Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40E8C00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 13:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiHANGl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 09:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiHANGj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 09:06:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DD81C3
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 06:06:36 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271An4MG023352;
        Mon, 1 Aug 2022 13:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=UvkZ6E6j0TNFLgCxLuZmeqnr+KqxuYzn9u+tcwCRlEA=;
 b=zYNvP+GiHImjC7GvZPzqMjVRuKAEAAGPGrjhSfAyxvMGnK2mXwO1CBJvs1cX/ZtlWmWt
 3kxyxmbe1up5KwytZHi/j3wRcA+vp3vruiefcj2gUN0A9GVpR/IoFOiKXsrqnk+XOik3
 MW6lgI1vMZFhOVn1PJdU8SJ1FKwdKD2S1zRYz9nwkfo/MAIDZQP6AlA0JgkavzgC9g9G
 kq4Y+RkPnmo+qbN/nudXGpKznSo+hkbzsrFuL/OsLdY37/rtwAr+CMHx4Z8Y62Anuzho
 xQoZVYbYbQBf+2BJA1WnD4txSUaLWuguDue8KgcDZB+GsxBjC/a4rpjM+mlyUbPjgcm5 7A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmue2kkkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 13:06:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271CvUWc001101;
        Mon, 1 Aug 2022 13:06:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hp57q635k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 13:06:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMJ/p/62TDjQIoOm0FHUyb6qNGFOFxJMLNfnr+toJ/9mGFiMdEakIW3er1A6969mnXnIrzkkOpmggWxDVTmFSpZ5BEnvqUW8h0Q5r4NYUCs0bN43ADInJdnvb/9oJOI+DZBcfuITEaNoyielxqSVcjJkrz+YDJsKwk74+Pt88BmVXlgma3An1ayEzW7rPchfd0ZUXlmIJ8km8kgTV41wXAaWlENSzMH0c5Hxelh9F06HLuER1SRl3XML7u9WN4njpwVwBpDWsbPuGhLLUoX8ioympsSwAHSre37hi/nzDn0tZkeyKXi056Cn7RR8sWssMReBi6hGfcT3mvySIxzpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvkZ6E6j0TNFLgCxLuZmeqnr+KqxuYzn9u+tcwCRlEA=;
 b=IrQmSfKhC0x3ENEb7ppbtgF3nnQNshQ7hYNoKscoMm3hpSwOG//9+B9koEQvPHIUBVn0+5pBHGH8LBKPKwEhmIV72YUUCZ4pDIQVII4SWYrzJExaBn4ZEnkTb8WJkqPgHKlPr4RdWmegE76LbsH6hQ88WoAGWBVDXza58lGAUgKZwRClu7cdWb3UKDosC8tFheblO+n4z7C4Rx24AdLoJm/pCGuGtPkmu5viK6W2kBFj9XTxRX/fuPxfJ8X3Sxy7VoLCDsjCStKXcNWkH0LI1TWMWS9mJRhHtv+UHw5y5LmKnwGw/ffENV440ACeHD3TFMUme7ESF0LNFELBrCHkRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvkZ6E6j0TNFLgCxLuZmeqnr+KqxuYzn9u+tcwCRlEA=;
 b=z1GE4f8fOGWHwRTtgvDHd37Meg1nKcikb94wA3la7EkkdtsAqHvGNiMIaWcLg79vV6nQGNiWgqLpVY4egFtGJ/Ppi3sOUSjObzLodgGw9HT5a4okjtngkiMsVctQ/7GcLE1OWz6t9Mn1unMIHlxwxA2p8Hx4hzpPgrUzdnFWBaQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB3745.namprd10.prod.outlook.com
 (2603:10b6:a03:1b1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 13:06:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 13:06:31 +0000
Date:   Mon, 1 Aug 2022 16:06:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bug report] Bluetooth: L2CAP: Fix use-after-free caused by
 l2cap_chan_put
