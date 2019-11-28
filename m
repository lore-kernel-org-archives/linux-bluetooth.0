Return-Path: <SRS0=XR6q=ZU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D8BC432C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Nov 2019 09:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2C72178F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Nov 2019 09:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnRRoR5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfK1JRl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:17:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37348 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfK1JRl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Nov 2019 04:17:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id p24so12841480pfn.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2019 01:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3kO1+94SCjfh/ohMmsUhGcrwMCWC3JcgJSgZ/p+JoOs=;
        b=rnRRoR5FMfw5SaBwJKxx5osbc7al1E1dqwtmoE3e1SdbGKy1yIGsDhb411wdzmCkcQ
         cfOMZEpOm4rgPTVAuvTMPAwdnqTOYm2S7GgJ+pkqZ+89fqZhu830nfRbnq0SYt9XDxAx
         ecxsiXlw8D8gxr+eblzmsAp837iNzImRD7/TB0wcB/0iC7iBygH2yNMklb7Wjq5VHFg+
         0/4LmUq1iaLSdTJSKczXGDHtiVL1BLrVuznSra+NCh3zJbToUhWPwgCVohw+kADP44n6
         EYX7oxmqPxkI+38L+GeM3FXOnWllYnvexQ4ZpCO/GYKYZbHumrhSvWc1tNB3LSw2zhMQ
         KPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3kO1+94SCjfh/ohMmsUhGcrwMCWC3JcgJSgZ/p+JoOs=;
        b=i9ZE972HQKM8OzDwL9LEmyEo/XoGq2kurFrqbmyx4fE+RnmcsjXjKx4A1f1BgC/GiK
         NlHwEmudf7cV5bLwB9BhoLOwgkYDARoKS4EGfalgfxB3gUviaLDUGk6w3JfswdRUhJMs
         RNWYTlcyHmJA/LbhxY7vsNXbeML7ly/BgYHabm6cihSTyqyX4d+B7aLzRzSU4UaC0HI3
         NhwRWu+48StWpSjmzaBSkv45l42OupMyb5j/oO5wKZt2Ei9fAVq7Nl7YwwbZIkGyOcJa
         VUViEbPKCHkMu3COFN8WkMmdrpqCTSnDpflwR5WCi2G2Nxd1ylEs4CO6YVdkkQ76jd9t
         JhGg==
X-Gm-Message-State: APjAAAW4kh4tnUsC1jp0IGIVI5m5IueW/K7uE4tYzVOCZr9dFzN4eOM1
        DLBT9snlwSswNiX3XaTs56bsRM8dyLQrMA==
X-Google-Smtp-Source: APXvYqyzSL+WB/6laSINTKgGbL0jk9axeqgSnHjGXgctRjSMIarlLViWAB7/mBJgLjjSmoif0sW15g==
X-Received: by 2002:a63:4303:: with SMTP id q3mr10232320pga.439.1574932660397;
        Thu, 28 Nov 2019 01:17:40 -0800 (PST)
Received: from nsathish-Latitude-7480.iind.intel.com (jfdmzpr05-ext.jf.intel.com. [134.134.139.74])
        by smtp.gmail.com with ESMTPSA id a12sm18733577pga.11.2019.11.28.01.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 01:17:39 -0800 (PST)
From:   Sathish Narsimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narsimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH v4 1/2] bluetooth: add support to notify SCO air mode
Date:   Thu, 28 Nov 2019 14:47:47 +0530
Message-Id: <20191128091748.24531-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

notifying HCI_NOTIFY_CONN_ADD for SCO connection is generic in
case of msbc audio. To differnetiate SCO air mode audio introducing
HCI_NOTIFY_SCO_CVSD and HCI_NOTIFY_SCO_TRASP.

Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
---
 include/net/bluetooth/hci.h      | 2 ++
 include/net/bluetooth/hci_core.h | 3 +++
 net/bluetooth/hci_event.c        | 9 +++++++++
 3 files changed, 14 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5bc1e30dedde..26af112b1f2c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -52,6 +52,8 @@
 #define HCI_NOTIFY_CONN_ADD		1
 #define HCI_NOTIFY_CONN_DEL		2
 #define HCI_NOTIFY_VOICE_SETTING	3
+#define HCI_NOTIFY_ENABLE_SCO_CVSD	4
+#define HCI_NOTIFY_ENABLE_SCO_TRANSP	5
 
 /* HCI bus types */
 #define HCI_VIRTUAL	0
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b689aceb636b..9258e19f8cc5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1604,4 +1604,7 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 #define SCO_AIRMODE_CVSD       0x0000
 #define SCO_AIRMODE_TRANSP     0x0003
 
+#define SCO_CODED_CVSD         0x02
+#define SCO_CODED_TRANSP       0x03
+
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c1d3a303d97f..ecad696db139 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4231,6 +4231,15 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 		break;
 	}
 
+	BT_DBG("sco connected with air mode: %02x", ev->air_mode);
+	if (ev->air_mode == SCO_CODED_CVSD) {
+		if (hdev->notify)
+			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_CVSD);
+	} else if (ev->air_mode == SCO_CODED_TRANSP) {
+		if (hdev->notify)
+			hdev->notify(hdev, HCI_NOTIFY_ENABLE_SCO_TRANSP);
+	}
+
 	hci_connect_cfm(conn, ev->status);
 	if (ev->status)
 		hci_conn_del(conn);
-- 
2.17.1

