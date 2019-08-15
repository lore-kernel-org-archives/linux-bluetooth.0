Return-Path: <SRS0=vV7E=WL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12167C433FF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Aug 2019 08:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2582084D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Aug 2019 08:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oWbZK6Rc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbfHOIef (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:34:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43894 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730744AbfHOIee (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Aug 2019 04:34:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F8XgqB000805;
        Thu, 15 Aug 2019 08:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=5vyC/ysLqV5tBBkd50oByxtAPImkiIhWEYeKyZyLtF4=;
 b=oWbZK6Rc4dFg19NiDVQvFgPpgH6jz/fdWndAG7kTpQDzFWU39GdmHvD6wtjs1TMk3wl+
 cwj0isxL9Wuz7UMaDlDeJ9aPzDcTTdklWVvsvbxSqe8Tp1r6gedXIErG3zoq8shHfhKG
 fhbQJz0JdhXpNVV1Ti/p7d2JNkxekJ1Ciab+QfsR5AqiAPTJ/q3kIMBPH9aCNuFSboze
 6uAAFAz3Z22G+YtFD6Qbl12rSuqcZw59TVyDipRVy3FwtISOS1REPjYzzBc+SLrUB5MW
 sim3rVypcevR0XxNyYc7pyVSHVvFdwvzgePBOCZiPrY8Wm2hcl41+NavfVnqSDZylstN NA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u9pjqsghh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 08:34:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F8XPwB032035;
        Thu, 15 Aug 2019 08:34:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ucmwjf1gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 08:34:26 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7F8YNai030721;
        Thu, 15 Aug 2019 08:34:24 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Aug 2019 01:34:23 -0700
Date:   Thu, 15 Aug 2019 11:34:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_qca: Use kfree_skb() instead of kfree()
Message-ID: <20190815083416.GF27238@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150091
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

sk_buff structs need to be freed with kfree_skb().

Fixes: 2faa3f15fa2f ("Bluetooth: hci_qca: wcn3990: Drop baudrate change vendor event")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index a054210ae866..7720e1748262 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -893,7 +893,7 @@ static int qca_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 		if (hdr->evt == HCI_EV_VENDOR)
 			complete(&qca->drop_ev_comp);
 
-		kfree(skb);
+		kfree_skb(skb);
 
 		return 0;
 	}
-- 
2.20.1

