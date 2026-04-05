Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276FC342509
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775392820; cv=pass; b=lvqQa+0JpUMyMJHq797f8aOpsO4Mh19jSUiEHDDMVc3E8SCSBA/TPmoi3ZaLkwojsMNv7s7KgXYOYRzTm5tD1O+AjCwQ8+MPMHK5BY6X3g0i0Egn5sNQASgy/hTFhJNTQ1HlLNtLOxt/bXrqMuuSJZCcVdeBYT1/eSfAY9vt+SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775392820; c=relaxed/simple;
	bh=E567MtBI0RdYQ34tB0yKkB4MN1QjaVlYGumkTKtDSVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEibT9KcNDEbwyJEEE9xcKVw9yYhhhJo7GTPLyVS2hdMdL3OM+tOsAmWeTIfyeg5ZVFfaHwll+kdni/u67ZJF547j/Eu1R+qTeIF+7q79IDx5LI9bJQEYIZZZQVpRk8n6ZCJeRb3S5VJdk5NytxmC48F3g8BvVxggfolEkl/IwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Pt+uOclp; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Pt+uOclp"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fpX9P1vW2zyxN;
	Sun, 05 Apr 2026 15:40:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775392809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwEG6L7ld3n0mgFOQNK8DUyjTtA8udcuK5PSfRe9GiY=;
	b=Pt+uOclpMx8Z4HDQCNCNenZFrixyHfPjREbHMGb4luFtTq/81YPAbkTv2+RrWymrxHKse2
	rXyzW5maTbsX3s7kerI5hORM5HgMdCTCfgUjzBhNKR8B2z+hHN97+8yj9o9kDfCXEfJ0bC
	qlC1zmMnz0ibd25+c8L8H+7QUJ4uCio=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775392809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwEG6L7ld3n0mgFOQNK8DUyjTtA8udcuK5PSfRe9GiY=;
	b=XpK86PjGCzDjc4LOX5w19jYRZ0uAHdPxhZrdJHu94EkpuKsBHqZ3m7OS8eqrxNmZbtSD4v
	AqkSYlcY/HR1KhnoALgg/1PTAonaTXDRLZvStj9oQxyPCatc8FBwyXjHSC7HALo1JG2u7H
	RjgwzxBxDhCiX4sceKmZuWk+fmXfys8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775392809;
	b=QW3BWihBcfIhJuZ7XpWaoc1rW5e9sDdG0zkhBhyCQs+VT4c+aA+EteLbKF0YlBeJ0boXCj
	IhG0ONunx43ZFW3l0L7r34TV4ZIeKce+O9qdfkqk8XR2Td/3oln4fY3p90zp++WKftOe0V
	+xTStlVc5UhwkwfP6ul5LofXN8QmCSA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 06/20] test-runner: Add -o/--option option
Date: Sun,  5 Apr 2026 15:39:47 +0300
Message-ID: <fcfff3832b074aea74011e4b5b78e985132629da.1775392680.git.pav@iki.fi>
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

