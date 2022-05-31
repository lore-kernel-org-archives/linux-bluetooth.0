Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CB9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 20:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344407AbiEaUzU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 16:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344939AbiEaUzS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 16:55:18 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF3B9D061
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 13:55:12 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 62so7043088iov.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWGNsJjOGqfhgCs+Q72O+UV/Ya9Lo7YVCP2NbETjKnc=;
        b=EOtebE1MG+fhU9defofYX3oCJ17frB3zvnGzTJ+kHFVfet9PgsD3jzQMm2v9GnQ9TQ
         2/3B4fRAZuBWnuN5ks+shVHjhVf8pwduX98Bi7lxKC4YpK6COpXAi7S8Y/A7xS/tYAV0
         p3iuMvXzk0hjHpRozubomoEQIu9v0avBP4VqceX3nOFwCX9E5U6gX0IdjyjWC/Iht3Ai
         21F8997eIkfKX1ThH2Cqe9xUb1T8liiv9rBVR6hOTrT5Ftkir+O9aci6ZxOvMAxGoPGI
         JfuQG+jxN3NuInzR/7aOgXHvPa10q3/Uuq4Cdeky+3+PwP7OPvsGMABZUFPCAjZ5/BPj
         kFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWGNsJjOGqfhgCs+Q72O+UV/Ya9Lo7YVCP2NbETjKnc=;
        b=EjwjLcvgCXKsOgEoVVlvC4W85+caHNIvpIDcIYilz1AGz1/CeZgdmVX8bJn4gLllaX
         ngg4whi8vlHvgEPdA5MJP5zDc4p0xqrv/hlM6ld7k6J46wRx3lNZdp49h98m//ENAu3L
         OGyOJLICJw6Ew4jaGn6Vdrdw4xiTTjF5cFKwjFkhoW08kYWp7YH6r6c+dXMoqZhEsjGY
         OlcVPnEDG2uT7tPB8mFu5mLkFJIx7W7TduCkpuCiVkELSS8qmOjFN4dQrvSv/V7iz7fG
         OEo4rKha5caOv4mOUKxICavY118aSMi8YQSlmembrbMIw8+hW/SZDSUXFLifiMpJyOAq
         CDDw==
X-Gm-Message-State: AOAM5300i5uzOH6ENj1ucfvHmEi+t9vU9T59tN1Z+dcihG6MrnrqxUTj
        WT3ULvvj38UM00QVb2Sj/AQwFOA/fgQ=
X-Google-Smtp-Source: ABdhPJzKv+RNX1vO1+Cxs8v6Bjzqy5ziNl3cAoaNANPp05194ewAANQGQyrZbAxqGzqonwR1C6nddQ==
X-Received: by 2002:a05:6602:2c0c:b0:5f0:793f:cb9e with SMTP id w12-20020a0566022c0c00b005f0793fcb9emr26670788iov.122.1654030511534;
        Tue, 31 May 2022 13:55:11 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v1-20020a922e01000000b002d10dc367a1sm4808460ile.49.2022.05.31.13.55.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 13:55:10 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/8] lib: Add definitions for ISO socket
Date:   Tue, 31 May 2022 13:55:02 -0700
Message-Id: <20220531205509.1062466-1-luiz.dentz@gmail.com>
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
v5: Add BT_DEFER_SETUP tests to iso-tester

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
2.35.1

