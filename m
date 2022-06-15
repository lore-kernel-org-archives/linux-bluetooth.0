Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F424C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jun 2022 08:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243903AbiFOI1R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jun 2022 04:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244402AbiFOI0W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jun 2022 04:26:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83B5252AB;
        Wed, 15 Jun 2022 01:26:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F6xkua002105;
        Wed, 15 Jun 2022 08:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=dNEW+btse4sm1hljJ+jKEdcOC28nRPsvyuYaMiuUJQg=;
 b=vUJ2lQIh7adKX04bYBhuBkjZpbfWNmW4nDYVj9J9cUjQmeVUh3pPmFfpD7iK1XruNZl1
 Y6XrXN8DjV8pofq5xo465EZ79Wf1Q/cBrE4az+HRVmBL4+FIJarl7cLKJv6iqmp/ys0G
 89E9gCfyW7aLPfNeh4/fFstKckLENFtXuO4HBYP0rZP1wyDy0af2g+VJ/rC8v8qmBlhk
 rvgssV0JudR+qhFRjhu2lV8WrN/z0ICLepZU638b3de3Iz2AtdsW4EcVTY6s1WTeuPyr
 vemYBBi9o/JHN5VpKw71f63hHtvFcEp+bJiHul31qfmSFYeXhfTuMsuX9DtpO/uK5ibt Mg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhfcqwdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 08:26:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25F8BuNf029885;
        Wed, 15 Jun 2022 08:26:17 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr25jb0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 08:26:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxRa+KPZ3eG1LseKfUKrSfML3hMvv5vyqZYhcgqHka85dkIGxEksq2WHQdZWua4vEP3I077pr29pwKk88LUWxrSG3um6ASkIRp2GuREfkJzkMgJK8CodHbkx6atefdza9pNuzV9vIgBzuAgq7/qi8FQ8KU/kw1Ir8HiNMB6M6KF8qXjab2KuLjRSwP+1tX39I2T5tRSbp7OzHpQfqpGSIpPZIg2iiZTI8yN96kUcP1TSbkCXufTXWBbULs90iaqRLN3ZYOC+APVxjVwGWPREDgvnwmWjimJgD6yOVbkeCZzPQ/BjG1wR0UqKIvPYihfXXP4MulL8cvqds/6Zlo/Ayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNEW+btse4sm1hljJ+jKEdcOC28nRPsvyuYaMiuUJQg=;
 b=TJTe68w//zodokpyinNyrQbozH9Ve5eQMv+aeMQppVieIqD/jZflH0YMfrBQqGpB5HfqMWCbEO1E9htF859U8YrWBg6MsmbAZZA4KHRXWDhOtmSqtbmHRkoiRPxI2wdQWcppe7iSKCF9+gTMDaI6zQAUbhzAon89Q76iEOMMbHMjm8kDkT2VNGcwdaimx1dHTlssEmKz5ST5+f73TZluH9fNJuhvcPAWKzbp7EV0WXriCQbN8OIdk7y+w5RxoyC2hJZnE966EdopyB1h8WG+4rQ3SFfvXZshqTbnuim0rKbTHQ4/nZEHZK1lKaB2+75PZDQP0TEW9Bv5u6vMUQ9FgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNEW+btse4sm1hljJ+jKEdcOC28nRPsvyuYaMiuUJQg=;
 b=n4v8VC5xCJ4aHxHyKFoVJR2zVz0YD3/ZpvfKlVabyTSPZwvoXIEJreJzc+iRMFlqH/rcHPYZlUMnyQhG1PVDa+emolWDgFWpTMl4fhmL0Tr84vhy5Nsgh84PopmUtwHvbI8wJpQhOGgWlySj2KP9aNvIRw49Jo77ZP8PTNTuECo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1741.namprd10.prod.outlook.com
 (2603:10b6:301:9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Wed, 15 Jun
 2022 08:26:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Wed, 15 Jun 2022
 08:26:15 +0000
Date:   Wed, 15 Jun 2022 11:26:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: Use strreplace() in btbcm_get_board_name()
Message-ID: <YqmXmsTX7dD+5HjN@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0039.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b14c6fb4-90e1-49ce-c057-08da4ea8b653
X-MS-TrafficTypeDiagnostic: MWHPR10MB1741:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1741D345F7567261976364818EAD9@MWHPR10MB1741.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fVhcAgwuFpfbw833OF3viPQrcErEVWwa5jnYNnzcki+Jijqf2KewBqDJvqfglRRB+gbcz4xW2YDTdv41u7xCHoCXogU1vClmScb9fl9BO47MuzDRksFeAJhrpKeN4vlP4dqaErcuZ6jKGwnqueah0EJ+q26KwMHFtePlWqV7GwGoVXNtzy0aIAaG0t9Y4qTpefVcTfu6AqglruOp0QPE710UG+wdqYv2cNx9ycfowwyYjL4yfpnfSBCTOUrzW6U9RV3oxTWZ6g4mKlUeiS3LNJ++rqGf6aXjSsZ1P8FYsDFTRmWMzZtN5aefDYIzm5E6gI0J+AYSNdg/KM16+KR3kh3aMdC+jcaPZNwOoZqCMa6jBbhLuIprOqSFfQWSNmNHSkBZjHSLOy/SQ1wN4YkHQKN7jzHCY3abwwxPImRsQymhaGhtfzHzd9CZ8bsMU1XWtl/lG/oZZEI4A8S4CM+gvyeDoC0SOy3YwdcWMluzO6U94SM595lMpPawnEOdPmts1kniSDkmCp5bPm+DMizudkJGZog747YTIINfDe7mqSZ50zq7Lw0jknzCW4MgqfxCQawINrl5YN6x9kXdudUDt0fSSHe6l4G6c+FHNcWQG14itgaJE1WOvNUvFNKX1/k6CMwwYT2XFxkVijmadbthzDHPk5RDmt9nhNKMN+L81M8dl7RBW4WsCs42hR7Qca5Q5Y3kZzavNdNGZ4vGvzAnObVJ6PAVO+a3dumli2ibNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(4326008)(8936002)(54906003)(110136005)(186003)(8676002)(66476007)(316002)(38100700002)(86362001)(33716001)(6512007)(66946007)(9686003)(38350700002)(6506007)(26005)(52116002)(6666004)(508600001)(5660300002)(2906002)(6486002)(83380400001)(66556008)(44832011)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s/c0tWs3XCx4yD1BtyYMYe3wDXY9Tjnvzq0t6Ea5VY6NxdL/m4bhzvsRq8Kq?=
 =?us-ascii?Q?0EK1kYB8qaWgcOxZ1Nrkslscqu1YSl9ts53LmBmLGeLBNV19NmY9eymAVSTB?=
 =?us-ascii?Q?rUE4RksVxDATiyTNeTpqR54nR3rJFoob7jHI7JG3QVyV7NOXzYS3YxfCBL4L?=
 =?us-ascii?Q?t5axeqFmA2dwkHmn8HOd548OfSRY5VmF7V4Xbv8M5CGmVL1GYkGv+tuBjCiD?=
 =?us-ascii?Q?BJ/3gbekutGv31EB26ZCzlu4FjubgeZ0Q6+MWw41qlzRsdeas/e2LVeyzPyn?=
 =?us-ascii?Q?UN64QwUY0qqASHBvSABYHTEaMEKUgaxH4LabCLM8DOh4G99yOOiFDPWll8pr?=
 =?us-ascii?Q?6Z8HFIyEOl9D4OkFl/kPNnIG4q+p7qf+TlyW9KjzKITj/JewwjTDa6oUZFxd?=
 =?us-ascii?Q?Hfvjfr3KV6SbPpUW/cukP1zlR9uopoZG+C237p50E+C19GBj0viPiDo9b0S4?=
 =?us-ascii?Q?y3zpduX3inb8jYlf/zP/rMXM5VnAsa7cS9MdyWvnggIlslNlkOz0qyoIJpPh?=
 =?us-ascii?Q?JZxHQM9wkgtOfsYks0Fvb7ibwchXE3YTrvRdYXiiKejEseZ4TujtAiqqhYSL?=
 =?us-ascii?Q?XNeTKGQmJ+J3vx1oCycjN64D1SOpGOAM2loMA0dyI1BEGFsZ/Au/g3QcyQnX?=
 =?us-ascii?Q?C+vG3UKNYYRIK06qffBBnpotIEnSHBRwpKsbAUH4yf0Qghng0pVNfQfunJr9?=
 =?us-ascii?Q?vtAGmra6KJ1NpbXfECEW2BSko8WvpdMFtRWZrsSQc8sGF2p1a6jH3XZ1/oSx?=
 =?us-ascii?Q?zYQBZy9lP0yeXJyusV+xfCbm2QBHQpot33OrQ81j3DhsxcckRUtlufit94+O?=
 =?us-ascii?Q?WoOnqEGBm3ZnwMDHSnkgnPRkf/DGjIKpCgetNN5giXOmjSepRxU0buZP9u8i?=
 =?us-ascii?Q?VpZqW9c7Q0GhJY7xFkinK27nKLQoq1yItWcNQg7YsMXyNcI9NRxYgvH7RWP1?=
 =?us-ascii?Q?R8AtLx02Ve5AxJ6JYxBZXnUW7A/kODbYO6VBiDuzFrvH+6q2N2js5hV10oAq?=
 =?us-ascii?Q?sLDPB/hVc0m7mt/ePUWP7ofez3l7iRe4V3v9QlKNll40kOt8qmWhIfdo2RpU?=
 =?us-ascii?Q?0jfbOJLzHwhr0jy/ouMcPAW3zAvKc7I2ighK9Ml5J9B20YNQMNvsdNTpNVKE?=
 =?us-ascii?Q?9exBK106K9PfLT88x/8UC80rHnVNMdYUUazUKGlT1fj0lw+0yWXYvzx4yVjN?=
 =?us-ascii?Q?bPe/t8vY6MEl5l6KL76YU7aGQdYxpImW2Uh2M3m7fXLbquKFyLDz87YyXKYQ?=
 =?us-ascii?Q?mTAc6OMREo0qwEQXga1Is435viSawzYvkNDZxaVf0TVR2mbFmby9L1Z4lE4S?=
 =?us-ascii?Q?OAa2dpqO5xzdLt3hQ5moF9uAXGf/s8s35UlGZkXfO88KhkMe1jfIkQCo0f1o?=
 =?us-ascii?Q?AoRjpvGL187zCUt4gpam9UHvYRZXBdm0VcBRwH9ECeaKwQTisjxRngcFXUnK?=
 =?us-ascii?Q?VYtS8MHYcVaigVcnUxDNGSJa9Tvs+rQ9vnzFVJ5ds9N+ICut/1e9l1x+XALC?=
 =?us-ascii?Q?EURaHXtZKPh5kN4YI7FXdH/Y7Yueuzh+h/ufGMm3y7npLqNENIjX4ZKk3LyB?=
 =?us-ascii?Q?FEUR0SmBXLsgTWGXRRbfX5ioNuwvwQUFzUIGyVNlY0Fnx+QPf8W8GxvlewVn?=
 =?us-ascii?Q?+WgyC8b2+OinwqecEM2yGKtGM6jdmFX+faRk1aED1nlJrx/hdb/L7I8SYQIc?=
 =?us-ascii?Q?2YbGvsPUY94JW0mYK0J6XuUMgk+Z+O1kLBkw2swZN3blw/Ov4Vf6Vb9gYXCx?=
 =?us-ascii?Q?nL63aLe2W2wJgNuwEpLpfMITlZKcVQI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14c6fb4-90e1-49ce-c057-08da4ea8b653
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 08:26:15.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qg4A67EavkscHeuzK4vn3v8pP1BA1UX+4vlC2jEtq1MbWun9BW6nsMqSz2isjbS0QceZiqbE12SDvj6EuVZZ30LRY1GsUOfQ215S4t3V6Po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1741
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_03:2022-06-13,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150030
X-Proofpoint-ORIG-GUID: o89AlCkiAKAKy0Ev3SO9pBXIv_Rilb4a
X-Proofpoint-GUID: o89AlCkiAKAKy0Ev3SO9pBXIv_Rilb4a
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The original code works but it's a bit iffy.  The end of loop test
should be something like "board_type[i] != '\0'" but instead it is
is "i < board_type[i]".  Fortunately, those two tests are equivalent so
long as the "board_type" is not an empty string.

It's much simpler to just call strreplace() instead.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/bluetooth/btbcm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 3006e2a0f37e..bcf254e2b138 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -498,7 +498,6 @@ static const char *btbcm_get_board_name(struct device *dev)
 	char *board_type;
 	const char *tmp;
 	int len;
-	int i;
 
 	root = of_find_node_by_path("/");
 	if (!root)
@@ -511,10 +510,7 @@ static const char *btbcm_get_board_name(struct device *dev)
 	len = strlen(tmp) + 1;
 	board_type = devm_kzalloc(dev, len, GFP_KERNEL);
 	strscpy(board_type, tmp, len);
-	for (i = 0; i < board_type[i]; i++) {
-		if (board_type[i] == '/')
-			board_type[i] = '-';
-	}
+	strreplace(board_type, '/', '-');
 	of_node_put(root);
 
 	return board_type;
-- 
2.35.1

