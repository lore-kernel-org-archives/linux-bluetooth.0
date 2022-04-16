Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E44C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Apr 2022 00:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiDPAV1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 20:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiDPAV0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 20:21:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B20FD398E
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 17:18:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g12-20020a17090a640c00b001cb59d7a57cso8404885pjj.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 17:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sz4IHHoDtXFM8pbU3ctHD/oh3X3RJRHz3VjvrVzkxpw=;
        b=jDmwCDZKDhDxOF5gBIatQl47m64O25qn1QHET0w2uEQUR0ysVh+guXZVN1U3u6HFWc
         TXo+yedc5CRpQsVWT9E4pagF5xqcQnIw6f3u4u84T1G+kjvlXa1igmGSrEvcVGnCnZWr
         fjPA0SuQpTnLdvLnEnO5CC2VHkyP7nA87m6LM84qd26KR6UH2uOG2qeOKV6Gf//38c7y
         mA6EYlREPNpgi5oJegCQOi54DYxWQGTERygYCUMxXr1E1g9epgTZAupjUcdOcQhdTthv
         AwgkYSnQD/GuqflW0OanYbOgZ1LXW27XQmwTSODOsGnrXmwGZODWLZjSwzH0l/CKod7s
         xanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sz4IHHoDtXFM8pbU3ctHD/oh3X3RJRHz3VjvrVzkxpw=;
        b=gZBE87xIoMwnLzEwFF7oraJKEFqKGXfVZMTjlrpnSIA5xGyJDnP6bB2/jq4tpjSEuq
         hrx7W823Ayt6HHcmbZDTiDn6WJ6dCqY/grLXV0QZOuQ14fYGh0gJ3rXLUISy9ckZNjGL
         Cy30AFgc25n97nP5kqM7kCnLiRIYHTNpnbHPrkQ1pbQ0RqB6nO+LQzI3HcofdXXj2W1t
         vHzMac58hpirZbIHWt4er17JsmU6OGhw+DXNQaVqOcFxBocCBvKmeSR1IwFoSNueVken
         1zl8wDFgtWN7BXt6pBPbGghlEiESahwu3IAWRcWS8rieMG2wHVQhd2CvYwDh6DzwoHvv
         6Dtw==
X-Gm-Message-State: AOAM533mRCpdNmqt2KxCanQBhwHwqA4Uw94Oon5bl3AVsr2LcgWU4X8f
        7Qrzk02jwEP17TaiQvsvpjcyP0nGEaY=
X-Google-Smtp-Source: ABdhPJyECIib/KebKeBr2Bvu3KRzb6U8dbAFpt2cCDAQ7/0aSGnWE4N+Tk2hvaThQhe2Wgqd+tarcA==
X-Received: by 2002:a17:90b:1b44:b0:1cd:49b8:42b8 with SMTP id nv4-20020a17090b1b4400b001cd49b842b8mr1439827pjb.102.1650068334356;
        Fri, 15 Apr 2022 17:18:54 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a00241000b004f3a647ae89sm3851970pfh.174.2022.04.15.17.18.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 17:18:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] test-runner: Add dedicated option to start D-Bus
Date:   Fri, 15 Apr 2022 17:18:53 -0700
Message-Id: <20220416001853.1240822-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a dedicated option to start D-Bus alone which can be useful
when testing the bluetoothd with the likes of valgrind.
---
 tools/test-runner.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index fd7b3b1b7..1f1a8c36f 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -47,6 +47,7 @@ static int test_argc;
 
 static bool run_auto = false;
 static bool start_dbus = false;
+static bool start_daemon = false;
 static bool start_emulator = false;
 static bool start_monitor = false;
 static int num_devs = 0;
@@ -249,11 +250,12 @@ static void start_qemu(void)
 				"rootflags=trans=virtio,version=9p2000.L "
 				"acpi=off pci=noacpi noapic quiet ro init=%s "
 				"bluetooth.enable_ecred=1"
-				"TESTHOME=%s TESTDBUS=%u TESTMONITOR=%u "
-				"TESTEMULATOR=%u TESTDEVS=%d TESTAUTO=%u "
-				"TESTARGS=\'%s\'",
-				initcmd, cwd, start_dbus, start_monitor,
-				start_emulator, num_devs, run_auto, testargs);
+				"TESTHOME=%s TESTDBUS=%u TESTDAEMON=%u "
+				"TESTMONITOR=%u TESTEMULATOR=%u TESTDEVS=%d "
+				"TESTAUTO=%u TESTARGS=\'%s\'",
+				initcmd, cwd, start_dbus, start_daemon,
+				start_monitor, start_emulator, num_devs,
+				run_auto, testargs);
 
 	argv = alloca(sizeof(qemu_argv) +
 				(sizeof(char *) * (4 + (num_devs * 4))));
@@ -683,11 +685,13 @@ static void run_command(char *cmdname, char *home)
 	if (start_dbus) {
 		create_dbus_system_conf();
 		dbus_pid = start_dbus_daemon();
-		daemon_pid = start_bluetooth_daemon(home);
-	} else {
+	} else
 		dbus_pid = -1;
+
+	if (start_daemon)
+		daemon_pid = start_bluetooth_daemon(home);
+	else
 		daemon_pid = -1;
-	}
 
 	if (start_monitor)
 		monitor_pid = start_btmon(home);
@@ -874,6 +878,12 @@ static void run_tests(void)
 		start_dbus = true;
 	}
 
+	ptr = strstr(cmdline, "TESTDAEMON=1");
+	if (ptr) {
+		printf("bluetoothd requested\n");
+		start_daemon = true;
+	}
+
 	ptr = strstr(cmdline, "TESTMONITOR=1");
 	if (ptr) {
 		printf("Monitor requested\n");
@@ -904,7 +914,8 @@ static void usage(void)
 	printf("\ttest-runner [options] [--] <command> [args]\n");
 	printf("Options:\n"
 		"\t-a, --auto             Find tests and run them\n"
-		"\t-d, --dbus             Start D-Bus daemon\n"
+		"\t-b, --dbus             Start D-Bus daemon\n"
+		"\t-d, --daemon           Start bluetoothd\n"
 		"\t-m, --monitor          Start btmon\n"
 		"\t-l, --emulator         Start btvirt\n"
 		"\t-u, --unix [path]      Provide serial device\n"
@@ -916,8 +927,9 @@ static void usage(void)
 static const struct option main_options[] = {
 	{ "all",     no_argument,       NULL, 'a' },
 	{ "auto",    no_argument,       NULL, 'a' },
+	{ "dbus",    no_argument,       NULL, 'b' },
 	{ "unix",    no_argument,       NULL, 'u' },
-	{ "dbus",    no_argument,       NULL, 'd' },
+	{ "daemon",  no_argument,       NULL, 'd' },
 	{ "emulator", no_argument,      NULL, 'l' },
 	{ "monitor", no_argument,       NULL, 'm' },
 	{ "qemu",    required_argument, NULL, 'q' },
@@ -941,7 +953,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "audlmq:k:vh", main_options,
+		opt = getopt_long(argc, argv, "aubdlmq:k:vh", main_options,
 								NULL);
 		if (opt < 0)
 			break;
@@ -953,8 +965,12 @@ int main(int argc, char *argv[])
 		case 'u':
 			num_devs = 1;
 			break;
+		case 'b':
+			start_dbus = true;
+			break;
 		case 'd':
 			start_dbus = true;
+			start_daemon = true;
 			break;
 		case 'l':
 			start_emulator = true;
-- 
2.35.1

