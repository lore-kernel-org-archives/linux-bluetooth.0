Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66243C4708B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 13:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9A6613B5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 13:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbhE0NFV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 May 2021 09:05:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58392 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235177AbhE0NFU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 May 2021 09:05:20 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14RD1TOG006432;
        Thu, 27 May 2021 13:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=3UfFyy5WWq+G3MNqvbVrF1Q8T1IkdlRalVMqiwawwmY=;
 b=DUFH16g+rwsRQamxxoAb1oRDaqsbTneITHf7XCM4Ke9qX20fHu2bTkyPldC4ueyDNSJ6
 2R54gm//XRLXjJOMWqWdfEFwfVXhqFD7cBfNtxb0F7ZR5qjBldaMYTSIAnOIOj5sGh2W
 rIPNtgQGaBSJrodijwuAKmqz+PEPpzFlQEut2Ng5ToQJ+aNXIAxiHXRvYydykWGWz/ze
 LvQZjUCzRf1QF2TPS6l4QYaC+K3GhenaiwVnEcDuZeG0kwJeGUXlUYPeHyO+gud09J7z
 xQXQ4+abmzjI5Kz01mc6pH2hwo7Z4fqLYbEH7VjlJ63IcQwTnuisjHgzebJFj100FfLV 7Q== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38sr118dej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 13:03:43 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14RD3IlQ124771;
        Thu, 27 May 2021 13:03:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38pq2wd22n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 13:03:42 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14RD2v7c124171;
        Thu, 27 May 2021 13:03:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 38pq2wd22e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 13:03:41 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14RD3c0l013294;
        Thu, 27 May 2021 13:03:39 GMT
Received: from mwanda (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 May 2021 06:03:38 -0700
Date:   Thu, 27 May 2021 16:03:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Loic Poulain <loic.poulain@intel.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Loic Poulain <loic.poulain@intel.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_intel: prevent reads beyond the end of
 skb->data
Message-ID: <YK+Yo6c1UuiACSZA@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-GUID: ez703iO3L2x6lMbNG-ox9FgtHJwQhEp0
X-Proofpoint-ORIG-GUID: ez703iO3L2x6lMbNG-ox9FgtHJwQhEp0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There doesn't appear to be any checks to ensure that skb->data is large
enough in these functions.  For most of these, if we specify a header
length, then h4_recv_buf() will ensure that all packets are at least the
minimum length.  The intel_recv_lpm() function needs an additional
check for LPM_OP_TX_NOTIFY packets.

Fixes: ca93cee5a56e ("Bluetooth: hci_uart: Add basic support for Intel Lightning Peak devices")

No signed-off-by because I can't test this and just wanted to collect
feedback.  This is part of a static checker warning because someone
reported the hci_event.c read overflows to security@kernel.org.  This
stuff is quite complicated for static checkers of course and I don't
understand all the rules yet.  Right now I have about 2000 warnings
that look like this:

drivers/bluetooth/hci_intel.c:877 intel_recv_event() warn: assignment assumes 'skb->len' is '2' bytes
drivers/bluetooth/hci_intel.c:922 intel_recv_lpm() warn: assignment assumes 'skb->len' is '2' bytes
drivers/bluetooth/hci_intel.c:1028 intel_dequeue() warn: assignment assumes 'skb->len' is '3' bytes

I think there should be a different additional static checker warning
for h4_recv_pkt structs like in this patch if you fail to specify a
.hlen value?

regards,
dan carpenter
---
 drivers/bluetooth/hci_intel.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 7249b91d9b91..3e4bccacad9b 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -925,7 +925,7 @@ static int intel_recv_lpm(struct hci_dev *hdev, struct sk_buff *skb)
 
 	switch (lpm->opcode) {
 	case LPM_OP_TX_NOTIFY:
-		if (lpm->dlen < 1) {
+		if (lpm->dlen < 1 || skb->len < struct_size(lpm, data, 1)) {
 			bt_dev_err(hu->hdev, "Invalid LPM notification packet");
 			break;
 		}
@@ -959,10 +959,10 @@ static int intel_recv_lpm(struct hci_dev *hdev, struct sk_buff *skb)
 	.maxlen = HCI_LPM_MAX_SIZE
 
 static const struct h4_recv_pkt intel_recv_pkts[] = {
-	{ H4_RECV_ACL,    .recv = hci_recv_frame   },
-	{ H4_RECV_SCO,    .recv = hci_recv_frame   },
-	{ H4_RECV_EVENT,  .recv = intel_recv_event },
-	{ INTEL_RECV_LPM, .recv = intel_recv_lpm   },
+	{ H4_RECV_ACL,    .recv = hci_recv_frame, .hlen = sizeof(struct bt_skb_cb) },
+	{ H4_RECV_SCO,    .recv = hci_recv_frame, .hlen = sizeof(struct bt_skb_cb) },
+	{ H4_RECV_EVENT,  .recv = intel_recv_event, .hlen = sizeof(struct hci_event_hdr) },
+	{ INTEL_RECV_LPM, .recv = intel_recv_lpm, .hlen = sizeof(struct hci_lpm_pkt) },
 };
 
 static int intel_recv(struct hci_uart *hu, const void *data, int count)
-- 
2.30.2