Message-ID: <YufPz/GTQ/fPzbTR@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0157.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78a8cfe5-b3e0-442c-93ba-08da73bea74a
X-MS-TrafficTypeDiagnostic: BY5PR10MB3745:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amEpem8xgKc3QcFeIRGPqNT8YEQ9b5+lmgX4iZthUL4b0tmiOFisUA6qREzwiNodrsntJMz5CM6thLp1sNHTfeCfRy8GppQ5BywNxPbEdoSjKupckFEyI5xuhkxvh6T7+Jb0wUJGHrsshMVtmvmjcFisU53QJaNbzxmdc14ytOFRLG8Hw0WaNZTjv32SKP+yK/lwxTdchVIIy1+IrLwPDSb5a1qEZPVvvbLae6k2xzqNBldV0bGZfjzXIQAOs5tsSwACJ5MroJSl5sSffuSIiC1S1xdyTBTzaz+iOHkOWuKVVfDsiwoxdRwIL0rYcZ+PfBBW7Tncf+tfRwi9ZHaGMtaol+H8gXBVLXEKuMyDYladhkgdaeFqJ5qomIGjY5u+//2NFxF8M21e3WZ1DoghqJBWplmtv2zVOkLuia0RBPvRgwbdrarvivCw2CDJ4DtFoNtWTDu9wZkVvZEFV5cfTqzBprO1wEPvTW9SoaX6wA/l/fAbLRGJVTJX/4QRm3Klaq6Ec9wYuKn40JZYZYZXJM14SBdlF8niAsWZsxT+E3DCCimWaUJF7eE21zL/Na+5oJPhveJ334ohe4J0ffmw4KUrRt4f7BJ6UayOmJyALSRItBiOiPtoSGoLNp/LW8ITqgtsXXU9Vd2bpb5Ukx9ROha+OgKN97vdtcknUkhOtsxBrkMdfYidvQ7z5I18PhoNctgYn9S1ic1VrsDqO/in97Gt5sLxs/0mNm5KKdZJBCLN7uIId+4KBGuVDqD6Bc6lvurZntk6Um4i8U2QC7lrxRVUnV4gW2OYIn0i8Q/xRhxxZNwNNyUB27l6Hi2wAp1s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(346002)(376002)(396003)(136003)(366004)(478600001)(86362001)(5660300002)(6486002)(83380400001)(186003)(6916009)(8936002)(316002)(66476007)(66556008)(26005)(9686003)(6512007)(4326008)(8676002)(6506007)(2906002)(33716001)(44832011)(6666004)(41300700001)(66946007)(52116002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?06HlS3ghtpHmB9Xa10oV7sAZN9E/U9k0xYH0ITmPqNwyiPoYK73oYdvoGiFF?=
 =?us-ascii?Q?0/RmRB9alySQlKNcC43n8KoLH6y0HGdfPaCGm1JFo0N241rOeagqY55a/ZXH?=
 =?us-ascii?Q?CE91BF+LrJZ9Bu3TtjTVNIYproCnueCXPErUh7EW0c4BCczj3INfydOYxPGr?=
 =?us-ascii?Q?8OD045kwqM7pBgy2M3e7VaC+Ni9/uYQHrrQgga2RWfL6/TaheogppSF3P2Dd?=
 =?us-ascii?Q?DECX3bVsqauaBOuXvMPOM/Fn9drBe8yCwp9b9pmzU+Ku9ON88MpewbNHzT6u?=
 =?us-ascii?Q?u9ef49OXTqxkcbxCK72khwjZsTVxRRPVFf6ABbqOk+ojYDEkFeHVII1AmM35?=
 =?us-ascii?Q?k0Nntw60ckZTDqO9N8YOclDo9sUwUUKDUImXSxYljv/hArYAF+rUJktvX/Lj?=
 =?us-ascii?Q?IwdEzTgWSR3yxRYY/Ra2nlbdsWNe2GDJ5rKJp7JEBJI6mrxWvTcozBRLqFoc?=
 =?us-ascii?Q?Ewku9ACYp9jgHPbZRQ92KRlULNEZ8b3OYGMFIj5vjoXwHsN7VbE/nTRorEPs?=
 =?us-ascii?Q?e6RTD74KcqLOhEpW++yAxvdva5IS6T9F9XG3ahBzBzD1ETwIfUf6xcTkqR/N?=
 =?us-ascii?Q?XHNOYLbWJlHfj9Dx0dQgvvccI09umPwr5zzdGxHjgmxSm/n9B/++YdKgFDaS?=
 =?us-ascii?Q?NELLewqqNVJ1Qz3HdodYsseDJSnNgF3jEoG+zSy2L9jQR7RzXRv75gVGgDF0?=
 =?us-ascii?Q?FxCqNWyS7pIvWV1mLqWX+HmqoE8MwiIZyGT9yQTrgz7SV6XP0zSP5M46R9Uk?=
 =?us-ascii?Q?qq6syzDTjYOkVmXgswupq+/nMInqtGX0UYhl9Ui4GaRAYbRJ8u6XSZg63sx1?=
 =?us-ascii?Q?XtYEucf2cf25ojOXyfsD667LezhIJqMs/ZCSDcC7U/c0WGP+ax85Z0K92AUs?=
 =?us-ascii?Q?B5THbphLhm1J25hZIrNGfDq3eSLqmpGOKYf1vjYiNfNxYQLbE3+hNNS8pJAa?=
 =?us-ascii?Q?KBFNycZZ1RDmwfdWhSsjTZpQEobhAGIPikeu7P/mqyZ3JIchQ2rCo7nN+x/v?=
 =?us-ascii?Q?EXfn4veeToVaQ21A0qfbXcLwonje7Jv/ksSNEChtkMLxhG61CL8o6Fic6hZD?=
 =?us-ascii?Q?sDKKki0CXq3RJdz+0IEgiSlhVhN+qgtFFqpCpOkaIniJS+Lnoo4Vure4yB5F?=
 =?us-ascii?Q?kG+6gjJY2L6+f7M+MBCKklFppIayTmzwe+FTT/6bUdA1tGi2cmaggLQ9cn8k?=
 =?us-ascii?Q?PE4eGPlnQQSkt30EBCT4Ury2HzFAPu1qMEOjVjVaGJRBpJbwNezHHyurcuPp?=
 =?us-ascii?Q?43UfuZ+uhDkYDL/CePL9bU3Y2jlZ0ogWvHnMegG9BMMex/wXAabX0mtZFPWi?=
 =?us-ascii?Q?ko2HUl48B+UUEwU9goxYoKGGOoaGhO4WNRyxjcF/3VG+c3z/U9QolVZftlz6?=
 =?us-ascii?Q?R9GOqjtX5sVHxp5ywJaq2SEa5IYYqBpjm7o4vc1cvl6nnbGe18QuBdyQhpdi?=
 =?us-ascii?Q?XQ0JYFBSHAmCxgqr+dKautfMg4N3D5DT/FtwyQQ9r0lvDw8hIhneqOG0vMUm?=
 =?us-ascii?Q?5S9GQXkR0HnFiDP/vbOlGSCYEdeCWAgCt6+LO9m3cmMD7Re9bpfGBMMLrsLO?=
 =?us-ascii?Q?lUFa+zbOiLkCamL98GHbrISoJ2Hc/sG0CrKwd6dHVWUCGQab3fi3lbWlinev?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a8cfe5-b3e0-442c-93ba-08da73bea74a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 13:06:31.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5yG/URF91eVJ26g7Aa8sfXCTN8la/VomVHDGEtl8GQ02Yjlrfqmg1RNWoLJ1rCCplFjOqOE6+QYKme+cg8ZCoWI6krdQTmCviEcmST4leo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_07,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=773
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010065
X-Proofpoint-ORIG-GUID: ZuBpfmH952Hnf2XtFaDkQMzPVG-nlAtd
X-Proofpoint-GUID: ZuBpfmH952Hnf2XtFaDkQMzPVG-nlAtd
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Luiz Augusto von Dentz,

