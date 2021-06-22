Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37618C49EA5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 00:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16650610EA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 00:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhFVAn1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jun 2021 20:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhFVAn0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jun 2021 20:43:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D02C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 17:41:07 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id t32so3685635pfg.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 17:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1Uzxbm7k6t9iXc8+plgKxgpHb/FGcG8CqFTW71mSacY=;
        b=EqnMKVlNMAIr7+9JxhooTwRg+PBjZRReKtV8AeuScEja5AeW4YgU5WwIFJzd6R3FJz
         f5Gu2V3EDwMeVcjZyVQOdmVlLB6L0aI60qhLw3weFKIDj1T8HFUm0byZyv/0P4l/b5EU
         PZdYsm6SmmefOiWQcdPnnc6bXs1J3A3Ma0wCpXsJapXm34Hl8utJqruxTDC6qMqqxker
         voBRceT2kyIO64WH1OigebqYqIwQ/QVM7fdcwkiDcER0PxVPK0gKI9OzIfdFRPdRjK2m
         RvTWZSN00r2k5ZsYKkcenj8Dk0ffJbbenvO4hb5lxxZ5qg5sB3m6HnCCseMeqR6XSKsU
         dYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Uzxbm7k6t9iXc8+plgKxgpHb/FGcG8CqFTW71mSacY=;
        b=YUiFHguX5Ce1hiVerZ/1gkKKUcFZ2i4dLjXr71ldiX6d2fIoe+/znS3+fWb5BTLAIM
         2Im99b5C04kHBqYKA+JJbpz2xpHDooIZ2JA+0eWzCqhAUk/c84ysYZIWahWKjNntWWnO
         JNtzajhLPyzZqlALxE0xDj72y8FSmDiCtKO9qaMiq8NkuGK7gv9I2+4UdP3LDAWqG/Ff
         XlFxZ08UEg8TqE182/RiCEkp3rkPNVcBosuK/XY9DkrJ9XFTGdijX59FLINHPIpPAxiq
         /ddsq8K9p8wjx4bDGyRFrcHC/VFVoc2ZHLDkLA5QFQeobwUDTnVuUvUs/3t+sEem3/NB
         sRQA==
X-Gm-Message-State: AOAM531D2iqsgYM+njpFlTea7NIQPqhJ4x7PlaZ9uVj5UkFMS48+u7H1
        qgCK20Ts13/FgEl+g5QcbZLaduPjGYIoNw==
X-Google-Smtp-Source: ABdhPJxBvK+1roB2dgpNbLeNMk8CxDTnjcde3Dhy5uuPtyFHPOFJBFBh4e2D6YtlcuUvUE5kmEuC0w==
X-Received: by 2002:a63:1453:: with SMTP id 19mr1126254pgu.270.1624322466653;
        Mon, 21 Jun 2021 17:41:06 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h22sm6491985pfc.21.2021.06.21.17.41.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 17:41:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/7] Bluetooth: eir: Move EIR/Adv Data functions to its own file
Date:   Mon, 21 Jun 2021 17:40:59 -0700
Message-Id: <20210622004104.3179217-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622004104.3179217-1-luiz.dentz@gmail.com>
References: <20210622004104.3179217-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves functions manipulating EIR/Adv Data to its own file so it
can be reused by other files.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  39 +--
 net/bluetooth/Makefile           |   2 +-
 net/bluetooth/eir.c              | 335 +++++++++++++++++++++++++
 net/bluetooth/eir.h              |  72 ++++++
 net/bluetooth/hci_core.c         |  54 ++++
 net/bluetooth/hci_event.c        |   1 +
 net/bluetooth/hci_request.c      | 416 ++-----------------------------
 net/bluetooth/hci_request.h      |  23 --
 net/bluetooth/mgmt.c             |   3 +-
 9 files changed, 482 insertions(+), 463 deletions(-)
 create mode 100644 net/bluetooth/eir.c
 create mode 100644 net/bluetooth/eir.h

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7b8dac2131e7..f672b8390463 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1360,6 +1360,8 @@ int hci_set_adv_instance_data(struct hci_dev *hdev, u8 instance,
 			 u16 scan_rsp_len, u8 *scan_rsp_data);
 int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance);
 void hci_adv_instances_set_rpa_expired(struct hci_dev *hdev, bool rpa_expired);
+u32 hci_adv_instance_flags(struct hci_dev *hdev, u8 instance);
+bool hci_adv_instance_is_scannable(struct hci_dev *hdev, u8 instance);
 
 void hci_adv_monitors_clear(struct hci_dev *hdev);
 void hci_free_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor);
@@ -1605,43 +1607,6 @@ static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
 	mutex_unlock(&hci_cb_list_lock);
 }
 
