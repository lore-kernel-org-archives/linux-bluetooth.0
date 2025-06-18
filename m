Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C743085D5
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750273891; cv=none; b=oi5An/T8dwbQzGisBsVnNzXI88EEjxE9dIwJi/r0tj0EgMNivWc2NwYak3nYzu/pmUJLZSGGBh/gW4Pv66Jj769y/KE9/18hNQFHNpuO+MjcT4UN2QIdx5uO06Xmxr6LfJaVbQY9ElGxQ+UERjaM+K5sSIMxO4c4f3xzEQkKq7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750273891; c=relaxed/simple;
	bh=heP0bdooXF2RPqUTfOwgUygYyrvZfXMmhb1Ubh20x8k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=meP8rasROJUc37u6sPXXLqstXMcgA8LOhyHOWQt956A+MJLnSaqy/oS6LHjURnDqfD/LsiswyS2QqxCbT2m9PL/Nu4nsc0mwHGAmPmOF2t1GDPCdcXwZslV7te5Ly4qlO9PYILdwWvYFTshhlERK21Q8xab0J8KKEjO29rE4ptI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyN44sin; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyN44sin"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86d587dbc15so640050241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 12:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750273888; x=1750878688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+IBy1E1OhQsIOybdc2QQ8aBtyL32UxNvj4l6rw+QEzw=;
        b=VyN44sinOLsub4lubfgxrgtCGt5f2hVYZf3iqz0nM7d4nPCW/MCqR7/n0yrLWAg4fD
         IvHAzx4BzN+vbPPiC0G+3V8OBgiY8QyurX3JnjvCQAS+s0XONO6FJ9uk8E+0c+X8TVQF
         qrdRdDcC2q5muS7EL1YfbwY+2IjYLlQHsi/8vLrWSlT9BvHBUqMSB/DcN3K0r5UtZnW/
         MBToUS/P4PLrtiZl9F4KLKnKjCFStiCRpLQ9BXHyu5zXnxyuVuZG2p5En00ZmS2JMFJb
         +1Dak/Ozhi8csAMGlH61xGp2hafV/rVK+/hKmJcL0fvpduSLvctBvgaReTYVbCu8evXa
         aYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750273888; x=1750878688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IBy1E1OhQsIOybdc2QQ8aBtyL32UxNvj4l6rw+QEzw=;
        b=Syy3N+R+b5TnxApNJXoiHUG4EY9k+VuBoHHY0/zk4rUvsEVPoIGe2YxOcRCnJ7j3Ib
         Su7sQB5EBGno3I8v7XWnX1Pkmy9DQWKdc7zpI0p0VgADk/3PpuPikeszqGMo+jNPGumQ
         UtHHOBwzceyNC4nEbNeJC01g4J9eSlUcmVqxdl3PpIJWw4dMXkAy2fw71Nzwuae7V0gD
         nWbjNnoLUijFbDyVZUUz+L5CZbRZ6CT6BYk7Tn4a38hBJSeGSlqxl4bYiGY6yBJEpAOX
         7cHCYlSlajpY4tzomGrDR2mdU3xJqOVypIALSf7sz6BYYsibPOoJlfMISnDY7J+FwmvZ
         /VEw==
X-Gm-Message-State: AOJu0YzzmIxDREhUICLhZapqUlENY3GeJB1ZYqXUO6DNJvEh9DuY727C
	qT7WE6EKK1l4uVKrjb3p1yfaI+8vMLfXhlNG/9Axr468VFUbc3bV+IuF2LZCJg==
X-Gm-Gg: ASbGncvJG1/Dq664CaH/LMylseBo00l2Z+hoUBOBUU6L/Qh849k43yG7/CoWEQfVTrQ
	5bZBrWfg/ryYqZBYN2yjl4wOTt5RqxUhCseVx46eQwZvxTR0w2F+L19zac/AHud4Uf4ZvNvK9Nb
	dHiReUrMY6W2kQsD9KXFMxdV+EqM7oSD25zQv/4VKEJ0Z2ZH06GlzxYSnwV5kzrOdUBFmZphWMN
	tvRKPXJ+JdDqeIxVvnszbi9pdFt6FCtlziVEk2vkFo1mh7FaN/ZFGAQ07z75Q8UflAu7z3oy/gs
	PVH5GWbb2UPCswp4oIpruwVkOTpxFonQU61hOJ1kXjD04SBdFuXFaUIRRbPM8U8qv4WO/af8SKA
	jOKfgyLFHeoK0ApVQbCCKBHbCaOxn5Qk=
