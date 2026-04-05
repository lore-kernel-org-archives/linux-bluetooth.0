Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2767C341ACA
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775392819; cv=pass; b=W4PEYTEQGZQZFVhAmMn2tDe7unPeukJC4KmUQX83k0klfhjj/dFXc2E0k8eW0zjdQCpE9vGLJBPL04AFgwkvc4COUWYbASNEz/Q+juGN7cb3wR1nDKkGLMZsnj7m8zQzJaAooBezuzZMGpKjf8uyF/1tud2TcDex6iFqUDpIyQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775392819; c=relaxed/simple;
	bh=KhaSn9U5TGNyM+Rr8VCAz2p32L0L3SC5h66L6yHEF+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTLIaiyQ9reRwcz1P2NoPK5yZBXwp/2d7POHXxH70kGGuthy56eR34yuCuOs9/mmGrEVV7na34CDqWZfctVyy6bX7B+8nlSqmEHEoUKDgApWE6mfIbDofouwOEDwlw3/YqFQxN35JOFoShNJFf0atx7G8MiekUzVCWpfdN1hcLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=yUZwD0Zt; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="yUZwD0Zt"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fpX9P57NSz1051;
	Sun, 05 Apr 2026 15:40:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775392809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7PZwaLAn4Iw/yOWnWFmExpfeiYQBFi5jccS8/IX2Qk=;
	b=yUZwD0Zt88TienQ+xAKGSgybgggNhiE9KzAf1RDuDyPVI+oHba7CCxd8sEeUklelkbEQBg
	XOOBxeUykOJo38ppGr/oUYash+uwPB6+sZsaBL2HhJzhbFtVeUeWooD1VRZvnB8YpjG9xt
	KcahFukn2zp2agMQ0+bP4El8mqnqkp4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775392809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7PZwaLAn4Iw/yOWnWFmExpfeiYQBFi5jccS8/IX2Qk=;
	b=oOd8Ei52K7PL8sUR5olHlCvnL3q6WKKBK8euBrnnZO547ay6/9qLjJEUJmviCwAa5++U0A
	y1qQabqH5ZSPkk5285WryytrpZEZBuhKZ4SzDnPYTXO4KoxcJXLkodEXlauj1L+5GPdTaq
	vPctkAgFPSg+/KGAWxLcNKnU7aEjqz8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775392809;
	b=rQuPzMuj2xHiPgpmifVBB4uzuafagTYWON4XJ60Q7mrLRnMYoyZmgYibT+V2egElWJCvTw
	nyU6A04aF5qVgkcKUZUEYIhsTU3oM5ikpb4UF1VXsrzg9h1J6qot2HJxu8lwg9L1mbcTLN
	7T2o2QmXtuHetgIpFQPvuhGxIvhaVIw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 07/20] test-runner: allow source tree root for -k
Date: Sun,  5 Apr 2026 15:39:48 +0300
Message-ID: <aa3ea74febd4bb8117168f66ad1714b9782bfc4d.1775392680.git.pav@iki.fi>
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
2.53.0

