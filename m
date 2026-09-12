Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A5639FCC5
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789237119; cv=pass; b=CFFhCKxd/IkUVUCMzfR8rlvNDPvOBxWCaxyJYBs3Ypsiqk6vgIuuOcLovLLrShmAmOuyRstAz2UUN+v7I4p1IKJ5X5YED0CwXGo7rkqezsNMFI763h0cBRXeZY+m7zzvpUF4N/OGXa0XPvDAbAZB9Ac+hNbc+048I8YUGi8GlQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789237119; c=relaxed/simple;
	bh=P/7qPOwrEGdxpfDaKID6ZQWzuGYpPELVlfnj+FaGR4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjWrsBHHyXen07Zb0gQ/Zl+QTvvjXiyRJuugufGeWugJWVZGTnafEkh5ngqE3Zd7YHtz68c8+Y2E/dSZKdCEUJz7WsnnVlG2sxqk7cfglP+pY18D3vGDZLeSDPqlzBr16aDU/I0lJyCi4po2/if6TI54/q0i7huVCNGRkTNtwik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=TlwrO04W; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="TlwrO04W"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:5:f011:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hj05z2Y9Kzyc2;
	Sat, 12 Sep 2026 21:18:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789237111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TOGVID9yamXz/zV9SkXklXAmCGUjJOyAEyByoPIunf0=;
	b=TlwrO04WPAuNUkxaUtiFnnUgYYcKH+8E/XOpjJjFOD2ewdSguIcOkEKWQjj4VOA6IYaHtA
	/NqPETVbS2A+BYS4T+TpcBhzul4JSdyhQzyp4HpSfze9DFi2dQ7btq64OWgHVv++uY+ofY
	kBRF6t22DZ/S3KU56jlYH7vjaUoflpw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789237111;
	b=ftykdv2qm0UGOaapFLAWemIZS4nIkxWiVH6w9PuMweHJDG7UwHOnU9L+Hyz+jzBt7HDUFt
	MHTjLG4MiLrJlakG0yjYcyCdS9iGrs49vLF8OOzfRqhA0cid3Ax/MCnuCJAsfaXkCdd03H
	+pV8QYkBCZhUeCy5HerKXMYFoGmsUtY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789237111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TOGVID9yamXz/zV9SkXklXAmCGUjJOyAEyByoPIunf0=;
	b=fzAdLCE5fziJm7mf6G4nz1RXns5qMJK8i+mTLlDQhiogZ2FsGq5rBdh5h2iDkoMitlco8S
	/gZ/+I5C0LrzT/XBx3of0ixGcUpGnyJicJjG2Gt/rsFYHgzzwy22qzqsYnIeZYMteYGndp
	C3NOfySUHJPkBm+av+HuE+5axs7SFHg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/4] tools/test-runner: replace alloca() based argv setup
Date: Sat, 12 Sep 2026 21:18:20 +0300
Message-ID: <4800bff58cfc252d23884e711ac3cd709fcd32db.1789237077.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789237077.git.pav@iki.fi>
References: <cover.1789237077.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite alloca() based argv array construction that required manual size
counting with vasprintf string array. This allows splitting start_qemu()
to multiple functions.
---
 tools/test-runner.c | 132 +++++++++++++++++++++++++++++---------------
 1 file changed, 89 insertions(+), 43 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 63fedece0..a0ac321ca 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -21,6 +21,7 @@
 #include <stdbool.h>
 #include <signal.h>
 #include <string.h>
+#include <stdarg.h>
 #include <getopt.h>
 #include <poll.h>
 #include <dirent.h>
@@ -41,6 +42,10 @@
 #define WAIT_ANY (-1)
 #endif
 
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+#define _cleanup_(f) __attribute__((cleanup(f)))
+
 #define CMDLINE_MAX (2048 * 10)
 #define EXTRA_OPT_MAX 64
 
@@ -65,6 +70,58 @@ static char *pcie_dev;
 static char *extra_opts[EXTRA_OPT_MAX];
 static int num_extra_opts;
 
+struct strv {
+	char **strv;
+	size_t size;
+	size_t i;
+};
+
+#define STRV_ERROR(s) ((s).size == 0)
+
+static void __attribute__((format(printf, 2, 3)))
+strv_append(struct strv *s, const char *fmt, ...)
+{
+	va_list ap;
+	int ret;
+
+	if (s->size == 0 || s->i >= s->size - 1)
+		goto fail;
+
+	va_start(ap, fmt);
+	ret = vasprintf(&s->strv[s->i], fmt, ap);
+	va_end(ap);
+
+	if (ret < 0) {
+		perror("vasprintf");
+		s->strv[s->i] = NULL;
+		goto fail;
+	}
+
+	s->strv[++s->i] = NULL;
+	return;
+
+fail:
+	s->size = 0;
+}
+
+static void strv_concat(struct strv *s, const char *const *str)
+{
+	while (*str) {
+		strv_append(s, "%s", *str);
+		str++;
+	}
+}
+
+static void strv_cleanup(struct strv *s)
+{
+	size_t i;
+
+	for (i = 0; i < s->i; ++i)
+		free(s->strv[i]);
+
+	memset(s, 0, sizeof(*s));
+}
+
 static const char *qemu_table[] = {
 	"qemu-system-x86_64",
 	"qemu-system-i386",
@@ -225,8 +282,7 @@ static void prepare_sandbox(void)
 	enable_printk();
 }
 
