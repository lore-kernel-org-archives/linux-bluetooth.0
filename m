Return-Path: <SRS0=5fC3=SF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36362C10F0B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 23:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27F72075E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 23:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uq/0vPSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfDCXIs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Apr 2019 19:08:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38172 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDCXIr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Apr 2019 19:08:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id g37so151869plb.5;
        Wed, 03 Apr 2019 16:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nxw+V9xjEoCYrY91TevWwUNtsWYwVMbAsuFAN9a7dqY=;
        b=Uq/0vPSb/wrJtmnr1Rb4LLyzFWnmFe07rKz3826d9LV/5RXbzLWFnizeyVscd9ktEp
         RMJX8XU1a9nCexmUgP1ZixCEUZe8xEvknZA1nb/A/XwCuxSRAGuOVfeohOjdoWs5rezV
         ty/ALHdArXLhlSO4QZXKDiM88J4LcLVT3K/qpEe3Wx0UsdBLYc8tri88yJT+c3RJBIw9
         t2N086TXg18nIFJPk9udJv/GajSaidpO/VP/zkVMe2+PkScgCtOwnedylQRC8pVTiJ6N
         NUY3nYHMbpH3N9kH7F7wy/e6Bb4gI3R7dvAbqKDHVILrkhkgsWl8IG9e3i1HJx7NKXOk
         mqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxw+V9xjEoCYrY91TevWwUNtsWYwVMbAsuFAN9a7dqY=;
        b=NvpcikaOVnxUBfpclR9FFuZwo6Z0E57H4SdUjqLrt/722Q2u2M9/306OMpY1XBDAcu
         lZbl9aRrLBUcxbyIMg3aoqoqGrTaW7q1vIaA1NElLHpzyHglfu7gvhB1obeWEdvLbMrw
         tASJXslyV9jhYt0CHvZAPWKtvy5KBA/xn1dqi9KVq3pk1jXTM5cuomXlTW1GNUrRt2IN
         K+wQTnBRjK4hPJr0oRPK2ga61wvg2E5PmmJoMPIoSoUPMuPT4N8aPbnGH2poH0L76GUx
         32v5Uy6O10Z5N5G0fWZeu7GTjQ10QRCW23t6xQoZeYtp2jvBvFb2on7TWDRLZhNBL85Z
         i+ZA==
X-Gm-Message-State: APjAAAVP5deHfV6y5wEwWSJwW99M9qX8vLoBWFBQZcdhnI9LXnN0Qs+b
        5GwR+AJTQoPawyCkm6IxVbXIH96d
X-Google-Smtp-Source: APXvYqzZN6xVY0L1vCxg/ipLyCexc5HvLvN8p8bB5XtY7ttaykOE6E8GJ3Hlp9xfq7FYi39E29t/Ig==
X-Received: by 2002:a17:902:2a29:: with SMTP id i38mr2833736plb.22.1554332926078;
        Wed, 03 Apr 2019 16:08:46 -0700 (PDT)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id a7sm23439574pfc.45.2019.04.03.16.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 16:08:44 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     netdev@vger.kernel.org
Cc:     linux-bluetooth@vger.kernel.org,
        Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot+cec7a50c412a2c03f8f5@syzkaller.appspotmail.com,
        syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [Patch net v2 1/3] bluetooth: validate HCI_EVENT_PKT packet carefully
Date:   Wed,  3 Apr 2019 16:08:33 -0700
Message-Id: <20190403230835.1174-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403230835.1174-1-xiyou.wangcong@gmail.com>
References: <20190403230835.1174-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hci_event_packet() blindly assumes all packets are sane, at least
for packets allocated via vhci_get_user() path this is not true.
We have to check if we access skb data out-of-bound with
pskb_may_pull() before each skb->data dereference on RX path.

