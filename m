Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32713C3F6B0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jul 2022 12:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiG0MKp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jul 2022 08:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiG0MKm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jul 2022 08:10:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612A323BCE;
        Wed, 27 Jul 2022 05:10:39 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RAA2LY010359;
        Wed, 27 Jul 2022 12:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=qwufezThziH4vemZu2PBSKmMwCVobasDhEymouxYAbk=;
 b=Wp8jbX5yEe/yVt3PZz3ftw0N0REii80WNTNR4Pss0u9zFex5M1reUA/OFbyl/Q57saeA
 5AvfsWOTq7ACUQH1UFqK8W3wKlHJV3qH3lVZfTbHzJHgCLgE76Zw9Nx91mskT56J9aRF
 i2CVDFHta5h/+NkgkzDClVVUptIXVnhPhA9DInUP14xQ5c8V8Cn+qhXYAboFPj5AxA7N
 FWMnvyn6aXtmaU/4lJAuDriLoSaL1YcurUhckuqMhHjFiTRpH4DJK4qauqB1edva3KXg
 guvAE/de1i02uEzPNqksPHRoa5Tu/WB4DLaezeHwTB42yQYSyvqmOKsidSS+qcQS01Nz TA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a9hcm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 12:10:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26RAhL5h034503;
        Wed, 27 Jul 2022 12:10:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh6346ttq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 12:10:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENwiLcDGJivFXrRyf1tVfgyPPIn22QMZDyt2vprcXxoIWjcWnz4ohFIjkYr/We6nS6TYElRQbxjYR0B+Ve1hj2XU2k1L5D8/TKP7QUX1oZSn3GeZmShSWbfIhndoyFG2KgIT6PRZkA5GWRYMUuJmtak1QKAiHK4xUdmABynKYYKAJiWOLC05QdrjYWLrkcriO+lBFKLqdAbDbS+qSztGDitXlAeoNEIX4tEAiQYLbI/DZ0ckpZKyNbp0EF4tkkfxo2h7Sor41YjwXiUDZ+86sqvQ2YkgkU4J/6rACGcLqkdbvkUIXLl/cnsFGTG/xiNyK5l4IhSA3bmniwM8KkqGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwufezThziH4vemZu2PBSKmMwCVobasDhEymouxYAbk=;
 b=NSWZXRrjl4ixWvHyZsRcN4y/dPoX4lfGuwdmolctb7xfDHiJqqW0RJZJJH2FwmzFVRJgTbd0K4eaxFuHkvv0yx7RI/KTaz11NZbzwmrJFhm01Rh/1WNSsj2uDrg/Tny8nO6TMwPyGRE283MpDYYAWyGVYhPhJLEjRel0vBU7RJsADnaRrw+QMqmVyGWt3yadU6GJFtTBfG4APnLdXUpdZPT46ecIB7S1cAK7yHdytbBmAQ5K6sgCUNl/CJDDw6pU3BJ0kvsWzHUX2+VoVAWu09VHE0B8uYcGeiiopu4wdMhmRt4dm6JqV3Lyl06kYGT6JWmEcekqAFkCxxnDGzwE2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwufezThziH4vemZu2PBSKmMwCVobasDhEymouxYAbk=;
 b=vbEqaTwnkroPbDQXhq4UmtGgTlk+0bJISEEE68mANBFK99GnSj7+CaBL0bKqZqzggFQ8Y6HlgCLK1Ae8fAR/H+ebrMbe54WKV6Ro4iW66soU2EJfHjuO50YzjZsRX8JaUzi9sQvZt2YUuQbt7Gr61/VVLOLXuBCr8pLMUmrTfRM=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by BYAPR10MB3205.namprd10.prod.outlook.com
 (2603:10b6:a03:14d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Wed, 27 Jul
 2022 12:10:33 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::eccc:6ecd:41f7:ed02]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::eccc:6ecd:41f7:ed02%5]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 12:10:33 +0000
