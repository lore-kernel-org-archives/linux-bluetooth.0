Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1457C438FEB
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772283103; cv=pass; b=vDe3AAs9mf3hF5Vxc6U3c0wtSPs7UEBeiAqAJtj1HdECUiWmtP8zU2OLGnNq71Vl3POYhOtJfQVFsuq33yKcTM2A6N9R8P9SxxdoLHyar3Y0xuI5uk7ucxrJy0oCdJzm+FzHPHhZlTPyrlhhlT0v58MTLAwgi0T3rmGzWzF4Y6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772283103; c=relaxed/simple;
	bh=E567MtBI0RdYQ34tB0yKkB4MN1QjaVlYGumkTKtDSVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBMdUUZpjSshxiKoFMAcdek/xLJ2ocf3ZAUdo65Vy8R3nB2DWsOUhZJxh5pe9JwUnIVIMEEpoYuDzoHN/maH1SNOkWXnbIHFIbbBLwY6IxaCPnho2ZUFYH4DtuTgB/jOCHIQDARgmXtnBpumuAdIMJ7Gp4+SmQBuH0EaYlZElUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=pZhHlXnC; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vm+xgpHP; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="pZhHlXnC";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vm+xgpHP"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4fNQ765QBXz49Q5n
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 14:51:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1772283090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwEG6L7ld3n0mgFOQNK8DUyjTtA8udcuK5PSfRe9GiY=;
	b=pZhHlXnCDjWfCg/bRwlq5xfmXOP1RejdeHKPqHYKSYCV2PTOLjocGDHdYGsqsfWlbhS2n0
	GZlDo591AR4iILKH0CCw5gaiakRhhmf+iLZ9bei0AT9i5Vr8DfoFz+y25YrDD43DfbFrp/
	2s+aFlto511l8a1yjNj9vSoGhQGG0PEZEss7zdDFvfVuMS6FYAtlUMjHDYQNE0dnB0tTEs
	lilJjPM/qOQw811yb4rQ0pjFseeFOG56gtL37OE1mXDhqp4Ajyo8iWUk0sIyopz9u1GSaN
	eE3memgdxmQvzqHiAMF+xeAkFijjAQ6q0TFGdwHyVzynmUHD3bjTer8k0x1OPA==
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fNQ6z2zRyz109f;
	Sat, 28 Feb 2026 14:51:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1772283083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwEG6L7ld3n0mgFOQNK8DUyjTtA8udcuK5PSfRe9GiY=;
	b=vm+xgpHP4KjheetY9FuO6MoNwOMy4td9XdoL6ta4VCqOUqhBCfsE20uXWNeoTNxnrvLsER
	pDC0cvxcTyH6BBr23FT458zeRLYOQA3BHdpYvkkz4VCNBfi0qzlgybtEi8wfDzdvrGu2nc
	E8kAJ0P7oidiTTJEVjXDzONvd1UDKQc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1772283083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwEG6L7ld3n0mgFOQNK8DUyjTtA8udcuK5PSfRe9GiY=;
	b=ItAfHYjijKxt4FOutKuYRQNhmPoczX3lSzOgHR/Y7fJG78gM8QuIXItUZ7hF01mWmY47Kc
	zxlkL+T0hmdVPb/Ou1u3Oej55hGaI3y3sIyExh3kssgyFJiiLMroNFvmu5v3TFWjDsFgia
	NiRvg1c59N7QSJrtkRFBT3LovhWGIrk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1772283083;
	b=w0EV7UstPHoRUolz3Bgc7Yd9EGAhoTCA2iGZbxVLPV1toE5yEWpm8mDajFD65WIk7rPg24
	ZnwztcbWqtOv7wBEXAUVzPf4gClCjRF+P8rwxEyWbbGilRa4v4d4enu9AbKQrCsQsp8CW3
	Zw2iv2NeJ682QqKvPNdG2oX/vxzI43E=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 04/11] test-runner: Add -o/--option option
Date: Sat, 28 Feb 2026 14:51:10 +0200
Message-ID: <17a465421effa917abebb84c09fc7b6031cab1db.1772282574.git.pav@iki.fi>
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
2.53.0

