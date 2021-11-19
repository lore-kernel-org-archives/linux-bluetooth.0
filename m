Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA122C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 14:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C129761AD0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 14:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbhKSObb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:31:31 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10656 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235888AbhKSObb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 09:31:31 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AJE7GN0010830;
        Fri, 19 Nov 2021 14:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=axETmiGNj4S21AjLoOfrkXURvnSLwKniuFE+w2IEt2A=;
 b=1CY05i2i6L3DOk+1WpQWCZF6jZc5YpUBF/3c2gi6j/01mhFZRwdxNrLp5cN32b+wAKly
 CPuIec+zBHzrDjIa78HAZKtLjIFPwnY+VVEDA1cXbouNiNknoFMpBhpgSk62GEqRQdU8
 htNtSzIvHpoxJt8IVnczIcJthgcB2h8xpA7ZOgj95HBddawkefpoPKclcuhAaJ0DXiyZ
 Fm0MHs6ESnKCK2CmaycYT2PbBwzG40JxgTXgAMiv6al2yHNIhhTDvwLSHkfmXPIylsBu
 S5WnSzdjtrpWkA2wneDFbpPjWFB0UieUhrmzpDhbfpng+t6wCGPqjwv8YlMIeMVeoKoa tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd382qxkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 14:28:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AJEGnrr051142;
        Fri, 19 Nov 2021 14:28:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 3ca56aah6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 14:28:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WavmykKXzNGp8o6KvY0MhjPf7+08taKQF+GDjbkNfvYmyL9nqI0a8E58WoA85uCtSDXtWJ1JYr5RVciy57aK6mbDQtxOc/gGry21Rb6qwBJNJSpKmAZUhJHYiXeZVOL7QmMr2AqcWIj2eCkpinQFt2xzY1gr9Z13Fb52hcfUEtRlmosndAEzFmMJFZP1JE/h6ib565DrVqgafzwKDzyWur6wO7ue+IyUMCHFXY2XKLIZRqasEgcTWfqFT4rBt4oGMWCl/pYj3IP3IacL1eKP9WXoZyvLQxXGXj36SQehykJ4d1Kk+ZTPG2lXKFAm9ltbb8uwnDSD9pYTwO8X6RHR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axETmiGNj4S21AjLoOfrkXURvnSLwKniuFE+w2IEt2A=;
 b=SfCLA/BafnVi+uHP/Mx7ZNfEqcsbT1sfjzY4dXxqLb5xtTC64O0WB76C2H+tfWRlFDz1NmR59s/uhx2g2vg30bum6wI0kbwp07jzczVBgNIDAEWQhZ+nI5kMZwZlF15Iiu3ZMnq8Z5AWBMkl2GadcbyzcIR0Adxd31jza/5Lb3pULRC7qhtHOOmgtAco8EtNK7P7vCE707B9HncMwiayMuf1viIv/eGz3+OsLtWvWxsTEmmolNLD6pxhhBV/JJUb/BDxJNijIjajl+qaNAsxK0FklgPxGZR+pSE4QqTRQw5qwikzqL54TvXwtojc1LrkCTey4l0CFcZkZLtXSSScBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axETmiGNj4S21AjLoOfrkXURvnSLwKniuFE+w2IEt2A=;
 b=WroIJ1EWD326LeHu+HP1rK8BROF6cx+72YFrtquNWl7x91yEMF3uRVstGrptoapu1Pu4uN9baWV9ECOPd950GTTnDzc/J2Kf24r44OhaO63rtWfaZWJzwe7Xmu7RUYaKND5heVqkOOKUv7y88UALr/342xilY9b0BXMmFciBfkU=
