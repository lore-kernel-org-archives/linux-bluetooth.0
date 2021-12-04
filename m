Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B535BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Dec 2021 00:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383641AbhLDATL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 19:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383637AbhLDATK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 19:19:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D816AC061751
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Dec 2021 16:15:45 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x7so3535726pjn.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Dec 2021 16:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cntzzbMuHfFI+CW65xIGMit0hA1h9tWw2PgUkC3i+8Q=;
        b=KksgsIDmWRkAt7D2dQOjV3/trJDlvgpjbm82U5+ovUzFBt2a6z0b+HBhVmNAzfxKkl
         IkS9TrCIY5upyGVud9k8dLi5z3bO3wgqi4f0dYTjDJNXgOYLnrll+d1sgh0GihKzU7eS
         HDuU9lbj5R7aylMEKYS91Oy4lrNfWtDBQyCjBbVH4b/In1cy1dBdcYlt5mOmCN5ZAoIE
         PVgRakBlEDWJPYYS8VNhxaFWFDX4IDKE5MJlnq1LVzQLPTPcqFT6XVgutXqryNOhtzWC
         fXnfY3pucWe4pPkTt2DVUn3H5kBcC+uxIgJDx2VHjgyukFH+yfCuSW5AFpj5SzDuxUB1
         7tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cntzzbMuHfFI+CW65xIGMit0hA1h9tWw2PgUkC3i+8Q=;
        b=DGqkh1kGsGA+HCriINxFM1awaq8oSCyaB6zPQZ7FdzJApOJ7K2t3MIWuhf9zogZYvv
         oIGVmcVSUyE1xYZ68B3x5b5visJQ5RmdUo/QTyejFpIGAhs+gthJlKJnLgP/OSdfewdC
         hQh80p3sriA+7W5I99LxQ7hWxYSIdjWo1VA2NLpCxB7Ht36p4rfmfAnnnh7Rw4XYKC1I
         Q/oYuhkLiBZ9pGx6mRo/lWqdegtFqJxmwGNXdQpjo58ZDCJW74MxcaM9eCukI4uifTb9
         cnjXu4UiHnqF8o0YmIJvtWAFUTGVBPbbki3G9LQagib/kAePRS9Oc07QlrkzJilr/17A
         MoJw==
X-Gm-Message-State: AOAM533xlHN/KWc1HDrTFqI6z7zwtP9oy0s53g5vm5Z7X2Q2kr+bxUWS
        I5eaFtSAEnx/vibwzyhxDWhtC59Pyv4=
X-Google-Smtp-Source: ABdhPJzilvrsd5zmDtROaLKRQJf9JxdNAy87bS9o2bWVtIH5215OYW81A40hcLgkgfIT3pDIKSj6wg==
X-Received: by 2002:a17:902:e890:b0:142:f3:7bf7 with SMTP id w16-20020a170902e89000b0014200f37bf7mr26115387plg.87.1638576945085;
        Fri, 03 Dec 2021 16:15:45 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g21sm4381221pfc.95.2021.12.03.16.15.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 16:15:44 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: mgmt: Make use of mgmt_send_event_skb in MGMT_EV_DEVICE_FOUND
Date:   Fri,  3 Dec 2021 16:15:41 -0800
Message-Id: <20211204001542.2404778-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204001542.2404778-1-luiz.dentz@gmail.com>
References: <20211204001542.2404778-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of mgmt_alloc_skb to build MGMT_EV_DEVICE_FOUND so the
data is copied directly to skb that is then sent using
mgmt_send_event_skb eliminating the necessity of intermediary buffers.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 52 ++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7d3c69c3cf62..8a66f947c543 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -335,6 +335,12 @@ static int mgmt_event(u16 event, struct hci_dev *hdev, void *data, u16 len,
 			       HCI_SOCK_TRUSTED, skip_sk);
 }
 