-static inline void *eir_get_data(u8 *eir, size_t eir_len, u8 type,
-				 size_t *data_len)
-{
-	size_t parsed = 0;
-
-	if (eir_len < 2)
-		return NULL;
-
-	while (parsed < eir_len - 1) {
-		u8 field_len = eir[0];
-
-		if (field_len == 0)
-			break;
-
-		parsed += field_len + 1;
-
-		if (parsed > eir_len)
-			break;
-
-		if (eir[1] != type) {
-			eir += field_len + 1;
-			continue;
-		}
-
-		/* Zero length data */
-		if (field_len == 1)
-			return NULL;
-
-		if (data_len)
-			*data_len = field_len - 1;
-
-		return &eir[2];
-	}
-
-	return NULL;
-}
-
 static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
 {
 	if (addr_type != ADDR_LE_DEV_RANDOM)
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index cc0995301f93..0276e7d5d7ad 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -14,7 +14,7 @@ bluetooth_6lowpan-y := 6lowpan.o
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o lib.o \
-	ecdh_helper.o hci_request.o mgmt_util.o mgmt_config.o
+	ecdh_helper.o eir.o hci_request.o mgmt_util.o mgmt_config.o
 
 bluetooth-$(CONFIG_BT_BREDR) += sco.o
 bluetooth-$(CONFIG_BT_HS) += a2mp.o amp.o
diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
new file mode 100644
index 000000000000..7e930f77ecab
--- /dev/null
+++ b/net/bluetooth/eir.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BlueZ - Bluetooth protocol stack for Linux
+ *
+ * Copyright (C) 2021 Intel Corporation
+ */
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/mgmt.h>
+
+#include "eir.h"
+
+#define PNP_INFO_SVCLASS_ID		0x1200
+
+u8 eir_append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
+{
+	size_t short_len;
+	size_t complete_len;
+
+	/* no space left for name (+ NULL + type + len) */
+	if ((HCI_MAX_AD_LENGTH - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 3)
+		return ad_len;
+
+	/* use complete name if present and fits */
+	complete_len = strlen(hdev->dev_name);
+	if (complete_len && complete_len <= HCI_MAX_SHORT_NAME_LENGTH)
+		return eir_append_data(ptr, ad_len, EIR_NAME_COMPLETE,
+				       hdev->dev_name, complete_len + 1);
+
+	/* use short name if present */
+	short_len = strlen(hdev->short_name);
+	if (short_len)
+		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT,
+				       hdev->short_name, short_len + 1);
+
+	/* use shortened full name if present, we already know that name
+	 * is longer then HCI_MAX_SHORT_NAME_LENGTH
+	 */
+	if (complete_len) {
+		u8 name[HCI_MAX_SHORT_NAME_LENGTH + 1];
+
+		memcpy(name, hdev->dev_name, HCI_MAX_SHORT_NAME_LENGTH);
+		name[HCI_MAX_SHORT_NAME_LENGTH] = '\0';
+
+		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT, name,
+				       sizeof(name));
+	}
+
+	return ad_len;
+}
+
+u8 eir_append_appearance(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
+{
+	return eir_append_le16(ptr, ad_len, EIR_APPEARANCE, hdev->appearance);
+}
+
+static u8 *create_uuid16_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
+{
+	u8 *ptr = data, *uuids_start = NULL;
+	struct bt_uuid *uuid;
+
+	if (len < 4)
+		return ptr;
+
+	list_for_each_entry(uuid, &hdev->uuids, list) {
+		u16 uuid16;
+
+		if (uuid->size != 16)
+			continue;
+
+		uuid16 = get_unaligned_le16(&uuid->uuid[12]);
+		if (uuid16 < 0x1100)
+			continue;
+
+		if (uuid16 == PNP_INFO_SVCLASS_ID)
+			continue;
+
+		if (!uuids_start) {
+			uuids_start = ptr;
+			uuids_start[0] = 1;
+			uuids_start[1] = EIR_UUID16_ALL;
+			ptr += 2;
+		}
+
+		/* Stop if not enough space to put next UUID */
+		if ((ptr - data) + sizeof(u16) > len) {
+			uuids_start[1] = EIR_UUID16_SOME;
+			break;
+		}
+
+		*ptr++ = (uuid16 & 0x00ff);
+		*ptr++ = (uuid16 & 0xff00) >> 8;
+		uuids_start[0] += sizeof(uuid16);
+	}
+
+	return ptr;
+}
+
+static u8 *create_uuid32_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
+{
+	u8 *ptr = data, *uuids_start = NULL;
+	struct bt_uuid *uuid;
+
+	if (len < 6)
+		return ptr;
+
+	list_for_each_entry(uuid, &hdev->uuids, list) {
+		if (uuid->size != 32)
+			continue;
+
+		if (!uuids_start) {
+			uuids_start = ptr;
+			uuids_start[0] = 1;
+			uuids_start[1] = EIR_UUID32_ALL;
+			ptr += 2;
+		}
+
+		/* Stop if not enough space to put next UUID */
+		if ((ptr - data) + sizeof(u32) > len) {
+			uuids_start[1] = EIR_UUID32_SOME;
+			break;
+		}
+
+		memcpy(ptr, &uuid->uuid[12], sizeof(u32));
+		ptr += sizeof(u32);
+		uuids_start[0] += sizeof(u32);
+	}
+
+	return ptr;
+}
+
+static u8 *create_uuid128_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
+{
+	u8 *ptr = data, *uuids_start = NULL;
+	struct bt_uuid *uuid;
+
+	if (len < 18)
+		return ptr;
+
+	list_for_each_entry(uuid, &hdev->uuids, list) {
+		if (uuid->size != 128)
+			continue;
+
+		if (!uuids_start) {
+			uuids_start = ptr;
+			uuids_start[0] = 1;
+			uuids_start[1] = EIR_UUID128_ALL;
+			ptr += 2;
+		}
+
+		/* Stop if not enough space to put next UUID */
+		if ((ptr - data) + 16 > len) {
+			uuids_start[1] = EIR_UUID128_SOME;
+			break;
+		}
+
+		memcpy(ptr, uuid->uuid, 16);
+		ptr += 16;
+		uuids_start[0] += 16;
+	}
+
+	return ptr;
+}
+
+void eir_create(struct hci_dev *hdev, u8 *data)
+{
+	u8 *ptr = data;
+	size_t name_len;
+
+	name_len = strlen(hdev->dev_name);
+
+	if (name_len > 0) {
+		/* EIR Data type */
+		if (name_len > 48) {
+			name_len = 48;
+			ptr[1] = EIR_NAME_SHORT;
+		} else {
+			ptr[1] = EIR_NAME_COMPLETE;
+		}
+
+		/* EIR Data length */
+		ptr[0] = name_len + 1;
+
+		memcpy(ptr + 2, hdev->dev_name, name_len);
+
+		ptr += (name_len + 2);
+	}
+
+	if (hdev->inq_tx_power != HCI_TX_POWER_INVALID) {
+		ptr[0] = 2;
+		ptr[1] = EIR_TX_POWER;
+		ptr[2] = (u8)hdev->inq_tx_power;
+
+		ptr += 3;
+	}
+
+	if (hdev->devid_source > 0) {
+		ptr[0] = 9;
+		ptr[1] = EIR_DEVICE_ID;
+
+		put_unaligned_le16(hdev->devid_source, ptr + 2);
+		put_unaligned_le16(hdev->devid_vendor, ptr + 4);
+		put_unaligned_le16(hdev->devid_product, ptr + 6);
+		put_unaligned_le16(hdev->devid_version, ptr + 8);
+
+		ptr += 10;
+	}
+
+	ptr = create_uuid16_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
+	ptr = create_uuid32_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
+	ptr = create_uuid128_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
+}
+
+u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
+{
+	struct adv_info *adv = NULL;
+	u8 ad_len = 0, flags = 0;
+	u32 instance_flags;
+
+	/* Return 0 when the current instance identifier is invalid. */
+	if (instance) {
+		adv = hci_find_adv_instance(hdev, instance);
+		if (!adv)
+			return 0;
+	}
+
+	instance_flags = hci_adv_instance_flags(hdev, instance);
+
+	/* If instance already has the flags set skip adding it once
+	 * again.
+	 */
+	if (adv && eir_get_data(adv->adv_data, adv->adv_data_len, EIR_FLAGS,
+				NULL))
+		goto skip_flags;
+
+	/* The Add Advertising command allows userspace to set both the general
+	 * and limited discoverable flags.
+	 */
+	if (instance_flags & MGMT_ADV_FLAG_DISCOV)
+		flags |= LE_AD_GENERAL;
+
+	if (instance_flags & MGMT_ADV_FLAG_LIMITED_DISCOV)
+		flags |= LE_AD_LIMITED;
+
+	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
+		flags |= LE_AD_NO_BREDR;
+
+	if (flags || (instance_flags & MGMT_ADV_FLAG_MANAGED_FLAGS)) {
+		/* If a discovery flag wasn't provided, simply use the global
+		 * settings.
+		 */
+		if (!flags)
+			flags |= mgmt_get_adv_discov_flags(hdev);
+
+		/* If flags would still be empty, then there is no need to
+		 * include the "Flags" AD field".
+		 */
+		if (flags) {
+			ptr[0] = 0x02;
+			ptr[1] = EIR_FLAGS;
+			ptr[2] = flags;
+
+			ad_len += 3;
+			ptr += 3;
+		}
+	}
+
+skip_flags:
+	if (adv) {
+		memcpy(ptr, adv->adv_data, adv->adv_data_len);
+		ad_len += adv->adv_data_len;
+		ptr += adv->adv_data_len;
+	}
+
+	if (instance_flags & MGMT_ADV_FLAG_TX_POWER) {
+		s8 adv_tx_power;
+
+		if (ext_adv_capable(hdev)) {
+			if (adv)
+				adv_tx_power = adv->tx_power;
+			else
+				adv_tx_power = hdev->adv_tx_power;
+		} else {
+			adv_tx_power = hdev->adv_tx_power;
+		}
+
+		/* Provide Tx Power only if we can provide a valid value for it */
+		if (adv_tx_power != HCI_TX_POWER_INVALID) {
+			ptr[0] = 0x02;
+			ptr[1] = EIR_TX_POWER;
+			ptr[2] = (u8)adv_tx_power;
+
+			ad_len += 3;
+			ptr += 3;
+		}
+	}
+
+	return ad_len;
+}
+
+static u8 create_default_scan_rsp(struct hci_dev *hdev, u8 *ptr)
+{
+	u8 scan_rsp_len = 0;
+
+	if (hdev->appearance)
+		scan_rsp_len = eir_append_appearance(hdev, ptr, scan_rsp_len);
+
+	return eir_append_local_name(hdev, ptr, scan_rsp_len);
+}
+
+u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr)
+{
+	struct adv_info *adv;
+	u8 scan_rsp_len = 0;
+
+	if (!instance)
+		return create_default_scan_rsp(hdev, ptr);
+
+	adv = hci_find_adv_instance(hdev, instance);
+	if (!adv)
+		return 0;
+
+	if ((adv->flags & MGMT_ADV_FLAG_APPEARANCE) && hdev->appearance)
+		scan_rsp_len = eir_append_appearance(hdev, ptr, scan_rsp_len);
+
+	memcpy(&ptr[scan_rsp_len], adv->scan_rsp_data, adv->scan_rsp_len);
+
+	scan_rsp_len += adv->scan_rsp_len;
+
+	if (adv->flags & MGMT_ADV_FLAG_LOCAL_NAME)
+		scan_rsp_len = eir_append_local_name(hdev, ptr, scan_rsp_len);
+
+	return scan_rsp_len;
+}
diff --git a/net/bluetooth/eir.h b/net/bluetooth/eir.h
new file mode 100644
index 000000000000..724662f8f8b1
--- /dev/null
+++ b/net/bluetooth/eir.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * BlueZ - Bluetooth protocol stack for Linux
+ *
+ * Copyright (C) 2021 Intel Corporation
+ */
+
+void eir_create(struct hci_dev *hdev, u8 *data);
+
+u8 eir_create_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr);
+u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr);
+
+u8 eir_append_local_name(struct hci_dev *hdev, u8 *eir, u8 ad_len);
+u8 eir_append_appearance(struct hci_dev *hdev, u8 *ptr, u8 ad_len);
+
+static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type,
+				  u8 *data, u8 data_len)
+{
+	eir[eir_len++] = sizeof(type) + data_len;
+	eir[eir_len++] = type;
+	memcpy(&eir[eir_len], data, data_len);
+	eir_len += data_len;
+
+	return eir_len;
+}
+
+static inline u16 eir_append_le16(u8 *eir, u16 eir_len, u8 type, u16 data)
+{
+	eir[eir_len++] = sizeof(type) + sizeof(data);
+	eir[eir_len++] = type;
+	put_unaligned_le16(data, &eir[eir_len]);
+	eir_len += sizeof(data);
+
+	return eir_len;
+}
+
+static inline void *eir_get_data(u8 *eir, size_t eir_len, u8 type,
+				 size_t *data_len)
+{
+	size_t parsed = 0;
+
+	if (eir_len < 2)
+		return NULL;
+
+	while (parsed < eir_len - 1) {
+		u8 field_len = eir[0];
+
+		if (field_len == 0)
+			break;
+
+		parsed += field_len + 1;
+
+		if (parsed > eir_len)
+			break;
+
+		if (eir[1] != type) {
+			eir += field_len + 1;
+			continue;
+		}
+
+		/* Zero length data */
+		if (field_len == 1)
+			return NULL;
+
+		if (data_len)
+			*data_len = field_len - 1;
+
+		return &eir[2];
+	}
+
+	return NULL;
+}
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8100a3a1ae13..d63c4d6c8bc2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3143,6 +3143,60 @@ int hci_set_adv_instance_data(struct hci_dev *hdev, u8 instance,
 	return 0;
 }
 
