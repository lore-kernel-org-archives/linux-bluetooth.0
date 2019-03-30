Return-Path: <SRS0=UugF=SB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D0CC43381
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Mar 2019 07:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505A0218A3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Mar 2019 07:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zm+PJ4Yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfC3HZ1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 30 Mar 2019 03:25:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49842 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfC3HZ1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 30 Mar 2019 03:25:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2U7Iq87156462;
        Sat, 30 Mar 2019 07:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=YZPMRLNIX7gdNLX2M3tNWQ9wwchtqhlS/45mhT5Xy+w=;
 b=Zm+PJ4Yv/hMrFDAsRCToEYf1ZrOE8B0pPfjzmDLujcAccO4waKpAVPOiIr1x95/DbxyX
 YguJgA0RdCphHZEz+V732y26ezEStHFMHVwap8mOKwUXtNaRQ/3aXHAi9H5uacWV4t4F
 ahU7LJACNMI28ZCVZZAGvf7z+6vDBFQ4GsY6M0S+p1ERPg6MHPTFRHQpH9I6k4/foC1v
 //yhYqKVUo/V9uQ7WiyAAiddbqgst2cnEh/6kgIobkWE3x3aTfDd/y0OMIauuR4CY70z
 +mIxa+2S8zSjOy/ez62LlZ0ttEkbAgbBIFH6V2pOfaV6oaY6Atbn5MoqAm6GO10MT5jQ rQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2rhyvsrfsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Mar 2019 07:25:22 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2U7PL2a017624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Mar 2019 07:25:21 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2U7PL8c009670;
        Sat, 30 Mar 2019 07:25:21 GMT
Received: from kadam (/41.202.241.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 30 Mar 2019 00:25:20 -0700
Date:   Sat, 30 Mar 2019 10:25:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Tomas Bortoli <tomasbortoli@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: potential out of bounds parsing ADV
 events
Message-ID: <20190330072511.GA5502@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9211 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903300052
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There is a potential out of bounds if "ev->length" is too high or if the
number of reports are too many.

Fixes: c215e9397b00 ("Bluetooth: Process extended ADV report event")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Not tested.  I suck at pointer math, and I don't know why the protocol
requires a "+ 1".  Please review carefully.

 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 609fd6871c5a..ee945b3d12e1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5417,6 +5417,7 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	u8 num_reports = skb->data[0];
 	void *ptr = &skb->data[1];
+	void *end = &skb->data[skb->len];
 
 	hci_dev_lock(hdev);
 
@@ -5425,6 +5426,8 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		u8 legacy_evt_type;
 		u16 evt_type;
 
+		if (ptr + sizeof(*ev) + ev->length + 1 > end)
+			break;
 		evt_type = __le16_to_cpu(ev->evt_type);
 		legacy_evt_type = ext_evt_type_to_legacy(evt_type);
 		if (legacy_evt_type != LE_ADV_INVALID) {
-- 
2.17.1
