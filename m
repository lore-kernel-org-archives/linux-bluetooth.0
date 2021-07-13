Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2D2C07E95
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 09:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C531A61158
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 09:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhGMJ44 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jul 2021 05:56:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20670 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235419AbhGMJ4z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jul 2021 05:56:55 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16D9pMEr013599;
        Tue, 13 Jul 2021 09:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=ey7IjHu2UfjXL5j2q1EFdE9C7WlL79fAySiQLL7jPKU=;
 b=No4e4SVR3M+ej9G4k7iIKiCUJrl2uXuKr99BJe5YvNuGhutXzEvUrFjvhv7XW/KVIMpc
 YAvLo/XJGWLV5Hc2ymWo3cFP9gJaeNmpa9a0qu1nivo/Za+GZLChQP7t2eJ40z9Zv6Wd
 S+EbA9g54mraXAsQeLpEm3/Lkcc9nkqOpzMePsl8HNtGwFG4JfMdOoabbFYcni+B1ZAb
 ZkWNP34oUNb6htrUWOlMXv42RQwfSSX8huLbBgXPvzP95rdy3KmhudvG1D3hiYTziYGA
 aOurzhSO8NKgkvisgbQYsiDGhpv45PRm6iGtjyl972wdkZillJDHhH+99F3WHlMdgMhM eQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39rnxdj5c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 09:54:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16D9orTB087173;
        Tue, 13 Jul 2021 09:54:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3020.oracle.com with ESMTP id 39qnaxe4un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 09:54:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcJYlpn+JyHYyDysO71VhOfsfRZ4Z255g+iYJiRgJQJjehiCf2+JwW5vRnfA5f3e96Aaw70FZK6EXNW9mrAXk6yrgW0XgkxTToo8p+sBU0KguA6KZNPA8dhg5+qzPMMnAs30gGqMXx9zfVVC2f20JysEJMBjwIh9XfEXku+srxBbznvi0AzUKAmJCivSk7u9mgnU1E6lLU38vU2pmJXsK6ygPEFD+zqZctvBg9JCoyhg//H29VY7+hNXpuyZ457MBdJVeFT4sjWMyRZL7tmFCVomoVau6UTrZlcXJEcknlQn87epuAXoOOyDZoxEMXiYvDiRw/Q6V1rXAiKdh2v+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ey7IjHu2UfjXL5j2q1EFdE9C7WlL79fAySiQLL7jPKU=;
 b=WcTrGGQC+ipABlmKtdcSJH314iRQoplB9RsGrnNQAlNWUSL79P+++cne968VDbsZr5lvjr6hJtMK0fcjjCp48D6iirvK0peJYYgqTs5mOdhfX+NqMF5FmpZtU4nA+hAD1YXoSvoJTfUM+1tEnRDzPwVLaRR+4N2RH85IJgIDcg3lo8Sm41ywQ6C0M9P41UamUNX3ytoutfsuVPrIrTzJgWOFnISWcm/hg4t98u6aBaqLgAEoOzMsFZqN6tQvYxpblayxvy2zTnQlPLF838pNI57iioEyZMNpTsT3IlbII6dM1w/zmOxvdluM3xNzxTMWvb3b0rQeTi9DZPeO420Tog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ey7IjHu2UfjXL5j2q1EFdE9C7WlL79fAySiQLL7jPKU=;
 b=d+HWB8Xj30HPGvihmjEMNyfq0/vaRYr7kYXNJIZSUaNuXwAGDc5BbfRhJmUb53UELgrHHFDvfMVKzfQY/QS/XTJImyaCXk6MrHgJpyU3tPTh7ws1yZToRnhJfOO6FyyU0eHuBPeRND6TAg5dxDcXvZcsPHE4uQyr/X7lUTFc+wg=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1293.namprd10.prod.outlook.com
 (2603:10b6:300:21::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Tue, 13 Jul
 2021 09:54:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 09:54:00 +0000
Date:   Tue, 13 Jul 2021 12:53:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     bjorn.andersson@linaro.org
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bug report] soc: qcom: smd: Transition client drivers from smd to
 rpmsg
