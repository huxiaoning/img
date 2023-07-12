-- MySQL dump 10.13  Distrib 5.7.16, for linux-glibc2.5 (x86_64)
--
-- Host: 10.114.4.12    Database: card_game
-- ------------------------------------------------------
-- Server version	5.7.33-2-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `card_game`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `card_game` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `card_game`;

--
-- Table structure for table `card_game_activity_plan`
--

DROP TABLE IF EXISTS `card_game_activity_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_activity_plan` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '活动名称',
  `func_type` int(11) NOT NULL COMMENT '功能代码',
  `code` int(11) NOT NULL COMMENT '模版编号',
  `url` varchar(1000) NOT NULL COMMENT '配置文件下载路径',
  `version` varchar(255) NOT NULL COMMENT '配置文件版本号',
  `region_nos` varchar(2000) DEFAULT NULL COMMENT '大区编号，逗号分隔',
  `server_nos` varchar(2000) DEFAULT NULL COMMENT '服务器编号，逗号分隔',
  `server_open_days` int(11) DEFAULT NULL COMMENT '开服指定天数后，该活动可见',
  `level` int(11) DEFAULT NULL COMMENT '角色达到指定等级，该活动可见',
  `start_time` datetime NOT NULL COMMENT '开启时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `suspend` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否已中止该活动，1：是，0：否',
  `discard` tinyint(4) NOT NULL DEFAULT '0' COMMENT '活动尚未开启时，是否作废该条记录。1：是，0：否',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_version` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='活动计划';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_alliance_war_log`
--