+/* This function requires the caller holds hdev->lock */
+u32 hci_adv_instance_flags(struct hci_dev *hdev, u8 instance)
+{
+	u32 flags;
+	struct adv_info *adv;
+
+	if (instance == 0x00) {
+		/* Instance 0 always manages the "Tx Power" and "Flags"
+		 * fields
+		 */
+		flags = MGMT_ADV_FLAG_TX_POWER | MGMT_ADV_FLAG_MANAGED_FLAGS;
+
+		/* For instance 0, the HCI_ADVERTISING_CONNECTABLE setting
+		 * corresponds to the "connectable" instance flag.
+		 */
+		if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
+			flags |= MGMT_ADV_FLAG_CONNECTABLE;
+
+		if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE))
+			flags |= MGMT_ADV_FLAG_LIMITED_DISCOV;
+		else if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
+			flags |= MGMT_ADV_FLAG_DISCOV;
+
+		return flags;
+	}
+
+	adv = hci_find_adv_instance(hdev, instance);
+
+	/* Return 0 when we got an invalid instance identifier. */
+	if (!adv)
+		return 0;
+
+	return adv->flags;
+}
+
+bool hci_adv_instance_is_scannable(struct hci_dev *hdev, u8 instance)
+{
+	struct adv_info *adv;
+
+	/* Instance 0x00 always set local name */
+	if (instance == 0x00)
+		return true;
+
+	adv = hci_find_adv_instance(hdev, instance);
+	if (!adv)
+		return false;
+
+	if (adv->flags & MGMT_ADV_FLAG_APPEARANCE ||
+	    adv->flags & MGMT_ADV_FLAG_LOCAL_NAME)
+		return true;
+
+	return adv->scan_rsp_len ? true : false;
+}
+
 /* This function requires the caller holds hdev->lock */
 void hci_adv_monitors_clear(struct hci_dev *hdev)
 {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 98ec486743ba..c2c047783a84 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -36,6 +36,7 @@
 #include "amp.h"
 #include "smp.h"
 #include "msft.h"
+#include "eir.h"
 
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 1d14adc023e9..5ec809d3d57e 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -30,6 +30,7 @@
 #include "smp.h"
 #include "hci_request.h"
 #include "msft.h"
+#include "eir.h"
 
 #define HCI_REQ_DONE	  0
 #define HCI_REQ_PEND	  1
@@ -521,164 +522,6 @@ void __hci_req_update_name(struct hci_request *req)
 	hci_req_add(req, HCI_OP_WRITE_LOCAL_NAME, sizeof(cp), &cp);
 }
 
