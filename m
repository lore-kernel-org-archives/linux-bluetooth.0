Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E70BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 18:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352608AbhLAS6q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 13:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352045AbhLAS6g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 13:58:36 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A5CC061748
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 10:55:15 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id l190so24576353pge.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 10:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rGmuzjNWCJwSMo2crUTDHRKMD3or9KnZlwBZfVFowyQ=;
        b=qxQg1mqEWqACKJ1P8uWqlJtOP5hLJnOxf4njPWxJiRKwiY2L9jgUFtcucJ6F8f1G5P
         RqIA6TEFOxknLL5GGuLU3NQFz95DCWLDC/1AbPz6C6PvSTblRySBhmcfyDENudA/ll6M
         GpWEH9HSJnIeZFlSzUwzpmr3/aL6CukbL459K+1SED0igdaH3XaHuqTcpvltnwfu7qS2
         6qHkOTYFo2ECWGPpthn0grKXyUhcJyfdA+Q4/32cyRQsoKXWHOXPm/tfJsthPhvpHG3x
         FYndGOvvfzqMVudyuNCsJdLlrVgkx9to5Fy7jARz0waQC4nNP8T2bSYSrP+bRbZTzerY
         dv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rGmuzjNWCJwSMo2crUTDHRKMD3or9KnZlwBZfVFowyQ=;
        b=3ZBsJ0bQ4XUWpcQRRw7M1NaBep28x8nMsqvSl5ErIJCyCLo0GSoDMdi+/wQLnLLI0v
         Op0YiKWUpBDU8pu2B2kNzh8dpzGw1RL+JTxqw+gudQBy/8UJPF10m+OQVZTVSRM58EnW
         FFpri3D2WkmkIZAeHHMV27ZrvX0YPQaVHXrkRZBMOgBFmSPP5/vmjL4de419o3lzBRZK
         FWow7Emh4UeAkAPEnJmHGMRrDW/Rw4dr4e1DhVx1DwaY6C59ueZEufZmAkNlBGVb9ALL
         fZisoK+Oyrx45LHFoBO4QkP8PNTyv0jndU8tPtGDyDjKOYBuY4aldML2KRIGd4UMjkxe
         dLhQ==
X-Gm-Message-State: AOAM533e3KotQKLxmL8bphn92F3GfxCeok0TrG6yzIlR+XQw7KWf5a+y
        DnFvMyVOouHUU6k17ddDAlTyowXURa8=
X-Google-Smtp-Source: ABdhPJwETjkUVaoWU9JIUdOZHVXeCqzrfLGU2dS4AicC1FrtNR0h1d2Gh6UGxfrgGIIpG2az2ChPtQ==
X-Received: by 2002:a05:6a00:807:b0:49f:9a8d:23b4 with SMTP id m7-20020a056a00080700b0049f9a8d23b4mr7758128pfk.71.1638384914620;
        Wed, 01 Dec 2021 10:55:14 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e19sm359391pgt.49.2021.12.01.10.55.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:55:14 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/15] Bluetooth: HCI: Use skb_pull_data to parse LE Advertising Report event
Date:   Wed,  1 Dec 2021 10:55:00 -0800
Message-Id: <20211201185506.1421186-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201185506.1421186-1-luiz.dentz@gmail.com>
References: <20211201185506.1421186-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses skb_pull_data to check the LE Advertising Report events
received have the minimum required length.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  7 ++++++-
 net/bluetooth/hci_event.c   | 39 +++++++++++++++++++++++--------------
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 9e721e6efef3..c005b1ccdbc5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2445,13 +2445,18 @@ struct hci_ev_le_conn_complete {
 
 #define HCI_EV_LE_ADVERTISING_REPORT	0x02
 struct hci_ev_le_advertising_info {
-	__u8	 evt_type;
+	__u8	 type;
 	__u8	 bdaddr_type;
 	bdaddr_t bdaddr;
 	__u8	 length;
 	__u8	 data[];
 } __packed;
 
+struct hci_ev_le_advertising_report {
+	__u8    num;
+	struct hci_ev_le_advertising_info info[];
+} __packed;
+
 #define HCI_EV_LE_CONN_UPDATE_COMPLETE	0x03
 struct hci_ev_le_conn_update_complete {
 	__u8     status;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d30e77f66376..42ffd5df6d4b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6564,31 +6564,40 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 
 static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	u8 num_reports = skb->data[0];
-	void *ptr = &skb->data[1];
+	struct hci_ev_le_advertising_report *ev;
+
+	ev = hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_ADVERTISING_REPORT,
+				sizeof(*ev));
+	if (!ev)
+		return;
+
+	if (!ev->num)
+		return;
 
 	hci_dev_lock(hdev);
 
-	while (num_reports--) {
-		struct hci_ev_le_advertising_info *ev = ptr;
+	while (ev->num--) {
+		struct hci_ev_le_advertising_info *info;
 		s8 rssi;
 
-		if (ptr > (void *)skb_tail_pointer(skb) - sizeof(*ev)) {
-			bt_dev_err(hdev, "Malicious advertising data.");
+		info = hci_le_ev_skb_pull(hdev, skb,
+					  HCI_EV_LE_ADVERTISING_REPORT,
+					  sizeof(*info));
+		if (!info)
 			break;
-		}
 
-		if (ev->length <= HCI_MAX_AD_LENGTH &&
-		    ev->data + ev->length <= skb_tail_pointer(skb)) {
-			rssi = ev->data[ev->length];
-			process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
-					   ev->bdaddr_type, NULL, 0, rssi,
-					   ev->data, ev->length, false);
+		if (!hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_ADVERTISING_REPORT,
+					info->length + 1))
+			break;
+
+		if (info->length <= HCI_MAX_AD_LENGTH) {
+			rssi = info->data[info->length];
+			process_adv_report(hdev, info->type, &info->bdaddr,
+					   info->bdaddr_type, NULL, 0, rssi,
+					   info->data, info->length, false);
 		} else {
 			bt_dev_err(hdev, "Dropping invalid advertising data");
 		}
-
-		ptr += sizeof(*ev) + ev->length + 1;
 	}
 
 	hci_dev_unlock(hdev);
-- 
2.33.1

