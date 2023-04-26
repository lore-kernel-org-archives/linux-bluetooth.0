Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDFBC77B60
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Apr 2023 12:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbjDZMm6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Apr 2023 08:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240730AbjDZMm5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Apr 2023 08:42:57 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D0735A4
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Apr 2023 05:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyYTbzlsxztCz2UOglTF1NtLUz5GXahvjcnHNKmzCA0PrnkcrgPh132lgGmshpSNUfF4DoQxbRzHckLTQT6cnhe1HKfzTp5hUQdvH/nJLeFxi5GVXeOpvwJBq5zM+/4TcdUXGi8l0rUNlQF1Khc3eVCgzrf/QxXiNLKEqStsHIGda3yeW+yHYUkSlSju/uA12/0R6nLWwErba/vfISiiMgqxeBsmQnNKSYPnMgAa/28ptjULS69Jhbe05nIoteblrVKnTzi14CZ20A4KnNvqbPcnjDAA6GmHDoV+wtRJNOkCPCrF6UG3HZapt4T8iAcTyE+NX3XIS6SRVf4rQ/Qyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VRsPK0S0P9tpk3PEUgc0Xnrnuxz3tOnTB5jbKT28kk=;
 b=LsIdGPzqTUqkmaioZD2r0WKFAOkEul7VhOhg47H/qlgNf5dMhEUoCqecXK/XrdLzKx+5V3FGNFGuDcbo1UWA9x7St615tJIZ5Evi3KHkYk+3LqT5j52rJfK07OJKVT1Gg9MaMvNlA1hb5IT+rn0EvQAqAtUmlwzY5p5nl1orOJCZmbiAI0hrVNKAd9tUSN05r/S7F68Rgd3sMbL1coO+GKF5oiFpWc98IBVxB16JQfHHLN9oH+blar9KQIj/i3T2/idSTBGl3MGZsAIFn/JOPoFIZRVRcjvf/9g9wEubeky6duu2vHX7D+Qf9gpttFzYzlsWXDONMO7+Ma89JKa0NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VRsPK0S0P9tpk3PEUgc0Xnrnuxz3tOnTB5jbKT28kk=;
 b=klHdGAhEoZTvaQzt2aHr8mrs4NKD8S+iif06S6jthTspkra2IpuyChMmBbWol4iRFOdt/HXR3pCgjzaXiiGBIwFIanzNtWjE2rTsFUKwdgWYAa79zEUfcQUIzPpAM1Dbz1z6Uw84N2VQie7O2qumyR7eWHkDte/domLgiWbkZFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB7830.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 12:40:49 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 12:40:48 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/2] shared/bass: Add initial code for handling BASS
