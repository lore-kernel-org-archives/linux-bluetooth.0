Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4653137F723
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215024; cv=pass; b=fGk63h+NVkqYdmgl88Xx+TYnFJ14cSCMeMYj056nHq1Uht6XKrEjsB/o9245nLeJIUvQZHRZFE9IJmNs95TN8R/ukz7naR6RVW76axarTciud6S3LbmhCyR9zwjgxPOIRDVLWFRwdBWpi7/72GNw7S2TyMhZnpS2W8AjEwEpjBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215024; c=relaxed/simple;
	bh=KhaSn9U5TGNyM+Rr8VCAz2p32L0L3SC5h66L6yHEF+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zkvaiyau74S4zn/5uBmoHXOsga6pXGAiwLGz2C3Kec1qlae00cOL0v4LftVjEN8jntsVMDK1jHZRH5mx4v6m5wbJu5YXOJR5bKSW8YAQ39W+nz+X+Cug8dEJ2TTqVX6xzLSRA1cnOUBtQcGUhrIXASQrPIdOemxxfWehLoLYkfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=oXt6aqxA; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="oXt6aqxA"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ff8bV0lzfz108f;
	Sun, 22 Mar 2026 23:30:14 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774215014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7PZwaLAn4Iw/yOWnWFmExpfeiYQBFi5jccS8/IX2Qk=;
	b=oXt6aqxAlKxQbEvjSrkNZGATD0VKAQCY59CifngcUkaZAg9q12HYN9T0ojfp+SN3wQ3gsa
	ZbNRocBcRNz184J9p0vjLGTcUmlGlBNyZBsFkLsZDGN5fMDKOS4GncA1yq7jUUdp0j0Rcx
	4TWewGshAjobusgcz3xQLfNn4uhJ2Go=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774215014;
	b=PTzO+980RVMPTZu1kQUbVFYQOu0go6skcHvH5OqCIUJQ9tFIdG0mJZXLxcQsTqVqdwCl+F
	nyrTTdRUa6cK5khoXBJtaSc5iz6ky7HjEWQSPFYPIxlG//aPe1J2u/WFPJQnuyRZsfWvEa
	NhrBMz5tYK/7TjCkVqpeOJDXgErz0wY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774215014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7PZwaLAn4Iw/yOWnWFmExpfeiYQBFi5jccS8/IX2Qk=;
	b=nwFSQi8ZmoI2aOgFWHTzXWVfozXv7co1PuEz5c5EDlZFGTZCG20XBGuPH9Te1B9YWIo3Na
	6ezlBf7i76Zf5vhr0LaG60mPs5Egw2z1zYqGvBTRU86tydkFDpkS+/gq78ajl3RGfHKODH
	/ebgyF03enVb47AoNgOs1l6Yf45M76I=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 07/20] test-runner: allow source tree root for -k
Date: Sun, 22 Mar 2026 23:29:56 +0200
Message-ID: <0320656cafa97329c7f48b9d36b311d2c8b391be.1774214693.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774214693.git.pav@iki.fi>
References: <cover.1774214693.git.pav@iki.fi>
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

