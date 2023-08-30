Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435E7C83F1C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Aug 2023 18:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245644AbjH3Sxu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244614AbjH3N3f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Aug 2023 09:29:35 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54521B0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 06:29:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzdzdRQshFYff4MegqniloSxIDtIfX+M/8u79Z9WyL5cTf/jScbRpB6+lD1DEPoKhFW1upYjIsj50LM7YWuTwIvk0BUDAXpkD+WzMtdeUpNEcjdunnXPa9JcaEaktp1iNqhobUhqpSvckJUb4ojZjZw0VsGLpW5mPgINjcc/cE1MWKbWlif+ZEdtf+IpStLT1sLzrY0cidUwjHN7r1ztK1g07L8IPNjcbdSxKaF98k6P+hK+pkQKoDMKmfwmItza3Ku0ZmrdBjU0apcHtz+0NBvNz/0yfw4kCuMNtWC/EvpPFEdtDF/kS6AFE+hmxdPqdOf6CRH2h5kDr0hQ8cCBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XEtmuGwrcOlVekMN5ijOgZ6nuLOzB1f7LLAkFG+/cU=;
 b=CuDSu6hYVD74Vs3ZWY7FxjlhOjULb5LI7T8/x+PjzTWVgCLTf6y8YpGP0BPNofsyGyaENFqUOfd5mbKQSTRayAlyP6773iXyvLh2NKH++bRiyxgDfGBSdZfbv5Op4t++MzXkE99wh4VNyVeq8sIG4aDhEabkiQYx9mRHUUXGI+ndLQrphjWWotZNuC+LdsiCu44vPVKmj4EOe2+dUnqa7vrn+sgg49r4/sfbZcCtqWnE+vRg+Y14c4wxovMtCjkn84rMJH26Yl/WTE6ePslPOEA1H/4S3gdfUAhEIlUVzXPvkZ69qf8LadA9EYk/bvFeGuRt3oHwY+++rW/l02/t+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XEtmuGwrcOlVekMN5ijOgZ6nuLOzB1f7LLAkFG+/cU=;
 b=cUvUl/hxso649iUAzGOb9ynDsNWkP7ePvFTz/NZq4YydgSv4tj4+Aqpyu/4dr5slET5/XstXUEtBD2DFmL3MU9zFiVlSu8gne+FaXCW8oVglg/MbCIXvW+kSGt+pJr6fqJnab0DEChKAlV1Zq2BpbRb9g0ry5rIkaeHs3y/jT9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DBAPR04MB7334.eurprd04.prod.outlook.com (2603:10a6:10:1aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 13:29:31 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::6831:19af:f6c0:5512]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::6831:19af:f6c0:5512%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 13:29:31 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH 1/2] Set temp if device is bcast source even if addr is private
