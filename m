Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669FFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 22:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357800AbiFVW2M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 18:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358195AbiFVW2L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 18:28:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF9AC61
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 15:28:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so734828pjm.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 15:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vv42n/CXFtmXKiytAwGXUBHYtpFJN5DHMBKlRP0RBuE=;
        b=lZtccvAHliHXPSFmRgCFwohi3YjYwJYZx99uDa/ToXu0QEqcoM9w2qCKziECjFPYbq
         IAD4TgU0floGBywGy2UHI6hBFjOo8itO6sVqNmrF+AK3jwvY8pbPsdSKRKGkLyyVPd1b
         yPmOag2SuyBMZJ/6qJYDs7e4XUlYEqrIS4xd//b4fqT9Y9Cmor3ezVtqCYUwB7jLddGV
         qJLDh9YkCpIeUQX3qqkLtAO6txO5I0xsIi++jRe0NXzWyZNhHxxC036MDkj2zxQiWaAZ
         os4c3upPet4TV/ofKZkgOppRU23rwEtBpDRKg9bWHQ+GaPJNBiYos1VB7nshw8eSFOw8
         g7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vv42n/CXFtmXKiytAwGXUBHYtpFJN5DHMBKlRP0RBuE=;
        b=7HGtUr3lGoc3M+Whchm6FX9QHIUmjjwLUfNxwo5TP4lYBgoDpEhTWTI9Og2Scp37Zp
         Yaa2gHngtTG0zfuGbXDm2MRDbduNUY2PpbhtkJ5YS8iNZfNI3G2GrmxT0OPvNrRafgYL
         QPefVEbstvQaMYB9yWNJwTz6qWsxr5G3WBazZ8fJPu3OCzwuSrqqKh8ACJToJAFQPSS4
         6+f9ezrpNQS0cXkPOWDNb6ftCeLseF8hJ0gcF6jvfQa6ihm+fGX+h7YtJmvBYrBB81ke
         TMWdir8f41F7wvWHOyYjaxA0d3dvUqC4ZPGdVUw1+tCR2gIYlVIkQd6eb7TfJXHvcalI
         TQsQ==
X-Gm-Message-State: AJIora8GUJgyVpYDOoqSETtxCG1iPDna8phviIITZH6DC9OE0gsCp29S
        cNIHud3B5MBBltOg+PGV7saaShRph6lIow==
X-Google-Smtp-Source: AGRyM1udCMNrQs61utT/OGOqdZQdLL+NTviCgVVE4ULt3kFQgc56R889XrCRODReOXVInumZYiHiPw==
X-Received: by 2002:a17:90b:3b52:b0:1ec:db2a:b946 with SMTP id ot18-20020a17090b3b5200b001ecdb2ab946mr596007pjb.229.1655936883170;
        Wed, 22 Jun 2022 15:28:03 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709028eca00b0016368840c41sm11710482plo.14.2022.06.22.15.28.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:28:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v7 1/8] lib: Add definitions for ISO socket
Date:   Wed, 22 Jun 2022 15:27:54 -0700
Message-Id: <20220622222801.2676431-1-luiz.dentz@gmail.com>
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