Reported-and-tested-by: syzbot+cec7a50c412a2c03f8f5@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Tomas Bortoli <tomasbortoli@gmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/bluetooth/hci_event.c | 262 +++++++++++++++++++++++++++++++-------
 1 file changed, 218 insertions(+), 44 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 609fd6871c5a..2fef70c0bffe 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2331,10 +2331,13 @@ static void hci_cs_switch_role(struct hci_dev *hdev, u8 status)
 
 static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	__u8 status = *((__u8 *) skb->data);
 	struct discovery_state *discov = &hdev->discovery;
 	struct inquiry_entry *e;
+	__u8 status;
 
+	if (unlikely(!pskb_may_pull(skb, 1)))
+		return;
+	status = *((__u8 *)skb->data);
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
 	hci_conn_check_pending(hdev);
@@ -2391,14 +2394,21 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct inquiry_data data;
-	struct inquiry_info *info = (void *) (skb->data + 1);
-	int num_rsp = *((__u8 *) skb->data);
+	struct inquiry_info *info;
+	int num_rsp;
 
 	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
 
+	if (unlikely(!pskb_may_pull(skb, 1)))
+		return;
+	num_rsp = *((__u8 *)skb->data);
 	if (!num_rsp)
 		return;
 
+	if (unlikely(!pskb_may_pull(skb, 1 + num_rsp * sizeof(*info))))
+		return;
+	info = (void *)(skb->data + 1);
+
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
 		return;
 
@@ -2428,11 +2438,15 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_conn_complete *ev = (void *) skb->data;
+	struct hci_ev_conn_complete *ev;
 	struct hci_conn *conn;
 
 	BT_DBG("%s", hdev->name);
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
@@ -2522,12 +2536,16 @@ static void hci_reject_conn(struct hci_dev *hdev, bdaddr_t *bdaddr)
 
 static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_conn_request *ev = (void *) skb->data;
+	struct hci_ev_conn_request *ev;
 	int mask = hdev->link_mode;
 	struct inquiry_entry *ie;
 	struct hci_conn *conn;
 	__u8 flags = 0;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s bdaddr %pMR type 0x%x", hdev->name, &ev->bdaddr,
 	       ev->link_type);
 
@@ -2633,13 +2651,17 @@ static u8 hci_to_mgmt_reason(u8 err)
 
 static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_disconn_complete *ev = (void *) skb->data;
+	struct hci_ev_disconn_complete *ev;
 	u8 reason;
 	struct hci_conn_params *params;
 	struct hci_conn *conn;
 	bool mgmt_connected;
 	u8 type;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -2717,9 +2739,13 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_auth_complete *ev = (void *) skb->data;
+	struct hci_ev_auth_complete *ev;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -2787,11 +2813,15 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_remote_name *ev = (void *) skb->data;
+	struct hci_ev_remote_name *ev;
 	struct hci_conn *conn;
 
 	BT_DBG("%s", hdev->name);
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	hci_conn_check_pending(hdev);
 
 	hci_dev_lock(hdev);
@@ -2885,9 +2915,13 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
 
 static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_encrypt_change *ev = (void *) skb->data;
