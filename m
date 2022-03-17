Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33F6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Mar 2022 07:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiCQH7U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Mar 2022 03:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiCQH7T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Mar 2022 03:59:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702B7D1CDC;
        Thu, 17 Mar 2022 00:58:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H3DwrL030863;
        Thu, 17 Mar 2022 07:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=1wwtIo7L4DG0PWLtiJTR0HgseMBOpdqqEQyAdqDJtX8=;
 b=WSRfJ1NH8qIoUtJyrEJWh+e0TcldjHboysdyTskkBEThOi8rnwMQdB43tznjX6ltEx1K
 98PYRTIoJv8QCH7WzEY7hikWe31poovPFIg4tZ4Y4nNUrF4NSi9kEtUNEc10HgyibHdq
 SE5JOorpQytwmOdi+dS3PAL7U+kH8pMVggaDhwN7SnXTJhHzbG4d5zkzAeXN0ZQRBNcu
 2Z98dWLJQIXZWYThejptGku48Uox2vlGe9YeNglgaaDAYzBARf9WdPraOwljRuVP7IIV
 DoP5p218cdyaYFEo9JdxudPlMfNXxLKwAGmw8K7f0U2/kGlM0t+sRoLGnB9pto4mwREI aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5s6rgny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:57:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22H7uhIY087524;
        Thu, 17 Mar 2022 07:57:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3020.oracle.com with ESMTP id 3et64m5f2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:57:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/nMmLIqwRMHh5jRW/I9fgbOmYVFjgx/IvmDrnW9TRle2wn38M4YCZlrSIgNw2u86nl6X+wLPegYHMYZpw796VAccU0+qyKmg8AOz6+jFd+2gHYpBQjAqzLSe+Xsu0PhykZgkBOe/ncJczY8c6q6mWHU75H/BvMGea/ymzz0uOgekjBflgoByM7L0RIUZur92/BxI11rWx4HkFfMfr11X5B5LhOeTKJuSQ6bvlXtdFgpLiqzmVwyduSiEKuwl7/TibOJ/LTwfmCshLacW02aOnqIVc3qlqeMi/usGxBaxFtzuV+W7yZ6xRxXBsOwlc69SSRm+or9kSJb5KDHfclfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wwtIo7L4DG0PWLtiJTR0HgseMBOpdqqEQyAdqDJtX8=;
 b=klLVjD3DkcHdPpF+8JuAYogufcR1gb4ilMO/bcFDT29vq6J9AZNWAaFxofS9+AmLFvAqHLxV2V7e7F+27BYRl7P6Fwwzndg6jTsVK4mrz3Ho4X1/sbENRA1OToEeTzSKH7ht+xRsdj78zZ2frRnvdhODJyOGE0R9FFHR1z2OX1xDo9nJm5rJIkzHyyGL8vRzGIsgXhbo/7RqeO7yT2uMm4bX5ntQ0iERh0sRYg7wga63Bj5hr8bYvvkRYBxTRtSyyHaPmPSeNQvjyBvvPbpSx3JCitPIL1gncq5Z7n5LimBFzFf8yHEcHSjjplud67OwSsuzgR+2GUEXhVuVXOfBDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wwtIo7L4DG0PWLtiJTR0HgseMBOpdqqEQyAdqDJtX8=;
 b=c7hrHfDlXO4wUayq9d0S1UMMISPNGmPk9Z3wmlxRwcv+YRF9FXv/+OMHQhf63VBt+5vCuTKJLyKJaGfgfOSRhiYQEvSYSJW+E/yRg3Lph5SqJsVeaFtMUDIMqGEW0JdARUv2Oyk5o/sgIbTTjSLxbhpyNfTvJVykYrBIZSotg9A=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5390.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 07:57:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 07:57:51 +0000
Date:   Thu, 17 Mar 2022 10:57:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: btmtkuart: fix error handling in
 mtk_hci_wmt_sync()
