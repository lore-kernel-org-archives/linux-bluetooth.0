Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA5CC6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 10:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjCWKmC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjCWKln (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 06:41:43 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAAA35EF7
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ew6so21390407edb.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679567921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=px4mnZzR8LoF4aom5eqQZBlh4g7OwxQ32xwWn2plVSU=;
        b=oN2OfDjfIEE+A2TiyruPnnuFibRItdbnOybgOzwJX8jpQq+lkRM7V7VXf5k35JIHpy
         1i4a586zCp//b9NVxirmCNZgGyI4aWa9w0W5xrDCfQhLkSMXq6FpUh4qPhEWdxH2KC3u
         GZzv9DGNNK1Z4adDoV/PLrf0dgp6unq7Bi9Vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=px4mnZzR8LoF4aom5eqQZBlh4g7OwxQ32xwWn2plVSU=;
        b=JuLxkzHJOeU+UOFYn3Go++zJBG59nvu2KimO7KVAoePR34YvVp0ZVgWK+OWKvr9BEN
         h8XPpDh6AaowXQCGU0xKaJoMw+lZ5ky1o+w8AbvqttCC6n6T/P3NblP5hlMXrheJhxX7
         NCgK3Zg4jLwL+75ngmvyOudy8K86iACOWRtsHLRixinBGvXEZNeqQhaLhqNmTN5Q4PSD
         Kknkt+HnGBGC3f8Fz6/jrNTPGr8/SHz+b8+QIHCRs0WHWVbWoyhtDudNkVrsEknL0APx
         cOKeV6+DeLZHksxo/qITuLpQ8IutjD2LdvADdj+NBia8+WKMuGhoKAc+4q3rw33qkccR
         SnfA==
X-Gm-Message-State: AO0yUKULGzSei8xLMbz+3in6oyGNXw379096AZPmHwPWDkY2SAvGOc9B
        omJMIMSR+DJoOyTmHAiQ7Npcd8OPSfWi0mqqrvU=
X-Google-Smtp-Source: AK7set9Acckpq6Dik1PHf72AaNp2XARPzM/J37I148tb9tMagBIQmKY/JfZNxokC50c3xbGWM/y/LA==
X-Received: by 2002:a17:906:f0c1:b0:931:6641:9897 with SMTP id dk1-20020a170906f0c100b0093166419897mr9847937ejb.44.1679567921442;
        Thu, 23 Mar 2023 03:38:41 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:4f8c:7da4:48b2:8bd2])
        by smtp.gmail.com with ESMTPSA id bv1-20020a170906b1c100b00939e76a0cabsm3513208ejb.111.2023.03.23.03.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:38:41 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 5/9] btgatt-client: Implement disconnect and connect commands
Date:   Thu, 23 Mar 2023 11:38:31 +0100
Message-Id: <20230323103835.571037-6-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
References: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/btgatt-client.c | 137 +++++++++++++++++++++++++++++++-----------
 1 file changed, 103 insertions(+), 34 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index ecfe3f3f1..152e6ee70 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -40,9 +40,13 @@
 
 #define MAX_LEN_LINE 512
 
-struct client *cli;
+struct client *cli = NULL;
 static bool verbose = false;
 static bool shell_running = false;
+static uint8_t dst_type = BDADDR_LE_PUBLIC;
+static bdaddr_t src_addr, dst_addr;
+static int security_level = BT_SECURITY_LOW;
+static uint16_t mtu = 0;
 
 #define print(fmt, arg...) do { \
 	if (shell_running) \
@@ -71,10 +75,22 @@ struct client {
 	unsigned int reliable_session_id;
 };
 
+static int l2cap_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
+									int sec);
+
 static void update_prompt(void)
 {
-	char str[32];
-	sprintf(str, COLOR_BLUE "[GATT client]" COLOR_OFF "# ");
+	char str[64], addr[18], type[3];
+	if (!bacmp(&dst_addr, BDADDR_ANY))
+		sprintf(str, "[GATT client]# ");
+	else {
+		ba2str(&dst_addr, addr);
+		sprintf(type, dst_type == BDADDR_BREDR ? "BR" : "LE");
+		if (cli)
+			sprintf(str, COLOR_BLUE "[%s][%s]" COLOR_OFF "# ", addr, type);
+		else
+			sprintf(str, "[%s][%s]# ", addr, type);
+	}
 	bt_shell_set_prompt(str);
 }
 
@@ -126,11 +142,22 @@ static const char *ecode_to_string(uint8_t ecode)
 	}
 }
 
+static void client_destroy()
+{
+	if (cli) {
+		bt_gatt_client_unref(cli->gatt);
+		bt_att_unref(cli->att);
+		free(cli);
+		cli = NULL;
+	}
+}
+
 static void att_disconnect_cb(int err, void *user_data)
 {
 	print("Device disconnected: %s", strerror(err));
 
-	mainloop_quit();
+	client_destroy();
+	update_prompt();
 }
 
 static void att_debug_cb(const char *str, void *user_data)
