Return-Path: <SRS0=Hv/D=BG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C2BC433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jul 2020 17:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248AF2070B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jul 2020 17:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W4Z+QvcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgG0RrN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgG0RrN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jul 2020 13:47:13 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBDBC061794
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2020 10:47:12 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id k7so8772130vso.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2020 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5lJtU6tIb4qc05hk/HqBeTb40P07YFQMzDtjotddUIA=;
        b=W4Z+QvcZK8hVtozQVJVEeUUeIWZkYzFafoprj907pyEgUutRDX0+OuEA5sx9Qbyckb
         GKd02jdXaaYlPDpIkqrjYqNI2BUULcIrFw0GrrYQ/kurt0k6Ir99ObZdBZyWrvURxG18
         T1oxG300Uji2O1fiMqbrh55rWaFHPRjawUdos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5lJtU6tIb4qc05hk/HqBeTb40P07YFQMzDtjotddUIA=;
        b=ldugNwyZsxEQt6ZjPB2LfWzPuvpxJcB7yZ1L7Zu02sp+qPWh6Dw2RSr+oIAnEM6Pop
         JtfzV6qgJMOcbC++OqTK/crgsg2qMbgP14lhqSQ+TYGACeeACDvwWTD4cx9Bb0F3UFfL
         +rrv8d5u4YZhMdi5qX2VrFQ5xC7LHB4Igeyh4cMEXAKfOTLdBnFoH9PHOfXZPSsnlQi8
         mwUEnKgN1vSxa6DW3AY2ckMSMExGFhgb6F9DAoB1x49tbHIwplS139Py5mFWkIUx+u3s
         lO7Lix6w0kymT98mZ1bHw6v0nBR5DhiapJfBEmZPrJlUa/zI0sNXRXU770frJWlkBvgj
         ng1Q==
X-Gm-Message-State: AOAM530ArNuY7j2wrPP4y42krxn95lw8er23CR4Bj6rqUOZqGFVCnuVk
        nLesHIS1wSeNaZF3TE77JhXD25LVbss=
X-Google-Smtp-Source: ABdhPJwK0d1+XgQY8hRAD76G1ZgOzJlMDXUSF/CexIuzCaKYqPRUEQ8Bxgf49m4MMMxZ7o+IGFEMhQ==
X-Received: by 2002:a67:f3cd:: with SMTP id j13mr17583373vsn.40.1595872031459;
        Mon, 27 Jul 2020 10:47:11 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id t67sm2718040vkd.38.2020.07.27.10.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 10:47:10 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH] Bluetooth: adding configurable eir_max_name_len
Date:   Mon, 27 Jul 2020 17:47:05 +0000
Message-Id: <20200727174641.1.Ic2cb84fb029a345c9e3901378717d1ab4e9246ab@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds support for a configurable eir_max_name_len for
platforms which requires a larger than 48 bytes complete name in EIR.

From bluetoothctl:
[bluetooth]# system-alias
012345678901234567890123456789012345678901234567890123456789
Changing 012345678901234567890123456789012345678901234567890123456789
succeeded
[CHG] Controller DC:71:96:69:02:89 Alias:
012345678901234567890123456789012345678901234567890123456789

From btmon:
< HCI Command: Write Local Name (0x03|0x0013) plen 248     #109
[hci0] 88.567990
        Name:
012345678901234567890123456789012345678901234567890123456789
> HCI Event: Command Complete (0x0e) plen 4  #110 [hci0] 88.663854
      Write Local Name (0x03|0x0013) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Local Name Changed (0x0008) plen 260               
{0x0004} [hci0] 88.663948
        Name:
012345678901234567890123456789012345678901234567890123456789
        Short name:
< HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241
 #111 [hci0] 88.663977
        FEC: Not required (0x00)
        Name (complete):
012345678901234567890123456789012345678901234567890123456789
        TX power: 12 dBm
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: Google (224)
          Product: 0xc405
          Version: 0.5.6 (0x0056)
        16-bit Service UUIDs (complete): 7 entries
          Generic Access Profile (0x1800)
          Generic Attribute Profile (0x1801)
          Device Information (0x180a)
          A/V Remote Control (0x110e)
          A/V Remote Control Target (0x110c)
          Handsfree Audio Gateway (0x111f)
          Audio Source (0x110a)
> HCI Event: Command Complete (0x0e) plen 4    #112 [hci0] 88.664874
      Write Extended Inquiry Response (0x03|0x0052) ncmd 1
        Status: Success (0x00)

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Alain Michaud <alainm@chromium.org>

