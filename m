Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273F368970
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041081; cv=pass; b=VMZRCp62/qehi0bOditduJLqwq2cwceuPqDi0GyBeVAqXSNBPWX9xbqOPXgspMCVnw1sbr4AgiUSOl+3yO7Asy/TOF8zweuHipJRUlINwB4NI2xspYpm6xum/SIlDMs5e4dMATW+r0ZJrZMM2AiBPFLANJPw1wb8B5BJuZzqx8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041081; c=relaxed/simple;
	bh=4EUAJFGAegZTFs7cTJV5RbJnvtQK4nqICV0SMwzagEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIg6Gjr6Mfdc4Z7yxkPf8oV+PeTqBTvI7dreVKYnf09dB58L75O3YaUvNMJvQTt+NUlZYj0RLJgNYa6z8oML/4AhRfQzONOJSQ6/6Hrnt+9gS4LhAnHbpsJzUS7tXKLBBGp8uNzPdQgZGSiA/qKNtCVLzYBLhdd2qs7awZpnop4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=c9L3Zcn3; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="c9L3Zcn3"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fcwGS66rjzyyZ;
	Fri, 20 Mar 2026 23:11:12 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774041073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuog9+yrxqrBlDzyk9tYQIPO1PT4sbv1PC5ZIrZ5WAg=;
	b=c9L3Zcn38hQImCHxDbKgyh0kbncl0LxpN4yM0+x81JWGUvud6bvIKe9HbGuP4FaiSfXb3o
	X1wXqKlcsoEN0CN6GmT7VPind/I7TRN8wLbBYZhWzOpcG+axzL/uxBjAIbNyqbtf3TqDgm
	VxnDijARZDSPGM5iIOW+KwwOJsx5DuQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774041073;
	b=eBmXc2KEFv3FslYe8jNeUJpV6MKl8EzxRjY3ytmEVbODzhDd2mKHBtzSkRonp5iV752CeQ
	jFfjcv5cohxX+Aa4gLhmP5K9yu6h63URc0byAj2XXwoC0GwZ+pEkQj+bcsD10EhrDfdtBZ
	5uB4qRSjE7/aN68WnrHqYO9eFnN/Vns=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774041073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuog9+yrxqrBlDzyk9tYQIPO1PT4sbv1PC5ZIrZ5WAg=;
	b=bjk568xuhVUMZxUA0J0Zg81y3qxU1mosF4poEDtP+b6aahV/hKVJWwVS3f6Q4AKV9rWjQ2
	OX3d2KV4R34g6LA3oU+uRizI9yP5Lv0ph6OPGNQbcXiSjRtt4r2FkVBfTesvtbX8bQxElQ
	6FG+RVPchNE6S2HRN7Sz7kvuGCoVgxU=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 05/20] test-runner: enable path argument for --unix
Date: Fri, 20 Mar 2026 23:10:49 +0200
Message-ID: <9e4b64253908418e3607ee0a207eff737a7ff40e.1774041047.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774041047.git.pav@iki.fi>
References: <cover.1774041047.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow specifying the path for the controller socket to be used.
---
 tools/test-runner.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 48b7c1589..331cb6eb1 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -54,6 +54,7 @@ static bool start_monitor = false;
 static bool qemu_host_cpu = false;
 static int num_devs = 0;
 static int num_emulator = 0;
+static const char *device_path = "/tmp/bt-server-bredr";
 static const char *qemu_binary = NULL;
 static const char *kernel_image = NULL;
 static char *audio_server;
@@ -313,11 +314,10 @@ static void start_qemu(void)
 	argv[pos++] = (char *) cmdline;
 
 	for (i = 0; i < num_devs; i++) {
-		const char *path = "/tmp/bt-server-bredr";
 		char *chrdev, *serdev;
 
-		chrdev = alloca(48 + strlen(path));
-		sprintf(chrdev, "socket,path=%s,id=bt%d", path, i);
+		chrdev = alloca(48 + strlen(device_path));
+		sprintf(chrdev, "socket,path=%s,id=bt%d", device_path, i);
 
 		serdev = alloca(48);
 		sprintf(serdev, "pci-serial,chardev=bt%d", i);
@@ -1198,7 +1198,7 @@ static void usage(void)
 		"\t-m, --monitor          Start btmon\n"
 		"\t-l, --emulator[=num]   Start btvirt\n"
 		"\t-A, --audio[=path]     Start audio server\n"
-		"\t-u, --unix [path]      Provide serial device\n"
+		"\t-u, --unix[=path]      Provide serial device\n"
 		"\t-U, --usb [qemu_args]  Provide USB device\n"
 		"\t-q, --qemu <path>      QEMU binary\n"
 		"\t-H, --qemu-host-cpu    Use host CPU (requires KVM support)\n"
@@ -1211,7 +1211,7 @@ static const struct option main_options[] = {
 	{ "auto",    no_argument,       NULL, 'a' },
 	{ "dbus",    no_argument,       NULL, 'b' },
 	{ "dbus-session", no_argument,  NULL, 's' },
-	{ "unix",    no_argument,       NULL, 'u' },
+	{ "unix",    optional_argument, NULL, 'u' },
 	{ "daemon",  no_argument,       NULL, 'd' },
 	{ "emulator", no_argument,      NULL, 'l' },
 	{ "monitor", no_argument,       NULL, 'm' },
@@ -1239,7 +1239,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "aubdsl::mq:Hk:A::U:vh",
+		opt = getopt_long(argc, argv, "au::bdsl::mq:Hk:A::U:vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -1250,6 +1250,8 @@ int main(int argc, char *argv[])
 			break;
 		case 'u':
 			num_devs = 1;
+			if (optarg)
+				device_path = optarg;
 			break;
 		case 'b':
 			start_dbus = true;
-- 
2.53.0

