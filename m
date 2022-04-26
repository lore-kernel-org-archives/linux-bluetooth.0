Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EEDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Apr 2022 18:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349992AbiDZSHR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Apr 2022 14:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348642AbiDZSHQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Apr 2022 14:07:16 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672234A919
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 11:04:08 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id h1so18646149pfv.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k9ACo0nNvGYcmWMcrcD5rZmuw08BO9te5phAzbX4Phc=;
        b=BzGG4R6WTVsycT+9hvBpEgS4IKkdUIU+gIPDD4jfDhveaICyZeoKy0nFxA5R6+nhfl
         l+DInTOvuZStropsDxKU0SEeTDoWtkEicTrOC8OYEProbtPivRMeyS5faB2DA8v+Itul
         BIJ6ijgA1FXuLONaVCMERs7BEUxEqvmCPlLI/A9dvlpKQ9kWojhkBOR1cXIojDR0CjAB
         LKz3q/9EjhDD1MWCJel6QNLuQpo4Mh9bA7k72uEai0iSCNCT9I2q8BY+ay9DQPcdzqfS
         jd1OD9Vv5XiOLCyJwkbialx9NsfS5+c4TlRYF/89cTt4i1miqBAWoQnbh8etNqdq6aYK
         RBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k9ACo0nNvGYcmWMcrcD5rZmuw08BO9te5phAzbX4Phc=;
        b=6EBMRO6EXuZcs45BO6fiym1+BTWgvLBp3/EBEkYCeEPBIRnBgBXypJ00PwCdxuSx74
         +LJjKAUwr4slHQV9x5F8e/DALlQigvlg6RkTXc2gUs/En3F2iR4fISts4O6caCkxbip5
         IPV1nuDkVN/UN7Lk4k0TKFCj9EHOmYmVe6H4FPDd34rf2nDWojj1uTJY9lqpkjJsprav
         J3Aa5qaYn2nd52MwpKdlP9aZP4niDQ4ht4T5uzPggM0Dtq1kRkjs6CVMJIi+p8Vgxyli
         63W3KXpD/Qs8leVClY9GXocuZfqIB+NXnGxxDmJ8b9BiMqKrzs2i5cX6RTyWhTCC5/mJ
         2vhg==
X-Gm-Message-State: AOAM532PnVAUfYO+h00lHeNvLJpAspWYiy4or2P9XUcPUK/FXmct/IPx
        yeFTPat8LZH8hn1GuGyiNkIYcEU4u0o=
X-Google-Smtp-Source: ABdhPJyMSASi7mK6HiGgyO9oEHIIewISbM2xv0lSyPGXagGc2eSURyoEV/bnruBs9FETYQ1mUyoPEA==
X-Received: by 2002:a05:6a00:1895:b0:50a:de86:b4b0 with SMTP id x21-20020a056a00189500b0050ade86b4b0mr25657958pfh.28.1650996247452;
        Tue, 26 Apr 2022 11:04:07 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 128-20020a630686000000b003ab01991fe5sm10259396pgg.77.2022.04.26.11.04.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:04:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ] client/player: Add transport.receive command
Date:   Tue, 26 Apr 2022 11:04:01 -0700
Message-Id: <20220426180401.794718-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds transport.receive command:

Get/Set file to receive
Usage:
	 receive [filename]
---
 client/player.c | 57 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/client/player.c b/client/player.c
index 315cde712..c2c10e7e2 100644
--- a/client/player.c
+++ b/client/player.c
@@ -81,10 +81,13 @@ static GList *transports = NULL;
 struct transport {
 	int sk;
 	int mtu[2];
+	char *filename;
+	int fd;
 	struct io *io;
 	uint32_t seq;
 } transport = {
 	.sk = -1,
+	.fd = -1,
 };
 
 static void endpoint_unregister(void *data)
@@ -2219,7 +2222,7 @@ static bool transport_disconnected(struct io *io, void *user_data)
 static bool transport_recv(struct io *io, void *user_data)
 {
 	uint8_t buf[1024];
-	int ret;
+	int ret, len;
 
 	ret = read(io_get_fd(io), buf, sizeof(buf));
 	if (ret < 0) {
@@ -2232,6 +2235,13 @@ static bool transport_recv(struct io *io, void *user_data)
 
 	transport.seq++;
 
+	if (transport.fd) {
+		len = write(transport.fd, buf, ret);
+		if (len < 0)
+			bt_shell_printf("Unable to write: %s (%d)",
+						strerror(errno), -errno);
+	}
+
 	return true;
 }
 
@@ -2451,13 +2461,17 @@ static void cmd_release_transport(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-static int open_file(const char *filename)
+static int open_file(const char *filename, int flags)
 {
 	int fd = -1;
 
 	bt_shell_printf("Opening %s ...\n", filename);
 
-	fd = open(filename, O_RDONLY);
+	if (flags & O_CREAT)
+		fd = open(filename, flags, 0755);
+	else
+		fd = open(filename, flags);
+
 	if (fd <= 0)
 		bt_shell_printf("Can't open file %s: %s\n", filename,
 						strerror(errno));
@@ -2514,7 +2528,7 @@ static void cmd_send_transport(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	fd = open_file(argv[1]);
+	fd = open_file(argv[1], O_RDONLY);
 
 	bt_shell_printf("Sending ...\n");
 	err = transport_send(fd);
@@ -2527,6 +2541,38 @@ static void cmd_send_transport(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void transport_close(void)
+{
+	if (transport.fd < 0)
+		return;
+
+	close(transport.fd);
+	transport.fd = -1;
+
+	free(transport.filename);
+	transport.filename = NULL;
+}
+
+static void cmd_receive_transport(int argc, char *argv[])
+{
+	if (argc == 1) {
+		bt_shell_printf("Filename: %s\n", transport.filename);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	transport_close();
+
+	transport.fd = open_file(argv[1], O_RDWR | O_CREAT);
+	if (transport.fd < 0)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	transport.filename = strdup(argv[1]);
+
+	bt_shell_printf("Filename: %s\n", transport.filename);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void volume_callback(const DBusError *error, void *user_data)
 {
 	if (dbus_error_is_set(error)) {
@@ -2589,6 +2635,8 @@ static const struct bt_shell_menu transport_menu = {
 						transport_generator },
 	{ "send",        "<filename>",	cmd_send_transport,
 						"Send contents of a file" },
+	{ "receive",     "[filename]",	cmd_receive_transport,
+						"Get/Set file to receive" },
 	{ "volume",      "<transport> [value]",	cmd_volume_transport,
 						"Get/Set transport volume",
 						transport_generator },
@@ -2617,4 +2665,5 @@ void player_add_submenu(void)
 void player_remove_submenu(void)
 {
 	g_dbus_client_unref(client);
+	transport_close();
 }
-- 
2.35.1

