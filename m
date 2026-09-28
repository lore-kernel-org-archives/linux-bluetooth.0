Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4988F4DE72A
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616818; cv=none; b=CQyXUIF/hEYYt0fyb710ixymX21ATeYw7fxkKTKuxRNEjRCAgFWIjikmpbC3sybXlZTqxkI0qJXkUkZ2hNh1ekdRf2StjsZdqJIdIAqfhA+FqsTIPasOI4Z4fFNqH7u6XzsYU1e24Kt2+FU9EbtU7nnhESCsl9vcN44qq029PS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616818; c=relaxed/simple;
	bh=lP+YRwzIAYJGshym0jOyLyRMf4BYPJWhY3sqveWe8YI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9gcPgJGdq+EnWoACN0BiZ6f/VBv01whP8pDADgkE+GoQzo1ax+qsU7VySKnZFYEqEEXd1KHD+iBEN+uL3BhNBgWeBqvBVir03Vluh3zgfiHFsUNgSeTVGYbPeGbxew/+YjPvgksslTLAVPcUblgMqIvb4zRq9dr0ZdDy0EeLDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=roNCdQuJ; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roNCdQuJ"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e96e461feso912073241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 10:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790616813; x=1791221613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y6NqxTQgWopM6ekRNOw9C8l5NIZGC5KPijOrYLtW4kQ=;
        b=roNCdQuJ1TCe7I2eeWaQrySlxGKq7yQI6yJOVNEXvCZty65O9rqry3WFEWHCzk7bYd
         nIlubPCqhxFA1JCzdwoegDwPMe0uEKFLXSxryNdbBr2K3+BpZSKh9IqTCIa6CmvnmkT7
         g4F9mARax8B2QiNQmgXEAVEvnS533swvFyaMeC4PLnK6YrTZ+XyKdyIJiPdUV22aE5dy
         /Rgh0L4lDX0juWXQggSEIhfoHqUVqv601tkCjd/M7N+lKUJbWx3Ob+PrWX54f4MhxKx1
         3ETQCxtqd+S6/rX7bqNM3WjObaaM4NblHZhT3OEP4UhZh4OsB3R6+5FqtdKM6RCBMmBt
         5a7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616813; x=1791221613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Y6NqxTQgWopM6ekRNOw9C8l5NIZGC5KPijOrYLtW4kQ=;
        b=rIgjbzefXMF+zJbPV4tP+Sq2IU88slLeg9opOC+uI+m+cPLPdjsFK62/XsjfOanW6k
         CqmbQrm3ffNRmd1TM+mHCLxhOrdyRmk0O8LuZBTf+OC6hcmes3iqS1ViZriIorIVU5op
         vkSkP5/uHHJ8otOkzU6SigxIphhS3GeGE26YfxMmPFo7epLlHeVNsa1VojrwemZ1PY6f
         8D0hDFj73+evIzu7WP5bxc3s5j77GdNuGMJUoTfu5xKvX8O3p2DgOYW+NSUhAFnDa/nS
         XLtdWDuH7+lmibnGQT9hjXsiEXuDCo80EXDeeNX9lpdkgq2z7BFMBO3rptkBJjZNnnqO
         HnKA==
X-Gm-Message-State: AFq9FYJm5o7pjFaeOqHrU8XD+0v0yrSMcG/lb21oJTBIGDnyaHRmE/4G
	XFBY1XiJT1mZ87AKoUQmrQ5z849fshJFcHe7V6+w7CHpHzlbvu4RUgbB0OnpDair+WE=
X-Gm-Gg: AYBFou1a2JwcrOHJYdPyTAKUf8jnTxXh+9Z0fiOcm57KPguvt66tgDyWcMP1PVKf3Vv
	UixOCzdAFvqTRaV8LHOGqdgByD0+Gbwbc4tk9f0EGR1yySWLmbZc6qs7qa/tZ46lYctkLcmFen9
	xg3vAt+iyJm6sO0t6o61WwhBDjWq1QSv95gwd/xB0jKg3ibbKUfes/9LKmszdiPtL68TvSzn1qZ
	lPR3TXCqTocFG7zfrAtEY6lcF8Xh6IlhINXR0Kn2Cx6dDHDmfAwy7usg6EARyB6tTvws8pIVvSN
	x1HLB2OLlUUgG9LlKC9j7sTNVnKiHo8xo8wFiCND3LLNgSxQkjgmlgy2GslN4BqxxfA2flK90+T
	91VXUL3EjGAXBNnu6rWztT6W5jRyNiOPrAoqeYwNRE/KYlBFZZPR2pqCN1EMDSF7R0Gzr9FOt7M
	keT8Xmx+hz51ti31d4YUDJ11zsPMfpwxJCI3ArdfRKWo02OoNYeFwLFk1m7V7wA/VPetIIaGkMp
	zMfagsNDJ7gF996nnVqEWyU/SNIH7GBDxKvsnn05SprnUQCJdLfOd8v+verY7y1
X-Received: by 2002:a05:6102:8098:b0:7a6:a661:efe8 with SMTP id ada2fe7eead31-7af1e4f74a0mr3883333137.22.1790616812062;
        Mon, 28 Sep 2026 10:33:32 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b6a6272sm10038880137.7.2026.09.28.10.33.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:33:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 21/21] attrib: Remove directory
Date: Mon, 28 Sep 2026 13:32:40 -0400
Message-ID: <20260928173243.1073509-22-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928173243.1073509-1-luiz.dentz@gmail.com>
References: <20260928173243.1073509-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

What is left of attrib is only used by bluetoothd: att_ecode2str, which
is moved to src/shared/att as bt_att_ecode2str, and struct gatt_primary
along with gatt_parse_record, which are moved to src/device, so remove
the attrib directory.

Assisted-by: OpenCode:claude-opus-5.5
---
 Makefile.am                      |    4 +-
 attrib/att-database.h            |   30 -
 attrib/att.c                     | 1238 ------------------------------
 attrib/att.h                     |  186 -----
 attrib/gatt.c                    |  103 ---
 attrib/gatt.h                    |   20 -
 profiles/battery/battery.c       |    3 +-
 profiles/deviceinfo/deviceinfo.c |    3 +-
 profiles/midi/midi.c             |    3 +-
 profiles/ranging/rap.c           |    1 -
 profiles/scanparam/scan.c        |    3 +-
 src/adapter.c                    |    3 +-
 src/device.c                     |   78 +-
 src/device.h                     |   13 +
 src/shared/att.c                 |   48 ++
 src/shared/att.h                 |    2 +
 16 files changed, 145 insertions(+), 1593 deletions(-)
 delete mode 100644 attrib/att-database.h
 delete mode 100644 attrib/att.c
 delete mode 100644 attrib/att.h
 delete mode 100644 attrib/gatt.c
 delete mode 100644 attrib/gatt.h

diff --git a/Makefile.am b/Makefile.am
index 33a2f79fbff6..1d2459b2de8f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -286,8 +286,6 @@ src_libshared_ell_la_LDFLAGS = $(AM_LDFLAGS)
 src_libshared_ell_la_CFLAGS = $(AM_CFLAGS)
 endif
 
-attrib_sources = attrib/att.h attrib/att-database.h attrib/att.c \
-		attrib/gatt.h attrib/gatt.c
 
 btio_sources = btio/btio.h btio/btio.c
 
@@ -308,7 +306,7 @@ include Makefile.plugins
 pkglibexec_PROGRAMS += src/bluetoothd
 
 bluetoothd_internal_sources = \
-			$(attrib_sources) $(btio_sources) \
+			$(btio_sources) \
 			src/log.h src/log.c \
 			src/backtrace.h src/backtrace.c \
 			src/rfkill.c src/btd.h src/sdpd.h \