Message-ID: <YO1irj8sHBvQ3QqH@mwanda>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: LO2P265CA0211.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::31) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mwanda (2a02:6900:8208:1848::16ae) by LO2P265CA0211.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Tue, 13 Jul 2021 09:53:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4029639f-6a04-4d54-dadc-08d945e423ab
X-MS-TrafficTypeDiagnostic: MWHPR10MB1293:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1293B8954197ED2C874CC53C8E149@MWHPR10MB1293.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDhLqKFOv7HOn1sRUuo/gUiTg9G5V/LgX457yvuQkzAhuNCyo82RyKFYtqeUfWO5smgmqSukUt8TcE1201MR00URbkmp+XaLC8QrRXH55PsAn2oYa1USBG5wHdLiKv4VdlJzbp09TXV2fbsyX3rt5xHbj2b7OwWqZmFUvJ2RY/LDXfEEpoDEcamwNEta5chGhuV+Plh0ManCELmNGyPLXE2kirxIWPk9Or/yp1wmixzJKYlnwu1t8/Ce0huN/31+cV3TIVTT0tnnu9zqprIxzRPno0lcsZ3dVt57ZHmV+JvoqHt4BjoMyroxfK4T69dor7HfoyKRKQLw8rCdO1hog9k+K3m4DGfTEbi3JivQVgo/rog+XoC2KAnxxxtTjmNcn2dCLj/1oJ/drNtXT64nQ1TKQJoC33wnLB4BZzwGn66jdwQnBe0kxgY9U+L3plmqKAKti1yRu7t/ppCnaH7++R4ed6BiK0jNzvSbLEuZCBm8KJt9sq9OV6B7BbQ4E/OEo79dX5hqfikrixJJA4a+079MbjoD/AF7I4EW5S2vSYsfsKKfWdXTl2IDgjFU3wXF20A0weY5qfz9WLcallvE49CP9UGTxy7UBpgYT4HYnA4rPPzNRwP3EJrUzQoiwDG63acbD1bSX6KKoIdEM/zKcZEcprEN2wB5E8FbRSipTZBJ9B4QfXsbXjiFj16MuQexRNdfFMEK/SIJY7FeKgn7rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(376002)(136003)(346002)(52116002)(9686003)(6496006)(6666004)(6916009)(33716001)(38100700002)(8676002)(2906002)(5660300002)(478600001)(8936002)(44832011)(9576002)(86362001)(66476007)(316002)(66556008)(83380400001)(186003)(66946007)(4326008)(55016002)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LC2RZvcwr43UNzCJCYuICXq+ATJZVByv/uE0A8i8Tg/dl2qwXCL3KRcpSOom?=
 =?us-ascii?Q?a4BBCspB2AVM8wGAr4QPVxRlJ3g9bafI0gV0drBxeKgCqKO+FzCj8aZVNdjf?=
 =?us-ascii?Q?RF082kcVuMShP+h9l1nIIatP40smFbAxRyyb41DiXSo9qer19D8enXEK5LzG?=
 =?us-ascii?Q?5vTNeC7PfADAA3HjuJAPTUO2RPhGYnxb8WXTk0f063IaPxrfLwmQ0D24a8Cm?=
 =?us-ascii?Q?5SehgjVNuFQc2VbDTKPsodtrTPTr4mnlWIZqwr1VGeQSjOg1ybzL3E9sixAk?=
 =?us-ascii?Q?UOHhfXAdbKHFEgulBqPjjuQb9E93NOfJsRD5rwloZqGij+fZdofxCC+r37I1?=
 =?us-ascii?Q?/rcYz/dcIro+bIVNSQSCs8n6SUCCrv+Xtgdnq7v9OHzIm4iVSgdzAKWddyCi?=
 =?us-ascii?Q?GimRaVkUV5tekwtjRXmsAQEdSlnppAYk1+/stRRHD8Zu2vEHC7u+0Ioh2h4p?=
 =?us-ascii?Q?Dqee0gs6Plby/GC3PV+z2ltFCVD9bemrWRxpivQUxC89y2M865s9kpGzd2f/?=
 =?us-ascii?Q?oPEL1siWsVepPfoHVVf0E/KJMoQqIBOdEL0gMxwGgtv1YSueuZQLBWeCaGLh?=
 =?us-ascii?Q?4l+3vaTBH+mosfdOIHMwCsM726jOWsq7AxA1TPVtQRKunzOCIMNu7IdZ//W5?=
 =?us-ascii?Q?SbBJmn+NB8gyw2qltckJloKO3XWxb2s1KstslZtIbjD303nGmephFyYum0oP?=
 =?us-ascii?Q?eZ4DmeCDUtnB1R1TqYfnuVCPpTsAheYoQzfXU1vyU4ybmcZB89KWbxUfIwPP?=
 =?us-ascii?Q?CEGmImcwOsT+cJ9kcl+TeVWajfcpjHneZu6rt/GH6Aa3wxEbuEsQrlgT2hdc?=
 =?us-ascii?Q?mUDMXwhpbtkDW4YCnnhGQ8beW1tlr7woAmfqbNqyp3Sc0BucY4uY2MtWZf2O?=
 =?us-ascii?Q?GSzPBc3bDHcoC5+F/SH2CXHU/k45B3pMXm3g5lrSvhryL/HYG9NQ6m9FtBA2?=
 =?us-ascii?Q?5ZMr0kXHVCRJWNtF9XzGKF56GqrtyLA2Ww9MHdtMjTmVRlMNhsTY0v5ZSwsh?=
 =?us-ascii?Q?9E4t6St5Uiy1iJuwo3ZbMTgoRbiZyuMmWgA801iTZt+4cBTLUdk3LL/yVZhW?=
 =?us-ascii?Q?RmZ8/ENm/rzd3MIsMKb3T0I9uepI0mim/j9aftpHq/YmvWuz7/F5KDQooMhc?=
 =?us-ascii?Q?sUTvxdG4UV8HpR2+zARmchljfJYAreyDahgDBH/SI9buts1LY8BPSlQyvZIt?=
 =?us-ascii?Q?5pMzfnowQ8AoS8g3AvpTejL903Eho5ERWoNW0qPALRm/0ACWB54w0LmJTG7B?=
 =?us-ascii?Q?CJkwAw+7xYtRm1nQkYaWC8qiXOEF4tgN9P9zuS3XqyussnJrki6Xa+nBftsa?=
 =?us-ascii?Q?ivFJuEE6ICCJ0I2+QEMAFD62asgaWIdOkBTaoOtuCZCE8+csJi9op8SjGADX?=
 =?us-ascii?Q?pz/uHu4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4029639f-6a04-4d54-dadc-08d945e423ab
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 09:54:00.4060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruVJYngTMAJOsfweM90vdgs36lUtYPGzn6vjxKsHie/ISiAOCRukvP1O+cgA1aS4+Vf+nIjpsXVgHBOJ7ylm4jMgGOZGsFIpMvjmskrIwjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1293
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10043 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=895 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107130062
X-Proofpoint-GUID: yNwh6rz8Hi_Nw37cKT4gK2AOoa8Fw8AZ
X-Proofpoint-ORIG-GUID: yNwh6rz8Hi_Nw37cKT4gK2AOoa8Fw8AZ
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Bjorn Andersson,

