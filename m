Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30DAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 22:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359153AbiEEWvM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 May 2022 18:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241219AbiEEWvL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 May 2022 18:51:11 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5076E5BD2B
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 May 2022 15:47:30 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c14so4793472pfn.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 May 2022 15:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7B2RYGoTuvwsFUFJ3VZZXwu1qxsEZhTkPCT15kAIyUA=;
        b=HXOUP5AGzi4vDNM04wldbyPIjgVAJV9jxZhqbLqdZN+A/urjZqGlg2VkfAbi/rc9eX
         nZqD/cU+6LLXKMStwE9gSce3zvkCzHyEhGTq5hPBjREm0wNKe7ne8dcqkJKzZ4OfGjl+
         SovupwMTor268BfXF3zOZv3+2OYfVPlOWeEIqvuO/ed04XmNsvpGvWpCS/cC4Zv6VK++
         SSzLz818LfL5qfrFIQovtY13LDFV/GomXaxrzx4Td1otmSae3rHnDXikWbCCwkD9hXp6
         uxHomiAwMP8G5Mq79Ltti9K6geRPm8NXQPA5Y/6ZgyRThP5qBjWsKrgzCTTQU49QXLNQ
         OwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7B2RYGoTuvwsFUFJ3VZZXwu1qxsEZhTkPCT15kAIyUA=;
        b=KCfxbsllfVnYwKAOeOoN9NCQ/bTGJyv5BPRcuCndu0uFUh4rCwdIHDHrUyjcvxSnYH
         n4ELtM1AY8cav2h1etTDSSRFzI2PcRMrILcEPCEWxJiUH4ybAQkdvZ0Ch6yiTGri99Hz
         GJ5JLL5bTBWoS/iTCgSmDB0rlpHNyEKrIrJSjPTSw3Cs/QYyiLz35zt29DHc7A/1b1J4
         g1wzbCNfqNb2+6U8Z/YC7DClOib2rwxSKLDnNYb/yA5bRV6DycIcmxmCtz8iBAvjlFem
         lkoysA+s0wnhZHj0lr8f9X5GuebOsQkSdfPyJQYmbQ1Q/93CBjWR7Qib5dYcGVhQY4pz
         P9PA==
X-Gm-Message-State: AOAM532OzeOakYmAhMeLRxI44aR21Ocrncn76KeqLsj/Z25TdD6XaSjK
        C2/1IwbVdY4SKdg81v9rqem79+7CeFQ=
X-Google-Smtp-Source: ABdhPJy9F/V4p46w41McfqkVqUpjPisFzhsASLNFB2uvTWfOkIlDQP1KfejWZ1ILzrho9beuTIRtmQ==
X-Received: by 2002:a63:fb0a:0:b0:3c1:cd4a:4f93 with SMTP id o10-20020a63fb0a000000b003c1cd4a4f93mr313538pgh.78.1651790849470;
        Thu, 05 May 2022 15:47:29 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b0015e8d4eb2aesm129651pld.248.2022.05.05.15.47.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 15:47:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/7] lib: Add definitions for ISO socket
Date:   Thu,  5 May 2022 15:47:21 -0700
Message-Id: <20220505224727.3369989-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.am     |  2 +-
 lib/bluetooth.h | 38 +++++++++++++++++++++++++++++++++++++-
 lib/iso.h       | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 2 deletions(-)
 create mode 100644 lib/iso.h

diff --git a/Makefile.am b/Makefile.am
index 82125c482..c7b369606 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -69,7 +69,7 @@ lib_headers = lib/bluetooth.h lib/hci.h lib/hci_lib.h \
 		lib/sco.h lib/l2cap.h lib/sdp.h lib/sdp_lib.h \
 		lib/rfcomm.h lib/bnep.h lib/cmtp.h lib/hidp.h
 
-extra_headers = lib/mgmt.h lib/uuid.h lib/a2mp.h lib/amp.h
+extra_headers = lib/mgmt.h lib/uuid.h lib/a2mp.h lib/amp.h lib/iso.h
 extra_sources = lib/uuid.c
 
 local_headers = $(foreach file,$(lib_headers), lib/bluetooth/$(notdir $(file)))
diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 0fcf412c6..73297c147 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -37,6 +37,7 @@ extern "C" {
 #define BTPROTO_CMTP	5
 #define BTPROTO_HIDP	6
 #define BTPROTO_AVDTP	7
+#define BTPROTO_ISO	8
 
 #define SOL_HCI		0
 #define SOL_L2CAP	6
@@ -140,7 +141,39 @@ struct bt_voice {
 
 #define BT_SCM_PKT_STATUS	0x03
 
-#define BT_CODEC 19
+#define BT_ISO_QOS		17
+
+#define BT_ISO_QOS_CIG_UNSET	0xff
+#define BT_ISO_QOS_CIS_UNSET	0xff
+
+struct bt_iso_io_qos {
+	uint32_t interval;
+	uint16_t latency;
+	uint16_t sdu;
+	uint8_t  phy;
+	uint8_t  rtn;
+};
+
+struct bt_iso_qos {
+	union {
+		uint8_t  cig;
+		uint8_t  big;
+	};
+	union {
+		uint8_t  cis;
+		uint8_t  bis;
+	};
+	union {
+		uint8_t  sca;
+		uint8_t  sync_interval;
+	};
+	uint8_t  packing;
+	uint8_t  framing;
+	struct bt_iso_io_qos in;
+	struct bt_iso_io_qos out;
+};
+
+#define BT_CODEC		19
 struct bt_codec {
 	uint8_t id;
 	uint16_t cid;
@@ -158,6 +191,7 @@ struct bt_codecs {
 	struct bt_codec codecs[];
 } __attribute__((packed));
 
+
 /* Connection and socket states */
 enum {
 	BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
@@ -171,6 +205,8 @@ enum {
 	BT_CLOSED
 };
 
+#define BT_ISO_BASE		20
+
 /* Byte order conversions */
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define htobs(d)  (d)
diff --git a/lib/iso.h b/lib/iso.h
new file mode 100644
index 000000000..1e9f79ce5
--- /dev/null
+++ b/lib/iso.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2022  Intel Corporation.
+ *
+ */
+
+#ifndef __ISO_H
+#define __ISO_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/* ISO defaults */
+#define ISO_DEFAULT_MTU		251
+#define ISO_MAX_NUM_BIS		0x1f
+
+/* ISO socket broadcast address */
+struct sockaddr_iso_bc {
+	bdaddr_t	bc_bdaddr;
+	uint8_t		bc_bdaddr_type;
+	uint8_t		bc_sid;
+	uint8_t		bc_num_bis;
+	uint8_t		bc_bis[ISO_MAX_NUM_BIS];
+};
+
+/* ISO socket address */
+struct sockaddr_iso {
+	sa_family_t	iso_family;
+	bdaddr_t	iso_bdaddr;
+	uint8_t		iso_bdaddr_type;
+	struct sockaddr_iso_bc iso_bc[];
+};
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __ISO_H */
-- 
2.35.1