diff --git a/attrib/att-database.h b/attrib/att-database.h
deleted file mode 100644
index bb30933eaf04..000000000000
--- a/attrib/att-database.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2012 Texas Instruments Corporation
- *
- */
-
-/* Requirements for read/write operations */
-enum {
-	ATT_NONE,		/* No restrictions */
-	ATT_AUTHENTICATION,	/* Authentication required */
-	ATT_AUTHORIZATION,	/* Authorization required */
-	ATT_NOT_PERMITTED,	/* Operation not permitted */
-};
-
-struct attribute {
-	uint16_t handle;
-	bt_uuid_t uuid;
-	int read_req;		/* Read requirement */
-	int write_req;		/* Write requirement */
-	uint8_t (*read_cb)(struct attribute *a, struct btd_device *device,
-							gpointer user_data);
-	uint8_t (*write_cb)(struct attribute *a, struct btd_device *device,
-							gpointer user_data);
-	gpointer cb_user_data;
-	size_t len;
-	uint8_t *data;
-};
diff --git a/attrib/att.c b/attrib/att.c
deleted file mode 100644
index 686674a9ac74..000000000000
--- a/attrib/att.c
+++ /dev/null
@@ -1,1238 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2010  Nokia Corporation
- *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <errno.h>
-#include <stdint.h>
-#include <stdlib.h>
-
-#include <glib.h>
-
-#include "bluetooth/bluetooth.h"
-#include "bluetooth/uuid.h"
-
-#include "src/shared/util.h"
-#include "att.h"
-
-static inline void put_uuid_le(const bt_uuid_t *src, void *dst)
-{
-	if (src->type == BT_UUID16)
-		put_le16(src->value.u16, dst);
-	else
-		/* Convert from 128-bit BE to LE */
-		bswap_128(&src->value.u128, dst);
-}
-
-const char *att_ecode2str(uint8_t status)
-{
-	switch (status)  {
-	case ATT_ECODE_INVALID_HANDLE:
-		return "Invalid handle";
-	case ATT_ECODE_READ_NOT_PERM:
-		return "Attribute can't be read";
-	case ATT_ECODE_WRITE_NOT_PERM:
-		return "Attribute can't be written";
-	case ATT_ECODE_INVALID_PDU:
-		return "Attribute PDU was invalid";
-	case ATT_ECODE_AUTHENTICATION:
-		return "Attribute requires authentication before read/write";
-	case ATT_ECODE_REQ_NOT_SUPP:
-		return "Server doesn't support the request received";
-	case ATT_ECODE_INVALID_OFFSET:
-		return "Offset past the end of the attribute";
-	case ATT_ECODE_AUTHORIZATION:
-		return "Attribute requires authorization before read/write";
-	case ATT_ECODE_PREP_QUEUE_FULL:
-		return "Too many prepare writes have been queued";
-	case ATT_ECODE_ATTR_NOT_FOUND:
-		return "No attribute found within the given range";
-	case ATT_ECODE_ATTR_NOT_LONG:
-		return "Attribute can't be read/written using Read Blob Req";
-	case ATT_ECODE_INSUFF_ENCR_KEY_SIZE:
-		return "Encryption Key Size is insufficient";
-	case ATT_ECODE_INVAL_ATTR_VALUE_LEN:
-		return "Attribute value length is invalid";
-	case ATT_ECODE_UNLIKELY:
-		return "Request attribute has encountered an unlikely error";
-	case ATT_ECODE_INSUFF_ENC:
-		return "Encryption required before read/write";
-	case ATT_ECODE_UNSUPP_GRP_TYPE:
-		return "Attribute type is not a supported grouping attribute";
-	case ATT_ECODE_INSUFF_RESOURCES:
-		return "Insufficient Resources to complete the request";
-	case ATT_ECODE_IO:
-		return "Internal application error: I/O";
-	case ATT_ECODE_TIMEOUT:
-		return "A timeout occurred";
-	case ATT_ECODE_ABORTED:
-		return "The operation was aborted";
-	default:
-		return "Unexpected error code";
-	}
-}
-
-void att_data_list_free(struct att_data_list *list)
-{
-	if (list == NULL)
-		return;
-
-	if (list->data) {
-		int i;
-		for (i = 0; i < list->num; i++)
-			g_free(list->data[i]);
-	}
-
-	g_free(list->data);
-	g_free(list);
-}
-
-struct att_data_list *att_data_list_alloc(uint16_t num, uint16_t len)
-{
-	struct att_data_list *list;
-	int i;
-
-	if (len > UINT8_MAX)
-		return NULL;
-
-	list = g_new0(struct att_data_list, 1);
-	list->len = len;
-	list->num = num;
-
-	list->data = g_malloc0(sizeof(uint8_t *) * num);
-
-	for (i = 0; i < num; i++)
-		list->data[i] = g_malloc0(sizeof(uint8_t) * len);
-
-	return list;
-}
-
-static void get_uuid(uint8_t type, const void *val, bt_uuid_t *uuid)
-{
-	if (type == BT_UUID16)
-		bt_uuid16_create(uuid, get_le16(val));
-	else {
-		uint128_t u128;
-
-		/* Convert from 128-bit LE to BE */
-		bswap_128(val, &u128);
-		bt_uuid128_create(uuid, u128);
-	}
-}
-
-uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
-						uint8_t *pdu, size_t len)
-{
-	uint16_t uuid_len;
-
-	if (!uuid)
-		return 0;
-
-	if (uuid->type == BT_UUID16)
-		uuid_len = 2;
-	else if (uuid->type == BT_UUID128)
-		uuid_len = 16;
-	else
-		return 0;
-
-	/* Attribute Opcode (1 octet) */
-	pdu[0] = ATT_OP_READ_BY_GROUP_REQ;
-	/* Starting Handle (2 octets) */
-	put_le16(start, &pdu[1]);
-	/* Ending Handle (2 octets) */
-	put_le16(end, &pdu[3]);
-	/* Attribute Group Type (2 or 16 octet UUID) */
-	put_uuid_le(uuid, &pdu[5]);
-
-	return 5 + uuid_len;
-}
-
-uint16_t dec_read_by_grp_req(const uint8_t *pdu, size_t len, uint16_t *start,
-						uint16_t *end, bt_uuid_t *uuid)
-{
-	const size_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
-	uint8_t type;
-
-	if (pdu == NULL)
-		return 0;
-
-	if (start == NULL || end == NULL || uuid == NULL)
-		return 0;
-
-	if (pdu[0] != ATT_OP_READ_BY_GROUP_REQ)
-		return 0;
-
-	if (len == (min_len + 2))
-		type = BT_UUID16;
-	else if (len == (min_len + 16))
-		type = BT_UUID128;
-	else
-		return 0;
-
-	*start = get_le16(&pdu[1]);
-	*end = get_le16(&pdu[3]);
-
-	get_uuid(type, &pdu[5], uuid);
-
-	return len;
-}
-
-uint16_t enc_read_by_grp_resp(struct att_data_list *list, uint8_t *pdu,
-								size_t len)
-{
-	int i;
-	uint16_t w;
-	uint8_t *ptr;
-
-	if (list == NULL)
-		return 0;
-
-	if (len < list->len + sizeof(uint8_t) * 2)
-		return 0;
-
-	pdu[0] = ATT_OP_READ_BY_GROUP_RESP;
-	pdu[1] = list->len;
-
-	ptr = &pdu[2];
-
-	for (i = 0, w = 2; i < list->num && w + list->len <= len; i++) {
-		memcpy(ptr, list->data[i], list->len);
-		ptr += list->len;
-		w += list->len;
-	}
-
-	return w;
-}
-
-struct att_data_list *dec_read_by_grp_resp(const uint8_t *pdu, size_t len)
-{
-	struct att_data_list *list;
-	const uint8_t *ptr;
-	uint16_t elen, num;
-	int i;
-
-	if (pdu[0] != ATT_OP_READ_BY_GROUP_RESP)
-		return NULL;
-
-	/* PDU must contain at least:
-	 * - Attribute Opcode (1 octet)
-	 * - Length (1 octet)
-	 * - Attribute Data List (at least one entry):
-	 *   - Attribute Handle (2 octets)
-	 *   - End Group Handle (2 octets)
-	 *   - Attribute Value (at least 1 octet) */
-	if (len < 7)
-		return NULL;
-
-	elen = pdu[1];
-	/* Minimum Attribute Data List size */
-	if (elen < 5)
-		return NULL;
-
-	/* Reject incomplete Attribute Data List */
-	if ((len - 2) % elen)
-		return NULL;
-
-	num = (len - 2) / elen;
-	list = att_data_list_alloc(num, elen);
-	if (list == NULL)
-		return NULL;
-
-	ptr = &pdu[2];
-
-	for (i = 0; i < num; i++) {
-		memcpy(list->data[i], ptr, list->len);
-		ptr += list->len;
-	}
-
-	return list;
-}
-
-uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
-					const uint8_t *value, size_t vlen,
-					uint8_t *pdu, size_t len)
-{
-	uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end) +
-							sizeof(uint16_t);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (!uuid)
-		return 0;
-
-	if (uuid->type != BT_UUID16)
-		return 0;
-
-	if (vlen > len - min_len)
-		vlen = len - min_len;
-
-	pdu[0] = ATT_OP_FIND_BY_TYPE_REQ;
-	put_le16(start, &pdu[1]);
-	put_le16(end, &pdu[3]);
-	put_le16(uuid->value.u16, &pdu[5]);
-
-	if (vlen > 0) {
-		memcpy(&pdu[7], value, vlen);
-		return min_len + vlen;
-	}
-
-	return min_len;
-}
-
-uint16_t dec_find_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
-						uint16_t *end, bt_uuid_t *uuid,
-						uint8_t *value, size_t *vlen)
-{
-	if (pdu == NULL)
-		return 0;
-
-	if (len < 7)
-		return 0;
-
-	/* Attribute Opcode (1 octet) */
-	if (pdu[0] != ATT_OP_FIND_BY_TYPE_REQ)
-		return 0;
-
-	/* First requested handle number (2 octets) */
-	*start = get_le16(&pdu[1]);
-	/* Last requested handle number (2 octets) */
-	*end = get_le16(&pdu[3]);
-	/* 16-bit UUID to find (2 octets) */
-	bt_uuid16_create(uuid, get_le16(&pdu[5]));
-
-	/* Attribute value to find */
-	*vlen = len - 7;
-	if (*vlen > 0)
-		memcpy(value, pdu + 7, *vlen);
-
-	return len;
-}
-
-uint16_t enc_find_by_type_resp(GSList *matches, uint8_t *pdu, size_t len)
-{
-	GSList *l;
-	uint16_t offset;
-
-	if (!pdu)
-		return 0;
-
-	pdu[0] = ATT_OP_FIND_BY_TYPE_RESP;
-
-	for (l = matches, offset = 1;
-				l && len >= (offset + sizeof(uint16_t) * 2);
-				l = l->next, offset += sizeof(uint16_t) * 2) {
-		struct att_range *range = l->data;
-
-		put_le16(range->start, &pdu[offset]);
-		put_le16(range->end, &pdu[offset + 2]);
-	}
-
-	return offset;
-}
-
-GSList *dec_find_by_type_resp(const uint8_t *pdu, size_t len)
-{
-	struct att_range *range;
-	GSList *matches;
-	off_t offset;
-
-	/* PDU should contain at least:
-	 * - Attribute Opcode (1 octet)
-	 * - Handles Information List (at least one entry):
-	 *   - Found Attribute Handle (2 octets)
-	 *   - Group End Handle (2 octets) */
-	if (pdu == NULL || len < 5)
-		return NULL;
-
-	if (pdu[0] != ATT_OP_FIND_BY_TYPE_RESP)
-		return NULL;
-
-	/* Reject incomplete Handles Information List */
-	if ((len - 1) % 4)
-		return NULL;
-
-	for (offset = 1, matches = NULL;
-				len >= (offset + sizeof(uint16_t) * 2);
-				offset += sizeof(uint16_t) * 2) {
-		range = g_new0(struct att_range, 1);
-		range->start = get_le16(&pdu[offset]);
-		range->end = get_le16(&pdu[offset + 2]);
-
-		matches = g_slist_append(matches, range);
-	}
-
-	return matches;
-}
-
-uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
-						uint8_t *pdu, size_t len)
-{
-	uint16_t uuid_len;
-
-	if (!uuid)
-		return 0;
-
-	if (uuid->type == BT_UUID16)
-		uuid_len = 2;
-	else if (uuid->type == BT_UUID128)
-		uuid_len = 16;
-	else
-		return 0;
-
-	/* Attribute Opcode (1 octet) */
-	pdu[0] = ATT_OP_READ_BY_TYPE_REQ;
-	/* Starting Handle (2 octets) */
-	put_le16(start, &pdu[1]);
-	/* Ending Handle (2 octets) */
-	put_le16(end, &pdu[3]);
-	/* Attribute Type (2 or 16 octet UUID) */
-	put_uuid_le(uuid, &pdu[5]);
-
-	return 5 + uuid_len;
-}
-
-uint16_t dec_read_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
-						uint16_t *end, bt_uuid_t *uuid)
-{
-	const size_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
-	uint8_t type;
-
-	if (pdu == NULL)
-		return 0;
-
-	if (start == NULL || end == NULL || uuid == NULL)
-		return 0;
-
-	if (len == (min_len + 2))
-		type = BT_UUID16;
-	else if (len == (min_len + 16))
-		type = BT_UUID128;
-	else
-		return 0;
-
-	if (pdu[0] != ATT_OP_READ_BY_TYPE_REQ)
-		return 0;
-
-	*start = get_le16(&pdu[1]);
-	*end = get_le16(&pdu[3]);
-
-	get_uuid(type, &pdu[5], uuid);
-
-	return len;
-}
-
-uint16_t enc_read_by_type_resp(struct att_data_list *list, uint8_t *pdu,
-								size_t len)
-{
-	uint8_t *ptr;
-	size_t i, w, l;
-
-	if (list == NULL)
-		return 0;
-
-	if (pdu == NULL)
-		return 0;
-
-	l = MIN(len - 2, list->len);
-
-	pdu[0] = ATT_OP_READ_BY_TYPE_RESP;
-	pdu[1] = l;
-	ptr = &pdu[2];
-
-	for (i = 0, w = 2; i < list->num && w + l <= len; i++) {
-		memcpy(ptr, list->data[i], l);
-		ptr += l;
-		w += l;
-	}
-
-	return w;
-}
-
-struct att_data_list *dec_read_by_type_resp(const uint8_t *pdu, size_t len)
-{
-	struct att_data_list *list;
-	const uint8_t *ptr;
-	uint16_t elen, num;
-	int i;
-
-	if (pdu[0] != ATT_OP_READ_BY_TYPE_RESP)
-		return NULL;
-
-	/* PDU must contain at least:
-	 * - Attribute Opcode (1 octet)
-	 * - Length (1 octet)
-	 * - Attribute Data List (at least one entry):
-	 *   - Attribute Handle (2 octets)
-	 *   - Attribute Value (at least 1 octet) */
-	if (len < 5)
-		return NULL;
-
-	elen = pdu[1];
-	/* Minimum Attribute Data List size */
-	if (elen < 3)
-		return NULL;
-
-	/* Reject incomplete Attribute Data List */
-	if ((len - 2) % elen)
-		return NULL;
-
-	num = (len - 2) / elen;
-	list = att_data_list_alloc(num, elen);
-	if (list == NULL)
-		return NULL;
-
-	ptr = &pdu[2];
-
-	for (i = 0; i < num; i++) {
-		memcpy(list->data[i], ptr, list->len);
-		ptr += list->len;
-	}
-
-	return list;
-}
-
-uint16_t enc_write_cmd(uint16_t handle, const uint8_t *value, size_t vlen,
-						uint8_t *pdu, size_t len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (vlen > len - min_len)
-		vlen = len - min_len;
-
-	pdu[0] = ATT_OP_WRITE_CMD;
-	put_le16(handle, &pdu[1]);
-
-	if (vlen > 0) {
-		memcpy(&pdu[3], value, vlen);
-		return min_len + vlen;
-	}
-
-	return min_len;
-}
-
-uint16_t dec_write_cmd(const uint8_t *pdu, size_t len, uint16_t *handle,
-						uint8_t *value, size_t *vlen)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (value == NULL || vlen == NULL || handle == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (pdu[0] != ATT_OP_WRITE_CMD)
-		return 0;
-
-	*handle = get_le16(&pdu[1]);
-	memcpy(value, pdu + min_len, len - min_len);
-	*vlen = len - min_len;
-
-	return len;
-}
-
-uint16_t enc_signed_write_cmd(uint16_t handle, const uint8_t *value,
-					size_t vlen, struct bt_crypto *crypto,
-					const uint8_t csrk[16],
-					uint32_t sign_cnt,
-					uint8_t *pdu, size_t len)
-{
-	const uint16_t hdr_len = sizeof(pdu[0]) + sizeof(handle);
-	const uint16_t min_len =  hdr_len + ATT_SIGNATURE_LEN;
-
-	if (pdu == NULL)
-		return 0;
-
-	if (vlen > len - min_len)
-		vlen = len - min_len;
-
-	pdu[0] = ATT_OP_SIGNED_WRITE_CMD;
-	put_le16(handle, &pdu[1]);
-
-	if (vlen > 0)
-		memcpy(&pdu[hdr_len], value, vlen);
-
-	if (!bt_crypto_sign_att(crypto, csrk, pdu, hdr_len + vlen, sign_cnt,
-							&pdu[hdr_len + vlen]))
-		return 0;
-
-	return min_len + vlen;
-}
-
-uint16_t dec_signed_write_cmd(const uint8_t *pdu, size_t len,
-						uint16_t *handle,
-						uint8_t *value, size_t *vlen,
-						uint8_t signature[12])
-{
-	const uint16_t hdr_len = sizeof(pdu[0]) + sizeof(*handle);
-	const uint16_t min_len =  hdr_len + ATT_SIGNATURE_LEN;
-
-
-	if (pdu == NULL)
-		return 0;
-
-	if (value == NULL || vlen == NULL || handle == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (pdu[0] != ATT_OP_SIGNED_WRITE_CMD)
-		return 0;
-
-	*vlen = len - min_len;
-	*handle = get_le16(&pdu[1]);
-	memcpy(value, pdu + hdr_len, *vlen);
-
-	memcpy(signature, pdu + hdr_len + *vlen, ATT_SIGNATURE_LEN);
-
-	return len;
-}
-
-uint16_t enc_write_req(uint16_t handle, const uint8_t *value, size_t vlen,
-						uint8_t *pdu, size_t len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (vlen > len - min_len)
-		vlen = len - min_len;
-
-	pdu[0] = ATT_OP_WRITE_REQ;
-	put_le16(handle, &pdu[1]);
-
-	if (vlen > 0) {
-		memcpy(&pdu[3], value, vlen);
-		return min_len + vlen;
-	}
-
-	return min_len;
-}
-
-uint16_t dec_write_req(const uint8_t *pdu, size_t len, uint16_t *handle,
-						uint8_t *value, size_t *vlen)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (value == NULL || vlen == NULL || handle == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (pdu[0] != ATT_OP_WRITE_REQ)
-		return 0;
-
-	*handle = get_le16(&pdu[1]);
-	*vlen = len - min_len;
-	if (*vlen > 0)
-		memcpy(value, pdu + min_len, *vlen);
-
-	return len;
-}
-
-uint16_t enc_write_resp(uint8_t *pdu)
-{
-	if (pdu == NULL)
-		return 0;
-
-	pdu[0] = ATT_OP_WRITE_RESP;
-
-	return sizeof(pdu[0]);
-}
-
-uint16_t dec_write_resp(const uint8_t *pdu, size_t len)
-{
-	if (pdu == NULL)
-		return 0;
-
-	if (pdu[0] != ATT_OP_WRITE_RESP)
-		return 0;
-
-	return len;
-}
-
-uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, size_t len)
-{
-	if (pdu == NULL)
-		return 0;
-
-	/* Attribute Opcode (1 octet) */
-	pdu[0] = ATT_OP_READ_REQ;
-	/* Attribute Handle (2 octets) */
-	put_le16(handle, &pdu[1]);
-
-	return 3;
-}
-
-uint16_t enc_read_blob_req(uint16_t handle, uint16_t offset, uint8_t *pdu,
-								size_t len)
-{
-	if (pdu == NULL)
-		return 0;
-
-	/* Attribute Opcode (1 octet) */
-	pdu[0] = ATT_OP_READ_BLOB_REQ;
-	/* Attribute Handle (2 octets) */
-	put_le16(handle, &pdu[1]);
-	/* Value Offset (2 octets) */
-	put_le16(offset, &pdu[3]);
-
-	return 5;
-}
-
-uint16_t dec_read_req(const uint8_t *pdu, size_t len, uint16_t *handle)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (handle == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (pdu[0] != ATT_OP_READ_REQ)
-		return 0;
-
-	*handle = get_le16(&pdu[1]);
-
-	return min_len;
-}
-
-uint16_t dec_read_blob_req(const uint8_t *pdu, size_t len, uint16_t *handle,
-							uint16_t *offset)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle) +
-							sizeof(*offset);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (handle == NULL)
-		return 0;
-
-	if (offset == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (pdu[0] != ATT_OP_READ_BLOB_REQ)
-		return 0;
-
-	*handle = get_le16(&pdu[1]);
-	*offset = get_le16(&pdu[3]);
-
-	return min_len;
-}
-
-uint16_t enc_read_resp(uint8_t *value, size_t vlen, uint8_t *pdu, size_t len)
-{
-	if (pdu == NULL)
-		return 0;
-
-	/* If the attribute value length is longer than the allowed PDU size,
-	 * send only the octets that fit on the PDU. The remaining octets can
-	 * be requested using the Read Blob Request. */
-	if (vlen > len - 1)
-		vlen = len - 1;
-
-	pdu[0] = ATT_OP_READ_RESP;
-
-	memcpy(pdu + 1, value, vlen);
-
-	return vlen + 1;
-}
-
-uint16_t enc_read_blob_resp(uint8_t *value, size_t vlen, uint16_t offset,
-						uint8_t *pdu, size_t len)
-{
-	if (pdu == NULL)
-		return 0;
-
-	vlen -= offset;
-	if (vlen > len - 1)
-		vlen = len - 1;
-
-	pdu[0] = ATT_OP_READ_BLOB_RESP;
-
-	memcpy(pdu + 1, &value[offset], vlen);
-
-	return vlen + 1;
-}
-
-ssize_t dec_read_resp(const uint8_t *pdu, size_t len, uint8_t *value,
-								size_t vlen)
-{
-	if (pdu == NULL)
-		return -EINVAL;
-
-	if (pdu[0] != ATT_OP_READ_RESP)
-		return -EINVAL;
-
-	if (value == NULL)
-		return len - 1;
-
-	if (vlen < (len - 1))
-		return -ENOBUFS;
-
-	memcpy(value, pdu + 1, len - 1);
-
-	return len - 1;
-}
-
-uint16_t enc_error_resp(uint8_t opcode, uint16_t handle, uint8_t status,
-						uint8_t *pdu, size_t len)
-{
-	/* Attribute Opcode (1 octet) */
-	pdu[0] = ATT_OP_ERROR;
-	/* Request Opcode In Error (1 octet) */
-	pdu[1] = opcode;
-	/* Attribute Handle In Error (2 octets) */
-	put_le16(handle, &pdu[2]);
-	/* Error Code (1 octet) */
-	pdu[4] = status;
-
-	return 5;
-}
-
-uint16_t enc_find_info_req(uint16_t start, uint16_t end, uint8_t *pdu,
-								size_t len)
-{
-	if (pdu == NULL)
-		return 0;
-
-	/* Attribute Opcode (1 octet) */
-	pdu[0] = ATT_OP_FIND_INFO_REQ;
-	/* Starting Handle (2 octets) */
-	put_le16(start, &pdu[1]);
-	/* Ending Handle (2 octets) */
-	put_le16(end, &pdu[3]);
-
-	return 5;
-}
-
-uint16_t dec_find_info_req(const uint8_t *pdu, size_t len, uint16_t *start,
-								uint16_t *end)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*start) + sizeof(*end);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (start == NULL || end == NULL)
-		return 0;
-
-	if (pdu[0] != ATT_OP_FIND_INFO_REQ)
-		return 0;
-
-	*start = get_le16(&pdu[1]);
-	*end = get_le16(&pdu[3]);
-
-	return min_len;
-}
-
-uint16_t enc_find_info_resp(uint8_t format, struct att_data_list *list,
-						uint8_t *pdu, size_t len)
-{
-	uint8_t *ptr;
-	size_t i, w;
-
-	if (pdu == NULL)
-		return 0;
-
-	if (list == NULL)
-		return 0;
-
-	if (len < list->len + sizeof(uint8_t) * 2)
-		return 0;
-
-	pdu[0] = ATT_OP_FIND_INFO_RESP;
-	pdu[1] = format;
-	ptr = (void *) &pdu[2];
-
-	for (i = 0, w = 2; i < list->num && w + list->len <= len; i++) {
-		memcpy(ptr, list->data[i], list->len);
-		ptr += list->len;
-		w += list->len;
-	}
-
-	return w;
-}
-
-struct att_data_list *dec_find_info_resp(const uint8_t *pdu, size_t len,
-							uint8_t *format)
-{
-	struct att_data_list *list;
-	uint8_t *ptr;
-	uint16_t elen, num;
-	int i;
-
-	if (pdu == NULL)
-		return 0;
-
-	if (format == NULL)
-		return 0;
-
-	if (pdu[0] != ATT_OP_FIND_INFO_RESP)
-		return 0;
-
-	*format = pdu[1];
-	elen = sizeof(pdu[0]) + sizeof(*format);
-	if (*format == 0x01)
-		elen += 2;
-	else if (*format == 0x02)
-		elen += 16;
-
-	num = (len - 2) / elen;
-
-	ptr = (void *) &pdu[2];
-
-	list = att_data_list_alloc(num, elen);
-	if (list == NULL)
-		return NULL;
-
-	for (i = 0; i < num; i++) {
-		memcpy(list->data[i], ptr, list->len);
-		ptr += list->len;
-	}
-
-	return list;
-}
-
-uint16_t enc_notification(uint16_t handle, uint8_t *value, size_t vlen,
-						uint8_t *pdu, size_t len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(uint16_t);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (len < (vlen + min_len))
-		return 0;
-
-	pdu[0] = ATT_OP_HANDLE_NOTIFY;
-	put_le16(handle, &pdu[1]);
-	memcpy(&pdu[3], value, vlen);
-
-	return vlen + min_len;
-}
-
-uint16_t enc_indication(uint16_t handle, uint8_t *value, size_t vlen,
-						uint8_t *pdu, size_t len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(uint16_t);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (len < (vlen + min_len))
-		return 0;
-
-	pdu[0] = ATT_OP_HANDLE_IND;
-	put_le16(handle, &pdu[1]);
-	memcpy(&pdu[3], value, vlen);
-
-	return vlen + min_len;
-}
-
-uint16_t dec_indication(const uint8_t *pdu, size_t len, uint16_t *handle,
-						uint8_t *value, size_t vlen)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(uint16_t);
-	uint16_t dlen;
-
-	if (pdu == NULL)
-		return 0;
-
-	if (pdu[0] != ATT_OP_HANDLE_IND)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	dlen = MIN(len - min_len, vlen);
-
-	if (handle)
-		*handle = get_le16(&pdu[1]);
-
-	memcpy(value, &pdu[3], dlen);
-
-	return dlen;
-}
-
-uint16_t enc_confirmation(uint8_t *pdu, size_t len)
-{
-	if (pdu == NULL)
-		return 0;
-
-	/* Attribute Opcode (1 octet) */
-	pdu[0] = ATT_OP_HANDLE_CNF;
-
-	return 1;
-}
-
-uint16_t enc_mtu_req(uint16_t mtu, uint8_t *pdu, size_t len)
-{
-	if (pdu == NULL)
-		return 0;
-
-	/* Attribute Opcode (1 octet) */
-	pdu[0] = ATT_OP_MTU_REQ;
-	/* Client Rx MTU (2 octets) */
-	put_le16(mtu, &pdu[1]);
-
-	return 3;
-}
-
-uint16_t dec_mtu_req(const uint8_t *pdu, size_t len, uint16_t *mtu)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*mtu);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (mtu == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (pdu[0] != ATT_OP_MTU_REQ)
-		return 0;
-
-	*mtu = get_le16(&pdu[1]);
-
-	return min_len;
-}
-
-uint16_t enc_mtu_resp(uint16_t mtu, uint8_t *pdu, size_t len)
-{
-	if (pdu == NULL)
-		return 0;
-
-	/* Attribute Opcode (1 octet) */
-	pdu[0] = ATT_OP_MTU_RESP;
-	/* Server Rx MTU (2 octets) */
-	put_le16(mtu, &pdu[1]);
-
-	return 3;
-}
-
-uint16_t dec_mtu_resp(const uint8_t *pdu, size_t len, uint16_t *mtu)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*mtu);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (mtu == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (pdu[0] != ATT_OP_MTU_RESP)
-		return 0;
-
-	*mtu = get_le16(&pdu[1]);
-
-	return min_len;
-}
-
-uint16_t enc_prep_write_req(uint16_t handle, uint16_t offset,
-					const uint8_t *value, size_t vlen,
-					uint8_t *pdu, size_t len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle) +
-								sizeof(offset);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (vlen > len - min_len)
-		vlen = len - min_len;
-
-	pdu[0] = ATT_OP_PREP_WRITE_REQ;
-	put_le16(handle, &pdu[1]);
-	put_le16(offset, &pdu[3]);
-
-	if (vlen > 0) {
-		memcpy(&pdu[5], value, vlen);
-		return min_len + vlen;
-	}
-
-	return min_len;
-}
-
-uint16_t dec_prep_write_req(const uint8_t *pdu, size_t len, uint16_t *handle,
-				uint16_t *offset, uint8_t *value, size_t *vlen)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle) +
-							sizeof(*offset);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (handle == NULL || offset == NULL || value == NULL || vlen == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (pdu[0] != ATT_OP_PREP_WRITE_REQ)
-		return 0;
-
-	*handle = get_le16(&pdu[1]);
-	*offset = get_le16(&pdu[3]);
-
-	*vlen = len - min_len;
-	if (*vlen > 0)
-		memcpy(value, pdu + min_len, *vlen);
-
-	return len;
-}
-
-uint16_t enc_prep_write_resp(uint16_t handle, uint16_t offset,
-					const uint8_t *value, size_t vlen,
-					uint8_t *pdu, size_t len)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle) +
-								sizeof(offset);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (vlen > len - min_len)
-		vlen = len - min_len;
-
-	pdu[0] = ATT_OP_PREP_WRITE_RESP;
-	put_le16(handle, &pdu[1]);
-	put_le16(offset, &pdu[3]);
-
-	if (vlen > 0) {
-		memcpy(&pdu[5], value, vlen);
-		return min_len + vlen;
-	}
-
-	return min_len;
-}
-
-uint16_t dec_prep_write_resp(const uint8_t *pdu, size_t len, uint16_t *handle,
-				uint16_t *offset, uint8_t *value, size_t *vlen)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*handle) +
-								sizeof(*offset);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (handle == NULL || offset == NULL || value == NULL || vlen == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (pdu[0] != ATT_OP_PREP_WRITE_REQ)
-		return 0;
-
-	*handle = get_le16(&pdu[1]);
-	*offset = get_le16(&pdu[3]);
-	*vlen = len - min_len;
-	if (*vlen > 0)
-		memcpy(value, pdu + min_len, *vlen);
-
-	return len;
-}
-
-uint16_t enc_exec_write_req(uint8_t flags, uint8_t *pdu, size_t len)
-{
-	if (pdu == NULL)
-		return 0;
-
-	if (flags > 1)
-		return 0;
-
-	/* Attribute Opcode (1 octet) */
-	pdu[0] = ATT_OP_EXEC_WRITE_REQ;
-	/* Flags (1 octet) */
-	pdu[1] = flags;
-
-	return 2;
-}
-
-uint16_t dec_exec_write_req(const uint8_t *pdu, size_t len, uint8_t *flags)
-{
-	const uint16_t min_len = sizeof(pdu[0]) + sizeof(*flags);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (flags == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (pdu[0] != ATT_OP_EXEC_WRITE_REQ)
-		return 0;
-
-	*flags = pdu[1];
-
-	return min_len;
-}
-
-uint16_t enc_exec_write_resp(uint8_t *pdu)
-{
-	if (pdu == NULL)
-		return 0;
-
-	/* Attribute Opcode (1 octet) */
-	pdu[0] = ATT_OP_EXEC_WRITE_RESP;
-
-	return 1;
-}
-
-uint16_t dec_exec_write_resp(const uint8_t *pdu, size_t len)
-{
-	const uint16_t min_len = sizeof(pdu[0]);
-
-	if (pdu == NULL)
-		return 0;
-
-	if (len < min_len)
-		return 0;
-
-	if (pdu[0] != ATT_OP_EXEC_WRITE_RESP)
-		return 0;
-
-	return len;
-}
diff --git a/attrib/att.h b/attrib/att.h
deleted file mode 100644
index 8d6ca5930859..000000000000
--- a/attrib/att.h
+++ /dev/null
@@ -1,186 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2010  Nokia Corporation
- *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- */
-
-#include "src/shared/crypto.h"
-
-/* Len of signature in write signed packet */
-#define ATT_SIGNATURE_LEN		12
-
-/* Attribute Protocol Opcodes */
-#define ATT_OP_ERROR			0x01
-#define ATT_OP_MTU_REQ			0x02
-#define ATT_OP_MTU_RESP			0x03
-#define ATT_OP_FIND_INFO_REQ		0x04
-#define ATT_OP_FIND_INFO_RESP		0x05
-#define ATT_OP_FIND_BY_TYPE_REQ		0x06
-#define ATT_OP_FIND_BY_TYPE_RESP	0x07
-#define ATT_OP_READ_BY_TYPE_REQ		0x08
-#define ATT_OP_READ_BY_TYPE_RESP	0x09
-#define ATT_OP_READ_REQ			0x0A
-#define ATT_OP_READ_RESP		0x0B
-#define ATT_OP_READ_BLOB_REQ		0x0C
-#define ATT_OP_READ_BLOB_RESP		0x0D
-#define ATT_OP_READ_MULTI_REQ		0x0E
-#define ATT_OP_READ_MULTI_RESP		0x0F
-#define ATT_OP_READ_BY_GROUP_REQ	0x10
-#define ATT_OP_READ_BY_GROUP_RESP	0x11
-#define ATT_OP_WRITE_REQ		0x12
-#define ATT_OP_WRITE_RESP		0x13
-#define ATT_OP_WRITE_CMD		0x52
-#define ATT_OP_PREP_WRITE_REQ		0x16
-#define ATT_OP_PREP_WRITE_RESP		0x17
-#define ATT_OP_EXEC_WRITE_REQ		0x18
-#define ATT_OP_EXEC_WRITE_RESP		0x19
-#define ATT_OP_HANDLE_NOTIFY		0x1B
-#define ATT_OP_HANDLE_IND		0x1D
-#define ATT_OP_HANDLE_CNF		0x1E
-#define ATT_OP_SIGNED_WRITE_CMD		0xD2
-
-/* Error codes for Error response PDU */
-#define ATT_ECODE_INVALID_HANDLE		0x01
-#define ATT_ECODE_READ_NOT_PERM			0x02
-#define ATT_ECODE_WRITE_NOT_PERM		0x03
-#define ATT_ECODE_INVALID_PDU			0x04
-#define ATT_ECODE_AUTHENTICATION		0x05
-#define ATT_ECODE_REQ_NOT_SUPP			0x06
-#define ATT_ECODE_INVALID_OFFSET		0x07
-#define ATT_ECODE_AUTHORIZATION			0x08
-#define ATT_ECODE_PREP_QUEUE_FULL		0x09
-#define ATT_ECODE_ATTR_NOT_FOUND		0x0A
-#define ATT_ECODE_ATTR_NOT_LONG			0x0B
-#define ATT_ECODE_INSUFF_ENCR_KEY_SIZE		0x0C
-#define ATT_ECODE_INVAL_ATTR_VALUE_LEN		0x0D
-#define ATT_ECODE_UNLIKELY			0x0E
-#define ATT_ECODE_INSUFF_ENC			0x0F
-#define ATT_ECODE_UNSUPP_GRP_TYPE		0x10
-#define ATT_ECODE_INSUFF_RESOURCES		0x11
-/* Application error */
-#define ATT_ECODE_IO				0x80
-#define ATT_ECODE_TIMEOUT			0x81
-#define ATT_ECODE_ABORTED			0x82
-
-#define ATT_MAX_VALUE_LEN			512
-#define ATT_DEFAULT_L2CAP_MTU			48
-#define ATT_DEFAULT_LE_MTU			23
-
-/* Flags for Execute Write Request Operation */
-#define ATT_CANCEL_ALL_PREP_WRITES		0x00
-#define ATT_WRITE_ALL_PREP_WRITES		0x01
-
-/* Find Information Response Formats */
-#define ATT_FIND_INFO_RESP_FMT_16BIT		0x01
-#define ATT_FIND_INFO_RESP_FMT_128BIT		0x02
-
-struct att_data_list {
-	uint16_t num;
-	uint16_t len;
-	uint8_t **data;
-};
-
-struct att_range {
-	uint16_t start;
-	uint16_t end;
-};
-
-struct att_data_list *att_data_list_alloc(uint16_t num, uint16_t len);
-void att_data_list_free(struct att_data_list *list);
-
-const char *att_ecode2str(uint8_t status);
-uint16_t enc_read_by_grp_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
-						uint8_t *pdu, size_t len);
-uint16_t dec_read_by_grp_req(const uint8_t *pdu, size_t len, uint16_t *start,
-					uint16_t *end, bt_uuid_t *uuid);
-uint16_t enc_read_by_grp_resp(struct att_data_list *list, uint8_t *pdu,
-								size_t len);
-uint16_t enc_find_by_type_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
-				const uint8_t *value, size_t vlen, uint8_t *pdu,
-				size_t len);
-uint16_t dec_find_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
-		uint16_t *end, bt_uuid_t *uuid, uint8_t *value, size_t *vlen);
-uint16_t enc_find_by_type_resp(GSList *ranges, uint8_t *pdu, size_t len);
-GSList *dec_find_by_type_resp(const uint8_t *pdu, size_t len);
-struct att_data_list *dec_read_by_grp_resp(const uint8_t *pdu, size_t len);
-uint16_t enc_read_by_type_req(uint16_t start, uint16_t end, bt_uuid_t *uuid,
-						uint8_t *pdu, size_t len);
-uint16_t dec_read_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
-					uint16_t *end, bt_uuid_t *uuid);
-uint16_t enc_read_by_type_resp(struct att_data_list *list, uint8_t *pdu,
-								size_t len);
-uint16_t enc_write_cmd(uint16_t handle, const uint8_t *value, size_t vlen,
-						uint8_t *pdu, size_t len);
-uint16_t dec_write_cmd(const uint8_t *pdu, size_t len, uint16_t *handle,
-						uint8_t *value, size_t *vlen);
-uint16_t enc_signed_write_cmd(uint16_t handle,
-					const uint8_t *value, size_t vlen,
-					struct bt_crypto *crypto,
-					const uint8_t csrk[16],
-					uint32_t sign_cnt,
-					uint8_t *pdu, size_t len);
-uint16_t dec_signed_write_cmd(const uint8_t *pdu, size_t len,
-						uint16_t *handle,
-						uint8_t *value, size_t *vlen,
-						uint8_t signature[12]);
-struct att_data_list *dec_read_by_type_resp(const uint8_t *pdu, size_t len);
-uint16_t enc_write_req(uint16_t handle, const uint8_t *value, size_t vlen,
-						uint8_t *pdu, size_t len);
-uint16_t dec_write_req(const uint8_t *pdu, size_t len, uint16_t *handle,
-						uint8_t *value, size_t *vlen);
-uint16_t enc_write_resp(uint8_t *pdu);
-uint16_t dec_write_resp(const uint8_t *pdu, size_t len);
-uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, size_t len);
-uint16_t enc_read_blob_req(uint16_t handle, uint16_t offset, uint8_t *pdu,
-								size_t len);
-uint16_t dec_read_req(const uint8_t *pdu, size_t len, uint16_t *handle);
-uint16_t dec_read_blob_req(const uint8_t *pdu, size_t len, uint16_t *handle,
-							uint16_t *offset);
-uint16_t enc_read_resp(uint8_t *value, size_t vlen, uint8_t *pdu, size_t len);
-uint16_t enc_read_blob_resp(uint8_t *value, size_t vlen, uint16_t offset,
-						uint8_t *pdu, size_t len);
-ssize_t dec_read_resp(const uint8_t *pdu, size_t len, uint8_t *value,
-								size_t vlen);
-uint16_t enc_error_resp(uint8_t opcode, uint16_t handle, uint8_t status,
-						uint8_t *pdu, size_t len);
-uint16_t enc_find_info_req(uint16_t start, uint16_t end, uint8_t *pdu,
-								size_t len);
-uint16_t dec_find_info_req(const uint8_t *pdu, size_t len, uint16_t *start,
-								uint16_t *end);
-uint16_t enc_find_info_resp(uint8_t format, struct att_data_list *list,
-						uint8_t *pdu, size_t len);
-struct att_data_list *dec_find_info_resp(const uint8_t *pdu, size_t len,
-							uint8_t *format);
-uint16_t enc_notification(uint16_t handle, uint8_t *value, size_t vlen,
-						uint8_t *pdu, size_t len);
-uint16_t enc_indication(uint16_t handle, uint8_t *value, size_t vlen,
-						uint8_t *pdu, size_t len);
-uint16_t dec_indication(const uint8_t *pdu, size_t len, uint16_t *handle,
-						uint8_t *value, size_t vlen);
-uint16_t enc_confirmation(uint8_t *pdu, size_t len);
-
-uint16_t enc_mtu_req(uint16_t mtu, uint8_t *pdu, size_t len);
-uint16_t dec_mtu_req(const uint8_t *pdu, size_t len, uint16_t *mtu);
-uint16_t enc_mtu_resp(uint16_t mtu, uint8_t *pdu, size_t len);
-uint16_t dec_mtu_resp(const uint8_t *pdu, size_t len, uint16_t *mtu);
-
-uint16_t enc_prep_write_req(uint16_t handle, uint16_t offset,
-					const uint8_t *value, size_t vlen,
-					uint8_t *pdu, size_t len);
-uint16_t dec_prep_write_req(const uint8_t *pdu, size_t len, uint16_t *handle,
-				uint16_t *offset, uint8_t *value, size_t *vlen);
-uint16_t enc_prep_write_resp(uint16_t handle, uint16_t offset,
-					const uint8_t *value, size_t vlen,
-					uint8_t *pdu, size_t len);
-uint16_t dec_prep_write_resp(const uint8_t *pdu, size_t len, uint16_t *handle,
-						uint16_t *offset, uint8_t *value,
-						size_t *vlen);
-uint16_t enc_exec_write_req(uint8_t flags, uint8_t *pdu, size_t len);
-uint16_t dec_exec_write_req(const uint8_t *pdu, size_t len, uint8_t *flags);
-uint16_t enc_exec_write_resp(uint8_t *pdu);
-uint16_t dec_exec_write_resp(const uint8_t *pdu, size_t len);
diff --git a/attrib/gatt.c b/attrib/gatt.c
deleted file mode 100644
index 335094f37b09..000000000000
--- a/attrib/gatt.c
+++ /dev/null
@@ -1,103 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2010  Nokia Corporation
- *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdint.h>
-#include <stdlib.h>
-#include <string.h>
-
-#include <glib.h>
-
-#include "bluetooth/bluetooth.h"
-#include "bluetooth/sdp.h"
-#include "bluetooth/sdp_lib.h"
-#include "bluetooth/uuid.h"
-
-#include "att.h"
-#include "gatt.h"
-
-static sdp_data_t *proto_seq_find(sdp_list_t *proto_list)
-{
-	sdp_list_t *list;
-	uuid_t proto;
-
-	sdp_uuid16_create(&proto, ATT_UUID);
-
-	for (list = proto_list; list; list = list->next) {
-		sdp_list_t *p;
-		for (p = list->data; p; p = p->next) {
-			sdp_data_t *seq = p->data;
-			if (seq && seq->dtd == SDP_UUID16 &&
-				sdp_uuid16_cmp(&proto, &seq->val.uuid) == 0)
-				return seq->next;
-		}
-	}
-
-	return NULL;
-}
-
-static gboolean parse_proto_params(sdp_list_t *proto_list, uint16_t *psm,
-						uint16_t *start, uint16_t *end)
-{
-	sdp_data_t *seq1, *seq2;
-
-	if (psm)
-		*psm = sdp_get_proto_port(proto_list, L2CAP_UUID);
-
-	/* Getting start and end handle */
-	seq1 = proto_seq_find(proto_list);
-	if (!seq1 || seq1->dtd != SDP_UINT16)
-		return FALSE;
-
-	seq2 = seq1->next;
-	if (!seq2 || seq2->dtd != SDP_UINT16)
-		return FALSE;
-
-	if (start)
-		*start = seq1->val.uint16;
-
-	if (end)
-		*end = seq2->val.uint16;
-
-	return TRUE;
-}
-
-gboolean gatt_parse_record(const sdp_record_t *rec,
-					uuid_t *prim_uuid, uint16_t *psm,
-					uint16_t *start, uint16_t *end)
-{
-	sdp_list_t *list;
-	uuid_t uuid;
-	gboolean ret;
-
-	if (sdp_get_service_classes(rec, &list) < 0)
-		return FALSE;
-
-	memcpy(&uuid, list->data, sizeof(uuid));
-	sdp_list_free(list, free);
-
-	if (sdp_get_access_protos(rec, &list) < 0)
-		return FALSE;
-
-	ret = parse_proto_params(list, psm, start, end);
-
-	sdp_list_foreach(list, (sdp_list_func_t) sdp_list_free, NULL);
-	sdp_list_free(list, NULL);
-
-	/* FIXME: replace by bt_uuid_t after uuid_t/sdp code cleanup */
-	if (ret && prim_uuid)
-		memcpy(prim_uuid, &uuid, sizeof(uuid_t));
-
-	return ret;
-}
diff --git a/attrib/gatt.h b/attrib/gatt.h
deleted file mode 100644
index 0fe81db06fe6..000000000000
--- a/attrib/gatt.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2010  Nokia Corporation
- *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- */
-
-struct gatt_primary {
-	char uuid[MAX_LEN_UUID_STR + 1];
-	gboolean changed;
-	struct att_range range;
-};
-
-gboolean gatt_parse_record(const sdp_record_t *rec,
-					uuid_t *prim_uuid, uint16_t *psm,
-					uint16_t *start, uint16_t *end);
diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 2fe1f4aca2cf..ce4564356c33 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -40,7 +40,6 @@
 #include "src/service.h"
 #include "src/log.h"
 #include "src/battery.h"