Received: from BN6PR1001MB2354.namprd10.prod.outlook.com
 (2603:10b6:405:31::21) by BN6PR1001MB2291.namprd10.prod.outlook.com
 (2603:10b6:405:31::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Fri, 19 Nov
 2021 14:28:20 +0000
Received: from BN6PR1001MB2354.namprd10.prod.outlook.com
 ([fe80::d5cf:764c:ca9c:b21d]) by BN6PR1001MB2354.namprd10.prod.outlook.com
 ([fe80::d5cf:764c:ca9c:b21d%5]) with mapi id 15.20.4690.027; Fri, 19 Nov 2021
 14:28:18 +0000
Date:   Fri, 19 Nov 2021 17:27:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Kiran K <kiran.k@intel.com>,
        linux-bluetooth@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: Re: [PATCH v3 08/13] Bluetooth: Implement MSFT avdtp open command
Message-ID: <202111190204.lssqaO96-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115064914.2345-8-kiran.k@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0133.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::25) To BN6PR1001MB2354.namprd10.prod.outlook.com
 (2603:10b6:405:31::21)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by MR2P264CA0133.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:30::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 14:28:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d3670f8-ca9e-423a-4d10-08d9ab68cc51
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2291:
X-Microsoft-Antispam-PRVS: <BN6PR1001MB2291751434D022800B2D30D48E9C9@BN6PR1001MB2291.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WdPiE1dNaOYDvWGJhvXiKjNuKtcIhXUJT8DWEioTH0VgWiFIhhflrE+j548qD7b5cmW67gMflRgE7oitBUR/rCPAgtG3n513yk9oHwReXfPI0cl+MRdFTnG7l8aDov56du91iEab4CaIdND4CDun+7Lg9aXFAUP6t04vEBIfT+XdFxfWHWKnERnB4Q1JyjgchPasH/svxgxOMEBpEAIo8czXLRyr0Si2VttOudVsdlpdOsEo93dCsLwpjFI2ptf+CaKusNyfL/TV94XtpHBLttVvIRgGbn1C5loPOkr3t0BvwCOHfdV/epldQ0Yiyy5k34L+XIczwDMjJrPS3riZKxAtvKWE0cyX7jniO7b7oeBuc0FAdGkOwy214THC1qMrYLudJ1zSU8FEZkqT54mseb++4e26GhODm6TaeI0dmpWJ9ZD3ECxuytkXdeMBee4BK744qobboh2oOXwRL4W+UWgg8DEj2zbmUXIfQe6KanJJp0x1Hi86CAH2OLOZI+vd4vQ5JGOexYflgBG+1aGun9MmmGcqjI9zdSEJrmbZw9jcckMB0wgm9ZbFBdH1hDP1WgSsSk1fTxnRqPGgtXX+h9T/RJeiuaDmvud9Y1kKGbXMDP0vZTx/FdeUBOgFxjx89rQtwOJ8qKqh6O3jxwXmUutRVef1pD/i5h8jM+z1P4vYzwYf1Htrv6QDCx6lQAANmUFBRnh3hVKD7Mq7NSueg4U9SyKdhZIxYq4J0OozQla57KgQR2/CXOWj8hUc2sNG4SSOfzdWQnPR6j0uw42U/TyMG3gFJd+IxRVLYCR1snl5gM9+48rsSx3+QEn5F8xLz6kB+oCrZMSR/IYnobGGNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1001MB2354.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(966005)(44832011)(4326008)(52116002)(6486002)(9686003)(83380400001)(38100700002)(6666004)(38350700002)(4001150100001)(66946007)(508600001)(26005)(956004)(66556008)(86362001)(316002)(8676002)(36756003)(1076003)(8936002)(66476007)(186003)(6496006)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C/cLIZQkRksTSRbtPzcGtqxKOkOMtm4EQQvaeRY4MeZmV/d+8ICT1tfwLhB8?=
 =?us-ascii?Q?vxIooJiJiFbcDQUL6h3wRsnvHd9hunFfvSh9v29ViGeYfiUMapvJZvhEXvG+?=
 =?us-ascii?Q?JSr8JeD/SkOdJ8yRJc6DfgV7e4c7Tf6qxV6nWfHcilWajjq2pI7j+viF48k/?=
 =?us-ascii?Q?LgQaY6FJ7d7ntGKPZrmhVoarkaLVfg/l8Omfcc+DIHPd2i29gga8VPR0+xpd?=
 =?us-ascii?Q?7u8CxtXamoUZV3KnijQRCSGQ9POmo0P9lItpA3VSz5Xn+PRodus5XuF6FrQi?=
 =?us-ascii?Q?5m3aT1rhAj5F28NK5OILS1GplAtPYSxSlJxGsG6nF3/WeyCsq0gEm7kWtUkn?=
 =?us-ascii?Q?u4IySrtb3Wt+Rni3TtaCSJNyaOt7xp6tf3d2Uh3ICptd6hjVaXmNJzGVyogn?=
 =?us-ascii?Q?aCDW698SlhsbAStSJ85w7OsxK/vTJM1tg+/FHrsL4eoNIUmkn8n3lpL12f/R?=
 =?us-ascii?Q?udFpPssLC0qXhW8KNxngsl6IZwEFTqkyLedS+MXEkPDpyOgZ6TICF7WM/ofW?=
 =?us-ascii?Q?CamMJitcVkB3bbz8MN/wmxbH5eWdauJDnlnYWrOVX1nZ7k5CG42akHiFvL7e?=
 =?us-ascii?Q?01wb+srfXid6vMfKIUMct4mWWyk4ZWLQ4r81WDDEFX4muQH8AyUTPMvbpECy?=
 =?us-ascii?Q?CJIuGAXibJ+ddBiPPwgrSqTkP4Umgsdb+rtI+nrlD16zrb/5L0XD+oH3V5+u?=
 =?us-ascii?Q?BQgSUI4TBqz+fMDsq+rAQxDxGApCYq8VN7k/2qIO4gFcmaAiyKc06MRrncbT?=
 =?us-ascii?Q?Fu6US1w5RD8grt0BL0B649gisoHGewS3hdelBC//vjJyoM1z9MDsqGZneddV?=
 =?us-ascii?Q?yrlocx8I++I6uEM6BQW+Naop3CIgidtcUfbjDX1dtEPbZ9Cc09rUmDq4AfHi?=
 =?us-ascii?Q?4r+ywkEGo5t/yayHk/UzNewM6ijoO7vHMF+NzPvM0P9YhZ9cMpMDXmnkGSD+?=
 =?us-ascii?Q?ZzpxIvVTkvrFtZObPXg2sQWqS1tJcYuPGyTP/L2gdBtXk97n9fsO2tMXiNGr?=
 =?us-ascii?Q?AjuLRkqtr92a/GCl3d1vGCQtQmaO2/jHbinQk6k9+mpbNSZiKUACmlESAUNc?=
 =?us-ascii?Q?DYEHthHRm/o1Yi+tKCQk+W0/snu1tygDXAXTQ7ipQjhnMGFXh19IpS/rTHEv?=
 =?us-ascii?Q?zgwrDoa6r8xgUvOtMb2GpeD1bDu+xgEb5s1TKwwx7/0U/8HfIulpn4UxbafL?=
 =?us-ascii?Q?QWTKX9sEO14b5+zfZ/PCsPxCPQPtraQVytS37qp00MccspJRt+nAfAD4wB2+?=
 =?us-ascii?Q?GQ6vO/ikeN5uuCZ1NWrbGJemBn3ELBCDFociFUH2t4DGB+eKocTsTwsIttUu?=
 =?us-ascii?Q?H/sr/Zzj7072/WZwgpjGrjc3pmJxzz7AoNmDKI27Re8G/wjYgkzddoFKmmm5?=
 =?us-ascii?Q?W/Fy3YbBWXgcRuJhDXMnYA2uAdtsRtES4h9y/u3Mw4WJL8wBghkIRwR5tmkX?=
 =?us-ascii?Q?xpxPrUbcLt2vLCU4dX62P5dF/jK7+VHULBFYR6mGxPUVSCTAUXRmiEbZWZk4?=
 =?us-ascii?Q?MMXSJl4VX5EoJwvQKnXm+x1HoUA61H0g1emv3XeyU+gGvqIv2hetDNlxGjcw?=
 =?us-ascii?Q?KXrHOi5D1UyYUcBHCKF6bI2vlsAe9YAPKYUtp6GGtsgkuSFeWPqDrAQZvjL2?=
 =?us-ascii?Q?4Y4G6GuNT8RVgKN1i+iHLp8BRDJhU+RKVC+AvtwJoZmWGoUH/9/IhsqS4Mv1?=
 =?us-ascii?Q?4b2rC93s/oQCcrI3BYtvFiyHrBs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3670f8-ca9e-423a-4d10-08d9ab68cc51
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1001MB2354.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 14:28:18.5692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9asYY3TFECztorBi8QnS5HDIvPaJCvFCjI+Re8FONH3YaWOYUZ2+nNIjPolId1KwkU4+9q+lGMeujpzUC4PO52XFIXMXuOh9NuPduw+8Hqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2291
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111190080
X-Proofpoint-ORIG-GUID: qDaHj8LFHE8M4LYOEntHuMYdQe7msE2R
X-Proofpoint-GUID: qDaHj8LFHE8M4LYOEntHuMYdQe7msE2R
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

