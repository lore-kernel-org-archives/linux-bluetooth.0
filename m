Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1442B43637A
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772283103; cv=pass; b=mjru2YH5qowDY19mebJ1mxdy7YTfrABhFszs9TuYII77HlGA93OftS2tqizetJb28FR1EMN7epWdsUkDoDZCdHzmZPU74Z2BniSZjcrqqxCoZTW6r+Gh3Hlr6TGcUiOkyB5CzRLoTBU4xzCFQZqTNMmXdlkV1OXiTyFAz12SjRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772283103; c=relaxed/simple;
	bh=4EUAJFGAegZTFs7cTJV5RbJnvtQK4nqICV0SMwzagEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYGMllD/MZ9mUyKjeVQxq9PvDnSt4Ck0iVe/oTxYoQXyZwLdVkwX9rlNieXc/fUYslOQxNZbJOq33PXUSOz+fNxTeHEbsxMDxORjt6v5WGX9esAlGEZ7En2zXBRRiUwEg1hoJvCjVqZPNc5OIYX/x9yMBDjC63nMFPo+un/Zl+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=nCMFHLgj; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=sRMjwWZf; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="nCMFHLgj";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="sRMjwWZf"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4fNQ765KYRz49Q4J
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 14:51:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1772283090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuog9+yrxqrBlDzyk9tYQIPO1PT4sbv1PC5ZIrZ5WAg=;
	b=nCMFHLgjOobjcgVSchzMD/USFnHHBxVeqPnu4SnZ7rXusRS2AiOURhjZTihDwd8YlnAZ9A
	YR3BjTNf6YEQ4Rrh7kPuXCBIt2oUJe7nlUjgUF9D5M1ZBgMEdJxIiFEonbkIBc+jsgKNRs
	Uggqqvy9q7l8d2skgOhivXTvY+0fU64ghcy2sVAnxaZnzcNicV9D8wUfR36mzm44Os7/aC
	g2AxvWy/nsK9ZP/0fuuzKVhKwytY5sIm2fltWf7sdpX6yHc8RZRllIEo08Z7MxnvwVF+Tx
	ERc4GLt2jrVrI4d4myvXpvkBm1QvyxoczxUJoFid4Ygl5kz75yFEBmp7MP4t6w==
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fNQ6y73tMzyvg;
	Sat, 28 Feb 2026 14:51:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1772283083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuog9+yrxqrBlDzyk9tYQIPO1PT4sbv1PC5ZIrZ5WAg=;
	b=sRMjwWZfgATQ/MjHIGkDT1xGslOtLkBWxhnLkd4SkcoQSEJbMCmPu2xNVez7eIPvs8MUhY
	tL1keoISStsd21i1q7j0LGpotSznkfdP5q+JKJn9oR5B9TCp2gJ3oIvUBBS96vLk/O5N9b
	8Gd5csQboxdxPf9lIJ6F6y5x0VQY5yg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1772283083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuog9+yrxqrBlDzyk9tYQIPO1PT4sbv1PC5ZIrZ5WAg=;
	b=Aj+apxAVEai5QcgkDHJXH/KNCZAty8FHYpCPQDcbef8Y2bsB0vnNnZ3ykRtzlE3iGejs5F
	F5Sgn2Gv/T0mQ4NPT8LimvMKzlXuObLTyKiG+iH3WwVmdodANfATFu20xPCiT4X2Ewz7+c
	ziVH5C7Ue+93rBn9/i34Hbq17lkNqd0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1772283083;
	b=dJ3i+xw5HPIoSplVozckNVuE9mXBSaONKQ73e8p6U+5Bo5rsWylE+bqfu7mCi6Lb5WbJv4
	OE0mntSHnOxKLfb1C7xheiBrqPEfirNJkWhPBqGCSnMqzJ2Jfs/+6yHG15v44AD0SibkrZ
	stm09thJ53cQTxeCrqxHoFO8KT4yHYA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 03/11] test-runner: enable path argument for --unix
Date: Sat, 28 Feb 2026 14:51:09 +0200
Message-ID: <923f34ad2eeec121f8700e430f6d7ed3feb54604.1772282574.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772282574.git.pav@iki.fi>
References: <cover.1772282574.git.pav@iki.fi>
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