The patch 5052de8deff5: "soc: qcom: smd: Transition client drivers
from smd to rpmsg" from Mar 27, 2017, leads to the following static
checker warning:

	drivers/bluetooth/btqcomsmd.c:140 btqcomsmd_probe()
	warn: 'btq->acl_channel' is not an error pointer

drivers/bluetooth/btqcomsmd.c
   125  static int btqcomsmd_probe(struct platform_device *pdev)
   126  {
   127          struct btqcomsmd *btq;
   128          struct hci_dev *hdev;
   129          void *wcnss;
   130          int ret;
   131  
   132          btq = devm_kzalloc(&pdev->dev, sizeof(*btq), GFP_KERNEL);
   133          if (!btq)
   134                  return -ENOMEM;
   135  
   136          wcnss = dev_get_drvdata(pdev->dev.parent);
   137  
   138          btq->acl_channel = qcom_wcnss_open_channel(wcnss, "APPS_RIVA_BT_ACL",
   139                                                     btqcomsmd_acl_callback, btq);
   140          if (IS_ERR(btq->acl_channel))

The qcom_wcnss_open_channel() original returned error pointers on error
but now it returns NULL on error and error pointers if it is disabled in
the .config file.

   141                  return PTR_ERR(btq->acl_channel);
   142  
   143          btq->cmd_channel = qcom_wcnss_open_channel(wcnss, "APPS_RIVA_BT_CMD",
   144                                                     btqcomsmd_cmd_callback, btq);
   145          if (IS_ERR(btq->cmd_channel)) {
   146                  ret = PTR_ERR(btq->cmd_channel);
   147                  goto destroy_acl_channel;
   148          }
   149  

regards,
dan carpenter
