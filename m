Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6891CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jan 2022 07:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348512AbiAKHZh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jan 2022 02:25:37 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46708 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235242AbiAKHZg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jan 2022 02:25:36 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B3TJvL003322;
        Tue, 11 Jan 2022 07:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=u/J5FbXR5MTPMNgB8a3M2foT2v3hFl7RGUFzigLoc+E=;
 b=bu8ln7AtAGgkAMnSM3CKwghe+lz7XF4HdlF9eUAjeg8UR+NfjEr2dEqUJNu/+33UDO3+
 N/1TdYZ6F+7iXIvoVwG30lAo2PP7CtW9E3Ndw4k+Tm2WpbgtNvCj14HmCjQi2x7eqMLx
 ox1D4n6o0cl9NkaQV63tPrSZd8OGmHoidWpEPxQpHUSoY3GMj2wP1i7gNnx26oQ9DyEx
 SWvi804l2Px6PUKzoisQvhD3/acFqN8Scu9vDmS1q2lTnYP4QV3vKobnb9vIrQhaRJ+C
 lqWdAzFlofLto//Ar5SqqaoxF1eofuwZ+lBdsS26U5yuJjwqO6SOCx5TDz79+mpFU9YU 3g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgmk9aaxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 07:23:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B7FwL4027999;
        Tue, 11 Jan 2022 07:23:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by aserp3020.oracle.com with ESMTP id 3df2e4dfqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 07:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJu9eBIbJ0b7nPqTj6E4XBDYIE/xjgmegU2u4rDwvgkiI7uHj5if5dncZ8ryS1b7bdiLGJkqWsc9xPy1pOy/reOx5Ln5k3kiCCHy1lsroSurDyNOJlcYfeFn2AAoMCBjmDaKC6kM5ab07iBPEOMCUmFd/3iIFaYxWrihqnxiujo53syUyosnNr0RwgKWde0N72OsWh2xTEmL/uhrxzJLMkr5W1dCGvods05jBwb626sD+HP00pAsPiqK7IbG7gWdseJyUAieveQo44lz+RIxdm3R1gM/kmVCzpE+CeEZMv8dasX2s/aCdBtOEawmBnkHO1m0bfTqh1x1/pbvor0Gbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/J5FbXR5MTPMNgB8a3M2foT2v3hFl7RGUFzigLoc+E=;
 b=NUPIZ3Nsntu1h8EvGxZ/g06l+dz+X0/+fW+lo7aTVjlfwLv/y2HK92oiyJF82SojUCk2a00jV7ERkwTCgPnwDJlVBpx0IyoAcA8Mc5zzJPlxQiUtI/2+RiMPPn9Y8OltYiN6+iHeSca4b9ETjm9e4PVX4nrxf8S0vW2PsCWd7lCKQMfdWPNmd2zGbL0z4ZSDbL+XM6oESfvp0Qkr7tFoqZyLWXgWXp/ckhXg23J8HBjLhqpZ29a4ifTcuwSm0podwfSlOHjnjJ2Tzlikc2xVHvAe8/tlDA0Ru0PfbsZKqETBIZCJZFxGMUf3ZLMdLlv2FWl1fD8t0phpricBXlWS8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/J5FbXR5MTPMNgB8a3M2foT2v3hFl7RGUFzigLoc+E=;
 b=YrouBzJhZmDDGzoqNBfjLE+ucmNCiiSJMKI14kUX9roERp4dVTuFViQRS4e+sa/x37AqSV9ZK8uT11yDjjc2KGmTme9Q4OD45Jnyxhk9fn+vTkHT3vm1pWC2VG6lWdt5WD3WM8ZNWzGN/tLvBvtYQLwYYZRZi87llXbXmKttSyM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2159.namprd10.prod.outlook.com
 (2603:10b6:301:2c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 07:23:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:23:30 +0000
Date:   Tue, 11 Jan 2022 10:23:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: unlock on error in
 hci_inquiry_result_with_rssi_evt()
Message-ID: <20220111072319.GH11243@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0075.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5f1fc78-0f01-4471-7a42-08d9d4d34427
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2159:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2159AFC1D8CAF4690257154F8E519@MWHPR1001MB2159.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDXaYb3AC9HnDRLSAb3YhcAGpi8Ela83LwqCFH2HkNs824t66AnkWHdsQYeqK+iwIFp1qIXvH3D7X9gtfaIsggAyrleLrEAHb6SMvq8TSVozNP4XwzWTEsR4ZVT5lINtxWJX2vHIRrceleDJ7jvJzF3bx5tJHub3DaPRyddbcypdUqGRPyII4ANijPSLV22aRq+XDLPIYRd/KRhV3GK2I4L76PQ62Gn5Zd7fmvskdNVSr2WdAhBu2LRaZk6y6Yor2NIUmdQF5bolmSntwZo9wGuHXDnagvwMw/biw3OYi1z6Hn+mJ3djm9XNBpNZlML+ZAvSYEOVBGwbeJFZyXufL3vkJZTo/iUUTJzS118oDwLGCanbl7n158Hsn1oYnWZ2i6dP4nqQyeHcTfg/+KcCIq+WyLNuyiBm7PbWrYCE7cK6LVXuDXV9nFj4MThnTmlUPgGv0qe6juqs0m/ULMXhke2Wmr1uK2tMdUQi9bOdLMuG/8Xoya4/fDPSdHM5IkTPkekjJmOu/NuIluVoEM8QbHxXR7QNrPUH2i9iLE/vHhh5M0tdoOmKQ3VavLSgvMcOEqOi/zFJnHr4i8lwJ33NDyQId6JHbl1TQFBuh7pzvGP4vz/Od7YTc0YLvkfrMJ0dE2nmNPxWTm+hjekCwEdP9CpS+vIBzUnGLuJnGSlpNzVUvWd1IIZKiQyj/aZj24CblM5Fu8ElwZB3wnGQG5MGqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(9686003)(316002)(110136005)(66556008)(6512007)(6486002)(5660300002)(6506007)(186003)(8936002)(38100700002)(38350700002)(4326008)(33716001)(8676002)(2906002)(44832011)(1076003)(83380400001)(52116002)(508600001)(86362001)(66946007)(66476007)(33656002)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DVJvKobRSLBKL3X+Yt3L4w+O4MgJqmn8Nv4RQdUdCWDs65tAYfzYDRh9okEw?=
 =?us-ascii?Q?7/P3pwEllwrcImVsty3lNzNU2ShoTxqYnm2FapGkPKoOLH9paP39Q5xebrim?=
 =?us-ascii?Q?+RZU2QRJ3cZoQlGG8kHBpgrcd7gkyZwU/MS019J/b/JiQr+j3+VtjqoUVAZG?=
 =?us-ascii?Q?d4YAhmlJ1+YonXdeb1R2icjEas2OZLx5JjLOP4FxjrpwE9HwseZe0IgTbR7q?=
 =?us-ascii?Q?wytOoHhpIDAjSC3V8egNxZ7srZcnyI0UgeJOJTZBanhTxlyfR4O0vKvbHnND?=
 =?us-ascii?Q?6q40SvUTF9fOXWvYqyMqYDjlygoBlFw8kHHiPpbLOuuAJUt76eNUAKZRZPxc?=
 =?us-ascii?Q?awWBPKEO3dRkOOM+nTiqhzCm5ZQPPfLA4PMEs0xlrzmvl1/2vqI8E8aYgkje?=
 =?us-ascii?Q?CCe5mbpUGRqCCTzGK+Cw8F62kEQeMYHwfsW2Ls2eC/E6JvFxwKOqs5QP7+sX?=
 =?us-ascii?Q?D49EfCU3II885OhW/7o2frvEaJ/6hIhmIOMvIf3xNwQ2heWTfhnH7GQSaVo7?=
 =?us-ascii?Q?ULa+RI9uU0WCGAFNevyp/w5J0cZ11r08aJWtebIh3+xLnDXm3jBHwcOLv+HT?=
 =?us-ascii?Q?b+rrC0KaNf87dsptJvXDsPe1z0ulTR0vFpGi4pqsU9+wMVpk4YmTkNO1wtxE?=
 =?us-ascii?Q?r5QZA1PHzdEAQZr7708SV7rkzFRaQvE7kHtvYT30tVC2wGpmpAD0UjjUj48g?=
 =?us-ascii?Q?zEpx3lNLaDXU0Qs6IV0D2VqhZxMXEm3wXDYqqpvrY9vsQ6VWBB0NkXmcs2+W?=
 =?us-ascii?Q?CxrJNPtW4KFH8cVgDLe1RWiemZ/k4lqBPcEs1qw5Fm7tgEH7X2wmRGtlR9jz?=
 =?us-ascii?Q?RIoCxWyXwviH2eSfI9erlluwZGuCpNeOdPl99Fwv7gDLNKi7e/q7gPdOAJxk?=
 =?us-ascii?Q?rLDwSB/ei1rj78daEzqfn/078YteHp4lkpY1u+CPOzKhi8dfLp+ENAx8AvAk?=
 =?us-ascii?Q?/4EAk3VeRFlJMnlQtSwk8sQuHUPUa2K9PEx7hklUnjqBCEsrXWTuCSPeXx+q?=
 =?us-ascii?Q?KvIBzz9KM7paREywv12ksMxzub7rZSvLDAJ6G515BulxTZoXHTZq5QptN+/Q?=
 =?us-ascii?Q?yB6Ow8SPZ+T1JeOzjZP6T+cPTjCAYYJQ+TSwomQCGP91ptJRvvZcemh9UKhK?=
 =?us-ascii?Q?bkP6lNPnaU1sBmVmjduc7Qb/3cKLzvg1SqcVii4qLw4MZsgxx/PBetI92hsv?=
 =?us-ascii?Q?lPFrWjDhvoZXFsdJMbM/lGFeR5lNJoZwbj16SsPewYOewJN8J5zW+D7ce+3g?=
 =?us-ascii?Q?Xr1WHACwh+k6744GJqOSbleZT1Xg3X/hK4/7WP14L4Zs5Rqto/QW9zkSaMd+?=
 =?us-ascii?Q?n9bbqfhWPl+tE1VUEh2G+0fMuiFegHD0JCDdf81sn+A4a2kDYa5PvGfGP4k/?=
 =?us-ascii?Q?YuOgUMNHexacljBk27ESf9LSIC5oxW4gIyCzj0awwm118Kf1eab54lEtf1DN?=
 =?us-ascii?Q?C0VRY82I79uk3LupdeDdUdgvFKZT6pc0cTsibyCt3n2dQhlFm7R6zIpfBs0c?=
 =?us-ascii?Q?MrmGVWlq4W6lmwxfUPA7sZlXBhXh/D6Q7bc0oPrsAYD/fANwVzEkScSjdR6L?=
 =?us-ascii?Q?y+Gm2v59GI30THSAtipVAdLesQi7B+wIz96H+cDTBnjqKAh2R6Ijm42NdyAP?=
 =?us-ascii?Q?5ooMy/eefCFdkjMFdzCPJDVp/nD+ODmEg07JoUkx+j+nvMvVSx4EE7dn7Aqs?=
 =?us-ascii?Q?ffNHW3Ft8VQy46+F3zGeVzIaFQ4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f1fc78-0f01-4471-7a42-08d9d4d34427
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:23:29.8917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYvJgRQ5TroF26nKllvi3Ldym/RMJgw/7NrnHPuz5DhHt4eZ0XNvqQA7cSf2dvu6vogJhnP6HuunUc+XEnTHUbWyxx6VnGAxl2eNak/vAmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2159
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110039
X-Proofpoint-GUID: eBVChr4cozJx_-JEDTT2nhosqhKLVNHx
X-Proofpoint-ORIG-GUID: eBVChr4cozJx_-JEDTT2nhosqhKLVNHx
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add unlocks to two error paths in hci_inquiry_result_with_rssi_evt().

Fixes: fee645033e2c ("Bluetooth: hci_event: Use skb_pull_data when processing inquiry results")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/bluetooth/hci_event.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f1082b7c0218..e6c75cb1c7fe 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4536,7 +4536,7 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, void *edata,
 			if (!info) {
 				bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
 					   HCI_EV_INQUIRY_RESULT_WITH_RSSI);
-				return;
+				goto unlock;
 			}
 
 			bacpy(&data.bdaddr, &info->bdaddr);
@@ -4566,7 +4566,7 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, void *edata,
 			if (!info) {
 				bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
 					   HCI_EV_INQUIRY_RESULT_WITH_RSSI);
-				return;
+				goto unlock;
 			}
 
 			bacpy(&data.bdaddr, &info->bdaddr);
@@ -4588,7 +4588,7 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, void *edata,
 		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
 			   HCI_EV_INQUIRY_RESULT_WITH_RSSI);
 	}
-
+unlock:
 	hci_dev_unlock(hdev);
 }
 
-- 
2.20.1