DROP TABLE IF EXISTS `card_game_alliance_war_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_alliance_war_log` (
  `id` bigint(20) NOT NULL,
  `phase` int(11) DEFAULT NULL COMMENT '期次',
  `region_id` bigint(22) DEFAULT NULL COMMENT '大区id',
  `team_id` bigint(20) DEFAULT NULL COMMENT '队伍id',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `target_team_id` bigint(20) DEFAULT NULL,
  `target_server_no` int(11) DEFAULT NULL,
  `win_count` int(11) DEFAULT NULL COMMENT '挑战者战斗胜利场次数',
  `my_score_before` bigint(20) DEFAULT NULL,
  `my_score_after` bigint(20) DEFAULT NULL,
  `my_rank_before` int(11) DEFAULT NULL,
  `my_rank_after` int(11) DEFAULT NULL,
  `target_score` bigint(20) DEFAULT NULL,
  `target_rank` int(11) DEFAULT NULL,
  `video_ids` varchar(255) DEFAULT NULL,
  `order` varchar(255) DEFAULT NULL COMMENT '挑战者上阵顺序',
  `target_order` varchar(255) DEFAULT NULL COMMENT '被挑战者上阵顺序',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_phase_team_id` (`phase`,`team_id`) USING BTREE,
  KEY `idx_phase_target_team_id` (`phase`,`target_team_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='联盟割据战-战报';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_alliance_war_team`
--

DROP TABLE IF EXISTS `card_game_alliance_war_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_alliance_war_team` (
  `id` bigint(20) NOT NULL,
  `phase` int(11) DEFAULT NULL COMMENT '期次',
  `name` varchar(50) DEFAULT NULL COMMENT '  队伍名称',
  `leader` bigint(20) DEFAULT NULL COMMENT '队长',
  `members` varchar(200) DEFAULT NULL COMMENT '队员信息',
  `join_check` int(11) DEFAULT '0' COMMENT '入队是否需要审核，1-需要，0-不需要',
  `ce_condition` bigint(20) unsigned DEFAULT '0' COMMENT '入队战力要求',
  `lv_condition` int(11) unsigned DEFAULT '0' COMMENT '入队等级要求',
  `apply_list` varchar(5000) DEFAULT NULL COMMENT '申请列表',
  `entry_war` int(11) DEFAULT '0' COMMENT '是否已经报名参赛，1-已报名，0-未报名',
  `energy` int(11) DEFAULT NULL COMMENT '队伍当前能量值',
  `last_energy_recover_time` bigint(20) DEFAULT NULL COMMENT '上次能量恢复时间',
  `lineup_config` varchar(200) DEFAULT NULL COMMENT '布阵顺序，roleId:是否隐藏(1-隐藏，0-不隐藏) #分割',
  `challenge_permission` int(11) DEFAULT NULL COMMENT '队员是否可挑战，1-可以，0-不可以',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_phase_server_no` (`phase`,`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='联盟割据战-队伍信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_butler`
--

DROP TABLE IF EXISTS `card_game_butler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_butler` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色编号',
  `task_type` int(11) DEFAULT NULL COMMENT '任务类型',
  `task_id` int(6) DEFAULT NULL COMMENT '任务id',
  `finish_time` int(6) DEFAULT NULL COMMENT '完成次数',
  `hide` int(11) DEFAULT '0' COMMENT '是否隐藏',
  `reward` varchar(1000) DEFAULT NULL COMMENT '奖励内容',
  `param` varchar(200) DEFAULT NULL COMMENT '额外参数',
  `server_no` smallint(6) DEFAULT NULL,
  `delete_flag` tinyint(4) DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_roleId` (`role_id`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户管家表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_chat`
--

DROP TABLE IF EXISTS `card_game_chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_chat` (
  `id` bigint(20) NOT NULL,
  `chat_type` tinyint(4) DEFAULT NULL COMMENT '聊天频道类型',
  `role_id` bigint(20) DEFAULT NULL COMMENT '发送人ID',
  `content` varchar(500) DEFAULT NULL COMMENT '聊天内容',
  `template` int(11) DEFAULT NULL COMMENT '模板编号',
  `send_time` bigint(20) DEFAULT NULL COMMENT '发送时间戳',
  `chat_role_id` bigint(20) DEFAULT NULL COMMENT '私聊对象ID',
  `legion_id` bigint(20) DEFAULT NULL COMMENT '军团ID',
  `prop` varchar(10000) DEFAULT NULL,
  `server_no` smallint(6) DEFAULT NULL,
  `delete_flag` tinyint(4) DEFAULT NULL COMMENT '0',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx-roleId` (`role_id`) USING BTREE,
  KEY `idx-createTime` (`create_time`) USING BTREE,
  KEY `idx_serverNo` (`server_no`),
  KEY `idx_role_id_server_no` (`role_id`,`server_no`) USING BTREE,
  KEY `idx_chat_role_id_server_no` (`chat_role_id`,`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_city_battle_region_info`
--

DROP TABLE IF EXISTS `card_game_city_battle_region_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_city_battle_region_info` (
  `id` bigint(20) NOT NULL,
  `issue` int(11) DEFAULT NULL COMMENT '期次',
  `region_id` bigint(20) DEFAULT NULL COMMENT '大区ID',
  `descr` varchar(128) DEFAULT NULL COMMENT '描述',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_flag` int(1) DEFAULT '0' COMMENT '删除标志位',
  PRIMARY KEY (`id`),
  KEY `idx_issue_region_id` (`issue`,`region_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='国战战区';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_city_battle_region_server_info`
--

DROP TABLE IF EXISTS `card_game_city_battle_region_server_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_city_battle_region_server_info` (
  `id` bigint(20) NOT NULL,
  `battle_region_id` bigint(20) DEFAULT NULL COMMENT '国战战区id',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `issue` int(11) DEFAULT NULL COMMENT '期次',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_flag` int(1) DEFAULT '0' COMMENT '删除标志位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_issue_server` (`issue`,`server_no`) USING BTREE,
  KEY `idx_battle_region_id_issue` (`battle_region_id`,`issue`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='国战战区服务器';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_city_battle_region_server_info_backup`
--

DROP TABLE IF EXISTS `card_game_city_battle_region_server_info_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_city_battle_region_server_info_backup` (
  `id` bigint(20) NOT NULL,
  `battle_region_id` bigint(20) DEFAULT NULL COMMENT '国战战区id',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `issue` int(11) DEFAULT NULL COMMENT '期次',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_flag` int(1) DEFAULT '0' COMMENT '删除标志位',
  PRIMARY KEY (`id`),
  KEY `idx_battle_region_id_issue` (`battle_region_id`,`issue`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='国战战区服务器';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_city_info`
--

DROP TABLE IF EXISTS `card_game_city_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_city_info` (
  `id` bigint(20) NOT NULL,
  `issue` int(11) DEFAULT NULL COMMENT '期次',
  `city_no` int(11) DEFAULT NULL COMMENT '城池编号',
  `attack_time` timestamp NULL DEFAULT NULL COMMENT '攻打时间',
  `hold_time` timestamp NULL DEFAULT NULL COMMENT '占领时间',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `battle_region_id` bigint(20) DEFAULT NULL COMMENT '跨服区域',
  `defenders` varchar(256) DEFAULT NULL COMMENT '城池守军',
  `camp` int(1) DEFAULT '0' COMMENT '是否大本营',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_flag` int(1) DEFAULT '0' COMMENT '删除标志位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_issue_cityNo_region` (`issue`,`city_no`,`battle_region_id`) USING BTREE,
  KEY `idx_issue_region` (`issue`,`battle_region_id`) USING BTREE,
  KEY `idx_issue_server` (`issue`,`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='城池信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_city_info_backup`
--

DROP TABLE IF EXISTS `card_game_city_info_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_city_info_backup` (
  `id` bigint(20) NOT NULL,
  `issue` int(11) DEFAULT NULL COMMENT '期次',
  `city_no` int(11) DEFAULT NULL COMMENT '城池编号',
  `attack_time` timestamp NULL DEFAULT NULL COMMENT '攻打时间',
  `hold_time` timestamp NULL DEFAULT NULL COMMENT '占领时间',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `battle_region_id` bigint(20) DEFAULT NULL COMMENT '跨服区域',
  `defenders` varchar(256) DEFAULT NULL COMMENT '城池守军',
  `camp` int(1) DEFAULT '0' COMMENT '是否大本营',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_flag` int(1) DEFAULT '0' COMMENT '删除标志位',
  PRIMARY KEY (`id`),
  KEY `idx_issue_region` (`issue`,`battle_region_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='城池信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_city_role_info`
--

DROP TABLE IF EXISTS `card_game_city_role_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_city_role_info` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `issue` int(11) DEFAULT NULL COMMENT '期次',
  `defend` int(4) DEFAULT NULL COMMENT '破防值',
  `city_id` bigint(20) DEFAULT NULL COMMENT '城池id',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_flag` int(1) DEFAULT '0' COMMENT '删除标志位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_issue_roleId` (`issue`,`role_id`) USING BTREE,
  KEY `idx_cityId` (`city_id`) USING BTREE,
  KEY `idx_issue_severno` (`issue`,`server_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户城池信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_city_role_info_backup`
--

DROP TABLE IF EXISTS `card_game_city_role_info_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_city_role_info_backup` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `issue` int(11) DEFAULT NULL COMMENT '期次',
  `defend` int(4) DEFAULT NULL COMMENT '破防值',
  `city_id` bigint(20) DEFAULT NULL COMMENT '城池id',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_flag` int(1) DEFAULT '0' COMMENT '删除标志位',
  PRIMARY KEY (`id`),
  KEY `idx_cityId` (`city_id`) USING BTREE,
  KEY `idx_issue_roleId` (`issue`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户城池信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_cross_ladder_info`
--

DROP TABLE IF EXISTS `card_game_cross_ladder_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_cross_ladder_info` (
  `id` bigint(20) NOT NULL,
  `issue` varchar(32) DEFAULT NULL COMMENT '期次',
  `region` bigint(20) DEFAULT NULL COMMENT '战区',
  `role_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `legion_name` varchar(32) DEFAULT NULL COMMENT '军团名称',
  `rank` int(11) DEFAULT NULL COMMENT '排名',
  `award` varchar(32) DEFAULT NULL COMMENT '奖励',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_flag` int(1) DEFAULT '0' COMMENT '删除标志位',
  PRIMARY KEY (`id`),
  KEY `idx-roleId` (`role_id`) USING BTREE,
  KEY `idx-region-issue` (`region`,`issue`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='跨服天梯开奖信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_cross_rank_info`
--

DROP TABLE IF EXISTS `card_game_cross_rank_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_cross_rank_info` (
  `id` bigint(20) NOT NULL,
  `rank_type` int(4) DEFAULT NULL COMMENT '排行榜类型',
  `issue` varchar(32) DEFAULT NULL COMMENT '期次',
  `region` bigint(20) DEFAULT NULL COMMENT '战区',
  `role_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `legion_name` varchar(32) DEFAULT NULL COMMENT '军团名称',
  `rank` int(11) DEFAULT NULL COMMENT '排名',
  `score` bigint(20) DEFAULT '0' COMMENT '积分',
  `award` varchar(128) DEFAULT NULL COMMENT '奖励',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_flag` int(1) DEFAULT '0' COMMENT '删除标志位',
  PRIMARY KEY (`id`),
  KEY `idx_ranktype_region_issue` (`rank_type`,`region`,`issue`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='跨服排行开奖信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_cross_stage_match_info`
--

DROP TABLE IF EXISTS `card_game_cross_stage_match_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_cross_stage_match_info` (
  `id` bigint(20) NOT NULL,
  `issue` varchar(32) DEFAULT NULL COMMENT '期次',
  `region` bigint(20) DEFAULT NULL COMMENT '战区',
  `role_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `target_role_id` bigint(20) DEFAULT NULL COMMENT '对手ID',
  `target_server_no` int(11) DEFAULT NULL COMMENT '对手服务器编号',
  `target_ce` bigint(20) DEFAULT NULL COMMENT '对手战力',
  `flag` tinyint(4) DEFAULT NULL COMMENT '胜负关系',
  `mvp_hero_id` bigint(20) DEFAULT NULL COMMENT 'MVP英雄',
  `score` bigint(20) DEFAULT NULL COMMENT '积分',
  `damage` bigint(20) DEFAULT NULL COMMENT '伤害量',
  `game_type` tinyint(1) DEFAULT NULL COMMENT '比赛类型 1.常规赛 2.王者赛',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_flag` int(1) DEFAULT '0' COMMENT '删除标志位',
  PRIMARY KEY (`id`),
  KEY `idx_roleId` (`role_id`) USING BTREE,
  KEY `idx_region_issue` (`region`,`issue`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='跨服段位赛比赛信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_cross_stage_match_summary_info`
--

DROP TABLE IF EXISTS `card_game_cross_stage_match_summary_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_cross_stage_match_summary_info` (
  `id` bigint(20) NOT NULL,
  `issue` varchar(32) DEFAULT NULL COMMENT '期次',
  `region` bigint(20) DEFAULT NULL COMMENT '战区',
  `role_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `legion_name` varchar(32) DEFAULT NULL COMMENT '军团名称',
  `regular_win` int(11) DEFAULT NULL COMMENT '胜负',
  `regular_lose` int(11) DEFAULT NULL COMMENT '负场',
  `max_win` int(11) DEFAULT NULL COMMENT '最高连胜',
  `max_damage` bigint(20) DEFAULT NULL COMMENT '单场最高伤害',
  `king_win` int(11) DEFAULT NULL COMMENT '王者赛胜场',
  `king_lose` int(11) DEFAULT NULL COMMENT '王者赛负场',
  `max_score` bigint(20) DEFAULT NULL COMMENT '最高积分',
  `strongest_role_id` bigint(20) DEFAULT NULL COMMENT '最强对手',
  `strongest_serverNo` int(11) DEFAULT NULL COMMENT '最强对手战力服务器编号',
  `strongest_ce` bigint(20) DEFAULT NULL COMMENT '最强对手战力',
  `mvp_hero` int(11) DEFAULT NULL COMMENT 'MVP最多英雄',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_flag` int(1) DEFAULT '0' COMMENT '删除标志位',
  PRIMARY KEY (`id`),
  KEY `idx_roleId` (`role_id`) USING BTREE,
  KEY `idx_server_no` (`strongest_serverNo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_dread_lord`
--

DROP TABLE IF EXISTS `card_game_dread_lord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_dread_lord` (
  `id` bigint(20) NOT NULL,
  `no` int(11) DEFAULT NULL COMMENT '魔将讨伐编号',
  `first_unlock_role_id` bigint(20) DEFAULT NULL COMMENT '首次解锁玩家编号',
  `unlock_num` int(11) DEFAULT NULL COMMENT '本服解锁人数',
  `unlock_min_fc` bigint(20) DEFAULT NULL COMMENT '解锁最低战力',
  `unlock_min_fc_role_id` bigint(20) DEFAULT NULL COMMENT '解锁最低战力--玩家编号',
  `unlock_min_lineup` varchar(500) DEFAULT NULL COMMENT '最低战力解锁阵容',
  `unlock_min_first_report` blob COMMENT '最低战力解锁首战录像',
  `unlock_min_middle_report` blob COMMENT '最低战力解锁中战录像',
  `unlock_min_end_report` blob COMMENT '最低战力解锁末战录像',
  `first_pass_war_report` blob COMMENT '首通录像',
  `first_pass_role_id` bigint(20) DEFAULT NULL COMMENT '首通玩家编号',
  `first_pass_fc` bigint(11) DEFAULT NULL COMMENT '首通时的战力',
  `first_pass_time` bigint(20) DEFAULT NULL COMMENT '首通时间时间戳',
  `first_pass_lineup` varchar(500) DEFAULT NULL COMMENT '首通玩家阵容',
  `server_no` smallint(6) DEFAULT NULL,
  `delete_flag` tinyint(4) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_server_no` (`server_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_encounter_gift_bag`
--

DROP TABLE IF EXISTS `card_game_encounter_gift_bag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_encounter_gift_bag` (
  `id` bigint(20) NOT NULL,
  `server_no` int(11) NOT NULL COMMENT '服务器编号',
  `role_id` bigint(20) NOT NULL,
  `task_config_no` int(11) NOT NULL COMMENT '任务配置编号',
  `task_progress` bigint(20) NOT NULL COMMENT '任务进度',
  `initialize_timestamp` bigint(20) NOT NULL COMMENT '初始化时间戳',
  `activate_timestamp` bigint(20) NOT NULL COMMENT '激活时间戳',
  `purchase_deadline` bigint(20) NOT NULL COMMENT '购买截止时间戳',
  `goods_config_no` int(11) DEFAULT NULL,
  `remind` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否已在登录时对该礼包执行过期提醒：1：是，0:否',
  `purchased_timestamp` bigint(20) NOT NULL COMMENT '支付时间戳',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_role_id_gift_bag_no` (`role_id`,`task_config_no`) USING BTREE,
  KEY `idx_role_id` (`role_id`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='奇遇礼包活动状态';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_encounter_optional_activation`
--

DROP TABLE IF EXISTS `card_game_encounter_optional_activation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_encounter_optional_activation` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `task_config_no` int(11) NOT NULL COMMENT '任务配置编号',
  `gift_bag_config_no` int(11) DEFAULT NULL COMMENT '礼包配置编号',
  `rewards` varchar(2000) DEFAULT NULL COMMENT '该礼包发放的奖励',
  `prop_library_nos` varchar(100) DEFAULT NULL COMMENT '「自选礼包」三、四号位的道具库编号列表，逗号分隔。若为「指定礼包」，该字段为 null',
  `upgraded` tinyint(4) DEFAULT NULL COMMENT '该礼包是否已升级',
  `activation_time` datetime DEFAULT NULL COMMENT '激活该礼包的时间戳',
  `deadline` datetime DEFAULT NULL COMMENT '购买截止时间戳',
  `order_no` varchar(100) DEFAULT NULL COMMENT '订单编号',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_role_id_task_config_no` (`role_id`,`task_config_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='奇遇自选礼包激活记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_encounter_optional_order`
--

DROP TABLE IF EXISTS `card_game_encounter_optional_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_encounter_optional_order` (
  `id` bigint(20) NOT NULL,
  `activation_id` bigint(20) NOT NULL COMMENT '激活记录ID',
  `order_no` varchar(255) NOT NULL COMMENT '第三方订单号（SDK）',
  `rewards` varchar(2000) NOT NULL COMMENT '奖励',
  `prop_library_nos` varchar(100) DEFAULT NULL COMMENT '「自选礼包」三、四号位的道具库编号列表，逗号分隔。若为「指定礼包」，该字段为 null',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='私人订制礼包订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_excel_data`
--

DROP TABLE IF EXISTS `card_game_excel_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_excel_data` (
  `id` bigint(20) NOT NULL,
  `version` varchar(255) NOT NULL COMMENT '文件版本号，上传 excel 时，生成全局唯一的版本号',
  `sheet_no` int(11) NOT NULL COMMENT 'Excel 配置文件 sheet 编号，从 0 开始',
  `data` blob NOT NULL COMMENT '从该 sheet 解析出的数据，通常为 ArrayList',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_version_sheet_no` (`version`,`sheet_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='excel 解析后的数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_fight_spirit`
--

DROP TABLE IF EXISTS `card_game_fight_spirit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_fight_spirit` (
  `id` bigint(11) NOT NULL,
  `star` tinyint(4) DEFAULT NULL COMMENT '星级',
  `part` tinyint(4) DEFAULT NULL COMMENT '部位',
  `type` smallint(6) DEFAULT NULL COMMENT '战意类型',
  `no` int(10) NOT NULL COMMENT '战意编号',
  `level` smallint(6) DEFAULT '0' COMMENT '强化等级',
  `random_attr` varchar(255) DEFAULT NULL COMMENT '随机属性：强化次数#随机属性：强化次数',
  `clear_random_attr` varchar(255) DEFAULT NULL COMMENT '洗练的随机属性',
  `ws_attr` int(11) DEFAULT NULL COMMENT '无双属性编号',
  `clear_ws_attr` int(11) DEFAULT NULL COMMENT '洗练的无双属性',
  `locked` tinyint(4) DEFAULT '0' COMMENT '是否锁定 0：未锁定，1：锁定',
  `cur_exp` int(11) DEFAULT NULL COMMENT '强化未满级且超出当前等级的经验值',
  `role_id` bigint(10) NOT NULL COMMENT '角色ID',
  `server_no` smallint(6) DEFAULT NULL,
  `delete_flag` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx-roleId` (`role_id`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色战意表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_finals_supplement_config`
--

DROP TABLE IF EXISTS `card_game_finals_supplement_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_finals_supplement_config` (
  `id` bigint(20) NOT NULL,
  `server_region_no` bigint(20) DEFAULT NULL COMMENT '大区编号',
  `battle_regions` varchar(1024) DEFAULT NULL COMMENT '补赛战区',
  `issue` int(11) DEFAULT NULL COMMENT '补赛期次',
  `game_date` varchar(64) DEFAULT NULL COMMENT '补赛日期',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_flag` int(1) DEFAULT '0' COMMENT '删除标志位',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='巅峰赛补赛配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_friend_share`
--

DROP TABLE IF EXISTS `card_game_friend_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_friend_share` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL COMMENT '邀请人',
  `friend_user_id` bigint(20) DEFAULT '0' COMMENT '账号id',
  `friend_role_id` bigint(20) DEFAULT '0' COMMENT '被邀请人',
  `first_lv_time` bigint(20) DEFAULT '0' COMMENT '被邀请人的达到第一个等级时间',
  `second_lv_time` bigint(20) DEFAULT '0' COMMENT '达到第二个等级的时间',
  `first_register` tinyint(4) DEFAULT '0' COMMENT '是否首个邀请注册的玩家，0：否，1：是',
  `assist` tinyint(4) DEFAULT '0' COMMENT '好友助力是否完成 0 ：否，1：是',
  `server_no` smallint(6) DEFAULT NULL,
  `friend_server_no` smallint(6) DEFAULT NULL COMMENT '好友的服务器编号',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'CURRENT_TIMESTAMP',
  `delete_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_role_id` (`role_id`) USING BTREE,
  KEY `idx_friend_role_id` (`friend_role_id`) USING BTREE,
  KEY `idx_friend_user_id` (`friend_user_id`) USING BTREE,
  KEY `idx_first_time` (`first_lv_time`) USING BTREE,
  KEY `idx_second_time` (`second_lv_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='好友分享表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_friend_share_recharge`
--

DROP TABLE IF EXISTS `card_game_friend_share_recharge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_friend_share_recharge` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL COMMENT '邀请人',
  `friend_role_id` bigint(20) DEFAULT '0' COMMENT '被邀请人',
  `recharge` int(11) DEFAULT NULL COMMENT '充值金额',
  `rebate` int(11) DEFAULT NULL COMMENT '返利',
  `status` tinyint(4) DEFAULT '0' COMMENT '领取状态：0-未领取，1-已领取',
  `server_no` smallint(6) DEFAULT NULL COMMENT '被邀请人的服务器编号',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'CURRENT_TIMESTAMP',
  `delete_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_role_id` (`role_id`) USING BTREE,
  KEY `idx_friend_role_id` (`friend_role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='好友分享充值记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_god_weapon`
--

DROP TABLE IF EXISTS `card_game_god_weapon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_god_weapon` (
  `id` bigint(11) NOT NULL,
  `no` int(10) NOT NULL COMMENT '编号',
  `aggr_lv` smallint(6) DEFAULT '0' COMMENT '强化等级',
  `role_id` bigint(10) NOT NULL COMMENT '角色ID',
  `server_no` smallint(6) DEFAULT NULL,
  `delete_flag` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx-createTime` (`create_time`) USING BTREE,
  KEY `idx-roleId` (`role_id`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE,
  KEY `idx_role_id_server_no` (`role_id`,`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色神兵表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_hero_altar`
--

DROP TABLE IF EXISTS `card_game_hero_altar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_hero_altar` (
  `id` bigint(20) NOT NULL,
  `pos` int(11) DEFAULT NULL COMMENT 'boss位置1-6（从上到下，从左到右）',
  `role_id` bigint(20) DEFAULT NULL COMMENT '玩家编号',
  `num` int(11) DEFAULT NULL COMMENT '进阶次数',
  `fc` bigint(20) DEFAULT NULL COMMENT '进阶战力',
  `lv` int(11) DEFAULT NULL COMMENT '玩家等级',
  `lineup` varchar(500) DEFAULT NULL COMMENT '阵容',
  `report` blob COMMENT '录像',
  `server_no` smallint(6) DEFAULT NULL,
  `delete_flag` tinyint(4) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_server_no` (`server_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='武魂坛挑战记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_hero_comment`
--

DROP TABLE IF EXISTS `card_game_hero_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_hero_comment` (
  `id` bigint(20) NOT NULL,
  `hero_model_id` int(11) DEFAULT NULL COMMENT '武将模型编号',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色id',
  `comment` varchar(1000) DEFAULT NULL COMMENT '评论内容',
  `like_amount` int(11) DEFAULT NULL COMMENT '点赞数量',
  `hate_amount` int(11) DEFAULT NULL COMMENT '点踩数量',
  `region_no` bigint(20) DEFAULT NULL COMMENT '战区编号',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_role_id` (`role_id`) USING BTREE,
  KEY `idx_hero_model_id` (`hero_model_id`) USING BTREE,
  KEY `idx_region_no` (`region_no`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='武将评论';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_hero_comment_attitude_info`
--

DROP TABLE IF EXISTS `card_game_hero_comment_attitude_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_hero_comment_attitude_info` (
  `id` bigint(20) NOT NULL COMMENT ' ',
  `role_id` bigint(20) DEFAULT NULL COMMENT '玩家id',
  `hero_model_id` int(11) DEFAULT NULL COMMENT '英雄模型id（区分不同英雄，不区分星级）',
  `comment_id` bigint(20) DEFAULT NULL COMMENT '评论id',
  `attitude` tinyint(4) DEFAULT NULL COMMENT '用户对评论的态度，1-赞，2-踩',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_role_id` (`role_id`) USING BTREE,
  KEY `idx_hero_model_id` (`hero_model_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='武将评论-点赞点踩';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_hero_comment_like`
--

DROP TABLE IF EXISTS `card_game_hero_comment_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_hero_comment_like` (
  `id` bigint(20) NOT NULL,
  `hero_model_no` int(11) DEFAULT NULL COMMENT '武将模型编号',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `like_amount` int(11) DEFAULT NULL COMMENT '喜爱数',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_hero_no` (`hero_model_no`) USING BTREE,
  KEY `idx_region_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='武将评论-武将喜爱信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_heroes_contest_battle`
--

DROP TABLE IF EXISTS `card_game_heroes_contest_battle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_heroes_contest_battle` (
  `id` bigint(20) NOT NULL,
  `batch` varchar(20) DEFAULT NULL COMMENT '批次20210303',
  `type` tinyint(4) DEFAULT '1' COMMENT '录像类型 1:群雄逐鹿',
  `team` tinyint(4) DEFAULT NULL COMMENT '组别',
  `side` tinyint(4) DEFAULT NULL COMMENT '上下半区 0：上半区，1：下半区',
  `stage` smallint(6) DEFAULT NULL COMMENT '几强，阶段（128，64，32，16，8，4，2）',
  `round` smallint(6) DEFAULT NULL COMMENT '轮次',
  `win_role_id` bigint(20) DEFAULT NULL COMMENT '获胜者',
  `challenge_role_id` bigint(20) DEFAULT NULL COMMENT '挑战者',
  `be_challenge_role_id` bigint(20) DEFAULT NULL COMMENT '被挑战者 ',
  `video_id` bigint(20) DEFAULT NULL COMMENT '录像ID',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx-serverNo` (`server_no`) USING BTREE,
  KEY `idx-batch` (`batch`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='群雄逐鹿分组战斗信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_heroes_contest_quiz`
--

DROP TABLE IF EXISTS `card_game_heroes_contest_quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_heroes_contest_quiz` (
  `id` bigint(20) NOT NULL,
  `batch` varchar(20) DEFAULT NULL COMMENT '批次20210303',
  `type` tinyint(4) DEFAULT '1' COMMENT '录像类型 1:群雄逐鹿',
  `betting` int(11) DEFAULT NULL COMMENT '投注数',
  `rebate` int(11) DEFAULT NULL COMMENT '返奖',
  `bet_role_id` bigint(20) DEFAULT NULL COMMENT '压胜利的角色ID',
  `win_role_id` bigint(20) DEFAULT NULL COMMENT '胜利方角色ID',
  `challenge_role_id` bigint(20) DEFAULT NULL COMMENT '挑战者id',
  `be_challenge_role_id` bigint(20) DEFAULT NULL COMMENT '被挑战者',
  `role_id` bigint(20) DEFAULT NULL,
  `video_id` bigint(20) DEFAULT NULL COMMENT '录像ID',
  `round` int(11) DEFAULT NULL COMMENT '比赛阶段轮次',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx-serverNo` (`server_no`) USING BTREE,
  KEY `idx-batch` (`batch`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='群雄逐鹿竞猜';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_inn`
--

DROP TABLE IF EXISTS `card_game_inn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_inn` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  `integral` int(11) DEFAULT NULL COMMENT '客栈系统招募积分',
  `warrior_num` smallint(6) DEFAULT NULL COMMENT '战将每日招募次数',
  `fg_num` smallint(6) DEFAULT NULL COMMENT '名将每日招募次数',
  `friendship_num` smallint(6) DEFAULT NULL COMMENT '友情招募每日次数',
  `fg_all_num` int(11) DEFAULT NULL COMMENT '名将总招募次数',
  `warrior_all_num` int(11) DEFAULT NULL COMMENT '战将总招募次数',
  `integral_all_num` int(11) DEFAULT NULL COMMENT '积分总招募次数',
  `friendship_all_num` int(11) DEFAULT NULL COMMENT '友情总招募次数',
  `fg_bad_times` int(11) DEFAULT NULL COMMENT '名将不幸召唤次数',
  `warrior_bad_times` int(11) DEFAULT NULL COMMENT '战将不幸召唤次数',
  `integral_bad_times` int(11) DEFAULT NULL COMMENT '积分不幸召唤次数',
  `friendship_bad_times` int(11) DEFAULT NULL COMMENT '友情不幸召唤次数',
  `free_warrior` tinyint(4) DEFAULT NULL COMMENT '剩余免费战将招募次数',
  `free_fg` tinyint(4) DEFAULT NULL COMMENT '剩余免费战将招募次数',
  `set_free_time` datetime DEFAULT NULL COMMENT '最近一次设置免费时间',
  `period_core_num` int(11) DEFAULT NULL COMMENT '周期内获得核心卡的数量',
  `last_core_reset_time` bigint(20) DEFAULT NULL COMMENT '上一次核心卡周期重置时间',
  `server_no` smallint(6) DEFAULT NULL,
  `delete_flag` tinyint(4) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx-createTime` (`create_time`) USING BTREE,
  KEY `idx-roleId` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_jz_competition_log`
--

DROP TABLE IF EXISTS `card_game_jz_competition_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_jz_competition_log` (
  `id` bigint(20) NOT NULL,
  `phase` int(11) DEFAULT NULL COMMENT '期次',
  `region_no` bigint(20) DEFAULT NULL COMMENT '大区id',
  `type` int(11) DEFAULT NULL COMMENT '日志类型，1-段位赛，2-天梯赛',
  `battle_result` int(11) DEFAULT NULL COMMENT '战斗结果，1-胜利，0-失败',
  `role_id` bigint(20) DEFAULT NULL COMMENT '挑战者id',
  `server_no` int(11) DEFAULT NULL COMMENT '挑战者服务器编号',
  `target_role_id` bigint(20) DEFAULT NULL COMMENT '被挑战者id',
  `target_server_no` int(11) DEFAULT NULL COMMENT '被挑战者服务器编号',
  `score_before` bigint(22) DEFAULT NULL COMMENT '积分变更前',
  `score_change` bigint(22) DEFAULT NULL COMMENT '积分变更值',
  `target_score` bigint(22) DEFAULT NULL,
  `rank_before` int(11) DEFAULT NULL COMMENT '之前排名',
  `rank_after` int(11) DEFAULT NULL COMMENT '之后排名',
  `target_rank` int(11) DEFAULT NULL,
  `videos` varchar(255) DEFAULT NULL COMMENT '录像id，逗号分隔',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_phase_challenger` (`phase`,`role_id`) USING BTREE,
  KEY `idx_phase_challenged` (`phase`,`target_role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='九州争霸赛-战斗日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_leaderboard_settlement_log`
--

DROP TABLE IF EXISTS `card_game_leaderboard_settlement_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_leaderboard_settlement_log` (
  `id` bigint(20) NOT NULL,
  `type` int(4) NOT NULL COMMENT '排行榜类型',
  `issue` varchar(255) NOT NULL COMMENT '期次',
  `role_id` bigint(20) NOT NULL COMMENT '用户ID',
  `ranking` int(11) NOT NULL COMMENT '排名',
  `score` bigint(20) NOT NULL COMMENT '积分',
  `prize` varchar(1000) NOT NULL COMMENT '奖励',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_type_issue_role_id` (`type`,`issue`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='排行榜结算信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_legion`
--

DROP TABLE IF EXISTS `card_game_legion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_legion` (
  `id` bigint(20) NOT NULL COMMENT '军团唯一ID',
  `legion_name` varchar(50) DEFAULT NULL COMMENT '军团名',
  `change_name_num` int(11) DEFAULT NULL COMMENT '军团名称修改次数',
  `head_image` int(11) DEFAULT NULL COMMENT '军团图像',
  `notice` varchar(255) DEFAULT NULL COMMENT '公告',
  `join_lv` int(11) DEFAULT NULL COMMENT '入团等级',
  `join_check` tinyint(4) DEFAULT NULL COMMENT '入团验证',
  `lv` smallint(6) DEFAULT NULL COMMENT '军团等级',
  `exp` bigint(20) DEFAULT NULL COMMENT '经验',
  `leader` bigint(20) DEFAULT NULL COMMENT '团长角色id',
  `deputy` varchar(50) DEFAULT NULL COMMENT '副团长角色id--玩家ID:玩家ID:玩家ID',
  `elite` varchar(255) DEFAULT NULL COMMENT '精英--玩家ID:玩家ID:玩家ID',
  `members` varchar(5000) DEFAULT NULL COMMENT '组员信息',
  `apply_list` varchar(5000) DEFAULT NULL COMMENT '申请列表',
  `day_sacrifice` int(11) DEFAULT NULL COMMENT '日祭祀值',
  `sacrifice_log` varchar(3000) DEFAULT NULL COMMENT '日祭祀记录',
  `add_atk_num` int(11) DEFAULT NULL COMMENT '激活全员战力次数',
  `add_atk_time` bigint(20) DEFAULT NULL COMMENT '全员战力作用结束时间戳',
  `dungeon_no` int(11) DEFAULT NULL COMMENT '当前挑战中的副本编号',
  `boss_hp` bigint(20) DEFAULT NULL COMMENT '当天挑战副本BOSS剩余血量',
  `horn_time` bigint(20) DEFAULT NULL COMMENT '最近一次发起集结时间戳',
  `server_no` smallint(6) DEFAULT NULL,
  `supremacy_exp` int(11) NOT NULL DEFAULT '0' COMMENT '军团争霸经验值',
  `supremacy_win_times` int(11) NOT NULL DEFAULT '0' COMMENT '军团争霸胜利次数',
  `notice_status` tinyint(4) DEFAULT '0' COMMENT '公告的编辑状态 0：可编辑，1：不可编辑',
  `delete_flag` tinyint(4) DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx-createTime` (`create_time`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_legion_assistance`
--

DROP TABLE IF EXISTS `card_game_legion_assistance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_legion_assistance` (
  `id` bigint(20) NOT NULL,
  `legion_id` bigint(20) DEFAULT NULL COMMENT '军团编号',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色编号',
  `ask_help_no` tinyint(4) DEFAULT NULL COMMENT '// 求援编号--武将国家编号',
  `assistance_num` smallint(6) DEFAULT '0' COMMENT '当前被援助次数',
  `receive` tinyint(4) DEFAULT '0' COMMENT '已经领取的碎片数量',
  `send_time` bigint(20) DEFAULT NULL COMMENT '发送求援时间戳',
  `server_no` smallint(6) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_legion_id_server_no` (`legion_id`,`server_no`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE,
  KEY `idx_role_id_server_no` (`role_id`,`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_legion_dungeon`
--

DROP TABLE IF EXISTS `card_game_legion_dungeon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_legion_dungeon` (
  `id` bigint(20) NOT NULL,
  `legion_id` bigint(20) DEFAULT NULL COMMENT '军团编号',
  `dungeon_no` smallint(6) DEFAULT NULL COMMENT '军团试炼副本编号',
  `hart_rank` varchar(3000) DEFAULT NULL COMMENT '伤害排行信息',
  `kill_role_id` bigint(20) DEFAULT NULL COMMENT '击杀者编号',
  `server_no` smallint(6) DEFAULT NULL,
  `delete_flag` int(11) DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx-createTime` (`create_time`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_legion_red_envelope`
--

DROP TABLE IF EXISTS `card_game_legion_red_envelope`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_legion_red_envelope` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `config_no` int(11) NOT NULL COMMENT '红包任务配置编号',
  `amount` int(11) NOT NULL COMMENT '红包总金额',
  `quantity` int(11) NOT NULL COMMENT '红包总数量',
  `allocation` varchar(1000) NOT NULL COMMENT '红包金额分配方案',
  `initialize_timestamp` bigint(20) NOT NULL COMMENT '初始化时间戳',
  `hand_out_timestamp` bigint(20) NOT NULL COMMENT '红包发放时间戳',
  `legion_id` bigint(20) NOT NULL COMMENT '军团ID',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_role_id_create_time` (`role_id`,`create_time`) USING BTREE,
  KEY `idx_legion_id_create_time` (`legion_id`,`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='军团任务红包领取记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_legion_red_envelope_snatch_detail`
--

DROP TABLE IF EXISTS `card_game_legion_red_envelope_snatch_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_legion_red_envelope_snatch_detail` (
  `id` bigint(20) NOT NULL,
  `red_envelope_id` bigint(20) NOT NULL COMMENT '红包ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `amount` int(11) NOT NULL COMMENT '所获元宝金额',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_red_envelope_id_role_id` (`red_envelope_id`,`role_id`) USING BTREE,
  KEY `idx_role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='军团抢红包记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_legion_supremacy_attack`
--

DROP TABLE IF EXISTS `card_game_legion_supremacy_attack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_legion_supremacy_attack` (
  `id` bigint(20) NOT NULL,
  `issue` int(11) NOT NULL COMMENT '期次号',
  `schedule_id` bigint(20) NOT NULL COMMENT '比赛场次ID',
  `stronghold_id` bigint(20) NOT NULL COMMENT '据点ID',
  `stronghold_nickname` varchar(255) NOT NULL COMMENT '据点昵称',
  `legion_id` bigint(20) NOT NULL COMMENT '进攻方军团ID',
  `role_id` bigint(20) NOT NULL COMMENT '进攻方角色ID',
  `nickname` varchar(255) DEFAULT NULL COMMENT '进攻方昵称',
  `fc` bigint(20) DEFAULT NULL COMMENT '进攻方战力',
  `heros` varchar(500) CHARACTER SET utf8 DEFAULT NULL COMMENT '出场英雄信息，json字符串',
  `stars` int(11) NOT NULL COMMENT '难度星级。扫荡时为 0',
  `video_id` bigint(20) NOT NULL COMMENT '挑战录像ID。扫荡时为0',
  `success` tinyint(4) NOT NULL COMMENT '挑战结果。0:失败，1:胜利。扫荡必胜',
  `credits` int(11) NOT NULL COMMENT '本次所获积分（战绩）',
  `legion_stars_then` int(11) NOT NULL COMMENT '本次进攻后，进攻方军团当时的星星数',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_stronghold_id` (`stronghold_id`) USING BTREE,
  KEY `idx_schedule_id` (`schedule_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='军团争霸赛据点进攻记录（挑战/扫荡）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_legion_supremacy_schedule`
--

DROP TABLE IF EXISTS `card_game_legion_supremacy_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_legion_supremacy_schedule` (
  `id` bigint(20) NOT NULL,
  `issue` int(10) NOT NULL COMMENT '期次号',
  `battle_region_id` bigint(20) NOT NULL COMMENT '战区ID',
  `left_server_no` int(11) NOT NULL COMMENT '左侧军团服务器编号',
  `left_legion_id` bigint(20) NOT NULL COMMENT '左侧军团ID',
  `left_legion_name` varchar(255) NOT NULL COMMENT '左侧军团名称',
  `left_legion_head_image` int(11) NOT NULL COMMENT '左侧军团头像',
  `left_legion_size` int(11) NOT NULL COMMENT '左侧军团人数',
  `left_ranking` int(11) NOT NULL COMMENT '左侧服务器排名',
  `left_stars` int(11) NOT NULL COMMENT '左侧军团获得星星数',
  `left_last_add_stars` datetime DEFAULT NULL COMMENT '左侧最近一次获得星星',
  `left_settled` tinyint(4) NOT NULL COMMENT '1:已结算；0:未结算',
  `right_server_no` int(11) NOT NULL COMMENT '右侧军团服务器编号',
  `right_legion_id` bigint(20) NOT NULL COMMENT '右侧军团军团ID',
  `right_legion_name` varchar(255) NOT NULL COMMENT '右侧军团名称',
  `right_legion_head_image` int(11) NOT NULL COMMENT '右侧军团头像',
  `right_legion_size` int(11) NOT NULL COMMENT '右侧军团人数',
  `right_ranking` int(11) NOT NULL COMMENT '右侧服务器排名',
  `right_stars` int(11) NOT NULL COMMENT '右侧军团获得星星数',
  `right_last_add_stars` datetime DEFAULT NULL COMMENT '右侧最近一次获得星星',
  `right_settled` tinyint(4) NOT NULL COMMENT '1:已结算；0:未结算',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_issue` (`issue`) USING BTREE,
  KEY `idx_left_server_no` (`left_server_no`) USING BTREE,
  KEY `idx_right_server_no` (`right_server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='军团争霸赛程';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_legion_supremacy_stronghold`
--

DROP TABLE IF EXISTS `card_game_legion_supremacy_stronghold`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_legion_supremacy_stronghold` (
  `id` bigint(20) NOT NULL,
  `schedule_id` bigint(20) NOT NULL COMMENT '赛程ID',
  `legion_id` bigint(20) NOT NULL COMMENT '军团ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `nickname` varchar(255) NOT NULL COMMENT '角色昵称',
  `fc` bigint(20) NOT NULL COMMENT '战力',
  `position` tinyint(4) NOT NULL COMMENT '位置编号，从1开始，连续递增',
  `stars` int(11) NOT NULL COMMENT '该据点已解锁的星星数',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_schedule_id_role_id` (`schedule_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='军团争霸赛军团据点信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_legion_supremacy_treasure_chest`
--

DROP TABLE IF EXISTS `card_game_legion_supremacy_treasure_chest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_legion_supremacy_treasure_chest` (
  `id` bigint(20) NOT NULL,
  `schedule_id` bigint(20) NOT NULL COMMENT '场次ID',
  `legion_id` bigint(20) NOT NULL COMMENT '军团ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `nickname` varchar(255) NOT NULL COMMENT '昵称',
  `position` int(11) NOT NULL COMMENT '位置',
  `reward_no` int(11) NOT NULL COMMENT '奖励编号',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_schedule_id_role_id` (`schedule_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='军团争霸赛宝箱开启记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_lineup`
--

DROP TABLE IF EXISTS `card_game_lineup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_lineup` (
  `id` bigint(20) NOT NULL,
  `lineup_type` tinyint(4) DEFAULT NULL COMMENT '阵容类型',
  `lineup_1` bigint(20) DEFAULT NULL COMMENT '1号位武将编号(0为该站位无武将)',
  `lineup_2` bigint(20) DEFAULT NULL COMMENT '2号位武将编号(0为该站位无武将)',
  `lineup_3` bigint(20) DEFAULT NULL COMMENT '3号位武将编号(0为该站位无武将)',
  `lineup_4` bigint(20) DEFAULT NULL COMMENT '4号位武将编号(0为该站位无武将)',
  `lineup_5` bigint(20) DEFAULT NULL COMMENT '5号位武将编号(0为该站位无武将)',
  `lineup_6` bigint(20) DEFAULT NULL COMMENT '6号位武将编号(0为该站位无武将)',
  `line_effect` bigint(20) DEFAULT '0' COMMENT '阵容产生的加成效果编号(0表示无加成)',
  `lineup_effects` varchar(50) DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL COMMENT '玩家编号',
  `stratagems` varchar(255) DEFAULT NULL COMMENT '上阵的计谋',
  `beauty_no` int(11) DEFAULT NULL COMMENT '美人编号',
  `server_no` smallint(6) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx-createTime` (`create_time`) USING BTREE,
  KEY `idx-roleId` (`role_id`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_lottery_draw_log`
--

DROP TABLE IF EXISTS `card_game_lottery_draw_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_lottery_draw_log` (
  `id` bigint(20) NOT NULL,
  `func_type` int(11) NOT NULL COMMENT '功能代码',
  `issue` varchar(255) NOT NULL COMMENT '期次号',
  `role_id` bigint(11) NOT NULL COMMENT '角色ID',
  `draw_times` int(11) NOT NULL COMMENT '抽奖次数',
  `prizes` varchar(1000) NOT NULL COMMENT '所中奖励编号列表，逗号分隔',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_func_type_issue_role_id` (`func_type`,`issue`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_mail`
--

DROP TABLE IF EXISTS `card_game_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_mail` (
  `id` bigint(20) NOT NULL COMMENT '编号',
  `mail_type` tinyint(4) DEFAULT NULL COMMENT '邮件类型，1-系统邮件，2-公告，3-来信，4-时效性GM邮件',
  `template_id` int(11) DEFAULT NULL COMMENT '标题模板编号',
  `send_role_id` bigint(20) DEFAULT NULL COMMENT '发件人角色编号(0表示系统发送)',
  `content_params` varchar(255) DEFAULT NULL COMMENT '内容动态参数',
  `enclosure` varchar(255) DEFAULT NULL COMMENT '附件',
  `expire_time` bigint(20) DEFAULT NULL COMMENT '过期时间',
  `receive` tinyint(4) DEFAULT NULL COMMENT '0-未领取 1-已领取',
  `read_mail` tinyint(4) DEFAULT NULL COMMENT '0-未读 1-已读',
  `role_id` bigint(20) DEFAULT NULL COMMENT '收件人角色ID',
  `gm_mail` bigint(4) DEFAULT NULL COMMENT '是否是GM邮件1是0是游戏系统邮件，其他是系统分发给玩家的GM邮件编号',
  `title` varchar(255) DEFAULT NULL COMMENT 'GM邮件标题',
  `content` varchar(500) DEFAULT NULL COMMENT 'GM邮件内容',
  `timeliness_expire_time` bigint(20) DEFAULT NULL COMMENT '时效性GM邮件过期时间',
  `picture_url` varchar(500) DEFAULT NULL COMMENT '邮件中图片地址',
  `server_no` smallint(6) DEFAULT NULL COMMENT '服编号',
  `delete_flag` tinyint(4) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`create_time`),
  KEY `idx-createTime` (`create_time`) USING BTREE,
  KEY `idx-roleId` (`role_id`) USING BTREE,
  KEY `idx_gm_mail` (`gm_mail`) USING BTREE,
  KEY `idx_expire_time` (`expire_time`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE,
  KEY `idx_role_id_server_no` (`role_id`,`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
/*!50100 PARTITION BY LIST (MONTH(create_time))
(PARTITION p1 VALUES IN (1) ENGINE = InnoDB,
 PARTITION p2 VALUES IN (2) ENGINE = InnoDB,
 PARTITION p3 VALUES IN (3) ENGINE = InnoDB,
 PARTITION p4 VALUES IN (4) ENGINE = InnoDB,
 PARTITION p5 VALUES IN (5) ENGINE = InnoDB,
 PARTITION p6 VALUES IN (6) ENGINE = InnoDB,
 PARTITION p7 VALUES IN (7) ENGINE = InnoDB,
 PARTITION p8 VALUES IN (8) ENGINE = InnoDB,
 PARTITION p9 VALUES IN (9) ENGINE = InnoDB,
 PARTITION p10 VALUES IN (10) ENGINE = InnoDB,
 PARTITION p11 VALUES IN (11) ENGINE = InnoDB,
 PARTITION p12 VALUES IN (12) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_mansion`
--

DROP TABLE IF EXISTS `card_game_mansion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_mansion` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `profession` tinyint(4) NOT NULL COMMENT '府邸类型，即英雄职业',
  `hero_id` bigint(20) NOT NULL COMMENT '英雄ID',
  `completion_time` datetime NOT NULL COMMENT '完工时间',
  `racks` varchar(1000) NOT NULL COMMENT '藏兵格位信息。格式：位置编号:锁定截止时间戳:藏兵编号。示例：1:1649925703864:380024,2:1649925703864:0',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_role_id` (`role_id`) USING BTREE,
  KEY `idx_hero_id` (`hero_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='封地-府邸';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_mineral_info`
--

DROP TABLE IF EXISTS `card_game_mineral_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_mineral_info` (
  `id` bigint(22) NOT NULL,
  `phase` int(11) DEFAULT NULL COMMENT '期次',
  `region_id` bigint(22) DEFAULT NULL COMMENT '战区id',
  `area` int(11) DEFAULT NULL COMMENT '矿区编号',
  `level` int(11) DEFAULT NULL COMMENT '矿山等级',
  `position` int(11) DEFAULT NULL COMMENT '矿场位置',
  `defender` bigint(20) DEFAULT NULL COMMENT '守军信息（守军为玩家时存roleId，无守军存-1，守军为怪物存0）',
  `break_point` int(11) DEFAULT NULL COMMENT '剩余破防值',
  `field_type` int(11) DEFAULT NULL COMMENT '矿场类型，1-普通矿场，2-巨型矿场',
  `occupy_time` datetime DEFAULT NULL COMMENT '占领时间',
  `profit` varchar(1000) DEFAULT NULL COMMENT '收益的奖励',
  `last_profit_time` bigint(20) DEFAULT NULL COMMENT '上一次收益的计算时间（初始化时候和攻占时间相同）',
  `last_receive_time` bigint(20) DEFAULT NULL COMMENT '上一次手动领取挂机奖励时间',
  `server_no` int(11) DEFAULT NULL COMMENT '守军玩家服务器编号',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_defender` (`defender`) USING BTREE,
  KEY `idx_phase_region` (`phase`,`region_id`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='矿山争霸-矿区信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_mineral_log`
--

DROP TABLE IF EXISTS `card_game_mineral_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_mineral_log` (
  `id` bigint(22) NOT NULL,
  `phase` int(11) DEFAULT NULL COMMENT '期次',
  `region_id` bigint(22) DEFAULT NULL COMMENT '战区id',
  `type` int(11) DEFAULT NULL COMMENT '日志类型，1-开采日志，2-战斗日志',
  `attacker` bigint(22) DEFAULT NULL COMMENT '攻击者',
  `attacker_server_no` int(11) DEFAULT NULL COMMENT '攻击者服务器编号',
  `defender` bigint(22) DEFAULT NULL COMMENT '防守者',
  `defender_server_no` int(11) DEFAULT NULL COMMENT '防守者服务器编号',
  `area` int(11) DEFAULT NULL COMMENT '矿区编号',
  `level` int(11) DEFAULT NULL COMMENT '矿山等级',
  `position` int(11) DEFAULT NULL COMMENT '矿场位置',
  `profit` varchar(255) DEFAULT NULL COMMENT '开采收益（三段式）',
  `battle_result` int(4) DEFAULT NULL COMMENT '战斗结果。1胜利，2失败，3破防',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_attacker` (`attacker`) USING BTREE,
  KEY `idx_defender` (`defender`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE,
  KEY `idx_region_id` (`region_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='矿山争霸-矿山日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_mineral_log_old`
--

DROP TABLE IF EXISTS `card_game_mineral_log_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_mineral_log_old` (
  `id` bigint(22) NOT NULL,
  `phase` int(11) DEFAULT NULL COMMENT '期次',
  `region_id` bigint(22) DEFAULT NULL COMMENT '战区id',
  `type` int(11) DEFAULT NULL COMMENT '日志类型，1-开采日志，2-战斗日志',
  `attacker` bigint(22) DEFAULT NULL COMMENT '攻击者',
  `attacker_server_no` int(11) DEFAULT NULL COMMENT '攻击者服务器编号',
  `defender` bigint(22) DEFAULT NULL COMMENT '防守者',
  `defender_server_no` int(11) DEFAULT NULL COMMENT '防守者服务器编号',
  `area` int(11) DEFAULT NULL COMMENT '矿区编号',
  `level` int(11) DEFAULT NULL COMMENT '矿山等级',
  `position` int(11) DEFAULT NULL COMMENT '矿场位置',
  `profit` varchar(255) DEFAULT NULL COMMENT '开采收益（三段式）',
  `battle_result` int(4) DEFAULT NULL COMMENT '战斗结果。1胜利，2失败，3破防',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_attacker` (`attacker`) USING BTREE,
  KEY `idx_defender` (`defender`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE,
  KEY `idx_region_id` (`region_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='矿山争霸-矿山日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_optional_gift_bag`
--

DROP TABLE IF EXISTS `card_game_optional_gift_bag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_optional_gift_bag` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `goods_no` int(11) NOT NULL COMMENT '充值项编号',
  `config_no` int(11) NOT NULL COMMENT '礼包配置编号',
  `rewards` varchar(2000) NOT NULL COMMENT '奖励三段式',
  `reward_nos` varchar(255) DEFAULT NULL COMMENT '奖励编号，逗号分割',
  `order_no` varchar(255) DEFAULT NULL COMMENT '订单号（SDK）',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户设置的自选礼包';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_pet`
--

DROP TABLE IF EXISTS `card_game_pet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_pet` (
  `id` bigint(20) NOT NULL,
  `pet_no` int(11) DEFAULT NULL COMMENT '战宠id',
  `level` int(11) DEFAULT NULL COMMENT '等级',
  `exp` bigint(20) DEFAULT NULL COMMENT '当前经验',
  `stage` int(11) DEFAULT NULL COMMENT '进阶次数',
  `skills` varchar(255) DEFAULT NULL COMMENT '技能（非专属技能）',
  `awaking_lv` int(11) DEFAULT '0' COMMENT '觉醒等级',
  `awaking_skills` varchar(255) DEFAULT NULL COMMENT '觉醒解锁的技能',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色id',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='战宠';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_privilege_pack_log`
--

DROP TABLE IF EXISTS `card_game_privilege_pack_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_privilege_pack_log` (
  `id` bigint(11) NOT NULL,
  `drop_no` bigint(20) DEFAULT NULL COMMENT ' 掉落编号（特权奖励id）',
  `expiration` datetime DEFAULT NULL COMMENT '礼包有效期',
  `type` tinyint(4) DEFAULT NULL COMMENT '类型 1：永久购买1次，2：周期性可以购买',
  `role_id` bigint(10) NOT NULL COMMENT '角色ID',
  `delete_flag` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx-roleId` (`role_id`) USING BTREE,
  KEY `idx-createTime` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色购买特权礼包记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_purgatory_tower`
--

DROP TABLE IF EXISTS `card_game_purgatory_tower`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_purgatory_tower` (
  `id` bigint(20) NOT NULL,
  `no` int(11) NOT NULL COMMENT '关卡',
  `star` smallint(4) DEFAULT NULL COMMENT '当前通关星级',
  `fight_cond` tinyint(4) DEFAULT NULL COMMENT '战斗条件  0：失败，1：成功',
  `hero_cond` tinyint(4) DEFAULT NULL COMMENT '上阵武将国家、职业条件 0：失败，1：成功',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `server_no` smallint(6) DEFAULT NULL COMMENT '游戏服ID',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_roleId` (`role_id`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='炼狱塔信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_purge_file_compensation`
--

DROP TABLE IF EXISTS `card_game_purge_file_compensation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_purge_file_compensation` (
  `id` bigint(20) NOT NULL,
  `region_no` bigint(20) NOT NULL COMMENT '大区编号',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `recharge_amount` int(11) NOT NULL COMMENT '充值总金额',
  `role_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '首次发放补偿的角色',
  `delivered_dates` varchar(255) DEFAULT NULL COMMENT '已发放补偿的日期列表，逗号分隔',
  `finished` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否已发放全部补偿，0：否，1：谁',
  `delivered` tinyint(3) DEFAULT NULL COMMENT '是否已发放补偿。0：否，1:是。该字段已废弃，上包后可删除',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='删档补偿累充及领取状态';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_rank_reward`
--

DROP TABLE IF EXISTS `card_game_rank_reward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_rank_reward` (
  `id` bigint(20) NOT NULL,
  `rank_reward_no` int(11) DEFAULT NULL COMMENT '排行榜目标奖励编号',
  `role_id` bigint(20) DEFAULT NULL COMMENT '全服首次达成目标条件的玩家编号',
  `role_lv` smallint(6) DEFAULT NULL COMMENT '玩家达成目标时的等级',
  `server_no` smallint(6) DEFAULT NULL,
  `delete_flag` tinyint(4) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_recharge_order`
--

DROP TABLE IF EXISTS `card_game_recharge_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_recharge_order` (
  `id` bigint(11) NOT NULL,
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `order_id` varchar(50) NOT NULL COMMENT '平台订单id',
  `sdk_order_id` varchar(50) DEFAULT NULL COMMENT '第三方订单id',
  `goods_no` int(10) NOT NULL COMMENT '商品编号(对应充值项ID)',
  `status` tinyint(1) DEFAULT NULL COMMENT '订单状态',
  `server_no` smallint(6) NOT NULL COMMENT '游戏服ID',
  `delete_flag` int(11) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique-name-roleId` (`order_id`,`role_id`) USING BTREE,
  KEY `idx-createTime` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_role_dungeon_info`
--

DROP TABLE IF EXISTS `card_game_role_dungeon_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_role_dungeon_info` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `dungeon_nos` varchar(256) DEFAULT NULL COMMENT '已领取试炼奖励',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_flag` int(1) DEFAULT '0' COMMENT '删除标志位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_roleId` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='军团试炼领奖信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_role_info`
--

DROP TABLE IF EXISTS `card_game_role_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_role_info` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(10) DEFAULT NULL COMMENT '平台玩家ID',
  `nick_name` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `sex` tinyint(1) DEFAULT NULL COMMENT '0:男 1:女',
  `lv` int(10) DEFAULT NULL,
  `exp` bigint(10) DEFAULT NULL COMMENT '编号',
  `max_ce` bigint(20) DEFAULT '0' COMMENT '最大战力（冒险副本阵容）',
  `vip` int(11) DEFAULT NULL,
  `role_status` tinyint(1) DEFAULT NULL COMMENT '角色状态 0-正常 1- 角色被冻结 2-限制登陆',
  `role_time` datetime DEFAULT NULL COMMENT '限制登陆到达时间',
  `chat_status` tinyint(1) DEFAULT '0' COMMENT '禁言状态 0：未禁言，1：禁言',
  `chat_time` datetime DEFAULT NULL COMMENT '禁言时间',
  `is_gm` tinyint(1) DEFAULT '0' COMMENT '是否是GM(0:不是，1:是)',
  `on_line_second` int(11) DEFAULT NULL COMMENT '总在线秒数',
  `login_time` bigint(20) DEFAULT NULL COMMENT '最近一次登录时间戳',
  `logout_time` bigint(20) DEFAULT NULL COMMENT '下线时间',
  `quit_legion_time` bigint(20) DEFAULT '0' COMMENT '退出军团时间戳',
  `quit_game_time` bigint(20) DEFAULT NULL COMMENT '最新退出游戏时间戳',
  `official` int(11) DEFAULT '0' COMMENT '官职',
  `halo` int(11) DEFAULT '0' COMMENT '主角光环',
  `guide_list` varchar(1000) DEFAULT NULL COMMENT '已经引导的编号列表',
  `guide_no` int(11) DEFAULT '0' COMMENT '当前进行的新手引导编号',
  `guide_str` varchar(255) DEFAULT NULL COMMENT '特殊引导字符串',
  `status_code` int(11) DEFAULT NULL COMMENT '封号的原因错误码',
  `chat_code` int(11) DEFAULT NULL COMMENT '禁言的原因错误码',
  `server_no` int(10) DEFAULT NULL COMMENT '服ID',
  `src_server_no` int(10) DEFAULT NULL COMMENT '合服前的服编号',
  `channel_id` bigint(20) DEFAULT NULL,
  `legion_id` bigint(20) DEFAULT '0' COMMENT '玩家所属军团id',
  `area_code` int(11) DEFAULT NULL,
  `delete_flag` int(11) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx-userId` (`user_id`) USING BTREE,
  KEY `idx-createTime` (`create_time`) USING BTREE,
  KEY `idx_server_no` (`server_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='地区聊天编号';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_role_worship`
--

DROP TABLE IF EXISTS `card_game_role_worship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_role_worship` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `worship_times` int(11) DEFAULT NULL COMMENT '膜拜次数',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_flag` int(1) DEFAULT '0' COMMENT '删除标志位',
  PRIMARY KEY (`id`),
  KEY `idx-roleId` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户膜拜表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_runes`
--

DROP TABLE IF EXISTS `card_game_runes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_runes` (
  `id` bigint(20) NOT NULL,
  `rune_config_id` int(11) DEFAULT NULL COMMENT '符文配置ID',
  `attr` varchar(64) DEFAULT NULL COMMENT '属性',
  `skill` varchar(64) DEFAULT NULL COMMENT '技能',
  `recast_attr` varchar(64) DEFAULT NULL COMMENT '重铸属性',
  `recast_skill` varchar(64) DEFAULT NULL COMMENT '重铸技能',
  `role_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_flag` int(1) DEFAULT '0' COMMENT '删除标志位',
  PRIMARY KEY (`id`),
  KEY `idx_roleId` (`role_id`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE,
  KEY `idx_role_id_server_no` (`role_id`,`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户符文';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_server_attr`
--

DROP TABLE IF EXISTS `card_game_server_attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_server_attr` (
  `id` bigint(11) NOT NULL,
  `batch` varchar(50) DEFAULT NULL COMMENT '批次',
  `attr_name` varchar(50) NOT NULL COMMENT '名称（英文唯一）',
  `attr_value` varchar(5000) DEFAULT NULL COMMENT '值',
  `server_no` smallint(6) NOT NULL COMMENT '游戏服ID',
  `delete_flag` int(11) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx-createTime` (`create_time`) USING BTREE,
  KEY `idx-serverNo` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_server_func_plan`
--

DROP TABLE IF EXISTS `card_game_server_func_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_server_func_plan` (
  `id` bigint(20) NOT NULL,
  `server_no` int(11) NOT NULL COMMENT '服务器编号',
  `func_no` int(11) NOT NULL COMMENT '功能代号',
  `func_name` varchar(255) DEFAULT NULL COMMENT '功能名称',
  `origin` bigint(20) NOT NULL COMMENT '开启时间戳',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_server_no_func_no` (`server_no`,`func_no`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务器活动开启进度';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_shop`
--

DROP TABLE IF EXISTS `card_game_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_shop` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色编号',
  `shop_id` int(11) DEFAULT NULL COMMENT '商铺配置编号',
  `goods` varchar(1600) DEFAULT NULL COMMENT '商品信息(id:购买次数....)',
  `goods_refersh` varchar(1024) DEFAULT NULL COMMENT '单个商铺刷新规则',
  `goods_refresh_limit` varchar(500) DEFAULT NULL,
  `pl_refresh_time` bigint(20) DEFAULT NULL COMMENT '最近一次限购刷新时间',
  `free_refresh_time` bigint(20) DEFAULT NULL COMMENT '最近一次免费刷新时间',
  `pay_refresh_time` bigint(20) DEFAULT NULL COMMENT '最近一次有偿刷新时间',
  `pay_refresh_num` smallint(6) DEFAULT NULL COMMENT '有偿刷新次数',
  `server_no` smallint(6) DEFAULT NULL,
  `delete_flag` tinyint(4) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx-roleId` (`role_id`) USING BTREE,
  KEY `idx-createTime` (`create_time`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_siege`
--

DROP TABLE IF EXISTS `card_game_siege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_siege` (
  `id` bigint(20) NOT NULL,
  `chapter` int(11) DEFAULT NULL COMMENT '章节',
  `no` int(11) NOT NULL COMMENT '关卡',
  `star` smallint(4) DEFAULT NULL COMMENT '当前通关星级',
  `fight_cond` tinyint(4) DEFAULT NULL COMMENT '战斗条件  0：失败，1：成功',
  `hero_cond` tinyint(4) DEFAULT NULL COMMENT '上阵武将国家、职业条件 0：失败，1：成功',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `server_no` smallint(6) DEFAULT NULL COMMENT '游戏服ID',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_roleId` (`role_id`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='攻城略地信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_siege_min_unlock`
--

DROP TABLE IF EXISTS `card_game_siege_min_unlock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_siege_min_unlock` (
  `id` bigint(20) NOT NULL,
  `chapter` int(11) DEFAULT NULL,
  `no` int(11) DEFAULT NULL COMMENT '关卡编号',
  `fc` bigint(20) DEFAULT NULL COMMENT '解锁最低战力',
  `role_id` bigint(20) DEFAULT NULL COMMENT '解锁最低战力--玩家编号',
  `lineup` varchar(500) DEFAULT NULL COMMENT '最低战力解锁阵容',
  `report` mediumblob COMMENT '最低战力解锁录像',
  `server_no` smallint(6) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_server_no` (`server_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='攻城略地关卡最低战力通关信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_silkbag_scheme`
--

DROP TABLE IF EXISTS `card_game_silkbag_scheme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_silkbag_scheme` (
  `id` bigint(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '无成长装备编号集合(,分割)',
  `silkbags` varchar(255) DEFAULT NULL COMMENT '兵法编号集合(位置:编号#位置:编号...)',
  `role_id` bigint(10) NOT NULL COMMENT '角色ID',
  `server_no` smallint(6) NOT NULL,
  `delete_flag` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx-roleId` (`role_id`) USING BTREE,
  KEY `idx-createTime` (`create_time`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='兵法方案';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_small_package_log`
--

DROP TABLE IF EXISTS `card_game_small_package_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_small_package_log` (
  `id` bigint(11) NOT NULL,
  `user_id` bigint(11) NOT NULL COMMENT '账号ID',
  `role_id` bigint(11) NOT NULL COMMENT '角色ID',
  `server_no` smallint(6) NOT NULL COMMENT '服编号',
  `delete_flag` int(11) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='小包下载奖励领取日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_soulstone`
--

DROP TABLE IF EXISTS `card_game_soulstone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_soulstone` (
  `id` bigint(20) NOT NULL,
  `soul_config_id` int(11) DEFAULT NULL COMMENT '符文配置ID',
  `attr` varchar(64) DEFAULT NULL COMMENT '属性',
  `recast_attr` varchar(64) DEFAULT NULL COMMENT '重铸属性',
  `soul_type` int(4) DEFAULT NULL COMMENT '宝石类型（光，暗）',
  `recast_type` int(4) DEFAULT NULL COMMENT '淬炼宝石类型（光，暗）',
  `role_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `server_no` int(11) DEFAULT NULL COMMENT '服务器编号',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `delete_flag` int(1) DEFAULT '0' COMMENT '删除标志位',
  PRIMARY KEY (`id`),
  KEY `idx-roleId` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户魂石';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_star_map_combination`
--

DROP TABLE IF EXISTS `card_game_star_map_combination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_star_map_combination` (
  `id` bigint(20) NOT NULL,
  `no` int(11) NOT NULL COMMENT '星图组合编号',
  `chapter` bigint(20) DEFAULT NULL COMMENT '所属章节',
  `wish` tinyint(4) DEFAULT '0' COMMENT '是否收藏入心愿单 0：否，1：是',
  `star` tinyint(4) DEFAULT NULL COMMENT '星级',
  `addtion` int(11) DEFAULT NULL COMMENT '增加的星图值',
  `status` tinyint(4) DEFAULT '0' COMMENT '是否激活 0：否 ，1：是',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `server_no` smallint(6) DEFAULT NULL COMMENT '游戏服ID',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx-roleId` (`role_id`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色激活星图组合表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_star_map_scheme`
--

DROP TABLE IF EXISTS `card_game_star_map_scheme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_star_map_scheme` (
  `id` bigint(20) NOT NULL,
  `scheme_one` text COMMENT '方案一',
  `scheme_two` text COMMENT '方案二',
  `scheme_three` text COMMENT '方案三',
  `scheme_four` text COMMENT '方案四',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `server_no` smallint(6) DEFAULT NULL COMMENT '游戏服ID',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_roleId` (`role_id`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='将星方案表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_star_map_skill`
--

DROP TABLE IF EXISTS `card_game_star_map_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_star_map_skill` (
  `id` bigint(20) NOT NULL,
  `chapter` bigint(20) DEFAULT NULL COMMENT '章节',
  `no` int(11) DEFAULT NULL COMMENT '技能编号',
  `level` tinyint(4) DEFAULT NULL COMMENT '技能等级',
  `status` tinyint(4) DEFAULT '0' COMMENT '是否激活 0：否 ，1：是',
  `role_id` bigint(10) NOT NULL COMMENT '角色ID',
  `server_no` smallint(6) DEFAULT NULL COMMENT '游戏服ID',
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx-roleId` (`role_id`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色星技能图表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_stratagem`
--

DROP TABLE IF EXISTS `card_game_stratagem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_stratagem` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色编号',
  `no` int(11) DEFAULT NULL COMMENT '计谋编号',
  `lv` smallint(6) DEFAULT NULL COMMENT '等级',
  `star` smallint(6) DEFAULT NULL COMMENT '星级',
  `transfer_lv` int(11) DEFAULT '0' COMMENT '幻化等级',
  `server_no` smallint(6) DEFAULT NULL,
  `delete_flag` tinyint(4) DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx-roleId` (`role_id`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_task_daily`
--

DROP TABLE IF EXISTS `card_game_task_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_task_daily` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL COMMENT '任务id',
  `finish` bigint(20) DEFAULT NULL COMMENT '完成数量',
  `status` tinyint(4) DEFAULT NULL COMMENT '是否领取 0：未完成，1：待领取，2：已领取',
  `server_no` smallint(6) DEFAULT NULL COMMENT '游戏服ID',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_role_date` (`role_id`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE,
  KEY `idx_role_id_server_no` (`role_id`,`server_no`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日常任务完成记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_task_heroes_contest`
--

DROP TABLE IF EXISTS `card_game_task_heroes_contest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_task_heroes_contest` (
  `id` bigint(20) NOT NULL,
  `batch` varchar(20) DEFAULT NULL COMMENT '批次20200303',
  `role_id` bigint(20) NOT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '类型,1：群雄逐鹿',
  `task_id` bigint(20) DEFAULT NULL COMMENT '任务id',
  `task_type` int(11) DEFAULT NULL COMMENT '任务类型',
  `finish` int(11) DEFAULT NULL COMMENT '完成数量',
  `status` tinyint(4) DEFAULT '0' COMMENT '任务奖励领取状态 0：未完成，1：已领取',
  `server_no` smallint(6) DEFAULT NULL COMMENT '游戏服ID',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='群雄逐鹿任务';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_task_main_line`
--

DROP TABLE IF EXISTS `card_game_task_main_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_task_main_line` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `task_type` int(11) DEFAULT NULL COMMENT '任务类型',
  `finish` bigint(20) DEFAULT NULL COMMENT '完成数量',
  `server_no` smallint(6) DEFAULT NULL COMMENT '游戏服ID',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uix_task_role` (`role_id`,`task_type`) USING BTREE,
  KEY `idx_role_id` (`role_id`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主线任务完成记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_task_seven_day_goal`
--

DROP TABLE IF EXISTS `card_game_task_seven_day_goal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_task_seven_day_goal` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `task_type` int(11) DEFAULT NULL COMMENT '任务类型',
  `finish` bigint(20) DEFAULT NULL COMMENT '完成数量',
  `server_no` smallint(6) DEFAULT NULL COMMENT '游戏服ID',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uix_task_role` (`role_id`,`task_type`) USING BTREE,
  KEY `idx_role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='七日目标任务完成记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_task_weekly`
--

DROP TABLE IF EXISTS `card_game_task_weekly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_task_weekly` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL COMMENT '任务id',
  `finish` bigint(20) DEFAULT NULL COMMENT '完成数量',
  `status` tinyint(4) DEFAULT NULL COMMENT '是否领取 0：未完成，1：待领取，2：已领取',
  `server_no` smallint(6) DEFAULT NULL COMMENT '游戏服ID',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_role_date` (`role_id`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE,
  KEY `idx_role_id_server_no` (`role_id`,`server_no`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='周常任务完成记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_team_arena_log`
--

DROP TABLE IF EXISTS `card_game_team_arena_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_team_arena_log` (
  `id` bigint(20) NOT NULL,
  `issue` varchar(255) NOT NULL COMMENT '期次号',
  `attacker_server_no` int(11) NOT NULL COMMENT '攻方服务器编号',
  `attacker_role_id` bigint(20) NOT NULL COMMENT '攻方角色ID',
  `attacker_nickname` varchar(255) NOT NULL COMMENT '攻方昵称',
  `attacker_head_no` int(11) NOT NULL COMMENT '攻方头像编号',
  `attacker_lv` int(11) NOT NULL COMMENT '攻方等级',
  `attacker_score_changed` bigint(20) NOT NULL COMMENT '攻方获得积分（正数）',
  `defender_server_no` int(11) NOT NULL COMMENT '守方服务器编号',
  `defender_role_id` bigint(20) NOT NULL COMMENT '守方角色ID',
  `defender_nickname` varchar(255) NOT NULL COMMENT '守方昵称',
  `defender_head_no` int(11) NOT NULL COMMENT '守方头像编号',
  `defender_lv` int(11) NOT NULL COMMENT '守方等级',
  `defender_score_changed` bigint(20) NOT NULL COMMENT '守方扣除积分（数量）',
  `video_ids` varchar(255) NOT NULL COMMENT '录像ID，逗号分隔',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_issue_attacker_role_id` (`issue`,`attacker_role_id`) USING BTREE,
  KEY `idx_issue_defender_role_id` (`issue`,`defender_role_id`) USING BTREE,
  KEY `idx_attacker_server_no` (`attacker_server_no`) USING BTREE,
  KEY `idx_defender_server_no` (`defender_server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='多队擂台挑战记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_totem`
--

DROP TABLE IF EXISTS `card_game_totem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_totem` (
  `id` bigint(11) NOT NULL,
  `no` int(10) NOT NULL COMMENT '编号',
  `lv` smallint(6) DEFAULT '0' COMMENT '强化等级',
  `star` smallint(6) DEFAULT '0' COMMENT '星级',
  `role_id` bigint(10) NOT NULL COMMENT '角色ID',
  `server_no` smallint(6) DEFAULT NULL,
  `delete_flag` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_server_no` (`server_no`) USING BTREE,
  KEY `idx_roleId` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色图腾表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_treasure`
--

DROP TABLE IF EXISTS `card_game_treasure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_treasure` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色编号',
  `treasure_no` int(11) DEFAULT NULL COMMENT '神器配置编号',
  `add_attr` varchar(500) DEFAULT NULL COMMENT '附加属性',
  `star` tinyint(4) DEFAULT NULL COMMENT '星级',
  `foster_attr` varchar(255) DEFAULT NULL COMMENT '培养数据',
  `wear` tinyint(4) DEFAULT NULL COMMENT '是够装备(1是0否)',
  `server_no` smallint(6) DEFAULT NULL,
  `delete_flag` tinyint(4) DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx-roleId` (`role_id`) USING BTREE,
  KEY `idx_server_no` (`server_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_trial_tower`
--

DROP TABLE IF EXISTS `card_game_trial_tower`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_trial_tower` (
  `id` bigint(20) NOT NULL,
  `no` int(11) DEFAULT NULL COMMENT '关卡层数',
  `min_unlock_fc` bigint(20) DEFAULT NULL COMMENT '解锁最低战力',
  `min_unlock_role_id` bigint(20) DEFAULT NULL COMMENT '解锁最低战力--玩家编号',
  `min_unlock_lineup` varchar(500) DEFAULT NULL COMMENT '最低战力解锁阵容',
  `min_unlock_report` mediumblob COMMENT '最低战力解锁首战录像',
  `first_pass_report` mediumblob COMMENT '首通录像',
  `first_pass_role_id` bigint(20) DEFAULT NULL COMMENT '首通玩家编号',
  `first_pass_fc` bigint(11) DEFAULT NULL COMMENT '首通时的战力',
  `first_pass_lineup` varchar(500) DEFAULT NULL COMMENT '首通玩家阵容',
  `type` tinyint(4) DEFAULT '0' COMMENT '类型：0-试炼之塔，1-炼狱塔',
  `server_no` smallint(6) DEFAULT NULL,
  `delete_flag` tinyint(4) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_server_no` (`server_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='试炼之塔首通/最低通关记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_union_carnival_groupon_order`
--

DROP TABLE IF EXISTS `card_game_union_carnival_groupon_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_union_carnival_groupon_order` (
  `id` bigint(20) NOT NULL,
  `plan_id` bigint(20) NOT NULL COMMENT '活动计划ID',
  `server_no` int(11) NOT NULL COMMENT '服务器编号',
  `commodity_no` int(11) NOT NULL COMMENT '商品编号',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `price` int(11) NOT NULL COMMENT '成交价格',
  `waiver_day_num` tinyint(4) DEFAULT NULL COMMENT '该订单为活动第几天的免单。null 代表未免单',
  `received` tinyint(4) DEFAULT NULL COMMENT '是否已领取免单退款。1:是，0:否',
  `create_time` datetime NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_plan_id_server_no_waiver_day_num` (`plan_id`,`server_no`,`waiver_day_num`) USING BTREE,
  KEY `idx_plan_id_server_no_commodity_no` (`plan_id`,`server_no`,`commodity_no`) USING BTREE,
  KEY `idx_plan_id_role_id_commodity_no` (`plan_id`,`role_id`,`commodity_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='合服狂欢=全民团购-交易记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_vip_customer_info`
--

DROP TABLE IF EXISTS `card_game_vip_customer_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_vip_customer_info` (
  `id` bigint(20) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色id',
  `channel_id` bigint(20) DEFAULT NULL COMMENT '渠道id',
  `region_id` bigint(20) DEFAULT NULL COMMENT '大区id',
  `status` int(11) DEFAULT NULL COMMENT '认证状态，1-已认证，0-未认证',
  `config_id` bigint(20) DEFAULT NULL COMMENT '对应vip客服配置id',
  `code` varchar(50) DEFAULT NULL COMMENT '礼包码',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'CURRENT_TIMESTAMP',
  `delete_flag` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='vip客服认证信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_game_zhu_lu_log`
--

DROP TABLE IF EXISTS `card_game_zhu_lu_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card_game_zhu_lu_log` (
  `id` bigint(20) NOT NULL,
  `phase` int(11) DEFAULT NULL COMMENT '期次',
  `region_no` bigint(20) DEFAULT NULL COMMENT '大区id',
  `battle_result` tinyint(4) DEFAULT NULL COMMENT '战斗结果，1-胜利，0-失败',
  `role_id` bigint(20) DEFAULT NULL COMMENT '挑战者id',
  `server_no` int(11) DEFAULT NULL COMMENT '挑战者服务器编号',
  `camp` int(11) DEFAULT NULL COMMENT '挑战者阵营',
  `target_role_id` bigint(20) DEFAULT NULL COMMENT '被挑战者id',
  `target_server_no` int(11) DEFAULT NULL COMMENT '被挑战者服务器编号',
  `target_camp` int(11) DEFAULT NULL COMMENT '对手的阵营',
  `score_change` bigint(22) DEFAULT NULL COMMENT '积分变更值',
  `video_id` varchar(255) DEFAULT NULL COMMENT '录像id',
  `create_time` datetime DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delete_flag` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_phase_challenger` (`phase`,`role_id`) USING BTREE,
  KEY `idx_phase_challenged` (`phase`,`target_role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='逐鹿中原-战斗记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'card_game'
--

--
-- Dumping routines for database 'card_game'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-12 16:57:17
