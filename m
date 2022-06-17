Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F517C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 19:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiFQTtp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 15:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbiFQTtm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 15:49:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C764286E0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 12:49:38 -0700 (PDT)
Received: from localhost.localdomain (67.227.121.78.rev.sfr.net [78.121.227.67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: fdanis)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CF993660179B
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 20:49:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655495376;
        bh=LZEWs6sDWy32jeWlvKDEMbHToL9/xzBo22z0mEsZWZk=;
        h=From:To:Subject:Date:From;
        b=TberD4DqCFjUm18M6SY6Uas0A2MDyBnCx/XpFLer7+aE4Ed0AzNvZMxpvL6hemJxo
         UXJ+TkAI6bJwV+YaCSWkkPHCstplhGnoqm3ACwm4mrVK+iTSOwiDLPuGQGlPV3/awh
         00W2zv0WyLLZpeOk4/fccdr+OOuxGeD/RzRWZR1a5AwmFsS5zPUUZ4eWtVQOHy2LY3
         AS7iTy9q7Ory8kwroT7Eav2lM8kALxLyIQpS3uelz6D989T03vfUWg7PVkZDaze9h/
         WBypwTfOfmuqFJXeUJEkcPQ1GH6UxGJRGCMG9tJP4YboSsa2+BQ1dfLclGHHLdzl3K
         LCNu0RrXrH2IQ==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] test-runner: Fix issues found by coverity
Date:   Fri, 17 Jun 2022 21:49:29 +0200
Message-Id: <20220617194929.95991-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/test-runner.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 49fc21325..6886d66c6 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -275,6 +275,10 @@ static void start_qemu(void)
 		char *xdg_runtime_dir, *audiodev;
 
 		xdg_runtime_dir = getenv("XDG_RUNTIME_DIR");
+		if (!xdg_runtime_dir) {
+			fprintf(stderr, "XDG_RUNTIME_DIR not set\n");
+			exit(1);
+		}
 		audiodev = alloca(40 + strlen(xdg_runtime_dir));
 		sprintf(audiodev, "id=audio,driver=pa,server=%s/pulse/native",
 				xdg_runtime_dir);
@@ -474,8 +478,14 @@ static void create_dbus_session_conf(void)
 				"/usr/share/dbus-1/session.conf") < 0)
 		perror("Failed to create session.conf symlink");
 
-	mkdir("/run/user", 0755);
-	mkdir("/run/user/0", 0755);
+	if (mkdir("/run/user", 0755) < 0) {
+		fprintf(stderr, "unable to create /run/user directory\n");
+		return;
+	}
+	if (mkdir("/run/user/0", 0755) < 0) {
+		fprintf(stderr, "unable to create /run/user/0 directory\n");
+		return;
+	}
 }
 
 static pid_t start_dbus_daemon(bool session)
@@ -919,7 +929,7 @@ start_next:
 
 		if (corpse == dbus_session_pid) {
 			printf("D-Bus session daemon terminated\n");
-			dbus_pid = -1;
+			dbus_session_pid = -1;
 		}
 
 		if (corpse == daemon_pid) {
-- 
2.25.1