@@ -247,13 +274,6 @@ static struct client *client_create(int fd, uint16_t mtu)
 	return cli;
 }
 
-static void client_destroy(struct client *cli)
-{
-	bt_gatt_client_unref(cli->gatt);
-	bt_att_unref(cli->att);
-	free(cli);
-}
-
 static void append_uuid(char *str, const bt_uuid_t *uuid)
 {
 	char uuid_str[MAX_LEN_UUID_STR];
@@ -1066,6 +1086,66 @@ static void cmd_set_sign_key(int argc, char **argv)
 	}
 }
 
+static void connect_device()
+{
+	int fd;
+	fd = l2cap_att_connect(&src_addr, &dst_addr, dst_type, security_level);
+	if (fd < 0) {
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+	cli = client_create(fd, mtu);
+	if (!cli) {
+		close(fd);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
+static void cmd_connect(int argc, char **argv)
+{
+	char addr[18];
+
+	if (cli) {
+		error("Already connected");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+	if (argc > 1) {
+		if (str2ba(argv[1], &addr) < 0) {
+			error("Invalid remote address: %s", argv[1]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+		bacpy(&dst_addr, &addr);
+	}
+	if (argc > 2) {
+		if (strcmp(argv[2], "random") == 0)
+			dst_type = BDADDR_LE_RANDOM;
+		else if (strcmp(argv[2], "public") == 0)
+			dst_type = BDADDR_LE_PUBLIC;
+		else if (strcmp(argv[2], "bredr") == 0)
+			dst_type = BDADDR_BREDR;
+		else {
+			error("Allowed types: random, public, bredr");
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+	if (!bacmp(&dst_addr, BDADDR_ANY)) {
+		error("Destination address required!");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+	connect_device();
+	update_prompt();
+}
+
+static void cmd_disconnect(int argc, char **argv)
+{
+	if (!cli) {
+		error("Already disconnected");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+	close(cli->fd);
+	client_destroy();
+	update_prompt();
+}
+
 static const struct bt_shell_menu main_menu = {
 	.name = "main",
 	.entries = {
@@ -1117,6 +1197,10 @@ static const struct bt_shell_menu main_menu = {
 		cmd_get_security, "Get security level on connection"},
 	{ "set-sign-key", "<csrk>",
 		cmd_set_sign_key, "Set signing key for signed write command"},
+	{ "connect", "[address] [public|random|bredr]",
+		cmd_connect, "Connect to device" },
+	{ "disconnect", NULL,
+		cmd_disconnect, "Disconnect from connected device" },
 	{} },
 };
 
@@ -1240,12 +1324,7 @@ static const struct bt_shell_opt opt = {
 
 int main(int argc, char *argv[])
 {
-	int sec = BT_SECURITY_LOW;
-	uint16_t mtu = 0;
-	uint8_t dst_type = BDADDR_LE_PUBLIC;
-	bdaddr_t src_addr, dst_addr;
 	int dev_id = -1;
-	int fd;
 	int status;
 
 	bt_shell_init(argc, argv, &opt);
@@ -1255,13 +1334,13 @@ int main(int argc, char *argv[])
 		verbose = true;
 	if (security_level_option) {
 		if (strcmp(security_level_option, "low") == 0)
-			sec = BT_SECURITY_LOW;
+			security_level = BT_SECURITY_LOW;
 		else if (strcmp(security_level_option, "medium") == 0)
-			sec = BT_SECURITY_MEDIUM;
+			security_level = BT_SECURITY_MEDIUM;
 		else if (strcmp(security_level_option, "high") == 0)
-			sec = BT_SECURITY_HIGH;
+			security_level = BT_SECURITY_HIGH;
 		else if (strcmp(security_level_option, "fips") == 0)
-			sec = BT_SECURITY_FIPS;
+			security_level = BT_SECURITY_FIPS;
 		else {
 			error("Invalid security level");
 			return EXIT_FAILURE;
@@ -1301,8 +1380,7 @@ int main(int argc, char *argv[])
 			return EXIT_FAILURE;
 		}
 	} else {
-		error("Destination address required!");
-		return EXIT_FAILURE;
+		bacpy(&dst_addr, BDADDR_ANY);
 	}
 	if (index_option) {
 		dev_id = hci_devid(index_option);
@@ -1319,15 +1397,8 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	fd = l2cap_att_connect(&src_addr, &dst_addr, dst_type, sec);
-	if (fd < 0)
-		return EXIT_FAILURE;
-
-	cli = client_create(fd, mtu);
-	if (!cli) {
-		close(fd);
-		return EXIT_FAILURE;
-	}
+	if (bacmp(&dst_addr, BDADDR_ANY))
+		connect_device();
 
 	bt_shell_attach(fileno(stdin));
 	update_prompt();
@@ -1335,9 +1406,7 @@ int main(int argc, char *argv[])
 	status = bt_shell_run();
 	shell_running = false;
 
-	print("Shutting down...");
-
-	client_destroy(cli);
+	client_destroy();
 
 	return status;
 }
-- 
2.34.1

