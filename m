Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D20EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 23:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637C2229CA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 23:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgLUXCY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Dec 2020 18:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgLUXCY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Dec 2020 18:02:24 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08549C0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 15:01:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b5so292294pjl.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 15:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+D78R+KUxlxs8S2JpfeUAyag+Ph+68TNR9WVVh4II7k=;
        b=dGqVhadeuKjDYEfja+R5Urvt9MjBu2Y/uW4K28v9aJdwDRucfKSYXRG/BNpTIdmKMt
         pjxSNMbcdWck1RxeN4UNtdcxm2xPtdisvistIUZzVcVEOmaYi2d8rgAP+92kP/1Ekxq/
         aU2mEE2saPdacN09xE64HLBS6XHt+sXWsFPCjiGw1QdEevQE60Rg1UBjreqM+VrvXJkj
         lliCyNNsdhmaOj2RqCGcmX7PrPfObfykpxRSmWxFbz4/c4qr44dP36t1nHJPb7Nmc2Vw
         rJYxatboNTbDe/lvGMgLqn8HkRDiIeji7SWQF5topwGOuhIBOAS7RSOdJ0AYx8ev/Dls
         /Jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+D78R+KUxlxs8S2JpfeUAyag+Ph+68TNR9WVVh4II7k=;
        b=YJ1XWR64RjIoZ6Y+v0HTDt6tOC3t4F3enSMSSiju2M8trYHO6THX5y9EB5v0xGKNV9
         QL4ugqjJdgFftSdXVwrDBwMYVHCaih6XIo5HPpGNSDc8I+QXM1q4RW59daZ1ALRQ7ZgM
         Jdvw0ez/yRHPhIzaV3jyg0x5UmIp/FsTJyk05VQMDXhaI7EccPj1SBIB9skEVHibeMAF
         vAze7WJ+PgJZCt/EnTqGe5VT27WN9UCVa0ZXgEXHmbxNGIO8qsDllR0FVySEVidQTU3j
         4UOqOh7LdC7RjN644F1iS8JRZbih1KseP3NCALv4grJi/zOVZCyC2qzAo0c7LHmYz0xK
         RPTg==
X-Gm-Message-State: AOAM533Mc3vcbFuGMSsD+DPVWA8wqXAN5LudONr4BqVKmVsZ3/krDJrU
        /En+dSzTn8G1zgwiExMBUwaj3gU2wJg=
X-Google-Smtp-Source: ABdhPJzVpwoY9BTAsgbEW428cH8aQQOHoYmOZSJqpx8vR+3kh5WKa5f5QZ6tRgspC+VysHSw9ILRcA==
X-Received: by 2002:a17:902:b116:b029:dc:c93:1d6b with SMTP id q22-20020a170902b116b02900dc0c931d6bmr741588plr.22.1608591702665;
        Mon, 21 Dec 2020 15:01:42 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a19sm17131855pfi.130.2020.12.21.15.01.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 15:01:41 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] lib: Add definitions for ISO socket
Date:   Mon, 21 Dec 2020 15:01:37 -0800
Message-Id: <20201221230140.2100824-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 lib/bluetooth.h | 24 ++++++++++++++++++++++++
 lib/iso.h       | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 lib/iso.h

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 9ab033ec4..0d4557377 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -37,6 +37,7 @@ extern "C" {
 #define BTPROTO_CMTP	5
 #define BTPROTO_HIDP	6
 #define BTPROTO_AVDTP	7
+#define BTPROTO_ISO	8
 
 #define SOL_HCI		0
 #define SOL_L2CAP	6
@@ -140,6 +141,29 @@ struct bt_voice {
 
 #define BT_SCM_PKT_STATUS	0x03
 
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
+	uint8_t  cig;
+	uint8_t  cis;
+	uint8_t  sca;
+	uint8_t  packing;
+	uint8_t  framing;
+	struct bt_iso_io_qos in;
+	struct bt_iso_io_qos out;
+};
+
 /* Connection and socket states */
 enum {
 	BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
diff --git a/lib/iso.h b/lib/iso.h
new file mode 100644
index 000000000..2d427b417
--- /dev/null
+++ b/lib/iso.h
@@ -0,0 +1,45 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2019  Intel Corporation.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
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
+
+/* ISO socket address */
+struct sockaddr_iso {
+	sa_family_t	iso_family;
+	bdaddr_t	iso_bdaddr;
+	uint8_t		iso_bdaddr_type;
+};
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __ISO_H */
-- 
2.26.2

