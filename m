Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269EEE7849A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Oct 2023 12:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbjJBMhv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 08:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbjJBMhu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 08:37:50 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E636F83
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 05:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKuNSdyzQTZrugCjAqGEPaeuuU0GSkjCjKWFm3l/1Ilh7AOlYToqhlD2EK8T03InJkH62ZfWIVyZYjIlJWO8UClgzxVzAiRtp/tGbdRR5LoeZ5oMI5Vq5ArR+eb8O/8m1aLieAa3itlVEDida4vedeooLGPY7K3Bg1Rq4ZSdmOSXrkDhSoP9BoLht6kfYMrZX/V0DllbBSRkdnk20f7w5UvcMUxkDunA4ZhF1svq5EhpG8fv6L0D6Y5samiEmX0+ZgWqWA1+Wjsj20/VI5Fx5S7Q58QbGjlGMTuob2W5ademiSJF4uJYzuI1RxdoQFseGRdrtr15XfaGM8rG8GXLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE5h5c3mJmBDWq21Zj3KBLTiAbMv/EOMjeOv2WyQSmk=;
 b=GCJZfyMIs4Kj6K16cAzfBKjydHOvX1T+cAkb7ReKfYElBn3lYjUtv3n6oyDg9GLK61d1SwjbZ0e5lxbCjxWxea5hXXifoeTiBbMPDqlb6LTfgXMVON+n8aSxczu+OLZ+QT0rTinvOwtH0OuCUJTnbFb/RWTtyP7Us3P6pgthGq8k7R69zoEx5yjBxv/G6XzcFBah5sPWTxoAhrvI46nQ0OK7074r9NZnnRSEof1Iu4LIfDlJv41pXKKZaBfN5nfw1Lj+wyv6S5Ur5tJyah/+I6a6G11u60jsoRAq0eAHaTO4+Wbf/eFneCx/FH62im1+lmEA17jBWtxGfRO0COCL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE5h5c3mJmBDWq21Zj3KBLTiAbMv/EOMjeOv2WyQSmk=;
 b=FynHkXtXyhAFMmJfj8oywCrPVXFQl75oDEtf1PxgDVO5lF+ZODSQKqdBg7a1BVmwA7ooJIaAYCVyu7Pnt43H6TyNkyXL6kSCgMIMCkBc5Hfn4KQTwUQeWEgU7QeSO4YXcWxPlzvD68zmZUCSMXBQg6P/TbmSbBfnmU6dqH91m6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 12:37:43 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::7838:af8e:f859:cb04]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::7838:af8e:f859:cb04%6]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 12:37:43 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1] client/player: Allow the user to control BIG encryption