url:    https://github.com/0day-ci/linux/commits/Kiran-K/Bluetooth-Refactor-code-to-read-supported-codecs-in-getsockopt/20211115-144640
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: i386-randconfig-m021-20211115 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
net/bluetooth/hci_codec.c:388 hci_configure_msft_avdtp_open() warn: is 'cmd + 1' large enough for 'struct hci_media_service_caps'? s32min

Old smatch warnings:
net/bluetooth/hci_codec.c:399 hci_configure_msft_avdtp_open() error: uninitialized symbol 'err'.

vim +388 net/bluetooth/hci_codec.c

d9396dc909768b Kiran K 2021-11-15  359  int hci_configure_msft_avdtp_open(struct hci_dev *hdev, struct l2cap_chan *chan,
d9396dc909768b Kiran K 2021-11-15  360  				  sockptr_t optval, int optlen)
d9396dc909768b Kiran K 2021-11-15  361  {
d9396dc909768b Kiran K 2021-11-15  362  	struct msft_cp_avdtp_open *cmd = NULL;
d9396dc909768b Kiran K 2021-11-15  363  	struct hci_media_service_caps *caps;
d9396dc909768b Kiran K 2021-11-15  364  	int err;
d9396dc909768b Kiran K 2021-11-15  365  
d9396dc909768b Kiran K 2021-11-15  366  	if (!optlen || optlen < sizeof(*caps)) {

The kbuild-bot doesn't use cross function analysis so it doesn't know
how this function is called.  This check doesn't prevent negative values
of "optlen" and the "!optlen" condition is not required.  Of course,
making "optlen" into an unsigned value changes it from a "negatives are
not handled" warning into a "integer overflows are not handled" warning.

One idea would be to just make sure this is called with valid values and
ignore the warning.  It probably should be disabled globally if you
don't have the cross function database.  Another idea would be to
write this as:

	if (optlen < 0 || optlen < sizeof(*caps)) {

Negatives don't really cause a problem though because copy_from_user()
has a check for that added in commit 6d13de1489b6 ("uaccess: disallow >
INT_MAX copy sizes").

regards,
dan carpenter

d9396dc909768b Kiran K 2021-11-15  367  		err = -EINVAL;
d9396dc909768b Kiran K 2021-11-15  368  		goto fail;
d9396dc909768b Kiran K 2021-11-15  369  	}
d9396dc909768b Kiran K 2021-11-15  370  
d9396dc909768b Kiran K 2021-11-15  371  	cmd = kzalloc(sizeof(*cmd) + optlen, GFP_KERNEL);
d9396dc909768b Kiran K 2021-11-15  372  	if (!cmd) {
d9396dc909768b Kiran K 2021-11-15  373  		err = -ENOMEM;
d9396dc909768b Kiran K 2021-11-15  374  		goto fail;
d9396dc909768b Kiran K 2021-11-15  375  	}
d9396dc909768b Kiran K 2021-11-15  376  
d9396dc909768b Kiran K 2021-11-15  377  	cmd->sub_opcode = HCI_MSFT_AVDTP_OPEN;
d9396dc909768b Kiran K 2021-11-15  378  	cmd->handle = __cpu_to_le16(chan->conn->hcon->handle);
d9396dc909768b Kiran K 2021-11-15  379  	cmd->dcid = cpu_to_le16(chan->dcid);
d9396dc909768b Kiran K 2021-11-15  380  	cmd->omtu = cpu_to_le16(chan->omtu);
d9396dc909768b Kiran K 2021-11-15  381  	caps = (void *)(cmd + 1);
d9396dc909768b Kiran K 2021-11-15  382  
d9396dc909768b Kiran K 2021-11-15  383  	if (copy_from_sockptr(caps, optval, optlen)) {
d9396dc909768b Kiran K 2021-11-15  384  		err = -EFAULT;
d9396dc909768b Kiran K 2021-11-15  385  		goto fail;
d9396dc909768b Kiran K 2021-11-15  386  	}
d9396dc909768b Kiran K 2021-11-15  387  
d9396dc909768b Kiran K 2021-11-15 @388  	if (caps->category != 0x07) {

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

