Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26570C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 07:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346865AbiFJH3K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 03:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346864AbiFJH3I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 03:29:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E054F9CC
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 00:29:01 -0700 (PDT)
Received: from localhost.localdomain (67.227.121.78.rev.sfr.net [78.121.227.67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: fdanis)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AB2F56601760
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 08:28:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654846139;
        bh=KnnhcmxHfKqP4ngVzLa2fBVQAmJDkEEflK4I0B2b57Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KbRD9NXtkMbI6kzDCDA+Cy3O2fI7cJ3KsMP5wEbTVuZfRRAErZ5xDZQe4InLAPdak
         fMwHkDifPobvM5jHnFRFLwaRZOch5dVPtzoBtzrWDwq7Mbiq4Muv8zB/0h8sF6lBsK
         gmKVvqJJmhE8Qa8QG0RoTYtqUsZvLj5ke6IRfrMiPQdrZ4pcrpiGYq9T/EYEplgmiI
         /6Up0iZXyKOMxSHHjF0Q7ak+fWv7vhtHHMczEej4+JJRPwFJRvS5NxBK8xH6MRTdah
         y8itpjVEpic/sXDMZcNfEFAK3sVofdcTpcxcwc30SYNGx8qq4XouJ3FHGI88ylBXqZ
         7lNM7gpLLj95g==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] test-runner: Add audio card support
Date:   Fri, 10 Jun 2022 09:28:49 +0200
Message-Id: <20220610072850.16593-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610072850.16593-1-frederic.danis@collabora.com>
References: <20220610072850.16593-1-frederic.danis@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

With this commit audio daemons can detect an audio card with output and
input, allowing to test interaction between BlueZ and the audio daemon.
---
 doc/test-runner.txt |  5 +++++
 tools/test-runner.c | 23 ++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/doc/test-runner.txt b/doc/test-runner.txt
index 683c622a2..019c23188 100644
--- a/doc/test-runner.txt
+++ b/doc/test-runner.txt
@@ -54,6 +54,11 @@ For Bluetooth functionality:
 
 	CONFIG_UHID=y
 
+For Audio functionality:
+	CONFIG_SYSVIPC=y
+	CONFIG_SOUND=y
+	CONFIG_SND=y
+	CONFIG_SND_INTEL8X0=y
 
 These options should be installed as .config in the kernel source directory
 followed by this command.
diff --git a/tools/test-runner.c b/tools/test-runner.c
index 9fc8e7b33..bbbca5b5d 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -54,6 +54,7 @@ static bool start_monitor = false;
 static int num_devs = 0;
 static const char *qemu_binary = NULL;
 static const char *kernel_image = NULL;
+static bool audio_support;
 
 static const char *qemu_table[] = {
 	"qemu-system-x86_64",
@@ -261,6 +262,7 @@ static void start_qemu(void)
 				run_auto, testargs);
 
 	argv = alloca(sizeof(qemu_argv) +
+				(audio_support ? 4 : 0) +
 				(sizeof(char *) * (4 + (num_devs * 4))));
 	memcpy(argv, qemu_argv, sizeof(qemu_argv));
 
@@ -268,6 +270,20 @@ static void start_qemu(void)
 
 	argv[0] = (char *) qemu_binary;
 
+	if (audio_support) {
+		char *xdg_runtime_dir, *audiodev;
+
+		xdg_runtime_dir = getenv("XDG_RUNTIME_DIR");
+		audiodev = alloca(40 + strlen(xdg_runtime_dir));
+		sprintf(audiodev, "id=audio,driver=pa,server=%s/pulse/native",
+				xdg_runtime_dir);
+
+		argv[pos++] = "-audiodev";
+		argv[pos++] = audiodev;
+		argv[pos++] = "-device";
+		argv[pos++] = "AC97,audiodev=audio";
+	}
+
 	argv[pos++] = "-kernel";
 	argv[pos++] = (char *) kernel_image;
 	argv[pos++] = "-append";
@@ -990,6 +1006,7 @@ static void usage(void)
 		"\t-u, --unix [path]      Provide serial device\n"
 		"\t-q, --qemu <path>      QEMU binary\n"
 		"\t-k, --kernel <image>   Kernel image (bzImage)\n"
+		"\t-A, --audio            Add audio support\n"
 		"\t-h, --help             Show help options\n");
 }
 
@@ -1004,6 +1021,7 @@ static const struct option main_options[] = {
 	{ "monitor", no_argument,       NULL, 'm' },
 	{ "qemu",    required_argument, NULL, 'q' },
 	{ "kernel",  required_argument, NULL, 'k' },
+	{ "audio",   no_argument,       NULL, 'A' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
 	{ }
@@ -1023,7 +1041,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "aubdslmq:k:vh", main_options,
+		opt = getopt_long(argc, argv, "aubdslmq:k:Avh", main_options,
 								NULL);
 		if (opt < 0)
 			break;
@@ -1057,6 +1075,9 @@ int main(int argc, char *argv[])
 		case 'k':
 			kernel_image = optarg;
 			break;
+		case 'A':
+			audio_support = true;
+			break;
 		case 'v':
 			printf("%s\n", VERSION);
 			return EXIT_SUCCESS;
-- 
2.25.1

