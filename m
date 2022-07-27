Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EECC3F6B0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jul 2022 12:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiG0MJ0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jul 2022 08:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiG0MJY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jul 2022 08:09:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281B04B48A;
        Wed, 27 Jul 2022 05:09:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RAGpY3009181;
        Wed, 27 Jul 2022 12:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=/ygSdHhQ6rthyJ9vdZWG84DpBFEtsJ3AqVhJvhSohYg=;
 b=RN6QVwdIROrco0kqwGRLZDJBuD/KZktrIAcomURem59AkmjP7tM6lkoyscpCXyhGLqDA
 qyOZjYoYBt8pQaAT0ubrrqRgJ3jkE6aOsLF6C68ZpPghGPBAsvXNKcU6b1c31ValMuxY
 wBmKPMBYF3XUXYFyWUycOsI6AYlD1Y0hwGHnK99UBUe0BFisl2wM7WIijTNQHlJnE31i
 h9uGuFreKCdpSTGlGDXqoQFwY668Ke7i6dJ81X9n6xf0wWHLpJ8DDOe0v51tOWdJ8dWT
 XfXFGHhAnOXL6PRbjI97lMbmJyOrOl27XMBWufgit3EXq8iJLpqfwmb7Pmlvf3taKkJn 4Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9ap0ypv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 12:09:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26RAGLWQ016626;
        Wed, 27 Jul 2022 12:09:18 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh651uucs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 12:09:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjNIPRnmzdQv1QL9SK8gJe8SrzEzrR3kXbkkoCgJttQNLVwVdVKux440jdISzbKnTuHLzP3wE9N8s/2gCQLxED5LsXDEubJDE5K55Vtj9pVIomioFU++PpSu1w61Nn+LtgVTDDjr4Pua6PQ1HUS4e/QTSUbGJhmk3HWJkmFcetlxgavRStJiGsU0bo8Uh5OBxGSYzTkpauvnpcIH5bMGzuDanPMkil0pxFE0cfOeShy4uPnFy8FNfdxs5nHPDSSd1MhKUrCKLE46PvzFqAe4OZTr7MxLe75n3bwAZkK44GoZcTBQAi8H5OXxIxBLzLzpvo2rVlNrURjAd/0696DbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ygSdHhQ6rthyJ9vdZWG84DpBFEtsJ3AqVhJvhSohYg=;
 b=lwTpubcUq6A6C1Um/o9byXNgTFWGsgLZC4XlkjCfdNR3TfdYZT2cffUCT1YZ9Otim0WLrSNBLI7yQyZx+sYkuICCSvSGkaHPnkM2ECCzHL8HGv7ux9OsETdPmU/PXc9NLPPTMyOJqxa/gOik8nQGwRyLpY6m1n4M1MwT9wetNNdEcUk7wqwBK3x6SvKxRZ2+tdntLswq2iL0yYiDBOFXPoii6AkfYv5s3F6Pkpb0vcGiu/MSTijAVAzgJxvuhlzhCjzWINrzrWza8l6R9dVoVc453NvLud8LCUt7upGO+i7VtlNULRsNV+oCLifDXjnJkrjHJ2Z/12QeJPl7wBagag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ygSdHhQ6rthyJ9vdZWG84DpBFEtsJ3AqVhJvhSohYg=;
 b=Qsbgv13iC7Doz6PHXHiZvwDy5Pe/SpthtHDgqqbSbZHOI+IE8xpcRIjgzzayO+qrJ64cRAQ4RVKGOuJ+hIosXSmlvQBMY8XzQGULX7pMGrU1qk2LwqBMPfy5qyimB1N0ej6I3evZneGwTHLoZpgEFrjtGD1vE2rEbf8q2FdO9Vg=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by BN6PR1001MB2194.namprd10.prod.outlook.com
 (2603:10b6:405:35::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Wed, 27 Jul
 2022 12:09:05 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::eccc:6ecd:41f7:ed02]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::eccc:6ecd:41f7:ed02%5]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 12:09:05 +0000
Date:   Wed, 27 Jul 2022 15:08:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: ISO: unlock on error path in
 iso_sock_setsockopt()
