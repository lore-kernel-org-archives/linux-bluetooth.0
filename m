Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48D848CD61
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285211; cv=none; b=XYQCk+32mVfOeU2mIa+E2wwGkao9RUDHN8tg+cljCbBXTx27Qvhk/yX37mg//LSmyjduE9oftKtHUM8U7dJO6K2YTnq4qS7io8AFmhn7U1X4b27MVmeMyYeiblPglsuHYUGDaMkcdm+8nxFC/t69Oo9s2Rg2AJIOh2jjaYsfNPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285211; c=relaxed/simple;
	bh=M9734yGdUzgSkwKOB5vF5O/qAYexI5eKp4wnH0vut1o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xf3M8pIptBCpWcKz7uZ9iaCLQUtETDZJEZUty6znrqe42h/JL/HelEWUizsQyuBrQ+IRcL5M/bCaVpmmWEaLcO4jGB0H3YZE6+llTs7IqGps5zbOkQGWAk92VXBpbwrZWYxbAFeQWOhjLQtpnTA3Jy0i1QQi9jcaJcJ6sUo1q1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egkRiTKf; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egkRiTKf"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5c671456e25so96741e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788285209; x=1788890009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oUDeBylrGpOCkMt0eNat73mEqw6uTyWKQozDid23cI4=;
        b=egkRiTKfotF/ZtCWpJ+5LjvzTIoqRAD+dYEVMhf4wwashqv4NTVyCFN6+RGXDSJ83F
         wmeHBN952uysLvRnBEcMNRu+n6C/4CDGZUp7naspizS+/GWtCnZxekTb9QDjm5QgAD7z
         ZzHsy4mZb/sdXYWUFn6UpJDTvv3WCoWTP72Wn4PAFS/nsVDeGHJl79b+WyHnJnkk3ZcM
         agGWJ6E5ZG1WjRA+b0nvh/YPwf5HJrTLN3n4Mwt/Q4LZriG/zyEFVo4Y1d9KkCt71dAX
         bxhnqUmLdmN+Svn6ALSeG2XiDQwmhNkfxv6vf0opS+/DJkMsyvTyqdEpX0tZ2IJXaPee
         VQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788285209; x=1788890009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oUDeBylrGpOCkMt0eNat73mEqw6uTyWKQozDid23cI4=;
        b=D+QtGox8auNnpuj22gCGVwZ2PpExELW7WcidYe0HL6HhYKQv7Adj5bKvgyi96qqzcs
         fi5bAoWb9yaCA1PoRi53dt3q9FbcnSujBRwRGPyt9VrsqFKFV7ht/lnWlWoy5P1jl+WE
         WPtCBJdy53ZS/we6J2sErQOH6oiC4vefhoDl5JPcnub7/o+fI0FOwajy3oxMndPmYg69
         7biFs6U8kkb4VPgZjTKl5FYZlF/468JxMvj8ai0b0AxjwBlpNlNsmymtx7PmMKVNMqY/
         T4IrS+dmf68aw86x2gsiva0iBq36qbo+tXGTUdqxc6u17uNCuAc7XgDNOPWQiAFQpqCh
         Jj7A==
X-Gm-Message-State: AFuF++lBPVjK5Bn+9ZJcKpS4WQNlB+ZYhzRRjSrYTbBqfMvaqynsmDfe
	gKcA6BEF3z7YfDM6RPPKq7iSiv0XHySVJ5E0qNAY7CZGjELBauuzxbsAsDmD4jZQ