Date:   Wed, 26 Apr 2023 15:40:33 +0300
Message-Id: <20230426124033.22297-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZK70qisom+iSyCoTh2XF70zNAcZUN6bKT2G6k2RoBRq8g@mail.gmail.com>
References: <CABBYNZK70qisom+iSyCoTh2XF70zNAcZUN6bKT2G6k2RoBRq8g@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0084.eurprd03.prod.outlook.com
 (2603:10a6:208:69::25) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 6463c66d-096e-4ef5-20b5-08db46537682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8nr9O3vjOuj6ZgUai/0bLoPOoMEzALNHc3iAwQLqELn+osbC+XKmT+eFZIjoD2t0bzZl56QMH50bPxQr37llKDfmLMVyPIVNRxKb83Tlu7VTrpXFWfdgIx0cZsOFcbQ+xkLibCLgCf/0KjMNamqapE8/9R51rFXItmbwWUiBRdPysXMjQPFXDvRZFcN0Guh2lYLua2STmmQgLt/yubzeIFZd/VNEuH20Ms969VNcnTNnaIH0h0bQYVASIhJKg6B5DxGOByULPYSjZOnAAiOVEkLgjU6BLNJI/tsBCkayQwQTGLvLRi0JPlajOcuvZotwiEB1M9uJc/R5nliGbOQA5HkSpIrVAI8VillZGFh/bvX9oTKuEhn5YIoRlkISvmsXHaxqT0PbvPvgc//i35/05x8wpf/IdC0lzJxbtzsV3W6XuAEu5gx5dsU1aGRPx4S9KIScOKc91J7O6WuOSvA9iHfc2eW2XXkCHoknrRKhfoqyiXdMAyoQt7Q4U8tlukeD+F7PEJ+IqVovnzEpX0wLzP6lUFKj9oTb0eA2rSIRrxilm9Lw02wynSOWgi+yIH87zVSfMTnTeSHX2Wz+WqXZ0+Ot7GZNu92cDaOaT+wwuN0NVD6aUIKqN4OzWFpgk3Nq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(6666004)(6486002)(478600001)(52116002)(6916009)(316002)(4326008)(66476007)(66556008)(66946007)(2616005)(55236004)(36756003)(6512007)(26005)(186003)(1076003)(6506007)(2906002)(4744005)(41300700001)(8676002)(8936002)(5660300002)(44832011)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H7JPUmkIUncAc/teYAQlWujtwTKwCJHfuJPCvjCcm5duRXdvjoFtceynCQaI?=
 =?us-ascii?Q?1RyGF/rP0yiEK+YzmC6x76HjVgIAZSMGn2cHzXhu4/o8qTNZuiRGyMF9Axu+?=
 =?us-ascii?Q?UXrqK6PLKLPc6SvyMNkNGI+LqLVSi9E8HV4E91E7W16gawCZJ5xiMKRWlHXV?=
 =?us-ascii?Q?yeQkJIX5Yyhy1BsRIbuDiP2zjIicfs2uXqIbuPXeOCkRXki0QJhtYQAxdvDf?=
 =?us-ascii?Q?x7pT+jdcsg+WqvKfF9bzIC2J4kmqU6wRuxVN6T89yT1ITaJKUOdwUTx6cXT3?=
 =?us-ascii?Q?eozJyhcZb5MZrpnNvPjIewi53RZbb18XDGM1IC40KiJiA/4wMqkfkEnkkOka?=
 =?us-ascii?Q?DwMSIFwSjWmYePypUBe6nH1FTRrOyAXDNkmGQi52t8qB0e7eGwwLkkuHsaMd?=
 =?us-ascii?Q?6kLpfxerOmON6vKN9SeXL+zNcHghYcWYIDkgD0zVGTZ4mZG2WlKVoBHI+oqV?=
 =?us-ascii?Q?4UF/ii7Sk3y/DhjP+Mze91pqu6Dukr2ruVM/yIywU8v7+oYscSCw6EjqdJET?=
 =?us-ascii?Q?bwOKdTtpAPUE/YGUhEDxiFnK28Hj9AeV4GO9NHhDOGaP5kWtgY1xQGEqeMiw?=
 =?us-ascii?Q?Gb0uXSx+JAOZZjs6fmvm2fXZgjEOrUt4n5ZqL+3xfayS1aeWuLQjU8lqfIVr?=
 =?us-ascii?Q?AkIzvGjOCp6gIFirQ55utXtI8wOg1zDygRTiaMlnOZKhlpMTN9W+gSoSmvq9?=
 =?us-ascii?Q?/U6hsEp5z4g4G5kl/qQ3gn44gSCcXYMPYCetp91qNiGwK8aCe9AxNltzBvFd?=
 =?us-ascii?Q?TOyywZ9b25ZMhSsyTMsxMP5c2h1uFeGOUtf6FGmXTk3acvtixFBOZHvb4AbH?=
 =?us-ascii?Q?XlW2qaa+INR4O+9QCNQZEEPl7dC5QpAhkh3NvvDmuhWJ35OoKFipzq0KLYM/?=
 =?us-ascii?Q?em19F68V+Fs9wiG1BewxPxrn1QZtp8KWz2VxF3o7uZGeqnYnB7XM4aACc0AJ?=
 =?us-ascii?Q?1K9asbVHHYTQ4i0jZyh27E+5Xyk5f37e3hfff9cdhMFY4jH/R0Xe8hBkSli/?=
 =?us-ascii?Q?Bv4i6D9DdEuH1iXRpHYTYFKPi1AWPtZjtdBgNXMLzks1oYJb7Dt+61NEn0D5?=
 =?us-ascii?Q?0kbUsX3G8xW/4+ndQ+CfXJCiYG6TT+9ih8H9ELwD6yfCDlBuxwJPnyurzamv?=
 =?us-ascii?Q?SXOn1Pzt94eTfsF+rYaVra/x+tepNQy20YB8qf6023F6EZaJ0yL+YH/XuLfR?=
 =?us-ascii?Q?h+Jid7IONBZFo9FZQFunJmOjP2abPWBcsunnQY0W+tOQ6yYJ+W5OU/yn4x+q?=
 =?us-ascii?Q?3ZhQqqMPfu99cq+juTEQje50jdR3yF9lWxT7o2o3MBy0Rv6KR3diWv6GclQE?=
 =?us-ascii?Q?NwTSw/1uOy5Tg7CeO4QA/TjnIgwbaB3C64+ZQXP/ZDzo0f5eYLdVreBhUC2N?=
 =?us-ascii?Q?/GZu+k+Jd/uuUPgzRMdvQOp5iI0vSuWKUSJjiNiBLpJlc3QzOtjKitIH0My4?=
 =?us-ascii?Q?yKlbRvuXiAFagGzh0CBoECLRepV1LC60Jjxz1m+YcUwd1VbXROa0znbHHwkP?=
 =?us-ascii?Q?EVpa9ME+M/Pi7/iI4GtKIWHUpZl6e1iSRKIrNxzDRS6PCAVycsHKujHvG1qB?=
 =?us-ascii?Q?UdlZdh5jBDoRDi0pCX6kkXFBEtolJ4+oV8eNQj+WUvjPmV/DHYXO13PmnMZF?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6463c66d-096e-4ef5-20b5-08db46537682
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 12:40:48.8694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2AoDzseJwDWpFMLnt4xYoqgcj4oSVdMZGXKIeeSN/0Lr3pnPGz4/gbaVzl1gH32H/xiLwRKzjHB8jAuF0RqrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7830
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thank you for the review, I agree that it would be better to implement BASS as
a standalone plugin, in my opinion, instead of incorporating BASS Client as
part of BAP and separating BASS Server, it would be even better to completely
decouple BASS from BAP, so that both Scan Delegator (BASS Server) and
Broadcast Assistant (BASS Client) roles will be implemented as a separate
plugin that may or may not be loaded along with the BAP plugin.

What do you think about this?

Regards,
Iulia
