Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9564C175568
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958929; cv=none; b=i7dZRBDmOtVPCPzgoo/WyjJveo7HRor77OVtgAFdJisrzeRKNXsaVySoQbSbCmxwizqI/eoX0uf+CHuw9O/0rw68PPO2Us2RPTMOQOMNXJz9jj6FGZGaUMgIl75NiNHZSAQ+0JHNf5Cg5UvLlC2NN6mvqO/tLQrBBGppC44dYOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958929; c=relaxed/simple;
	bh=CF5uaSjCw5wgb8xectFEiFmyD2N5TMC4f40USPzj5Is=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DhPf/HqATTy9ypQBVRdg7LCpRyc2sJCGbFdhDE7tdAkcJTQcdCHlxWbHHNEC0XqFYCxUTy16TMu3MFlube3QMpKLsmJas79SaZvyAanC13qHJbe6r+YXVKNK/i8iGsayg/kjGHULMIzIn3w8+qCMKI2MSwdBgvcth1FSUIf0TGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XwZq137b; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XwZq137b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725958925;
	bh=CF5uaSjCw5wgb8xectFEiFmyD2N5TMC4f40USPzj5Is=;
	h=From:To:Subject:Date:From;
	b=XwZq137bdINBQ1XIkOGInwLSljzagXsi+6TwOzi4QpQ+C9IUVYm6idJkSgiPW9CI5
	 hSSzSx+x+Io1Oogfla+boJR8Y5PyTjFlWSAiylYh+9nbslC3Xf3mGbsOOS6usk1OLe
	 tl3HYZs50NzYxGEO/248r0fXiXqdURymlMU1AAoaQeO3jjXi8KwnNaK4K3Jvf+w6LH
	 d9eEd/bs9ZZ+Dg+bUcM/bp3EKEGbvffZfpADddyHFone6T6hNXQkXCs4I9KFjI4Cz2
	 dA2VacFcOAhGh9pKJ5ocqn6yyK0pfS5Vw6WCUY513ZW36Vf3STd0Q6G9YJrQif2GDC
	 TZ9umJjj/tQrQ==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B300E17E0FC8
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 11:02:05 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3] gobex: Replace g_convert by utf16_to_utf8
Date: Tue, 10 Sep 2024 11:02:01 +0200
Message-Id: <20240910090201.115557-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The glibc's iconv implementation is based around plug in modules
for specific translations which may not been built on the platform
and prevent to use g_convert().
This commit replaces it by a function similar to the existing
utf8_to_utf16() function.
---
v1 -> v2: Fix missing g_free
v2 -> v3: Replace g_malloc0 by alloca
          Fix UTF-16 buffer size allocation
          Ensure that UTF-16 buffer is terminated by '\0'

 gobex/gobex-header.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
index 002ba8861..889c794df 100644
--- a/gobex/gobex-header.c
+++ b/gobex/gobex-header.c
@@ -62,6 +62,34 @@ static glong utf8_to_utf16(gunichar2 **utf16, const char *utf8) {
 	return utf16_len;
 }
 
+static glong utf16_to_utf8(char **utf8, const gunichar2 *utf16, guint16 len,
+				GError **err)
+{
+	glong utf8_len;
+	guint16 utf16_len, i;
+	gunichar2 *buf;
+
+	if (*utf16 == '\0') {
+		*utf8 = NULL;
+		return 0;
+	}
+
+	/* OBEX requires network byteorder (big endian) UTF-16
+	 * but g_utf16_to_utf8 expects host-byteorder UTF-8
+	 */
+	utf16_len = len / sizeof(gunichar2);
+	buf = alloca(sizeof(gunichar2) * utf16_len);
+	for (i = 0; i < utf16_len; i++)
+		(buf)[i] = g_ntohs(utf16[i]);
+	buf[utf16_len] = '\0';
+
+	*utf8 = g_utf16_to_utf8(buf, -1, NULL, &utf8_len, err);
+	if (*utf8 == NULL)
+		utf8_len = -1;
+
+	return utf8_len;
+}
+
 static guint8 *put_bytes(guint8 *to, const void *from, gsize count)
 {
 	memcpy(to, from, count);
@@ -130,7 +158,7 @@ GObexHeader *g_obex_header_decode(const void *data, gsize len,
 	GObexHeader *header;
 	const guint8 *ptr = data;
 	guint16 hdr_len;
-	gsize str_len;
+	glong str_len;
 	GError *conv_err = NULL;
 
 	if (len < 2) {
@@ -177,13 +205,14 @@ GObexHeader *g_obex_header_decode(const void *data, gsize len,
 			goto failed;
 		}
 
-		header->v.string = g_convert((const char *) ptr, hdr_len - 5,
-						"UTF-8", "UTF-16BE",
-						NULL, &str_len, &conv_err);
-		if (header->v.string == NULL) {
+		str_len = utf16_to_utf8(&header->v.string,
+					(const gunichar2 *) ptr,
+					hdr_len - 5,
+					&conv_err);
+		if (str_len < 0) {
 			g_set_error(err, G_OBEX_ERROR,
 					G_OBEX_ERROR_PARSE_ERROR,
-					"Unicode conversion failed: %s",
+					"UTF16 to UTF8 conversion failed: %s",
 					conv_err->message);
 			g_error_free(conv_err);
 			goto failed;
-- 
2.34.1

