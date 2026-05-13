Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F484CA27D
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689070; cv=pass; b=a+gEowRAh2UzVYs6MvkLAHZs7ZIB+0cr2xxthprlbJBlHWPjQ6IhyXsDmVdapMBWV8I0fBenL7uNij7lrP2eugs7w0yr2WrdCe5UOUz06p+MvsbDcppOfOF1uh/wCxv3o/Q5n0MQOffbbFmyvyQvHqqHlBlDWte0VCgyG4mcfZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689070; c=relaxed/simple;
	bh=BNMZdIC+oBscYS4hS3XvR+PobB8tC4t+1xVqXPpg82o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZoeuK6IoXnGH/byH/79Iw03+yq8VQsxLIcopMQJ+gLKMRhFMcIvEIZwCcbqX1crQuBmIpW3/dYxwFFWKQNjkSQ4ULFMvKWO34gKWYpHoXCWYz8F6MQRNGBuFvsm7OPwVicR91dwjz+i5qtkisCKxBiSyzBpFg4pGW8Lqjm6znM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=jNlPMB3s; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="jNlPMB3s"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gFzBq0S5Pz10TD;
	Wed, 13 May 2026 19:17:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778689059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbEh1/3DGkkJSNaxmVSX8Q+jsxVYKcJ2w/OJNjhkhu0=;
	b=jNlPMB3seTQJggjhIJyO+5EKrTXV1zXBdtsQ+fa+KPgPyaqGA0mj8dv1ioA03ExNqcHqfH
	oQ1f0KO2ElDVO+r6HJ3von0jsDnx5CBYyIPuuc1pz1pz6gxf4h/ViPg1t1VA7183YfuBC8
	0QlT6OHbzTCK1hIcISr2oGuqYaz1Ekg=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778689059;
	b=VLja518ZCbV+QPh+AEpkGXJXyI3CLtoQhzXdN0G9fvWos0XVzZrGI2m3phbFLnHhuXPhHC
	wbTTH54MFC261wN5Hre8+cSfi5VSAIW5/DxITzQw8qOsu0TrHuFpOi1Im6No2ilXAd7Sme
	Tk1lFdpeEyzGlIHKsK1SW53u1YXah+o=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778689059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbEh1/3DGkkJSNaxmVSX8Q+jsxVYKcJ2w/OJNjhkhu0=;
	b=BihiB0BsJvYHKgU7Wy1e9drtkb5OjN0WJvNulNFX4sUOPWmPywm8a1mvSaBviMQeVlFvOv
	3mLNyIqeGEqj3Dt+oahTxb1tyzGVi22G+itHKQW1rcTCiPoMKmWFpZOZFL4Jl1fLo/aUyK
	acB7Xq0yaeuERgdmCNYz99O0j2jGFWw=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 06/16] test-runner: Add -o/--option option
Date: Wed, 13 May 2026 19:17:23 +0300
Message-ID: <50a85d1e7138097220557440529372b75778dd9f.1778688966.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778688966.git.pav@iki.fi>
References: <cover.1778688966.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow passing arbitrary arguments to QEMU.
---
 tools/test-runner.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 331cb6eb1..3de3a9d74 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -41,6 +41,7 @@
 #endif
 
 #define CMDLINE_MAX (2048 * 10)
+#define EXTRA_OPT_MAX 64
 
 static const char *own_binary;
 static char **test_argv;
@@ -59,6 +60,8 @@ static const char *qemu_binary = NULL;
 static const char *kernel_image = NULL;
 static char *audio_server;
 static char *usb_dev;
+static char *extra_opts[EXTRA_OPT_MAX];
+static int num_extra_opts;
 
 static const char *qemu_table[] = {
 	"qemu-system-x86_64",
@@ -291,7 +294,8 @@ static void start_qemu(void)
 
 	argv = alloca(sizeof(qemu_argv) +
 			(sizeof(char *) * (6 + (num_devs * 4))) +
-			(sizeof(char *) * (usb_dev ? 4 : 0)));
+			(sizeof(char *) * (usb_dev ? 4 : 0)) +
+			(sizeof(char *) * num_extra_opts));
 	memcpy(argv, qemu_argv, sizeof(qemu_argv));
 
 	pos = (sizeof(qemu_argv) / sizeof(char *)) - 1;
@@ -335,6 +339,9 @@ static void start_qemu(void)
 		argv[pos++] = usb_dev;
 	}
 
+	for (i = 0; i < num_extra_opts; ++i)
+		argv[pos++] = extra_opts[i];
+
 	argv[pos] = NULL;
 
 	execve(argv[0], argv, qemu_envp);
@@ -1199,10 +1206,11 @@ static void usage(void)
 		"\t-l, --emulator[=num]   Start btvirt\n"
 		"\t-A, --audio[=path]     Start audio server\n"
 		"\t-u, --unix[=path]      Provide serial device\n"
-		"\t-U, --usb [qemu_args]  Provide USB device\n"
+		"\t-U, --usb <qemu_args>  Provide USB device\n"
 		"\t-q, --qemu <path>      QEMU binary\n"
 		"\t-H, --qemu-host-cpu    Use host CPU (requires KVM support)\n"
 		"\t-k, --kernel <image>   Kernel image (bzImage)\n"
+		"\t-o, --option <opt>     Additional argument passed to QEMU\n"
 		"\t-h, --help             Show help options\n");
 }
 
@@ -1220,6 +1228,7 @@ static const struct option main_options[] = {
 	{ "kernel",  required_argument, NULL, 'k' },
 	{ "audio",   optional_argument, NULL, 'A' },
 	{ "usb",     required_argument, NULL, 'U' },
+	{ "option",  required_argument, NULL, 'o' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
 	{ }
@@ -1239,7 +1248,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "au::bdsl::mq:Hk:A::U:vh",
+		opt = getopt_long(argc, argv, "au::bdsl::mq:Hk:A::U:o:vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -1284,6 +1293,13 @@ int main(int argc, char *argv[])
 		case 'U':
 			usb_dev = optarg;
 			break;
+		case 'o':
+			if (num_extra_opts >= EXTRA_OPT_MAX) {
+				fprintf(stderr, "Too many -o\n");
+				return EXIT_FAILURE;
+			}
+			extra_opts[num_extra_opts++] = optarg;
+			break;
 		case 'v':
 			printf("%s\n", VERSION);
 			return EXIT_SUCCESS;
-- 
2.54.0

