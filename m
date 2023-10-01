Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A69E748ED
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Oct 2023 08:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjJAIjg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Oct 2023 04:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbjJAIjf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Oct 2023 04:39:35 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB81B3
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Oct 2023 01:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E09/MWqsVOCGJiU46x82hgFEsZQBT3l1NY98Q+Dvnvn02E3lQNkYOdgygfkqI6TL18WF6vwn24lM7D0lOTpFcRyN7kl4messNexywmXVYwnU1sbPOPauvHkbUvKbN08N+IZp6gVT1MI7fzlcqoFUnLlzVnofTvkEEoMVCHoO0Gbzi+76GBZe5KneEP9CaJXkcUpvUqVPwJ9P7KdqY3Il2evb0Ts+MZfWCyEWWBDi6i6d/+nT9swTqQEtbJURhxomU9n0s7x/Ur9fRp7ritrp91cJNhaTXoMv0JYp1jTV4HaeDyo/UVM/SRrpdJ+IkOP5KV9YCfmj890To2ndsXf2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGsGe3Mj6v8R3KHOJqZAINUJFR1UnhAcHSr0qp7Xjgs=;
 b=aBg/21n1eiKjuMyGy4beFn2g6wy2uUeKI3KP7ZHLLpgxuSQez0K7o1L/1GHW6qNB32N1vD1dQi2UHorM0vGA3MYfz1/jZOz6Syfv2j+MVPb4rf9gBu3E0aSYarTCIfWR7imWFeZRV+A/eVaB3MRWPSWia2JSib27lo4WwrLRV5MyBV7bHdMN9sXoGetCohoe76CSAPiPWFL2sBXjU1JBX2iVohEpKoz8pc+WQ34IV/m+OfNv/8tW9ebfnRtG0zgmShCR2yz0YIJS7LJdDRPburyBhjtP40bP4LlmKlyAXC6vTe1jLm9OCk7m42W6J9tRVectbRD/KH3UqD5lkjH2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGsGe3Mj6v8R3KHOJqZAINUJFR1UnhAcHSr0qp7Xjgs=;
 b=0Ub/fxpF8DD5hba4qfxeTEYWI613YtQpCX8x2fhH3wtRHPpHnv5q0d57mkzwMm3Qj4L2ZVKHzoJIlLBgevR9mtvb5jSbKWvlkhbKHopgFklXLf4hjNV9WAsHAYd6fZK3h9QjWMlqQ8LKV/RQzUfP907vC6cd39hA8z3g+zocZSNKwUCctGhLt7i5wkHKmXs86RdOfrNXEJAMI7/rcSv0FzQxZTnsaImuWvQNqS3ide7AntxmUtouHG0T5BtPdsw5GCLc0uIAAf5ZHmwHykl9RRUxFueqLe0FM7VS1mnAeF6dja5hJT0DdXM4NPBvVEe99EpcW48Mf+x2MZIM2zlhfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by PAXPR04MB9677.eurprd04.prod.outlook.com (2603:10a6:102:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Sun, 1 Oct
 2023 08:39:30 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2%4]) with mapi id 15.20.6813.027; Sun, 1 Oct 2023
 08:39:30 +0000
