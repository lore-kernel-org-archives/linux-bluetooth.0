Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710E815574F
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Sep 2024 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388707; cv=none; b=aq1ph1jCn3t0D7w1FeQt5moeba9yW76wZySz19XOiesDg//H2mt487pQn8YpNT9zhpW4vrtzXav0bRFeKiBnJsx4psG1mesxIarzsywg5f0KhudYqK2y/vWDJWkkDTFFn+rtNZhXWZhWafcTyvh6iPq5PVBOMkeaTtAV8vzGUHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388707; c=relaxed/simple;
	bh=j5C5Alu4DSE+v664/7R5D9NGIIqfVVuW4VHnqZihLes=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=d2UuM/CloUk9uOF5629oMsbQX3dPwJOWpPSr4BhZOlSl37EFVkgFIgu+phBLC/55mZMJmZ7n8A1rrxl4QDbgmKpJ5+aF3KyQuFHmQ9tpuQylH2Pb9/P+TxZ9Q6F1dhGT+GTddQ0GRNBwR1DsO9gDakE15fFQAszYVQUfBqi8e2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HxBE+cUJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HxBE+cUJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725388703;
	bh=j5C5Alu4DSE+v664/7R5D9NGIIqfVVuW4VHnqZihLes=;
	h=From:To:Subject:Date:From;
	b=HxBE+cUJAlYd1OAwtrS6d+woUPKYzJuUslnF8WGsyn4QYMrQf+QWKUyKs+hOWMlwm
	 zMdrHM9aX+65QQGQaRqz4/BtENaePSfbaImToNxShkNrYiUs9em8D30RJj3YclEiJv
	 TowREzgwqpvE1jugoErbP7QNgvJw85cJDHCJCkSZf643ErpsqgE6hue5oB1osSqPLx
	 z4z1Mct2EOtr/rPd8zYSIEYl+XDDHaI2mWipBhSpUEcBJEQX4S7qxTADqa8zKmlJ5B
	 I/gLAixUPpOA9ureKFHZKbSpRCktfLuPyjm/Uyps5s+pT/QJm/E+MUmlRy9fazlvfd
	 qvqlS6CJ2O0Cw==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5594317E121A
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Sep 2024 20:38:23 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] gobex: Replace g_convert by utf16_to_utf8
Date: Tue,  3 Sep 2024 20:38:17 +0200
Message-Id: <20240903183817.155842-1-frederic.danis@collabora.com>
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
v1 -> v2: Fix missing g_free

 gobex/gobex-header.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
index 002ba8861..a6cabdf41 100644
--- a/gobex/gobex-header.c
+++ b/gobex/gobex-header.c
@@ -62,6 +62,34 @@ static glong utf8_to_utf16(gunichar2 **utf16, const char *utf8) {
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
+		utf8_len = -1;
+
+	g_free(buf);
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

