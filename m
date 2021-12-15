Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF97C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Dec 2021 11:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbhLOLrK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Dec 2021 06:47:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36262 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236897AbhLOLrJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Dec 2021 06:47:09 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFBSvDK009518;
        Wed, 15 Dec 2021 11:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=tLb7cu/bkpkSLE44XbrtyQSqEItxxM5rr/NtAQzh3qo=;
 b=VO5NZBu1WEPLyR4kpLGvH6v3Fn8eRMs8/IzUSk6QqN/HneYqsuT0Fsxp3dVg2DLany5X
 diZBRZJywMcwGoap9bOjjId7EiYAr1ZEdt8hE13YQZ4ngHS/S+K5LPEXwlDBnq96aHc6
 FyirnrxVfcQ0r/yf7AK77t8AHP9TaLJEivJS9v6TIQnlzzhfv1+c0oTErNHe9UovFwWo
 C9oif+iFtzuZzuJXZTzOZ54bgk0J2IpJ3Ea+w9x3RRr7rNclcey3nEgATryD21XUZFx8
 Rc+EXhqlM791fWw9shkr4UQ62qO56xFlugNVfbmvUOJKAUS0Xufc5+ykyV+RQ5Rh0Xe9 oA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3mrxpsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 11:47:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BFBfgdu193837;
        Wed, 15 Dec 2021 11:47:02 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by userp3020.oracle.com with ESMTP id 3cvnerqp5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 11:47:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPz0T+czms6JXxgPEGkW0EmPCQADXjvWD96FBuRe8fiIdG3parorVNJzq4s4EuhQ1jbGuqkw6wMzm4Ym5PwSj9GEVRCB1Vqz/J+ADiX7ZJpgLOd0ALBEKpKruSdPBj5i4Lo9hwRx02qiJx+w7C3Ted2BHk0o7hczMyIJ0+rnIkcAx9Q2bDM7/x2dfmaJGhi7T9qGzaDsnwV/JfA2wfMFlTWqqyqpiCbctESuD4eJG5KIbRh6aMOunquThzcXxAeODynNDRU+08ZvsPHFqFVAV0txwtEktDVKuTbxRyFfXaOd/q74pHGhLX69tMliIZ+bw3uhx8X3LvqMpscEikBghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLb7cu/bkpkSLE44XbrtyQSqEItxxM5rr/NtAQzh3qo=;
 b=dYLYJqqQyA0ukFRLBVJV4hscnLS1txEQ/YAI+i/OfKjCWyx1HtAcd5PXph3A3+pAwhHCs45sKCyZSA/avIvPw64BnZYg3vVU1BiK8ILUbLkLms8/IttCWFKM3MzHUQ5M2mVkx64BWTGtwOlphH98CD2I8o7Qii1yzg1F3Z/y8olgYlGoNDPeClfE0vXsVX2QZdCbfS+YVHhSSvpjfX20wkO4qP2yqqxp+kTLNZ+Ng8Fg3qmuXhhqujyYPuQm+UOw0c+bLcNv9Y+JBEK64UTceniltueiYWvH3RwdKPzPm6BzADiQ6vYCv/rxOH8q7rJoQ8y282X7I7yssSWNEUsyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLb7cu/bkpkSLE44XbrtyQSqEItxxM5rr/NtAQzh3qo=;
 b=JzPUEVzQCV6c4mRO92NQ4ZQlHTXN5bTDvvNmaKRMktaS54r21Yj50DEvG26mBrVQk2M6CkVdDVcPu5OymiTZ81ei4OXGz56H5lIlu3LTZxQ/XVU/aS2gg4CY7ODeEPeon4kraoY0CEKYzB+ZO7YxJUym1345h0V/X0Pbn7DyXX0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1664.namprd10.prod.outlook.com
 (2603:10b6:301:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Wed, 15 Dec
 2021 11:46:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 11:46:56 +0000
Date:   Wed, 15 Dec 2021 14:46:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: virtio_bt: fix an error code in probe()
Message-ID: <20211215114644.GC14552@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0062.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92f088c3-ad9a-49a5-97cf-08d9bfc09875
X-MS-TrafficTypeDiagnostic: MWHPR10MB1664:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1664E922A2CC60DDEA4AD3AA8E769@MWHPR10MB1664.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVhgZukjZ7nBuzKmTAr844KOtil/NZsYGdFDYGWhoId1ZMQzeeWT3p9UC10iXNHtsw2ZGce3k8lQcXGg/ZOM6eFkHY1lAb2T2ISuwCuUPBHdXj5aINfPe+vRfwtKkoQC6BiLGidFDi6zN+TSo8RiVep67SRQx14QrWEYVNPjPayLJuhScA7cJfNece8A6wkuF89dNWdvoJM5sq+cYTtk5AIzMCFPe55B2evUBp10IaFRkxHAmjjdThLAynBjiBQ+oV6BBpmvvjAsaISjfZKdLQYnp/sCpQ4RTV5OBkcBjeQRVS1rolWYv4w4WmJCSV5rtUifDnxNsOZTtxztQuHNyY25i3hpQRHpOaRDBbmN56NXapCDp3GhDvWpnStLCSBJsSJlUAKzr0bTBr0Sl/f2UtQxzP3hkulj+IlocbU9haUV9pR2n4cr4FJ1fBG8VzpZvTvOOyQFztsVuKJCyM556cljCHOpcg9lVdCfIo3ELCeq02HI8EyCwStXlE4BPuXnhUylvBm0/oU7qCrUHbodoTdVrhpVl+MmGhKH/ojS1mFVaV1QADOwKHrPQijTf4ZcZNQ7G0msH4s+/kPdXoKDDyqOYswdOrLgW7nj51xqIVnXuFxVhxdM2XThdVbaN6/Osg/C975EzhFyoxtdKQwqSLykKGqeZyUxi4x2qBQIHY7U149gssUR+yvGt4Z2aN1YtAcvo736HBoqnNZCD3egzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(38100700002)(6512007)(9686003)(4326008)(38350700002)(26005)(66946007)(6666004)(33716001)(44832011)(8676002)(66476007)(66556008)(5660300002)(86362001)(54906003)(1076003)(2906002)(110136005)(4744005)(8936002)(52116002)(83380400001)(508600001)(6506007)(6486002)(186003)(33656002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yu9MhNd0lrmpcgW+6frGbk02ZthyvA+p6Lhlmy02h2X+pHJcPWmIsARYfChm?=
 =?us-ascii?Q?HFDeqANEWxBaJvHBqu9FLcPzCxYeTUSGlRJ7/6YHkuYlyQcpzVOTebWRs0Kf?=
 =?us-ascii?Q?1yJ1MRuQrK1B3RJ3O9zWYzJULv+V7Kn2vq8RMfKgBABDrAI8DeH88awLhRZ6?=
 =?us-ascii?Q?4/7kScGNSLmibb4iQ7kDKHrqRLhuba7fWgs80IX0R+IAutT9Uhv6P77qfd4V?=
 =?us-ascii?Q?VrWsbwBAbe8x+b1Hysa3dw1tOusc1joK2tnVOC9Yns+8Z7cUjTf4GoSO/1TT?=
 =?us-ascii?Q?sOqG0WSPNvKAuQl9g2+ASY0SFXH6AlalnduR9EFtAT6uYEsoBOD0M5lhVcJ9?=
 =?us-ascii?Q?ZQj2gQIIZPV7XnOXU1IZBnU8gcFcwbt+JchOzK//YgeVN09w/tNqfRjGtKv5?=
 =?us-ascii?Q?+JkW7BbLHlWzc/6mosSQYiwSp/2Ny8pRHqoFTnfBRJQsPOFS5JSE1FpW36L8?=
 =?us-ascii?Q?rh/apH9zi2w6OnM57hlW4bONxefK8amsxMjeIwAXHQv7bZERgAHqeP7SgRxc?=
 =?us-ascii?Q?O/64UXl1R7Ix98x4EyKvp1wdF7CLG1/J6aktBYqDfSN7Y+YkbqmcPIO3crJ/?=
 =?us-ascii?Q?g8QuyhQJ3seOP0ut8MfXtrBMJQKpYW3TIHxe2GF+EhDsYo5Gfo2Yot69a3vg?=
 =?us-ascii?Q?ssDqLddMJTCXgr63jEmIz15Z6NQRHwIfO9TaurMp4g0jT29YtZnolNLbCjh5?=
 =?us-ascii?Q?gqusYsurKIZF8v+Gdh6kPfCG/im/ZahF49d8kX+yzAcI7O/aqVenyElv6EPR?=
 =?us-ascii?Q?6+QD7f8KoGDolPE1NzY23nbu+NVRCAMDLPIvnotcoYw8yVIzWK913Ql2e17A?=
 =?us-ascii?Q?pNOzzXbYMkQLiZrcY3cDtHgAbEEiN92J5J2xRN0XRfJAA6C1/xZJO2LKCaWf?=
 =?us-ascii?Q?W8nKg46L1ysjOFgoadPMSbpuLYH+zahdKR+8D4z+/Wdj260tWvUXo+A2ufFO?=
 =?us-ascii?Q?3+m2ReYLiyHzca+OpEEwxvPSmekxGddsbgic/rPpgjoYMnZm2UJn3/ClLIUn?=
 =?us-ascii?Q?PxD7NFMDQGk4ycXh1IxPveAKMPawes3FOUVxjRT+7O4fHdo0l20J9q+RjPe2?=
 =?us-ascii?Q?vjf41+xqVklEFApiSZ4We8beB9Ij9g9mJWWbQm8hCz1y46NC/8wbmQRGt+U6?=
 =?us-ascii?Q?+vfNNmhK80UuAm59ifRNkc+WZyvhVGvQNwaPbfze8UzAbwOHZ+ou9z3nD6K4?=
 =?us-ascii?Q?N6a7XrNRz21jl+tg14n9u5/Y71u4regeAu4vlvGlH8sPHGvnYiOVNp/THjz8?=
 =?us-ascii?Q?RC8xBuJQlxLoz67cJADvC9twlQeAo88PrtzjwOyFUdxZk4FxfK+byjWG9Ek4?=
 =?us-ascii?Q?JpqOvdnyOUHsVzOVNgNv42TVAC5jxorg3HcF2Fzxnp3gPDNCCtRBwYp4wXrY?=
 =?us-ascii?Q?7Hk+YlR4yqgDI1ySYBVuN1uOsb7mmEEinSQdNT+9k0CPRaVFyKyE3MlVX4Gm?=
 =?us-ascii?Q?U9z6SXUUc/dNtffIQdApkavka/eskTjR5dZugtAvUW5TtwS1k6nxGsN+AQn9?=
 =?us-ascii?Q?Q68w7nK+tsa1IbdwfgVMaDxBimbQrHM1vqo2qioUyWVoou0RPcX4QQHWMd8n?=
 =?us-ascii?Q?SWODZy0Vf4w7ToUPWIXjejzrFLkIPJ7PzCsGlVjwJoG3XWpG/dzf4+cK/fRK?=
 =?us-ascii?Q?m/DyNqloFyOoVkzSmna8R/hq276C3FMPBzw7kCsV8MKVlRRSJiHNVaHPJYtE?=
 =?us-ascii?Q?6sg4iXiTsNUi7jYRJCI0VT+3psY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f088c3-ad9a-49a5-97cf-08d9bfc09875
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 11:46:56.3094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucRLXEo+WTuO3VsY5Ub2DitZVOMY9pPxg1V7Xh4pzchEC0ox+B9EN04elhgFk2KuqsmcUxz7T6t778HRvcfxVVfwqeOB7kzvDtrxiE7GxJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1664
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10198 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150065
X-Proofpoint-ORIG-GUID: AOACT52M4x3BC3GJxZS4B32WE9FGRmzN
X-Proofpoint-GUID: AOACT52M4x3BC3GJxZS4B32WE9FGRmzN
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Return an error code if virtbt_open_vdev() fails.  Don't return success.

Fixes: 212a6e51a630 ("Bluetooth: virtio_bt: fix device removal")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---

This almost certainly goes through Michael's virt tree and not the
Bluetooth tree.

 drivers/bluetooth/virtio_bt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 1dd734aef87b..f6d699fed139 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -362,7 +362,8 @@ static int virtbt_probe(struct virtio_device *vdev)
 	}
 
 	virtio_device_ready(vdev);
-	if (virtbt_open_vdev(vbt))
+	err = virtbt_open_vdev(vbt);
+	if (err)
 		goto open_failed;
 
 	return 0;
-- 
2.20.1