X-Gm-Gg: AR+sD12BdZJyHYMUBVwwku6zoLH0cCeDYXmqng8i/zTeEJxywRUOZhxmp1LiilOJap3
	xmM9IXhN8pHQZ4bb/Q/84cnEkPoDL8w876kxRgTIxgOvcJJakEeF68Y2ZKOvkfPvOOHf8WsQRBs
	J7WZ5prdq3oX26YpCip/0lx2fx7TrhKei1jiazESSR1cEd+wB5TpGaAdcjcv5820lcRkauz1Nty
	X9NmeNaILyXaU450ir60kRoxpwXP8bjmoEQBlYdkjKK+OvrYLybFgxPcHiTTyNK2Tk9lkiPIYv1
	ItdbyzwRkX2NLouS2jRDi1CU+G1ANXHh7xcl8ssfEVtGu4uqfwd96KL0k9wh2FB/rikvCivWl03
	e4JEpsAZu5zuFX8R2T9CXK5m15QEOs2wh++WTjsGX+ydMtgwusCkk7wt41n51XYJ14XcWIYZtzM
	cSoBIgtblmxn8gUrXVplwT7Do1iquTaH8HHmQZDKTzcELrtjQvX0P2a2tUP59LaZBn7HJRkGk8U
	dz7LfrhKgv+wMehTUl1U52/r/U8QMKV6NgCjB/oHX1LjBOeqKRhd68Ck+pTYG+BmA==
X-Received: by 2002:a05:6122:3a19:b0:5c4:4ec2:971c with SMTP id 71dfb90a1353d-5c7c1e74d93mr2111550e0c.10.1788285208483;
        Tue, 01 Sep 2026 10:53:28 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7cd94646csm254265e0c.18.2026.09.01.10.53.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 10:53:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/5] avrcp: Move response parsers to avrcp-parse.c
Date: Tue,  1 Sep 2026 13:53:14 -0400
Message-ID: <20260901175315.1348621-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901175315.1348621-1-luiz.dentz@gmail.com>
References: <20260901175315.1348621-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The parsing of controller side responses lives in the middle of
avrcp.c, interleaved with the media_player and D-Bus glue that consumes
its results. That makes it unreachable from the unit tests: none of it
can be called without an adapter, a device, a service and a session.

The three preceding fixes were all in this code, and none of them could
be covered by a regression test as a result.

Move the parsing proper to a new avrcp-parse.c, which depends on
nothing but util_iov and log.h:

- avrcp_pull_header() and avrcp_pull_browsing_header()
- avrcp_parse_player_attributes(), which now takes the bound on the
  attribute array from its caller
- avrcp_parse_attribute_list(), which reports each attribute through a
  callback rather than calling media_player_set_metadata() itself
- avrcp_parse_media_name(), avrcp_parse_media_element() and
  avrcp_parse_media_folder(), which fill a plain struct rather than
  creating media items

struct avrcp_header, struct avrcp_browsing_header, NAME_MAX_LEN and the
player attribute ids move to the new header, which avrcp.h now includes
so that its users are unaffected.

The logic is unchanged; avrcp.c keeps the glue as thin wrappers.

Assisted-by: Claude:claude-opus-5 valgrind
---
 Makefile.plugins             |   2 +
 profiles/audio/avrcp-parse.c | 174 +++++++++++++++++++++++++++
 profiles/audio/avrcp-parse.h | 102 ++++++++++++++++
 profiles/audio/avrcp.c       | 221 +++++++----------------------------
 profiles/audio/avrcp.h       |   8 +-
 5 files changed, 322 insertions(+), 185 deletions(-)
 create mode 100644 profiles/audio/avrcp-parse.c
 create mode 100644 profiles/audio/avrcp-parse.h

diff --git a/Makefile.plugins b/Makefile.plugins
index ac667beda847..a73569e555fe 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -37,6 +37,8 @@ builtin_modules += avrcp
 builtin_sources += profiles/audio/control.h profiles/audio/control.c \
 			profiles/audio/avctp.h profiles/audio/avctp.c \
 			profiles/audio/avrcp.h profiles/audio/avrcp.c \
+			profiles/audio/avrcp-parse.h \
+			profiles/audio/avrcp-parse.c \
 			profiles/audio/avrcp-player.c
 endif
 