-#include "attrib/att.h"
 
 #define BATTERY_INTERFACE "org.bluez.Battery1"
 
@@ -128,7 +127,7 @@ static void batt_io_ccc_written_cb(uint16_t att_ecode, void *user_data)
 
 	if (att_ecode != 0) {
 		error("Battery Level: notifications not enabled %s",
-		      att_ecode2str(att_ecode));
+		      bt_att_ecode2str(att_ecode));
 		return;
 	}
 
diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index b1f6fb3ff749..2aaec84a8a4b 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -31,7 +31,6 @@
 #include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
-#include "attrib/att.h"
 #include "src/log.h"
 
 #define PNP_ID_SIZE	7
@@ -43,7 +42,7 @@ static void read_pnpid_cb(bool success, uint8_t att_ecode, const uint8_t *value,
 
 	if (!success) {
 		error("Error reading PNP_ID value: %s",
-						att_ecode2str(att_ecode));
+						bt_att_ecode2str(att_ecode));
 		return;
 	}
 
diff --git a/profiles/midi/midi.c b/profiles/midi/midi.c
index ea4719b95b23..f432ccde92f8 100644
--- a/profiles/midi/midi.c
+++ b/profiles/midi/midi.c
@@ -31,7 +31,6 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/io.h"
 #include "src/log.h"
