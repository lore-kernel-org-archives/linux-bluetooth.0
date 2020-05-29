Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD16C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 10:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A1120776
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 10:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SpzQrG+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE2KAF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 06:00:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43872 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2KAF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 06:00:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04T9q1No078773;
        Fri, 29 May 2020 09:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=hIj8gRKieb8Z9m6m0Qi1A9c0VXDjl11HDRarOu6wrdc=;
 b=SpzQrG+KYu0EvNiMfpUcNde8cEfLh7SrsdBkHthQ1M3SyTJxBcWGaqk5gwjFEWzDCtoe
 EZspyPUC+NyHtSQ3s+pjJXqPURAfNKMhoUYQo1CzhUcDYVL/r2hPQGZx6wt18uUFhJdQ
 pFTtpgfw9KTA7tYD6beEIG9NGM7YjoLLzo7aH09I9i+Cr3rbjbnLgeUYRzMLoX243YcJ
 96BEMv77aCdqIhxc177RJVT0wzKdEvhbjT78FU/ofTftdVodEnGJyZ69yL/qKSGgnTMq
 QckLuoKNZ1FFmYvHznWetAU78Mh7Vfau51rxBauyGWdXRlpsE3aCAnxPSmPjl6BvzP9C /Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 318xbk9kf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 09:59:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04T9xDio033072;
        Fri, 29 May 2020 09:59:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 317j5y1hbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 May 2020 09:59:58 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04T9xtOu013809;
        Fri, 29 May 2020 09:59:55 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 May 2020 02:59:55 -0700
Date:   Fri, 29 May 2020 12:59:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Rocky Liao <rjliao@codeaurora.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_qca: Fix an error pointer dereference
Message-ID: <20200529095948.GA1304852@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=0 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005290078
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When a function like devm_clk_get_optional() function returns both error
pointers on error and NULL then the NULL return means that the optional
feature is deliberately disabled.  It is a special sort of success and
should not trigger an error message.  The surrounding code should be
written to check for NULL and not crash.

On the other hand, if we encounter an error, then the probe from should
clean up and return a failure.

In this code, if devm_clk_get_optional() returns an error pointer then
the kernel will crash inside the call to:

	clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);

The error handling must be updated to prevent that.

Fixes: 77131dfec6af ("Bluetooth: hci_qca: Replace devm_gpiod_get() with devm_gpiod_get_optional()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Commit 77131dfec6af ("Bluetooth: hci_qca: Replace devm_gpiod_get() with
devm_gpiod_get_optional()") changed how qcadev->bt_en is handled as
well.  From a very strict perspective the new code is buggy because the
warnings should only be printed for error pointers, but currently errors
are ignored and warnings are printed for NULL.

However this bug does not lead to a crash so I have left it as is.

 drivers/bluetooth/hci_qca.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e4a68238fcb93..5738ab062a733 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1926,17 +1926,17 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
-		if (!qcadev->susclk) {
+		if (IS_ERR(qcadev->susclk)) {
 			dev_warn(&serdev->dev, "failed to acquire clk\n");
-		} else {
-			err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
-			if (err)
-				return err;
-
-			err = clk_prepare_enable(qcadev->susclk);
-			if (err)
-				return err;
+			return PTR_ERR(qcadev->susclk);
 		}
+		err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
+		if (err)
+			return err;
+
+		err = clk_prepare_enable(qcadev->susclk);
+		if (err)
+			return err;
 
 		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
 		if (err) {
-- 
2.26.2

