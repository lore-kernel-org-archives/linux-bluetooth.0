Return-Path: <SRS0=5fC3=SF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC852C4360F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 23:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E222147C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 23:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEWxF6dC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDCXIw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Apr 2019 19:08:52 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:38766 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDCXIu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Apr 2019 19:08:50 -0400
Received: by mail-pl1-f175.google.com with SMTP id g37so151923plb.5;
        Wed, 03 Apr 2019 16:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kJGFCq3WEM2nR2OBL/VzxgfL4YYVH3Bm7taMZGFMCiQ=;
        b=DEWxF6dCvrUz015Lh215MQLIfmZ+w4FhcM8rUxsNKKNcaJdP5fL4S3Hqva1aSb+kWv
         tNtRD8kWUqd+vd3h25UuqTyPFmfcGSpxgDeQOadbcF/ULAi/MP4qd94K1pmWjKrDZXio
         6ClDSglVpsTv4wUwD91GWa0dYh2eI37KZ5a4Ewaca4m5BlD6sibGvUj9esRdxrePcB7N
         VZnWs+QX1A59ixBqcRb5GN43Pz3HWO6ZmWjMPJK2I/dVWvDOif4qM2P48jPYyaCag4N/
         Md16OQyPbXclHgxP3tX6b/3RVSqG7+94z6LL/ucZcifLM4s+4nfYtHAtt2gJE0P0CyWH
         4GMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kJGFCq3WEM2nR2OBL/VzxgfL4YYVH3Bm7taMZGFMCiQ=;
        b=C8jY0Ee3bZDtXVcjJHZgflKaQaMqO9ZNPvVADZPT+bX/ygSiGcLMRphF3zBj18Smf8
         gcaplH/OSl1VzK1nZsF63kEkhqLNGF0raJLyT4Nx1JcPKRB7k7DzfmQkkxzAGkTFaMD7
         qTLeh4ttgClvAWKxThKgo8UjVTcYHSxWO4Cht+S6E7BFc2Vue014ZVDXspFyP9uWBFZc
         euEVHRtz8g25sH+bNrGUyfl6Z/jYTv7z2s360ZM9m+VySOHYWLD2b/81NkoppAswA3Lz
         E9lDAaJxUoKXTHUfv6Kv4O2sND/t9PzmdT6S2kmx146EaVystroMOn3nLcP81r2XyVS+
         Lu3g==
X-Gm-Message-State: APjAAAUon1WaweauwYmzrFIOOMbs9yh2lgqTZcXVrkMmbXY+a+rGGykP
        fVMN+yP4Pm8unhLutxQ7iZn73oZs
X-Google-Smtp-Source: APXvYqx2saY2rpb/CjUA8COdCUugE4zv819Ab01tgLgl1Rx6NG0KXjPbcbF2M2yuKEDPlPeqrdObqQ==
X-Received: by 2002:a17:902:d70c:: with SMTP id w12mr2816158ply.198.1554332929126;
        Wed, 03 Apr 2019 16:08:49 -0700 (PDT)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id a7sm23439574pfc.45.2019.04.03.16.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 16:08:46 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     netdev@vger.kernel.org
Cc:     linux-bluetooth@vger.kernel.org,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [Patch net v2 2/3] bluetooth: validate HCI_EV_LE_META packet carefully
Date:   Wed,  3 Apr 2019 16:08:34 -0700
Message-Id: <20190403230835.1174-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403230835.1174-1-xiyou.wangcong@gmail.com>
References: <20190403230835.1174-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Similarly, we need to check skb->data boundary for
HCI_EV_LE_META event too.

Note, hci_le_adv_report_evt() and hci_le_ext_adv_report_evt()
are slightly complicated, as they read the length of the field
from the packet as well.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Tomas Bortoli <tomasbortoli@gmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/bluetooth/hci_event.c | 107 +++++++++++++++++++++++++++++++-------
 1 file changed, 87 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2fef70c0bffe..31aef14dd838 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5147,7 +5147,11 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 
 static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
+	struct hci_ev_le_conn_complete *ev;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -5161,7 +5165,11 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_le_enh_conn_complete *ev = (void *) skb->data;
+	struct hci_ev_le_enh_conn_complete *ev;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -5174,9 +5182,13 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 
 static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_evt_le_ext_adv_set_term *ev = (void *) skb->data;
