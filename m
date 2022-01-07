Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B117DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jan 2022 07:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiAGHRs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jan 2022 02:17:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31386 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231975AbiAGHRs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jan 2022 02:17:48 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20736AcC014394;
        Fri, 7 Jan 2022 07:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=H3Lzd8FMpUZoe2oaoGevU++6k2Z1JIlmoQ2LoOIUblo=;
 b=VZR4p+78qHdvpVtNJe6btUM0k/XUFiOu+uK0LXNGVenL2U1vslvMnOQialLRDvZoGs0w
 6cBKWARUgt+joSOkR62IJ4PGhoqNteHqTXRpE5q9L4ufTj4XaPaxvZs97pMW99307Ofs
 25XMNTQUFdstV84UQHIsrhbG7c3Ko2ERPlnDVaW3foZ2O2JTgOAnHo3Ocjw0IbfQLFbV
 STsNLfVRbQTbc9nO5MtiKnpIlVAF2jIT3Bp0C7aIXT5KjBtNRocpypKR7sXS4DrmWxPA
 GlOMXBr2WgqDVZa/3lS/3LQoXlwqDPBgFBBNgDwxY+14eRoyYj8Tw+PpH2ZhMOBur3dp pA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4v8h9jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 07:17:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2077GDEC171636;
        Fri, 7 Jan 2022 07:17:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3030.oracle.com with ESMTP id 3de4w2ph5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 07:17:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzemHR15PUKlKk+9waZ2uZioJVzlKcXAc0NzJUvLc67KwvEmTws3JdT/y6gtnyxflrL0tZQZ3KZKnfQsALnbi6mWVKGyaFguN7HhfHwTDUfue9zhUvz1t9e2MS40s9QdzD1Al8pCsambjo3KmI93Bpi6JnU1qfITu0uDQUcXRp6k42jlS3e8QzpQ6yzu611R8Ff7LIPJqher/i39OCGuuzGK+fgAtrH0KEcZ00JYktfiCSEs03LrP0ti6D0UgeB0M0wf3cS/hX197rucE/Z1SKUJjekWKc/ChX6omYxkw5gpoCuza0ofs4YVAYE057jBnOHJwgVh7zrwj3kHUnFo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3Lzd8FMpUZoe2oaoGevU++6k2Z1JIlmoQ2LoOIUblo=;
 b=KsN3Zq0Y2YOvq9XUHK2/KApvs81/fb6ZdsE1XA364yTobAS+GMxVJkcACHEKhXhWneBbUfWICYLrnHZxduFZgjz36G4MF0Gst3Gudh27LtCY5tpF2yT/7xH6OwUtjlcDjBz/goYHtQipWoI16hOWfIGTed12wLY9F8YmUD96gxJhmwJRt0YIccrLb70jLdpZxC3DGm3c4oheqoeD8+RUvQjydrtlgrHkxMEJ2Bq7Uck+xk5JgOnuEFkaVKfvv0L04/4lB/dRVS/pM06aaWrCvlmpRdeP4mjECZnfzglY8B7u9mxrCQSS593bBt+ai6BHcfEmhL+IV8AaMYCt1y/EAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3Lzd8FMpUZoe2oaoGevU++6k2Z1JIlmoQ2LoOIUblo=;
 b=OY2854PdPy509l3rr7nGJUaet3NzZ9bHKu2Fts300Dz87d7RU0F7L/saQkW3jZKoVf77GEVasdz5rG54VVhjvgQstIsn1CqZBRmwevI8z7UQCEys72NPhd5qmkijv08D0gzduphVprgzaZgHoUWmRXAO6BM5Gj9G9R0NMuBoMqw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5554.namprd10.prod.outlook.com
 (2603:10b6:303:141::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 07:17:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 07:17:39 +0000
Date:   Fri, 7 Jan 2022 10:17:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     hch@lst.de, Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sock: fix endian bug in hci_sock_setsockopt()
Message-ID: <20220107071727.GD22086@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0172.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::6) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f05fe8b3-045d-4f69-b5a6-08d9d1adc98a
X-MS-TrafficTypeDiagnostic: CO6PR10MB5554:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB55546C99B9AA94014ECF44D18E4D9@CO6PR10MB5554.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXbhRAmjTplTbtMZsQXSvz0d0+dhu9BAs3ctLYGfUzwyMJr3Xni7p8i0lz7hoAgcgLzGgFIsixcE2e3M6jqsVf9M6bpr9HPg46aoYZ//WSdQhO0XSngCmLqyFmQf5S45x7dA1/7j/0bsZOlJT3HlQIDoJhxN24lowzaGnePKN5ApaHd5shAsv0C++hD4byeK6veOvlIdo6wbKUeZIIEwU7RtHYTd1uvzRtXm4YXoq2gx0WorwCotSb3Qa8FImwCZSLQTmzlwJ2Xnjki7dDvY0n01DlSHKYdS8szfB+cdVIersFNiX/5cR+TB2jhaYf8DgWa7dI/fT1GD+yrcWmJz5mtmfU44oly5bPjooHdL9W6q8bCnnhTPNpELCjTBxQK3URRQr1Zi/eJV19+OkMtpcpxEtWQI4+2Di2U67X2cu3/xxiTTvlYwcDLuueayl610TseJowIrIhcdlo8LwuaWY+2yaUpyRdPSVtKz6ltbukBGskidUGSnfoKVXwZo+yO9F4iLP1SSKeB/mUb+xD+prs5HfvunB1rnmIJqQDyqg9tZGgNOWpgFiqHp5T56vcsXMkt1uqyJpWW+60Mkf2AoJ5JmQgxqjyBBA5I3pumJacyvC8tUmXinJZPSpBWPuxi7F63QhUCjtor8OU3XD3HdvzfxJk4LI92UB8QPAtg4unCUD1IraHYR5kI22fJo5B7tPLnxyYZoyFJcGuKmEmJ7Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(52116002)(186003)(508600001)(26005)(9686003)(66476007)(66946007)(33716001)(6506007)(5660300002)(6666004)(4326008)(38100700002)(110136005)(54906003)(38350700002)(6486002)(66556008)(316002)(1076003)(8936002)(83380400001)(33656002)(86362001)(2906002)(8676002)(44832011)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MJI0WW50byogEmTFXLcnuOCDJI14Vji2Vr01VEYnlKUj48DsmdIGKgU8noNA?=
 =?us-ascii?Q?mvbYZbYCsjD955Gg/tQ2PMbuF8bMAPG5jQ9E05Iu4Lx85taxRZjdjfgmXtiv?=
 =?us-ascii?Q?QQ7s+h5LsZjugKcLpJH63LJ7V2T6cMzSEXyqGetMZHlC+ZAOL03KXJWek153?=
 =?us-ascii?Q?wuIWEcMF6GXf5FM44Q5/GGHs2iqfLa9vFa40BVAwc+aB9PLe3zV8T6zPahn6?=
 =?us-ascii?Q?o0n6+uiSZkkl7lVBtCb+jAmsR8NaE2XZISztiwtRkqhNKS8APksVDfw/kXp4?=
 =?us-ascii?Q?9gswcstuJBNhy/ZeQ9kDtpfqmMaM8YN0/eskZHhTrpUpGWcUqiSqWRcn+nYH?=
 =?us-ascii?Q?gTxLUwET62DvGeCwOsD2mIbvcAo/bu8bRjhDckVeopGNO21ejClr/MJoZVYW?=
 =?us-ascii?Q?VUH5EYMCmMXsFHIQXUGMBAkB7sYgynQZAbiS+Y91qUfv+jXdGiAzc6yahsCC?=
 =?us-ascii?Q?E7RtnyCcdrf5Nme7uHtASy+Na6cGasyJ+jDBKAlptglWfn2RX2wkLAPcTAaP?=
 =?us-ascii?Q?cOh5coxu/QYeMmfruxbiwHJ68Q5nv2u9pw8aq56t1HaFjtLsZjLF/aFsBDdt?=
 =?us-ascii?Q?28MtekesKavL5JQDgl10uLxbO3oUuter4ZkyYK/1Ac/j4EiLKbCrU5DzyNZz?=
 =?us-ascii?Q?/HMkpT39+1g77QcBtQp/slwFNKBsGfTQ7YLV70TZqr514ukxLt/f6Y31vx+m?=
 =?us-ascii?Q?Js4sR/AIQ9YdsnpFocomV6+Sqdf00Jk62LI8TP3feAux6D7RYpg6Rn2BYfGv?=
 =?us-ascii?Q?RX05qmTmrQb2FkaWp31jMzqhw8NzsAUv/bs1R+gDWi/2dKg6HbRvoPVas7CN?=
 =?us-ascii?Q?pkPQW2zzmlgxND6XaLTwcqhkc5TSAyah32MCx4RWrO/sUyJUy6m11Z9i8e7U?=
 =?us-ascii?Q?xDtBujhIThO9W4TBTi4ypp0vHtKOg7KlfUXILmLmSBEBITeLdjuFpe/JKBId?=
 =?us-ascii?Q?OZPqZKHOiiHF+3wC3DzOCn8/TeQnDK6apUK+/AhXw9JzlnAWh3X2oHoz8FSZ?=
 =?us-ascii?Q?tsAobT2PW862qWa95TNgH2tOuS6u6RDIhM3vhQ1KPWkFJQcYlfoDVqumGlos?=
 =?us-ascii?Q?Hmyzenv3R/VOzA1hq5Hk/5jqAmb7bSSM8tKogZg/2xnRJKdBfSr0Aqk434BI?=
 =?us-ascii?Q?ZLStZtQlpS5sKxEEMa/GGdcAgZrp7E21yjgvW6jfPfWEitMot0q5WUBbzMzx?=
 =?us-ascii?Q?InTQX1gEQka7E8g5wb+YUgp24RlTS/uP1tv+N6VkIdBcq6pP7175SkmphV4T?=
 =?us-ascii?Q?SyBL/3DzSr+JyAG8Oj06YIPo/1qmsiGlTmYm3KPerG143NTua6k5kgJLpW12?=
 =?us-ascii?Q?osa51eXaazJGp4mzvxDzLQS0FdDLcCLG0B4XKpzNyQi7IxGIHrgvWto6bsX9?=
 =?us-ascii?Q?JLejRgLnjhBeqtzfVuxJmVsHHBChJv4C33fBIKg0iyqgZII9GriAdkRfuDuj?=
 =?us-ascii?Q?hRo8zEqPnlVLajMApsBd6si+QW8NJbbRsyGtngMhwsGbEubjGlIll8lmgjsy?=
 =?us-ascii?Q?S9ay63a0B5fxW8VAvgvz97C2XXOAFTJe6FEQ81u+Z5xevRB8q7OWcjrkz4yC?=
 =?us-ascii?Q?esFtFYhJxTmPTdCpp6G1WzjlVB7m69nigt+uNqoIcz7ABxnXp9gKBGOxnPqD?=
 =?us-ascii?Q?nL5TSuylyjO++TbsO2GcVpZbF06Ti0Qq/9k7aKZh6vv1SiQ5vD08xXYl/MQf?=
 =?us-ascii?Q?DQbU31HvOR4S8YU3zerks2hCE8s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05fe8b3-045d-4f69-b5a6-08d9d1adc98a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 07:17:39.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztv496O/25zneboHbYfrqG9RFQTS7EgGEf4wCYnzWFTphiwYx1CAld6MK7pGOkZwgC/W9CJG/ZuqgRlQGa/TAQ43Ipv3vc3F/hrhRUlKX5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5554
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201070052
X-Proofpoint-ORIG-GUID: 5_I0n5Ydbfy7hgt3U1OVwtuWSbkb-X4g
X-Proofpoint-GUID: 5_I0n5Ydbfy7hgt3U1OVwtuWSbkb-X4g
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This copies a u16 into the high bits of an int, which works on a big
endian system but not on a little endian system.

Fixes: 09572fca7223 ("Bluetooth: hci_sock: Add support for BT_{SND,RCV}BUF")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/bluetooth/hci_sock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 446573a12571..33b3c0ffc339 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1911,7 +1911,8 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 			       sockptr_t optval, unsigned int len)
 {
 	struct sock *sk = sock->sk;
-	int err = 0, opt = 0;
+	int err = 0;
+	u16 opt;
 
 	BT_DBG("sk %p, opt %d", sk, optname);
 
@@ -1937,7 +1938,7 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 			goto done;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u16))) {
+		if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
 			err = -EFAULT;
 			break;
 		}
-- 
2.20.1