-#include "attrib/att.h"
 
 #include "libmidi.h"
 
@@ -134,7 +133,7 @@ static void midi_io_ccc_written_cb(uint16_t att_ecode, void *user_data)
 {
 	if (att_ecode != 0) {
 		error("MIDI I/O: notifications not enabled %s",
-		      att_ecode2str(att_ecode));
+		      bt_att_ecode2str(att_ecode));
 		return;
 	}
 
diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index f3f677c4b4bb..0fffd3e032b7 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -33,7 +33,6 @@
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
 #include "src/shared/rap.h"
-#include "attrib/att.h"
 #include "src/log.h"
 #include "src/shared/cs-types.h"
 #include "src/btd.h"
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index a66f80eabf3e..d3c0809042be 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -31,7 +31,6 @@
 #include "src/shared/queue.h"
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
-#include "attrib/att.h"
 #include "src/btd.h"
 
 #define SCAN_INTERVAL_WIN_UUID		0x2A4F
@@ -91,7 +90,7 @@ static void refresh_ccc_written_cb(uint16_t att_ecode, void *user_data)
 {
 	if (att_ecode != 0) {
 		error("Scan Refresh: notifications not enabled %s",
-						att_ecode2str(att_ecode));
+						bt_att_ecode2str(att_ecode));
 		return;
 	}
 
