Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A95FC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jan 2022 07:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiAGHRT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jan 2022 02:17:19 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41798 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231975AbiAGHRS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jan 2022 02:17:18 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2073M9LJ016699;
        Fri, 7 Jan 2022 07:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=3tPQa/MgGaloT30QkOBES+9mYSoK48BpUn8xndhyK/Y=;
 b=ViGaCSR6EJErvWGKYJ8c7n+P/Da1nyaI6tru3tTUaGgzF0yDRXX5mRTn2FYODmG2TvRm
 E+FsizhRcKSuadMqANNnQ7/0dYeNW4K9RTM29g8jSqOD46LrzTJ4HS3gNsxkjoQOpNpu
 MIi/TFfsgLC+Gcbtcqa/K9xc6+e42IZxDOJnl/A35vyZm54USjY81xZ1jyT1DEJfsoIY
 I610BstA0e6SyowzgJq2bCEADqZPOunl/m1RG314tLJQP4UIM4x75Ozq5sRKw0N6rS9a
 FcTKS4TEEkbZ5/t9nHW2j7CC6vPUQW01i+FvZ1c1mX66vNjM4mCmM8Y0+UqVsjCy57Oo hQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4v899kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 07:17:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2077FOUm099144;
        Fri, 7 Jan 2022 07:16:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3020.oracle.com with ESMTP id 3de4vn7r3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 07:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfW4LML2wSVrpNsz4taLK/jP6UJSyIj+b42dHKvyoPsm0+2HgVBeL+PHvf9xy0pgshFxP2ydZFqLEeGI7WI2qbY4KAhau18Rwy1UnFpeiGp9SE3Ll7UEbyLDnjvy6Ke2eLk0J3eJiVH4HqOuntnJf6nhIjACtGFnFy5Uu936sk6wwEr9iScxDkpmEkjQdmJRc/zksMCLEjaLRRIeuvQvJGBVzBldboY/LZh5ALBEGsnTatb+e9ur3wxlqSbv7hoNh+7BNTeDNQec69nA5pk2ttfJqRK0bEGAY5c9vsZq4C5LsTtoXMoAh22smGITgSjzrk6bTK258OCP5lmCuSodpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tPQa/MgGaloT30QkOBES+9mYSoK48BpUn8xndhyK/Y=;
 b=INOZTnKvZGC+k0NlrLWthEqXZeYzZ9g57d3JYSPyW6Imxpo9LyD6qvW+1CJjWR3Va79kZpvVBqnrD2I4jrpJchvhtvsEbEjVgazqubKKA824QJ6mMfKJy1wbF9nvprfe87bpgT1uANnlpDvftCPuGvk0E1VimT6cAxtJUYZMBQ+2Z/uLqyPqMYCgdYuQxOxZrg/gQp64cHRBZEv59ymFPMtmcMy54Snub0AFuuBwk33geNepZ/BSKxYgeofzBOIMq2mPfdIKaaepEnhjSIkJZIhOdfJQKYfPCPNXpRsDjJJnmAyq0AEZjlnt3wMHXIsT0xt5x5ON9bEMjvH+oeMMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tPQa/MgGaloT30QkOBES+9mYSoK48BpUn8xndhyK/Y=;
 b=nKh8/wXVAIXuCfcYO0IvuKtKzXDqTmbMA+Erz87faoxOMQS4dYXx2B6CPn6WJCwnAkO/bgGH2MOnCneVztWw8npom766KeutIZjxCDYscV4K7SMnAKApT1n9VGAtYmu35GSWqfljSgs5obUVqrG7lhOLiJ1bJafjaEXiyKU7VYU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1246.namprd10.prod.outlook.com
 (2603:10b6:301:5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Fri, 7 Jan
 2022 07:16:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 07:16:56 +0000
Date:   Fri, 7 Jan 2022 10:16:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>, hch@lst.de
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: uninitialized variables in
 l2cap_sock_setsockopt()
Message-ID: <20220107071644.GC22086@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0097.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1e223de-c3b9-40c6-a13e-08d9d1adb019
X-MS-TrafficTypeDiagnostic: MWHPR10MB1246:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1246E3C63E5B0CDF0DF9AF2E8E4D9@MWHPR10MB1246.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXQ3sNjbZ5owuInV47e091zDGKzKW67BfDzvEFE/4WZbsqOcWLwiUHCvwWaIed76gn9dF8THbkMUWfM0Sykuz4EtIHHigvOpN3BTcvdRDn0E0/9mBaaKXGDiTPmhcjv7FLERzNM7wLQNBUTNKF1LMbe+wCc3k7gjHByPX5Rdfh7r/DNmtThqLIdzah5bYXHTRjRtpZ6hUkVJO0flM+/5I1AWGOEk4DjJambCyFMi6A4791MdmH0ZwogpLkP+tZ9IgIrDRtHB52QXVZd3WX/AQMMbptWDP3F1oT5BYvPARqNw/jI2c/JEGRkSkM5WCOvWq1wueJrs0jTBjlSMqo1agMzgtUvHHuQKB/M02KNd4WH/SM/AnWWo7mtfBI2aM6bDP+ZNXd92yYw4wNy/z+t4h5s5JYuIwItneq8NT6bgZxz8nVte73dgTXnPJjVVYmzkC8sICqnr3jtOfvdL1yr4Vf3/yVqNb3wu03d7t38Jb77KWMpoYy3KdzfVZHSNrgF5UEyC8PblBMPrvfPO/1nEuE0X01LqF9qkYxN0M44byBJNe+snFVSrFjfP9cIDpyPeq5z4NorqPqvOTwum7lREwn4AHkCB0WTjOY0amELZpklEoWyYWs7vyyPhEjESZkm8MtG0c0xO9xX6QvFO0VV5gV62PTrXkygOOTidB16S3+X5DmGqSS/WZw8mUx85ZGvCn9vUzqhvIqAhx1Yp7xCajA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(4326008)(5660300002)(508600001)(33656002)(38350700002)(186003)(26005)(38100700002)(316002)(44832011)(33716001)(6666004)(2906002)(6486002)(8676002)(54906003)(66476007)(86362001)(66946007)(66556008)(8936002)(52116002)(9686003)(6512007)(83380400001)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w8zjELYz/2ZDS3VbwNg7qixz3FmVxGxcIaCREul8v5siG7eFafSxjAtusVz9?=
 =?us-ascii?Q?IuuDFR+EYWC1DxSn3wtaYCWXMD1HZRu2b+SLhPkieoX92jstjlWa3LfQ90qy?=
 =?us-ascii?Q?3J28uZfMgXKdPvDwYBjVavqZcRYljxJKJrM9z6inQVNEA+tV+p4vqTI6o4OV?=
 =?us-ascii?Q?5lNHFBdc/dCG02gR/ngqjwJZoz9sUtTuX0rlXuu7QUVB9KdGGNkL4tf4rLwp?=
 =?us-ascii?Q?63JWCrTRR2yqWWnrEOpUUn5jeAAMtRQvlnsuIEVKARdJqRPP54g4yPKdkXIU?=
 =?us-ascii?Q?v7y2G9362v9Wa4f6KC34z4p3LwvIwFCSH7I2L68e3EPqa9Y+RzHueUblqMlQ?=
 =?us-ascii?Q?GI+RVMD94ZPxh8NemBxcxXXi1mgYTANIskkPUMMBU7SCJiBfvZC3d56UfyOy?=
 =?us-ascii?Q?t7/N4x3X18RJUguE3TdMuZkBIaHWdLAwLaYCvAiFadOKyGpxTVzpqyqYOVII?=
 =?us-ascii?Q?sVK5+eLut2TsLC/ZbWUYiKwGxCNMtTEGGAq14UKFvFq1NneNnlYvXW7F2LNO?=
 =?us-ascii?Q?xlyAflsQ1+WbSOY/RdN980R0OOz6D1XPc3R8hVQbEcq7ZLQ6bvcUtPxTKUZr?=
 =?us-ascii?Q?gw0Zgz5HQaoQuWVb5kfsAUvrICXdwxUPcnq2fP8J6FHysLOEZX94O47hFkuW?=
 =?us-ascii?Q?8AFbOMkIN23okoZ9f5UQPYA0M4qQCGktUWSFHJPEnr5WG4mlOJmn1S1BcM4t?=
 =?us-ascii?Q?lz6FQj09WVa34whXBhbysXhoFc/yMJqMfUNHwGxblkIwHF5yRQyEgm1+VdhV?=
 =?us-ascii?Q?fmBSz3I0L17bzIvbxYeqeqvHxijStPgOdSy3NaLUwcFfyVPIdU21B9wZ81ms?=
 =?us-ascii?Q?whAFpzZg6Jt+FomUbxTPgLLFhJvpuGMBa1DTxALLKhs9Cs5NIHLiUYMTcLVq?=
 =?us-ascii?Q?PO1XmynJvneg+in+s1Svb5YnVkxoYytrwXxBZ52hu9Lz2Vew2lzl5QbA1MtJ?=
 =?us-ascii?Q?0xEkyXO/+1JkbZQXYtgZ03iTod0bH3PKZKqARXv/nSTOiHL79igbMax0tUrZ?=
 =?us-ascii?Q?c7ONOgiiGQUtUjJUopQszC/GMuDo5mKIIK2ocZ+pepBSAE7hkWF46+74fKGZ?=
 =?us-ascii?Q?0IusxIQ2Tkk5mJwma1MihZxThZZZJt1XOELpR2W8cNflXEGSXJ9pBj4t6UPM?=
 =?us-ascii?Q?MQUSmDnFd93JmESqb/SBgXqEZ3yHrqGz9l/bhuoVeblCX3BmtXwbY8PWiPb4?=
 =?us-ascii?Q?v83WIOKs7xBvlr11zigFzcJMzJup3MV5gXvnYRIJj7NIKLtIuJnk0tpNtavc?=
 =?us-ascii?Q?Ks3ngR2Kh/zxvUSEBb26MfBq3C1bsy+2z7gP7CknFpQ3ya0uq4GlReUWVtmz?=
 =?us-ascii?Q?Ajlrs4J6BJV4/BpnrvdEnuSarAWr4qjqRGElCmwwv0iKMaxT3SarGhHvNsZp?=
 =?us-ascii?Q?vIjSLusLyNZ4twJYlZkBCAP/buLvPeCAP3ml5Y/ga8fC4cQhESeF/HCj0/YL?=
 =?us-ascii?Q?lhkFw+cHqMhNogunr9begqONMtmy3NPDlNGRAP7RLWDuGY+mbnlWGTk7czvC?=
 =?us-ascii?Q?F+HK2C96TxeRrXE3LfN4n3dqBE2Izga+opf0kWwsPoUNc9sErY/cuT/n8fDS?=
 =?us-ascii?Q?wJY7/FyRlO/CTsNKxn896s704UtYgqaBIK12NSuHoK+EDQo5w30nm8cLOIVV?=
 =?us-ascii?Q?gQWy5YrV3BA8D4A3s3eMuK8BwUADrwoAkMrClmayoSWinPGJxLl4QD8uYV1i?=
 =?us-ascii?Q?wbzGtJ982ea92x1ow8Rne8se/Xw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e223de-c3b9-40c6-a13e-08d9d1adb019
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 07:16:56.6308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMVk0zjyoPp2Px61XhlukXl3kg1Y7IoSFVr8BvSmf/YJDnLbm0PH/JKViKSMtIqo53wjs4sfbC51XxKjUku4kib8I/PvbtMNdPWv9Jhw+s4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1246
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070052
X-Proofpoint-ORIG-GUID: yXsl7GTSynxxgCDrLMVjTqb5skZwxxaB
X-Proofpoint-GUID: yXsl7GTSynxxgCDrLMVjTqb5skZwxxaB
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The "opt" variable is a u32, but on some paths only the top bytes
were initialized and the others contained random stack data.

Fixes: a7b75c5a8c41 ("net: pass a sockptr_t into ->setsockopt")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/bluetooth/l2cap_sock.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 188e4d4813b0..ca8f07f3542b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -904,6 +904,8 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct l2cap_conn *conn;
 	int len, err = 0;
 	u32 opt;
+	u16 mtu;
+	u8 mode;
 
 	BT_DBG("sk %p", sk);
 
@@ -1086,16 +1088,16 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u16))) {
+		if (copy_from_sockptr(&mtu, optval, sizeof(u16))) {
 			err = -EFAULT;
 			break;
 		}
 
 		if (chan->mode == L2CAP_MODE_EXT_FLOWCTL &&
 		    sk->sk_state == BT_CONNECTED)
-			err = l2cap_chan_reconfigure(chan, opt);
+			err = l2cap_chan_reconfigure(chan, mtu);
 		else
-			chan->imtu = opt;
+			chan->imtu = mtu;
 
 		break;
 
@@ -1117,14 +1119,14 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u8))) {
+		if (copy_from_sockptr(&mode, optval, sizeof(u8))) {
 			err = -EFAULT;
 			break;
 		}
 
-		BT_DBG("opt %u", opt);
+		BT_DBG("mode %u", mode);
 
-		err = l2cap_set_mode(chan, opt);
+		err = l2cap_set_mode(chan, mode);
 		if (err)
 			break;
 
-- 
2.20.1