Message-ID: <YuEq2Aey0VOrxPB+@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0177.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::11) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15e1f8b3-2b1f-49c6-378c-08da6fc8cd71
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2194:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5B6ctztmu0KRCgrIQ34+AsVxMJJsOhRy26RQzPQ3dup8xmWpeHKoDYQ4CYOfDB3hmWUmJ25Gv7DJqSKuIv2TOdnttAC9n2/q5yQ8eLiAvbfoCywiD+MG+kXR1PlwuICa+tR0ksgK/xZ3kmWQ6YXEcAirBLAkYLrhNEtXLLDmoYT2TkzVJLTIR39/OvGBDjhxbimdB8ElY8JdNEgjGSPAoQdNXB1z3kCg/NuhbKFWs+UKDCyLWQ2Srh3PBYjbdlaea/5NGjyTChPd7or+an6ttnT45cYsMUTVIxXzxZ/q33naqYz/uCpk0WU580f2w6vQOJIermf1z2653IY1EPloDEHJ36RVmV+UegFv7d/x+hUHeOBWwrYZhFJIsR/49uEWcjLSfXXcK6Iu5/BEkH4Taq08+XBY/sNNANFdbbgzhBAvRQnBZBfP4O4H2wh2ScRRNBtbvJ1dLgO8nYF9JNZyGbR7yzJAC94xzr2pwe30+Eia11CY70SQH2RN8gHiQ6ZrdFV45JImXeSViBE0UfBu4sZTqGIY/zusI8uk90fwoX+aS58Gsc8xidIGgLaisYjrPsuNteB82afkfzNicF35kAfNWQ4DG2SByeIrjZgycl1AXvxK0FORSx2WiY6N+K0shnVwc6Tdl5mCjvlZN+J6MmDNdoFe6oI9GLfLQo8hyG4EtWJxjAke95rvTJA8pgcFqV8753jPmXXvsUozhttVnzp83AAXrlEZodqnoAa1kC7oEIsohVeuMvcOs85QyPKMWQanEWuRBLQebBSmOvlN5pu9HuD7HE6dHqxFcVaJF/PGCKiqFh7Z9aCPVI12Rz3Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(346002)(39860400002)(136003)(396003)(41300700001)(5660300002)(8936002)(4326008)(86362001)(316002)(9686003)(478600001)(6666004)(6512007)(26005)(2906002)(6486002)(4744005)(6506007)(186003)(66946007)(33716001)(38100700002)(52116002)(83380400001)(66476007)(38350700002)(8676002)(66556008)(44832011)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UnLxBb4wqDqrswIuOo6DxJNwUqilOWu4Sb1caDO7kds2+nsoob0xXt1WTSwh?=
 =?us-ascii?Q?4ZJy+wUlvZyLNpD4FV5+LGz/jYS4ZnlkX/rjwWvwD+3rEkWSW1EUvbjiuhlJ?=
 =?us-ascii?Q?q8zA8cdnNBHLqs+t/c9jX0ZEBckCk07Pd7lRfHuNBdtCs1LgMOMFXBL3JPKC?=
 =?us-ascii?Q?UQFjk8XA43tzVV7GumvOhatI/4f6fngNT/jmEN0vLXaCHMo0a5kApfgICrmd?=
 =?us-ascii?Q?RtdXChGnIf9k6kcV+7ILWQ9KZYB75Rraz4yk5CGVVkSamtu1+Dcu2Me3MYnf?=
 =?us-ascii?Q?1+r7qJfJ4Q9DjIrAtXW4Iy0pJ9HaxmhdCtk24A0e77csTC+94ecbqOPj4lFE?=
 =?us-ascii?Q?BEqFTK195Gh6rULuHftJmPEJGsluLS8fFvlBcn4fI71xlhtehp7/zdktioqU?=
 =?us-ascii?Q?2MMEX8huey+t8rzQlk5qTJX4h5dYIHAZJD6x/avmcHR2Tb6GZAxm0V76n/5z?=
 =?us-ascii?Q?t0FNvdjU+c2PCgnpbux+Rnfhe04CHfptJJEMl9aT9TLs4JquQwpqmhM+a1M2?=
 =?us-ascii?Q?25pMiwJguErlm5rxlMV2jVMlfYrxnbxTaNchwYLyOni4Ug9Pw/NKhELRhKBc?=
 =?us-ascii?Q?sV93vAc30mjPv1MNwznQF2uXuyJJPB9azmmkr3Es3poJttwfRo/jpXnyjjuS?=
 =?us-ascii?Q?/ZX3T5TBMDwxMaWxAgGRTJ8G8oOxU6CFvVSIz/Srjwhie5AglASbpOPweJUA?=
 =?us-ascii?Q?Oak+1MkKMWroYlGGle/4Ql+gxk9PeEIVjvQgc20q5NJMiaLQhD6gyw1BDDdC?=
 =?us-ascii?Q?TPBHRhLxuwPc5UMb4H5yVbR7TwPfxATZkeXFfEUDB/vpcg0S4SGo7nOdkMCC?=
 =?us-ascii?Q?3DJKBhmBNJvomsxCu9doDmGYpnRAj40PwFqR7CpWP/HQFo0/hE88Ehpv6umx?=
 =?us-ascii?Q?Q2Es5D8XUHSLw6qQnShQhDqEtp5hYTaXO8r4qIDnaTczzqw7uHXonsMyMlZs?=
 =?us-ascii?Q?lr97J7Stcn6SKLMqWpE9tzkNjhBWy2QIseCNzEtryaEcBA/LZy/EXiYNw0sT?=
 =?us-ascii?Q?AqguFpiR6l4hFQmJvoqVEVk30KAZgqWgdarhAQ0qzEEaTr9NbfG5l3U+TPVQ?=
 =?us-ascii?Q?eMpOY+oqISaC+fAuXMb7WQc6ejqSZLnSY0DG+CkRib3iEnnu/mCgIV953NW8?=
 =?us-ascii?Q?9/LS/5MF/7S2AY04bTLhBGCMdBMHC/qjxiPToGR/trRAkHRzIBDSx/8pwmHC?=
 =?us-ascii?Q?Q7KZ/aHXWRaQNsq0BkDZ0nAPbXfBP4pPptbd4YOMzFCjMBdgInlJNZxe+nT6?=
 =?us-ascii?Q?4BciHYtKYdZkyVwVZpvPDIwwlryMpuaIkbZFs9/IfDdyo7biX1OWcsKjmU/p?=
 =?us-ascii?Q?5FurY/1KRv9evSmiN++DjA8EO436VKyKFDzAeo/dLF/nDmzL0tEuGJ3RW5J2?=
 =?us-ascii?Q?noGlyMJwC2kaQut39ty7+MHi9+AeD7qGHHaEZGsxJ3OqgyGcicC0uO1P198A?=
 =?us-ascii?Q?DowHTdU/UuWwFjfvNSUqLvXnFHa3wCrsWj2g8IUwAeI67LSC6uEYm79yDWKg?=
 =?us-ascii?Q?vy7HR9VobE2aeG4VIT4W8YZEb0r83Qa6OEcqS0MvSAyRTkGr+q74XwuUbOFI?=
 =?us-ascii?Q?gY0WVhDzSfcLN0b8qf0FyT4H5djbM8Lb9Lp4zGGfuoOWGOyixA1VC1YxoaWF?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e1f8b3-2b1f-49c6-378c-08da6fc8cd71
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 12:09:05.8644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DoOxJ0rgX5tmaHtSvoBIYWSmgUcHSAMtQK3BpTyJgkUTucjzmPUR9RNgi+9knJudi2lg95z1efE65yWOnSEpkrdzkg8vlS8rqapLfJOOuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2194
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_02,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207270050
X-Proofpoint-ORIG-GUID: _z4g82jdzQ7Mq4MTSoxCyZjMMoRgKd83
X-Proofpoint-GUID: _z4g82jdzQ7Mq4MTSoxCyZjMMoRgKd83
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Call release_sock(sk); before returning on this error path.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/bluetooth/iso.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index ff09c353e64e..19d003727b50 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1177,8 +1177,10 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 		}
 
 		len = min_t(unsigned int, sizeof(qos), optlen);
-		if (len != sizeof(qos))
-			return -EINVAL;
+		if (len != sizeof(qos)) {
+			err = -EINVAL;
+			break;
+		}
 
 		memset(&qos, 0, sizeof(qos));
 
-- 
2.35.1