diff --git a/profiles/audio/avrcp-parse.c b/profiles/audio/avrcp-parse.c
new file mode 100644
index 000000000000..e0c73ec9b03a
--- /dev/null
+++ b/profiles/audio/avrcp-parse.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Intel Corporation
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/uio.h>
+
+#include "src/log.h"
+#include "src/shared/util.h"
+
+#include "avrcp-parse.h"
+
+/*
+ * Pull the AVRCP header out of iov and validate that the parameters length
+ * it declares matches the number of bytes actually received, leaving iov
+ * pointing at the parameters.
+ */
+struct avrcp_header *avrcp_pull_header(struct iovec *iov)
+{
+	struct avrcp_header *pdu;
+
+	pdu = util_iov_pull_mem(iov, sizeof(*pdu));
+	if (!pdu) {
+		error("Invalid AVRCP header");
+		return NULL;
+	}
+
+	if (be16_to_cpu(pdu->params_len) != iov->iov_len) {
+		error("Invalid parameters");
+		return NULL;
+	}
+
+	return pdu;
+}
+
+/*
+ * Same as avrcp_pull_header() but for the browsing channel, which uses a
+ * different header layout.
+ */
+struct avrcp_browsing_header *avrcp_pull_browsing_header(struct iovec *iov)
+{
+	struct avrcp_browsing_header *pdu;
+
+	pdu = util_iov_pull_mem(iov, sizeof(*pdu));
+	if (!pdu) {
+		error("Invalid AVRCP browsing header");
+		return NULL;
+	}
+
+	if (be16_to_cpu(pdu->param_len) != iov->iov_len) {
+		error("Invalid parameters");
+		return NULL;
+	}
+
+	return pdu;
+}
+
+/*
+ * Pull a ListPlayerApplicationSettingAttributes response body out of iov,
+ * skipping the attributes that cannot be queried. At most max attributes are
+ * written to attrs, which is what bounds the write.
+ */
+uint8_t avrcp_parse_player_attributes(struct iovec *iov, uint8_t *attrs,
+							uint8_t max)
+{
+	uint8_t len, count = 0;
+	int i;
+
+	if (!util_iov_pull_u8(iov, &len))
+		return 0;
+
+	len = MIN(len, max);
+
+	for (i = 0; i < len; i++) {
+		uint8_t attr;
+
+		if (!util_iov_pull_u8(iov, &attr))
+			break;
+
+		/* Don't query invalid attributes */
+		if (attr == AVRCP_ATTRIBUTE_ILLEGAL ||
+					attr > AVRCP_ATTRIBUTE_LAST)
+			continue;
+
+		attrs[count++] = attr;
+	}
+
+	return count;
+}
+
+void avrcp_parse_attribute_list(struct iovec *iov, uint8_t count,
+					avrcp_attribute_func_t func,
+					void *user_data)
+{
+	for (; count > 0; count--) {
+		struct avrcp_attribute attr;
+
+		if (!util_iov_pull_be32(iov, &attr.id) ||
+				!util_iov_pull_be16(iov, &attr.charset) ||
+				!util_iov_pull_be16(iov, &attr.len))
+			return;
+
+		attr.value = util_iov_pull_mem(iov, attr.len);
+		if (!attr.value)
+			return;
+
+		func(&attr, user_data);
+	}
+}
+
+bool avrcp_parse_media_name(struct iovec *iov, char *name)
+{
+	uint16_t namelen;
+	uint8_t *namebuf;
+
+	if (!util_iov_pull_be16(iov, &namelen))
+		return false;
+
+	namebuf = util_iov_pull_mem(iov, namelen);
+	if (!namebuf)
+		return false;
+
+	namelen = MIN(namelen, NAME_MAX_LEN - 1);
+
+	memset(name, 0, NAME_MAX_LEN);
+	memcpy(name, namebuf, namelen);
+	strtoutf8(name, namelen);
+
+	return true;
+}
+
+bool avrcp_parse_media_element(struct iovec *iov,
+					struct avrcp_media_element *element)
+{
+	/* Skip the media type and character set */
+	if (!util_iov_pull_be64(iov, &element->uid) || !util_iov_pull(iov, 3))
+		return false;
+
+	if (!avrcp_parse_media_name(iov, element->name))
+		return false;
+
+	if (!util_iov_pull_u8(iov, &element->count))
+		return false;
+
+	return true;
+}
+
+bool avrcp_parse_media_folder(struct iovec *iov,
+					struct avrcp_media_folder *folder)
+{
+	/* Skip the character set */
+	if (!util_iov_pull_be64(iov, &folder->uid) ||
+			!util_iov_pull_u8(iov, &folder->type) ||
+			!util_iov_pull_u8(iov, &folder->playable) ||
+			!util_iov_pull(iov, 2))
+		return false;
+
+	if (!avrcp_parse_media_name(iov, folder->name))
+		return false;
+
+	return true;
+}
diff --git a/profiles/audio/avrcp-parse.h b/profiles/audio/avrcp-parse.h
new file mode 100644
index 000000000000..1a27c0684b32
--- /dev/null
+++ b/profiles/audio/avrcp-parse.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Intel Corporation
+ *
+ *
+ */
+
+#ifndef __AVRCP_PARSE_H
+#define __AVRCP_PARSE_H
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <sys/uio.h>
+
+#define NAME_MAX_LEN 255
+
+/* player attributes */
+#define AVRCP_ATTRIBUTE_ILLEGAL		0x00
+#define AVRCP_ATTRIBUTE_EQUALIZER	0x01
+#define AVRCP_ATTRIBUTE_REPEAT_MODE	0x02
+#define AVRCP_ATTRIBUTE_SHUFFLE		0x03
+#define AVRCP_ATTRIBUTE_SCAN		0x04
+#define AVRCP_ATTRIBUTE_LAST		AVRCP_ATTRIBUTE_SCAN
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+
+struct avrcp_header {
+	uint8_t company_id[3];
+	uint8_t pdu_id;
+	uint8_t packet_type:2;
+	uint8_t rsvd:6;
+	uint16_t params_len;
+	uint8_t params[0];
+} __attribute__ ((packed));
+
+#elif __BYTE_ORDER == __BIG_ENDIAN
+
+struct avrcp_header {
+	uint8_t company_id[3];
+	uint8_t pdu_id;
+	uint8_t rsvd:6;
+	uint8_t packet_type:2;
+	uint16_t params_len;
+	uint8_t params[0];
+} __attribute__ ((packed));
+
+#else
+#error "Unknown byte order"
+#endif
+
+#define AVRCP_HEADER_LENGTH 7
+
+struct avrcp_browsing_header {
+	uint8_t pdu_id;
+	uint16_t param_len;
+	uint8_t params[0];
+} __attribute__ ((packed));
+#define AVRCP_BROWSING_HEADER_LENGTH 3
+
+struct avrcp_attribute {
+	uint32_t id;
+	uint16_t charset;
+	uint16_t len;
+	uint8_t *value;
+};
+
+struct avrcp_media_element {
+	uint64_t uid;
+	char name[NAME_MAX_LEN];
+	uint8_t count;
+};
+
+struct avrcp_media_folder {
+	uint64_t uid;
+	uint8_t type;
+	uint8_t playable;
+	char name[NAME_MAX_LEN];
+};
+
+typedef void (*avrcp_attribute_func_t)(const struct avrcp_attribute *attr,
+							void *user_data);
+
+struct avrcp_header *avrcp_pull_header(struct iovec *iov);
+struct avrcp_browsing_header *avrcp_pull_browsing_header(struct iovec *iov);
+
+uint8_t avrcp_parse_player_attributes(struct iovec *iov, uint8_t *attrs,
+							uint8_t max);
+
+void avrcp_parse_attribute_list(struct iovec *iov, uint8_t count,
+					avrcp_attribute_func_t func,
+					void *user_data);
+
+bool avrcp_parse_media_name(struct iovec *iov, char *name);
+bool avrcp_parse_media_element(struct iovec *iov,
+					struct avrcp_media_element *element);
+bool avrcp_parse_media_folder(struct iovec *iov,
+					struct avrcp_media_folder *folder);
+
+#endif /* __AVRCP_PARSE_H */
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index aff3b5ce21a2..df5f97eafc88 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -52,6 +52,7 @@
 
 #include "avctp.h"
 #include "avrcp.h"
