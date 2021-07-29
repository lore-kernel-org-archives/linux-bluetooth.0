Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,GB_FAKE_RF_SHORT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5259C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C3960E76
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhG2MIT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:08:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23624 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236611AbhG2MIR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 08:08:17 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TC1avY001604;
        Thu, 29 Jul 2021 12:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=nww5a943KJ7LoantE1MMyGloLiGQcnA9B8X3qtvMbHM=;
 b=SWt3G5kFkkuxGKUZOqP4qUFUGFT+/FVhpGJmG9U/LtEcdXkAICr8h/1cF/fJl/KUvScG
 Mw1G+RLAYjXx3b5SCX2KgBibu0R6vjc7Cb0z9N3HTjumNSfgW04rQyvEkN1UfoF+tXPN
 2Q54LtJMWKk9fnQ9LpklzpdMr/IWITNDqd92ZD4ctFBT+BdiMUPmwwtCiY0U0YqR2Wqi
 lfyAiYJdnJ+epgdNDwDFpQD61KTs2WgYfJ5YRNlP5/5i7TxyNiMsumR4dIttWPXyMZt1
 3MTv6F8AWF9U6NSq6nyLQrEGS0KcRHzcn8WJDVwVMotLa8GImkqrEPV6GjR6FwRzSN0h 4g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2020-01-29;
 bh=nww5a943KJ7LoantE1MMyGloLiGQcnA9B8X3qtvMbHM=;
 b=KQcBfCY6atFcwdN2UuQjxxcliDr7ZDofzt+VVOnz3pIwf6dPDykBJsxmSnqVX0S5n4mF
 KXEfkyNYMINZWVJu2/RbcINa5XODiZLq695B/gSO8fjZuZtMtiJaJoZrbwt7LNXlcZ7l
 8tu4XkkW9517yQGZUONaiL68xpv2QAz+FlTLfek/Uo55kgkF+FzYTUnxhb8xRsCVbc5O
 sbSemHvjRdzyN8czdXaYotOe1SJ1MtgTAUD68smgxNirXitbXO2J0T3t/yDMeOClyURf
 8WKUf4CEosJs4FJTz27IsHjI6bwNs7vIw7v4lxaWRmImY/cKRSdf1pRL3dWoBxDziY7m fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a3uuj80xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 12:07:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16TC5nZJ183154;
        Thu, 29 Jul 2021 12:07:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3030.oracle.com with ESMTP id 3a234ed124-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 12:07:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1aAlyEYuRRYnyye1XwbDbvDuSP5Vd0XTmoxqp0n6mze8+iojdLdMoDfPRSnyxLu+buPehyw+At3p92BQq4aOZ0dSSdnSmf00uGWKFx9TlomXwW1PB9NwaZbFVBScjdprBbh25Ag/UABTlreH6R75I45nyWnjXhjsjrFFKp2sFMF/a/ybLOP+wh0Sl0/ZGHdiQ4Cp9C0Ph+MDgHyfP9O61bqwnTzg+rwKElMOFPGBbQWm/1+uel2OWvLlXLIsWk6by7/gq+l/nQL0fQehitVVppIVMoFbtbyDQ6J2056OzDoqY5eHtAjUuLo9ERs2duPJa5VM8w7qScJ722iM3mnCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nww5a943KJ7LoantE1MMyGloLiGQcnA9B8X3qtvMbHM=;
 b=IeLlKd4WWhJ2YgFjt/o9Wa5O2nEAuqang0c8aKcdbDnUO0M7dG8jdzG+rXDdTGvzNTFlQCpcJr65WFB9Zp7Bfk6T6gYvlspTRZ1HL89fc1udl6Dhfu2v4ISaedVF3YyUB0NkCqfL0Jy0Chlvob6TgS3qDPry3IDTrilOSbNLjEERyurcO6x5qPXDTF3Of/hDEWQL8xMbOKg+yRcBZhxc1QYvFfED5ExXreGFIcfji3RYQOMtUakaatnvXKKaqH1dKnDsGWYltGDDAgX4v2HQM9NREhkRSGTJsJ+ZRKPNIAFT6d6wWxh4VV9VbtFQFqiZo0Mj908xq+mkiRtjU2FUow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nww5a943KJ7LoantE1MMyGloLiGQcnA9B8X3qtvMbHM=;
 b=nl1yEjxT19lfHzOvpnQ7FRyza/Ro8b3y/yrPORPXTn+I6/hsTzPYIomNWPkoQCqY1x306wP/a1DE2QyLBroa/mBwBAIp1PhMZDiYHIFHURw2XmomEd8+UZXQ/FPKDPIHjU7aYneywjDBNCOY0tU4ll96FzxkzHRP4Sb2cql9K4w=
