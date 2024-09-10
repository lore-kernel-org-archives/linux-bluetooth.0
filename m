Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D715F19FA65
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983108; cv=none; b=JWEdEMFgfLC9y11nOrMhIed/APHu9PPNxhp3t8FCKu1W2yC6cc4wOcLPIfYTOmBIp5joFbV0QvI1fyt7mNJaYc1c01xmvzxpzuCRyloxqgBRZjUw0VdVOoAqxPysOY8lvm0fw17IHsK2WMLac7GzCGbuX5VYN80+VgNEDkgwI3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983108; c=relaxed/simple;
	bh=h5QnbJFt6JyVo/Z3Tdx9/LN3v9JHoBIMFDBke1FGyVw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=piTSDNnBgAwNXsG9zZJCF60RD9gUJhcSgvxQUajvUt6PrnhvId44x1ofSl38lquJZO367d/CbQzArWC3GwXBWKhmxJqe3m2zQAR83XKnsi/TTmP0wOLOy29sMSpU4aJbbsEE9/CLiH7t4pd5XayMu67jHdb3uPezXFl2LZ2zntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TV7jINmZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TV7jINmZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725983104;
	bh=h5QnbJFt6JyVo/Z3Tdx9/LN3v9JHoBIMFDBke1FGyVw=;
	h=From:To:Subject:Date:From;
	b=TV7jINmZqhqECYxefvR2BjyVCnV/Q1jpGBoB8mjkmBZpCX68KPcdJOZ58xv4OQLk9
	 LwBrgAZCNO28lo3XNPBm6+Nkq2CKr+s889A1RJlh4EE/mFh75kdIEsRVxY2zXaPy3a
	 XEEEWDWoZmfLZyJL0zW9/aMs4gTrw9yt7xfUFweAi5C+FKeaYueZxb81VttRxUcn7H
	 6DQMW6wkNh8FXZNJl8GFhhtJQFAthzWq5xPpUF2k9qwIKQTCJwqLJrOPJCG8J7KLpk
	 FMD8vz+mRgwPKPQ3edd0nLSH46s8GN15FUciRpxBMX9D0BfLcftJxkLdwtWs6BBUgk
	 eAGNl3MQTuAOw==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AE83517E35CC
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 17:45:04 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4] gobex: Replace g_convert by utf16_to_utf8
Date: Tue, 10 Sep 2024 17:44:50 +0200
Message-Id: <20240910154450.164911-1-frederic.danis@collabora.com>
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
v3 -> v4: Fix memory allocation size

 gobex/gobex-header.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
index 002ba8861..f368f0e22 100644
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
+	buf = alloca(sizeof(gunichar2) * (utf16_len + 1));
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