+#include "avrcp-parse.h"
 #include "control.h"
 #include "media.h"
 #include "player.h"
@@ -145,46 +146,9 @@
 #define AVRCP_SCOPE_SEARCH				0x02
 #define AVRCP_SCOPE_NOW_PLAYING			0x03
 
-#define NAME_MAX_LEN 255
-
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-
-struct avrcp_header {
-	uint8_t company_id[3];
-	uint8_t pdu_id;
-	uint8_t packet_type:2;
-	uint8_t rsvd:6;
-	uint16_t params_len;
-	uint8_t params[0];
-} __attribute__ ((packed));
-#define AVRCP_HEADER_LENGTH 7
-
-#elif __BYTE_ORDER == __BIG_ENDIAN
-
-struct avrcp_header {
-	uint8_t company_id[3];
-	uint8_t pdu_id;
-	uint8_t rsvd:6;
-	uint8_t packet_type:2;
-	uint16_t params_len;
-	uint8_t params[0];
-} __attribute__ ((packed));
-#define AVRCP_HEADER_LENGTH 7
-
-#else
-#error "Unknown byte order"
-#endif
-
 #define AVRCP_MTU	(AVC_MTU - AVC_HEADER_LENGTH)
 #define AVRCP_PDU_MTU	(AVRCP_MTU - AVRCP_HEADER_LENGTH)
 
