Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078F0189B88
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Sep 2024 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379885; cv=none; b=GESF1gghZjSAsIaiOYZUBGO5grBx5y/+RezQ69OqKHV64pWuAULEZD4texclP1EyFGZKoPx9jtbpCsDE6aVNQhf2aDYgsAfKOyN1uHuJ+bvF8eDd+7JnD2QxeuSHbqEgtuY1YC8A0eEIxoDwEE4GXG/UOZL8h/kO0ojHN/2GL9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379885; c=relaxed/simple;
	bh=HXrEr9CPzyQKLrsx2MUDTkIitXsm+A95AU6VvFB3XzY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iwEQK6piPRAHsY4thaOxl8350zsJEmxMI5ovh32qY7gztNmxQSH9c+iKh8rY0BPCqxKMtDXL2R6+YY61NkXANeQrAzdifpscyOrUX4TK+wkL8NYpSyOyjO0ouMRC6LG2zJkbrLVjgrxnfs7zbLU1BjbWOrp2F5xNDONb45MhxjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FQHKVDhL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FQHKVDhL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725379881;
	bh=HXrEr9CPzyQKLrsx2MUDTkIitXsm+A95AU6VvFB3XzY=;
	h=From:To:Subject:Date:From;
	b=FQHKVDhLEF8bA/j2fvnOu3Ox+mAq6aCR3wssr37C5ohFxqU/GQbryNeMMJx17sDNj
	 2fzg7THURAtFwIojw5qKMMrOvxLNU012KytG9iprilNvF43VA3r1etzqWt40FMr1ib
	 hY0XaV2MVBihOoWdhjslLisnpj4OWua5kcPFhdicr0YL3dPd1ZLiyo5KQhEP6hFbgG
	 A7BnEWoV3Tj2Ye/6HUnoRDv7lZlRC3h6TW7L9ChKMIctJN66bPk4bq9LYP4PkG34ix
	 zvyB3MYHvd9h8ECApQnuLWFTnh7AXOb6A160q4Dp8vLBZleM/RpGTF7eWduTL2da3g
	 XwjyQ/hYuh5AA==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 03A2B17E10CD
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Sep 2024 18:11:20 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gobex: Replace g_convert by utf16_to_utf8
Date: Tue,  3 Sep 2024 18:11:15 +0200
Message-Id: <20240903161115.143632-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

g_lib may be built without the gconv modules for UTF-16, which
prevent to use g_convert().
This commit replaces it by a function similar to the existing
utf8_to_utf16() function.
---
 gobex/gobex-header.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
index 002ba8861..b43374da6 100644
--- a/gobex/gobex-header.c
+++ b/gobex/gobex-header.c
@@ -62,6 +62,32 @@ static glong utf8_to_utf16(gunichar2 **utf16, const char *utf8) {
 	return utf16_len;
 }
 
+static glong utf16_to_utf8(char **utf8, const gunichar2 *utf16, glong len,
+				GError **err)
+{
+	glong utf8_len;
+	int i;
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
+	buf = g_malloc0(sizeof(gunichar2) * len);
+	for (i = 0; i < len; i++)
+		(buf)[i] = g_ntohs(utf16[i]);
+
+	*utf8 = g_utf16_to_utf8(buf, -1, NULL, &utf8_len, err);
+	if (*utf8 == NULL)
+		return -1;
+
+	return utf8_len;
+}
+
 static guint8 *put_bytes(guint8 *to, const void *from, gsize count)
 {
 	memcpy(to, from, count);
@@ -130,7 +156,7 @@ GObexHeader *g_obex_header_decode(const void *data, gsize len,
 	GObexHeader *header;
 	const guint8 *ptr = data;
 	guint16 hdr_len;
-	gsize str_len;
+	glong str_len;
 	GError *conv_err = NULL;
 
 	if (len < 2) {
@@ -177,13 +203,14 @@ GObexHeader *g_obex_header_decode(const void *data, gsize len,
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

