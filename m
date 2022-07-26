Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31D6C00140
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jul 2022 15:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiGZPOF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jul 2022 11:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiGZPOC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jul 2022 11:14:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D902F3AF;
        Tue, 26 Jul 2022 08:14:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QEE66Y016870;
        Tue, 26 Jul 2022 15:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=ski0wcbGZe/Rm8mRD6ZJHwQqdcDzT3M9f//fa/wIPP8=;
 b=g0boW3pRERnx3OaYxxurZYaAAcWvgEZci3EJt0yvthwxvsx2gV/CvlVn+GSm9qanD+Xu
 XFaCJQ1dYoNUMzh6r2WEA+xsg5o65r4N6BqsdApkCvGJNp8HSDpuA843nhO+ztbLBaQK
 RgK9q/1mjeTP3qgBtpaBd3gnW0B1h1Y90lz7SoBMlnaNbcVA2Ei1u+dMvrcd3RlTUkPA
 G30dkvPtJB9rXaarpknvuB5BzSWD8KnOO0n5kKhPMjJnW7uv5HRYaV+a2l602Go10KtH
 ox5KKdHu1cqZwSPkGmeC16BaVF6AcS7SYubODbuIR+yyr2fdQLNqXYK/OPCq7UMDObp8 ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a4put7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 15:13:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26QFDsIt034538;
        Tue, 26 Jul 2022 15:13:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh632xqnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 15:13:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8wvEzzeaBOBQrOsQEvxIMV9VSdHMD/bKtc9QMMW4s8Lg4shoBrqbrLhF3mLEXw1NTEQQuaf7iWDaCvIPcneWJpl/jc0wtwmrIpgFI9eI7WX39Om4NNR5HdLvRhDpwmPSovQZWzUmJMRe6ABBr2D52ncUzrsEEJD/N0yWnLOamLk6UAphJjZXM86Ud6/l8WraIuaS7bdkHE9QIw10Dz5XBKH9n8uZ4dI4JFl9KOhG/web2CrmYJxKVnv4ZDPJoLqeXoGDA99/BHJ3F0nRKsVJVr3WTLc9Q7zknONM5GrAyvgyOb2kKSNMdPSFAU2e53d2acAvzARY6zPABq9vTBMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ski0wcbGZe/Rm8mRD6ZJHwQqdcDzT3M9f//fa/wIPP8=;
 b=hAKkS+LpJPgHBBXEF6EUwBB77NyYhH/IsjYpj6i/W7RWGtB0/nXOHXq2C3vWZ2U/0ZybCX5cOLaPvyg1wYHuV5iSVCX99U6CUBdFTOhtmsvmPldcYUMwyrFgIzNTyhUfhPWTNUzqcSiDPUatQ1gCwBSd1S3bVh38/n2n0ZCvC5DouMELri6yj69DeSgyr1AepOgmfaaIchBTGU1r8gMfjKG/QxTWJAt1XUKSjz5P1ecFaCZcqKGX4IwjGPHgnpOOO5lmCynGbIhILSHMS2CPXk1RY9hC7q7oCM9vNFxN46qHZXh3kwyi/GgqSyv0rf8tPlmRDFWSkKUDD9FTgYaLJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ski0wcbGZe/Rm8mRD6ZJHwQqdcDzT3M9f//fa/wIPP8=;
 b=ufpHSkBC4L4EDtdKcsguMIBq977TOOcn1+HBQSeCfsOy4jauzZN0LpJwSM1rmLS7Mho8gdtIpgJx0Qfco2a7V+r6rH12+q42tZth2ZWqp6zSu7bsKInNRx1AYozbbGY7x2AX9caJ2abeeIOey3PCRPJ/vS66kWyB7AXMf6u12PI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB4228.namprd10.prod.outlook.com
 (2603:10b6:a03:200::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 15:13:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 15:13:54 +0000
Date:   Tue, 26 Jul 2022 18:13:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Manish Mandlik <mmandlik@google.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Miao-chen Chou <mcchou@google.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: mgmt: Fix double free on error path
Message-ID: <YuAEqGGp/SRNP2Nr@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0123.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3466f567-aa00-4809-e604-08da6f19746b
X-MS-TrafficTypeDiagnostic: BY5PR10MB4228:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XCvno3s7cA1VQJfpTfbCbvRpXHFss4xEkFAeE1LNxSN1mdp4WBuWOnjdhpry69xWjgN6ttfJGc7V0IhELiRlFGsZEHR8smCN3KG/sj5EiY7Ti1x5oWM1gKdzgkZHD/Ep+L4pan1F10vKkCwtDwcgCJfAKdORcP/B68o5p2RpGi5l1O6QCQxAG3sqWQUf5fapahtYwrwOTKdnPBVmtlkZEYW+tm5qbo9p1+6iCKFeGHphkUxZsqk//GrGed3unj5X0jjnePPcAQEaxIvObaat1uB6Ydyc3AZWv4YIeMBFLTvLiXipBrzUz3APLwvmkxNEdu/wngKW7F4RiZshpVVIi5ZUaoyooys4m+w898QCm2ptk2C0rFD+SaFFAXdNPzE/Lqa4wVr+L2s+EuZJj+O/as77oi+H3i646r/2hhhm2dwwYoACjhFfnpkNHwPYrc7kdHj1/It7UNm5+2QRhiq90fVi581dZ7rIQgQ8AT8Dn41O2xLVEizGPXVhZmEXplQai8FQvx/WqhiCZEplaspsEAuOej5tEj19V6k0yxeNwZbjYIN2mRuBl9m0FkPAZPdYKUqAQ8hgCBqEz8d/AR3ee9yzGWWd0UtH4Q0G8DgMhR+TXc/naz6+R1JaidDopEMW2yQrMdNc0Kj1ihGlaygSeGonxAXwJy/Of4/YIGX++1mtdWf1hcMLo3D6Ns4RYg/kPXcTXMSyQmLRlHagFmXY+SBfBQ+VwTT1lFAUqY7FrMGtmXHHVu7P3kT+Lhovdn+fFHeTj0tnCZOAT1N5mnr8FDcrqaiWgs9eTPghOznseOE1twK+fEuEf6jB8lAoDf14
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(376002)(346002)(39860400002)(136003)(366004)(4326008)(8676002)(33716001)(6506007)(6666004)(66556008)(66946007)(66476007)(2906002)(5660300002)(6512007)(41300700001)(86362001)(8936002)(9686003)(478600001)(52116002)(26005)(6486002)(44832011)(83380400001)(4744005)(316002)(54906003)(110136005)(186003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OmSdUnuPipLfNyNG9c7i3r8Lr/eb6nPgHrv1w61nTS+XLjBbgmPT4ofwjeyc?=
 =?us-ascii?Q?wqnoEUGEGqMVGBkGic81FH4ziJIbGQFk//I7363xOX8eLLNJSSHSfzIWuj7X?=
 =?us-ascii?Q?AEUY92KFgf2ies+ncxyShJCqDX1gBPaHBBUvNUXwkgLyTbZy/WS5DWh/goFX?=
 =?us-ascii?Q?p4FK0Ls2QLiY8+QytgKEJwE/5Xi4AmOZqbl9/JMaYhXnzuAhrXeXUNaZArdG?=
 =?us-ascii?Q?x8YcndZKDjJ40qvgbJI2wGwfSvB8SdZRZKDpykPd4laoMYOFh/fImfPO8Gil?=
 =?us-ascii?Q?Kn0Tp5bfHRXFx14xQjmRqsKsCz8eCmkHb8+w0Ggt73BVrcND2nogyoJfNn08?=
 =?us-ascii?Q?GCGVPQ5zouXVNf3grqlX3JdjXG/euFRL+6qs5nsqxz4kdz7C2VucYz1vULKO?=
 =?us-ascii?Q?leg3ixj+f8Z9gcfOO9U1IDUjkEGExf60ToUe99rjuk24VlSuSmwJqoszVMSf?=
 =?us-ascii?Q?EOyjykGmiXtsdYqDQ43sH+kWta8cr1lEU7owv4H+V+Nzgb+Ne644UYnaaCUq?=
 =?us-ascii?Q?uLdrds98vPQYoWpce9EDk6KzyuZcCEU42zK7KmYLNLc3wq5p6dDOSqA9aNvH?=
 =?us-ascii?Q?Od3Wt/dQ/vTWupR3RZe/KVFDS0FsiNF3fZ8m/Du+ecLhe+KTHWQhO18Jv4/F?=
 =?us-ascii?Q?UpKttQ4gwoIipLyxBF9G1phL5jAZNWdDi4A/29gE/RiiWW5+ehtrVTDz+Con?=
 =?us-ascii?Q?cSuHflh7XtaS5djtyoNoxp7o4s9sQGYC+BVBl26BlZzdNQyybH97PyXCQy+a?=
 =?us-ascii?Q?JkpwBXQ5dbmv8Gmc0yLRI71MPFInPRRm+W1Dgw/gD/IhWKS4RTB6T/xcfpWD?=
 =?us-ascii?Q?qaR1l3Hq9F8iJPbYuzaqHaGgkqm0IxXEflUKrut0YJxfr0QKG0zWt2X4QeGw?=
 =?us-ascii?Q?pHRyzXEqIgrk8cs6OG9qPbKqw0+CO2vXPBTAJmlIfdPi9EB/aGWOlHHS1ZET?=
 =?us-ascii?Q?TeaOhNQ03Q7aJ/4PZnY56EqssDDsbWyS3FKnRtLQxcVH76KpAxE01yCJ3np+?=
 =?us-ascii?Q?bS21MKyzYa8xUytHfAvC3iFivg5z3b9ROtGfoEPWbN9KXsoSkXHb1xQ1WpoV?=
 =?us-ascii?Q?0yH9Tv4VWhZB9h3Ab4TotLhuax2F4U3Dv59Y6kQ9XsyeUWhOsqlx8n8Yo2s6?=
 =?us-ascii?Q?88lUnws2mq2pRweu6ZEKkgt2OEth40wwclNTMp0LKb469FxA51tPXGOtoi0I?=
 =?us-ascii?Q?amqtCxMdohcZHhkgdkse88EFoD1AOr2z01zRC7uS2BKELBgvRq3CFYIFwADb?=
 =?us-ascii?Q?nala7xOxyjgDVKW2gLqv1zx1XbDGFuMnldz1vybV1q98ec6P+/FPlP/3PIIE?=
 =?us-ascii?Q?SrkhEpxV1vHlOepcfTs6CVV2RWTOpOHsJkZ5jaKKFrHD4/VGzpHZJygL7MlW?=
 =?us-ascii?Q?RrhJQI+NsONnqA/gXW26qER7ILGa7uuV4wbBQnmGGUBfV2BhywBwqK8uBThr?=
 =?us-ascii?Q?himi6m+l6ZnIJpQY+lB2x7gBwu6GFLM9gprjf/3Jotqplm1HkaZ8MFEqoTaN?=
 =?us-ascii?Q?tamjQWPHuBKp2phOs27FRcH2Q/3wXOuieM+69BMFvruOVB9PAJs5XK3vkhA8?=
 =?us-ascii?Q?vWppDqM18XUIVpPhxtJC91oPocv3BN4O7tLrTrqWkb6/LWszbyHW0ksEWcNf?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3466f567-aa00-4809-e604-08da6f19746b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 15:13:54.5846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOifJB1drrmkPA+PvpyxXiGf+KnEWFw/SCP95pXr+tW68bpQBpvnaQWWiFnBvTB4UkocYlskON5ZtHOGalEKH43rhw2gSpK6loWuzMF1shw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207260059
X-Proofpoint-ORIG-GUID: G0d3vJJTeO_3Jd8Qukvuts2fAi6eSwrb
X-Proofpoint-GUID: G0d3vJJTeO_3Jd8Qukvuts2fAi6eSwrb
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Don't call mgmt_pending_remove() twice (double free).

Fixes: 6b88eff43704 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/bluetooth/mgmt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0c6878095709..2bca36b9f3a2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5056,7 +5056,6 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 		else
 			status = MGMT_STATUS_FAILED;
 
-		mgmt_pending_remove(cmd);
 		goto unlock;
 	}
 
-- 
2.35.1