The patch d0be8347c623: "Bluetooth: L2CAP: Fix use-after-free caused
by l2cap_chan_put" from Jul 21, 2022, leads to the following Smatch
static checker warning:

	net/bluetooth/l2cap_core.c:1977 l2cap_global_chan_by_psm()
	error: we previously assumed 'c' could be null (see line 1996)

net/bluetooth/l2cap_core.c
    1968 static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
    1969                                                    bdaddr_t *src,
    1970                                                    bdaddr_t *dst,
    1971                                                    u8 link_type)
    1972 {
    1973         struct l2cap_chan *c, *c1 = NULL;
    1974 
    1975         read_lock(&chan_list_lock);
    1976 
--> 1977         list_for_each_entry(c, &chan_list, global_l) {
    1978                 if (state && c->state != state)
    1979                         continue;
    1980 
    1981                 if (link_type == ACL_LINK && c->src_type != BDADDR_BREDR)
    1982                         continue;
    1983 
    1984                 if (link_type == LE_LINK && c->src_type == BDADDR_BREDR)
    1985                         continue;
    1986 
    1987                 if (c->psm == psm) {
    1988                         int src_match, dst_match;
    1989                         int src_any, dst_any;
    1990 
    1991                         /* Exact match. */
    1992                         src_match = !bacmp(&c->src, src);
    1993                         dst_match = !bacmp(&c->dst, dst);
    1994                         if (src_match && dst_match) {
    1995                                 c = l2cap_chan_hold_unless_zero(c);
    1996                                 if (!c)
    1997                                         continue;

If "c" is NULL then this will crash on the continue statement.  Should
it be list_for_each_entry_safe()?

    1998 
    1999                                 read_unlock(&chan_list_lock);
    2000                                 return c;
    2001                         }
    2002 
    2003                         /* Closest match */
    2004                         src_any = !bacmp(&c->src, BDADDR_ANY);
    2005                         dst_any = !bacmp(&c->dst, BDADDR_ANY);
    2006                         if ((src_match && dst_any) || (src_any && dst_match) ||
    2007                             (src_any && dst_any))
    2008                                 c1 = c;
    2009                 }
    2010         }
    2011 
    2012         if (c1)
    2013                 c1 = l2cap_chan_hold_unless_zero(c1);
    2014 
    2015         read_unlock(&chan_list_lock);
    2016 
    2017         return c1;
    2018 }

regards,
dan carpenter
