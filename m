Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC6114B075
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 06:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515570; cv=none; b=kZ2tO88hHJ5krXOkhxUcwVS7qFC+VNU9AkHhylRPl5Cp4UBn+fkpI+Lco6o3iqqGPXiWhBHNe1Tb4IQYcipTAVWOAWUz/bqcywd2IVeafwU9x+OzuRFjsAhPm/wuR863no7V4haYj+mq3iEQSQhbl8vXCMVbSOAOe1V+vzslaR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515570; c=relaxed/simple;
	bh=cWlQ2bTLEWLZWgr6nDCzSlJOhQaXffiueSppou5HIEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kGmo0Ku79uMgiPlTeiVAfh7ZIoNk/OJbUIU2RTDRKeuZ84Zasf25DOt0BZHAOm/KlGfhZeMh4FEKegBaliWLTHpWk7m++htFloO8oOh2Ok8ZcPSOTokbrQ+bduQUmx5CynmpZGHmUrYDHy3cjllKsgL8kNmRvKN7T/W6crXDBm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrTTy1W1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrTTy1W1"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7e9254bb6so260717066b.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 22:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739515566; x=1740120366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/t+gYZcIgTpTRLHEqplHUrAxi09XAP1zEAXNdJn/5cc=;
        b=TrTTy1W1zTDTeMIkjxCLW6mOuPBL+bgnWnioVqND+HBc+7zEQFazxu4VHOKz0YGLOV
         l4yUSvdAhdGtYuU4vO7TehRBd+JgdzVskSoisyX4hTmjOdsLRQRlw6G24GPvuU2OgCR8
         seMUDpYJyHIIxD5Un8ZXiCxBvqrQy2g2id5mWdEMB8aMYQtwor6Zxdxa2mHfv710nDHQ
         rrhATf4JNW9gO1Mik0856sihbdraj0+n+N3rHSTHZHJZh0SPqLgsYqefT844RnYEBDXI
         /xKx9eq+0ijheSejW9LLRN9ecrXM9RLRuFAGbhHoU+GIPdZqc/uhbbTBRKtZElj8ah0y
         KTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739515566; x=1740120366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/t+gYZcIgTpTRLHEqplHUrAxi09XAP1zEAXNdJn/5cc=;
        b=kc/5tRaFkXcKywVtoVIDJvfev18mv7vNCNiPI2pg+Jher8VbF7Lqqym311Gm//RIX+
         mSUtFSfPxpvg1ge4FiUmsTj0l58JmqhqLRZgBdNAqQTA2U3P7DSqCZWmZtZ6OeDuMRmN
         QB/5bu0BCT9VX6pQp13vbj4zgAg9PvhDkdc7szcyPvcvJsZ5TL/7BMIR7+Bio6+Xg+6E
         Vk98IfcEDmGD/rk5PtfSai+pFQQxJ2zXL1s46d4rsV6Q7Vk44MZYclzufSJ/arthUgkO
         836WJzHm2Lcs+DSBYTD7RuME6iUW0gI7Khc1+O9I9ftdRAR2m9nK2KpeZZm23liUYIJH
         aYVw==
X-Gm-Message-State: AOJu0Yzby8yik5KrqZqj7EI1E33IccpJ+2ksRiuNPdkie4KJ3bm2jSsD
	s3GsAA6p+fmFvGbUwT3uQS0xYrNTe+qIT7/1ajoJFNgjUKv5NMH5SN4Nf263
X-Gm-Gg: ASbGnctHZLJMUIfmf1wweJQ+H/L/arktzr0+DfDxRcddEkTkB2GrZ6Cu54svLcfaYRW
	cRpu50uhRmt3A4JZm/XDSn/OYyVPhPD5+fgc2DHkPbb+eodle40OXQAGNs2SZuT97hI9G+/DTdp
	+djU7ARj7Hm0XhNemFW/ukBxdGjUCnVzPPEqmyRa7bzS7Q5R8BnZ6jC0iq2T//8bHHdZ6JpnBnU
	kYz21kv4FAVnBQtslX7wtYWaeLGeRuDWXlMkqIU0utGSJwDNFSaEFqiAIXJZZ2KtIHo4d7/xyQz
	4+ujvw2lSvHuGKBuPd6C9y9sy/MR9k7C712pICoeXA1r0kxUGRC8FXAozX5eGlxImO9RfN8U0+a
	RMret8jvFnDw=