-struct avrcp_browsing_header {
-	uint8_t pdu_id;
-	uint16_t param_len;
-	uint8_t params[0];
-} __attribute__ ((packed));
-#define AVRCP_BROWSING_HEADER_LENGTH 3
-
 struct get_folder_items_rsp {
 	uint8_t status;
 	uint16_t uid_counter;
@@ -2260,52 +2224,6 @@ static const char *status_to_string(uint8_t status)
 	}
 }
 
-/*
- * Pull the AVRCP header out of iov and validate that the parameters length
- * it declares matches the number of bytes actually received, leaving iov
- * pointing at the parameters.
- */
-static struct avrcp_header *avrcp_pull_header(struct iovec *iov)
-{
-	struct avrcp_header *pdu;
-
-	pdu = util_iov_pull_mem(iov, sizeof(*pdu));
-	if (!pdu) {
-		error("Invalid AVRCP header");
-		return NULL;
-	}
-
-	if (be16_to_cpu(pdu->params_len) != iov->iov_len) {
-		error("Invalid parameters");
-		return NULL;
-	}
-
-	return pdu;
-}
-
-/*
- * Same as avrcp_pull_header() but for the browsing channel, which uses a
- * different header layout.
- */
-static struct avrcp_browsing_header *avrcp_pull_browsing_header(
-							struct iovec *iov)
-{
-	struct avrcp_browsing_header *pdu;
-
-	pdu = util_iov_pull_mem(iov, sizeof(*pdu));
-	if (!pdu) {
-		error("Invalid AVRCP browsing header");
-		return NULL;
-	}
-
-	if (be16_to_cpu(pdu->param_len) != iov->iov_len) {
-		error("Invalid parameters");
-		return NULL;
-	}
-
-	return pdu;
-}
-
 static gboolean avrcp_get_play_status_rsp(struct avctp *conn, uint8_t code,
 					uint8_t subunit, uint8_t transaction,
 					uint8_t *operands, size_t operand_count,
@@ -2452,8 +2370,7 @@ static gboolean avrcp_list_player_attributes_rsp(struct avctp *conn,
 	struct iovec iov = { operands, operand_count };
 	uint8_t attrs[AVRCP_ATTRIBUTE_LAST];
 	struct avrcp *session = user_data;
-	uint8_t len, count = 0;
-	int i;
+	uint8_t count;
 
 	if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED)
 		return FALSE;
@@ -2461,25 +2378,7 @@ static gboolean avrcp_list_player_attributes_rsp(struct avctp *conn,
 	if (!avrcp_pull_header(&iov))
 		return FALSE;
 
-	if (!util_iov_pull_u8(&iov, &len))
-		return FALSE;
-
-	len = MIN(len, AVRCP_ATTRIBUTE_LAST);
-
-	for (i = 0; i < len; i++) {
-		uint8_t attr;
-
-		if (!util_iov_pull_u8(&iov, &attr))
-			break;
-
-		/* Don't query invalid attributes */
-		if (attr == AVRCP_ATTRIBUTE_ILLEGAL ||
-					attr > AVRCP_ATTRIBUTE_LAST)
-			continue;
-
-		attrs[count++] = attr;
-	}
-
+	count = avrcp_parse_player_attributes(&iov, attrs, sizeof(attrs));
 	if (!count)
 		return FALSE;
 
@@ -2505,34 +2404,38 @@ static void avrcp_list_player_attributes(struct avrcp *session)
 					session);
 }
 
