Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6B1C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 07:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbiCWHuc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 03:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiCWHua (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 03:50:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873E66FF56;
        Wed, 23 Mar 2022 00:48:59 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22N7WG3g012128;
        Wed, 23 Mar 2022 07:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=oX40UgTtPrl4OyMJMkEBmNZ2CZ1YZbDQviPYihdkYuQ=;
 b=Vsv0DzaubMumIYRQdjsQZTQU0zJn/GqDns6WUNHgLPFGSaCR4cs9u3ffCHcXZ9DUeLcQ
 yLxMXLWWQpG8EyOvW5gzspDIHZ2cpCRENQkZHk+V3EXhEVLbvm3BCh1sREs9FbQhj3KO
 g9li86CmLc6nGeptWt1UWLdr2cbmpEkJN4840xewYf2ZVEgRumQJgSX1pDkF6sxsS3uu
 a6i34RqX0oYthOk4QJNBG4lQgpsq79VApmTlEwS3xj7fx3yNbUc+ASqXqvT16b/H5Iaw
 SmJCXN4KLNmEGj+vpo1ehB+KC6/hLVQtLs/OaDl867laDvcBvU9X3d5idC19N/rgRNfX 0w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5s0rrr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 07:48:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22N7mACS016196;
        Wed, 23 Mar 2022 07:48:46 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by userp3030.oracle.com with ESMTP id 3ew49r8xwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 07:48:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1zutCpxFKrYF9NZ8jgWrvPLs/kfG3bd2IL380d75Xzo+cbkBafX/FcCUYglI5lb+50U1CdBVb698ELovINEiz8kzAncYn6uf9DRHJvHd5BAvoN0hG/Bn6MkDqBM3MVs1b+XewyXZWKJuLPcFLKnTZuGZGRNZJYPGQdCw+r5Ja0Iilxnz6MthIDOGcKOCUWwkfl49NLnXgqOaJ8sOMA5aAkyJ/tBaH2kfgUOLvXSqwUIt5Hhp/KJVMQZwHD1mY/rFn1ZxqqRGOTX1f834AGez7jh0MbPnnRhWLCeen5R8X0YAeatY6UQ5XG1o2T7UUgEwhQfnEHb8kOrmDE+/HDWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oX40UgTtPrl4OyMJMkEBmNZ2CZ1YZbDQviPYihdkYuQ=;
 b=nWELJlSN1J63VGZzfd3E/xdAv8xEi26CFK2xvjDTINL44MwIxENIOm+0edi3QwrjCPSBGcmGcGDcA1RWZFb1JCBMl2Wyfzsr+oDnCM2Dbq+h4nkyVzo1VOi8rYIttc+TfcclFQQvvVHjl3z8+053MnAap3LYKpEI+J1aE50h7bV5jxc5yVp9bxnnJtm0NZbYmoKkpepVHiQrn4j8XSMQ62MBPJwCtL06j7vEwnxBC1h9FsZEaWD5Ug6N9ZxaAlTUpbtA9bdV+pvRbLDof3TqigLLVHrntpmmafngcNbKnRbJzoOH8I1IGWisK5xJ/59zTpV9t9Fpvre4dUcYICye0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oX40UgTtPrl4OyMJMkEBmNZ2CZ1YZbDQviPYihdkYuQ=;
 b=f/hnjon5zoSlNISzpzEnlhMi1OpFb2aFssxJxjHvW8gRjrvOxemUSNp/boD3XZ6tl065qKyo5PmG61vMP4QmJTbwuXQkxFg3paQJXxbiLUaqRsEBjslLLRGpxzcTrn092HDjvxJ6bVyQQ7O2h2xztQpuFzs5CvHq5mpXsTHcU/E=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB3069.namprd10.prod.outlook.com
 (2603:10b6:805:cd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 23 Mar
 2022 07:48:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 07:48:44 +0000
Date:   Wed, 23 Mar 2022 10:48:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Yake Yang <yake.yang@mediatek.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Chen <markyawenchen@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: mt7921s: fix a NULL check
Message-ID: <20220323074830.GA4639@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f92ca621-7ae6-4dfc-f681-08da0ca18dfe
X-MS-TrafficTypeDiagnostic: SN6PR10MB3069:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB3069E73C00E45A6FE2A3403F8E189@SN6PR10MB3069.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /RQ65316/R6dCeTTfO8Ln7gqWrjSNNbzQcpX1Z5ofLgp6g6JaoUGgBZfw+qSnLnQR/cV2v25RfPc+EA2ylR1dEnJ+sTS6M2jJfAPSRDKdRqygTeNhSt8qFgqI4R0YA+obkJmH1FGEwp/LaNbYcheHGi4qJ8mWvaRdglqXJ6SLeARShQ4qdzWJAhOYaHf7lzvPalM9pQ2rRYdpq+lE1JoXW7ZQQk95/4y27uRRzLbhaMht8aCXOSHewb4k7BveykL+lmAZv9eqrFClMITo05JFzC01cwLXcXv2aNUwNpWvSEyteUm32pZv6+rxFwi90txKRIHgb5razQpO9rrLlG/IysIW7fSz/jDtLgwVuwshusNS+xnOLTQG1b/ZhsCF47pHy4XOonRha/u4sEEXAM5gYG5YUzLeyqT+6ltNu04+DJ9i4b4SB+VNIRphihSUmqcB0KQEZYE8VJ8YGIZ2cEQzdyocQS/oJLlleEPwfRo4ZbI2Ls0a7VND+il6gGcCWmAv6IUV6S1GZIgbKGGhEfz+nnqPEh53zWN+eSjyPjOOv6CZKLWxCoFhZjEn9sZjsQ52C8S2UXmEY1sZpHBLLHprJRq8W+X5bC7m/+fzxBM4grhJ1XY+PSonu85HjQYmioAwGtPgr4I2jGsIYWjBw6FBxfWD3h2Hg6l1srwta+vdjGNcUbQT39ERIg8b7tm/U5nFgB3ydRjVq5ElpUQP3WILQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(6666004)(86362001)(26005)(6512007)(2906002)(33656002)(5660300002)(52116002)(1076003)(44832011)(9686003)(38350700002)(38100700002)(6506007)(4744005)(7416002)(186003)(33716001)(83380400001)(6486002)(110136005)(8676002)(54906003)(4326008)(66556008)(66476007)(316002)(66946007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iFaW9t7v8UfXaEYsu2CAi//HAmlihBKXa3VxiQN6tz07cM9h9GA+Po02e/To?=
 =?us-ascii?Q?/o+ah5ODYpnDv18YP2VktU2kcRiByiRVwi8i7cEj7I42jJduCnfj6E/vkmbd?=
 =?us-ascii?Q?Z/hEyyNMnSzvo7sAoSoMn1aIikdJZyQ1+Gr6wSipMv0n/1TTS3IDbg258kHF?=
 =?us-ascii?Q?kyudEgaREeUX2ZDSOlsjvC8CNF+ejy4wH5SDURp6DHMCp3QVfYeVAIrxIvF4?=
 =?us-ascii?Q?GbBUwEMzBWn+6YoW+R+2nZYL1O1l8hVnSxZXlJrqJqWTF0EFfR420cCkGgiO?=
 =?us-ascii?Q?WXdS0hKkNIFR2EomqP6G6zQglFpRJjFqY/mvZ23sOhTt9bZwMGqlb1FA37mK?=
 =?us-ascii?Q?qz21QWPgMpEigDuSlrUN0Fd/ExdbhvtqhswxGvKwuGN3MQhWMDI3wDxc2AUN?=
 =?us-ascii?Q?/tYdKoMbxvzX9YFKeE+XTm8Eg+4u/UudAHgopNPGbdBzWqjzizDVpvbtqdSQ?=
 =?us-ascii?Q?YHb5+SLHlg82z0w31fPQsBgH3aR4HCCJxPpA0XjnfrMIifmaUUH1jlQQusG9?=
 =?us-ascii?Q?78VyzQrA/TQri+iGzsQf/sP22x3SlYFgGA70k7HFFhGbNkzxK8adQ/7GGZom?=
 =?us-ascii?Q?dAwKlM0AJp6Z4ZKcFy7HYjiGUAxkyAOr59q+xJClFGq9LFT/aI9UIHawtuzG?=
 =?us-ascii?Q?EqSdMsj8VOUO2XfcgpiGKEHP2f3Ro+1P1A/gT56d+cGLnDAMVn4tbytq1kgs?=
 =?us-ascii?Q?3HFuwI7iJgGp7Y7kElupXHiasbUf9GI3Silk5gS4EeGqgoml57faHIsNIQde?=
 =?us-ascii?Q?mCyZSnCBOgeK4pj/wevzjAjJZjdb88kNwIe24gjrbFyxCpb8Ik2hYsyEEOUp?=
 =?us-ascii?Q?l+ksDmpj4u1XLkBv335g/so5rpYflav5loBenEuT2YnV88XvtTEkH4KeJehK?=
 =?us-ascii?Q?NQ5X292T+SmhTX3Ab7egCnQoFZXUfLasVyJjOCyQBdCV4gNow2pP0tMsB3qf?=
 =?us-ascii?Q?B3bTdqVXMUspZnH+jF2DjZgHVJiaQOiAthjSFkp42ZY6XcgWMjO6vIm/OSQU?=
 =?us-ascii?Q?jm54k8+OmKidSygUAJPc+pk6DsOr6rcRFeXFrgNP6pr9d7LsCoHTZRQ5S40i?=
 =?us-ascii?Q?2blguNygUCKKSyoq64di9T7ZRQZb7wOHAtTNVcDxNymMR9foMJQ9ZKG5nX4Q?=
 =?us-ascii?Q?Xn7M8Mv5OHkvMzB63Wm0+eILAqSdY9DpWFWQIKA5kPQFZOT4X6xvzHWh+5jF?=
 =?us-ascii?Q?BE6D2s5lAVdTBvogzRVy0Svfwl9JKD1eYU3deCLmWAyTQZhoxB29uIgJdlWm?=
 =?us-ascii?Q?NVm8zq4XzjTovSpLugOio08sWAU3CAc2S2U1unqBy/zNZ7RG8LTrHGz0wiRO?=
 =?us-ascii?Q?acywBbgfzsZ1hPiVMJLrlz+esmeFstvIkADvW+8fDhB8kq0HpKGFTRmwLSz3?=
 =?us-ascii?Q?M+0nbn0mB0RcCqFaHnSklrEh9kPM+yOdAH/K8Ml+AhhjeEv7ds2qwvOrhPoO?=
 =?us-ascii?Q?U3A6djzYnbwQb4GoEdUwRn9dWnDBpseyPKhsy1ZuTCjBSTTl/vPzFw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92ca621-7ae6-4dfc-f681-08da0ca18dfe
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 07:48:44.1192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9AXjCQgvaCAuQl8A4xer2o0Rhu1fhNiktcDLkG8IMXTQIDpn3IZUtqAhhoFP15qgtemZ9EpWBYw1MsvyN04Z5UHv1DB8ROHhxyQ/CC6L5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3069
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10294 signatures=694350
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203230044
X-Proofpoint-GUID: DzpnsihYkqdV7bKMSW1ENINv3LnSFpCE
X-Proofpoint-ORIG-GUID: DzpnsihYkqdV7bKMSW1ENINv3LnSFpCE
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There is a typo in the NULL check so it's never true.  It should be
checking "*ven_data" instead of "ven_data".

Fixes: 3cabc5ca2c9d ("Bluetooth: mt7921s: Add .btmtk_get_codec_config_data")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/bluetooth/btmtksdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index f3dc5881fff7..b6d77e04240c 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -961,7 +961,7 @@ static int btmtksdio_get_codec_config_data(struct hci_dev *hdev,
 	}
 
 	*ven_data = kmalloc(sizeof(__u8), GFP_KERNEL);
-	if (!ven_data) {
+	if (!*ven_data) {
 		err = -ENOMEM;
 		goto error;
 	}
-- 
2.20.1

