Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993BCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 22:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiF3WO5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiF3WO4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 18:14:56 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EC14D170
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 15:14:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x20so609763plx.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 15:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4gghVsBCpB8GXN4ZB22T+23lGvU75meE2wp9k97nad8=;
        b=IzuI7fIbyBUtlqF4MfzZU/XBXmRi5KBmu/2hXSTED+l8qNm2/uvzUatGl/+zLM6NOX
         CvIrSPtPvAgARIxG9RRlaAzY67WNIYrA/M+7n65IOD5VVKdRk/xtKAdzXCFL46NVd11h
         T9+qocYezz1jveof8pXT51lv31qFrcvSIERDv1zMMK7O4oSHZtZQy1oo7JhQ5OTIWKCY
         h9kSGyDDSHwgiJ02eattz3lyT+wE1Ixe+fi/qpqKOIHCNM61cnGRiiIcmiPgz8GgNa4P
         EuDw3z0+hgkSQkmlt88mU4qnel2KAz74nOhbVSbHL3pj+ceUE0nMgnGUC/wtr8f0Hh8s
         jecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4gghVsBCpB8GXN4ZB22T+23lGvU75meE2wp9k97nad8=;
        b=e/vBqrcWIYgr9MtL6vUl37r61UpSsTm5lfv49IFEjg95REPhuPSBZfI0z22NMaYakc
         etB6HV9furN/RMXbORVdWGCpNLnnHeiM9pSArdZDa6k41w4T4VTQhjE3+1l/OQKTNmpH
         RzfEsCscovvyTTGdKliwYymZ/nEE1xKxj7M/5gEUJul6Ti+ni/ma7zPk2C7jiE5YagH4
         Prprp7c8bZ0XkvHrFsnKLsi3O0c9XZgC+WbsOYN7gF1sbD55CXMGZ70wWjqG+ujoTv4u
         QjNXL8wdVNZ3nKw/Pr3g+TCMjfE+WhZu7/fShtPZfyngHfc59bwg0sdEQorZbIVyUXCp
         1b9Q==
X-Gm-Message-State: AJIora+5Oo6Tjnaa9Du4UEbjKLCndvd2vIv605vx0orP1Cs3KWud6BDH
        R1AKuJ/9qePYfzWMwQH0psF6A+RiI5ifzA==
X-Google-Smtp-Source: AGRyM1sB054woES/ukbfdzOjETyxczL7K5DMnyr3brikIUU9l0VcICy7xWYdXFktz9bg8dSsih4uWw==
X-Received: by 2002:a17:903:1246:b0:16b:a568:4f74 with SMTP id u6-20020a170903124600b0016ba5684f74mr8559151plh.0.1656627293963;
        Thu, 30 Jun 2022 15:14:53 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id me3-20020a17090b17c300b001ec84b0f199sm3460333pjb.1.2022.06.30.15.14.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:14:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v8 1/8] lib: Add definitions for ISO socket
Date:   Thu, 30 Jun 2022 15:14:45 -0700
Message-Id: <20220630221452.638591-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
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
v5: Add BT_DEFER_SETUP tests to iso-tester
v6: Make iso-tester disable ISO Socket experimental UUID after each test
v7: Fix scan-build findings
v8: Add tests Defer and Defer send which use DEFER_SETUP when connecting which
emulates the QoS state of BAP where a SetCIGParameter shall be used without
CreateCIS which is left to just Enabling state.

 Makefile.am     |  2 +-
 lib/bluetooth.h | 38 +++++++++++++++++++++++++++++++++++++-
 lib/iso.h       | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 2 deletions(-)
 create mode 100644 lib/iso.h

diff --git a/Makefile.am b/Makefile.am
index 0074ea3ac..cead4b8c6 100644
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
index e6171cef0..af5fbcfbc 100644
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
2.35.3