-static char *const qemu_argv[] = {
-	"",
+static const char *const qemu_argv[] = {
 	"-nodefaults",
 	"-no-user-config",
 	"-monitor", "none",
@@ -510,7 +566,9 @@ static int start_qemu(void)
 {
 	char cwd[PATH_MAX/2], initcmd[PATH_MAX], testargs[PATH_MAX];
 	char cmdline[CMDLINE_MAX];
-	char **argv;
+	char *argv_strv[EXTRA_OPT_MAX + 64];
+	struct strv _cleanup_(strv_cleanup) argv = { argv_strv,
+							ARRAY_SIZE(argv_strv) };
 	int i, pos, status = 0;
 	pid_t pid;
 
@@ -533,7 +591,7 @@ static int start_qemu(void)
 		if (n < 0 || n >= len) {
 			fprintf(stderr, "Buffer overflow detected in "
 					"testargs\n");
-			exit(EXIT_FAILURE);
+			return EXIT_FAILURE;
 		}
 
 		pos += n;
@@ -558,66 +616,54 @@ static int start_qemu(void)
 				run_auto, audio_server ? audio_server : "",
 				testargs);
 
-	argv = alloca(sizeof(qemu_argv) +
-			(sizeof(char *) * (8 + (num_devs * 4))) +
-			(sizeof(char *) * (usb_dev ? 4 : 0)) +
-			(sizeof(char *) * (pcie_dev ? 2 : 0)) +
-			(sizeof(char *) * num_extra_opts));
-	memcpy(argv, qemu_argv, sizeof(qemu_argv));
-
-	pos = (sizeof(qemu_argv) / sizeof(char *)) - 1;
-
 	/* Make sure qemu_binary is not null */
 	if (!qemu_binary) {
 		fprintf(stderr, "No QEMU binary is set\n");
-		exit(1);
+		return EXIT_FAILURE;
 	}
-	argv[0] = (char *) qemu_binary;
+
+	strv_append(&argv, "%s", qemu_binary);
+	strv_concat(&argv, qemu_argv);
 
 	if (qemu_host_cpu) {
-		argv[pos++] = "-cpu";
-		argv[pos++] = "host";
+		strv_append(&argv, "-cpu");
+		strv_append(&argv, "host");
 	}
 
-	argv[pos++] = "-kernel";
-	argv[pos++] = (char *) kernel_image;
-	argv[pos++] = "-append";
-	argv[pos++] = (char *) cmdline;
+	strv_append(&argv, "-kernel");
+	strv_append(&argv, "%s", kernel_image);
+	strv_append(&argv, "-append");
+	strv_append(&argv, "%s", cmdline);
 
 	for (i = 0; i < num_devs; i++) {
-		char *chrdev, *serdev;
-
-		chrdev = alloca(48 + strlen(device_path));
-		sprintf(chrdev, "socket,path=%s,id=bt%d", device_path, i);
-
-		serdev = alloca(64);
-		sprintf(serdev, "virtconsole,chardev=bt%d,name=bt.%d", i, i);
-
-		argv[pos++] = "-chardev";
-		argv[pos++] = chrdev;
-		argv[pos++] = "-device";
-		argv[pos++] = serdev;
+		strv_append(&argv, "-chardev");
+		strv_append(&argv, "socket,path=%s,id=bt%d", device_path, i);
+		strv_append(&argv, "-device");
+		strv_append(&argv, "virtconsole,chardev=bt%d,name=bt.%d", i, i);
 	}
 
 	if (usb_dev) {
-		argv[pos++] = "-device";
-		argv[pos++] = "qemu-xhci";
-		argv[pos++] = "-device";
-		argv[pos++] = usb_dev;
+		strv_append(&argv, "-device");
+		strv_append(&argv, "qemu-xhci");
+		strv_append(&argv, "-device");
+		strv_append(&argv, "%s", usb_dev);
 	}
 
 	if (pcie_dev) {
-		argv[pos++] = "-device";
-		argv[pos++] = pcie_dev;
+		strv_append(&argv, "-device");
+		strv_append(&argv, "%s", pcie_dev);
 	}
 
 	for (i = 0; i < num_extra_opts; ++i)
-		argv[pos++] = extra_opts[i];
+		strv_append(&argv, "%s", extra_opts[i]);
 
-	argv[pos] = NULL;
+	if (STRV_ERROR(argv)) {
+		fprintf(stderr, "Failed to build argument list\n");
+		return EXIT_FAILURE;
+	}
 
 	if (!pcie_dev) {
-		execve(argv[0], argv, qemu_envp);
+		execve(argv.strv[0], argv.strv, qemu_envp);
 		return EXIT_FAILURE;
 	}
 
@@ -635,7 +681,7 @@ static int start_qemu(void)
 	}
 
 	if (pid == 0) {
-		execve(argv[0], argv, qemu_envp);
+		execve(argv.strv[0], argv.strv, qemu_envp);
 		exit(EXIT_FAILURE);
 	}
 
-- 
2.55.0

