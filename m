Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A942CC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 May 2023 07:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjERHTZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 May 2023 03:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjERHTY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 May 2023 03:19:24 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2088.outbound.protection.outlook.com [40.107.6.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E928211D
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 00:19:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOYAAaTChpwO9FH4FjXWYz5QdpER+5zMtaqa8jyqTFGR9SQ11c88UeLf3CI7tu5Y1i3gMF3yoc3brcmOJQvlsYFUeP4B/q7VIk2elYZ4ub/Av4duE3K5hAml+I9mcHZmdmjRSqLtuVP8WhTKz3jLLfVW6QryVIjrdQPYIZimRy3LOygbtJAiuxcIOLz3rA2Jsb5UnBI7OazLLnmHVsZQxOKou7Uo+SuAjPW/m7Xr4lNRMJ+zhPOcTPjjsJjqk9f+TOfvNfP+FG4M3bmRW9BobnpBuc3MjSYaXvuA5ONFvNg6RiKNZBoT53dvs7dVoktfLy6WvIkYxFlTHH8nSwZb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhaf7WwUHaKa5lObEOAfoJ8DkbiOqMD4DL8ywi3LnrI=;
 b=PRn89yJRBtw9IerT22o7cjuWUrLDB4nwi6Dqq9FB680vpr2jMROX2Iok2uMrKA8AKCb7kF8rVH62DQ29kst6gLHFZ7AbU9g8detj4F7JPBVFhE5oM2akhpWULAjah+cZaJClc0Yd1QQgubKXWBq1Sku7ErJGaK+YuwlXzuKdr3PW6YvRFpzEiRwrHi3cjVOYuLVD4PGIvwY2/TlzB0+WPHqKVDWQ50WDfFRZT/fUoPtQhBFHZ6EqPkHsMY1FFa24ju2lh11lK/LOrA9o+aFk2MmSrFpwufTyaLJfprHKHLu2RYXXHIioS+gCoB4hjfoQxTDfDaAOnFLqtXJNMPiQsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhaf7WwUHaKa5lObEOAfoJ8DkbiOqMD4DL8ywi3LnrI=;
 b=d8dxQoo26qDP3KDW0aIJQQQNm05Unvoxwh7f0cXFoNI9mztY49tEiF1apZPDDkmeoreMB/TM8ymFsm8di1uCjK3ZotBAUZZ62X+i4gNDqu/cWUVSKR+JSmKi8VF+Wp+WQ3V9vAkuZ37AM/drQTN2i1vwjyEssHXN6qSrdXcQCgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB6775.eurprd04.prod.outlook.com (2603:10a6:20b:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18; Thu, 18 May
 2023 07:19:20 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6411.018; Thu, 18 May 2023
 07:19:20 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     pmenzel@molgen.mpg.de
Cc:     iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: Add support for creating multiple BISes
Date:   Thu, 18 May 2023 10:19:08 +0300
Message-Id: <20230518071908.4725-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9c4c67d0-7a51-5dbf-a05c-46103c694f39@molgen.mpg.de>
References: <9c4c67d0-7a51-5dbf-a05c-46103c694f39@molgen.mpg.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0156.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::23) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c01706c-4709-408d-a94b-08db577032db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VICov26oIcFPnKxxy7NwMLWpOpLedkCL+xwP65A+QY7Lv8HTllnTKrwh9ym5cfeKbcAHTtBOA63HoSe1hCrHX7TokBj7VOZLKMZjfSYQ1JiwLs6rTGW2pSH9z6CC+hBbxUrabFI8xAPjssilNfg66ISJl3eJsK5AtET9atecZtVTA16WbhmHQeMNfyLDuX9a8nhJpG2Gp5nRMT5rmmTDWaIc3tFcqQprv09hsuca/+OMTDpBOvi7/iX6nViHWLY2oogjKzrsJpEE5n9i980kBjymVWmuI0w3eeoPg5AP2pWyDDo9O1LTFCC8svtSzUghK2xMR/4NGpup1XCR+g+tkbMdK5oDilcdsKSNeJBgtXhKf+dGRANpZwI+A5SGfA6aR+K3tuik+H8223RNGLsEO6czBWe4RGP8SVngrnnUQJ98zT71Y7mubs28d9tLDSFJ6BlLWsiE7BX7oogKAMCg5X8A/9JQ6XpqPH9xMQnd8i67L2oe1LoFshZoGlNI+n9VZm7G0IIyowcfnTFP3UBhaJMgqiu02vdyiMjpM+OclUJ+BknnRc1lOeunenS+HjlwLihr8I64dY+Z705K1JxgahzVLWBBhlr5QXNIsEzScyTDvbJwnZg2BLZyFyAhv8pd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(4326008)(6916009)(66556008)(66476007)(66946007)(52116002)(316002)(86362001)(478600001)(36756003)(558084003)(83380400001)(1076003)(6512007)(6506007)(186003)(26005)(2616005)(5660300002)(8676002)(2906002)(6666004)(44832011)(8936002)(6486002)(41300700001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PF1CHznUjwDylymc53dmIblABObh4b9sPtqZeyMBvJbiP7Q3Fs7w1teyTn2q?=
 =?us-ascii?Q?mQv9XwshFeogsexjUfIPe5HFkL6TnPse5g9L7SOjPUfz4Xx92r3Um7L40PKz?=
 =?us-ascii?Q?Cyn3FsBjOHgcdddu9vHAHLDFryiMyB/EALzD3RFGz95kL+mbed/LoCxxaFZm?=
 =?us-ascii?Q?yAoh+MOEO9utKLFK11TybCS9+T0ckcmD48EtAeHCDmLJ2OqM99t7lEyJ35Fv?=
 =?us-ascii?Q?UBj3tavLpAaHdsReRoVgZm8GDUlC2vDhmhXNN++YNz1H//ia+x5dXLv1IbAk?=
 =?us-ascii?Q?G2b/LYwmEMKWhOa7AeLK1xfZGsBJZL3WdgXRsQkYONAbaYcKuRNyL7rHw2Xt?=
 =?us-ascii?Q?b49aGNBakFxAW4qUfpXWyTFh9sWeg1rsfMx261IdzH9S/fNmffcp7UlemSor?=
 =?us-ascii?Q?vqV4hxMtuilAbE8ZnbCIrs6TIk3Sodc10EvLU4SOMDogu+2+cSmsV4qiC1CV?=
 =?us-ascii?Q?TSLawqg2eSYE6MWb3b89X1p9Wk6HotC7pGyMEX57H27itqhpjOX8A7zFbECO?=
 =?us-ascii?Q?e/vsjpnasczejIKM2aOh82Zy/bO9b32zY103m7/T1Zo7iOan326jBZT+xQHs?=
 =?us-ascii?Q?rZeETVBFppeHqsGnfNxDmVagB7GnzVjYP5MoSAOiBupO32zP9hJPZXmdZPLS?=
 =?us-ascii?Q?kuNgN6JD0LiSFCKIIfJJDwbeZqtz/0MwvlC7NT3L5UPuz9LUBQyVgkPvd7ZH?=
 =?us-ascii?Q?IdL97q0KLAjhvc+jlIikksF0cA3gB9gz/4L7bG5N75XSvB5YfQwJTxV7nCdV?=
 =?us-ascii?Q?yCshfSdI3grYSCmdJQo48ZPQp+ZK18FNT3Vq+A636Uz33JDfi07WmEJjisPG?=
 =?us-ascii?Q?p1nttnzpOfpZ2yeXaVh1t3Un1cnnTbhVRf5aq3zUE786MKMv64gTrtTUGR03?=
 =?us-ascii?Q?8kOzGAZhLh7ipstkj49zADoTR/B4RLlZr1gec7xdXvDmvQU01THG6r327isN?=
 =?us-ascii?Q?zg4eTJKgtpEk/ntObLb7W5GgpEVZ6AJ2nFOxDHO99Z7Al1nHtQYs/D9uEQCq?=
 =?us-ascii?Q?MWWsFr4phPSqH7bm+WVCa/9CAwUNUf0h+fWM0ynvI3mqDNQ0n0kNux41waen?=
 =?us-ascii?Q?UQKTGxKguBur2FRgvWjYve/Xq1jc59xv+VkNXy84Yj0++H9OJ11VpbjToTR5?=
 =?us-ascii?Q?XZzeWDqkHwsl7Rawj5qLED3tveCrHPiEAGcPR1IPHJP/j3A/N53KqJCDH2EP?=
 =?us-ascii?Q?CmUMijgpLJfizvspfhyFOlO3sxQH4V/KiZfpiP7vwY+idndlL/wsY7Wsat4+?=
 =?us-ascii?Q?M2rr0uJhixyV+pQiJS1wAGzjKi5PRaS2/ydphP4woSL0fs89mHW/QdDStEeD?=
 =?us-ascii?Q?hkDstlX0V47pQhb8JV4FDln3uy4S0fheKHx4PHh/RYdS7ArRUr+mwJbqRRSJ?=
 =?us-ascii?Q?+u5SIQszwsN/vzplmvhS5iehIpA8nNs5AXSrtZFcPoVUwA0ihEEIVpxI5mze?=
 =?us-ascii?Q?1cdE0ulrZ4jMYz/ZmHWHDBfaGHPtx7+htEvoWDiSP+C8ZaXRoP9540og56OV?=
 =?us-ascii?Q?jA1j68xkHt+z8xMfao7aUDKdjl0BEqeAQfBwOsrxGV2ZzTIYSPi/hyBhjl3y?=
 =?us-ascii?Q?1Trnavn6PNLbj4kImqA5DEBKNrgzBc0elRcaMWXqojDionOTZ2ccVm2VIEUd?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c01706c-4709-408d-a94b-08db577032db
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 07:19:20.5556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvuiZPkcTGIebFqbCM3PRlgCgC8yhI6pgpL15CrgOF3Keh2SB95kJRAb/jGTYvfIwWjnIqZ8PTyzeakqROrmsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6775
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Paul,

Thank you for your feedback, I will update the patch and
I will resubmit.

Regards,
Iulia
