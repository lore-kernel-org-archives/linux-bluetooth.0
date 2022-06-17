Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DC1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 22:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346993AbiFQWVY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 18:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiFQWVX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 18:21:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A9260DB7
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:21:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so4115539pjm.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u12HuJCeYwblHUKL7UkRcE/oMMm+Sm2qK7TiuylZ23I=;
        b=MC6YyZK2ZE3b4s8BzP30OuAFo8nH0En9ldOdMIfB/vJdchZjDewD6qXxS1JJL5jDLK
         PIV2oE/nkWQCgq09JM8KbO6SflUPhvRuhwooGQAlGCJY7dG3KLLIVZuiTO1SvQJlyGb3
         hM/37YoRxtJcd25chjBRjc+53SFSkoa3qr6o42y5AN1SA+X3Ir3tFDsp3Lkl4jywAuQd
         T5J4dM6lliDKXPfBCIVh4m6m1xilDWuAlS+Mdy/rzp2ujDQ5dlK6BvEVCBvoR7YcA53T
         PmiRW0W3gqQmXSEqePwf0xOE8ZLkmtKtJJm0IE/mar9on1Ez54oVFgRIXrXQt0Fq8IRa
         6Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u12HuJCeYwblHUKL7UkRcE/oMMm+Sm2qK7TiuylZ23I=;
        b=A0VoV6dFIHW5uE/A30Dr537KHgTuMM0zx9izhwsTUZh7PSrtW6FJavBZV6CUmdV99T
         zAWdBzmqjGGwOqZQ+bkPxp0WXtRY8A4W0cFo3Bp9UjI6ZVAbAVPNhl8KLU1woRZ9IgaO
         TldUaKQqvdn9mQez3jwFEAOIGsVbTcYKi4vvnSmN4a0fTQSkya3RxJ3YWWiqv/3Ejf1V
         /9pvWz5AfD/3H8zSMyBMCs5xgCv1YgOrBaSTFdCMkyFXBgiZvY4J/JiO/lvdJdfY2f4N
         r5wEt4V+NF/05XfW+q2/1CajbubetZWnlUzQU48oW3zAc7rzkh0zMgJUE24DiKBsrWSy
         8JTQ==
X-Gm-Message-State: AJIora9RIoCKa9Xp1mV1hJO2v+gteuggKEw2RbUsuQgT1+5k2VbBDrX5
        VWNwn71xBlHPN2OWmAmVgN/KhetWIsM=
X-Google-Smtp-Source: AGRyM1tl+mcqjMZp0a4YKdWOXPWd4w204Rk72utURUqKSKAnStd8tms53uLmTa5Pxigxg7Jj58B+UQ==
X-Received: by 2002:a17:90b:4c0e:b0:1e8:859c:6b56 with SMTP id na14-20020a17090b4c0e00b001e8859c6b56mr23661119pjb.121.1655504481086;
        Fri, 17 Jun 2022 15:21:21 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v9-20020a056a00148900b0051829b1595dsm4165392pfu.130.2022.06.17.15.21.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 15:21:20 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v6 1/8] lib: Add definitions for ISO socket
Date:   Fri, 17 Jun 2022 15:21:12 -0700
Message-Id: <20220617222119.1413958-1-luiz.dentz@gmail.com>
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

