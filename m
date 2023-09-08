Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4907CEE57EC
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 10:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbjIHKHz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 06:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236579AbjIHKHx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 06:07:53 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1CA1FF3
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 03:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obw4GxoZBb5VScicM6aT6IouFBXVkP11vuSDVvbyBcNAuNffMrosBiZcyaJdRCTkcM9CWM5vK6MK9Y15PXP0mUks5EZZKeEATdrasUHR+1g0OsYeOvORQ8E6JbsvRIzgx91ahrQwEx+ASCR5/BoFdcpJo9uhGKKmYX2jGQlD9YPN8icVRFGKNIP3cEkHCztT8Qg1M4pY0XuEUhpmaSWYDjG0eWqoepGdtOpzgY8M8DlD2Gd8JjkaZTU7HfSOvAnJEiBRLvLTYuUUUqXyC/P1LWSAuXHxNoUkQhI+Xu5I0MTNaqbI62dyF3EAed94xp6Ej2AbysKlhoTYwxoBeTI+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEJzTyaQu9XVLnMtJfW1NN7ghoonjf3+4R+PAwq7G6E=;
 b=RnyiZGjvQaWtYK/k7dmzwg6Y9InsSux9U2cEBB+JYZ4U6PXrHrSYYSDS3LItDVNMznYV63Im6QGYFp43CZGQE49pd2ZcVpqQTLLQ+vCPsQkTqntMZHFXA/Tti1nww3Nx30ugSNZ4PFPwFw2xSdo/dJlFKmuPULa7Rfu72sWPEphcXYp4dtHANesKzgvdtOPvLg1FbIsREz358Fz57fguzECkcboz9taU0LojuSrqVo5Mb3WrbuDAirhnQq/stZik7A9Kfx6eZaDSGOYiSJPGLZT5KXIa2ODeGbUFGlPYW/b2lCsNsCKwoDkRB9FhCQS6Rz9wYAlP0/ejSiA9NLrLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEJzTyaQu9XVLnMtJfW1NN7ghoonjf3+4R+PAwq7G6E=;
 b=mwXNPApsqOu4QjIV1p/v5HYSgZFzTMl4YpwTfm9GEP1kmDChBs8/uBbYwl5AB/P/r9zFKErh+wxy+S7hH4VY+qxAJq/SEsVI6Ot+45JtSDAAXmWE/YfBrGpmWa1bySbHC7wWlcKcIFCowtXAG2cyVgH6Um8RgB11R8VgR2pWEC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by DBBPR04MB7755.eurprd04.prod.outlook.com (2603:10a6:10:1e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 10:06:38 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 10:06:38 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH v2 1/1] Bluetooth: ISO: Set CIS bit only for devices with CIS support
