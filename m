Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387BDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Apr 2022 00:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbiDZADo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Apr 2022 20:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbiDZADk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Apr 2022 20:03:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA6711A3C
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 17:00:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a11so5085373pff.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 17:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5rEeZljbyOxxq9boILGDhtSfvaWhZpYzphgWh6HejoQ=;
        b=GLRqMShe6bzheBC0AgOsgFhFTdgL0SX7KzkICjwM1o3QxuQb/Jg71tKInBX1H70JQs
         LHmtQV5pgOmgUfmTmjxDsgaBLEEXgLXzbn25Yzm/FIGqpgwSbtRR1WxBoUEqdttY68GC
         WS8XpF7zJFixKWPZ9UXIY5GH+06CPvrJz9Bcux6YdQblCV4g8UFNJUc2RBRx4wNts/xp
         brSXkuMVrwSI8YYV5XbzboJG94WT4XxLZULrm1g4APfWIpN2dqI4yA7+VfH94y51ypzB
         X7ha3hQgTly6CBEqN5amEZP3kuEzHWpUyg/sClJAy09S5RRPmYauxVL+LIt86tH1nHHv
         ufAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5rEeZljbyOxxq9boILGDhtSfvaWhZpYzphgWh6HejoQ=;
        b=YRYJhhi19NncpeDeQ3IZiX0FbI8M4ifytuQmpjosE1ldupDb+ZB8MD42WQS1EO0JAZ
         +rVH/s5bxjTjphZBXISta/w1sQcps4VprnlsdErvqYQgW/PC5bUHq9XC78bHJPwkfJqu
         /QRQoh3HgWURz5M7qaP9EDlgnOz5g6rgVMjNTYdLK+M9TbphisK6onRtRqKE6qREObWh
         74xzZ785xm/HycEGISGb4q9A4X4iYvUig2tfWTbizd5sVpk01/0ODdTvfY9xgeYAw3PL
         a+2ntOrSXJUXU2tOmhPulkakQOkNEGbnnAmCYwBsaW3GLhw6P3kmpFlWrARgLeQFEuNZ
         2DGw==
X-Gm-Message-State: AOAM5300y2qCOIa5w9Hs/wUZUUMgy7T86GPfNh3j7j4/PCui/FkB8pml
        r2wAHUcrXyPdW/vLudVFBL1GUcBTp2s=
X-Google-Smtp-Source: ABdhPJyo4+g17lBs1czFhw1dy6jDo9s0BQGdkr1TMQ3KAx3AQYxyV4Q44Orbl44KdWwP7d5uyMXbTQ==
X-Received: by 2002:a63:8643:0:b0:3ab:2240:3da1 with SMTP id x64-20020a638643000000b003ab22403da1mr8256247pgd.621.1650931233974;
        Mon, 25 Apr 2022 17:00:33 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q9-20020a638c49000000b00398677b6f25sm11578238pgn.70.2022.04.25.17.00.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 17:00:33 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/player: Add transport.receive command
Date:   Mon, 25 Apr 2022 17:00:32 -0700
Message-Id: <20220426000032.622524-1-luiz.dentz@gmail.com>
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
 client/player.c | 53 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/client/player.c b/client/player.c
index 315cde712..9f41c1b83 100644
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
 
@@ -2451,13 +2461,13 @@ static void cmd_release_transport(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-static int open_file(const char *filename)
+static int open_file(const char *filename, int flags)
 {
 	int fd = -1;
 
 	bt_shell_printf("Opening %s ...\n", filename);
 
-	fd = open(filename, O_RDONLY);
+	fd = open(filename, flags);
 	if (fd <= 0)
 		bt_shell_printf("Can't open file %s: %s\n", filename,
 						strerror(errno));
@@ -2514,7 +2524,7 @@ static void cmd_send_transport(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	fd = open_file(argv[1]);
+	fd = open_file(argv[1], O_RDONLY);
 
 	bt_shell_printf("Sending ...\n");
 	err = transport_send(fd);
@@ -2527,6 +2537,38 @@ static void cmd_send_transport(int argc, char *argv[])
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
@@ -2589,6 +2631,8 @@ static const struct bt_shell_menu transport_menu = {
 						transport_generator },
 	{ "send",        "<filename>",	cmd_send_transport,
 						"Send contents of a file" },
+	{ "receive",     "[filename]",	cmd_receive_transport,
+						"Get/Set file to receive" },
 	{ "volume",      "<transport> [value]",	cmd_volume_transport,
 						"Get/Set transport volume",
 						transport_generator },
@@ -2617,4 +2661,5 @@ void player_add_submenu(void)
 void player_remove_submenu(void)
 {
 	g_dbus_client_unref(client);
+	transport_close();
 }
-- 
2.35.1

