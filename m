Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4BCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 09:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241178AbiCWJUh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiCWJUg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 05:20:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C0774DC5
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 02:19:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22N7YiCS019548
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 09:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=xt9GJeKefO1QsfBGV5M8Xw01C9NN8EGqjQ+UVMfRIeU=;
 b=sIzlamO55rpODw0ovnSX6ZhFmWCKHgBHMvfVbT3FCY1UzBCqpkFA+EgGqplAjkZhDSPF
 5VqABV3fK3cLAmqUCX/M5yYeJBRg03ZEXQMi+/QVtjhD299Q3ak6cY2ol/FPF4CKALcJ
 yL3x1rpkMM4IiUscfa2J+mSxvrm384Pz2vIEqmOO/a1Bnix9lrn7Q5XkEJbH0XKud1Sz
 gsVGqWKUsq8oRTw5G1g7zFJEvii6M5S3k44TxwpYpFZOPT4dinj3oeYb4GE5GM7UxR0u
 n9CAnqUSowbxHi8jGfUMYKjWCZ05Wwi6hgQ5lngPvgaSSQtRBNrSGhROZjyTcp8GNX44 zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew72agqd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 09:19:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22N9BJSN186198
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 09:19:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by userp3020.oracle.com with ESMTP id 3exawj5web-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 09:19:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgeI8JJTyDYSm9RsqMKsKzHWUeL3XXFfK8Mn4z3SN0a/cPUGEjdNLPiQpdmW8VND2mj2PWitzdiihhN7qvFsLPvKUCMVq6Giw62grYjf7TjojJEurXBmKdY+d4QZymXgUmdxQRuDYJfuQmd8M1Wy8mafMGojfdiUO6hjgMtWL5d0g7N+XK6MEg3OH1mXNvagVRGd8MlIynKaM2k1rWH+T3SmbMRnTe9Lp0RmwBXUDZHGjdn07FB17C3KCCTLoV/MNEFACHHI2md5eXBR0E9q2de1Txo4KNYSArR6rcRFNqKSodIetcqH19g+O915wJbE11tCPYQW+9t0IQJ9bC+RjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt9GJeKefO1QsfBGV5M8Xw01C9NN8EGqjQ+UVMfRIeU=;
 b=NHyPDO/frPBc38cUXVytA8QfwN1O1Q9/ZmFb6eQp+B8K6avF4dZ0GZj96vX9IODyk8uaZ4RFFOETXWbQGr7LgdKFcOG88rG6EMSzw8z6/xrnbcZZVSmqXomPi5hkp2W3wIe9F9+lobDedafeqQ/Lyb11+und3ozdc5G10lm5wcaKxe3eZQhArSCpd8csbGlRUHOUyMUBKsVg4i+VM+coFoMWkPMXi01nxfPCPXQfDG/gh2vVRTHbuGf5Z6yd93eDi+/C2g0NhnQkEjq+LNUDjNexatKKU1CluiUl26E9qzE9/1vWtkJdLJFHDiBT4PPaiU6I22/f2UQpiSdI4fWIeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt9GJeKefO1QsfBGV5M8Xw01C9NN8EGqjQ+UVMfRIeU=;
 b=kqcvV+/5qsAwoyRACVWFtdX7BIS6mQ5u72QkaBLTmk5vkTjH8cgbqG67bHOo4vIa2roQaGx3eQHb9lyBJAu+5+gqr7S9n2a/QkY8bmY0NkC7FcXmXoCp4heiRGT4FobCldeFm3tvPKT8ppOQs/4c39lQJ/iRIQU9lBEdX3ThaIs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5358.namprd10.prod.outlook.com
 (2603:10b6:5:3a3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 09:19:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 09:19:02 +0000
Date:   Wed, 23 Mar 2022 12:18:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: mt7921s: fix a NULL check
Message-ID: <20220323091845.GB336@kadam>
References: <20220323074830.GA4639@kili>
 <623adf16.1c69fb81.b9a8a.713b@mx.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <623adf16.1c69fb81.b9a8a.713b@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0070.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25fa4945-9eab-4083-a402-08da0cae2b90
X-MS-TrafficTypeDiagnostic: DS7PR10MB5358:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5358404191398BE7F7359D5E8E189@DS7PR10MB5358.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNPZCVuzwNDpxrg0m7qjdKxeqY9ynOfTBJ2NSOWutBHk2bjdUpQ64I0FUj/xmiGp1NrY8ohTCKTgVqloB4vS60rQ31VNi9yh9eS7iXSxV+Xq5ef53uTMZZ4MySspzLpHYF4oYADi9rzM6a+mgdL8ACYhAwC1fuBCzX7fgU0sTrn78z8gceADaFlvggfhBcLeg8E5QJa9y2yvOlK7xSs6q9lOFe02jA3PKF6s0VstDp8yXFgQwhNgcfVwTLpGpnaQA4PoLBMyTo6mbJHlHauY95TC4cgwhN2UfM8cRZPc8JCiW+AfqEB17OPsZHmP4VMs06dMRrGu1vR+n66pG+4b19U/O/qqgHEeobAQ2DjkpIVK2QzLXY5VBwnLtONFcHaCA6/LZAeUkutuhwp05k/OYnWGsvp3Qfp0UcYgsXhlMpBCBMoD8RrfJ443FG5PVmX6+6HH8X7VXXHOBACt6Ic1PTePlN7i7tSbH4rdEnFQWcYt7BfSOotnBQ6PRLloBhp7nPAT0O3u46rD6/f/uaBYgWLjbrK6OsWK46KbEF4RlG1LzSIV6LIJWPjXQJ0UNWtjkzFZ7WCLn0ggu4GFBTPCaQ0voGilyJ5+xHW4GENAHree00ZCePrYf+bEpjSZGB86FpHirAIVXfXS7Xa7rcz9mVnHf5J2DAKtTDQcqTll52b5WepvAuVKHwsQb9HE7vbb5A/XBQqMOlN4wvNHZ91n+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33656002)(83380400001)(9686003)(6666004)(52116002)(508600001)(38350700002)(38100700002)(6512007)(6506007)(6916009)(6486002)(86362001)(316002)(66946007)(26005)(186003)(2906002)(66476007)(8676002)(33716001)(5660300002)(1076003)(66556008)(44832011)(4744005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?POnDrcJUZbp5cvC9VWP2u9w9/BIFGUwzWHL0QgasCjp61EKRCu0r2Iurft/6?=
 =?us-ascii?Q?6sNoMGkZxGh9ITJGIz+3cMgYznpD5emRNftLtUN/fnfXG4+XwSz0y+dT1BLq?=
 =?us-ascii?Q?THlasRmC5e/0q+Rw8RpRWeX6v6t1x5Zc04bZY+xeU77PhBtrcriXFU0Ymq48?=
 =?us-ascii?Q?eSXTqOkhXYzNbVjv2zZPhwI0uYABwS8ElJd0p0JtJVHgTq+f72h0AJD5MKzf?=
 =?us-ascii?Q?15Ss8u/Hgc1fuwV5cYRc+ll5p4uIF50K9r1jJ0OTg7pR3z0lCy70SDAoRFgR?=
 =?us-ascii?Q?OG3iev/am6ioUGNrnSj1YmdGRb0iFkQEGi3XX/HAI1PgFC5SIaYNh4qwJfRm?=
 =?us-ascii?Q?yeYSChyl3LCbBe19a9qnA/pYz0t8ccQowGid1u24cmwSl2qWAOizaLIQxd7f?=
 =?us-ascii?Q?eMia/FECWQ8yfoJ4Fs3HJah9UcSN2bFoaTaOO8cHpBpk+Xxh5ol1PKHZwAPJ?=
 =?us-ascii?Q?EhLCthl69QHISF1bR7pqlZ8asSBWCbO727heME8fRhsE/dx0mgG8A6vMygep?=
 =?us-ascii?Q?wPoWWSwtBiKPWBzV9/9vOIVfBle4J74Z5GHYYS7+G4vyOhKjtFq9tMuNbHvx?=
 =?us-ascii?Q?yWAcABWWmjuqR8yci2r1i3fSNw2xTz4tpgGfeBH7CW1C+IcaAgbzGmXPastE?=
 =?us-ascii?Q?iraq6E4I3PMG4OkCH2mX0+GNmBC7aMaswzPtUqoaSLqJv5lXyz99vC4gvGGf?=
 =?us-ascii?Q?lu+xNYBqjrUce9xDAB+Ox+/URu83cKMYIKcr2RfxT2z29NP4FzmYhwTO5NCy?=
 =?us-ascii?Q?SC9YPCmy7qa6F+pErefNY1pISiCptPGXy6DP0Evo//ntA5hUBeosrKbOMXZB?=
 =?us-ascii?Q?lxGJvJNp13b5GISWMbmCHBMslixnjG18OaxQt0RfoOEHd5OcwbnPULP7NwU8?=
 =?us-ascii?Q?kxXnpfmKJcgzpm3UMuHVPWFxMua9OR6WpCbmBnRrg6kXoPTuvwtsiWF60Ffm?=
 =?us-ascii?Q?1m9S+BCkhyfY8MZNRC24MjvozRuSq6ik9faceegVGs3BPKWgqLqV9UDtRG7M?=
 =?us-ascii?Q?8S91p7WxrUVP+bxJgyedrGFDqd/nXj5o+QtGfL/6ByaJh5WJB+5O54353h08?=
 =?us-ascii?Q?rJtMUMky4fYXA4SdWV0P/KZRrqRY0+QCDsYeZAIdgO4almsIs6mn+UxPW5f3?=
 =?us-ascii?Q?AfK7ZHqCxfkPY7bey668+R+80hn7H1qUfeewNQO468PkY2qyejbknfmGzvY9?=
 =?us-ascii?Q?Kstlvw0ki7P6EN3waJahPTv5/+viW9EUma7zoAnZDJqyg0ucfjuR5dczViv/?=
 =?us-ascii?Q?HdwGgycdQ8e+j8k+M3RvV5QNh0EtFuU/lH5TEL9JJ83T/B0YwZJaNkQNe/Qu?=
 =?us-ascii?Q?n+Zc98wL4q+gOmh4Fck+qtIyiF0Yvva/rbRDu9LDrgrJweSaRopN37DL7l5P?=
 =?us-ascii?Q?/J2I2WxHPoU/hmBH4/Vo/dIqP85G6+hmoFqAT7B0vbVzFKwBJdW2U0r2Fgmh?=
 =?us-ascii?Q?DloRQ/SaRd7k0Y5pkUE/IhQkxHmbMIayTJrYv0bg4CEBvOiGfZx27w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fa4945-9eab-4083-a402-08da0cae2b90
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:19:02.2338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDKwz+ywviBtqdhC8p4fEIyIecWGLtfRcQ/n8tRXp9v969uy0zeOwnrOeqGwmKq6K/tHZieGDZIGeZQwHpa6FU/cl1sRWFAItPsI7hzjlCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5358
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10294 signatures=694350
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203230054
X-Proofpoint-GUID: fgVBKVBYa8YT_fuP1SvPrMlFZN6X0PD7
X-Proofpoint-ORIG-GUID: fgVBKVBYa8YT_fuP1SvPrMlFZN6X0PD7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Mar 23, 2022 at 01:49:26AM -0700, bluez.test.bot@gmail.com wrote:
> This is an automated email and please do not reply to this email.
> 
> Dear Submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.
> 
> ----- Output -----
> error: patch failed: drivers/bluetooth/btmtksdio.c:961
> error: drivers/bluetooth/btmtksdio.c: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
> 
> 
> Please resolve the issue and submit the patches again.

I tested it and it applies to:

git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master

It would help if the email said what tree the build-bot is using.  Who
is maintaining the build-bot?

regards,
dan carpenter