diff --git a/src/adapter.c b/src/adapter.c
index 4131c4431dc6..b33192641047 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -45,6 +45,7 @@
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/att.h"
+#include "src/shared/crypto.h"
 #include "src/shared/gatt-db.h"
 #include "src/shared/timeout.h"
 
@@ -59,8 +60,6 @@
 #include "uuid-helper.h"
 #include "agent.h"
 #include "storage.h"
-#include "attrib/att.h"
-#include "attrib/gatt.h"
 #include "gatt-database.h"
 #include "advertising.h"
 #include "adv_monitor.h"
diff --git a/src/device.c b/src/device.c
index 7ed32a63cf19..a8bd29b7018c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -38,6 +38,7 @@
 #include "log.h"
 #include "src/shared/util.h"
 #include "src/shared/att.h"
+#include "src/shared/crypto.h"
 #include "src/shared/queue.h"
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
@@ -46,8 +47,6 @@
 #include "src/shared/timeout.h"
 #include "btio/btio.h"
 #include "bluetooth/mgmt.h"
-#include "attrib/att.h"
-#include "attrib/gatt.h"
 #include "btd.h"
 #include "adapter.h"
 #include "gatt-database.h"
@@ -6477,6 +6476,81 @@ static bool remote_counter(uint32_t *sign_cnt, void *user_data)
 	return true;
 }
 