---

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  1 +
 net/bluetooth/hci_request.c      | 29 +++++++++++++++++++++--------
 net/bluetooth/mgmt_config.c      |  5 +++++
 4 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bee1b4778ccc..e08f92e7a9ca 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -298,6 +298,7 @@ struct hci_dev {
 	__u8		dev_name[HCI_MAX_NAME_LENGTH];
 	__u8		short_name[HCI_MAX_SHORT_NAME_LENGTH];
 	__u8		eir[HCI_MAX_EIR_LENGTH];
+	__u16		eir_max_name_len;
 	__u16		appearance;
 	__u8		dev_class[3];
 	__u8		major_class;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6509f785dd14..b2507bd6613a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3536,6 +3536,7 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->adv_instance_cnt = 0;
 	hdev->cur_adv_instance = 0x00;
 	hdev->adv_instance_timeout = 0;
+	hdev->eir_max_name_len = 48;
 
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 7c0c2fda04ad..f4714370b7e7 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -578,17 +578,21 @@ static u8 *create_uuid128_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
 static void create_eir(struct hci_dev *hdev, u8 *data)
 {
 	u8 *ptr = data;
+	u8 size_remaining = HCI_MAX_EIR_LENGTH;
 	size_t name_len;
 
 	name_len = strlen(hdev->dev_name);
 
 	if (name_len > 0) {
 		/* EIR Data type */
-		if (name_len > 48) {
-			name_len = 48;
+		if (name_len > min_t(u16, (HCI_MAX_EIR_LENGTH - 2),
+				     hdev->eir_max_name_len)) {
+			name_len = min_t(u16, (HCI_MAX_EIR_LENGTH - 2),
+					 hdev->eir_max_name_len);
 			ptr[1] = EIR_NAME_SHORT;
-		} else
+		} else {
 			ptr[1] = EIR_NAME_COMPLETE;
+		}
 
 		/* EIR Data length */
 		ptr[0] = name_len + 1;
@@ -596,17 +600,21 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 		memcpy(ptr + 2, hdev->dev_name, name_len);
 
 		ptr += (name_len + 2);
+		size_remaining -= (name_len + 2);
 	}
 
-	if (hdev->inq_tx_power != HCI_TX_POWER_INVALID) {
+	if (hdev->inq_tx_power != HCI_TX_POWER_INVALID &&
+	    size_remaining >= 3) {
 		ptr[0] = 2;
 		ptr[1] = EIR_TX_POWER;
 		ptr[2] = (u8) hdev->inq_tx_power;
 
 		ptr += 3;
+		size_remaining -= 3;
 	}
 
-	if (hdev->devid_source > 0) {
+	if (hdev->devid_source > 0 &&
+	    size_remaining >= 10) {
 		ptr[0] = 9;
 		ptr[1] = EIR_DEVICE_ID;
 
@@ -616,11 +624,16 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 		put_unaligned_le16(hdev->devid_version, ptr + 8);
 
 		ptr += 10;
+		size_remaining -= 10;
 	}
 
-	ptr = create_uuid16_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
-	ptr = create_uuid32_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
-	ptr = create_uuid128_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
+	ptr = create_uuid16_list(hdev, ptr, size_remaining);
+	size_remaining = HCI_MAX_EIR_LENGTH - (ptr - data);
+
+	ptr = create_uuid32_list(hdev, ptr, size_remaining);
+	size_remaining = HCI_MAX_EIR_LENGTH - (ptr - data);
+
+	ptr = create_uuid128_list(hdev, ptr, size_remaining);
 }
 
 void __hci_req_update_eir(struct hci_request *req)
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index b30b571f8caf..420ea322a5b7 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -67,6 +67,7 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		HDEV_PARAM_U16(0x001a, le_supv_timeout),
 		HDEV_PARAM_U16_JIFFIES_TO_MSECS(0x001b,
 						def_le_autoconnect_timeout),
+		HDEV_PARAM_U16(0x001c, eir_max_name_len),
 	};
 	struct mgmt_rp_read_def_system_config *rp = (void *)params;
 
@@ -138,6 +139,7 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x0019:
 		case 0x001a:
 		case 0x001b:
+		case 0x001c:
 			if (len != sizeof(u16)) {
 				bt_dev_warn(hdev, "invalid length %d, exp %zu for type %d",
 					    len, sizeof(u16), type);
@@ -251,6 +253,9 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 			hdev->def_le_autoconnect_timeout =
 					msecs_to_jiffies(TLV_GET_LE16(buffer));
 			break;
+		case 0x0001c:
+			hdev->eir_max_name_len = TLV_GET_LE16(buffer);
+			break;
 		default:
 			bt_dev_warn(hdev, "unsupported parameter %u", type);
 			break;
-- 
2.28.0.rc0.142.g3c755180ce-goog