-#define PNP_INFO_SVCLASS_ID		0x1200
-
-static u8 *create_uuid16_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
-{
-	u8 *ptr = data, *uuids_start = NULL;
-	struct bt_uuid *uuid;
-
-	if (len < 4)
-		return ptr;
-
-	list_for_each_entry(uuid, &hdev->uuids, list) {
-		u16 uuid16;
-
-		if (uuid->size != 16)
-			continue;
-
-		uuid16 = get_unaligned_le16(&uuid->uuid[12]);
-		if (uuid16 < 0x1100)
-			continue;
-
-		if (uuid16 == PNP_INFO_SVCLASS_ID)
-			continue;
-
-		if (!uuids_start) {
-			uuids_start = ptr;
-			uuids_start[0] = 1;
-			uuids_start[1] = EIR_UUID16_ALL;
-			ptr += 2;
-		}
-
-		/* Stop if not enough space to put next UUID */
-		if ((ptr - data) + sizeof(u16) > len) {
-			uuids_start[1] = EIR_UUID16_SOME;
-			break;
-		}
-
-		*ptr++ = (uuid16 & 0x00ff);
-		*ptr++ = (uuid16 & 0xff00) >> 8;
-		uuids_start[0] += sizeof(uuid16);
-	}
-
-	return ptr;
-}
-
-static u8 *create_uuid32_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
-{
-	u8 *ptr = data, *uuids_start = NULL;
-	struct bt_uuid *uuid;
-
-	if (len < 6)
-		return ptr;
-
-	list_for_each_entry(uuid, &hdev->uuids, list) {
-		if (uuid->size != 32)
-			continue;
-
-		if (!uuids_start) {
-			uuids_start = ptr;
-			uuids_start[0] = 1;
-			uuids_start[1] = EIR_UUID32_ALL;
-			ptr += 2;
-		}
-
-		/* Stop if not enough space to put next UUID */
-		if ((ptr - data) + sizeof(u32) > len) {
-			uuids_start[1] = EIR_UUID32_SOME;
-			break;
-		}
-
-		memcpy(ptr, &uuid->uuid[12], sizeof(u32));
-		ptr += sizeof(u32);
-		uuids_start[0] += sizeof(u32);
-	}
-
-	return ptr;
-}
-
-static u8 *create_uuid128_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
-{
-	u8 *ptr = data, *uuids_start = NULL;
-	struct bt_uuid *uuid;
-
-	if (len < 18)
-		return ptr;
-
-	list_for_each_entry(uuid, &hdev->uuids, list) {
-		if (uuid->size != 128)
-			continue;
-
-		if (!uuids_start) {
-			uuids_start = ptr;
-			uuids_start[0] = 1;
-			uuids_start[1] = EIR_UUID128_ALL;
-			ptr += 2;
-		}
-
-		/* Stop if not enough space to put next UUID */
-		if ((ptr - data) + 16 > len) {
-			uuids_start[1] = EIR_UUID128_SOME;
-			break;
-		}
-
-		memcpy(ptr, uuid->uuid, 16);
-		ptr += 16;
-		uuids_start[0] += 16;
-	}
-
-	return ptr;
-}
-
-static void create_eir(struct hci_dev *hdev, u8 *data)
-{
-	u8 *ptr = data;
-	size_t name_len;
-
-	name_len = strlen(hdev->dev_name);
-
-	if (name_len > 0) {
-		/* EIR Data type */
-		if (name_len > 48) {
-			name_len = 48;
-			ptr[1] = EIR_NAME_SHORT;
-		} else
-			ptr[1] = EIR_NAME_COMPLETE;
-
-		/* EIR Data length */
-		ptr[0] = name_len + 1;
-
-		memcpy(ptr + 2, hdev->dev_name, name_len);
-
-		ptr += (name_len + 2);
-	}
-
-	if (hdev->inq_tx_power != HCI_TX_POWER_INVALID) {
-		ptr[0] = 2;
-		ptr[1] = EIR_TX_POWER;
-		ptr[2] = (u8) hdev->inq_tx_power;
-
-		ptr += 3;
-	}
-
-	if (hdev->devid_source > 0) {
-		ptr[0] = 9;
-		ptr[1] = EIR_DEVICE_ID;
-
-		put_unaligned_le16(hdev->devid_source, ptr + 2);
-		put_unaligned_le16(hdev->devid_vendor, ptr + 4);
-		put_unaligned_le16(hdev->devid_product, ptr + 6);
-		put_unaligned_le16(hdev->devid_version, ptr + 8);
-
-		ptr += 10;
-	}
-
-	ptr = create_uuid16_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
-	ptr = create_uuid32_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
-	ptr = create_uuid128_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
-}
-
 void __hci_req_update_eir(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -698,7 +541,7 @@ void __hci_req_update_eir(struct hci_request *req)
 
 	memset(&cp, 0, sizeof(cp));
 
-	create_eir(hdev, cp.data);
+	eir_create(hdev, cp.data);
 
 	if (memcmp(cp.data, hdev->eir, sizeof(cp.data)) == 0)
 		return;
@@ -1134,25 +977,6 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 			   addr_resolv);
 }
 
