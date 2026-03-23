Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9575940DFC4
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2026 00:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774226957; cv=none; b=RzxjUpiMAxIAk7tCYe84m+urXnoLTnBz8x63FH6CCkGXnsV8LL52BfotFR7fqEeEwK2NviUa3ygT/kd6vXsAM23KEZ2RWZ9MQIypE+lSYKs+dXjneuk2fc+gmrtignoEw6oka+PK7rFiPfphon8qq3q6F5s7OCHglG2RO3mrVrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774226957; c=relaxed/simple;
	bh=m6Mp/zQBtC59FOEAUD24D73cM7zRTH9fSkDDh3irz3k=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=FTwK2SJ+2du87Yd/IKNdk57W0theSh6LMWDeY3nnHoU/PWO6ciJOXAu1ijROBoZv+K7HXif45CIK9NeLy9cOk7JysHGIHOMNyg/RstfKDe1nxHn8K1d8i0arJ/YICAkRkCN71GZHD8QMKHAIKfok4q5vtoFY3It+33/lVKX0BDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kQAlnzJt; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kQAlnzJt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774226944; bh=gtbcrZGJc+eq+n9NRdpxnBnEd3VCm0yKO7qdvBt4E/w=;
	h=From:To:Cc:Subject:Date;
	b=kQAlnzJty6uZ6RkUAC1pkx6EU6bZRywVo4diitBKdkB6aw9v0Xj6DdpImbChl+6XP
	 hhRMV14l4nswtmSUHN+LAh6duG5CLlETHQ/h4pyT2qd9YEo5XsXSozU2m+WgbA1K8M
	 rUnL9Y3vPpH3+FyOr354LbhlUWL179GU85Dpcolg=
Received: from max ([116.7.234.240])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id C3307223; Mon, 23 Mar 2026 08:48:51 +0800
X-QQ-mid: xmsmtpt1774226931t983yegdl
Message-ID: <tencent_855A3D40BA68914559569DE8F0A84AC00C09@qq.com>
X-QQ-XMAILINFO: NT7uTz3cNku2I2U42wUWedoScMgaxFyZCE7tW+zvKni6wrN4U4rFcze08Tqa1Z
	 N1QTldONXUfKOV/Peqoh7iGW6b9VK1g/H8RVKPVABBqaPpE7CnC02wbghX2cA2Rsv/Al6aq0L5wT
	 saN7imuW1MVJrcnwqRj/CeBvd0F562yAgnNC6HlIIvg5zRbl2YI/DuvjWe/+Qlhxp0e4LmfxdmUa
	 RhGNZ8rjSFzXYnGsVhcZtNPPRD5ptP6Z3nx4XX2q2Qc14k3JmgN6xa5pn/RhkutUaLgymlAO3Nr+
	 m5O5PcJwHV8fWfd9jXQ9BqEkNbNQq2CzMzuAUMaSE7SQo10etFm0RhKMYqF5eqGeocGN4Gk1RKhj
	 mwu2XEkc0SUKjM7LlluoXHlbM55I2XIDx+CggjyqCT+yJo93Y6oX9X7GeRT5CAmv5ABnT+uqloak
	 qt0vkbtXJkUOk7xAmL2WpovRsdXX/kq1+qDmSa+aVXPLEUTEEbkujuZJU8KYeaXVy40nsVVNZWjQ
	 jKUFHmD7l9fo7+PNhy7O2AMf/Mt5BBYfxc2LMqO3eiiRFhFnj/Om+MU0QZKyzycU69GBFssu4l4f
	 7plfFnRD+CQQFyUPpynpyt93P58IASUbBoH1RjXmljCjn3s643FNW8rtiNzHFkT81TKOqkgNLbMe
	 bYsdNUGtP2xvUve12T5aQbCrW618XvwcPOuRj0QAcK7z4vfxt2JM22+R2XWnu4hTSB5aiHQi8S8J
	 nb8iqR2Ec3ZNj6AkRWuLg+6Zl5E/5DzDibSeXDG1hnaAyy0SkURDcScMjby00/QBLNu1DL7GWvpm
	 R/7ep4Hkw6w8YxUDRnhEDF4ox0p2uyvTz623tUTkFzlvBI/GjAQ+sAv4f+hN+SEEJqOZkWJvhxf3
	 31B/hF3ygzDS4d9Re0IvmoNcyCtdTzkAq8Jqosd9605IJebD1urx3fCINehOuwQRfIGTjxD3wRm9
	 9QsB+TanyzW+gMNZyVRMcVanvTxOZnPRO8KEdOw2T4URjegjguIPySg8dsHLNIbinfSmUDODWmti
	 8lt2SUgRCwUETEm0Re/feDFra9G1g=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: maxing <2965346066@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: maxing <2965346066@qq.com>