+static sdp_data_t *proto_seq_find(sdp_list_t *proto_list)
+{
+	sdp_list_t *list;
+	uuid_t proto;
+
+	sdp_uuid16_create(&proto, ATT_UUID);
+
+	for (list = proto_list; list; list = list->next) {
+		sdp_list_t *p;
+		for (p = list->data; p; p = p->next) {
+			sdp_data_t *seq = p->data;
+			if (seq && seq->dtd == SDP_UUID16 &&
+				sdp_uuid16_cmp(&proto, &seq->val.uuid) == 0)
+				return seq->next;
+		}
+	}
+
+	return NULL;
+}
+
+static gboolean parse_proto_params(sdp_list_t *proto_list, uint16_t *psm,
+						uint16_t *start, uint16_t *end)
+{
+	sdp_data_t *seq1, *seq2;
+
+	if (psm)
+		*psm = sdp_get_proto_port(proto_list, L2CAP_UUID);
+
+	/* Getting start and end handle */
+	seq1 = proto_seq_find(proto_list);
+	if (!seq1 || seq1->dtd != SDP_UINT16)
+		return FALSE;
+
+	seq2 = seq1->next;
+	if (!seq2 || seq2->dtd != SDP_UINT16)
+		return FALSE;
+
+	if (start)
+		*start = seq1->val.uint16;
+
+	if (end)
+		*end = seq2->val.uint16;
+
+	return TRUE;
+}
+
+gboolean gatt_parse_record(const sdp_record_t *rec,
+					uuid_t *prim_uuid, uint16_t *psm,
+					uint16_t *start, uint16_t *end)
+{
+	sdp_list_t *list;
+	uuid_t uuid;
+	gboolean ret;
+
+	if (sdp_get_service_classes(rec, &list) < 0)
+		return FALSE;
+
+	memcpy(&uuid, list->data, sizeof(uuid));
+	sdp_list_free(list, free);
+
+	if (sdp_get_access_protos(rec, &list) < 0)
+		return FALSE;
+
+	ret = parse_proto_params(list, psm, start, end);
+
+	sdp_list_foreach(list, (sdp_list_func_t) sdp_list_free, NULL);
+	sdp_list_free(list, NULL);
+
+	/* FIXME: replace by bt_uuid_t after uuid_t/sdp code cleanup */
+	if (ret && prim_uuid)
+		memcpy(prim_uuid, &uuid, sizeof(uuid_t));
+
+	return ret;
+}
+
 bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 {
 	GError *gerr = NULL;
diff --git a/src/device.h b/src/device.h
index f18fa5b2119f..fdc036ec4dae 100644
--- a/src/device.h
+++ b/src/device.h
@@ -9,6 +9,7 @@
  *
  */
 
+#include "bluetooth/uuid.h"
 #include "src/shared/queue.h"
 
 #define DEVICE_INTERFACE	"org.bluez.Device1"
@@ -67,6 +68,18 @@ void btd_device_set_record(struct btd_device *device, const char *uuid,
 							const char *record);
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 						const char *uuid);
+struct gatt_primary {
+	char uuid[MAX_LEN_UUID_STR + 1];
+	gboolean changed;
+	struct {
+		uint16_t start;
+		uint16_t end;
+	} range;
+};
+
+gboolean gatt_parse_record(const sdp_record_t *rec, uuid_t *prim_uuid,
+				uint16_t *psm, uint16_t *start, uint16_t *end);
+
 struct gatt_primary *btd_device_get_primary(struct btd_device *device,
 							const char *uuid);
 GSList *btd_device_get_primaries(struct btd_device *device);