-static bool adv_instance_is_scannable(struct hci_dev *hdev, u8 instance)
-{
-	struct adv_info *adv_instance;
-
-	/* Instance 0x00 always set local name */
-	if (instance == 0x00)
-		return true;
-
-	adv_instance = hci_find_adv_instance(hdev, instance);
-	if (!adv_instance)
-		return false;
-
-	if (adv_instance->flags & MGMT_ADV_FLAG_APPEARANCE ||
-	    adv_instance->flags & MGMT_ADV_FLAG_LOCAL_NAME)
-		return true;
-
-	return adv_instance->scan_rsp_len ? true : false;
-}
-
 static void hci_req_clear_event_filter(struct hci_request *req)
 {
 	struct hci_cp_set_event_filter f;
@@ -1442,7 +1266,7 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 
 static bool adv_cur_instance_is_scannable(struct hci_dev *hdev)
 {
-	return adv_instance_is_scannable(hdev, hdev->cur_adv_instance);
+	return hci_adv_instance_is_scannable(hdev, hdev->cur_adv_instance);
 }
 
 void __hci_req_disable_advertising(struct hci_request *req)
@@ -1457,40 +1281,6 @@ void __hci_req_disable_advertising(struct hci_request *req)
 	}
 }
 
-static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
-{
-	u32 flags;
-	struct adv_info *adv_instance;
-
-	if (instance == 0x00) {
-		/* Instance 0 always manages the "Tx Power" and "Flags"
-		 * fields
-		 */
-		flags = MGMT_ADV_FLAG_TX_POWER | MGMT_ADV_FLAG_MANAGED_FLAGS;
-
-		/* For instance 0, the HCI_ADVERTISING_CONNECTABLE setting
-		 * corresponds to the "connectable" instance flag.
-		 */
-		if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
-			flags |= MGMT_ADV_FLAG_CONNECTABLE;
-
-		if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE))
-			flags |= MGMT_ADV_FLAG_LIMITED_DISCOV;
-		else if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
-			flags |= MGMT_ADV_FLAG_DISCOV;
-
-		return flags;
-	}
-
-	adv_instance = hci_find_adv_instance(hdev, instance);
-
-	/* Return 0 when we got an invalid instance identifier. */
-	if (!adv_instance)
-		return 0;
-
-	return adv_instance->flags;
-}
-
 static bool adv_use_rpa(struct hci_dev *hdev, uint32_t flags)
 {
 	/* If privacy is not enabled don't use RPA */
@@ -1555,15 +1345,15 @@ static bool is_advertising_allowed(struct hci_dev *hdev, bool connectable)
 void __hci_req_enable_advertising(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
-	struct adv_info *adv_instance;
+	struct adv_info *adv;
 	struct hci_cp_le_set_adv_param cp;
 	u8 own_addr_type, enable = 0x01;
 	bool connectable;
 	u16 adv_min_interval, adv_max_interval;
 	u32 flags;
 
-	flags = get_adv_instance_flags(hdev, hdev->cur_adv_instance);
-	adv_instance = hci_find_adv_instance(hdev, hdev->cur_adv_instance);
+	flags = hci_adv_instance_flags(hdev, hdev->cur_adv_instance);
+	adv = hci_find_adv_instance(hdev, hdev->cur_adv_instance);
 
 	/* If the "connectable" instance flag was not set, then choose between
 	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
@@ -1595,9 +1385,9 @@ void __hci_req_enable_advertising(struct hci_request *req)
 
 	memset(&cp, 0, sizeof(cp));
 
-	if (adv_instance) {
-		adv_min_interval = adv_instance->min_interval;
-		adv_max_interval = adv_instance->max_interval;
+	if (adv) {
+		adv_min_interval = adv->min_interval;
+		adv_max_interval = adv->max_interval;
 	} else {
 		adv_min_interval = hdev->le_adv_min_interval;
 		adv_max_interval = hdev->le_adv_max_interval;
@@ -1628,85 +1418,6 @@ void __hci_req_enable_advertising(struct hci_request *req)
 	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
 }
 
-u8 append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
-{
-	size_t short_len;
-	size_t complete_len;
-
-	/* no space left for name (+ NULL + type + len) */
-	if ((HCI_MAX_AD_LENGTH - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 3)
-		return ad_len;
-
-	/* use complete name if present and fits */
-	complete_len = strlen(hdev->dev_name);
-	if (complete_len && complete_len <= HCI_MAX_SHORT_NAME_LENGTH)
-		return eir_append_data(ptr, ad_len, EIR_NAME_COMPLETE,
-				       hdev->dev_name, complete_len + 1);
-
-	/* use short name if present */
-	short_len = strlen(hdev->short_name);
-	if (short_len)
-		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT,
-				       hdev->short_name, short_len + 1);
-
-	/* use shortened full name if present, we already know that name
-	 * is longer then HCI_MAX_SHORT_NAME_LENGTH
-	 */
-	if (complete_len) {
-		u8 name[HCI_MAX_SHORT_NAME_LENGTH + 1];
-
-		memcpy(name, hdev->dev_name, HCI_MAX_SHORT_NAME_LENGTH);
-		name[HCI_MAX_SHORT_NAME_LENGTH] = '\0';
-
-		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT, name,
-				       sizeof(name));
-	}
-
-	return ad_len;
-}
-
-static u8 append_appearance(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
-{
-	return eir_append_le16(ptr, ad_len, EIR_APPEARANCE, hdev->appearance);
-}
-
-static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
-{
-	u8 scan_rsp_len = 0;
-
-	if (hdev->appearance)
-		scan_rsp_len = append_appearance(hdev, ptr, scan_rsp_len);
-
-	return append_local_name(hdev, ptr, scan_rsp_len);
-}
-
-static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
-					u8 *ptr)
-{
-	struct adv_info *adv_instance;
-	u32 instance_flags;
-	u8 scan_rsp_len = 0;
-
-	adv_instance = hci_find_adv_instance(hdev, instance);
-	if (!adv_instance)
-		return 0;
-
-	instance_flags = adv_instance->flags;
-
-	if ((instance_flags & MGMT_ADV_FLAG_APPEARANCE) && hdev->appearance)
-		scan_rsp_len = append_appearance(hdev, ptr, scan_rsp_len);
-
-	memcpy(&ptr[scan_rsp_len], adv_instance->scan_rsp_data,
-	       adv_instance->scan_rsp_len);
-
-	scan_rsp_len += adv_instance->scan_rsp_len;
-
-	if (instance_flags & MGMT_ADV_FLAG_LOCAL_NAME)
-		scan_rsp_len = append_local_name(hdev, ptr, scan_rsp_len);
-
-	return scan_rsp_len;
-}
-
 void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -1723,11 +1434,7 @@ void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance)
 
 		memset(&pdu, 0, sizeof(pdu));
 
