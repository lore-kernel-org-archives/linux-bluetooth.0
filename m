Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2009D2749ED
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775392820; cv=pass; b=diI1uwubIklSFdz0nEOeU6TGnFkUuEkqcUDN+0FAceRXqLjvid7BAQwnJkiRpSBDZUCMMF8XSULQxjxh+2f0zbEwRFlMSDlp+RYzmfkf0AeSRVx+oKrK3prSi+z6JDRE1jt20A8+EQEqw67uN22Lz8twsEqYQ2VYs3sZs42zTjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775392820; c=relaxed/simple;
	bh=4EUAJFGAegZTFs7cTJV5RbJnvtQK4nqICV0SMwzagEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAymkMnt1t1eZ/v5elMr9VP/GgKPaE5RhAp1y5JZ6BYJpLHjDIFxQgeFpIGzAPwy4LgqkwOGsrhnR0x39bT8ir21023KajwSsBv/Yxxg8JcxqkZwVPCmddgxcjIGFoxyaKDwKLuv3Ic/hJqk1lU1JOlG3va8QEqcx52JPSgxgC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=u4d65ILO; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="u4d65ILO"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fpX9N5Q1SzyxX;
	Sun, 05 Apr 2026 15:40:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775392809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuog9+yrxqrBlDzyk9tYQIPO1PT4sbv1PC5ZIrZ5WAg=;
	b=u4d65ILOz+xLawK96i5T7fjcIR+v7BvmHvgznATxc3M583+sCqX3VXHZoZ50GBVfEFjjjT
	FEZyKvwOip89Pn4Vwieqg3e6uQKqyk0nR23C5t2HTAOYT5urMhDO32CFIIXxy9G/C2/D6b
	C13agH7p422Xy79Me0/0TDkfcswcEC8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775392809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuog9+yrxqrBlDzyk9tYQIPO1PT4sbv1PC5ZIrZ5WAg=;
	b=c/bPNAZTCOLSfIfiYxpoqt5D9bjYuENez0InOF9IM3BtyysA+EdriEbQhn30OE5m5PCOr/
	+oD8HShvMb2qhJqlyJ/WFLYsdwjnHTwdQxRVfvM+iSZvFs7XeLAQ1iPB25DMUB5VBhOiQ1
	5YzM8XRiJ9oiwtjtay7MXEMZad8azAU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775392809;
	b=oHPk22/Avv7/X5i41sCHRbZNWkgi/+FQ55NZE+FmV+B1CxS1pGRQIivkAvA/dQ6C0f8chO
	DVI5nR0O0yiW7QkuolVV+QatXovjCPjoS4K51dxhBdQUG28+9KF4CLJ9PVCcHhcHeG61IY
	UjYwyxbaDFX9/0Hq7nETx/NnvI7i1kg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 05/20] test-runner: enable path argument for --unix
Date: Sun,  5 Apr 2026 15:39:46 +0300
Message-ID: <e2245b5846cdbef9a4f6930ebff4933f35ed1faa.1775392680.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775392680.git.pav@iki.fi>
References: <cover.1775392680.git.pav@iki.fi>
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

