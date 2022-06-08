Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EF1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jun 2022 13:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbiFHNqo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jun 2022 09:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbiFHNqn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jun 2022 09:46:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BF5276CE2;
        Wed,  8 Jun 2022 06:46:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 258DPpBN017788;
        Wed, 8 Jun 2022 13:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=AjWqwCk6+ebwqK1x0Wj5jtmgfQ77Wg0sKR4aR95uOfE=;
 b=gpGQpaLNzxaJ/Qem2LBGQGOcPEB207OQ3gPOjGfi/8YGAOAzFnH+b6vUpPn/OADlAuY5
 8T07sz8FGldD45CmFRw//wzjtRqSAtZr0Cr7qtjYO4kOJyKqBseLbKLwcfd23kzdSBA3
 em8DScDMMOvxB5/YS+AZqQvSG8gIuEokcN+pKtzDY71ldXlvtYhUzFzqD9G2mtQTmm6I
 dhYon7nqU91B9H0E1D5srogA3B/w9knxi1G45bAZ+7H4YiSSYCpWU+AW0mEOq4M8v/W9
 Yg3gebWcUJrC5elq0ySkBiUbOyRh4fPQStlDeyA7xItX4siAEDuqp7CkL9n81I464Rh7 6Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghvs3bwyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jun 2022 13:46:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 258DeZg3033186;
        Wed, 8 Jun 2022 13:46:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu3jhj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jun 2022 13:46:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCmpjIVt2u47w5VoQdMKRnoZgMDqQUVwTN5xs8gnAbzJJ3TX6nd/QsU4c+R8qTuG4UBY4BYvGCy4WlTwvVdUTEQkTk19iFUrI+uOI/ZJdjO7tn+Rq379YlBXkW2uuGBx3v/Suc3o/BfWyrRzQo6Lzqt1LxW635PTCdJDuwif6NWxbdndSb+VkLVVG2JWEuV7rqJtru36OIUjWXeAyC7FkhHxHlolhzsYHJZs7x1Za6mamJb5iw2e56wukVfvAm3X4FpSrbfeNSKLadbAjoHZ6U9DOe2x2HgWXHhGydHDkvdA1vtCQzbkkoqtAAZMVN61mbE64x/Bh8xE5sr1t8ZLYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjWqwCk6+ebwqK1x0Wj5jtmgfQ77Wg0sKR4aR95uOfE=;
 b=c2qO02vL4lj8X7tkzwz/TgLuTM3dlJLbNaWyeU/1TzyRtzS16321LxoRW2mfCIKYUWZunnzym52lVHiWe9JJMLiJId4+GqYYPJFBd/rel+7rEXZb735b0+J+b3cEh+J56PgWbT1VCEV80ceKs8J07pFG5Z53BiQwLfGjTi0z18m4itfEDrzoxIVpca4MNaFWheXuuAZHNaVSBCXrN/30RDBeqfGNXZSEbCNSS+KiK/3LP1JAOdflOISW+3Z9TWwye2EorKZHrKmTXWwFxda6h+tXC51IF91MEJ9+6JYMkCelow0k66pqTnQqPjABOPKIX8/VPRhmHomtX7bRWd5rSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjWqwCk6+ebwqK1x0Wj5jtmgfQ77Wg0sKR4aR95uOfE=;
 b=FsIIQXH/QgmG1Gsbv7oLAkodYUnyUNzxctfl/FDkp7udIm/digLVuEPmrvupKdQH/9Bd3v01o0+BRqTb+RGW/jYWJNf3HWWqimfBVywVqTiUG9w7gI6xEcIliBLCUUekKWYBjwqkM0HTo7VL6szUnpJfe+KmvqWhlZ+MjQqebgw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1426.namprd10.prod.outlook.com
 (2603:10b6:404:45::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 8 Jun
 2022 13:46:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 13:46:26 +0000
Date:   Wed, 8 Jun 2022 16:46:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: fix an error code in hci_register_dev()
Message-ID: <YqCoJXuRV8MIDS2M@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::25) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24a43592-a444-4ce3-a1bc-08da495548a7
X-MS-TrafficTypeDiagnostic: BN6PR10MB1426:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1426D397EDC103DC4D9410048EA49@BN6PR10MB1426.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VEIiYhxLlYly0svl8+0y+fhU79kxBDnyY2oKfKvv8mVKFn7NuOBfyaqwrF+JKCepqT0zLBUXdVgC8n3k2twqcjqn+8+rgcNHuJxEpx3aogJXvmyFRuvmMXdc74qjnm13HwtAA075TjwPfgVdz9vKWIlpWQyMpxZ+OmrdnhzHYAfO1aeUoZJYkSDZPq+jBdhXKuaZJMPWJPsTCoKfBe0N2NhUJb8NVp/eoTDu5EJ1CFqtnhwFVA2N0ROk/T/ghLXJNF6rBChdAy94mG0WomYVv8VXMma7VQd+tafuZjwH34r2jVOx3UxnLKfypTOJhKSHGxhVYFzmVOH0eDbAFS4UjWvlcHo/SvDyamb+ZswvqWlWXUhm6vhIydCUblzB5SL65ZzMPT0aVMu6qAmRbTGHafA1TVkf7xdzGcgVP/dFZ9as18JvpklD+B/kukY80+Cuyl5UPjqf7Ns3UnluKG1tE8OGef8LlgwAY2P5i/1UWi/8h/tnTK13p66ckG1zcYv6DPOp+prp4BpNX5sq1ZKMFCVAdrea8JQkm7OS+TaUMVbIZAg6jFg0g25UynMKl07elNV+IeANogjFHcH3tw/doRqAPhI6SC4FoWvhwa7vUKopYHt7gKG1WkLLf+C4+dBIutDPlZt5ulBqawzg09Qal41s3vIOFnGNSLydLcpvUrWYKX4DIU6DuhB8sBKBeuM5c4br4PKicNYm73lAS5atbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66946007)(66556008)(110136005)(316002)(9686003)(4326008)(8676002)(2906002)(52116002)(66476007)(86362001)(8936002)(33716001)(6486002)(83380400001)(6506007)(6512007)(26005)(38350700002)(5660300002)(186003)(38100700002)(44832011)(54906003)(508600001)(4744005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jM8CuYEArOpsMqaUGmRslF8+1yJl+QIMRXxUouaOVxYd2KruLLRI6VJAuovI?=
 =?us-ascii?Q?7zwM4pKJFkAEe+kwZtMRDxMS3+ZlxxWk1tw/ayOioIALkO54OjPX2sfNxJW0?=
 =?us-ascii?Q?V/BsVVcGIyBRl53ZGjLUSDUKbBpckcGVCZrCVAwuRWAon9MyjC27OuJodCIB?=
 =?us-ascii?Q?n4IYdnFmN9EocdS5b68ESCXRF98HElyS7wZ8ZFSUT4bp3us/q+Td3tlSUInB?=
 =?us-ascii?Q?DBj6aIRYJqDKakg3ElgGbfcvkBGsqVvofn4FU08EwUUJcJoZ2+zIskyQwc0L?=
 =?us-ascii?Q?Ivrif1fDqI1BVWHI08HDu+73mTqgvMebZZ22P5BFHDru4xMX112zD2+a0DLQ?=
 =?us-ascii?Q?bkniCv+uGQxkgmx/HXbTIAc+RYizt3dxdF5XxCOJCrlRUmnjEb5EvV0Xrynu?=
 =?us-ascii?Q?C8wi8BAn12t8qnCmOprFK5DpmjB7BLY2dpT4jo702A+TDhIXAWPwpYIkBzxM?=
 =?us-ascii?Q?QYCrxG8ZHbRUlPx+OYFChi+5n9tWRYWglt2J99rSwSp/5h2KenOiAt9PgvF2?=
 =?us-ascii?Q?Nfe76wSKIWOqyTuI/O9LGzfQvXUlw/1agqsPwUNpF2HSMF+tEP8nUumJV1rm?=
 =?us-ascii?Q?WkNwaTHaa7x+RCf+pMctcgxUO+/l5epZeCi/p7HJqoL7JvfxHdq2Q1mI7O1J?=
 =?us-ascii?Q?tUMBcJHkT+FqPqqkPJWY+2vbdGvGm2mG5KQCUwzspuhfF44HsrhgwJvtxx3A?=
 =?us-ascii?Q?7dnd7BAB5uu/8OCehXjZjQs1BwtwFwnIiHkNfBNj8zItsaOUusweI7nRvW8q?=
 =?us-ascii?Q?aDWtNDRRfB5p27WHTy1CP9i59fr/SdRIMychmWYsLufV3rVMuIzlpKjZnOe1?=
 =?us-ascii?Q?MBr66db9909GHyzTpem5AY3tXEPOvbM+mZVnHpYKFlqlWhXOwa1uQNf4t9+c?=
 =?us-ascii?Q?H78iJCIySMEmgBNsx96bC4VtQF+Z/6j13thYqdqslob+grTWRREe8SBCPimB?=
 =?us-ascii?Q?SqnRMh0aq1wn/rwot155+SlWqPSmU8uAvZHNxClsa/s3xK/YYE6Hn49ZpOXH?=
 =?us-ascii?Q?+yphuAXJpiHFhy0/5oxrQmvyVBGrzgllwLIsiktajWLINIs3kcr83360mzDT?=
 =?us-ascii?Q?/CW9WWV8dB2ZGidFWIvf1GOUXqkeQqdx7nz0zoiHM//dHzcaNSulnAM9BsFT?=
 =?us-ascii?Q?I3HaiX1j2sp082L453b3dBSqCKkhtKU508pMOkW/apCBibKItFPVUeawCAdU?=
 =?us-ascii?Q?zXCN95Hl93DZ0CwgzNSsAUk4Olk87fLAQI9dGrOJPQ4NIcY5CtXXMjBMqBr/?=
 =?us-ascii?Q?icVb/OWVWwRBNtv5p7AWR+1TXWJPHEbbWUCu2QIXnvNGHv2mtLdyIQ8B7XWG?=
 =?us-ascii?Q?gvUZv5crXwbXzJs89R+y/aXNWsAsRNNZGEu6XUGHElA71jh47FisZwG/kcZ8?=
 =?us-ascii?Q?LFMBjE6KofoDQLOElk2SxA0RkCFlAiHk4G61/KF1j+ciMSBgp8FLp8UZ9RdR?=
 =?us-ascii?Q?WUVN78Y4qyIVvs9/v8EeZOJlHRYn/zB0sVDp2Ft8ohKYQ8806+pdrXJnEGmH?=
 =?us-ascii?Q?skq8n4YOtEtst9CU+vzo/RhdGb9QxSFDV13Mknfg5y+zJtf9bBpLjij+vyGl?=
 =?us-ascii?Q?zUyzwZgfoYOjdZeQknKaZPsiXLGl0iwfDaHjQPhV2X+atM4CBwv2IRJfIpjv?=
 =?us-ascii?Q?PNgReE5fFOPn3UbUE6LfcsucOddgsQDgnIbzDjgpwS2x94hKtK48HuA/xr45?=
 =?us-ascii?Q?X6Dhx6CODc58aykJjR4y8mnRDHdf1K8CC7wl0AsjyR/UDBuafERnNvP6Qfwm?=
 =?us-ascii?Q?ArS7RZo/fYLQvJOEcgLNaZ/Iaq1GlEE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a43592-a444-4ce3-a1bc-08da495548a7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 13:46:26.8370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVozIfJa5gOCn/WgJgRhoQhs2ZSNOb56Yc6XoIWHYTpNpoErrcznXQv6tAx4f2EPRHys8GZKEpkutuI7oWSz+XVCf63zJMMx+CM8rWNY3gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1426
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-08_04:2022-06-07,2022-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206080059
X-Proofpoint-ORIG-GUID: FhQgnYOh4KSRJc2yl95ku8W8rOMC4Iez
X-Proofpoint-GUID: FhQgnYOh4KSRJc2yl95ku8W8rOMC4Iez
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Preserve the error code from hci_register_suspend_notifier().  Don't
return success.

Fixes: d6bb2a91f95b ("Bluetooth: Unregister suspend with userchannel")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/bluetooth/hci_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a4b4b3b927f2..dbddf891a4a9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2646,7 +2646,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	hci_sock_dev_event(hdev, HCI_DEV_REG);
 	hci_dev_hold(hdev);
 
-	if (hci_register_suspend_notifier(hdev))
+	error = hci_register_suspend_notifier(hdev);
+	if (error)
 		goto err_wqueue;
 
 	queue_work(hdev->req_workqueue, &hdev->power_on);
-- 
2.35.1