-static void avrcp_parse_attribute_list(struct avrcp_player *player,
+struct parse_attribute_data {
+	struct media_player *mp;
+	struct media_item *item;
+};
+
+static void parse_attribute(const struct avrcp_attribute *attr,
+							void *user_data)
+{
+	struct parse_attribute_data *data = user_data;
+	const char *key;
+
+	if (attr->charset != 106)
+		return;
+
+	key = metadata_to_str(attr->id);
+	if (key == NULL)
+		return;
+
+	media_player_set_metadata(data->mp, data->item, key, attr->value,
+								attr->len);
+}
+
+static void avrcp_player_parse_attributes(struct avrcp_player *player,
 					struct media_item *item,
 					struct iovec *iov, uint8_t count)
 {
-	struct media_player *mp = player->user_data;
+	struct parse_attribute_data data = {
+		.mp = player->user_data,
+		.item = item,
+	};
 
-	for (; count > 0; count--) {
-		uint32_t id;
-		uint16_t charset, len;
-		uint8_t *value;
-
-		if (!util_iov_pull_be32(iov, &id) ||
-				!util_iov_pull_be16(iov, &charset) ||
-				!util_iov_pull_be16(iov, &len))
-			return;
-
-		value = util_iov_pull_mem(iov, len);
-		if (!value)
-			return;
-
-		if (charset == 106) {
-			const char *key = metadata_to_str(id);
-
-			if (key != NULL)
-				media_player_set_metadata(mp, item, key,
-								value, len);
-		}
-	}
+	avrcp_parse_attribute_list(iov, count, parse_attribute, &data);
 }
 
 static void avrcp_abort_continuing(struct avrcp *session, uint8_t pdu_id)
@@ -2589,7 +2492,7 @@ static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
 
 	item = media_player_set_playlist_item(mp, player->uid);
 
-	avrcp_parse_attribute_list(player, item, &iov, count);
+	avrcp_player_parse_attributes(player, item, &iov, count);
 
 	media_player_metadata_changed(mp);
 
@@ -2671,57 +2574,28 @@ static const char *subtype_to_string(uint32_t subtype)
 	return "None";
 }
 
