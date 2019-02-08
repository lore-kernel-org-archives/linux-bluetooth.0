Return-Path: <SRS0=tsxM=QP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F95FC282C2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Feb 2019 01:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385A12085A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Feb 2019 01:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfBHBDd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:03:33 -0500
Received: from gateway30.websitewelcome.com ([192.185.145.3]:46861 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726775AbfBHBDd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Feb 2019 20:03:33 -0500
X-Greylist: delayed 1378 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Feb 2019 20:03:33 EST
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id DC61E9F93
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Feb 2019 18:40:34 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ruDag56bs2qH7ruDage9EG; Thu, 07 Feb 2019 18:40:34 -0600
X-Authority-Reason: nr=8
Received: from [189.250.49.191] (port=46324 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gruDa-00412J-20; Thu, 07 Feb 2019 18:40:34 -0600
Date:   Thu, 7 Feb 2019 18:40:33 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] Bluetooth: hci_event: Use struct_size() helper
Message-ID: <20190208004033.GA15609@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.49.191
X-Source-L: No
X-Exim-ID: 1gruDa-00412J-20
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.49.191]:46324
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, change the following form:

sizeof(*ev) + ev->num_hndl * sizeof(struct hci_comp_pkts_info)

 to :

struct_size(ev, handles, ev->num_hndl)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/bluetooth/hci_event.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ac2826ce162b..609fd6871c5a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3556,8 +3556,8 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
-	if (skb->len < sizeof(*ev) || skb->len < sizeof(*ev) +
-	    ev->num_hndl * sizeof(struct hci_comp_pkts_info)) {
+	if (skb->len < sizeof(*ev) ||
+	    skb->len < struct_size(ev, handles, ev->num_hndl)) {
 		BT_DBG("%s bad parameters", hdev->name);
 		return;
 	}
@@ -3644,8 +3644,8 @@ static void hci_num_comp_blocks_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
-	if (skb->len < sizeof(*ev) || skb->len < sizeof(*ev) +
-	    ev->num_hndl * sizeof(struct hci_comp_blocks_info)) {
+	if (skb->len < sizeof(*ev) ||
+	    skb->len < struct_size(ev, handles, ev->num_hndl)) {
 		BT_DBG("%s bad parameters", hdev->name);
 		return;
 	}
-- 
2.20.1

