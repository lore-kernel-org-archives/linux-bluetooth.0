Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8855CC07E99
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Jul 2021 03:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61442613C3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Jul 2021 03:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhGJDEq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jul 2021 23:04:46 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:10416 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230317AbhGJDEp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jul 2021 23:04:45 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16A31thj016946;
        Sat, 10 Jul 2021 03:01:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-0064b401.pphosted.com with ESMTP id 39q2h9r0ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Jul 2021 03:01:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9ALA0seTc95U9hTLZNzyFhssYcQU7M1UqPXt+fgQLOS78ggOtuuaTXfAeQf3tj3KfpIWZrB1+Di94AoOCQwwmeBrljXyIJxhWQLfG69cKbh8kxD6DQvQec7OmB59S407PGg5RsX2Tnrk5GlnIo9CnTWsr6XKkzlVR0EX1IMctUK5KrNAggD5UU39tT/lZhLCHD2HSyQcFmW20J1mRAWR2NlCuhvdXVaDJBUvUEmKqYKaN0s/eo/UZDTFYLG5FTULQ5LrCT02q90p1osYi1pNHa9C/ST3qXgFjbv7ArUAFB9AIATCKHWxYsY2C1aU8wQ7upAlz6rlSMgLMXYHYx1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7w/uWXVt1ZM0of5sjNayMMl9dYuya3MWdTylSWZhMjg=;
 b=EGFE8CjKqLY0DwnHvrr9ozwctrFmZjZ+lsPOEeFi3rLHe+lvVaOVL9e5MoZUcH9L0a4clCMBuaej4zDdSllS6UTu6o/KDkQufMF1S/Fco64kMlzpVyowxACqcNQK0fM6N0Wffj0dR7QwPArxDPQUndb3S5YXdd966gxO8Ni3tByiX8eKdbHN52QCzVL8JJfubIIi18XSi6LABz0tQ1xzzTcyPICdd3JJUm9pBaAPS+wL2SmIUx4ltR/KkteR7SI7gskVGVrjP6zy4xH+m91h1PAOImvpPtxaIZq3rLgFa3DC+IU8MqK5gflU9OUPtkh4p8FnyA4XmU714/yC7XtFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7w/uWXVt1ZM0of5sjNayMMl9dYuya3MWdTylSWZhMjg=;
 b=jiIQ1ZCjTXzcm298J/irNj4NyS/r8SnoNYq7HC8ATH92Kewun1DZZoSV+eoYRedHT5qlKl22jOUEHyhbc93Y8nTmiqz77MoK/GM/nXZ3AaqZ34d2wbiVjM7MmpC2hrsTBHiYpHCHnRAUIXRXQ4etSSYGf+8biyTKcdqaWCVc1H8=
Authentication-Results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB2587.namprd11.prod.outlook.com (2603:10b6:5:c3::16) by
 DM6PR11MB2794.namprd11.prod.outlook.com (2603:10b6:5:c5::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20; Sat, 10 Jul 2021 03:01:52 +0000
Received: from DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::7071:ef90:3130:cc76]) by DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::7071:ef90:3130:cc76%6]) with mapi id 15.20.4287.030; Sat, 10 Jul 2021
 03:01:51 +0000
From:   Jun Miao <jun.miao@windriver.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     kiran.k@intel.com, chethan.tumkur.narayan@intel.com,
        AyappadasX.Ps@intel.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] Bluetooth: btusb: Fix a unspported condition to set debug features