Date:   Fri,  8 Sep 2023 13:06:18 +0300
Message-Id: <20230908100618.63986-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908100618.63986-1-vlad.pruteanu@nxp.com>
References: <20230908100618.63986-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0079.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::20) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|DBBPR04MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: 17da2fde-ce7a-4ccb-0935-08dbb0534a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jdy9r4C+AKffAWnqMuaRGul+nbjd2S9/Emy6+sdIwRM/V0XAF3SE27Kbg0LaD95Ph/3+8onLsiiBPfSmd1tbSIkVLfw+zVqLaG3Q+0o+DeZfTUTCax035OtDCDa2aKEC82pdHscZ51X1wnNm96CQhswdqOLmB5G+ITVf78hUWVkVftp9oc46DHf6doEZ3UByevExLgp0/H6c7MkwCdlBy6UVnCcdm6+s7LCblkN4BOQQIk6e4pGe1ol501wYYcXz58dYsP8Xz200EM0xhFC0g3d8h+/Rbe/i0H2AL1fQ12Vi3rmjnBViqnnXx05BE7Laxuf20kXN6jmw9Oelhg4k0nzL/KwO8y3f0nZnohTAZ/Mle/5hzwfjcTUaID/ihKnJ4TpZMLd6IVR2Y6f/gNqsPpvvImLuQSPxkBppoosuYgBlhVprrSKOtAo3rYPuUMtRG8J5zCydMs92teBpRARVFrKrbFss820KdUwKuHG/uPmbgRhhz85IyK5246bJ8l0fXwDFj3zXm29PIwrqNVjpSRqN7QGcmDPQZ4Co3XUckf89/WIxRiXJg5UIOCuIlH0/FnPSkq/XMuGmGq6tt58DEH8Dg76CEnYhYJ7IXZV3N16C2V0CdH6JAmUgU4IUAAnz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(1800799009)(186009)(451199024)(38100700002)(38350700002)(36756003)(86362001)(6916009)(52116002)(6512007)(26005)(1076003)(316002)(2616005)(5660300002)(44832011)(66556008)(66476007)(6666004)(6506007)(6486002)(4744005)(478600001)(66946007)(2906002)(8936002)(4326008)(41300700001)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HAT0/381Jnyv9NUBjiCPMUzX9IfX1l+TU4uI5l2jIUa67Iem/mygwwGq+fDW?=
 =?us-ascii?Q?njnYgYKQ48791ngevflBZXZrcBEE1+YfdG3QdVBKbhhz5t9+J7GBFa8RzYvI?=
 =?us-ascii?Q?ml6BFk85s9kD4NH7FTs+y6K1Z9yYAtRZrquulpLbAIPmV0zXteDUBcM7awA6?=
 =?us-ascii?Q?rqzODKOg1VxoFs6g3Nq2K+ruekG6xcaIrqAWvBbUg24yNr0bJLFrNBOTFB0X?=
 =?us-ascii?Q?whG/anyKn4uHMHiUNlGFLI2HWEhy1MrWA4f2Pxdb/SOGGl0hAE2BP5tKZHlO?=
 =?us-ascii?Q?uCyrn4bu68FUsYhpsbxfKd2SLqomJYjCLG11vXjbrk7/Z0/XD5plaMHJKPJ7?=
 =?us-ascii?Q?CfQC+2RTaDcmgXogKO48XKpp8/ZARxNcg2veDvrzyUBEb+PqqUNSKRTVv2aq?=
 =?us-ascii?Q?ZqtZFJcO0qUOuz9I1W+ScAePvSDMG7IyrEqreIvTwznIrzw0VPNhscUUeXJC?=
 =?us-ascii?Q?cvELTLkxzaEpr0RwnyvTb8xhq5Q1xi3yppYZBRdp/yhwxwjLbkRnMoxtKm8N?=
 =?us-ascii?Q?XfLxU4wV5KWMIH1NfignDhefnQQxxFgS50bYVraR0sSZ3+j0bdfi5sGFKN7W?=
 =?us-ascii?Q?iOsoxBAzZyh41MPUb9ujQcyJhS3ueH3IVTtM7b1NANr71FvzGONbfr7Lofd5?=
 =?us-ascii?Q?RMC9i2kWI9vQ58cskueWnR4BPRiOWNXLs4Pynd+ko80yywnpK59SomUjuQvR?=
 =?us-ascii?Q?Wa/j9GE/jSHnbHiJ3wMXV6ERCE8e7usFKx1OTX45EFNX9yJ1sm8Cr3j3Usgq?=
 =?us-ascii?Q?XxZrsgKGbtPMFcO2BNtbblTqKZ5r8lqIRRKSdmycINuYgAsTN+8pIYTGy42a?=
 =?us-ascii?Q?iwiQhqhwNZlh2WfMqzwNt1DOPKZdwru9m0uajEEbTIg5I04ZIYgRB/12QtSg?=
 =?us-ascii?Q?1OjhGSm3Dak93ykQ9tz2ElUAuT4OzNzC1E/pBy1y6W1B4TcV49/16giOhC6X?=
 =?us-ascii?Q?DwiUa/hqJ/arc6P/IZNEWvvIj+kbviceWOOQBJf8I65m9/p5Rb350+vFYWcY?=
 =?us-ascii?Q?GGyc6e4ghBFY5RxSsD4E4OM3Pmm4dOeQSeu1FCb30cmf/SbBTjBVkFBjJdM3?=
 =?us-ascii?Q?sNeDJPhmlSPlc5GvkqCKEM+BcMud7UIXdfVu0Dm70sroKXmKZXK7aUO3lK2X?=
 =?us-ascii?Q?HhxAwEeDn8/2zybdFL1TFDaaM0RsMPhVNKTIwPxrqc7N0sl39z62RoKX32AV?=
 =?us-ascii?Q?Ln2r4r+gFeQZcjxkK0pL2OKFHIXwocizN5k5oIecosf9a7TDb6S2DW98wQBu?=
 =?us-ascii?Q?d6ZPZUv9iiLfV0Ma9rJ9pWYhWVKCKqo5jPPD1ee/CQTJZJWficx1xn/hL00l?=
 =?us-ascii?Q?S3+8kwkkpRl2ebUFy8+HBoc7IpkvL9mvgAjMp1rCXsoHTqu4QkoSHf9u+YmF?=
 =?us-ascii?Q?GIGjkwvjMOrv2jg1NyyrutAQM3Fc4txpkcXecFogPMAu2bL85Ey6ySRuILke?=
 =?us-ascii?Q?i3hcVD5iwNiIflshwo2MBuOUGnz8tAz48Fyrc/IneByMrkS1zHbcfobprZgb?=
 =?us-ascii?Q?VArC5K1hFN5pGZAqvAIF5nrqANNJZi+jk6Q3JLXCb+gVNpfldbdVzhMqrzK3?=
 =?us-ascii?Q?MLRI5HFXFg+mTqGh6WSqDRYjmTvDT29DwZSOXzIPBmnJ8lrDt2EN0QTlgb9+?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17da2fde-ce7a-4ccb-0935-08dbb0534a52
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 10:06:37.9923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eons0yFmCUIUOg3/Bw7D0YVlXuJaAwrAVYqrfW9TOXPBYrVQNaAp0ziGwwkqA/fK2klVo354SN3XSY7t2UDi+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7755
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently the CIS bit that can be set by the host is set for any device
that has CIS or BIS support. In reality, devices that support BIS may not
allow that bit to be set and so, the HCI bring up fails for them.

This commit fixes this by only setting the bit for CIS capable devices.

Signed-off-by: Vlad Pruteanu <vlad.pruteanu@nxp.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ec4dfc4c5749..f09c5812c247 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4264,7 +4264,7 @@ static int hci_le_set_host_feature_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_le_set_host_feature cp;
 
-	if (!iso_capable(hdev))
+	if (!cis_capable(hdev))
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
-- 
2.34.1

