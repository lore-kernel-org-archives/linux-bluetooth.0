Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8427C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 12:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A113610CC
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 12:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhDIMCg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Apr 2021 08:02:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44726 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDIMCg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Apr 2021 08:02:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139C08I2071449;
        Fri, 9 Apr 2021 12:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=+HNUnCXaK7Xa2rJul52WRBdu9ZSVRtHE39iDNYouSRk=;
 b=UCvdecvIgyDak2VHlL3iw/FaX3izNLG3ftb02+vjXatk7iGTfHKmv58WnC1Y5RT3wFql
 cEv8UOw1gxtLUAumLcRZAptNG/DO+NHH9D/Vw3IXmBqx/qdYNx+6jMpq2CD78c9Gp5da
 sACXSWmDonTGXqTUQlGlc7NMcEW8Yt3MvfjDamGNcsZFqJLBWJS6zxmyUrp+A0zC5wDV
 MABmA4MkObTYTlVt/RP4YMhrfKF0//2sf7Vhi++D7sDdTSS5XmS8lFHuM5lULv21lYtn
 tFDm3lxMKXuCATbwXuxASFHtWCRlzXZZ4XZO1ZwG38/SGxXblq6AyTUvy8R58Y5gPajD ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37rva695jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 12:02:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139C0Gma075051;
        Fri, 9 Apr 2021 12:02:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 37rvbhhhtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 12:02:10 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 139C27r2016715;
        Fri, 9 Apr 2021 12:02:07 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Apr 2021 05:02:06 -0700
Date:   Fri, 9 Apr 2021 15:01:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Kiran K <kiraank@gmail.com>,
        Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: prevent buffer overflow in
 btintel_read_version_tlv()
Message-ID: <YHBCNqdojHJT2usi@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090090
X-Proofpoint-GUID: GDbwTXjR56q45zNubsd2gcCL0ID_djcL
X-Proofpoint-ORIG-GUID: GDbwTXjR56q45zNubsd2gcCL0ID_djcL
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090090
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Smatch says that "tlv->len" comes from skb->data and so it's untrusted.
It can be 0-255 which is more than the size of "version->otp_bd_addr"
which is 6 bytes so the memcpy() could lead to memory corruption.

drivers/bluetooth/btintel.c:583 btintel_read_version_tlv() error: '__memcpy()' '&version->otp_bd_addr' too small (6 vs 255)

Fix this by clamping the length to sizeof(version->otp_bd_addr).

Fixes: 57375beef71a ("Bluetooth: btintel: Add infrastructure to read controller information")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/bluetooth/btintel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e44b6993cf91..654288e974b0 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -515,6 +515,7 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 	 */
 	while (skb->len) {
 		struct intel_tlv *tlv;
+		int len;
 
 		tlv = (struct intel_tlv *)skb->data;
 		switch (tlv->type) {
@@ -580,7 +581,8 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 			version->sbe_type = tlv->val[0];
 			break;
 		case INTEL_TLV_OTP_BDADDR:
-			memcpy(&version->otp_bd_addr, tlv->val, tlv->len);
+			len = min_t(int, tlv->len, sizeof(version->otp_bd_addr));
+			memcpy(&version->otp_bd_addr, tlv->val, len);
 			break;
 		default:
 			/* Ignore rest of information */
-- 
2.30.2