Date:   Sat, 10 Jul 2021 11:01:36 +0800
Message-Id: <20210710030136.1567673-1-jun.miao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0160.apcprd02.prod.outlook.com
 (2603:1096:201:1f::20) To DM6PR11MB2587.namprd11.prod.outlook.com
 (2603:10b6:5:c3::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp7.wrs.com (60.247.85.82) by HK2PR02CA0160.apcprd02.prod.outlook.com (2603:1096:201:1f::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Sat, 10 Jul 2021 03:01:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b4ceeaf-3b55-49c9-58e4-08d9434f10dd
X-MS-TrafficTypeDiagnostic: DM6PR11MB2794:
X-Microsoft-Antispam-PRVS: <DM6PR11MB2794616CEEF6BE6605DFF9888E179@DM6PR11MB2794.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cNnxw8SiAgKCQxhMFQj13UkiDO1FArx4Np99xZsUY3C8+/ff1ZnzZUL0TmCM7RinEu8G2P5QFxqFaEXuG4b1qVm71XzXbPc2yaovmbCl49qPcFZ9JPIgcHW52OAB/ciJHgH2ehMK7JxZI5tGU5IwB8OFsNjo8mxrmgdKE2PacsBD9lTtGEG4RhiZ6AvxrpqBbNucyGcsu0b1yXN8F/4Xw3D38PRxfuh6XElFW1ZhAT12nG9RJq8LdEhwf/Lsbj1xCHGyN/+7weFnJAdaHK9HKs/N9lZJnFfbnGo66ckl37DZYDLQY04uGuXG4OOFb0H8P8a/FKwataweKx5BiqkhWTHnSYByZWWT7xBl7wAv0ybuk+2/pzRDFtQoFzM3akgslIyjpjhe+kyNWOzShZDQiVDmLZT6fssf6B+g7kEF7hJbN0IRYnJXZ7vRr1MPHXJVFf/HzAeIGHQYsXoRYu6WUj47U31RHPhHvt88Dll/jddBOKqMzcF5X3EcNELqUi28sECNwZbKlhxFUbHqJ5SVbqrfygiXqvyLtnWtDiMo+Xk9NH7d25fxa0ycpbuSRVSfUyOwOpApqEWmfSjc2LRg+NOHNe1gXpMy8SVeUX0KqgjHsCbd/EzvZmDk7JAvMTh5d0rh0SRfF3NDYL42OWzjQ8ycc9Vu0xm5tOuTl7zsTHjc4gMDbBlPvK/Bdw2Badq6iHBw+N1njG3TW1uiUWiIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39850400004)(376002)(366004)(4326008)(52116002)(83380400001)(478600001)(316002)(38100700002)(38350700002)(6486002)(1076003)(186003)(26005)(6506007)(8936002)(6666004)(2906002)(5660300002)(2616005)(86362001)(6512007)(956004)(66476007)(44832011)(66946007)(8676002)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8VmmLO0lfYS/IsTIoog1rrDpFTE5OuEBPIHfpgp/+fFvRQ561uK8qzaDPcVD?=
 =?us-ascii?Q?CvLva5OqSR4mJVhMGPqWoxOXanqiceYrFpo+kx0H/hK3PkwA+dYClQV2dht/?=
 =?us-ascii?Q?ztfxZiY+eCVk1BsPua7frw4LdL3oo9xOa0l1L/nTmzQZHcpJidrt/JePAadY?=
 =?us-ascii?Q?ATJpXnCm+Pvoa9LSTH5Iu7MjQHQafQEDswhldPnE8Ypho2VH75I0AOcW9hrg?=
 =?us-ascii?Q?pAeNHx4dd8XIPw7O2csC1yuTgrkiK773T5dnC+MsXeTCYUNVTxM/SKcU4WJc?=
 =?us-ascii?Q?Km0s4Ncg6xV1emjyasHAbTTz+BoedSN+lNwyAJn5f5MacMYAwKkmCCpistPB?=
 =?us-ascii?Q?dmsHGmrJuNfWuTAG6gkXnnxbHDt3zJvLPZCo15e1F2tz2lQF5/dj6KCcUVgK?=
 =?us-ascii?Q?dcdacjw1F9zx5a6LYlDciDfKpCZ85tZOvWVPGijXad1IG/twWp74HCa2Is9W?=
 =?us-ascii?Q?zInCYCPmgaBzH43E3EW9fJnAJyv9f+4KMFYwZGX/AaWpEGdeHYNK0+MhhTIP?=
 =?us-ascii?Q?eO5qgF70McM2Mj6wMjQp/mf6ixU62R+/+4y/8P9JNBn6gpCdXsBZ6rlMJpQc?=
 =?us-ascii?Q?+DU/0vK0Rvpf4r49mjV2T/qyLYnhVD/kVmX7at0ZT/lxjCEGGGxpN98vqCV+?=
 =?us-ascii?Q?aiDqiW+us0DqnmPwQk7ITIErWEyvhWPgI3OuNdjsJjQvavnjCf5l/nnT5Jj5?=
 =?us-ascii?Q?80EPc+0HyC/OMYIvT7mVdP5PZo7UE/Ul3DM7HmJYKbhaxzjCALYOduhcS6Fu?=
 =?us-ascii?Q?FfDS9y/6w73bXsekSgPCiUPxAstmaZkcxdcBzVZ7CKGguj4bNSuIz0BUtZoM?=
 =?us-ascii?Q?OmRQPFRP4w17NdSivhed2zyCb4l98UtGh4jJ9sdGPI8mHj3Yz6MuyydT01WN?=
 =?us-ascii?Q?jRDUbKaVBhih6/aGqTOZZBo+aAIs9eo9xXEwO3DRAk56R1RHfEzXNZAq3Rre?=
 =?us-ascii?Q?npJnx0fg3bH479cGm6cazUE7hVmrzZS3AZYPJi31KhMfD6I2wS1Qxau7nTeE?=
 =?us-ascii?Q?XyhsYWn8xSF93P7mXqUfRrGhYGgZ7Wz/HM7FMgzqGDigfwj9XO1x+wGDaSZW?=
 =?us-ascii?Q?0JIYOMWYM4dWe7sreR6foaKq5fTl2FIYwQmN0jOVvdLMLUaOwAHbHfTGNQFy?=
 =?us-ascii?Q?aHWCFaX9K04qBZKTXsu5RKQWvzGgSzIkZjWvd8OVs+RB5hcHWdbhGm1lOexU?=
 =?us-ascii?Q?VhQ91dz+ILtJLMh7gDmif/tlDphxeNGJoibaQOm/yQThLlt6/7GDaVjLpN7Y?=
 =?us-ascii?Q?0/q+5Xgl7mJ9sNd9qnrGeJ4ejekWXHD9eYdLyb1+f6WoooT/ZRoi8kDeXAys?=
 =?us-ascii?Q?Nz6q4fYTfibCnFZ8OZf0CjFS?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4ceeaf-3b55-49c9-58e4-08d9434f10dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2021 03:01:51.6573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L827JKwPOMZAcBkfHS2ONBkU0L081hPYI8u68WLImDmaylcovbc7sY7QkKlozTJFNwdUbpfUDC3HXp9m8qP4gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2794
X-Proofpoint-GUID: e0iURfw2mhG4YAKkjPqBRkiA_izVx2SN
X-Proofpoint-ORIG-GUID: e0iURfw2mhG4YAKkjPqBRkiA_izVx2SN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-10_02:2021-07-09,2021-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1011 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107100016
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When reading the support debug features failed, there are not available
features init. Continue to set the debug features is illogical, we should
skip btintel_set_debug_features(), even if checked by "if (!features)".

Fixes: c453b10c2b28 ("Bluetooth: btusb: Configure Intel debug feature based on available support")
Signed-off-by: Jun Miao <jun.miao@windriver.com>
---
 drivers/bluetooth/btusb.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a9855a2dd561..20c804069991 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2907,10 +2907,11 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	/* Read the Intel supported features and if new exception formats
 	 * supported, need to load the additional DDC config to enable.
 	 */
-	btintel_read_debug_features(hdev, &features);
-
-	/* Set DDC mask for available debug features */
-	btintel_set_debug_features(hdev, &features);
+	err = btintel_read_debug_features(hdev, &features);
+	if (!err) {
+		/* Set DDC mask for available debug features */
+		btintel_set_debug_features(hdev, &features);
+	}
 
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version(hdev, &ver);
@@ -3003,10 +3004,11 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	/* Read the Intel supported features and if new exception formats
 	 * supported, need to load the additional DDC config to enable.
 	 */
-	btintel_read_debug_features(hdev, &features);
-
-	/* Set DDC mask for available debug features */
-	btintel_set_debug_features(hdev, &features);
+	err = btintel_read_debug_features(hdev, &features);
+	if (!err) {
+		/* Set DDC mask for available debug features */
+		btintel_set_debug_features(hdev, &features);
+	}
 
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version_tlv(hdev, &version);
-- 
2.32.0

