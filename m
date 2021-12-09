Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3701C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Dec 2021 15:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbhLIPMo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Dec 2021 10:12:44 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49860 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239231AbhLIPMk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Dec 2021 10:12:40 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9DuCTW006477;
        Thu, 9 Dec 2021 15:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=PiH5AgOkK+OsBcVIyTBJpAkkkKNFL8Fo65mfPFUg8ig=;
 b=Tv1IL8pXi3e+dH8Q/0sZ6mcjnKqmhfi26EsiOCTRJ6UqplWA6WkLuyH6GA8aNckogSxf
 ad7UEvaydsZZsyR3k2RonhoN+jxy0B7fQkfIJI0NVU8L6VRbbczf95hyeYZ+KMsp/gH2
 KryAHiUvPz31TM+bXJEm8yh3LrYO1Z3otztMmft0yq5Yk2BGSb+9BiTani0Ww0pPLpFf
 HQGnVt3Mty9P3N+oMbhwgm4vbbqz/RzGpMydsln9JC64R7mJs1D1pG2k+VfeJV4NepiD
 xaWAFNsSfYcczY9G3ZweTX1GmKGMrMAVbeSfYZELmV4VbuMEVP97MKqF1fQBdWZUJbSK aQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctua7k84n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 15:09:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B9F5UTe157616;
        Thu, 9 Dec 2021 15:09:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3030.oracle.com with ESMTP id 3csc4wb6mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 15:09:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhrkSYtT8cxONOOSek3TQ1sfq0YKhKylmNOKFFnvzvw6lmmxA8Y5UT5+GDVTLmK5OpS/rLGdPGTMqaREQyvPjIlFvsdxLGkL5VQBvRFKfI/c+vppcz9gJM1dzbEdXy5Tb0Ouh/QrV4AUN4yAukxt54MIas3A/WDB7kVXb4CtJlvELhjBiawsp1mTPvGzHBn5dcad56obUCUAQ9mhHW7rQLyAVuD7T4i4jOLSnLycA2pv48IPWVn2Cid/tSgk2xTFThCu19lYja90EFx/vhpEmpoUbY/H/Kk+IFp94smdegEphKAy0rrYVV7u96ZWGLrEdJRkR42Sc0XfzPGJuZSobA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiH5AgOkK+OsBcVIyTBJpAkkkKNFL8Fo65mfPFUg8ig=;
 b=l9GGmQus7LdH5pOBXlSzlCk5UIoVxGyywC7zSVQqv/GR2Sqg7uNh08CcNkY4nncNx3vdtzJ1XLtkN2nYv+a96UQQ6rnNQ8Um0Y9gSBVZochHxuMPENU3/psWm+foG7B0sMamA03zc0uQItxBKkgGlURsGwdU4UYLrpMkhZVViCYfKastREIt38vT8IZ3HnALWFfdV3bhKuSJbPyI3kdGXupm2TXarQkbluxRmbK/5mIeN2UH/IYIBY7me3ldoykomQBdntOirJFhiB22lLT0Sr3yjw6V+K2b4YF43NvUqGCZftBmcgNQkfB8DES/sfhn6ayXElm0Fg3ESx9aIlLR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiH5AgOkK+OsBcVIyTBJpAkkkKNFL8Fo65mfPFUg8ig=;
 b=S5RutNJUvs+fEDZR9vTDrOWy7RzY3u/MeywQnor3Gme+IDPU6XKxk9sYSTzmp0scr1rYAPpcjiaYmLugGpzobyDs7FbKHPSE4rJTrMaYAOwHN1AeHaYHyQulg843MZnK/XAD2GEpvh+d7BsiXQ7X3/sgKSxpPqZC8mAPmBZEhJY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5862.namprd10.prod.outlook.com
 (2603:10b6:303:18f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Thu, 9 Dec
 2021 15:09:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 15:09:01 +0000
Date:   Thu, 9 Dec 2021 18:08:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: mgmt: Introduce mgmt_alloc_skb and
 mgmt_send_event_skb
Message-ID: <20211209150851.GA14075@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO2P265CA0325.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::25) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (2a02:6900:8208:1848::11d1) by LO2P265CA0325.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a4::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Thu, 9 Dec 2021 15:08:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c002308d-511d-47de-6124-08d9bb25d4d7
X-MS-TrafficTypeDiagnostic: MW4PR10MB5862:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB58626EA19F21EEFEB65C73328E709@MW4PR10MB5862.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4f+A73jHcN6ED6FQ5ndJ8YM6I1njAy1jDCIqJaTj0QQaZOMXUZCDoZ+n0REDWEqYxJg/tHuwAYk6fUKWuTewDNE8niBTzngiWJNZm7WFXMB1YOsx7M3iusCcblieXaHoVMRG/L8bgp/DjREflKs1ANq2abwbVA8/zDVS3yFzXBYCOWj2oN0jQ+TWCPplXB7CJhIoBCWQ5ODioPuzc6pbJatfDbykOwBTQ0lfRTYYH56lPguYEmAb7kAWaFFCj1GHfDlsspCQgei2C73Gh1awCyQCEubcbJVs2rYYUK++OhxTKJFcPpb3LyaPSthNNXHhzjBpf5t7p1c9a2DvY3bniJJqk7SlmfudrCLNtnuqb+0P+4Hg/+J9xkBSlsCgSF+ZaqUAGC6tTGZlLK7lHZtzlRZj13khpxieVC69OhC4mGmNJsO1yRi+CeT5Metxq8HWjfGEavFJ4ujWX79Hxyp56a5C/cCvc1cPxms8eCedMxYG91hUau3zRamNX7mfT55pHdKm6Ceb5o2H1c4yOZ3VcOCv0K0Zev/bWPIVuKUIhioHw30xA05FyLVR0iZn25OERJaxhqCdL+R052awBudw8h6O/iuHwVg0sN9T1FV3wtyi+gWQtOdG3GkrkfF4AzGDPlFz0GEKOYMLpfMkL2loFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(5660300002)(66946007)(508600001)(66476007)(6666004)(38100700002)(44832011)(83380400001)(9576002)(8676002)(6916009)(33656002)(6496006)(86362001)(52116002)(33716001)(186003)(1076003)(2906002)(66556008)(8936002)(4744005)(9686003)(316002)(55016003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mdB/bmK5Lus2fF9IALwK8COIj1LAfDwraj41ojkJukfzRNI5ISy2PAPYlC8g?=
 =?us-ascii?Q?PIs04zKBTnkdB2HzFIZrLBQ8MZKgN5xj4hYaFnaeweDTtRxwH+Et10HWLq7q?=
 =?us-ascii?Q?GZ2rsupvlQjvWIqe+d95f1NMJjZvHZcBttqN12PHZuL2YigcgkL/IOjkoWDC?=
 =?us-ascii?Q?vzfOazLjHRTdHLopyy+/UQ52nJzFA7JZJaA5GUDgDSdai0xpiGspJy6Taw73?=
 =?us-ascii?Q?phNiIpdftbvO8ik9hqOoeAEXjd6p963r58I7y6Ey6PiQ4ZpQXMPCiAlT5pQD?=
 =?us-ascii?Q?YnbLTIgHHl3xSR+2wXN5WTCBMwCQO62ve6O8vudKR4FXbHrO9y67dYMhpPk9?=
 =?us-ascii?Q?Gb6UuwE5E/WBpvVvtvJPWTYCEa2C9CDL2SaLK4gglLAQ5q1o5ivB+7WunCJL?=
 =?us-ascii?Q?af4vPsfAsCACjMGNQH0hezwsYmsobGI6LrSvrY6VUSa+FLtbL0o6yNuXU914?=
 =?us-ascii?Q?OQi/Gx1+9Y3KFMyBqzIzaH4y1rq0eYChfr4J/5Q36eAtJC8x/3Yj88p95xkN?=
 =?us-ascii?Q?v/hhk8xA1C4DGfB8zGM2HzffdRTxhQZTCjVcUP7ok0z6iwqyJR8KM7fVSuIh?=
 =?us-ascii?Q?9rUy2gUkaZSy+RIotVK4YFEYsq/z/8RLa0PGtVxSiuh2T4bF7KntaMv+nj8S?=
 =?us-ascii?Q?N8NgCjMUwH6oKyyTIlC0pyS8JZfx8qVtiUcA1j6m8L9T20SvIQbABL8ChSyc?=
 =?us-ascii?Q?JUpwCnkOtDzSBsaQP7o3MW4UYocgdfPtVb/MGprarx/h+aceL6JibXuhFd+/?=
 =?us-ascii?Q?KFGfA/rUDhzV49d0Qc0krOmTpVwcCiVF6RK5YZ/rIhoPRnVwhmPJaZj2DHSh?=
 =?us-ascii?Q?0rs41xAA1s6zwRZqcK1UvlFGrJthQkXIg+qzgG2rSvyBdSUmFXJzAyMDH/pz?=
 =?us-ascii?Q?2V8vMnhjuaS2MVLKmUplF8g4Sh25W138vXi5FQTSO9Tapfkr+vUHzQfmkWVJ?=
 =?us-ascii?Q?XnngvpmE3HGLEt+3ScsTqShJ9yIznYVXBYGYT98zAufffxziLpCiwydS9SLW?=
 =?us-ascii?Q?rEUz7I4t36dO7fkeJgv+VSAQaZfI8Xqrpc8AoHiGQ++lvnyGkSR/15HWp+7j?=
 =?us-ascii?Q?iM+XYTBFanhFTrLObe6GZa+sKeyAVbMyjMtjxR/A/ossiiqTweIfqSzZ/Tva?=
 =?us-ascii?Q?gwz27aGgAUQlkHftJmK84DiwUTtF2T1+ZV2eQJsUoAz/B3tiWZPnQSL1gPeF?=
 =?us-ascii?Q?v0BB5ys87NKjAgvhuVr8yUnYRlB84uYV/3u6WHWsNIdZHTYFVb0PFMuuZCUI?=
 =?us-ascii?Q?+a2uRYsutTfN7sCzQF6+n02BiUEXRsw6ZQprypvd4usdSi9eQiq74CSPFLLl?=
 =?us-ascii?Q?RtWwAFnWfRD7SDcbpNlvC67RtENRm23EzrZnGyUy7kwGj1A8giZkRYsTfrJN?=
 =?us-ascii?Q?ZJdRsvbFAKgTsMlaaTqbnstfyAp7SRdD9XuwfWS7AEHsAplH6x9/Ypwrh80a?=
 =?us-ascii?Q?5DCZach7TS15U6YP240gDFqOHBGh6QvWAYhUdGsX+mSQfFudhNyvG1zmIBN+?=
 =?us-ascii?Q?dqeOkBGTGsln31o2vz67jCbFItZRVx2x7q3zf9ZsxebIf5RMtBovTzZdvQiz?=
 =?us-ascii?Q?s+SE1JPtQXUBx3h6TDB9mH3JxsvikIwuR8xwwwns/bMbq7WUHKPKXKWxXQYA?=
 =?us-ascii?Q?09N8H9U92K3RSZziCXYsxHaEKjT3y9/NT5MFKuWXfQFze/7L9TPUv0QgNIY0?=
 =?us-ascii?Q?uWf2YyO0LYZBau8le/JauOik3OmFqsTgSl7po5DY6OZxuVsa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c002308d-511d-47de-6124-08d9bb25d4d7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 15:09:01.0243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRrN6GZN7aVjqhzNNdHZ6dHKVz4DlYJPPs+XOkvpW9RuadB4hVzRR458fDqQqNfvGCXvALBFRIN3of0IsAu+kuUKnMiE93oXOcaxlCWyEKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5862
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090082
X-Proofpoint-ORIG-GUID: rNQHnGRrfCJKUwYivVlHmBbFLAUjFVeT
X-Proofpoint-GUID: rNQHnGRrfCJKUwYivVlHmBbFLAUjFVeT
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz Augusto von Dentz,

This is a semi-automatic email about new static checker warnings.

The patch 8aca46f91c42: "Bluetooth: mgmt: Introduce mgmt_alloc_skb
and mgmt_send_event_skb" from Dec 3, 2021, leads to the following
Smatch complaint:

    net/bluetooth/mgmt_util.c:82 mgmt_send_event_skb()
    warn: variable dereferenced before check 'skb' (see line 80)

net/bluetooth/mgmt_util.c
    79		struct mgmt_hdr *hdr;
    80		int len = skb->len;
                          ^^^^^^^^^
Dereference

    81	
    82		if (!skb)
                    ^^^^
Too late

    83			return -EINVAL;
    84	

regards,
dan carpenter