X-Google-Smtp-Source: AGHT+IElYgt3crwZeN0cxvEMoiV9M29goLc0VA5R2gOyGILYUH/UuMztzbiu7X0wMK4S8pWIGcIYbw==
X-Received: by 2002:a05:6102:2ad5:b0:4e5:9608:1298 with SMTP id ada2fe7eead31-4e9acee3a6dmr833008137.9.1750273887913;
        Wed, 18 Jun 2025 12:11:27 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e979b63419sm695910137.25.2025.06.18.12.11.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 12:11:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] test-runner: Add -U/--usb option
Date: Wed, 18 Jun 2025 15:11:23 -0400
Message-ID: <20250618191125.3123951-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds option to use a host controller plugged over USB:

> tools/test-runner -U "usb-host,vendorid=0x8087,productid=0x0036"... -- /bin/bash
> dmesg
[    1.046214] usb 1-1: new full-speed USB device number 2 using xhci_hcd
[    1.192623] Bluetooth: hci0: Firmware timestamp 2025.18 buildtype 2 build 82364
[    1.192638] Bluetooth: hci0: Firmware SHA1: 0xa66e016b
[    1.197362] Bluetooth: hci0: Fseq status: Success (0x00)
[    1.197368] Bluetooth: hci0: Fseq executed: 00.00.04.196
[    1.197371] Bluetooth: hci0: Fseq BT Top: 00.00.04.197
> lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 8087:0036 Intel Corp. BE200 Bluetooth
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
---
 tools/test-runner.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 7c9386d2c3d3..ae4e653e3502 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -57,6 +57,7 @@ static int num_devs = 0;
 static const char *qemu_binary = NULL;
 static const char *kernel_image = NULL;
 static char *audio_server;
+static char *usb_dev;
 
 static const char *qemu_table[] = {
 	"qemu-system-x86_64",
@@ -288,7 +289,8 @@ static void start_qemu(void)
 				testargs);
 
 	argv = alloca(sizeof(qemu_argv) +
-				(sizeof(char *) * (6 + (num_devs * 4))));
+			(sizeof(char *) * (6 + (num_devs * 4))) +
+			(sizeof(char *) * (usb_dev ? 4 : 0)));
 	memcpy(argv, qemu_argv, sizeof(qemu_argv));
 
 	pos = (sizeof(qemu_argv) / sizeof(char *)) - 1;
@@ -326,6 +328,13 @@ static void start_qemu(void)
 		argv[pos++] = serdev;
 	}
 
+	if (usb_dev) {
+		argv[pos++] = "-device";
+		argv[pos++] = "qemu-xhci";
+		argv[pos++] = "-device";
+		argv[pos++] = usb_dev;
+	}
+
 	argv[pos] = NULL;
 
 	execve(argv[0], argv, qemu_envp);
@@ -1183,6 +1192,7 @@ static void usage(void)
 		"\t-l, --emulator         Start btvirt\n"
 		"\t-A, --audio[=path]     Start audio server\n"
 		"\t-u, --unix [path]      Provide serial device\n"
+		"\t-U, --usb [qemu_args]  Provide USB device\n"
 		"\t-q, --qemu <path>      QEMU binary\n"
 		"\t-H, --qemu-host-cpu    Use host CPU (requires KVM support)\n"
 		"\t-k, --kernel <image>   Kernel image (bzImage)\n"
@@ -1202,6 +1212,7 @@ static const struct option main_options[] = {
 	{ "qemu-host-cpu", no_argument, NULL, 'H' },
 	{ "kernel",  required_argument, NULL, 'k' },
 	{ "audio",   optional_argument, NULL, 'A' },
+	{ "usb",     required_argument, NULL, 'U' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
 	{ }
@@ -1221,8 +1232,8 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "aubdslmq:Hk:A::vh", main_options,
-								NULL);
+		opt = getopt_long(argc, argv, "aubdslmq:Hk:A::U:vh",
+						main_options, NULL);
 		if (opt < 0)
 			break;
 
@@ -1261,6 +1272,9 @@ int main(int argc, char *argv[])
 		case 'A':
 			audio_server = optarg ? optarg : "/usr/bin/pipewire";
 			break;
+		case 'U':
+			usb_dev = optarg;
+			break;
 		case 'v':
 			printf("%s\n", VERSION);
 			return EXIT_SUCCESS;
-- 
2.49.0

