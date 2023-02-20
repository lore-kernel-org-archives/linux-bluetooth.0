Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF91C6379F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Feb 2023 19:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjBTTjq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Feb 2023 14:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjBTTjQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Feb 2023 14:39:16 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010AD2279A
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Feb 2023 11:38:36 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 27CA524027F
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Feb 2023 20:38:35 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PLCQL41Cgz6tmJ;
        Mon, 20 Feb 2023 20:38:34 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: ISO: fix timestamped HCI ISO data packet parsing
Date:   Mon, 20 Feb 2023 19:38:24 +0000
Message-Id: <1fd2d4523c139deda93aab2c31f1508d79c32472.1676921889.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use correct HCI ISO data packet header struct when the packet has
timestamp. The timestamp, when present, goes before the other fields
(Core v5.3 4E 5.4.5), so the structs are not compatible.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    My hardware doesn't seem to produce timestamped packets, so this is not
    properly tested, except to the extent that it doesn't break the
    non-timestamped code path.
    
    Regardless, the current state of things looks wrong, so sending this to
    the list in any case.

 net/bluetooth/iso.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 2dabef488eaa..cb959e8eac18 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1621,7 +1621,6 @@ static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 {
 	struct iso_conn *conn = hcon->iso_data;
-	struct hci_iso_data_hdr *hdr;
 	__u16 pb, ts, len;
 
 	if (!conn)
@@ -1643,6 +1642,8 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		}
 
 		if (ts) {
+			struct hci_iso_ts_data_hdr *hdr;
+
 			/* TODO: add timestamp to the packet? */
 			hdr = skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SIZE);
 			if (!hdr) {
@@ -1650,15 +1651,19 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 				goto drop;
 			}
 
+			len = __le16_to_cpu(hdr->slen);
 		} else {
+			struct hci_iso_data_hdr *hdr;
+
 			hdr = skb_pull_data(skb, HCI_ISO_DATA_HDR_SIZE);
 			if (!hdr) {
 				BT_ERR("Frame is too short (len %d)", skb->len);
 				goto drop;
 			}
+
+			len = __le16_to_cpu(hdr->slen);
 		}
 
-		len    = __le16_to_cpu(hdr->slen);
 		flags  = hci_iso_data_flags(len);
 		len    = hci_iso_data_len(len);
 
-- 
2.39.2