+	struct hci_evt_le_ext_adv_set_term *ev;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	if (ev->status)
@@ -5203,9 +5215,13 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_le_conn_update_complete_evt(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
-	struct hci_ev_le_conn_update_complete *ev = (void *) skb->data;
+	struct hci_ev_le_conn_update_complete *ev;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	if (ev->status)
@@ -5511,15 +5527,29 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 
 static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	u8 num_reports = skb->data[0];
-	void *ptr = &skb->data[1];
+	unsigned int len;
+	u8 num_reports;
+
+	if (unlikely(!pskb_may_pull(skb, 1)))
+		return;
+	num_reports = skb->data[0];
+	len = 1;
 
 	hci_dev_lock(hdev);
 
 	while (num_reports--) {
-		struct hci_ev_le_advertising_info *ev = ptr;
+		struct hci_ev_le_advertising_info *ev;
+		u8 ev_len;
 		s8 rssi;
 
+		if (unlikely(!pskb_may_pull(skb, len + sizeof(*ev))))
+			break;
+		ev = (void *)skb->data + len;
+		ev_len = ev->length + 1;
+		if (unlikely(!pskb_may_pull(skb, len + sizeof(*ev) + ev_len)))
+			break;
+		ev = (void *)skb->data + len;
+
 		if (ev->length <= HCI_MAX_AD_LENGTH) {
 			rssi = ev->data[ev->length];
 			process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
@@ -5529,7 +5559,7 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			bt_dev_err(hdev, "Dropping invalid advertising data");
 		}
 
-		ptr += sizeof(*ev) + ev->length + 1;
+		len += sizeof(*ev) + ev_len;
 	}
 
 	hci_dev_unlock(hdev);
@@ -5583,15 +5613,29 @@ static u8 ext_evt_type_to_legacy(u16 evt_type)
 
 static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	u8 num_reports = skb->data[0];
-	void *ptr = &skb->data[1];
+	unsigned int len;
+	u8 num_reports;
+
+	if (unlikely(!pskb_may_pull(skb, 1)))
+		return;
+	num_reports = skb->data[0];
+	len = 1;
 
 	hci_dev_lock(hdev);
 
 	while (num_reports--) {
-		struct hci_ev_le_ext_adv_report *ev = ptr;
+		struct hci_ev_le_ext_adv_report *ev;
 		u8 legacy_evt_type;
 		u16 evt_type;
+		u8 ev_len;
+
+		if (unlikely(!pskb_may_pull(skb, len + sizeof(*ev))))
+			break;
+		ev = (void *)skb->data + len;
+		ev_len = ev->length + 1;
+		if (unlikely(!pskb_may_pull(skb, len + sizeof(*ev) + ev_len)))
+			break;
+		ev = (void *)skb->data + len;
 
 		evt_type = __le16_to_cpu(ev->evt_type);
 		legacy_evt_type = ext_evt_type_to_legacy(evt_type);
@@ -5601,7 +5645,7 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 					   ev->data, ev->length);
 		}
 
-		ptr += sizeof(*ev) + ev->length + 1;
+		len += sizeof(*ev) + ev_len;
 	}
 
 	hci_dev_unlock(hdev);
@@ -5610,9 +5654,13 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
-	struct hci_ev_le_remote_feat_complete *ev = (void *)skb->data;
+	struct hci_ev_le_remote_feat_complete *ev;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -5651,12 +5699,16 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev,
 
 static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_le_ltk_req *ev = (void *) skb->data;
+	struct hci_ev_le_ltk_req *ev;
 	struct hci_cp_le_ltk_reply cp;
 	struct hci_cp_le_ltk_neg_reply neg;
 	struct hci_conn *conn;
 	struct smp_ltk *ltk;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s handle 0x%4.4x", hdev->name, __le16_to_cpu(ev->handle));
 
 	hci_dev_lock(hdev);
@@ -5728,11 +5780,15 @@ static void send_conn_param_neg_reply(struct hci_dev *hdev, u16 handle,
 static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 					     struct sk_buff *skb)
 {
-	struct hci_ev_le_remote_conn_param_req *ev = (void *) skb->data;
+	struct hci_ev_le_remote_conn_param_req *ev;
 	struct hci_cp_le_conn_param_req_reply cp;
 	struct hci_conn *hcon;
 	u16 handle, min, max, latency, timeout;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	handle = le16_to_cpu(ev->handle);
 	min = le16_to_cpu(ev->interval_min);
 	max = le16_to_cpu(ev->interval_max);
@@ -5786,19 +5842,27 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev,
 static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	u8 num_reports = skb->data[0];
-	void *ptr = &skb->data[1];
+	unsigned int len;
+	u8 num_reports;
+
+	if (unlikely(!pskb_may_pull(skb, 1)))
+		return;
+	num_reports = skb->data[0];
+	len = 1;
 
 	hci_dev_lock(hdev);
 
 	while (num_reports--) {
-		struct hci_ev_le_direct_adv_info *ev = ptr;
+		struct hci_ev_le_direct_adv_info *ev;
 
+		if (unlikely(!pskb_may_pull(skb, len + sizeof(*ev))))
+			break;
+		ev = (void *)skb->data + len;
 		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
 				   ev->bdaddr_type, &ev->direct_addr,
 				   ev->direct_addr_type, ev->rssi, NULL, 0);
 
-		ptr += sizeof(*ev);
+		len += sizeof(*ev);
 	}
 
 	hci_dev_unlock(hdev);
@@ -5806,8 +5870,11 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
 
 static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_le_meta *le_ev = (void *) skb->data;
+	struct hci_ev_le_meta *le_ev;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*le_ev))))
+		return;
+	le_ev = (void *)skb->data;
 	skb_pull(skb, sizeof(*le_ev));
 
 	switch (le_ev->subevent) {
-- 
2.20.1

