Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D97C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 22:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444766AbiEFWf1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 18:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376814AbiEFWf0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 18:35:26 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3322528F
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 15:31:41 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id s14so5658992ild.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 15:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcmTdjLDG7vNZdhSiKPXKeV+gyyg0CAX0q35uYBnL4w=;
        b=c1c9ZKbfSOB4xTOGzoddW2nA6QnnHKlDDOgG70Y4fgjzIeS9id7SZMq2GIeWlfreHl
         swDj9nturfbS3lc0Ll+bTKUxe7TheP0p+4IVwU/ut1quTFYGmxZk/uPpGj/hH0FsEqgr
         g9z33ovPZrAJMnUnQxPAqZY/tLP1VWV8+VKJ8/EnJ6ICrN2X6n1Be+gM+VkZLUEsco7e
         wbFw5fzydE2yhH/tDNQpz/ZhDRPvuqzjCbmZo7HnoHzPCEsSMuuUU/R3mzKeErb30Avg
         gB2XV1/AftfRNF3e0Gol8JmrNdB5dyGQh6cMMPQoMdZJZOMjQXNU9lf2RnO8neoJ+Nm0
         0Oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcmTdjLDG7vNZdhSiKPXKeV+gyyg0CAX0q35uYBnL4w=;
        b=A9lCC8qAVSPKd62pXdrFBraldZvM4BbTnhmlAs1kjMwA6W7Ho2Lrd0ylGHiKv+8ctk
         PMXCP5HP7dwHlbMyUcPSkvfn2jo6NUAa0gZuVQhEfSCLGQ5atOA3CWOabWTItpsFFweD
         FyVcBrxUZPfS0R056QYipEMElRJUsBYSvQ8icLefpvZ911Qxfgoo4YTDJRmfKVhLfayJ
         vXPcc7cT8uryx0Lz0CfQI4BIxkiG+P67EK7EPAmJrBD19TcRs6vUKbqA/E2cfqkGfDyg
         wp0CuoGIo495Z808dnQtZvEKasTXJ1VNNcyrB1nUJvXTksPMqBnTI/HsndIPpzha1GUh
         wesQ==
X-Gm-Message-State: AOAM533mTh4JvTWN949bwexx7PUX5Ta7NtV+nohCoxJ9LeJzLP32evX7
        OR01gEnNOEg1fFJMXyNgw6xgaw4tI9g=
X-Google-Smtp-Source: ABdhPJyY6YF/3UC49jaAimpUE1EWh9arormgVdZKt0wDPc9f0oYbQNAgYhZnz9wiZ+JEEdpUuJNuVA==
X-Received: by 2002:a05:6e02:ca4:b0:2cd:d46a:6928 with SMTP id 4-20020a056e020ca400b002cdd46a6928mr2145075ilg.287.1651876300752;
        Fri, 06 May 2022 15:31:40 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p16-20020a92c110000000b002cbed258dcfsm1488375ile.0.2022.05.06.15.31.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 15:31:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 BlueZ 1/8] lib: Add definitions for ISO socket
Date:   Fri,  6 May 2022 15:31:27 -0700
Message-Id: <20220506223139.3950573-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
v2: Fix CI findings.
v3: Add patch fixing mgmt-tester Read EXP Features tests

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

