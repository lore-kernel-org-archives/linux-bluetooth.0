Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C4FC0015E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jul 2023 12:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjGXMaX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jul 2023 08:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjGXMaK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jul 2023 08:30:10 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2048.outbound.protection.outlook.com [40.107.247.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9DF1722
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 05:29:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bdy8pUN1vhkhJWPb87vlIFUDYFtdUvA6L04AHLX33WhAtm8rGegFWC2f0C3WxJeCfadMsbTjQJ4NpGp4zR2UNJ+xRiSBeuvhPwwEhOZVCNFWj2vSCgVodE23zf+nZNMakon8lrcElWfd2pTX+eLnB/XC36dQ2hw44D56JFeYstSuRMGi/Lbzg7+AsPVZRBWCYNCPoqRprOzU/WT5yXxnZXYJygCEkmN05bHPIN5DgphqaargfEERySRLfYX88e1EPlEyderFVq+GUdZHTiZi/MGVspEyJq2gl83GR9bAXNVPdwGLTKJGqyrT2aLJHP2VHaUy10pvmwyUuqrgUn085g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+Vt/J/BlONsyQ1oMFRrc/CGCw+kXKMyRVDegPe+sRo=;
 b=LEpZrrHUvRu2f1ghrgfw60wAbRSDs9NxXmD6rncyzwmgkTCitY5CEJlcPuD6JoyBNycDeOFhHctuVIreTuwJgJesKu7GuuXMOnb6rGPAKxmthIvJgzJX0chaSHsosmFu07c6hma1diuXMBG/PBk2SO6hagCS8ui/zzfq2xh4z8s0gM+guqqR+rp6JSkqbvIPBswCDGBHeUWuaNe6TuzPevxDPua+6a1knJkMGbuGeUOWsmnv1MkcvwnnsoO0gPEH0lDy83mFs/f+jOQTOOT3KzE+Jw2902z02+SwkVPD5q8oL3xd7qtiHjjUym8wgLIizHcrnpc4+Jfdq0JGrvu20A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+Vt/J/BlONsyQ1oMFRrc/CGCw+kXKMyRVDegPe+sRo=;
 b=NkhOnzq3gQbJv0TtWXbLwntLnyS6HfNkFR67pQCIJMfnD68Os6zRq7Hk3vTmeBm7IIaVDV4DTCwNXe1R+aYXeoAfA7QCV3MLDFpOMtv8Dy01ybTlmaIUBSXI86cbSV9rkE04bYfnPdgSklf7md4d7YJe44IK9p6Q6u5dXyKsf8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by AM8PR04MB8020.eurprd04.prod.outlook.com (2603:10a6:20b:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 12:29:50 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 12:29:50 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, pav@iki.fi, luiz.dentz@gmail.com,
        sathish.narasimman@intel.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v2 0/1] Fixed the crash observed with VOCS
Date:   Mon, 24 Jul 2023 15:29:07 +0300
Message-Id: <20230724122908.42409-1-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::17) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|AM8PR04MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 09cdde38-370b-4dbd-a829-08db8c41ac74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aezZU9zKIcrPjd4SzMWnRUTEU12UojkFHihW8Yh7KIGFl0vKI9802hzoK9ov3yhrWiPOxg6bUE8s/hsmKkiAz/ioOIoWj34AV5D+6PR/KeiuhGX85TYNwwrZlS0/UG5mim7tH9dAU8KwCqeAWiVP4D2iwMxnnkIfF77OLR4cqj9zUv6YJ/mdxn9rm/lFcoO80lbpx9iZQ66q/JF3sDVYqSStHp2Xcwwb0Kp8UFXW3wIXzhJ1EL+jpG63Q3Sw1nQswij5Dah9RC/VPhyRbHrEuyx8kjPZe+kDxYnTIo+mHqz7WIfx3cf+3L/8i0TpVvt1fGtyIOeUe06Rwx1Y6dgGIt5iKZWX8MJK8vHYsxWn/uHewDj61Uf86RCnCDHzbtH61faDsYf2QdTuqPkvx5pK83dlGffqICWkQZ+oZj49EL8232bI+Iu8XK9cYslNgGHrmwa9Et0p/L+Ho2NIsjcH/nBgrIcDouF9+CIau/X9erNpt+Yw7FmUMAeLPwrDEAFsbo4bShJ4Hc5LZP/JoPSRD26Mei3JCzdUtokMD2z77jf/9CKlWZnoN4RJ5I0A5Kt5GKwdnxweit1JWquBbbrAVOx4kU0NfY0eZKzebZJrbKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(38100700002)(38350700002)(66556008)(36756003)(55236004)(2616005)(83380400001)(8676002)(8936002)(5660300002)(44832011)(478600001)(66476007)(6916009)(4326008)(316002)(66946007)(41300700001)(186003)(26005)(6506007)(1076003)(52116002)(966005)(6486002)(6512007)(6666004)(2906002)(4744005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mCpbFJk992Hu8soBBybiyKKxY6yn8/nG4eYbH1QPQY+5z6JTAqaQbHkG8mWj?=
 =?us-ascii?Q?NKa9rH9ho0o0IV6Cr2FB1b1A7z65bYKc+Yb2e7PnBMHXnE/iIAJUYe09vHbd?=
 =?us-ascii?Q?mLu8jom0TX6dIPTwwZUyRaV7Eh3xnaxxqEenAGWBX1ePrMVLUFpA22YMBdAs?=
 =?us-ascii?Q?O3GqdfV8HlfIyYY/tpWwh1dZvImau29kXGgcAhLXiyFAvR7BunBqG6dopyL9?=
 =?us-ascii?Q?CF0xJPEgAqW8/tl3XoWZWMezZlvrSbpp0AzlTckLwgxad30mCAspv2FWNGwP?=
 =?us-ascii?Q?jFQDornEmvFs3VSdwqa2wic5DY4zAvir2OxGcp5c2F416mLaPe0WCwi73yhH?=
 =?us-ascii?Q?/GFhZv66VfjRygIaz6Hx+FPT9Vrdd/4c8Z/z5GdeQG74Cm/mor7vAJFGjQ1V?=
 =?us-ascii?Q?yN7tBxBUXm/h6fNC62ScAkfRzzMMAnhlPqXF5oM9CCTkSRC5alD58X5clqte?=
 =?us-ascii?Q?Ibuv1WDyMiXmDHoE9OTs1b59/zAfcv3s3mh8X/vrJjvIs7gP1Kx0WPP5F5sV?=
 =?us-ascii?Q?5+/ouWb+9bEd5O9lueiQnZ71I//rRJ49YXSLhKIrcqVir9OnkUk1pJxZVhfQ?=
 =?us-ascii?Q?zxXccVtTDxG/ZSP8mjXAI2+m//090/ZC8KEmoU6NvOAH1lkoXrRiTyOSZ7EV?=
 =?us-ascii?Q?TaFYZ1dB0htb3heFTpn/2Afxk/L3HTLZUda3EeRhIe+f58ImGctnBWlhX5rl?=
 =?us-ascii?Q?NaXsyqD3suukiR4CDrgmZ7nsHCV1UXOJ1DiI/97jQfCQzHW6egSPTKISbGnC?=
 =?us-ascii?Q?SDEaPfSwXHLlta+HEBdT+EUN45bLrFCvrwwOqfmaFXZbOKH/sFTqgmsU4PXH?=
 =?us-ascii?Q?z9hmnJSupysVikrmeDwwp+C04Ar2GlfCu2d3HYowIb7mDTG0U+eQayuFVvSu?=
 =?us-ascii?Q?ePmxlJkGNXAl1+cMz39RC4P4gGLsCoGr+9JfQIwu48YyWStcyTN5PRRtbdpj?=
 =?us-ascii?Q?cXphAL1XjDAJ75jC4mYk5dRyc1OqgorsE0K3hARNPae2dEV5mOZhT8spmQyB?=
 =?us-ascii?Q?RsNcWQd0/lugmiKB7VIyApHgf8Xc1/3aCOOEv0qyvE9D/0EkCKFTsP3zCVLJ?=
 =?us-ascii?Q?QBmuRaaV0htViZahf50wLv27fdzZPBX8BfCoD2XB7povuHWAKbeLY18wHOxS?=
 =?us-ascii?Q?vCasmqhT7Fl7lyDHXb80jBiYmIb33hAOXRLW7FmP94V2zULPtmn4MKfVgRP/?=
 =?us-ascii?Q?bd1u/7tSzSqFiLbsXODmzKhlE7O5JvP91k59K9+dBuRN29rcovn9gGnyMN9i?=
 =?us-ascii?Q?oIiPddb/guMImJG9tydD6Ae3JGbw8QPpmgh3e2qZeGA4A63k+JMl5HwfUFuj?=
 =?us-ascii?Q?ModPQ1VJuKX5csUuRrebZWzxq2hrebleFUxudcSPQirOFH1kjxqc7H0Xt16y?=
 =?us-ascii?Q?7C1fc+Tp7j6cZHTbUSVxVkV7ovqf7vfb5K28ECXAWGytRtpOpN2on1aRlrlS?=
 =?us-ascii?Q?5Aer68SvvJ5ma1xtVRLqkXxPV9R9kErSmUql8v9L+UQ/CKZcPIBOhpj1KjQG?=
 =?us-ascii?Q?WX2Q3D4jYBlGshMm4ZpZDD91RUxYy45imSoHtFx0GGlC8zvDq0icdbBvKe78?=
 =?us-ascii?Q?7JIiVDnDbWCvbh2Qc/cICm/LITugZuu0D2bC5RXP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cdde38-370b-4dbd-a829-08db8c41ac74
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 12:29:49.9762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEe1EhdYySRgQIBmeR8rmDvgkw4HXDGomXApv3R38EdmWxEHfIr894+9jKvatitLNLS1n3mRiqUkxIriJzEcUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8020
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers

This patch handles the fix for the crash observed with VOCS when trying to pair with LE Audio TWS earbuds. 

A crash was reproted for the following patch by Pauli Virtanen <pav@iki.fi>. 
Patch Link: https://patchwork.kernel.org/project/bluetooth/patch/20230612133251.194-4-nitin.jadhav@nxp.com/

Root cause: 
- There are two types of database- Remote and Local (rdb and ldb)
- In client mode currently the code was written to access ldb

Fix:
- Correcting it to access rdb has resolved the problem in VOCS
- Same correction is done for VCS.

Thanks
Warm Regards
Nitin Jadhav

Nitin Jadhav (1):
  shared/vcp: Fixed the crash observed with VOCS

 src/shared/vcp.c | 52 +++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

-- 
2.34.1