-static gboolean parse_media_name(struct iovec *iov, char *name)
-{
-	uint16_t namelen;
-	uint8_t *namebuf;
-
-	if (!util_iov_pull_be16(iov, &namelen))
-		return FALSE;
-
-	namebuf = util_iov_pull_mem(iov, namelen);
-	if (!namebuf)
-		return FALSE;
-
-	namelen = MIN(namelen, NAME_MAX_LEN - 1);
-
-	memset(name, 0, NAME_MAX_LEN);
-	memcpy(name, namebuf, namelen);
-	strtoutf8(name, namelen);
-
-	return TRUE;
-}
-
 static struct media_item *parse_media_element(struct avrcp *session,
 							struct iovec *iov)
 {
 	struct avrcp_player *player;
 	struct media_player *mp;
 	struct media_item *item;
-	char name[NAME_MAX_LEN];
-	uint64_t uid;
-	uint8_t count;
+	struct avrcp_media_element element;
 
-	/* Skip the media type and character set */
-	if (!util_iov_pull_be64(iov, &uid) || !util_iov_pull(iov, 3))
-		return NULL;
-
-	if (!parse_media_name(iov, name))
-		return NULL;
-
-	if (!util_iov_pull_u8(iov, &count))
+	if (!avrcp_parse_media_element(iov, &element))
 		return NULL;
 
 	player = session->controller->player;
 	mp = player->user_data;
 
-	item = media_player_create_item(mp, name, PLAYER_ITEM_TYPE_AUDIO, uid);
+	item = media_player_create_item(mp, element.name,
+					PLAYER_ITEM_TYPE_AUDIO, element.uid);
 	if (item == NULL)
 		return NULL;
 
 	media_item_set_playable(item, true);
 
-	avrcp_parse_attribute_list(player, item, iov, count);
+	avrcp_player_parse_attributes(player, item, iov, element.count);
 
 	return item;
 }
@@ -2732,26 +2606,17 @@ static struct media_item *parse_media_folder(struct avrcp *session,
 	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
 	struct media_item *item;
-	char name[NAME_MAX_LEN];
-	uint64_t uid;
-	uint8_t type;
-	uint8_t playable;
+	struct avrcp_media_folder folder;
 
-	/* Skip the character set */
-	if (!util_iov_pull_be64(iov, &uid) ||
-			!util_iov_pull_u8(iov, &type) ||
-			!util_iov_pull_u8(iov, &playable) ||
-			!util_iov_pull(iov, 2))
+	if (!avrcp_parse_media_folder(iov, &folder))
 		return NULL;
 
-	if (!parse_media_name(iov, name))
-		return NULL;
-
-	item = media_player_create_folder(mp, name, type, uid);
+	item = media_player_create_folder(mp, folder.name, folder.type,
+								folder.uid);
 	if (!item)
 		return NULL;
 
-	media_item_set_playable(item, playable & 0x01);
+	media_item_set_playable(item, folder.playable & 0x01);
 
 	return item;
 }
@@ -3043,7 +2908,7 @@ static gboolean avrcp_get_item_attributes_rsp(struct avctp *conn,
 
 	item = media_player_set_playlist_item(mp, player->uid);
 
-	avrcp_parse_attribute_list(player, item, &iov, count);
+	avrcp_player_parse_attributes(player, item, &iov, count);
 
 	media_player_metadata_changed(mp);
 
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 21351a4bc422..9f72c2ed4413 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -9,13 +9,7 @@
  *
  */
 
-/* player attributes */
-#define AVRCP_ATTRIBUTE_ILLEGAL		0x00
-#define AVRCP_ATTRIBUTE_EQUALIZER	0x01
-#define AVRCP_ATTRIBUTE_REPEAT_MODE	0x02
-#define AVRCP_ATTRIBUTE_SHUFFLE		0x03
-#define AVRCP_ATTRIBUTE_SCAN		0x04
-#define AVRCP_ATTRIBUTE_LAST		AVRCP_ATTRIBUTE_SCAN
+#include "avrcp-parse.h"
 
 /* equalizer values */
 #define AVRCP_EQUALIZER_OFF		0x01
-- 
2.54.0