+	struct hci_ev_encrypt_change *ev;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -2992,9 +3026,13 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_change_link_key_complete_evt(struct hci_dev *hdev,
 					     struct sk_buff *skb)
 {
-	struct hci_ev_change_link_key_complete *ev = (void *) skb->data;
+	struct hci_ev_change_link_key_complete *ev;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3015,9 +3053,13 @@ static void hci_change_link_key_complete_evt(struct hci_dev *hdev,
 static void hci_remote_features_evt(struct hci_dev *hdev,
 				    struct sk_buff *skb)
 {
-	struct hci_ev_remote_features *ev = (void *) skb->data;
+	struct hci_ev_remote_features *ev;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3413,7 +3455,11 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 			       hci_req_complete_t *req_complete,
 			       hci_req_complete_skb_t *req_complete_skb)
 {
-	struct hci_ev_cmd_status *ev = (void *) skb->data;
+	struct hci_ev_cmd_status *ev;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
 
 	skb_pull(skb, sizeof(*ev));
 
@@ -3517,7 +3563,11 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 
 static void hci_hardware_error_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_hardware_error *ev = (void *) skb->data;
+	struct hci_ev_hardware_error *ev;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
 
 	hdev->hw_error_code = ev->code;
 
@@ -3526,9 +3576,13 @@ static void hci_hardware_error_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_role_change *ev = (void *) skb->data;
+	struct hci_ev_role_change *ev;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3687,9 +3741,13 @@ static void hci_num_comp_blocks_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_mode_change *ev = (void *) skb->data;
+	struct hci_ev_mode_change *ev;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3715,11 +3773,15 @@ static void hci_mode_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_pin_code_req *ev = (void *) skb->data;
+	struct hci_ev_pin_code_req *ev;
 	struct hci_conn *conn;
 
 	BT_DBG("%s", hdev->name);
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
@@ -3785,13 +3847,17 @@ static void conn_set_key(struct hci_conn *conn, u8 key_type, u8 pin_len)
 
 static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_link_key_req *ev = (void *) skb->data;
+	struct hci_ev_link_key_req *ev;
 	struct hci_cp_link_key_reply cp;
 	struct hci_conn *conn;
 	struct link_key *key;
 
 	BT_DBG("%s", hdev->name);
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	if (!hci_dev_test_flag(hdev, HCI_MGMT))
 		return;
 
@@ -3845,7 +3911,7 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_link_key_notify *ev = (void *) skb->data;
+	struct hci_ev_link_key_notify *ev;
 	struct hci_conn *conn;
 	struct link_key *key;
 	bool persistent;
@@ -3853,6 +3919,10 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
@@ -3905,9 +3975,13 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_clock_offset_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_clock_offset *ev = (void *) skb->data;
+	struct hci_ev_clock_offset *ev;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3928,9 +4002,13 @@ static void hci_clock_offset_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_pkt_type_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_pkt_type_change *ev = (void *) skb->data;
+	struct hci_ev_pkt_type_change *ev;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -3944,11 +4022,15 @@ static void hci_pkt_type_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_pscan_rep_mode_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_pscan_rep_mode *ev = (void *) skb->data;
+	struct hci_ev_pscan_rep_mode *ev;
 	struct inquiry_entry *ie;
 
 	BT_DBG("%s", hdev->name);
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	hci_dev_lock(hdev);
 
 	ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
@@ -3964,8 +4046,12 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 					     struct sk_buff *skb)
 {
 	struct inquiry_data data;
-	int num_rsp = *((__u8 *) skb->data);
+	int num_rsp;
+
+	if (unlikely(!pskb_may_pull(skb, 1)))
+		return;
 
+	num_rsp = *((__u8 *)skb->data);
 	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
 
 	if (!num_rsp)
@@ -3978,6 +4064,9 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 
 	if ((skb->len - 1) / num_rsp != sizeof(struct inquiry_info_with_rssi)) {
 		struct inquiry_info_with_rssi_and_pscan_mode *info;
+
+		if (unlikely(!pskb_may_pull(skb, 1 + num_rsp * sizeof(*info))))
+			goto unlock;
 		info = (void *) (skb->data + 1);
 
 		for (; num_rsp; num_rsp--, info++) {
@@ -3999,7 +4088,11 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 					  flags, NULL, 0, NULL, 0);
 		}
 	} else {
-		struct inquiry_info_with_rssi *info = (void *) (skb->data + 1);
+		struct inquiry_info_with_rssi *info;
+
+		if (unlikely(!pskb_may_pull(skb, 1 + num_rsp * sizeof(*info))))
+			goto unlock;
+		info = (void *)(skb->data + 1);
 
 		for (; num_rsp; num_rsp--, info++) {
 			u32 flags;
@@ -4021,17 +4114,22 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 		}
 	}
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
 static void hci_remote_ext_features_evt(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_ev_remote_ext_features *ev = (void *) skb->data;
+	struct hci_ev_remote_ext_features *ev;
 	struct hci_conn *conn;
 
 	BT_DBG("%s", hdev->name);
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
@@ -4091,9 +4189,13 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev,
 static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
-	struct hci_ev_sync_conn_complete *ev = (void *) skb->data;
+	struct hci_ev_sync_conn_complete *ev;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	hci_dev_lock(hdev);
@@ -4176,14 +4278,21 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
 	struct inquiry_data data;
-	struct extended_inquiry_info *info = (void *) (skb->data + 1);
-	int num_rsp = *((__u8 *) skb->data);
+	struct extended_inquiry_info *info;
+	int num_rsp;
 	size_t eir_len;
 
+	if (unlikely(!pskb_may_pull(skb, 1)))
+		return;
+	num_rsp = *((__u8 *)skb->data);
+
 	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
 
 	if (!num_rsp)
 		return;
+	if (unlikely(!pskb_may_pull(skb, 1 + num_rsp * sizeof(*info))))
+		return;
+	info = (void *)(skb->data + 1);
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
 		return;
@@ -4225,9 +4334,13 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 static void hci_key_refresh_complete_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_key_refresh_complete *ev = (void *) skb->data;
+	struct hci_ev_key_refresh_complete *ev;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x handle 0x%4.4x", hdev->name, ev->status,
 	       __le16_to_cpu(ev->handle));
 
@@ -4334,11 +4447,15 @@ static u8 bredr_oob_data_present(struct hci_conn *conn)
 
 static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_io_capa_request *ev = (void *) skb->data;
+	struct hci_ev_io_capa_request *ev;
 	struct hci_conn *conn;
 
 	BT_DBG("%s", hdev->name);
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
@@ -4403,11 +4520,15 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_io_capa_reply_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_io_capa_reply *ev = (void *) skb->data;
+	struct hci_ev_io_capa_reply *ev;
 	struct hci_conn *conn;
 
 	BT_DBG("%s", hdev->name);
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
@@ -4424,12 +4545,16 @@ static void hci_io_capa_reply_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_user_confirm_req *ev = (void *) skb->data;
+	struct hci_ev_user_confirm_req *ev;
 	int loc_mitm, rem_mitm, confirm_hint = 0;
 	struct hci_conn *conn;
 
 	BT_DBG("%s", hdev->name);
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	hci_dev_lock(hdev);
 
 	if (!hci_dev_test_flag(hdev, HCI_MGMT))
@@ -4499,10 +4624,13 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 static void hci_user_passkey_request_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_user_passkey_req *ev = (void *) skb->data;
+	struct hci_ev_user_passkey_req *ev;
 
 	BT_DBG("%s", hdev->name);
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_user_passkey_request(hdev, &ev->bdaddr, ACL_LINK, 0);
 }
@@ -4510,11 +4638,15 @@ static void hci_user_passkey_request_evt(struct hci_dev *hdev,
 static void hci_user_passkey_notify_evt(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_ev_user_passkey_notify *ev = (void *) skb->data;
+	struct hci_ev_user_passkey_notify *ev;
 	struct hci_conn *conn;
 
 	BT_DBG("%s", hdev->name);
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (!conn)
 		return;
@@ -4530,11 +4662,15 @@ static void hci_user_passkey_notify_evt(struct hci_dev *hdev,
 
 static void hci_keypress_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_keypress_notify *ev = (void *) skb->data;
+	struct hci_ev_keypress_notify *ev;
 	struct hci_conn *conn;
 
 	BT_DBG("%s", hdev->name);
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (!conn)
 		return;
@@ -4569,11 +4705,15 @@ static void hci_keypress_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_simple_pair_complete *ev = (void *) skb->data;
+	struct hci_ev_simple_pair_complete *ev;
 	struct hci_conn *conn;
 
 	BT_DBG("%s", hdev->name);
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
@@ -4600,12 +4740,16 @@ static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 static void hci_remote_host_features_evt(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_ev_remote_host_features *ev = (void *) skb->data;
+	struct hci_ev_remote_host_features *ev;
 	struct inquiry_entry *ie;
 	struct hci_conn *conn;
 
 	BT_DBG("%s", hdev->name);
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
@@ -4622,11 +4766,15 @@ static void hci_remote_host_features_evt(struct hci_dev *hdev,
 static void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
-	struct hci_ev_remote_oob_data_request *ev = (void *) skb->data;
+	struct hci_ev_remote_oob_data_request *ev;
 	struct oob_data *data;
 
 	BT_DBG("%s", hdev->name);
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	hci_dev_lock(hdev);
 
 	if (!hci_dev_test_flag(hdev, HCI_MGMT))
@@ -4676,9 +4824,13 @@ static void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 #if IS_ENABLED(CONFIG_BT_HS)
 static void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_channel_selected *ev = (void *)skb->data;
+	struct hci_ev_channel_selected *ev;
 	struct hci_conn *hcon;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s handle 0x%2.2x", hdev->name, ev->phy_handle);
 
 	skb_pull(skb, sizeof(*ev));
@@ -4693,9 +4845,13 @@ static void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 				      struct sk_buff *skb)
 {
-	struct hci_ev_phy_link_complete *ev = (void *) skb->data;
+	struct hci_ev_phy_link_complete *ev;
 	struct hci_conn *hcon, *bredr_hcon;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s handle 0x%2.2x status 0x%2.2x", hdev->name, ev->phy_handle,
 	       ev->status);
 
@@ -4732,11 +4888,15 @@ static void hci_phy_link_complete_evt(struct hci_dev *hdev,
 
 static void hci_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_ev_logical_link_complete *ev = (void *) skb->data;
+	struct hci_ev_logical_link_complete *ev;
 	struct hci_conn *hcon;
 	struct hci_chan *hchan;
 	struct amp_mgr *mgr;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s log_handle 0x%4.4x phy_handle 0x%2.2x status 0x%2.2x",
 	       hdev->name, le16_to_cpu(ev->handle), ev->phy_handle,
 	       ev->status);
@@ -4771,9 +4931,13 @@ static void hci_loglink_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_disconn_loglink_complete_evt(struct hci_dev *hdev,
 					     struct sk_buff *skb)
 {
-	struct hci_ev_disconn_logical_link_complete *ev = (void *) skb->data;
+	struct hci_ev_disconn_logical_link_complete *ev;
 	struct hci_chan *hchan;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s log handle 0x%4.4x status 0x%2.2x", hdev->name,
 	       le16_to_cpu(ev->handle), ev->status);
 
@@ -4795,9 +4959,13 @@ static void hci_disconn_loglink_complete_evt(struct hci_dev *hdev,
 static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev,
 					     struct sk_buff *skb)
 {
-	struct hci_ev_disconn_phy_link_complete *ev = (void *) skb->data;
+	struct hci_ev_disconn_phy_link_complete *ev;
 	struct hci_conn *hcon;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev))))
+		return;
+	ev = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	if (ev->status)
@@ -5742,13 +5910,18 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_event_hdr *hdr = (void *) skb->data;
+	struct hci_event_hdr *hdr;
 	hci_req_complete_t req_complete = NULL;
 	hci_req_complete_skb_t req_complete_skb = NULL;
 	struct sk_buff *orig_skb = NULL;
-	u8 status = 0, event = hdr->evt, req_evt = 0;
+	u8 status = 0, event, req_evt = 0;
 	u16 opcode = HCI_OP_NOP;
 
+	if (unlikely(!pskb_may_pull(skb,  HCI_EVENT_HDR_SIZE)))
+		goto free;
+	hdr = (void *)skb->data;
+	event = hdr->evt;
+
 	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->hci.req_event == event) {
 		struct hci_command_hdr *cmd_hdr = (void *) hdev->sent_cmd->data;
 		opcode = __le16_to_cpu(cmd_hdr->opcode);
@@ -5960,6 +6133,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		req_complete_skb(hdev, status, opcode, orig_skb);
 	}
 
+free:
 	kfree_skb(orig_skb);
 	kfree_skb(skb);
 	hdev->stat.evt_rx++;
-- 
2.20.1

