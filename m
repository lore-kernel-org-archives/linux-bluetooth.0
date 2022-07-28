Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1018C3F6B0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jul 2022 06:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiG1Glh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jul 2022 02:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiG1GlS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jul 2022 02:41:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFAF50728;
        Wed, 27 Jul 2022 23:41:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26S63ESc020281;
        Thu, 28 Jul 2022 06:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=isXttrPBhiaA6VO8zIXIDVzfyk2FNMWzZZQzBdRkNMs=;
 b=LrILFIni5IXpf+fmAAO2zIhPGjhV/Nt5xJOqK6wL/hWLstMnX/4yJLE65Z48jg9efULd
 PpyXZzb5PA1e4cWDhsuQ99IrzYKwpx2noEalTiJYzkA1n0jkV3VUwYrXUwAr2Q00FUr3
 dCGBakgBB1i4uWTFvvw4viMPRHOmBxfKbyRfXTaKhHb4GtUCgYNJrZ7dE7gGoAgoo6+S
 kqEY+/wavvhMWoWYgDZ87ECCuVvrguYkbHUczkbfpIOcb1Fb9+wtkCZxwhb+YYwtUZRm
 DFgEWg3s7UOKfGszDU5AJHlD7kNheOq8PB6rE04EXAQuTmDIg6rBZ2sDec/jGPM1EED3 rQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hsv3br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 06:41:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26S4TOF0034454;
        Thu, 28 Jul 2022 06:41:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh6357vnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 06:41:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2Ns+HRvxs39+z0DuKIfvYIy2JBU9DDyDtTjSI6k7B4e5iArfwmwlwrsiKEkszPDTA6sPfSVhze2UkaPB34Q9JZFCumF1DsMF8aT069fnYQQjZIhFutNnKHXtTInjRA9ZACdf5GEvu/lot8NAIQnP0kW7jKciOHtnMQjNlTDUfkSKXsXvlgWEihAYWMMMfbYnkCKi3m9cWNKElX4Rp023DflviqHyWLC75lH8LniZVjExQsO6AnfiW686fmAQUuTZUeYy5k0sY69gLzzce8JPYH9gipM48DhkDxJc9bL1VFneZ4L3bKDMMTZMZCgoII6y9nHkLdgz2yAS9qXPgP+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isXttrPBhiaA6VO8zIXIDVzfyk2FNMWzZZQzBdRkNMs=;
 b=L+P2RGVh7qhL8FRlg9iRZMJlp8+0hwVcfHct6fj5ZlUb/44HThU+6aDsXnUKYmzR6bW4HIb8Q5UCBivLXOHDCjW8rjw51wkwUoeiaplFVUeK0Bmcj6EmShgCv1b1/jkRqMm0xDEVr3IvQbkfh618hlM2DHKxiYDoSiCLhVVz8/PK9aK0o1rzZoTHM49s0OI8eKE4/LVdmumdyl1xIkQV89Cf3ySc6BS9AuMkKeoj4P+SyyuR3tHxiEbAWFySiOl6grjEVeN8AUUyuGCYMGX2x4cqgvDbjEKk5tAYpeQXOaZHsALI1v2/mFDp7vuU4Qq4AgRoKCqgepsTlpHR8wBTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isXttrPBhiaA6VO8zIXIDVzfyk2FNMWzZZQzBdRkNMs=;
 b=Zmp+pwIuLb1f3t0KGu4p8G9BD5vvoG+VUzHmQasO42jEJWiQVsa2dzGrb7YfWiv5q+1zJxB2etLlg2nscv9ZYCV3Kx+MmViGkblUwwe3BCV2tlK88JGRhmwfs/k0hJ7eWhiDLb0a6p2FcqGPSkXuVPkEttg2wl2NVzQcOCBXkWY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2558.namprd10.prod.outlook.com
 (2603:10b6:805:48::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 06:41:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 06:41:09 +0000
Date:   Thu, 28 Jul 2022 09:40:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: ISO: fix info leak in
 iso_sock_getsockopt()
Message-ID: <20220728064059.GS2338@kadam>
References: <YuEq2Aey0VOrxPB+@kili>
 <YuErMEjse5lgAMO3@kili>
 <CABBYNZ+bdU4sVjbQfOHtz5P7X+BkZj2DG6f3hNJzdjx+DSVtGw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZ+bdU4sVjbQfOHtz5P7X+BkZj2DG6f3hNJzdjx+DSVtGw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0216.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac860aa2-b325-4809-45fc-08da706427eb
X-MS-TrafficTypeDiagnostic: SN6PR10MB2558:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sp0fXXsgy6lUNZaJRmE3Aef5CBL4vE6Su6SUsTUK23B3KAt55+ZNhKST9YVScKqNvl5kEUQd+wveobqV8gFCL8ErxaS53aQLkEUS0Fwzu7wdb+PvUf4yapMzPDm9Mb3MFEGxnrH5I5Qb3nx41BKQlxfVZiuJwtRbR1r+Hg5h0V4ExIJ8OulVa63wgrNRN5ypaHy8C/JFC7ZsUK7ZhjFsrvEMmBACNdoiqTvMUdkXMuK3dBPgkWudOO6FGdZiJVgDEFg6lQVpNsjPFGJJE899D7H6oWA99Q9/9H+bKDi0nV2gelKbhVw1AQgYqFZKXM3J3gVMBFOqZHAL9dSEAq3BdgEKZaPGhr9oz+2qDhMvHTvmlyCYToi/8ef3JXNEbnge/gBNmUmTSKnUEQNd4NrN0BVP9Lh5I7pETnSa5uuTOqVtAZJqDwb2HQYLBTRV2VdptcLW8g3o6ITW7PJG4KtzrrxZHva7v7sIGHkS/UJ8J1MYW5bHYFT3mDa5NpVe9sWdh36YZ5KD4VvO6bGTVZiOdIkphAM6IfcOFRCa7z39PrLkzaY1Lj47P4sLPUx1mEN2obes5/7dEFuYw8q0M0Katfb7TWPhN33qhijOrDRXpR1JqL3w4tcf1u9QA5KE5Sg8qbsP+dH1GRYyXNdvVCm6Xg/d7GJkKYEgo6TEPkdC/zqSVFJv22ClXYrrDtRNMsJ9u+YcILdlqgQZF3IeO3xh6KBBeMWJc+Gip/0aeA54lqW0PXX6pJsCIbxG8Y13A+MnWLovy6QGVA0Swh3N5eStqQlOhS7bUS1aYVXMw0PjhYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(136003)(376002)(396003)(366004)(346002)(1076003)(83380400001)(316002)(38100700002)(38350700002)(6916009)(54906003)(186003)(9686003)(6506007)(2906002)(66476007)(8676002)(8936002)(66556008)(478600001)(4326008)(6512007)(44832011)(6486002)(6666004)(26005)(33716001)(66946007)(86362001)(5660300002)(52116002)(33656002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9jSzDn9BhmP6RN8RwH7fPpMJR34Ulwf/lI3ZQ2tpWDnH4a5B66tRCnjdeb1S?=
 =?us-ascii?Q?DMdC+aRLeUcUlladaPZ0PiOwOGFcHI1bheCp1N4yb+bG2lks7i5tV57alRW0?=
 =?us-ascii?Q?uerbBQ81zdgkAJ7bFhPkOfvAoFNF8QrFXiwO9jvmg6k0yK28mOCz2dbATxYf?=
 =?us-ascii?Q?37x5UKxcIu4FasSAlOgMfemls5rCpYyTtgoixiIuzbTLXOR19za78c1fKVPE?=
 =?us-ascii?Q?2+zNNUA6rcFDfc3kPZ2W5u62GFmxpoHKE8rchQnmNGEX3sBTh5f3vJg2I/gn?=
 =?us-ascii?Q?qtTUZJQywJA6HhGLD6m5gZ4cNzFFkdGXjg9rRMALkTVp3w7xSAWk3S2pVRDo?=
 =?us-ascii?Q?+iLt9pyOsjggLKqsLoK49kuXJZ9r7S8E+WIxmgmH5pP6BOLJ31CEUe3NBs7j?=
 =?us-ascii?Q?PB7L9bReNhrz8fnjGzL+vwqhH722VspPooBtt/vAmp3mYbsyFWQ/P7cal8TX?=
 =?us-ascii?Q?mhSe71Sng3ZoOTAqlxKlOugbvrwXxQkUGXZp5OeCyhutJhm/kAQgtFcXTk8f?=
 =?us-ascii?Q?6TN9F7zsgzTDV5Dg/i70TIK8R5OKWIH5jm05tzGiWAt2UbuL9B4KTQpJVpoz?=
 =?us-ascii?Q?+pHZuZTW5affWU9a9bBRcum6h7lpDFCYHDrOXeYCU51NYd1Gs1NcUe3NPSrH?=
 =?us-ascii?Q?QGGHpRwfdQfYjdNMHRS7mlwaI/WKALDKAl0y3KqA8b8qM4EaDmF9YlEMGypf?=
 =?us-ascii?Q?LNwYd7dT2AFVVXnKvH51QShAuYmVhASBmw6UxfN9as7HQDzuN2SdSGiD4dy2?=
 =?us-ascii?Q?HXOsKznFd8G+VEkxuvhI+qFpC3rNpzuoCbju3YfLpKWrRkW28g8BGTqWHDqL?=
 =?us-ascii?Q?ehvtUf/r8IFlvDMngWvidSF8lfmktGTb/PzoD8+8C+WmLsgXEh3Zs+L7DX/k?=
 =?us-ascii?Q?ycm76FQmpZzYC+aPpoUO/jtTsrkUc4AWay/h77wnFRD44c2tWciIGyzpZ6qb?=
 =?us-ascii?Q?JYvMZg4x3CLOZ9+bn0q+xVNgYEikEaanoSTju12xFdfHWtCIu8HnqzKWcbq/?=
 =?us-ascii?Q?ECFfiFbDLDbadL21KW72ydU/ghAVq+ymsWV+i7gNzhW38tRzlPr1lKAEHcsY?=
 =?us-ascii?Q?ymgnB3iXByPmsqY4LCNW280BEKs/JP9weuH/ZzSX4sqYId+ouoN+9ukXh5/M?=
 =?us-ascii?Q?PgKQEW1glIJgxNsaMYmQdGXBSJNi4qylw218swhqJs7dWJqhDlY4+mupnQ1U?=
 =?us-ascii?Q?eLiBUPoGVvHRt0dD5/ocErkspAZtj591Fije6zhg9Kxg5NykXQlmSwEEHLBF?=
 =?us-ascii?Q?j98FPZzy9uhUOmuz+XxJF/2vyJwFLS/sHFTS1aADjE3N21Byb15+EdSlvTsU?=
 =?us-ascii?Q?XxeTdMKZJCPQIZB0Mw1WcehABdhPwTPOrVkd9Rv3n9v6aycrhTrcOs/uuBds?=
 =?us-ascii?Q?6KBFicBovNu7oZLbq3F1noQEzCkeqwtPCMkvGkowmOZPpH9WmSXLodx7uzNV?=
 =?us-ascii?Q?64wgYT4rVd42f7BAkojh9CTZACK3AYMMGohOwl1gWcTbLFh0pqU3GWeUSW1w?=
 =?us-ascii?Q?Zbzq000lh1OdFkVzudOi+xMG1XfmqWocKENheq5bnF6ErbeONf70TbioM7gv?=
 =?us-ascii?Q?WD4BoGeYUwxrWWPxZcJHWQ3j2H23e9KVVRRXAVZa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac860aa2-b325-4809-45fc-08da706427eb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 06:41:09.7773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qAfkg8qY4EtZ8E0+nkRsPXKG63kI9D4dqXEbKwexbl+h6VRG8YtubtQPjBrq9uuw31YPsfIx96BpvQNdLniaa4y/wkuQJefNfoKItpKhgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_01,2022-07-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207280020
X-Proofpoint-ORIG-GUID: pqQVcMQgAlEgJr8YtI8OcKpFJ8quDr3u
X-Proofpoint-GUID: pqQVcMQgAlEgJr8YtI8OcKpFJ8quDr3u
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Jul 27, 2022 at 12:51:30PM -0700, Luiz Augusto von Dentz wrote:
> Interesting, did you get a report from static analyzer or something?

Yeah.  It's a Smatch check.  Unfortunately, it still complains after my
patch...  Which is frustrating because I thought I had fixed that.

> The variable gets assigned in the code below which has the exact same
> size thus I don't see how it would leave anything uninitialized:
> 
>         if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONNECT2)
>             qos = iso_pi(sk)->conn->hcon->iso_qos;
>         else
>             qos = iso_pi(sk)->qos;

It's the struct holes after ->in and ->out which are the issue.  When
you have an assignment like that, the compiler is allowed to do it as
a series of assignments:

	foo = bar;

becomes:

	foo.a = bar.a;
	foo.b = bar.b;
	foo.c = bar.c;

> 
> Well perhaps it would have been better to use a pointer though so we
> don't have to copy anything:

That works, and it's faster too.  Do you want to send that and give me
a Reported-by tag?  Otherwise I can.

> 
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index ff09c353e64e..0e4ec46ef273 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1233,7 +1233,7 @@ static int iso_sock_getsockopt(struct socket
> *sock, int level, int optname,
>  {
>         struct sock *sk = sock->sk;
>         int len, err = 0;
> -       struct bt_iso_qos qos;
> +       struct bt_iso_qos *qos;
>         u8 base_len;
>         u8 *base;
> 
> @@ -1259,12 +1259,12 @@ static int iso_sock_getsockopt(struct socket
> *sock, int level, int optname,
> 
>         case BT_ISO_QOS:
>                 if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONNECT2)
> -                       qos = iso_pi(sk)->conn->hcon->iso_qos;
> +                       qos = &iso_pi(sk)->conn->hcon->iso_qos;
>                 else
> -                       qos = iso_pi(sk)->qos;
> +                       qos = &iso_pi(sk)->qos;
> 
>                 len = min_t(unsigned int, len, sizeof(qos));
> -               if (copy_to_user(optval, (char *)&qos, len))
> +               if (copy_to_user(optval, (char *)qos, len))

No need to cast btw.

regards,
dan carpenter

