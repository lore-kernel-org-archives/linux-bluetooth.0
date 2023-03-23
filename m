Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F9DC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 10:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjCWKl7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCWKli (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 06:41:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502903B236
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b20so51427459edd.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679567920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lb9C5GpQN4g3bfCkMJYSdXclZJQqIUaDfGvJziBEQI=;
        b=qZo4COgzFy5TXbZEm9KL0WRz0YiTwXQyRsOdZdsZyT+A7d0PI92wuiqdDcFmMoIiiq
         B47/hJpRBJskD1K6CBnkIS7nBJh3eHDIuaCf/+RIcr/YBEcyTnMHxtWPhJ8BeBeg7KXx
         nn3d1yfo7qOyBJo/DnOhWsuz/jsSKGvu9sxUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lb9C5GpQN4g3bfCkMJYSdXclZJQqIUaDfGvJziBEQI=;
        b=C4GmCeeM944X3ZwdanBtRq5NaIdEpnq0Ku5KH6U22120pYHd1T2zoOORqoK1pjMSp8
         SGVwvotM8tXht8oVHy6xKgGcmZLRxxVoT7vOTz7vq0q6o5ZD1+xiLv8k5QzN4IjCX+c/
         8gYNHNH1KFINS8qJRXealZvReQVsp+Vx44WuFMEHdEg79TewZ+wg4tIzdyj0VpaKjj/E
         QSvuzJNDDG4kM7+kztX25+m/HLK3uphT35lLqMXroyrnPMLsFui43IISkgPizqqHUWvO
         WukDxLiZVWSSDHcXXE46L4saEHAQF6x0o3gORmx7FYj6e0BaBqY2hxBG10gIHhY3nAzr
         0NJw==
X-Gm-Message-State: AO0yUKUphyA+QOirBcdB2dRn+Ns9AVgRdkbq66ukA4Hyo4Jph8EI0R1D
        o9uScr3By3n66ECOsAfqT3DmQ1H97Tmp0FVx1Rg=
X-Google-Smtp-Source: AK7set/xzgjzHn+dX5Kt7KTw08xGVM2wM0rQLPhLQFDbFKxYSmxOF38ndiprRebzHArIQ5MB8vGiQQ==
X-Received: by 2002:a17:907:2162:b0:92d:44ca:1137 with SMTP id rl2-20020a170907216200b0092d44ca1137mr10313652ejb.43.1679567920236;
        Thu, 23 Mar 2023 03:38:40 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:4f8c:7da4:48b2:8bd2])
        by smtp.gmail.com with ESMTPSA id bv1-20020a170906b1c100b00939e76a0cabsm3513208ejb.111.2023.03.23.03.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:38:40 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 3/9] btgatt-client: Don't wait for discovery on read/write commands
Date:   Thu, 23 Mar 2023 11:38:29 +0100
Message-Id: <20230323103835.571037-4-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
References: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/btgatt-client.c | 45 -------------------------------------------
 1 file changed, 45 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index cce978869..2a0cb5181 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -490,11 +490,6 @@ static void cmd_read_multiple(struct client *cli, char *cmd_str)
 	int i;
 	char *endptr = NULL;
 
-	if (!bt_gatt_client_is_ready(cli->gatt)) {
-		printf("GATT client not initialized\n");
-		return;
-	}
-
 	if (!parse_args(cmd_str, sizeof(argv), argv, &argc) || argc < 2) {
 		read_multiple_usage();
 		return;
@@ -560,11 +555,6 @@ static void cmd_read_value(struct client *cli, char *cmd_str)
 	uint16_t handle;
 	char *endptr = NULL;
 
-	if (!bt_gatt_client_is_ready(cli->gatt)) {
-		printf("GATT client not initialized\n");
-		return;
-	}
-
 	if (!parse_args(cmd_str, 1, argv, &argc) || argc != 1) {
 		read_value_usage();
 		return;
@@ -594,11 +584,6 @@ static void cmd_read_long_value(struct client *cli, char *cmd_str)
 	uint16_t offset;
 	char *endptr = NULL;
 
-	if (!bt_gatt_client_is_ready(cli->gatt)) {
-		printf("GATT client not initialized\n");
-		return;
-	}
-
 	if (!parse_args(cmd_str, 2, argv, &argc) || argc != 2) {
 		read_long_value_usage();
 		return;
@@ -661,11 +646,6 @@ static void cmd_write_value(struct client *cli, char *cmd_str)
 	bool without_response = false;
 	bool signed_write = false;
 
-	if (!bt_gatt_client_is_ready(cli->gatt)) {
-		printf("GATT client not initialized\n");
-		return;
-	}
-
 	if (!parse_args(cmd_str, 514, argv + 1, &argc)) {
 		printf("Too many arguments\n");
 		write_value_usage();
@@ -791,11 +771,6 @@ static void cmd_write_long_value(struct client *cli, char *cmd_str)
 	uint8_t *value = NULL;
 	bool reliable_writes = false;
 
-	if (!bt_gatt_client_is_ready(cli->gatt)) {
-		printf("GATT client not initialized\n");
-		return;
-	}
-
 	if (!parse_args(cmd_str, 514, argv + 1, &argc)) {
 		printf("Too many arguments\n");
 		write_value_usage();
@@ -901,11 +876,6 @@ static void cmd_write_prepare(struct client *cli, char *cmd_str)
 	unsigned int length;
 	uint8_t *value = NULL;
 
-	if (!bt_gatt_client_is_ready(cli->gatt)) {
-		printf("GATT client not initialized\n");
-		return;
-	}
-
 	if (!parse_args(cmd_str, 514, argv + 1, &argc)) {
 		printf("Too many arguments\n");
 		write_value_usage();
@@ -1026,11 +996,6 @@ static void cmd_write_execute(struct client *cli, char *cmd_str)
 	unsigned int session_id;
 	bool execute;
 
-	if (!bt_gatt_client_is_ready(cli->gatt)) {
-		printf("GATT client not initialized\n");
-		return;
-	}
-
 	if (!parse_args(cmd_str, 514, argv, &argc)) {
 		printf("Too many arguments\n");
 		write_value_usage();
@@ -1193,11 +1158,6 @@ static void cmd_set_security(struct client *cli, char *cmd_str)
 	char *endptr = NULL;
 	int level;
 
-	if (!bt_gatt_client_is_ready(cli->gatt)) {
-		printf("GATT client not initialized\n");
-		return;
-	}
-
 	if (!parse_args(cmd_str, 1, argv, &argc)) {
 		printf("Too many arguments\n");
 		set_security_usage();
@@ -1225,11 +1185,6 @@ static void cmd_get_security(struct client *cli, char *cmd_str)
 {
 	int level;
 
-	if (!bt_gatt_client_is_ready(cli->gatt)) {
-		printf("GATT client not initialized\n");
-		return;
-	}
-
 	level = bt_gatt_client_get_security(cli->gatt);
 	if (level < 0)
 		printf("Could not set sec level\n");
-- 
2.34.1