Date:   Wed, 27 Jul 2022 15:10:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: ISO: fix info leak in iso_sock_getsockopt()
Message-ID: <YuErMEjse5lgAMO3@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuEq2Aey0VOrxPB+@kili>
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0151.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::12) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8169027-a0ff-4796-b669-08da6fc90178
X-MS-TrafficTypeDiagnostic: BYAPR10MB3205:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3ZP3Cdvesvzk3h4w6z404h1mlRs/5/IVgEsWRcQXvM/bO90b9aBXAZuUvyFnOP3LYsehBgyk567staKAacqwoj6g0TsnAk1OGhs7IZCWJodGW+ZBOkQQSX0gILDb47E3ITHjUmUPe4374u0RpvIM9wo10uyUt4AtFr8cPF+zZHLoTBmMpL7X4VZRt0QBh50LQu3OE/RuCWvA+HkXj2jPEcRr7TJ7k8S9wnOof227yHQwOPBe0nNTAu56QzRq0K2r9pYMEF4uFYCjbkS2wSqsQTje09gKoJcVLSpqGkCM4y1P8TV8QhPmkXWfjSiRDTIgFWLHibu4MgQkWEysgbRwuTdVj+Nnj2huciXh7miUuQwyrdrtRoDaIRXFJ85sOn5HQXlIZ7AC9sX6V9MRR3l6SMNkzCNRorQZRg3+g9cgTuYnrYRTjzHYbCTVovYNJtW9MVRKBLDnveXW1iGrl2JMHyZxEypKgL3zLYv6q91PS0mzNZ3GiwPZ9bxzrD1HM1m2fMs/NVKd1biE7Dq5cGuu5l9N+9yXD1ATBqKeNzC5r+2nA/SJ5EgwxTLxHpKNnKyF5QqVogDwhNp2DFtYZzo9Hqzm+HJa3jEe1oPe2vcoE48JUpdAurUk56S/FOhNLsFWbDuUhDMKQ/vcl+UT23jgfdZU5uTzQtgQKo0fRZ7+dl6n1N+KNa/Re7Yqgq6ioNrcL38pOgAEKq7OylFYJsmcigxkM3btKapLsJsMH+5lu7B/VR7KfTyZko8Nywf8dVcFC5i1ddGFiWsejwr1W3pFx7l/whLJHK/swxP/h29MczXGrB0/K37VJP7XHdpSH2N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(366004)(136003)(396003)(346002)(376002)(52116002)(6916009)(54906003)(86362001)(6486002)(478600001)(8936002)(41300700001)(26005)(6512007)(9686003)(6506007)(6666004)(186003)(38350700002)(2906002)(83380400001)(38100700002)(33716001)(66556008)(4326008)(316002)(8676002)(66476007)(66946007)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XYiVWXWOnincdodNeYMJxkS5niOZ6jv2QEeglkRGzXMbC4wg6USNKWfiX4j0?=
 =?us-ascii?Q?fijaHuDXUf02nYmqrdaqwjnUSxtRjoutiXk9s61r9jSpZ983X+uDybphh5fx?=
 =?us-ascii?Q?vdffI8HQBy/OEVSO40aSEwU9g+eV3TyVYseOvyEtRv9mr5DqJ9VEw1TeDrfC?=
 =?us-ascii?Q?iaOmx1an8YZpVNKvZsBTt4sXbVyqJZLH+QklsS7EZmkRfdhm/SpzGjOpAih2?=
 =?us-ascii?Q?M4MSBnc5iDwhtWrVMSiOthVxjAeYi4aT+OXpDNiFcszGBszBY6oYUBIL/fyx?=
 =?us-ascii?Q?cU9LHFLzwqR2WaL80y1W0IOg2583bvdaOUiStWx5224VWiSt6KEwKJz/ZEqE?=
 =?us-ascii?Q?W2/9aN6PIia2C5obAThyenQr+fPianNOXjARseZ+oh/uX+CH8CQft/gU9VUq?=
 =?us-ascii?Q?Kx09U45JcVZNDxfS+4QyTwSASMxjVM+gCXp2fYlicqAAgV1Knf6a4mfljJCm?=
 =?us-ascii?Q?ba7mkW1rb5uVxIfHhpFMkT12eF4y3b5GnDwqg2GfGdN8TjxNa0yqlPaHbLl4?=
 =?us-ascii?Q?0+LwnTuw0sl0mpK7mExcNZVswQunIgKmPFfZCSRGLQZiLRFva3DJRM0lDiKb?=
 =?us-ascii?Q?DEWpfXWMXTdOksO5r0mNoGS4XX9YucJ9Zr00Di8cbpqSfHlQdwQapi7cnUli?=
 =?us-ascii?Q?K+UL3LFlhWAYN5vD1SBxxwr1JsoCq+DOXc8XqRJfTVr6jcksF9viOjleigcD?=
 =?us-ascii?Q?aSb/aOb5GZYIWmsIMr/jumDaGjmgjeYo1Qid9+SkCFobeG/R5hVp+bU6TKrY?=
 =?us-ascii?Q?NXHS9kdAx2Al2Tzdn+MKAMDezAK9sGjyEwD8hxlXHg7s7IDGPcGPUBaliyOj?=
 =?us-ascii?Q?cRuMrDPQIk29MCL+iyABjSZAi4txyt4+vD7s2dwyNHayD6v9hjydDBJDXrkz?=
 =?us-ascii?Q?jfqvKy7LId/1o+zOqGYSfX72L0pKfpyGLoRp+JKtsVFskf1BJJL/ee3Gy/t3?=
 =?us-ascii?Q?z85Zey0i2xGDRc8bdyx0y4IISn8Mzy+w8PPzhqjBILvygqBWD40GVf5kSnzS?=
 =?us-ascii?Q?xEhcojh6B0ze+knsDF+TQOlPLHKxxibMRgbMOQXc31QjLNbccNLJZ2/x/gkU?=
 =?us-ascii?Q?MaOr7t+ij48r/iy4svL4i8Aeh1cWVqTeUoorynGxI3CeI+45QYIYHiLgMVNq?=
 =?us-ascii?Q?S1tV6UJfSwYAtnVpNnEnZ5r/qBxJ5kzHVWCvWN8S8fvo5i2qC3o3JTSQzGDn?=
 =?us-ascii?Q?9epVYI7sS3bGg8aOItAFFbwflM8P5vUfalI1Et+/qhdUMs2LOHs/BOVT0RMc?=
 =?us-ascii?Q?dkBEfPQimq8MF/n1eq94MMQKG4x0fyO3AYWaXRElU1PbSzqKYc7VPQQXWtwd?=
 =?us-ascii?Q?29pDuisBFkJW0JlsOcF0leKaV2/WRA80/Q7SE6Efwk/fS2EUpzxQtm1rhkNf?=
 =?us-ascii?Q?lxEItkHyl/lnrkTigocnF0hNiG5BmOI1M9qoj6axj5A52xZldwGV/6brz0/b?=
 =?us-ascii?Q?uJmQdcJkbxBtkFR9yT53/HzfBTVDLe6DauApH5lda0gKW7ObyONmvt0GZ7fZ?=
 =?us-ascii?Q?sCo4vx3Yi6e+A0LML0jM9dMTYT0fiMZWoNFAdFkZT9LFPSP7+2qECw20CLSm?=
 =?us-ascii?Q?x276MNv2nNGaolpK0JjuG+YmOdEemlrvxQfgxpJJkbMmsv40EoA1TaapCCS4?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8169027-a0ff-4796-b669-08da6fc90178
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 12:10:33.4987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9R0nrwVCiaTEeSWH9V/WwcwSEoCRkkoNNS6BND9MW0cOme1JukdvFQlXKCVRo09iOYnNDeAwex/BubVyWZl4tGCDwog2aT2lJXYpWOWQG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_03,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270051
X-Proofpoint-GUID: u_Nqr9-Gr2Zvc9kkZQvC_8cYKvkeMBh4
X-Proofpoint-ORIG-GUID: u_Nqr9-Gr2Zvc9kkZQvC_8cYKvkeMBh4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The "qos" struct has holes after the in and out struct members.  Zero
out those holes to prevent leaking stack information.

The C standard rules for when struct holes are zeroed out are slightly
weird.  The existing assignments might initialize everything, but GCC
is allowed to (and does sometimes) leave the struct holes uninitialized.
However, when you have a struct initializer that doesn't initialize
every member then the holes must be zeroed.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/bluetooth/iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 19d003727b50..c982087d3b52 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1235,7 +1235,7 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	int len, err = 0;
-	struct bt_iso_qos qos;
+	struct bt_iso_qos qos = {}; /* zero out struct holes */
 	u8 base_len;
 	u8 *base;
 
-- 
2.35.1