Date:   Wed, 30 Aug 2023 16:29:14 +0300
Message-Id: <20230830132915.72153-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830132915.72153-1-silviu.barbulescu@nxp.com>
References: <20230830132915.72153-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0102.eurprd03.prod.outlook.com
 (2603:10a6:208:69::43) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|DBAPR04MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ae8457-0b58-41ba-bffa-08dba95d244a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 145rMsy0D5VlQEWHFI9LrdqUBkwOgHGQbhlUo1UCEb6Gbc2H6n2kVdLSvlEoVqby9ZqIFD8by8EZvzaQFyuHah7ioBTsmwM3pUmFwWBp9mwWkabu5nlfUkDj2A2b8mxWot3smnK/6Fgib8MWhAVV4VM43G6+ljYIr5hhVRjYWAt6FE1/MAwIG8Mq+I6nfCKQuFW04TZFaTg7wAETGJTzuhbtFRr6r88fIh10xrYPY+Qu1945R90Wl9dAsPPPOhCVgLE6/u4IL5yIQMrQXd8H8vYhKzMaL5039Vq6Vzvl/JjvQsJ4zNTvWgQGb+eP85Zz+n2FxyezpFu4+M3akKpvGuqWHfrJSaq1r59pQGctdpQIXiKArGznOGhA1+vClWfDg3lkhVjZlVvykkuUp1DoxB1tgBy9wQiX07w4RVZ9Ywa8EZ04qRFf7hsq+f0NE8jz5uxj4+OhlYXsFuljpX1Uo/J4qvIcVcghDntZKHDdOn6Xyt1M9TgFAqTF1ByBG779vfjgoQYxg8yR4zpbC6r3tqF0QMLOXerTvx2ctxs5bOqXqaPFhlmKj1HJasPiuFds6eBVoH0PRZzIYyoaKWE0GYNQR9Z582jeFmwpLwImC8CmE8N4zVHYbjGCcTATQYZx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799009)(186009)(451199024)(8936002)(6666004)(52116002)(66946007)(478600001)(6506007)(66556008)(66476007)(6486002)(316002)(38100700002)(41300700001)(38350700002)(6512007)(5660300002)(8676002)(26005)(36756003)(1076003)(2906002)(83380400001)(2616005)(6916009)(86362001)(4744005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FwRNQXWgiJ2J2K6QFF3ZbbbXFpfz+xboJfJ/I7gzaRBh59SFcXU7fvZcEUu2?=
 =?us-ascii?Q?2GE5TnvgP6SKtVOJ0NiB0UoOEn83mMYGaIZcVpDxdxRUrbcBTR+CHHVfZuJ5?=
 =?us-ascii?Q?QcZODPMsqDaJ8cibU9AHaUbyYUlV9vgYOYnXlGW29D8y1Ag9P8xy55rfRULZ?=
 =?us-ascii?Q?VAVhBWZy+sKvT+ggaRXOAiX9ADAz7IxKBd0PaOxdMpH5bQr8paGn1yRF5xjr?=
 =?us-ascii?Q?zMM+lABaRi0KtwRoVLEtyfArZ+jsQ+1nlMqBgZk2ihb6ViUeXXFpZqTtFARf?=
 =?us-ascii?Q?kUOKF3WJy5223aZeeY803OjmDhDTs+y1gIdaxS5tqO8NcXi7bKNRushlZJlV?=
 =?us-ascii?Q?mG7kjBhtlBiG33TuBZP7MAApwB7W2hUQ0HRdTxWXJRuNQMXnbHFVNWbZbTgZ?=
 =?us-ascii?Q?jpUNv3v/mhllGJAG219RVvsXQ5syxFoixFaf4qaMcgHbyvpq7GobB4AJGXm/?=
 =?us-ascii?Q?Pw8f1swNu/7iZSLIRFZgTWhQptJpl4+Vga0gSxXUpWNJih7c7rxCteIgrPpI?=
 =?us-ascii?Q?qPV9WyUeY25t1XYh7h8Mu7rF7Mipp0C/nMw/R0V8GebqHKaNY8oUplQzSvdM?=
 =?us-ascii?Q?fwDPwVIGvwnkztJWtdMm014+mO0yT0gNWr56Je4/8JdiJrb/ELA1g0GMorxt?=
 =?us-ascii?Q?dJD/OiHF3o1U9V6OPrXUNOwgM/gTws+We79NS58hc9pSh8mjT18BTk2P9u1o?=
 =?us-ascii?Q?KiCPnb7IeI6u+GGsC72dQGJBBj+cnieV/r8R4aijr0Zcw5U2TW9udg1Y7CKP?=
 =?us-ascii?Q?QEtK2h5UVyaeaRhhlPVZ2bdss92HB8egv2M1WKKJYGNnAcdyy0IndBz/VAvV?=
 =?us-ascii?Q?fBhwZ5CWLdeolb1QVV/1SYP0X9+WXYt8s5SEcZmm29JhzJUtM9mTiFiuoW2T?=
 =?us-ascii?Q?7rbwkkk+uUDIxd9va+H/z6X1u8UFfqWFqdmuCJBe/u9LTcY/xAkXR84W/7bE?=
 =?us-ascii?Q?MJ3h1VBLXKYUUEMtVYlzq9Z0WeObpvJ3LPIZjfaZnDncPA94CTpaJn/EH4fd?=
 =?us-ascii?Q?9YAUYBkcp9b525Gl8Yydh+8D7B9n30kbHdV55ke8Y9vnT1a1n9D7fXyp5tlo?=
 =?us-ascii?Q?5KXlS929FSk/lZDStHMG8bQL7PnHZZXsRpD9TkriRSd60Bio3IYajKsn2G6H?=
 =?us-ascii?Q?twujKGCZ9YMj8R82i9/kbILyI8ksbNpSsDeAEiqhNnVX3RoNsVxfoI3WL/F2?=
 =?us-ascii?Q?SGo+5JCWhZJJEIFWxh/W06jZtsy5nqj52EEXvkFRzc56Nxjlz1qTv5srvV9U?=
 =?us-ascii?Q?Mv+aJgswbL345iHDtZMzeMeUMCMaUoArEmIUfFXTNT0YvqqEdVzoa45hR61z?=
 =?us-ascii?Q?XH+GrXKTIzF4WZAlMSlL31jthbvMw/3hR27PcMP3BFBplsKwyulVSF+2LMWU?=
 =?us-ascii?Q?K2KnB3AVzQ5oM6w5VxH7EYMyNc7Ri0ThB6G4L5nwrX+PDzuIPURL5NXVabXw?=
 =?us-ascii?Q?d0gHLM4gep9y1rtN39h+K/ZCRZDndavLDhARzNs+7a+9DJzXsL8YDhZU+rjC?=
 =?us-ascii?Q?WfUrRmEZcBf5x9kNXnCoEirrmAAyellTYUnhYD+sfrK8r+cOkbpclqC7Uf4U?=
 =?us-ascii?Q?QYdHTx5DsuydniWJAmowPWRJrgK56anq3CGLzTdAnIp7RAQSlcNaXTQQkDd1?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ae8457-0b58-41ba-bffa-08dba95d244a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 13:29:31.4028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrydS08U+wuw7k3TkkB4aot6RQLBKi4B5iStczWuMgrDp58vJOigObwa+IpjDP8CIhXPisoQsgWmJYhn6TBQVhEOnWWViSpNY6jQGgy2u/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7334
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For audio LE broadcast we need to set the device temporary flag eaven
if the address is private

---
 src/device.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 9b58e0c4e..9ceffa118 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5945,8 +5945,17 @@ void btd_device_set_temporary(struct btd_device *device, bool temporary)
 	if (device->temporary == temporary)
 		return;
 
-	if (device_address_is_private(device))
-		return;
+	if (device_address_is_private(device)) {
+		/* For audio LE broadcast, we need to set the device
+		 * temporary flag even if the address is private.
+		 * If the device that is temporarily set on
+		 * has BCAA_SERVICE_UUID (is a broadcast source)
+		 * will set the temporary flag even if the address
+		 * is private.
+		 */
+		if (!btd_device_has_uuid(device, BCAA_SERVICE_UUID))
+			return;
+	}
 
 	DBG("temporary %d", temporary);
 
-- 
2.34.1