Message-ID: <20220317075740.GE25237@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0098.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6a5e1ad-8742-442c-d286-08da07ebd5cb
X-MS-TrafficTypeDiagnostic: DS7PR10MB5390:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5390ECF19DF512EA9AAE278B8E129@DS7PR10MB5390.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZoAitzrVf/ijL/31Ga+X1Z7Fc1/0GxH1Fak4xn5P3uRdOdWarHth086Ck6lvZWN0/bgy+unx28/z7Utqb86fGVQJRf5h/68ur3c9YVlT8rwd8zchvnin9eJhESyQvZyNXGfzxgO7Np7nPhxTWglTrHuEkLwjwsksehcTVPvPJXsQlf4ewhmLoyKnGazNarA/2QSYZ/V2VJBJAB/cNu5aZPDCqiYEVCbNSeKGWPwYThMWj0lixEL+k+YrahkinC6ijE+6ZYIFNDbEMfcJVRfOM3kW4ZaRpqnz+qBBA10SogdKDv2+yxq8m5yaaNeieIJ1A089NauHPRtEVQThHA3+4kp2wrbebgSvH4PpM47ojQr+Usk+59tcZnTBeBYWq8CfIM+AHwWNbPKXBuR5FNAYCEZlz2SiV4etovEN73Xzpx2SiMDTS8y1N3TVBNoRxTGawIX1Qes/77MJ4huiAATxZWA6dDRkcJW5MpL98SQ+Xh+cviLX2iCfGdIi+ieXMe0YJtWPy3TroUcMteivMQdfbf13+5uHRx4R8RpOkYv8t5ATN/Rf3ZfEjZOSkM98rkuPALdKv9fYg4kAhEejvjOA1+6NaMGA9Lz8mfRavu8LzOsECxcEt8ox4ofp3ed355ZfJHU4E5mY8RAWfax3CmEnMHOcIXxqfb86y2l4N1hCT7RgVSdgXS4c3E06yOg2PQX8m/+xeTFK2sOJd0L0CnBnTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(83380400001)(33716001)(44832011)(2906002)(316002)(54906003)(6916009)(4326008)(8676002)(66476007)(66556008)(508600001)(66946007)(9686003)(186003)(6512007)(86362001)(6486002)(6666004)(38100700002)(38350700002)(6506007)(52116002)(33656002)(1076003)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dH5gk+YJZc6KaRTocW7qXyoa6uSTWmbBwxtCsybt8JqhlrJVhZz+aXLt4I3J?=
 =?us-ascii?Q?a5ygl0NIjKtFNdbAIZTPAp54r2pjj3PhhhHZuXxqXhz5EUggqidqS+PQpIae?=
 =?us-ascii?Q?nxCXXUWkC86JV7ROqv77vLAAe/zY9tOZbhh2rOSr6yRNej7hmLYIys8TlVlJ?=
 =?us-ascii?Q?hSQYSp01Ha7COXVrS8kU9FZYGWYXxnkM/zXgTcl/SSxlrYEK7P5zD1JGOyDg?=
 =?us-ascii?Q?XaIaaV/V3Lg8h52d8QU3kultCnojQYk1kN0l8z2oV/8ngqvYUHV0PmvkEM5E?=
 =?us-ascii?Q?PeqSc3yNb2DV3Bs2IJi/NyG5sf1t7pQ2zMFN4BPO+htrZzkAK+jymadh6ICj?=
 =?us-ascii?Q?49BDI+aE7+BgdTDsmWuqoU5+UEO4run2GjBarefBsXJG+Nsm45zarMHkAUT9?=
 =?us-ascii?Q?hMM1rG6RH3MosFRKtXcZIcbeuv5xYWPeWucduW56kGb2YU23rpElPUuHWUJu?=
 =?us-ascii?Q?h7YICoX7vxW26FdqzBSGTAGM77jwTZRhJ4BkW+xjZakUuNw9XySd6MQAQTf/?=
 =?us-ascii?Q?YJU+RhQIwzjrrB+OACiWBWhvEoNWLQ2EYINldrB52M13GXGwVmVcb4P0p5Bc?=
 =?us-ascii?Q?ZlXbuhn9V9LJ3fEu37UHsoQLMtPlgn2PD0849wn7CCCWkkMcEgTrkYUe4lfl?=
 =?us-ascii?Q?4Sn59wG8ODiRt34yf2Hdlw1kbQIFm3/ojasSWVvHsryJYWPA1E9QIQ8Iusus?=
 =?us-ascii?Q?1mQCFZs+ELuEoGHaYlr3SRK1F7/42cTTjfhwo/N0Et3J/q8NFuB4OOLjrvGP?=
 =?us-ascii?Q?r+xzk9d5NwvlwxOq87NhtMO7+JJnMSTlFmOOMpHejlJp3KGEDb8hyHr+Ctcu?=
 =?us-ascii?Q?iLFXQIHBLMjpL7y5UdSGgxm//9BoTI6U22yl1QCbXvtl613zOETmBFqn7QRn?=
 =?us-ascii?Q?DbIg2n63q0ZiSyYFuOEdTT028/L6j4Kjtgu2ZEkTdf8HD5KeXjHvR5VKs6+g?=
 =?us-ascii?Q?OzZOz41QpZja0MOvsn/eSWD8Nxv9EHrtGD+a6OLSXMF73deimPCjnaRJu1DQ?=
 =?us-ascii?Q?HDq2ajltAQYOBt+bnZLUtZmt37W8VbZWaG/L1mtp6HjDL30gLSlIDugzZJAt?=
 =?us-ascii?Q?L806p7db2yUOCPJABd0YyhIOzqsdSqVnHj/bdh4Of0mHf0MiiKsPYyOWxZrg?=
 =?us-ascii?Q?W3DVNuVkDCTFm5zJi37T3z8xQ7G+cvVqoIeX1wIwO/HMrMs1gNz89xJPwSJ5?=
 =?us-ascii?Q?P/4bePG4F9CxkKb67ixeBbXiSmw3jBdDHm9x/Vi63LHCVCbK+VR6QjS3kRyH?=
 =?us-ascii?Q?8Fj9hLJJZlCluoJ6RaV8/JkTc8PsKo0N1OmjyT+xdtO/9kElJoWWg7Rabnle?=
 =?us-ascii?Q?K2079xCLX0QRKYTd03z2wft0bjZGn+tPAFQPYqgdNj/owLrl3PRpq2mS1Pqh?=
 =?us-ascii?Q?o2+cMwYrZDyyjrbMVBh0xz/S4GrX/kLaSwbWaipXQkdRPKA9uZ6hFpI3et4a?=
 =?us-ascii?Q?5lRv3FaSe5levq9LjezbqKFKffXfqTidtjmEzc2aoukLsAhu/qw/4Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a5e1ad-8742-442c-d286-08da07ebd5cb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 07:57:51.3053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Djw8bGDmMwnmWWH7Nv00g2ciLhhfaZgdXhXI+X3bqsSySyJ1SJkbiznDoDsyrXB4gjYjxTGF/MvKHmatlcTIh57KuHjGDhDQcAgs78jvLso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5390
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170046
X-Proofpoint-GUID: cm8RZROjrhZRLfLAS3R4E4rYWPSVjjZu
X-Proofpoint-ORIG-GUID: cm8RZROjrhZRLfLAS3R4E4rYWPSVjjZu
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This code has an uninitialized variable warning:

    drivers/bluetooth/btmtkuart.c:184 mtk_hci_wmt_sync()
    error: uninitialized symbol 'wc'.

But it also has error paths which have memory leaks.

Fixes: 8f550f55b155 ("Bluetooth: btmtkuart: rely on BT_MTK module")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/bluetooth/btmtkuart.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 695e1225b08c..c98691cdbbd5 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -105,8 +105,10 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 	}
 
 	wc = kzalloc(hlen, GFP_KERNEL);
-	if (!wc)
-		return -ENOMEM;
+	if (!wc) {
+		err = -ENOMEM;
+		goto err_free_skb;
+	}
 
 	hdr = &wc->hdr;
 	hdr->dir = 1;
@@ -153,7 +155,7 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 		bt_dev_err(hdev, "Wrong op received %d expected %d",
 			   wmt_evt->whdr.op, hdr->op);
 		err = -EIO;
-		goto err_free_skb;
+		goto err_free_wc;
 	}
 
 	switch (wmt_evt->whdr.op) {
@@ -177,11 +179,11 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 	if (wmt_params->status)
 		*wmt_params->status = status;
 
+err_free_wc:
+	kfree(wc);
 err_free_skb:
 	kfree_skb(bdev->evt_skb);
 	bdev->evt_skb = NULL;
-err_free_wc:
-	kfree(wc);
 
 	return err;
 }
-- 
2.20.1

