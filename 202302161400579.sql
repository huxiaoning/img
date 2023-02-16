-- mysql card_game

ALTER TABLE `card_game_trial_tower`
ADD COLUMN `first_three_star_time`  datetime NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '首次三星通关时间' AFTER `server_no`;

ALTER TABLE `card_game`.`card_game_legion` 
ADD COLUMN `type` tinyint(0) NULL DEFAULT 1 COMMENT '军团类型 0系统军团 1真实军团' AFTER `notice_status`;

-- mysql cardCenter

ALTER TABLE `card_center`.`card_center_region_config`
ADD COLUMN `no_battle_region_server_check`  int(11) NULL DEFAULT 0 COMMENT '该大区未开服务器无战区配置告警数量（前x个未开的服无战区则告警）' AFTER `auto_hot_server_amount`;


-- mycatcardgame 库
ALTER TABLE `card_game_hero`
MODIFY COLUMN `common_attr` VARCHAR(3000) DEFAULT NULL COMMENT '通用的字段，目前是用于幻将的国家';



-- 卡牌后台修改备份
-- sys_config 运营活动-幻将活动新增模板，code为3，name为青莲法正
UPDATE `card_center`.`card_center_sys_config`
SET  `value`='{\"24000\":[{\"code\":1,\"name\":\"七星秘宝\"},{\"code\":2,\"name\":\"夺宝奇兵\"},{\"code\":3,\"name\":\"望气占星\"}],\"75000\":[{\"code\":2,\"name\":\"诸葛亮\"},{\"code\":3,\"name\":\"关羽\"},{\"code\":4,\"name\":\"玩酷驭浪\"},{\"code\":5,\"name\":\"秋季主角皮肤\"}],\"76000\":[{\"code\":1,\"name\":\"合服狂欢\"}],\"66000\":[{\"code\":0,\"name\":\"端午安康\"},{\"code\":2,\"name\":\"秋季盛典\"}],\"42009\":[{\"code\":1,\"name\":\"芳菲菲\"},{\"code\":2,\"name\":\"流光流萤\"},{\"code\":3,\"name\":\"美人九歌\"}],\"70000\":[{\"code\":1,\"name\":\"龙魂赵云\"},{\"code\":2,\"name\":\"闭月貂蝉\"},{\"code\":3,\"name\":\"青莲法正\"}],\"67000\":[{\"code\":1,\"name\":\"主角皮肤活动\"},{\"code\":2,\"name\":\"昆仑镜\"}],\"41000\":[{\"code\":1,\"name\":\"神将来袭\"}],\"83000\":[{\"code\":1,\"name\":\"登录礼包\"},{\"code\":2,\"name\":\"登录礼包2\"}],\"31000\":[{\"code\":1,\"name\":\"幸运夺宝\"}],\"85000\":[{\"code\":1,\"name\":\"活动皮肤售卖\"}],\"87000\":[{\"code\":1,\"name\":\"如梦令\"},{\"code\":2,\"name\":\"锦韶年华\"},{\"code\":3,\"name\":\"绿野仙踪\"},{\"code\":4,\"name\":\"玩酷驭浪\"}],\"90000\":[{\"code\":1,\"name\":\"新服礼包\"}],\"81000\":[{\"code\":1,\"name\":\"限时冲榜\"}],\"91000\":[{\"code\":1,\"name\":\"新版升星专属\"}],\"920000\":[{\"code\":1,\"name\":\"中秋盛宴\"}]}'
where `name`='activity_template_code';