-		if (instance)
-			len = create_instance_scan_rsp_data(hdev, instance,
-							    pdu.data);
-		else
-			len = create_default_scan_rsp_data(hdev, pdu.data);
+		len = eir_create_scan_rsp(hdev, instance, pdu.data);
 
 		if (hdev->scan_rsp_data_len == len &&
 		    !memcmp(pdu.data, hdev->scan_rsp_data, len))
@@ -1748,11 +1455,7 @@ void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance)
 
 		memset(&cp, 0, sizeof(cp));
 
-		if (instance)
-			len = create_instance_scan_rsp_data(hdev, instance,
-							    cp.data);
-		else
-			len = create_default_scan_rsp_data(hdev, cp.data);
+		len = eir_create_scan_rsp(hdev, instance, cp.data);
 
 		if (hdev->scan_rsp_data_len == len &&
 		    !memcmp(cp.data, hdev->scan_rsp_data, len))
@@ -1767,95 +1470,6 @@ void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance)
 	}
 }
 
-static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
-{
-	struct adv_info *adv_instance = NULL;
-	u8 ad_len = 0, flags = 0;
-	u32 instance_flags;
-
-	/* Return 0 when the current instance identifier is invalid. */
-	if (instance) {
-		adv_instance = hci_find_adv_instance(hdev, instance);
-		if (!adv_instance)
-			return 0;
-	}
-
-	instance_flags = get_adv_instance_flags(hdev, instance);
-
-	/* If instance already has the flags set skip adding it once
-	 * again.
-	 */
-	if (adv_instance && eir_get_data(adv_instance->adv_data,
-					 adv_instance->adv_data_len, EIR_FLAGS,
-					 NULL))
-		goto skip_flags;
-
-	/* The Add Advertising command allows userspace to set both the general
-	 * and limited discoverable flags.
-	 */
-	if (instance_flags & MGMT_ADV_FLAG_DISCOV)
-		flags |= LE_AD_GENERAL;
-
-	if (instance_flags & MGMT_ADV_FLAG_LIMITED_DISCOV)
-		flags |= LE_AD_LIMITED;
-
-	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
-		flags |= LE_AD_NO_BREDR;
-
-	if (flags || (instance_flags & MGMT_ADV_FLAG_MANAGED_FLAGS)) {
-		/* If a discovery flag wasn't provided, simply use the global
-		 * settings.
-		 */
-		if (!flags)
-			flags |= mgmt_get_adv_discov_flags(hdev);
-
-		/* If flags would still be empty, then there is no need to
-		 * include the "Flags" AD field".
-		 */
-		if (flags) {
-			ptr[0] = 0x02;
-			ptr[1] = EIR_FLAGS;
-			ptr[2] = flags;
-
-			ad_len += 3;
-			ptr += 3;
-		}
-	}
-
-skip_flags:
-	if (adv_instance) {
-		memcpy(ptr, adv_instance->adv_data,
-		       adv_instance->adv_data_len);
-		ad_len += adv_instance->adv_data_len;
-		ptr += adv_instance->adv_data_len;
-	}
-
-	if (instance_flags & MGMT_ADV_FLAG_TX_POWER) {
-		s8 adv_tx_power;
-
-		if (ext_adv_capable(hdev)) {
-			if (adv_instance)
-				adv_tx_power = adv_instance->tx_power;
-			else
-				adv_tx_power = hdev->adv_tx_power;
-		} else {
-			adv_tx_power = hdev->adv_tx_power;
-		}
-
-		/* Provide Tx Power only if we can provide a valid value for it */
-		if (adv_tx_power != HCI_TX_POWER_INVALID) {
-			ptr[0] = 0x02;
-			ptr[1] = EIR_TX_POWER;
-			ptr[2] = (u8)adv_tx_power;
-
-			ad_len += 3;
-			ptr += 3;
-		}
-	}
-
-	return ad_len;
-}
-
 void __hci_req_update_adv_data(struct hci_request *req, u8 instance)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -1872,7 +1486,7 @@ void __hci_req_update_adv_data(struct hci_request *req, u8 instance)
 
 		memset(&pdu, 0, sizeof(pdu));
 