+static int mgmt_event_skb(struct sk_buff *skb, struct sock *skip_sk)
+{
+	return mgmt_send_event_skb(HCI_CHANNEL_CONTROL, skb, HCI_SOCK_TRUSTED,
+				   skip_sk);
+}
+
 static u8 le_addr_type(u8 mgmt_addr_type)
 {
 	if (mgmt_addr_type == BDADDR_LE_PUBLIC)
@@ -9538,9 +9544,8 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
 		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
 {
-	char buf[512];
-	struct mgmt_ev_device_found *ev = (void *)buf;
-	size_t ev_size;
+	struct sk_buff *skb;
+	struct mgmt_ev_device_found *ev;
 
 	/* Don't send events for a non-kernel initiated discovery. With
 	 * LE one exception is if we have pend_le_reports > 0 in which
@@ -9575,13 +9580,13 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		}
 	}
 
-	/* Make sure that the buffer is big enough. The 5 extra bytes
-	 * are for the potential CoD field.
-	 */
-	if (sizeof(*ev) + eir_len + scan_rsp_len + 5 > sizeof(buf))
+	/* Allocate skb. The 5 extra bytes are for the potential CoD field */
+	skb = mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_FOUND,
+			     sizeof(ev) + eir_len + scan_rsp_len + 5);
+	if (!skb)
 		return;
 
-	memset(buf, 0, sizeof(buf));
+	ev = skb_put(skb, sizeof(*ev));
 
 	/* In case of device discovery with BR/EDR devices (pre 1.2), the
 	 * RSSI value was reported as 0 when not available. This behavior
@@ -9602,35 +9607,39 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 	if (eir_len > 0)
 		/* Copy EIR or advertising data into event */
-		memcpy(ev->eir, eir, eir_len);
+		skb_put_data(skb, eir, eir_len);
+
+	if (dev_class && !eir_get_data(eir, eir_len, EIR_CLASS_OF_DEV, NULL)) {
+		u8 eir_cod[5];
 
-	if (dev_class && !eir_get_data(ev->eir, eir_len, EIR_CLASS_OF_DEV,
-				       NULL))
-		eir_len = eir_append_data(ev->eir, eir_len, EIR_CLASS_OF_DEV,
-					  dev_class, 3);
+		eir_len += eir_append_data(eir_cod, 0, EIR_CLASS_OF_DEV,
+					   dev_class, 3);
+		skb_put_data(skb, eir_cod, eir_len);
+	}
 
 	if (scan_rsp_len > 0)
 		/* Append scan response data to event */
-		memcpy(ev->eir + eir_len, scan_rsp, scan_rsp_len);
+		skb_put_data(skb, scan_rsp, scan_rsp_len);
 
 	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
-	ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
 
-	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
+	mgmt_event_skb(skb, NULL);
 }
 
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len)
 {
+	struct sk_buff *skb;
 	struct mgmt_ev_device_found *ev;
-	char buf[sizeof(*ev) + HCI_MAX_NAME_LENGTH + 2];
 	u16 eir_len;
 	u32 flags;
 
-	ev = (struct mgmt_ev_device_found *) buf;
-
-	memset(buf, 0, sizeof(buf));
+	if (name_len)
+		skb = mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_FOUND, 2 + name_len);
+	else
+		skb = mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_FOUND, 0);
 
+	ev = skb_put(skb, sizeof(*ev));
 	bacpy(&ev->addr.bdaddr, bdaddr);
 	ev->addr.type = link_to_bdaddr(link_type, addr_type);
 	ev->rssi = rssi;
@@ -9639,6 +9648,7 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		eir_len = eir_append_data(ev->eir, 0, EIR_NAME_COMPLETE, name,
 					  name_len);
 		flags = 0;
+		skb_put(skb, eir_len);
 	} else {
 		eir_len = 0;
 		flags = MGMT_DEV_FOUND_NAME_REQUEST_FAILED;
@@ -9647,7 +9657,7 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	ev->eir_len = cpu_to_le16(eir_len);
 	ev->flags = cpu_to_le32(flags);
 
-	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, sizeof(*ev) + eir_len, NULL);
+	mgmt_event_skb(skb, NULL);
 }
 
 void mgmt_discovering(struct hci_dev *hdev, u8 discovering)
-- 
2.33.1

