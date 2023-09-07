Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D3AEC873D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 15:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjIGPl5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344180AbjIGPcj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 11:32:39 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDA5135
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 08:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxC0dqGROmI/WK29VHkQeJmKyqgnzRhLnDFBMyftd/oa03fpUScpFfbXQ+Uy7nXqtxrA99PG6B/LyJoeTwC8WmoUS/D09jQ2R0G0N7pqkzu2mEuF8W/qo0RRs7KryU1yZzD0vQmBtJUhe/6ax4mz2fTzafJML4/UszgdFDDqJy/jRX5k/mge8A9AuYHz9d2OcQ6sSMkpFTi4o1PqCQyH8clxktEei5yGLC6loUvOWkmnObt+1fftYd6619KnEsnGNNIvnlQix8ijsL13tx5wvetxwHVPN2c/O1nUnpnh65gemU9onhqDhwvGZm0NqFwptVsNP2KqjjQP687Dr+78jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvNN+O80hO6Fs5x2PvCSam+t2/Dts/HoBeP8i8Wc/VA=;
 b=UzV8+/ygwhk7XKJEnGsNpjAixYFc53lTL9ZSrTlRgiRAUqBmGV0FqwWbj72OlaLCEu3RrCM15a8UqlaU3oHVuEjT7Ow2T+nEfUIWxOmDc99PDKB4DgGWZZiJv38DRVeTE9mChSz53nDZ3UmMGq7gYTEbrfN3AYlAhEnTK5AJHDTW1Rt3Bd+1sLzMtzFvjQYUDuwmchXYPejbNU2FIBy3ilWxU+CWa8gBgfYnD1MGrJa7pFjHTyMOlwPXkGKH9SVs7sbOg5u8c2/llbjW/vJ+fYRtbxpDChNsmhZT69GsUccu32yCEgk0OwgpBfEhrgryquKzHCdT6yPGV7KCy38UDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvNN+O80hO6Fs5x2PvCSam+t2/Dts/HoBeP8i8Wc/VA=;
 b=fduxqXGajO3S5dwnREiS/Sm97TaYi3KySh2HqVd2cjI1PQNa6ukL4iVyxyOsekNHlKmT56SzxRFZVchQTAbLWQrXyqWggXZEoEc0cA1b5ryPKfCUMUy7H+zh1A/8DUcmmjl+auKY/AfWCZjIjmQ6YUoKWZG60t4sV22yf480heQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by PR3PR04MB7402.eurprd04.prod.outlook.com (2603:10a6:102:89::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 05:48:22 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 05:48:22 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH v2 0/1] Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID
