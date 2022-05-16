Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989ACC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 May 2022 22:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347603AbiEPWNK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 May 2022 18:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244688AbiEPWNJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 May 2022 18:13:09 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253442A729
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 15:13:07 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id d3so11474980ilr.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 15:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PBJ/Wp/6u6XOk/PHHgeBysn9tgdoUlUaIXGE1lqECgw=;
        b=FMVAAqHih5pUffYZrAecJOenImJfptKj/Yxm89ue//XcwGRLAaqZKYWRxI1CzCRAmK
         NiC/k2FF8/o9mzK/1RIOOHWM7u1hwrxTARlSWz3iqcfPetapEFVbeFKGuqvBg1zsX5y3
         j6pap7JROx1PLCrWerLD5fEbigqL1Sr/2JPy/wvqGfNp+x+gDHLK4FP0p41hV1UZuAde
         fYdI6yCJW085oNaVzMJjePK6DadkKW3gLpSdieXIS2/+6NJsmVJLFw83p4ZNaSANKe2b
         ocO3/6kJhb+CDuqOCgIaZaBJj9PZdOJd/ky+RN60nZXJlS7gKihikUyxGs/cslxuVP71
         pRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PBJ/Wp/6u6XOk/PHHgeBysn9tgdoUlUaIXGE1lqECgw=;
        b=xwEbCeX+lWmJAfxQkjplwr+fFzyy/3YA4JXqCz92oTfOGP+Uh1GGkVj3QlOBFOAibz
         FepDQmwUQsjh2J7QhRsPQFivIfOjz1QabdCwAez2P72ugrvrKYevVECZIbXCOX6qy9t9
         M6AQ8hiksFW/83Ob+JxjwoXGJzWsUDw8+kRmgWiaG0zw0+puPfN9Q8cNKjnw7zNzHtZb
         DS9vuHYuSYWzu1/cMrV7PhjK5MwEMp160BEsxj4ePzuvYeB/HANBkHJchc8UgneMRR+U
         hEkRXzCVYPa6AulScKtJfFrbsxoSQsTfIKn4PwE/xibomIbQ+TTj+qEvpBvUN+nz26+8
         yRSw==
X-Gm-Message-State: AOAM532POeJZry4uGM0CO779RphYnP9jDDtRi1i1Vu9+wSYb3unzZYy3
        ypbyvjytakw6v89Rbgyk9QV9nVF4WtI=
X-Google-Smtp-Source: ABdhPJwd8547Cmi+Ag32XOalgfkEIltBk9Hfg2QFLj1AoQv1rjLuV5pHmOL6gTuHMRSNvKQ2TX0JDA==
X-Received: by 2002:a05:6e02:1685:b0:2cf:32bc:eb56 with SMTP id f5-20020a056e02168500b002cf32bceb56mr10372084ila.243.1652739186096;
        Mon, 16 May 2022 15:13:06 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t9-20020a6b5f09000000b005e1729b55ccsm166426iob.1.2022.05.16.15.13.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:13:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/8] lib: Add definitions for ISO socket
Date:   Mon, 16 May 2022 15:12:57 -0700
Message-Id: <20220516221304.1744026-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
v2: Fix CI findings.
v3: Add patch fixing mgmt-tester Read EXP Features tests.
v4: Rebase and add flag EXP_FEAT_ISO_SOCKET

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