Authentication-Results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1549.namprd10.prod.outlook.com
 (2603:10b6:300:26::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Thu, 29 Jul
 2021 12:07:29 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4352.032; Thu, 29 Jul 2021
 12:07:29 +0000
Date:   Thu, 29 Jul 2021 15:07:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Phi Nguyen <phind.uet@gmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: memory leak in h4_recv_buf
Message-ID: <20210729120706.GU1931@kadam>
References: <0000000000006b1779058c0cbdda@google.com>
 <d71a274f-fdeb-4da1-898e-06f6944e04dan@googlegroups.com>
 <a125c3e6-7723-185a-3c47-219c201c6785@gmail.com>
 <E59B3DB2-3D96-459B-9902-C9E729407ED2@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E59B3DB2-3D96-459B-9902-C9E729407ED2@holtmann.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0068.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0068.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Thu, 29 Jul 2021 12:07:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c3c6fbd-85b9-43d2-7400-08d952896f9a
X-MS-TrafficTypeDiagnostic: MWHPR10MB1549:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB15490A867A8AE4DD482FC6208EEB9@MWHPR10MB1549.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +mwAIQWecZb5F9kECEvX3dmKfgV8VD18jxZmJA3WhwYPCU0v+zh5WLtMKPsQ9+BPf1fZzOAYHM1VE5MqfFV1A5O2wqhha1Iqz+dqCE28pHn0YilzcBGXGzgpG/3lolFThVl9oynXSWY69c9HCh/JMry/mHxT8oFayn6mrjpN1ZXNyzu67lwEEV4pRAAPbhyPcrNcMtQ8/U348u6uIcACxu3qN7eaYBgfDZiSh3dtmp+D9xxNRK7FPC298nJI/a4pNpXaHhpb26zv1sz8X0dNzVacq7JPWxOxIh3A8+NkYO/Osy0ysHGlNfPnYdChV+mut3RcdPuGzzCX4P+rE+0LmJn3crAu/0N2OJtLR25uVBG+jbp10IQWrOt/8C7WzzZNveDkM8gsYSXhGukgm9pzUkb+BHtjNDPHxeABN9MnAiE5b+LQu1RG8Rn7SzuWpUhHAFz5PEccsF1L3nTpx9jUJoJITIV2QQJkBIw2BDJy4L9qq3U2krdkWsjUoZ85mnZPZULV8JCZscyBSLyhuwE8v/+bZprflJvxi2k4wlaS3TBnqiMJFGUcBW7jt/KqYZQ3dglqIoLfF3gVhObfsmUckd0nCpLEhozMkAvirapVlsnswzRmsm8K7ea63g+/JqkB47P/6FxlqGabEr0mXqST0hkUqCJKbLbqRgcpUQRfbG2RdIXMf/tcEpROvzI7kKCTVvCiuOTbdh/D7SoZpeEL3lI9FGGAOBsTjUmYw7jJ0uVrlkIHnkKej+a+sz1Op12Jv6LRo5bR/SyLenLDNpSIG8PXL6bHWa0YBg0Yy6JJcM289bnvghNlC1EPA3TncuL3GWoRMkrSnjcFxG5VR0jmDW/vaPJMBxgxmQlLieuruaGNalNWmW33vATcbQp/+h0i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(9576002)(66946007)(66556008)(66476007)(33716001)(1076003)(26005)(33656002)(316002)(6666004)(186003)(38350700002)(38100700002)(5660300002)(4326008)(52116002)(8936002)(966005)(508600001)(8676002)(55016002)(6916009)(44832011)(83380400001)(956004)(6496006)(9686003)(86362001)(54906003)(99710200001)(505234006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjlJVEJteW4xVVNycnc0TVhSMWh6eVdTV09jS2xnTU13Y3hKb2pTR2JxcnRJ?=
 =?utf-8?B?ajZqbjA4ZXdLTUZzd0I0SEdZb3ZNSVZPenRpZ1lvR3FhSmFicWFoSmFqdUF0?=
 =?utf-8?B?S1N3N0F1ajBjdnhZR1pLSkVmVk5YdzhmMVkyUXJBeVkySmIwQXlGTHhYeTly?=
 =?utf-8?B?eDczYmVGZ29NMlFmUmhjS2NibGdHd0tGV2g5NjMyZmhPby9VU0Z4OTlEWDIr?=
 =?utf-8?B?UjZURHlobjhma29LN0hyTnlUWVBlbTI2Nmk1VExmUGpFSk5DOUs0SzdqQVV6?=
 =?utf-8?B?akk0TDBUaFN6eFpWVDZvOURTR0FMYjAxVlBYMm5lLzRPbUFFS2x0dlVrekp5?=
 =?utf-8?B?MGozeUJOR2FVamVOak5Oa3pVejZsanFlRzhRK0dHRmo1OXFnSG9QSjBXZmtx?=
 =?utf-8?B?b1lBdDE5VjNnODZOdE9JOER0ek9UV2JQY29NUjFYK3g2Z0hvYy9Ub2ZJU0hx?=
 =?utf-8?B?cUJqcXRvaC9NUld5Z2RzTXNnbE9Ea01lNmw3aXVPT2FTWkFpaGtlb2dFNjJE?=
 =?utf-8?B?dVBiNnVzZWE5RE4zSFloYTZzTVZzQkdBRS8yU25MaFRrUjBjNENOb3pUekx2?=
 =?utf-8?B?NlpwN2pRSDFrcFF5UjFKT3ZobkVnZ0l1T3UwdUZGcjlPcituRHA4WTFNWnln?=
 =?utf-8?B?aGZSQllmUHRpS00xWlJqeVF0cG83bjU3N2Z3aUg5ZEhrb3VJR2pvUkR1TENH?=
 =?utf-8?B?Ym9aUjhHTWZodHRBeno4L25Dc2R2a3FLZVZLK1VTTWFneTZoTFJ6MkJ5cExw?=
 =?utf-8?B?cUpsbERrMUQrS0psL0U2SHBLWmFENTdxQ1I1K2xXSGtRWm5FMUVvMjJuNlp1?=
 =?utf-8?B?ZXBKMGdkcGJyZXl5Y3Vlckt2U1JKOWxiQm8yR2JSKzRHbkc5OHRJcDRvZTNr?=
 =?utf-8?B?TXRQMDJkMEdMWnNCRmM1bVNHSG10d2N2TldtK3gvRlk5dkc4dGh0VXRSWjhx?=
 =?utf-8?B?ZjNKa2RWamFpckZiWHc0VXQxNzB5ajlZS0RmZDhKTFhIVzN0T0k4bklXckkr?=
 =?utf-8?B?dmg4QUNmZUZiSU9sQ3JkVi9JNmx1NGQxSy9UM0hteDc2R2NvN1E0c3FsQTNB?=
 =?utf-8?B?aFIxbkJ5cis3dkY4dU54Sm51VldXSEgvQm0zZGJkdkVCZHNzMTZMZC9xZTdh?=
 =?utf-8?B?bzdzOTBZaVV2RHFyNHBvNTRNbzhUL091eTZUa01tUU1qRkxxRlcybi8zQ1hp?=
 =?utf-8?B?K3AvcEo3Mm5NUGsyWXNqSXJUMDF4QkZtTUZhT01HcWZvNjdQQTBzMTlnLzAw?=
 =?utf-8?B?eEpkUk4ra3N1aG1PUTFGZ3dyNHluYUdPd1ROVE1UaGJZUFVlUnQrUFdZVTln?=
 =?utf-8?B?OHd2bmF3TGRzNzRkWFQyN2RjczNvREdYdnhaNDJHK3BSWnRLSGRUd0RWemhV?=
 =?utf-8?B?RzczZzRDOWtYd2h3Q1hydzc4elN2YkQ3eldNUWxSdDgyd0dvTktmUWN6Z20x?=
 =?utf-8?B?QmdJdjBqYkJjT2NqWW9OMkcyRGVPQk10eFVlSWphYU9DaTlSSG5MWE5zSTM2?=
 =?utf-8?B?Qm03cHJ2OS80cGIwVENSMVdxR2V0VHJIWHpISVVsUEhpR2x3Njh5emNkWHdm?=
 =?utf-8?B?NFR6dW5tQ3NZQXIxWlBuMmx2N2tNTy9Rb3NBdzFNdm92T1g5N2Via3ptck5J?=
 =?utf-8?B?dFdPWGF4ZnJNSVNLa1NDMjhQY1k1Y1ExdFhqUitPeVpxelNQMzY4ZEJzOXdm?=
 =?utf-8?B?ZXJjVURDa005QkJWUER3R21neFZiUEJZL1prQVRyWHhRdU1xUlk3dDNQR1Z2?=
 =?utf-8?Q?R7Wo8TcEL+0PyFvDdP8CdE7XiD4GhKjsS1uGEk/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3c6fbd-85b9-43d2-7400-08d952896f9a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 12:07:29.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bO3n1cOedyXTI4QDjI44xJfHT4vlrTWQ6bAeLlp4KkOXUYzH/OjocXtvRlrNONW3pgqnO9VmpjoKetdASx6FEVTCUhstfcwSXyUzWhuEY+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1549
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10059 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290078
X-Proofpoint-ORIG-GUID: fa6jMG15R0653yR0Y647kGDfdZZNi67k
X-Proofpoint-GUID: fa6jMG15R0653yR0Y647kGDfdZZNi67k
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Jul 29, 2021 at 01:44:13PM +0200, Marcel Holtmann wrote:
> Hi Phi,
> 
> >>    Hello,
> >>    syzbot found the following crash on:
> >>    HEAD commit: abf02e29 Merge tag 'pm-5.2-rc6' of
> >>    git://git.kernel.org/pu <http://git.kernel.org/pu>..
> >>    git tree: upstream
> >>    console output:
> >>    https://syzkaller.appspot.com/x/log.txt?x=1054e6b2a00000
> >>    <https://syzkaller.appspot.com/x/log.txt?x=1054e6b2a00000>
> >>    kernel config:
> >>    https://syzkaller.appspot.com/x/.config?x=56f1da14935c3cce
> >>    <https://syzkaller.appspot.com/x/.config?x=56f1da14935c3cce>
> >>    dashboard link:
> >>    https://syzkaller.appspot.com/bug?extid=97388eb9d31b997fe1d0
> >>    <https://syzkaller.appspot.com/bug?extid=97388eb9d31b997fe1d0>
> >>    compiler: gcc (GCC) 9.0.0 20181231 (experimental)
> >>    syz repro:
> >>    https://syzkaller.appspot.com/x/repro.syz?x=1073d8aaa00000
> >>    <https://syzkaller.appspot.com/x/repro.syz?x=1073d8aaa00000>
> >>    C reproducer:
> >>    https://syzkaller.appspot.com/x/repro.c?x=17b36fbea00000
> >>    <https://syzkaller.appspot.com/x/repro.c?x=17b36fbea00000>
> >>    IMPORTANT: if you fix the bug, please add the following tag to the
> >>    commit:
> >>    Reported-by: syzbot+97388e...@syzkaller.appspotmail.com
> >>    program
> >>    BUG: memory leak
> >>    unreferenced object 0xffff88810991fa00 (size 224):
> >>    comm "syz-executor739", pid 7080, jiffies 4294949854 (age 18.640s)
> >>    hex dump (first 32 bytes):
> >>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> >>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> >>    backtrace:
> >>    [<00000000da42c09f>] kmemleak_alloc_recursive
> >>    include/linux/kmemleak.h:43 [inline]
> >>    [<00000000da42c09f>] slab_post_alloc_hook mm/slab.h:439 [inline]
> >>    [<00000000da42c09f>] slab_alloc_node mm/slab.c:3269 [inline]
> >>    [<00000000da42c09f>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
> >>    [<00000000f6fbcf84>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
> >>    [<00000000ea93fc4c>] alloc_skb include/linux/skbuff.h:1054 [inline]
> >>    [<00000000ea93fc4c>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339
> >>    [inline]
> >>    [<00000000ea93fc4c>] h4_recv_buf+0x26d/0x450
> >>    drivers/bluetooth/hci_h4.c:182
> >>    [<00000000e0312475>] h4_recv+0x51/0xb0 drivers/bluetooth/hci_h4.c:116
> >>    [<00000000ebf11fab>] hci_uart_tty_receive+0xba/0x200
> >>    drivers/bluetooth/hci_ldisc.c:592
> >>    [<0000000095e1216e>] tiocsti drivers/tty/tty_io.c:2195 [inline]
> >>    [<0000000095e1216e>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2571
> >>    [<000000009fa523f0>] vfs_ioctl fs/ioctl.c:46 [inline]
> >>    [<000000009fa523f0>] file_ioctl fs/ioctl.c:509 [inline]
> >>    [<000000009fa523f0>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
> >>    [<000000000cebb5d9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
> >>    [<000000001630008a>] __do_sys_ioctl fs/ioctl.c:720 [inline]
> >>    [<000000001630008a>] __se_sys_ioctl fs/ioctl.c:718 [inline]
> >>    [<000000001630008a>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
> >>    [<00000000c62091e3>] do_syscall_64+0x76/0x1a0
> >>    arch/x86/entry/common.c:301
> >>    [<000000005c213625>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>    BUG: memory leak
> >>    unreferenced object 0xffff8881204f4400 (size 1024):
> >>    comm "syz-executor739", pid 7080, jiffies 4294949854 (age 18.640s)
> >>    hex dump (first 32 bytes):
> >>    6c 69 62 75 64 65 76 00 fe ed ca fe 28 00 00 00 libudev.....(...
> >>    28 00 00 00 a0 00 00 00 52 ca da 77 00 00 00 00 (.......R..w....
> >>    backtrace:
> >>    [<0000000034504843>] kmemleak_alloc_recursive
> >>    include/linux/kmemleak.h:43 [inline]
> >>    [<0000000034504843>] slab_post_alloc_hook mm/slab.h:439 [inline]
> >>    [<0000000034504843>] slab_alloc_node mm/slab.c:3269 [inline]
> >>    [<0000000034504843>] kmem_cache_alloc_node_trace+0x15b/0x2a0
> >>    mm/slab.c:3597
> >>    [<0000000056d30eb5>] __do_kmalloc_node mm/slab.c:3619 [inline]
> >>    [<0000000056d30eb5>] __kmalloc_node_track_caller+0x38/0x50
> >>    mm/slab.c:3634
> >>    [<00000000df40176c>] __kmalloc_reserve.isra.0+0x40/0xb0
> >>    net/core/skbuff.c:138
> >>    [<0000000035340e64>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:206
> >>    [<00000000ea93fc4c>] alloc_skb include/linux/skbuff.h:1054 [inline]
> >>    [<00000000ea93fc4c>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339
> >>    [inline]
> >>    [<00000000ea93fc4c>] h4_recv_buf+0x26d/0x450
> >>    drivers/bluetooth/hci_h4.c:182
> >>    [<00000000e0312475>] h4_recv+0x51/0xb0 drivers/bluetooth/hci_h4.c:116
> >>    [<00000000ebf11fab>] hci_uart_tty_receive+0xba/0x200
> >>    drivers/bluetooth/hci_ldisc.c:592
> >>    [<0000000095e1216e>] tiocsti drivers/tty/tty_io.c:2195 [inline]
> >>    [<0000000095e1216e>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2571
> >>    [<000000009fa523f0>] vfs_ioctl fs/ioctl.c:46 [inline]
> >>    [<000000009fa523f0>] file_ioctl fs/ioctl.c:509 [inline]
> >>    [<000000009fa523f0>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
> >>    [<000000000cebb5d9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
> >>    [<000000001630008a>] __do_sys_ioctl fs/ioctl.c:720 [inline]
> >>    [<000000001630008a>] __se_sys_ioctl fs/ioctl.c:718 [inline]
> >>    [<000000001630008a>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
> >>    [<00000000c62091e3>] do_syscall_64+0x76/0x1a0
> >>    arch/x86/entry/common.c:301
> >>    [<000000005c213625>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>    ---
> >>    This bug is generated by a bot. It may contain errors.
> >>    See https://goo.gl/tpsmEJ <https://goo.gl/tpsmEJ> for more
> >>    information about syzbot.
> >>    syzbot engineers can be reached at syzk...@googlegroups.com.
> >>    syzbot will keep track of this bug report. See:
> >>    https://goo.gl/tpsmEJ#status <https://goo.gl/tpsmEJ#status> for how
> >>    to communicate with syzbot.
> >>    syzbot can test patches for this bug, for details see:
> >>    https://goo.gl/tpsmEJ#testing-patches
> >>    <https://goo.gl/tpsmEJ#testing-patches>
> >> -- 
> >> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> >> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com <mailto:syzkaller-bugs+unsubscribe@googlegroups.com>.
> >> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/d71a274f-fdeb-4da1-898e-06f6944e04dan%40googlegroups.com <https://groups.google.com/d/msgid/syzkaller-bugs/d71a274f-fdeb-4da1-898e-06f6944e04dan%40googlegroups.com?utm_medium=email&utm_source=footer>.
> > 
> > The reason of this memory leak is tty_ldisc_receive_buf() and tiocsti()
> > can access the h4->rx_skb concurrently by calling
> > hci_uart_tty_receive(), so the rx_skb be overwritten without
> > deallocating. There used to be an spin_lock in hci_uart_tty_receive(),
> > but it was removed by commit 7649ffaff1cfe(Bluetooth: Remove useless
> > rx_lock spinlock).
> 
> I don’t have that commit in my Linus’ tree. Where is it?
> 

There is a typo in the git hash.  It should be: 7649faff1cfe4 ("Bluetooth:
Remove useless rx_lock spinlock").

> > The commit message claims that hci_uart_tty_receive() was only called by
> > flush_to_ldisc(), but it seems incorrect.
> 
> That seems to be a larger problem in the TTY layer if its contract with its users have changed.

The tiocsti() function has an ancient comment which suggests that the
documentation has always been wrong.

*      FIXME: may race normal receive processing

regards,
dan carpenter
