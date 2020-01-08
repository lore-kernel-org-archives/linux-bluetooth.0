Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB48CC33C9B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80EA72075A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC6hEdzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgAHAds (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:33:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34282 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgAHAdr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 19:33:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id x17so387743pln.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 16:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=j2ZCFATyIGjIUkx/0ER/kXgMfFAg7tvRILbBVi+IPog=;
        b=JC6hEdzQh/YA92JYxZDHlsT8Mg/FK+ZlagckdnjJxuJM8YgpADoagVexJ2knt1/X6V
         S9usrwtR5DntsefybCRIPkPizwUxOPNSXHCl+bOd756P8jRUF5J+CuvhlOaYh7x4NjwT
         YbbJ9/xMdXMjfUha5SmusYMPFiqqDN0qGRjq60PsOYGUOTSFxWlWoZUORSfpisGCkOFI
         MgMwDxcemCG7EMWhGV0oLcKPxKStrXHEQ47XFMRhHmflOWh5WxvXX2QuFvIs4VooTx+a
         8T0x8e0FaXzULWQYPRqWP1BKj/23lmR+v6DqZUrtIYsaJWRzrmPjUQxHsER0Kjx0/KWi
         rgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2ZCFATyIGjIUkx/0ER/kXgMfFAg7tvRILbBVi+IPog=;
        b=csN/lhYjgWKdn+GpyoM5KBQsRMKoUkQ4Z6V4FXo31x2c9TMtD6ZMnuki3dKB1Ajz9D
         jgG4TVllCZeXZgQEpP0R7MjCUq4KQ1ehGhGyidAoNcjuIWM1xbF4K7xALGW9lvJt5yFD
         MPBsFfyxwRzw5zEQk0xsLAvTTAmN/fb+UOTwKGHBDdNfrtwxOo7r0P9UmRYOVYvcR/tD
         8YnjicnpPswURPZnlvkjVZyoxa5lQzl8Zt4FkHTEbO3D4xzXINt3cozCHn+hnxVGpC7w
         qCNgVc1gME76PwXOwU79Kl5D2WNFGT/x1CVuyA6wrIKZV/iJhHZOMhY7tPOWQSJz+4OP
         zN2g==
X-Gm-Message-State: APjAAAX3YeG8s/iK1X5+g0bV8kKLABjswcWyz9SxKvyjMnhB2jDphEz0
        uEhVODyr7jKOAkuU9qgFHz1jekKeEN0=
X-Google-Smtp-Source: APXvYqxY47XM3yVpNNuridM79aXkAv0lJCfNT2tG4eIzh8Lcv/BdQkOUk8mNcRGCaxrszDPSzqfQgw==
X-Received: by 2002:a17:902:bd96:: with SMTP id q22mr2483912pls.94.1578443626617;
        Tue, 07 Jan 2020 16:33:46 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.43])
        by smtp.gmail.com with ESMTPSA id u10sm925805pgg.41.2020.01.07.16.33.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:33:46 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/22] lib: Add definitions for ISO socket
Date:   Tue,  7 Jan 2020 16:33:23 -0800
Message-Id: <20200108003342.15458-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200108003342.15458-1-luiz.dentz@gmail.com>
References: <20200108003342.15458-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 lib/bluetooth.h | 14 ++++++++++++++
 lib/iso.h       | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 lib/iso.h

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 756dce164..ec110f757 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -50,6 +50,7 @@ extern "C" {
 #define BTPROTO_CMTP	5
 #define BTPROTO_HIDP	6
 #define BTPROTO_AVDTP	7
+#define BTPROTO_ISO	8
 
 #define SOL_HCI		0
 #define SOL_L2CAP	6
@@ -120,6 +121,19 @@ struct bt_voice {
 #define BT_SNDMTU		12
 #define BT_RCVMTU		13
 
+#define BT_ISO_IN_QOS		15
+#define BT_ISO_OUT_QOS		16
+struct bt_iso_qos {
+	uint8_t  sca;
+	uint8_t  packing;
+	uint8_t  framing;
+	uint32_t interval;
+	uint16_t latency;
+	uint16_t mtu;
+	uint8_t  phy;
+	uint8_t  rtn;
+};
+
 #define BT_VOICE_TRANSPARENT			0x0003
 #define BT_VOICE_CVSD_16BIT			0x0060
 
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
2.21.0