Date:   Thu,  7 Sep 2023 08:47:57 +0300
Message-Id: <20230907054758.4893-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::22) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|PR3PR04MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb96108-f0a7-4538-ef46-08dbaf660bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPzpvIrVEyD1W65KgMhA2UBsR3mqvff4eqHJPXeRoa4zgtQ3ACxP0uwKIjgK/NJE+tFvg+v2PhqHNMKravtG2co2qc6Q1EJGSAcSlzhevFFO7OkzMMWwdXAQGHv3XvpDHinJLkQYhg/58NcrufygInGcBtkaAG+qOAcddTiyx11JqBXwSxcxUueVpLzzXJMjRAv1mwAKAl3a6fsrr6CdRKJFKVp6CedLHwgFEVI60555P0VZuC+uVTufVWY9e3omph4VJfYYxwu1yNJO0BF/r6G2Z77WizQRikb9J1nT8sjlsGcFDUUTlrzB8qpfKsCQIOPdE9uMAuIfQx12i/pk25MW77oXAywUsMR/iGaZP8mPSkXtFz7U4XkOUl2U1ao49XNH/lOaQbjTnc7dwGdFYkEZsJK079lTKrSTcrADxab+xS10unOn+pqQSDUITEKMgC3E3bhEdHPGDC8yro3jL2ePmWzLP3H3hL3I6CexjK1ehv3BM941saUAOdyE49cwTwQCGReZrNwRG1F1Y17y1wY1XEEa2qlhDEXqcQBMMVPFQ0y7maaJdQpUE7IDL+s/sRQYaPZzD3i6A0zmJmcyklvGt5EPKmae2975m6JoCLeFb3UeQiW7E68BqarFhap3WWXIfdI66Fnmiva4E9HRyXCAr7+08jaTj6j67gvR6m4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(186009)(451199024)(1800799009)(36756003)(316002)(38350700002)(2906002)(52116002)(41300700001)(4744005)(86362001)(38100700002)(5660300002)(2616005)(8936002)(4326008)(8676002)(83380400001)(26005)(6512007)(1076003)(6486002)(6506007)(6666004)(478600001)(66946007)(6916009)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1QpixgVbO+sQD1Iap/Y6TL8wyJ+tuujRu1wtftqxDmSK70x4bXIcx60os2DW?=
 =?us-ascii?Q?F0A1rP4ntnVhFfmuIX1Vj0jojN0KFImDKnx84I/MCeqNyYUt621rjqSWsjam?=
 =?us-ascii?Q?xtG2KMDOmBgGl74Ib3fDnMgEHBvdDB3eYWbSLANCGBXSKGmJAdSJ875x8a/F?=
 =?us-ascii?Q?8hzZwCigFY32b/EQ6fYvmuCXggDs1z4UUO2lXtDhEomSI//K7rlGw+Cch0pj?=
 =?us-ascii?Q?VKBDKJq2uhu6YX5orwP1syWY8EaTChyfC8U5kVt4fYq9Tm6sQT4aDXbv0XYg?=
 =?us-ascii?Q?k0nv6Q2O0xgcDzEVq6hLCyO/3xG0D+jAFqgbr3myEvLtkZp2RE8L+uV8XZre?=
 =?us-ascii?Q?wl6UdLIWbRRTj3kyMD0HcDKicBoFArvutgUEBTZ/0GIMM+o++bP73d3kCx1e?=
 =?us-ascii?Q?qOL5fjqr8ZI6WF6S2nyvlIqKSKSyvDd10PObC782OnQJt2sLzLFktMX+tk/B?=
 =?us-ascii?Q?fyVe4o8ufMyjRw3/cnHT++VtAvFJ3Os/cZPKvmitjEb5TNMzAWquUTBxxAkX?=
 =?us-ascii?Q?jDVbo9Xk+CUiR/FbaqDR5ZSCqgBrZgwrtySEPCfm/mMmwBxxdW0fGoKmP4aS?=
 =?us-ascii?Q?9rz0U0htzg92o8kWjMwhZ8uygsuJAx55KWYYvh+S8APMbTlMFxrLAHfAF8q2?=
 =?us-ascii?Q?DNysxeo40TAYbrF/0jp2pbe/kTzF6vGz9e0whzw7Ipb03woKlUjBMWGXfYc0?=
 =?us-ascii?Q?aTyWNx3byny0viZ/ksXa1U2fWrN01oOgqVxtOnA9tbBJRrm8/o6kK1DQVQ1X?=
 =?us-ascii?Q?LMWnKRtatqlL5tDUhhWbtT2HnSVuhQISjnA86rGq501g7IR/whzU0ZF+OFOH?=
 =?us-ascii?Q?ejbD6hzp6HvoGb5nJ0ReOBm1EgKSEb9KxxgYjOeIeB0aTgHfOQd1okvtvyBk?=
 =?us-ascii?Q?QgggeStQpbaWiAcD60jFCQNyrxaCh4BgF9IMnwWAEQEPCxzKzJjDYcO8cToD?=
 =?us-ascii?Q?tHaQwomCOS8WSvlDKJxXHj6ZjQqdYFdrLiFa+O5xHCBCbhulzuLDOTIQoVt4?=
 =?us-ascii?Q?IMsu+IyRyR6LxK4lpDzemdKIamC1v4InG18VSEFA8egxNkBgz9ebUszAkZSM?=
 =?us-ascii?Q?nj1zaZg+0LjWGBRfqOOkAOdH1AOrRae66YDsXqOIyhjqEKyz4kAjyK6C+MSu?=
 =?us-ascii?Q?QWABqKzUs4uN9sbYbkJ5Sc+lNl4V74ZV7u8y0RlTA9CsQxmwOcUXgrCqiRcA?=
 =?us-ascii?Q?smD8sU/pA9g9VUq7ndTfSxwO0OnKERuiLlJ8XwBBYJhJZiNdPFoU+GNJlFlI?=
 =?us-ascii?Q?U9XhmgkG7XTKTvGf6WBvfm+txvppEgSWqrqPQ9hcNPPeCRPCa32VbKWQDt/h?=
 =?us-ascii?Q?omoUAlvyHjh+JTJTRBcmWCV19iriuUzJ7XlekS/UQThoCmK0P0lhDprgPt+h?=
 =?us-ascii?Q?kwq33m7HcJHbNXoBBRLQ0ZxeD6xXfYzEwywTQx7zhr9qlpOXO5kniJPdvBgy?=
 =?us-ascii?Q?YVX9t0poPh6dm2XJtl4lA8LstYzc8XFym8uP8RN+dlmqLJKolaoWTZnR4S7o?=
 =?us-ascii?Q?Lcx5wIlZZy8NpEnELWJaHK8JUiV8P1MoDoMFYUo7DiO8CWP0vIBQ/f20Q8Ys?=
 =?us-ascii?Q?dnuV8BDCv7us6Now0vi8fgq/fOYNMbesAC+s1R0T?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb96108-f0a7-4538-ef46-08dbaf660bde
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 05:48:22.5916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpgSvSH6cTK9SQJtAz7efBLQj6tGtyNhFhYhX7d1b2Aq0FJVDO5V5s38jhbuJA3LcUWRjQu4IosJkIbKjij0Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7402
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Copy the content of a Periodic Advertisement Report to BASE only if
the service UUID is Basic Audio Announcement Service UUID.

Claudia Draghicescu (1):
  Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID

 net/bluetooth/iso.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)


base-commit: 52bf4fd43f759ac4698f041fff2cb27691698265
-- 
2.34.1