-		len = create_instance_adv_data(hdev, instance, pdu.data);
+		len = eir_create_adv_data(hdev, instance, pdu.data);
 
 		/* There's nothing to do if the data hasn't changed */
 		if (hdev->adv_data_len == len &&
@@ -1894,7 +1508,7 @@ void __hci_req_update_adv_data(struct hci_request *req, u8 instance)
 
 		memset(&cp, 0, sizeof(cp));
 
-		len = create_instance_adv_data(hdev, instance, cp.data);
+		len = eir_create_adv_data(hdev, instance, cp.data);
 
 		/* There's nothing to do if the data hasn't changed */
 		if (hdev->adv_data_len == len &&
@@ -2173,7 +1787,7 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 		adv_instance = NULL;
 	}
 
-	flags = get_adv_instance_flags(hdev, instance);
+	flags = hci_adv_instance_flags(hdev, instance);
 
 	/* If the "connectable" instance flag was not set, then choose between
 	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
@@ -2213,7 +1827,7 @@ int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance)
 			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_CONN_IND);
 		else
 			cp.evt_properties = cpu_to_le16(LE_LEGACY_ADV_IND);
-	} else if (adv_instance_is_scannable(hdev, instance) ||
+	} else if (hci_adv_instance_is_scannable(hdev, instance) ||
 		   (flags & MGMT_ADV_PARAM_SCAN_RSP)) {
 		if (secondary_adv)
 			cp.evt_properties = cpu_to_le16(LE_EXT_ADV_SCAN_IND);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 39ee8a18087a..4824be833169 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -122,26 +122,3 @@ static inline void hci_update_background_scan(struct hci_dev *hdev)
 
 void hci_request_setup(struct hci_dev *hdev);
 void hci_request_cancel_all(struct hci_dev *hdev);
-
-u8 append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len);
-
-static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type,
-				  u8 *data, u8 data_len)
-{
-	eir[eir_len++] = sizeof(type) + data_len;
-	eir[eir_len++] = type;
-	memcpy(&eir[eir_len], data, data_len);
-	eir_len += data_len;
-
-	return eir_len;
-}
-
-static inline u16 eir_append_le16(u8 *eir, u16 eir_len, u8 type, u16 data)
-{
-	eir[eir_len++] = sizeof(type) + sizeof(data);
-	eir[eir_len++] = type;
-	put_unaligned_le16(data, &eir[eir_len]);
-	eir_len += sizeof(data);
-
-	return eir_len;
-}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d1bf5a55ff85..d44832c90860 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -38,6 +38,7 @@
 #include "mgmt_util.h"
 #include "mgmt_config.h"
 #include "msft.h"
+#include "eir.h"
 
 #define MGMT_VERSION	1
 #define MGMT_REVISION	20
@@ -7526,7 +7527,7 @@ static u8 calculate_name_len(struct hci_dev *hdev)
 {
 	u8 buf[HCI_MAX_SHORT_NAME_LENGTH + 3];
 
-	return append_local_name(hdev, buf, 0);
+	return eir_append_local_name(hdev, buf, 0);
 }
 
 static u8 tlv_data_max_len(struct hci_dev *hdev, u32 adv_flags,
-- 
2.31.1

