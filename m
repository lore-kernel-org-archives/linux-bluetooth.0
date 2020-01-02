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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888EDC3276E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 23:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE6320866
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 23:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ru2V+IE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgABXBF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jan 2020 18:01:05 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:37467 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbgABXBA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jan 2020 18:01:00 -0500
Received: by mail-pg1-f180.google.com with SMTP id q127so22591220pga.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jan 2020 15:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r26ZGSJQEt3FmkInwqJEPLO1xlgFwY2lZaHaRg6lYwg=;
        b=ru2V+IE6TEQyFoB74AYvc58Mnlyq2GsBOFosZcx9BCufA0yKFJqQj4t1zncfMyv4E9
         d8GARbLZfxBiqjswfby+ZNrNv7Blg2er7JKEQrcykDoyMw3iHAbGV5iVbE7TwMhGBXjP
         PVxhpcxXG4ovtQKLu4+AhFinSZVBxKpG6D2JIHaffUzEFoLDEYENRwGTSVlypY9aLUos
         t9LuGXljNLyzg6KWNK6z9n2Cn3c34JlhR08+QxRGj2yRaLSLXq9XMAw7LnkJ/UexWNT6
         l1Mn/6jvw5daHx8sPhKghM160Upya2cA8Rj+N7gyuvSL3B24BEk3QHVs/BqE9N6NO+U2
         VaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r26ZGSJQEt3FmkInwqJEPLO1xlgFwY2lZaHaRg6lYwg=;
        b=f/yiUsok7jboKQDB+mxIwyy5mKsOFNpVAo2Ah11h/Yfh1mmG6lemUMMzTrM47ZKEFO
         J8n0CUf4rjJ10Ug+UFaaeE+0kWg/YusFtj3Tf/z2e+Rh5t1YYFADtK3XtG1hQ9P19T/d
         s9PM0qELJ9L6wuYBS/bNQGEFEojxZGcIVnLBZBBzhgWl49n39Pq19Mu4mRVVS2Gys0YI
         HBkaqMWWwpymcU2hxCBasRcgGtta4IPjVmqOb7hxCaJFUVVleRz0/gn2JSGsKhigOTz0
         cE8i2+yMYTfRnh1E46vZSO3hLBtdy6lq0JfvAA+dQSJ0Njg/2XCZSmcOPtIds1MYMAC3
         H6+A==
X-Gm-Message-State: APjAAAVm2A0e5IQxGPfg5ptOD6iS/wtEDtH8aRTQdHg8Ps52veqhm/Ni
        4xF6qioB8QWH4u23rLUaPNkFlz5ohag=
X-Google-Smtp-Source: APXvYqzmzYYe+j2QVabDmLj9bkqLVhNvg2z7FwEKM2i2oJmMaWkKLu1k/5vfDx8J5PuJVlQlWuRr1Q==
X-Received: by 2002:a62:33c6:: with SMTP id z189mr91532459pfz.246.1578006059477;
        Thu, 02 Jan 2020 15:00:59 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id 83sm61468946pgh.12.2020.01.02.15.00.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 15:00:58 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 1/3] Bluetooth: HCI: Add support for LE PHY Update Complete event
Date:   Thu,  2 Jan 2020 15:00:55 -0800
Message-Id: <20200102230057.31326-1-luiz.dentz@gmail.com>
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