X-Google-Smtp-Source: AGHT+IEfKNACwXKN7dppd0Q75L/zjbdE3jX/R539/f3PCCiG+LSFQNQVsTh07lLW2tcE5yXj4vnBjg==
X-Received: by 2002:a17:907:7285:b0:ab7:9bea:4e04 with SMTP id a640c23a62f3a-ab7f33a3b2emr979203166b.15.1739515564744;
        Thu, 13 Feb 2025 22:46:04 -0800 (PST)
Received: from localhost.localdomain (46.205.193.135.nat.ftth.dynamic.t-mobile.pl. [46.205.193.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53281cfcsm276582666b.79.2025.02.13.22.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 22:46:04 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] test-runner: Allow to use host CPU on demand
Date: Fri, 14 Feb 2025 07:45:27 +0100
Message-Id: <20250214064527.159950-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "-cpu host" option for QEMU can not be enabled by default because
our CI system does not have a support for KVM. In order to allow to run
the test-runner on systems where binaries built on the host are not
compatible with QEMU CPU variant, the "--qemu-host-cpu" option will add
the "-cpu host" to the QEMU command line arguments.
---
 tools/test-runner.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 48e114174..1d770330c 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -52,6 +52,7 @@ static bool start_dbus_session;
 static bool start_daemon = false;
 static bool start_emulator = false;
 static bool start_monitor = false;
+static bool qemu_host_cpu = false;
 static int num_devs = 0;
 static const char *qemu_binary = NULL;
 static const char *kernel_image = NULL;
@@ -211,7 +212,6 @@ static char *const qemu_argv[] = {
 	"-monitor", "none",
 	"-display", "none",
 	"-machine", "type=q35,accel=kvm:tcg",
-	"-cpu", "host",
 	"-m", "256M",
 	"-net", "none",
 	"-no-reboot",
@@ -280,7 +280,7 @@ static void start_qemu(void)
 				testargs);
 
 	argv = alloca(sizeof(qemu_argv) +
-				(sizeof(char *) * (4 + (num_devs * 4))));
+				(sizeof(char *) * (6 + (num_devs * 4))));
 	memcpy(argv, qemu_argv, sizeof(qemu_argv));
 
 	pos = (sizeof(qemu_argv) / sizeof(char *)) - 1;
@@ -292,6 +292,11 @@ static void start_qemu(void)
 	}
 	argv[0] = (char *) qemu_binary;
 
+	if (qemu_host_cpu) {
+		argv[pos++] = "-cpu";
+		argv[pos++] = "host";
+	}
+
 	argv[pos++] = "-kernel";
 	argv[pos++] = (char *) kernel_image;
 	argv[pos++] = "-append";
@@ -1171,6 +1176,7 @@ static void usage(void)
 		"\t-A, --audio[=path]     Start audio server\n"
 		"\t-u, --unix [path]      Provide serial device\n"
 		"\t-q, --qemu <path>      QEMU binary\n"
+		"\t-H, --qemu-host-cpu    Use host CPU (requires KVM support)\n"
 		"\t-k, --kernel <image>   Kernel image (bzImage)\n"
 		"\t-h, --help             Show help options\n");
 }
@@ -1185,6 +1191,7 @@ static const struct option main_options[] = {
 	{ "emulator", no_argument,      NULL, 'l' },
 	{ "monitor", no_argument,       NULL, 'm' },
 	{ "qemu",    required_argument, NULL, 'q' },
+	{ "qemu-host-cpu", no_argument, NULL, 'H' },
 	{ "kernel",  required_argument, NULL, 'k' },
 	{ "audio",   optional_argument, NULL, 'A' },
 	{ "version", no_argument,       NULL, 'v' },
@@ -1206,7 +1213,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "aubdslmq:k:A::vh", main_options,
+		opt = getopt_long(argc, argv, "aubdslmq:Hk:A::vh", main_options,
 								NULL);
 		if (opt < 0)
 			break;
@@ -1237,6 +1244,9 @@ int main(int argc, char *argv[])
 		case 'q':
 			qemu_binary = optarg;
 			break;
+		case 'H':
+			qemu_host_cpu = true;
+			break;
 		case 'k':
 			kernel_image = optarg;
 			break;
-- 
2.39.5