Subject: [PATCH] obexd/bip: Fix uninitialized memory and malformed XML in GetImage request
Date: Mon, 23 Mar 2026 08:48:48 +0800
X-OQ-MSGID: <20260323004848.113540-1-2965346066@qq.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit addresses several defects in the AVRCP BIP GetImage
implementation that caused strict OBEX servers (e.g., Android)
to reject image transfers with "Precondition Failed (0x4C)".

1. Fix uninitialized memory read:
   In `get_image()`, the `maxsize` variable was not initialized. If the
   client omitted the "maxsize" key in the D-Bus dictionary, `maxsize`
   retained garbage data from the stack, leading to anomalous log entries.

2. Fix malformed XML image descriptor:
   When D-Bus clients omitted the `pixel` or `encoding` parameters,
   `parse_get_image_dict()` improperly forced them to empty strings ("").
   This resulted in `get_image()` generating an invalid XML tag:
   `<image encoding="" pixel=""/>`.
   The XML construction logic has been rewritten to dynamically append
   only the provided attributes, and the previously parsed but ignored
   `maxsize` attribute is now properly included if specified.

3. Fix D-Bus iterator advancement:
   Removed a redundant D-Bus type check in `parse_get_image_dict()`
   where the iterator was evaluated twice before calling
   `dbus_message_iter_next()`.

Signed-off-by: maxing <2965346066@qq.com>
---
 obexd/client/bip.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/obexd/client/bip.c b/obexd/client/bip.c
index ec75fdd67..7c724b4b4 100644
--- a/obexd/client/bip.c
+++ b/obexd/client/bip.c
@@ -38,9 +38,6 @@
 
 #define EOL_CHARS "\n"
 #define IMG_DESC_BEGIN "<image-descriptor version=\"1.0\">" EOL_CHARS
-#define IMG_BEGIN "<image encoding=\"%s\" pixel=\"%s\""
-#define IMG_TRANSFORM " transformation=\"%s\""
-#define IMG_END "/>" EOL_CHARS
 #define IMG_DESC_END "</image-descriptor>" EOL_CHARS
 
 static DBusConnection *conn;
@@ -206,9 +203,9 @@ static gboolean parse_get_image_dict(DBusMessage *msg, char **path,
 		goto failed;
 	dbus_message_iter_get_basic(&iter, path);
 	*path = g_strdup(*path);
+	dbus_message_iter_next(&iter);
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
 		goto failed;
-	dbus_message_iter_next(&iter);
 	dbus_message_iter_get_basic(&iter, handle);
 	*handle = g_strdup(*handle);
 	dbus_message_iter_next(&iter);
@@ -258,13 +255,11 @@ static gboolean parse_get_image_dict(DBusMessage *msg, char **path,
 		dbus_message_iter_next(&array);
 	}
 
-	if (*pixel == NULL)
-		*pixel = strdup("");
-	if (*encoding == NULL)
-		*encoding = strdup("");
-
-	DBG("pixel: '%s' encoding: '%s' maxsize: '%lu' transform: '%s'",
-			*pixel, *encoding, *maxsize, *transform
+	DBG("pixel: '%s' encoding: '%s' maxsize: '%llu' transform: '%s'",
+			*pixel ? *pixel : "",
+			*encoding ? *encoding : "",
+			(unsigned long long)*maxsize,
+			*transform ? *transform : ""
 	);
 
 	return TRUE;
@@ -283,7 +278,7 @@ static DBusMessage *get_image(DBusConnection *connection,
 	struct bip_avrcp_data *bip_avrcp = user_data;
 	char *handle = NULL, *image_path = NULL, *transform = NULL,
 		*encoding = NULL, *pixel = NULL;
-	uint64_t maxsize;
+	uint64_t maxsize = 0;
 	struct obc_transfer *transfer;
 	GObexHeader *header;
 	DBusMessage *reply = NULL;
@@ -310,10 +305,16 @@ static DBusMessage *get_image(DBusConnection *connection,
 	obc_transfer_add_header(transfer, header);
 
 	descriptor = g_string_new(IMG_DESC_BEGIN);
-	g_string_append_printf(descriptor, IMG_BEGIN, encoding, pixel);
+	g_string_append(descriptor, "<image");
+	if (encoding != NULL)
+		g_string_append_printf(descriptor, " encoding=\"%s\"", encoding);
+	if (pixel != NULL)
+		g_string_append_printf(descriptor, " pixel=\"%s\"", pixel);
+	if (maxsize > 0)
+		g_string_append_printf(descriptor, " maxsize=\"%llu\"", (unsigned long long)maxsize);
 	if (transform != NULL)
-		g_string_append_printf(descriptor, IMG_TRANSFORM, transform);
-	g_string_append(descriptor, IMG_END);
+		g_string_append_printf(descriptor, " transformation=\"%s\"", transform);
+	g_string_append(descriptor, "/>" EOL_CHARS);
 	descriptor = g_string_append(descriptor, IMG_DESC_END);
 	header = g_obex_header_new_bytes(IMG_DESC_TAG, descriptor->str,
 						descriptor->len);
-- 
2.51.0

