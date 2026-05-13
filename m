Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7784CA287
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689070; cv=pass; b=MBhGRgK0d0+dtr4S1K88rq5J2UQtQAGa5TAwFoPT9tQjARZoyNglA1LBJYEj0myqL1VyDrTnSPrqHZ5Deqq1m8347nMLotFdxM8p1Vm2jvs3SnCYIbLXY+FV99cJ478Q9W9kxVSntSic+07+Kg0LsLc6HSSONViiH9VNh/uPKfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689070; c=relaxed/simple;
	bh=r8vhe6TJzV2iFgZE4/ALec9B9lFn/qooMLcTLsffhV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uwb1rQmz1/v3kY7+vq1js5M6ugTat6SY0ZlcgLOpBuiV3WSdLTmNQj2XZTwWvFE1kCXVj79B0TLRFean0vXCocyOuZltBvoMyXoRF/DeD32EKZVyKO57ufioo6jgKs02u9kPQamYWMUv1rt1G3D66lQ/3AFACgeUaRmubEqA8Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=huJYkDEl; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="huJYkDEl"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gFzBq2l5Lz10Th;
	Wed, 13 May 2026 19:17:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778689059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0JMVZc6OPnkkDRh0OCQ8uUU3qN0ud7vnxHqHvfq7mo=;
	b=huJYkDElDpW8ZoE3yQcW+9p0HldlT3qtgD9v1ylMBTILVrlcLurQXzZn9ItgTCYxe9TQdz
	sQBWos6rAONvVABz3QJWOJEQakTiAwasmkRx34/bNgisKay62GUI/VBs/Ka8/lABGyAwaW
	MTnyjITua1Jf4WMkJf2apn0q0tFSWrQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778689059;
	b=O0sz29LvCuucqjIIWlPod2W+WsYE91MQA51xDbqff6e9G7gm+5vjhuH/j2et9Gb/XtF1TM
	3TTiNrU4QdpU5QGdi/D09GGnPqIZupnyA19ACyIyE5ihqDM7Xj9mIYPApOWp5UJ2A8EJvr
	Rn3C8zbEZKj43RDEh6QTc4GF0qFjqlo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778689059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0JMVZc6OPnkkDRh0OCQ8uUU3qN0ud7vnxHqHvfq7mo=;
	b=fAlsdbK5/E1MHNxfgEZTvd3qB/SPRPQHRRvvVekM/dnbn5tLxoCykxvkJv59MR6eC8uH+1
	MNfYKhMyyITgOLMjN9gSwSxU2lx6m1nDGGrPxjXZ4TQcIUB62ifBI0ypACaeM2ntn8uDft
	v5aJV+xOSXwWHQ7SBPSUvc6EaBSznVY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 07/16] test-runner: allow source tree root for -k
Date: Wed, 13 May 2026 19:17:24 +0300
Message-ID: <391ce2cd9d3130d055e5d141fb6589ca7c6569f9.1778688966.git.pav@iki.fi>
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

Allow passing source tree root for -k option, look up kernel below it.
---
 tools/test-runner.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 3de3a9d74..b3e0b0cfe 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -93,18 +93,31 @@ static const char *kernel_table[] = {
 	NULL
 };
 
-static const char *find_kernel(void)
+static bool find_kernel(const char *root, char path[PATH_MAX])
 {
+	struct stat st;
 	int i;
 
-	for (i = 0; kernel_table[i]; i++) {
-		struct stat st;
-
-		if (!stat(kernel_table[i], &st))
-			return kernel_table[i];
+	if (root) {
+		snprintf(path, PATH_MAX, "%s", root);
+		if (stat(path, &st))
+			return false;
+		if (!(st.st_mode & S_IFDIR))
+			return true;
 	}
 
-	return NULL;
+	for (i = 0; kernel_table[i]; i++) {
+		if (root)
+			snprintf(path, PATH_MAX, "%s/%s", root,
+						kernel_table[i]);
+		else
+			snprintf(path, PATH_MAX, "%s",
+						kernel_table[i]);
+		if (!stat(path, &st))
+			return true;
+	}
+
+	return false;
 }
 
 static const struct {
@@ -1209,7 +1222,7 @@ static void usage(void)
 		"\t-U, --usb <qemu_args>  Provide USB device\n"
 		"\t-q, --qemu <path>      QEMU binary\n"
 		"\t-H, --qemu-host-cpu    Use host CPU (requires KVM support)\n"
-		"\t-k, --kernel <image>   Kernel image (bzImage)\n"
+		"\t-k, --kernel <image>   Kernel bzImage or source tree path\n"
 		"\t-o, --option <opt>     Additional argument passed to QEMU\n"
 		"\t-h, --help             Show help options\n");
 }
@@ -1236,6 +1249,8 @@ static const struct option main_options[] = {
 
 int main(int argc, char *argv[])
 {
+	char kernel_path[PATH_MAX];
+
 	if (getpid() == 1 && getppid() == 0) {
 		prepare_sandbox();
 		run_tests();
@@ -1335,14 +1350,13 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (!kernel_image) {
-		kernel_image = find_kernel();
-		if (!kernel_image) {
-			fprintf(stderr, "No default kernel image found\n");
-			return EXIT_FAILURE;
-		}
+	if (!find_kernel(kernel_image, kernel_path)) {
+		fprintf(stderr, "No kernel image found\n");
+		return EXIT_FAILURE;
 	}
 
+	kernel_image = kernel_path;
+
 	printf("Using QEMU binary %s\n", qemu_binary);
 	printf("Using kernel image %s\n", kernel_image);
 
-- 
2.54.0

