Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B23EC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jul 2022 11:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiGTLYH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jul 2022 07:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiGTLYG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jul 2022 07:24:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE6152FE9;
        Wed, 20 Jul 2022 04:24:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K9UkiZ003860;
        Wed, 20 Jul 2022 11:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=aGrZbjik/cqL8QYjpfcI+uRI974waPn4rEoB613Krwk=;
 b=I/4akUpoWopdlqGr7Rm6PHLAROiK5lgGueFoJrWxt1U1rCZnQ0K8WcUj1vY9Rc0AuU0r
 gtV/nGj0AVBEgAXbdmdD9a5V5BuZqMQFguwGiyFx6WkWa2RQe1/wf5UxU/kOmHKUZ4zY
 vTqMw9Xmjr3IGbMCiBbvVbVCs4SuyvqhfJfLVLKJrtT07e+N4Qxs9QRXEyGOTNgV1hx6
 BDb2kxXeFX8/ycwfILHIPXjIDULxv2cZUSnSMTbIm2THnSxnfjS+TC5g/ZtHMRNVJCgF
 noBXG9ZqlWflF6lXzTHjxRn1zrYIpkypJGuRlXUekqaHEWadR2Z2mgSeSNym+y/OK9cb Mw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs96ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 11:24:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K8rKHx022149;
        Wed, 20 Jul 2022 11:24:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hsqx00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 11:24:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWgc5OBwtcXttow3tcl738J633pzClmn3qV/YyEGi1JyDylaF2Nrd2ZrEh2mc8ROMwqdAlJx5EjYgxhz2Sbl8ZV8LIMsSdJlHkanUvfXb7tt0MMvY7laEWOPf0epdWPvOY1k5BpV6L6sgY/AK1LEjUPFicIzmzWIP3veqvV+LNyCVqYG4dAGNPbzVGseEQ3TmHmfqIaeTapJ4qkbt4e25VBvFcqook+vbXvS48BLYC7DBAIKNHzaNonI2ct0261ndVkGDxC0bjuq/BJnVE346gIGCGgNcP/XEL7kcBXtYHFv1hlflztDtfJ6AMhR1sG236sbfG2EHvPb9/A6J1/lxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGrZbjik/cqL8QYjpfcI+uRI974waPn4rEoB613Krwk=;
 b=odZFzaQz4KY8UyGQBriC5E1ayl83byyr74kvFG5oYyIGp+rBgfnYjCmuFLJ7WkdEFSMNZywZYVClQEFwQzcTX4hLa+AAGA76v7evR6v1nTd2Akq1enoSUdN+ngMyK0X4ioeYeGlI8381j+MDDgZfM6I9gjoj+JiTgj5dDTEebKIxzd7fOqoEuqqRucgJnVgKvdWXNgOlmN2L4JhqXnUed5xAqpNrh39l/lAk2AuGOEU+fqJbRO2aPIuWoA44ck7jajHzvc0EhgmWsq3MoAs5fimaSNDwc4dnNKeWUmJTpvyTDNHioXyDRIcRRa5t1692knmSojTvMvjNegzFBuV1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGrZbjik/cqL8QYjpfcI+uRI974waPn4rEoB613Krwk=;
 b=RtnykEhdMbRqo7GSHcER/aO4v4hKVBAxiDyaIyZbik/EHtj5x83X+DxVya1yIy4hcs4nG0njP/1sjboCM7u+GsV3Qo99txyuT4Y3wSrQpd2y3CilrJuNXE2Z/Ge2fVEGMKORsvw/wWDyJ6GFfbDeVWWD4Uh6OsWUfUMS0vllfX4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4151.namprd10.prod.outlook.com
 (2603:10b6:610:aa::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Wed, 20 Jul
 2022 11:23:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 11:23:58 +0000
Date:   Wed, 20 Jul 2022 14:23:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: clean up error pointer checking
Message-ID: <YtflxRosxskh2CoH@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45ebf124-4905-417d-e9fe-08da6a4256f6
X-MS-TrafficTypeDiagnostic: CH2PR10MB4151:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/T28E2kxm5RkpAoSuoTx2VYh9j543a+7M58fJbj3LUbX/QDnD+PLkUcOOwDWt0vC225Qgqt2dI+aQ7RR7hBISHch29QFrUe8GKnFdSp91I061kzC4Xcxg6CZA6ixzEU461fN9LYrsAZPUSbyPj4fTOKeS8KGhpirWtskpIP6zbD0veUabm29731StvuhrTf2xFDusu0dTPJ/aGz8s+AeVUZLXdhTcVd5RcQJRyV/YzAt91EYW0K6r+IOR388aENKjfC+smGYMxL8FPstkgC2lqrEwrEfqOMyYUEttxfj98Y3OPREIidi79oFTOnpHM2tQnT9ZXFzhXBQMjzRZc+hPAEic6xaAqDpK+jGeDnldjETFPfpVyYkw2BBvSl5GclMM2Z9heV0j8LHuDF0+NjlcLwKw8+pSix8yM5bSW8NdNGSwUyUMNDB1ZcbpS9vrs8Kn0XYOIAbGu8CCjOAO2L0n4VjY4wSdp+s1J7NyPZXywSyU9l33Qh+1sMfs37hm4CnOlUIUd0GrJHJj+Veo2nfYDGMRu0ytDzfpDnH4rFRJfYl3T7uc2Fr6zJ6SmlBSrF+Qn38yH1LOVvQIraPAOGDErcuzQrQiWdv0sq2ETKrMVPNdmTxpodP5BzMi48Pb8Prwv50VcZKmEvcDPBHHca7FWc3Vff4t2NfK5zpSHvV05rtFdoB7rKgNF5cL3aeC/jzXNPb0eGlQxKI/1m8bdtPL+aUDqSUG8KPhc4i2gujHsGWVcATzKUO+JEmXyUVrn8i1hq+NpJ0VIMjMWTYD/kr2OOE82CqiSKCALE1HIcY9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(396003)(39860400002)(366004)(136003)(376002)(4326008)(66476007)(66556008)(41300700001)(86362001)(38100700002)(478600001)(186003)(8936002)(6512007)(6486002)(6506007)(9686003)(52116002)(6666004)(5660300002)(44832011)(66946007)(316002)(26005)(4744005)(33716001)(8676002)(83380400001)(110136005)(2906002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/mBxFoaeM1cgMEKuyZfoRno8uuBuWJ8dTrBAxW5KeC0+eEDzxzfjjcOwoNiw?=
 =?us-ascii?Q?dvWup6CSndI4+P3U8ydcm/nCZRzAzJHKBY7+Ti+XFje0xim2a6e4vnyuczXS?=
 =?us-ascii?Q?EV96NE05cBxDF595+GDVJi9fyJh1bto5OoWbHPstEBEihvVI9Gm6+h5DFbFs?=
 =?us-ascii?Q?ymsDYRQ1UpbQYnk+s0Ket57p0URoATpLk64ex/bVAxqLHtsnn4PfHGTCkdpF?=
 =?us-ascii?Q?gf/QPmJlLpekNePmaaox3iJ+RPfHHC/9U8nytthykbVI6mv3su++BqzJ7qy5?=
 =?us-ascii?Q?KnD9vLh7IQcmjdtoii/I+M/U75h/Tb53ZctS09ScUpGsoa4CAYMjZEuDAl+i?=
 =?us-ascii?Q?yuoZqW/uS5dQI7uwoRpHR35eZOuWMJT4lMPIRzBwBry1A0C1pJqfCoA30dWb?=
 =?us-ascii?Q?sC1vjno+zcS7iKFuU1yCJlJv6X2OIOSpgGlsba3b369807692Fxg9S+ZFJEZ?=
 =?us-ascii?Q?6ZfYie/eSQQR+OycZaK6zvFASgSwDw12gdMDk6NetGZd51qUtGKX4dgYQ22H?=
 =?us-ascii?Q?wi2ed6tgK8mlIs5dLuvHZBXTlOEi5sheDH+LRSfCtZ+8Yey9n6FITKKqQc+o?=
 =?us-ascii?Q?F16PzPDm7J04oIwmt4wvHtU3cs48lyB75dH0QAWpIB6CmIL7JETsbe3rYem5?=
 =?us-ascii?Q?LUZxddkk39wyBUWjb4rdYRCZdpb0EoaThGzLpO1Hlkm++ImiVsl5XYIetX6L?=
 =?us-ascii?Q?VQrVBNdiMYAlQAw3kuAT2S+fobzgYucAznyvYwk+2vwK+pzCxTk7jbvvgtcc?=
 =?us-ascii?Q?msJdqkeqfj+592v9PPLxH5ezvKEv6ERdP6Lsh0kRV7coS2scJsHDCY8T4G4J?=
 =?us-ascii?Q?nR90W/PYRnz1ryn2X6RBJNjJBRGiQNlHJCT4Tiv3lFyDyYCt1RCrVtU4SYte?=
 =?us-ascii?Q?RB81nBL1y3yKzNascu4Mi0Sp7MR6PBj4xEPYeu65XpEKpTnS7Vp6N7hd+JAU?=
 =?us-ascii?Q?36eFX2tKru1nkQifyyYme230jppnha5nA6EvM0zN++W1gIF7rDp0klxlCa5S?=
 =?us-ascii?Q?ND2U1/3gyqYO/EzvaVt4lxljVeJrivqu1kMmvmV/agyVfTmFXrL64SlkmulI?=
 =?us-ascii?Q?1MY6JxzVOftI7vzsOUw3jjN3RLROvUsWfQWw2JDNp0q2RyH8Iq0U2kMu75Zt?=
 =?us-ascii?Q?XyDgM8vEm+iK6JHqoNLNVgEgUAxnaAnN78yAMj/KKczbrGFmP77JHL2JO6og?=
 =?us-ascii?Q?tvsO8MKXlljw9CLWfHWSambmJEd4nhF9S6VBSQo3wjt4xaWgMBLYfEsOvtJ6?=
 =?us-ascii?Q?VjK+cHz9+jeZ27j7LT7cKCB8FrH5injO7blDjMekTfRIcWuxcjfB3u7bkXZk?=
 =?us-ascii?Q?L5lA1Cw60J4+bpqXk81mXvUTwsm1avrnAX6ysp1lh2LgnhONqysRJUXYCwIP?=
 =?us-ascii?Q?KGWQAUcI7KDfDv0L34/oRh3OoC2+UqDFBWHhO7ptuYCjuAYnY3hDi7j13M/B?=
 =?us-ascii?Q?5o+wLLsnewTgquUnyn7SXuhHR8OxKxOOyYmpTbfIRoSIE1zMGAbsvnVn/psp?=
 =?us-ascii?Q?knMxtOqQKds4c8NF0UsZ/CbMYE6r3knxI5ShRzNjTSJTYCYRSq5ZQJid3tR3?=
 =?us-ascii?Q?LHjN7ienFRjaWEui756z7sjD6zXt1ue3Gm7XWh2ZZrTRAz0t6NzdA3qyd4k0?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ebf124-4905-417d-e9fe-08da6a4256f6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 11:23:58.7160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxMA57dPZPtovfIH6RU2Sg0Znf5dVExrPQfM4JNlHevCUwMtZXreVx2mVL+fJxmX34Ag4b8L/pLT5GOeHuflz5JRtXUp6nbYVh/TF2FKRmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_05,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200047
X-Proofpoint-GUID: DqTwAfOpENdrcOMrVW6aBs4JLU-GtONF
X-Proofpoint-ORIG-GUID: DqTwAfOpENdrcOMrVW6aBs4JLU-GtONF
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The bt_skb_sendmsg() function can't return NULL so there is no need to
check for that.  Several of these checks were removed previously but
this one was missed.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 include/net/bluetooth/bluetooth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 6b48d9e2aab9..a8b52175af05 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -494,7 +494,7 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
 	struct sk_buff *skb, **frag;
 
 	skb = bt_skb_sendmsg(sk, msg, len, mtu, headroom, tailroom);
-	if (IS_ERR_OR_NULL(skb))
+	if (IS_ERR(skb))
 		return skb;
 
 	len -= skb->len;
-- 
2.35.1