Date:   Sun, 1 Oct 2023 16:39:19 +0800
From:   joeyli <jlee@suse.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: ignore NULL link key and reject connection
Message-ID: <20231001083919.GD8209@linux-l9pv.suse>
References: <20231001074807.GA14403@linux-691t>
 <65192a7a.050a0220.74207.ee6c@mx.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65192a7a.050a0220.74207.ee6c@mx.google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TY2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:404:42::27) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|PAXPR04MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ddd19e-1db6-47a5-cabd-08dbc259ee04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGjwAxFPj1CqrqXk2Z+gg1EgooIPrrkvybEdQCPV51v0tYJ8pVP+6NrZ28y6dCt84uVuIuGGeJ6bNuG6jv9ODjCE1rybV/aTliMH+SK5uS82f7d9x7lzLVnq/ex6FkVAyEeP5+ofrGdLpC7MzvQ9hhQGFqTSYddBgLLlrm6PqmJiLz8fZjSShYkqsnebK+nhjpZk4p9NSxnYG1E0e7cZEmkX0zOOpyd1L8i7tL9zNlRH9qBJwHM5cALsONApzPlb9lNCYjoaEpQDFm38os+zsPxIdQyt0hfKt7imHViUBAX86scDe6W3QD6fDdgRUybDoNm4LJwGaicZFOtZWXXRqoGO/X8bLeo9l3RjEP3B0WpVGMTPR5eUo0vzOZWRILSiq/3ri1MW9zz4DnNBcmS8zj2pCTmVEroNqkyKfmSTNjWM4tMyZtHb8JTdRu2ocVlj3iXgdznTqAf7TXnuhQU0vvke474PRODFr8QGbeu97BGgCZeSG2+X/vWk25V35LP5fyKTvA96P8E7rsK67gXmyZ+I0ioA66bW1WYfLKFbjkZaScAVrAXj7z5RPpOgrmcBc/42xGjubFZGKPpb3KcLuWcbM1msz6WCXXcmlI4Wm/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(4744005)(9686003)(6512007)(2906002)(5660300002)(6506007)(6486002)(33656002)(26005)(83380400001)(36756003)(1076003)(41300700001)(86362001)(6666004)(38100700002)(6916009)(478600001)(8936002)(8676002)(66556008)(66946007)(66476007)(316002)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VIFqgAKWovROEV/JxlBueqsYZnu7JhtXL9NGVRYtUHPFQ6OxJzXTE7RI9u1C?=
 =?us-ascii?Q?Rhww7OPSLiwIXMpu3hZzUk4Bn+tEiU43BStJS8hduubaEpnCOh1skBdL1hrz?=
 =?us-ascii?Q?YWzXAFba7sbCyIcXJ84dDzWbVSCNzsq2YJteQ6RONmmfBBve/5Al8WGpPWay?=
 =?us-ascii?Q?w8Jj+UZWtoiNGMKC3dJPoMDsQisyMhzqoqtaPNsIBXSd5xiNUcpvCDjH04fo?=
 =?us-ascii?Q?Q9agGfsRYo02goyQuuk80n60UqYnZfUmS3+lA55iKOJ/2WIrzI09JXqKIML3?=
 =?us-ascii?Q?J4bT5L09z2lcy0kaLXtc4A805FfPxqId5ZirQ6OyPB1/TEoNHxDr2dTmj/AN?=
 =?us-ascii?Q?4Hm3SsT3tmbqISaSDfgTSwJVCCVpXVc6nXaoMLf1gd2m/IZ54ztSfoYpVSto?=
 =?us-ascii?Q?GFGLwTxlShzEFHnN6WD0+847visvTXN7Ja4eXpKo2tNbPYqXxWqSk1iKEVet?=
 =?us-ascii?Q?vdmOcdEuKGNyo+kzRVzNiZZxZZGkRKNBweIBo6GwckM2Hg3SQLQCcTDwqWkk?=
 =?us-ascii?Q?xIZEDOVEyVkbJV2xdhwGTwpXHbkiUvpLNWxRaj045zivzvOrtf9Z5+0uXg7l?=
 =?us-ascii?Q?kImhWWsogimqt2B3e1atU9jZMDZMfEjERFc1W42dT7f+G+F3aw/Fa+Ntgr9j?=
 =?us-ascii?Q?hCd6MlXfC6xP7SFCQUK1iSW1m6WDULSzpckLogy2ZBq4h1IpWK3rJwconix4?=
 =?us-ascii?Q?6klOCy9PIq/Yq705DanVt1/NqvSeLQnIikCw/i2rCXw5Vc4FzI3n7esLvBGw?=
 =?us-ascii?Q?a/cyaqWwHhA+KoNeP5aaE3I779j4wSGaxc3G6BYwD/uYflUU1YR/8IZCgaMx?=
 =?us-ascii?Q?BgyeoA/bVgUjCRLA05zD9F8062F/u4Kp+E9ZfCCf/eHPNqrv25SBXM+Q246a?=
 =?us-ascii?Q?rXyjHGrqsHHoOkeS5N2fGw8gyrnogFyAv1Uik8pbzhUEFFH8lxqAyrR/udad?=
 =?us-ascii?Q?qjzLg+HaxBdD9OUDrZ3VohkZLa3fxJKkYxPtEDuRFyQnVvvkvhT3y2yN1gBj?=
 =?us-ascii?Q?QNKenrWjMBaLCpgOPxvnD4hl1gIn0bFk9uWuhZaGk99r5nxlEKdmEcFgTwBo?=
 =?us-ascii?Q?ymwTpBlV+Jj4EDNn7tV3Oa0Ymw3NVRZiTcH1vTAV8uyAMsBmDXafpbHrRzIp?=
 =?us-ascii?Q?LAAU09g4QhW2wkMtvI/5Xazm+ALSrLU3NQ1WWh8EoMF7rvBgnBLWvROD78Ib?=
 =?us-ascii?Q?MqEMeWD43cQO5p0GMAH1RVH24+9eTiRngO07X9GKEDszT/CSis9OlaBuQsJi?=
 =?us-ascii?Q?7McnL8DqjYYOTj5l53gGxR2H53UDxvsiXjhgbm7ttKzRm0KscsrBIldosxmv?=
 =?us-ascii?Q?kfzgj4G/GVreyxo8WCkiPr+D1x4yQcmovDBanIdredNDMK7r69LE/yvbEanD?=
 =?us-ascii?Q?a092VdjMwRje9SH820vZ0xe7Lcj/IZLgFOD6/moiDUkX3wrTiktHuGNx5D27?=
 =?us-ascii?Q?EiCW/OZiHrqbtWT0lNXg1AQXSpe9djd7wib8xFLHow93iqyQaXmEpmuHCmpA?=
 =?us-ascii?Q?LnlYmg2RpVauwJJ3iWK8O056rKPOQo5RSEYRUMRPAnnIFAdZ79NVvdQJgBDI?=
 =?us-ascii?Q?mBCk+ysR8aKLpN566PDH7KMAXIG2ou2fTzOwSF6t?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ddd19e-1db6-47a5-cabd-08dbc259ee04
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:39:30.4977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtSsmiVqMpNax2H47I9Rpy6i1F9xIiLep9jpegT/ScNMb6y1Dc2ApA7ySjJsDADC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9677
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi experts, 

hm... I will port my patch to newest mainline kernel and send out series again.

Sorry for any inconvenience caused!

Joey Lee

On Sun, Oct 01, 2023 at 01:14:50AM -0700, bluez.test.bot@gmail.com wrote:
> This is an automated email and please do not reply to this email.
> 
> Dear Submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.
> 
> ----- Output -----
> 
> error: patch failed: net/bluetooth/hci_event.c:4692
> error: net/bluetooth/hci_event.c: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
> 
> Please resolve the issue and submit the patches again.
> 
> 
> ---
> Regards,
> Linux Bluetooth
> 