Date:   Mon,  2 Oct 2023 15:37:37 +0300
Message-Id: <20231002123738.22210-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0049.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::7) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|VE1PR04MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: a7037cd6-ab5e-4424-e0e8-08dbc3445f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1+1RisNTBeuh/bMACZCIHi4GIfgu8Iyy8yxuaEbK73sXrQgopLIRlisdp9IUgoMj/ziYaxYm5mVbFSz1fOeY8oqqdEpl853KEenjHzgbQ6OMg/nu4diAQ5ZyUePrDWKUdsPj/2FI49rRVYiOgGcWit2Zrpq6n2HQdH9ZXEPSNSI7hYRBKQnbla6RS0PZtnuqcewBN12uicozDeIydZYWsH0q/W4dEd0RnTv0KS8FxBjutME55fYlQG6xGRs+s4Sh23wzP1m0QGqy3KnfSi81y9ZNIomITaB7zoJHDpQsRf5Q3njeBoW2jh42lectnrHEE6Oawa6Mb13H+1W7oiVtCp0pExOyQybWf+oZvRoflKK9r+LWCxGmD48iQZ+CV8Z1w4C18XJdCcmLEEOpZV8sr3vw0VwdVYIdiwJl+zvFGgpdgwZZNKsAhvcA40l6WMy8HLOutlfDoYF6nEDJ/ZkVemaa6rbS07nWMb75yiLRYjLQ/jNtaeNdkZEsm3RhD6UpFdaLHHWQ/e1kdk9r5BZiWUVkm5Nvhc/VDB3psMoCP3UzDNv4HsyPpSTdQGW3jwG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6512007)(6666004)(6486002)(6506007)(83380400001)(86362001)(1076003)(38100700002)(2616005)(36756003)(26005)(2906002)(41300700001)(316002)(66556008)(66476007)(66946007)(8936002)(6916009)(4326008)(478600001)(4744005)(8676002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uCDVsu/e6NsRkuVPkkT2/hJi/pwStMk69HG9vSlJAzCumnB/UDW8/8MKj0nw?=
 =?us-ascii?Q?UQXGN3jSnzxTr//PymBxnN2Y/erwafuNWK5+ovuaso6bVqz4aO1u/MycKN4l?=
 =?us-ascii?Q?y4in6vWQk2msTC02DjizIqy+xGPi8XlvfOCaNdEbj0Rb59tmfw3iB0JlyU06?=
 =?us-ascii?Q?MiHaV6+XjAEVXnGCag7k1vvTGvGZ2BMb+rtfDsEZnhv/23Si2QpvQCExEyuQ?=
 =?us-ascii?Q?fi2UvRxRV7Pnro94J97h2kyeTTz5pYLuhEg9Eh1ZOqyetMO7OCOl68L8uUkN?=
 =?us-ascii?Q?GJX4Bf26heDWQZ6t2rSaLOd0Cy+hsxZ+aGMkvJhSSYDsfL4Kw+psJTa8YE00?=
 =?us-ascii?Q?m/M4nevdn/V0LGuq00xeUqqCl8lReLD2oJyQM1cffbKOk619SaS3yq5KkPbB?=
 =?us-ascii?Q?togOI9MPskFpPmcGqTum80UhN+SYQr+b6EHOyu/JdGBrsvVlfgxP0T6bdhsy?=
 =?us-ascii?Q?F8ue+dhYysdtC2magztFOfdiVulDvpwqv4MD4tYIw6qHEmXQuUy8/qECgT5L?=
 =?us-ascii?Q?1WFQi6m5o6q885EpQPjMO3qSUNR4/4hOEQNYLoAzPHB9VP5fH906eh9n2wKf?=
 =?us-ascii?Q?Dxpv8NFWqYZofEyFVl5MaDncnG7Yqd83nmgAFZNYs/MZhbKYqPyajB92r+Tp?=
 =?us-ascii?Q?tdsOTp+wVsTwrUw0DEsPJGYjFZjTjXlhYMkEFl6y6WsiDdnGb3lYn4TVzgI0?=
 =?us-ascii?Q?qJH0VnkTpzH0eGYoVXP9tlYCn7OYd07fOfTllK8rVpxvE8Hg202WE2kB+lTy?=
 =?us-ascii?Q?SZhBgWxpWWZJyUt+DZnS2kPDsM3mnsXOeVQqSFwWaa8ALFFD/Jn8p7pRv8xx?=
 =?us-ascii?Q?jSYdB8XBFiin9monJxe1vzpBtprBX8c0SVg8QWxyi6VUhiUyrbNk32qZmUb3?=
 =?us-ascii?Q?WUrDpGW2SXs1zKcehMml2uV4KTF5961VUz0adRExxFFC6a3DZbPNmKvgQv+f?=
 =?us-ascii?Q?zfzCg+eUOudnipmMDprmMXZwcWDsucudTkZhYStgefBANuHKiOkjsy8LunA1?=
 =?us-ascii?Q?5nNpmdTX+/bQtkb8cLJ5qtOXDdnwTYOQHFCMlL3c2+x9ka7V0o1PvXwnTGED?=
 =?us-ascii?Q?/FLYm/tp2SbTZeqeDwumM7r5r2mOdFLoOQ8WLFH6oJi2CrOnhJFf2bbpSVzl?=
 =?us-ascii?Q?jU6DOXid4KaYvbgPjVjmMT4Q/XNH+xQCTcTbcVfeV9uBZsb+RxZx+LWDjNjG?=
 =?us-ascii?Q?FUOoaarEYXkS8YhxK8fxqPPRAdCxwWtQkZdBD0QVREUOzm9eAiZd/fVtvGcE?=
 =?us-ascii?Q?VrYEhZhlrtqfsOpbp6fGNzZgTSDxBtG9xTLCt1/9LsTrVW83SrIIpAcE6UKa?=
 =?us-ascii?Q?rhIeT6mFWP07ZADuHiVaQtTMH3YRvyRXBWuWulJkssENHx80AnAquVcXAhBB?=
 =?us-ascii?Q?cb2pSEDwN6nslmZWieavCITyqqoOEoaWu2sUIAlSDp30gH0WwzZPNHDaRhzR?=
 =?us-ascii?Q?6FiJFCa28G3Art39wZA9EBU10pXxCmdwcWpDaxEINf3x1nQ+kKM1avm0jwS8?=
 =?us-ascii?Q?PhxR7F66mWyuNQoYbaqRtTSIEC5ODbph18v2NkSpfMOFulCGVl7MWlY4HJLL?=
 =?us-ascii?Q?V7OvFuJOp7UKxttyKIaU0ARG4xn9dw1+/7xIq71k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7037cd6-ab5e-4424-e0e8-08dbc3445f84
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 12:37:43.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3j2KO9oe6pIJZSysiwovZhVgScywmGYun2q7wR1YN5tVB8cXZfOSeKOK9f75NrjHjc3STvYep1kCF2MWqQ4Z8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7471
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit adds support for controling the use of encryption and
setting the broadcast code. This is done as part of the endpoint.config
command. For source endpoints the encryption flag and broadcast code can
be set, while the sink supports only broadcast code setting. If no custom
broadcast code is provided, the default one will be used.

Vlad Pruteanu (1):
  client/player: Allow the user to control BIG encryption

 client/player.c | 50 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

-- 
2.34.1