diff --git a/src/shared/att.c b/src/shared/att.c
index 3d3c8cfa262a..e49743b5a764 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -2175,3 +2175,51 @@ done:
 
 	return true;
 }
+
+const char *bt_att_ecode2str(uint8_t ecode)
+{
+	switch (ecode) {
+	case BT_ATT_ERROR_INVALID_HANDLE:
+		return "Invalid handle";
+	case BT_ATT_ERROR_READ_NOT_PERMITTED:
+		return "Attribute can't be read";
+	case BT_ATT_ERROR_WRITE_NOT_PERMITTED:
+		return "Attribute can't be written";
+	case BT_ATT_ERROR_INVALID_PDU:
+		return "Attribute PDU was invalid";
+	case BT_ATT_ERROR_AUTHENTICATION:
+		return "Attribute requires authentication before read/write";
+	case BT_ATT_ERROR_REQUEST_NOT_SUPPORTED:
+		return "Server doesn't support the request received";
+	case BT_ATT_ERROR_INVALID_OFFSET:
+		return "Offset past the end of the attribute";
+	case BT_ATT_ERROR_AUTHORIZATION:
+		return "Attribute requires authorization before read/write";
+	case BT_ATT_ERROR_PREPARE_QUEUE_FULL:
+		return "Too many prepare writes have been queued";
+	case BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND:
+		return "No attribute found within the given range";
+	case BT_ATT_ERROR_ATTRIBUTE_NOT_LONG:
+		return "Attribute can't be read/written using Read Blob Req";
+	case BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE:
+		return "Encryption Key Size is insufficient";
+	case BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN:
+		return "Attribute value length is invalid";
+	case BT_ATT_ERROR_UNLIKELY:
+		return "Request attribute has encountered an unlikely error";
+	case BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION:
+		return "Encryption required before read/write";
+	case BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE:
+		return "Attribute type is not a supported grouping attribute";
+	case BT_ATT_ERROR_INSUFFICIENT_RESOURCES:
+		return "Insufficient Resources to complete the request";
+	case 0x80:
+		return "Internal application error: I/O";
+	case 0x81:
+		return "A timeout occurred";
+	case 0x82:
+		return "The operation was aborted";
+	default:
+		return "Unexpected error code";
+	}
+}
diff --git a/src/shared/att.h b/src/shared/att.h
index ba1f846777dc..5b5cd4fbab2c 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -29,6 +29,8 @@ bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close);
 
 int bt_att_get_fd(struct bt_att *att);
 
+const char *bt_att_ecode2str(uint8_t ecode);
+
 int bt_att_attach_fd(struct bt_att *att, int fd);
 
 int bt_att_get_channels(struct bt_att *att);
-- 
2.55.0

