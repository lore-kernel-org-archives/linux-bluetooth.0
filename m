Return-Path: <SRS0=Qv9v=2X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01577C2D0DC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 17:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB0021734
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 17:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY8/HbOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgABRYu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jan 2020 12:24:50 -0500
Received: from mail-pj1-f46.google.com ([209.85.216.46]:36456 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgABRYt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jan 2020 12:24:49 -0500
Received: by mail-pj1-f46.google.com with SMTP id n59so3609860pjb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jan 2020 09:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r26ZGSJQEt3FmkInwqJEPLO1xlgFwY2lZaHaRg6lYwg=;
        b=aY8/HbOTKde4UsPJ3UEF8emBVCWj1k4yia5z2ffIv7g9oP3cfQYRo/VTm2lUZpBvFk
         KvxK7s65/j1QyKcG+eBrkpnjodEfZ84IHgJc8c3k71Tmr5dAeaWcKGhQhIXFvCqy7zU+
         6Z+JaUXv7e3Mk5UkOgXbK+2zqybRH7yzm6D+ZrT42GJfTvicFtmaFLTd65jl1ceu1o8r
         on4U0Ew1qK2WR+xRYdkrMSlcSmQwwLvuStW0ON51GYR/sp/d0ip2N+1hu8YM63ptkpLW
         aZ2talx3IIKSttYARaT8Gjcg0MQG19V6ZtzUEdtQ1go9Bge6IOiLfG8Sw9CVaLquYASD
         s64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r26ZGSJQEt3FmkInwqJEPLO1xlgFwY2lZaHaRg6lYwg=;
        b=bPeI2n3PaKOcougWaC7zntEQYuKhquGGMh9D84p7kyUshxUmWw1BTyI2asMcyanzoW
         Lh+YOsYyAa+12Q8Cjyc/PTv98WyejaSiY7LtlE5P/Wz4Bgfn7kADgaCEK7I834o6FFKj
         xJPDm8RraIYQqX6KiK4Z/3kXIcemzpVSy6up7tGu5GIOHDcvhmEXStlcaOUkgAaCDFZB
         XB3m1I0c7nLu8YE26qsOo+ixBREVCt6Fdm/EOxGkyjvPruBj1/omLzYPeco5ry79u7Dy
         7/eTx2n9GUzVTUY9pW3OkNGsSS4br5Rhu+S4llwfWI3umk6nPOfJKXNpHWGCsgeH5MeW
         gdQg==
X-Gm-Message-State: APjAAAV0BkAVi14kQgMK8yUhlW02eY4pqcBYEnIgMQJ10kTKTQ2Hyi7N
        PEo7pTwc2euW9+ZlfsJNYG8p4FSo1tA=
X-Google-Smtp-Source: APXvYqz6iugBhDurwn2n4RR1rspsrVfutS5Z69L5vlyBr+QfTTAmyHdlpr8U5sBoRgmyHSZkoTIwPg==
X-Received: by 2002:a17:902:7004:: with SMTP id y4mr86266450plk.263.1577985888822;
        Thu, 02 Jan 2020 09:24:48 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id o6sm59041087pgg.37.2020.01.02.09.24.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 09:24:48 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 1/2] Bluetooth: HCI: Add support for LE PHY Update Complete event
Date:   Thu,  2 Jan 2020 09:24:46 -0800
Message-Id: <20200102172447.18574-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This handles LE PHY Update Complete event and store both tx_phy and
rx_phy into hci_conn.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |  8 ++++++++
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_event.c        | 27 +++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5bc1e30dedde..07b6ecedc6ce 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2186,6 +2186,14 @@ struct hci_ev_le_direct_adv_info {
 	__s8	 rssi;
 } __packed;
 
+#define HCI_EV_LE_PHY_UPDATE_COMPLETE	0x0c
+struct hci_ev_le_phy_update_complete {
+	__u8  status;
+	__u16 handle;
+	__u8  tx_phy;
+	__u8  rx_phy;
+} __packed;
+
 #define HCI_EV_LE_EXT_ADV_REPORT    0x0d
 struct hci_ev_le_ext_adv_report {
 	__le16 	 evt_type;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b689aceb636b..faebe3859931 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -493,6 +493,8 @@ struct hci_conn {
 	__u16		le_supv_timeout;
 	__u8		le_adv_data[HCI_MAX_AD_LENGTH];
 	__u8		le_adv_data_len;
+	__u8		le_tx_phy;
+	__u8		le_rx_phy;
 	__s8		rssi;
 	__s8		tx_power;
 	__s8		max_tx_power;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1941f120a376..6ddc4a74a5e4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5718,6 +5718,29 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_le_phy_update_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_le_phy_update_complete *ev = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+
+	if (!ev->status)
+		return;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (!conn)
+		goto unlock;
+
+	conn->le_tx_phy = ev->tx_phy;
+	conn->le_rx_phy = ev->rx_phy;
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_meta *le_ev = (void *) skb->data;
@@ -5753,6 +5776,10 @@ static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_le_direct_adv_report_evt(hdev, skb);
 		break;
 
+	case HCI_EV_LE_PHY_UPDATE_COMPLETE:
+		hci_le_phy_update_evt(hdev, skb);
+		break;
+
 	case HCI_EV_LE_EXT_ADV_REPORT:
 		hci_le_ext_adv_report_evt(hdev, skb);
 		break;
-- 
2.21.0

