Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701A2C6FA9D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 15:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCAPdw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Mar 2023 10:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCAPdv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Mar 2023 10:33:51 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F031A945
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Mar 2023 07:33:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5McLITU4XWq0l+LvZGEEjQiFnO0vbD5fCAUyNzl8JKb01bbKzIJP2GSyEDCgL/Ctv1RGBeSbOlYDoNI7D6JIyimMx2aO5N7/fgkihvvGW7vcxrLxQBJH0uIDT4Xv6cKNgIvfFPjfLViQF2h+Oua4oUGNTgPTeIPTMYOK4vSkpeRrkhBw69e9pfAHADI+Iwjn5urzbYs68AeBPpnAoHdiD/FDB9V2tZJpMR0Jrm7k4wDYXRPDebWixmT4cKptvmKUyc60p1Lt8N7A1lMIzRbWDrfZF+jACFHNqpa51OPkSjOkCeqEv68aFAaahV+OzvbvW319k0nXBaVe+rFoVrw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrEq+0u95zBmhNpK2i4OZUfDPueXDAXCjaSN+13RTZ8=;
 b=RcEyqTtLKTiGpUp9k5Mub21Pka/v1dATr6tplKtVilxWUrJoh9tyhyfgT3cTwUMIi6bm+u3u0RCJQjZMiwdZDmBAI5VHziD/uNR9Zr/47CW0ZVEt04sKutBoiUqtV2naRSzY/jzA23S4ceXirGALk2S3AXgv3wE0Q0U6NGWIMUreJWH/UY3dxTdkm1aEQdxkpZiSpXmjDCxYWVSp6/luF2vFvBuNLVJrafNFelePX7ij+LVaZmEBSXZCeGUoTR8+ebGqBnjGaXDWIXgrkXTW78R/FATj7dhdyP0DNYww8GUBedxszVls2tU9wf8mHV3nJnWOCjnI0UHTeRmDh7YCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 15:33:46 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%9]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 15:33:46 +0000
From:   iulia-tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia-tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/2] lib: Add BASS UUIDs and auxiliary defines
Date:   Wed,  1 Mar 2023 17:33:21 +0200
Message-Id: <20230301153322.12555-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301153322.12555-1-iulia.tanasescu@nxp.com>
References: <20230301153322.12555-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: AM4PR05CA0028.eurprd05.prod.outlook.com (2603:10a6:205::41)
 To AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 48cab856-3396-4d3b-77f7-08db1a6a58e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BwBh8bt+Txl6lN1dKY83y+3BxLR9E51wRsopC+95FrD3OZn82+ANgs8kGndM3kSKvjD9KsgCTNu6U2SnphGUGQYoBy0dww+CbgWhVpl/vcr1GH5NVfW2eO5j+ZlYFqk2jEpNka5qwhha8Vl0LYINOS16g8JrzpbOxgZldx2oAqki7GAjJzyOMKKSUipGsfojOC2M6/yqaEB3wgx8nbcH32FdDaTL5bTJ1D+mcM+jAG8a55BGRR+XGXQjW7uqtDbTvKRQKSxY6QA+XcBJi0iiQASb/J6nYWmn1zQf0JoVbSVI0gFqgttEar6mDu0Ey2PtEyB89GtgxRxUjfOaCjt1AbtFsHdKIZOh2aYJJfHj2s0fAj+msiU1r1HTwZ51W4rPqwacRY2lLipYeNK1vn/YTtPGeeXCQ/QmBrmy/LAaYqiOLvRfUqid7UpWgWYNgZz0IsUHzNVPVGpHKR7QPJ93cesS13szLmh9gSElKxfj1yj6a+345miEs2EnZQDYFXbkCRgqubn3YorJPuNL840sDsLjRUzWFD4cPufQY79mDY5pb6u0GcP39k5ubSIn5QX1qE93OMGJlZ9Q5y33wpPBRLw5nMjJGFjobFCqKwlqjiQCk4cIDBFrWZuWZUix4jHmO1eEiXIt8NVx4KONcPeZ5q+RChpfHyfR7iI3CwfmICKQpNGy322XJFME1bVPg7Pp9NdL8QEhvZfGR21BWjm4beO8qzQc+svlq/64UcOQi0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199018)(5660300002)(8936002)(36756003)(86362001)(478600001)(2616005)(52116002)(6486002)(6666004)(186003)(55236004)(6506007)(26005)(6512007)(66476007)(66556008)(66946007)(4326008)(38100700002)(41300700001)(1076003)(6916009)(8676002)(38350700002)(316002)(2906002)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IF9mgyTVjG3lIpzF4fFGTh4SZwToQpP25ePQ6ZJ7VM5LBYxzr4YIJvqSR8fY?=
 =?us-ascii?Q?c5QjhQxZ5PjGCiyR0CdgIOKx/8z5m8O3BI/V7c00nxMEZMEIe2hlsqgy0IBB?=
 =?us-ascii?Q?kEF6DvrXhXY4I+Jh10teiwOkLGrn/oWQxE/Y/TpxNhLGUjs8O9T7G3mm6+WY?=
 =?us-ascii?Q?6iZBAsk+zRT9AaM6u8kvcdSw4viuio5UNtjoO0hVzxO/WQSImdT9rFNwqiOY?=
 =?us-ascii?Q?qnSMNriKMGxo1Gs+NRc0pF6sRmb/IKSM1Kz6vbmCM3EUN5Tkow+Fn55gh0X/?=
 =?us-ascii?Q?0AJO+CWziAIozGCQBoOyhO1QaLx7boPnrRE0B4zf3r1BCW7ibq+8/FEcE7BK?=
 =?us-ascii?Q?7+6FZku7xJrRYjOl7Ys4LCjkmBG3oy4E1BZSPfy/V4o7XkulSHuz9wXKFrIx?=
 =?us-ascii?Q?kjWJzCu1mWwwGueiGinHkSKeC2WgKpFcLAUGsDRuQ9d143Hx75wW5Sj7Ljgx?=
 =?us-ascii?Q?+f3TTb9hDR/AfhVkd2iUeLR1Vj+kTMECzVqjlXg+MXz8Dg33kdImKUE09/tk?=
 =?us-ascii?Q?jeazLLKEmM5pv0mZwOrTtRBSjYlVjvo2FUjWSq2GZeOePyoBBQd4EFIzjgsi?=
 =?us-ascii?Q?+mTwjze7svL9VD8h5DWFuQVozrcyu1NgjcW3hXLHoP4MB3PUu5yi6cpfFiJR?=
 =?us-ascii?Q?3KBOc2mOpgeC3SB/yJOH8VPxLTmp+kjVmR5bdkImG6tpLALxXk9x8v0EwFPL?=
 =?us-ascii?Q?ZUbfQCYhBOMveHO1xooT6ijutlYzAr78b8VRcDsrh1qBpBhNqqa/HdJfzu4g?=
 =?us-ascii?Q?R92AcLUS2rMkaqdC+hu9EeQ9z2vg1o8DrvphCWHjr97kA8FnfCNX/yz5sGa6?=
 =?us-ascii?Q?QCZoE2YHMSt2CUUmLJLjMhwCuGY1IzvAVWek5kgxYe/w/aHdTxqoTQ+SjqHN?=
 =?us-ascii?Q?YUP+JJPzAQvIRzpHsxcj5qLPWVdBvCePjAisgAblNJXY9zndGr2Prk7ZLYI3?=
 =?us-ascii?Q?R4xKf2gXx+L5MgfGEPdIA1cRZJvo4hAr7WQjvIWIqP7cVoLgDUx/DarZxWmx?=
 =?us-ascii?Q?ubEKkYH8HPpyTRpXVqD6c/pdMGMTjdt8yjVEa+gijsWOo6lvev14LFXaTe80?=
 =?us-ascii?Q?v1GyA7GUkZa8RVFVVl9e4gRV8iUBUaw8ObL1tJHeaM9iAiFipWW+KfyZao9C?=
 =?us-ascii?Q?ePvJltmU/oZFwvgZGF3iT2Zcu3hjHGJnNpKYnrhzis9dW3nNlW7xwUpH/SzJ?=
 =?us-ascii?Q?c5usZMGMJN6EkmDYwUYGRUbMYTae/8JbWYQ5IV1XKxF/t91TSlwbePx7SS8y?=
 =?us-ascii?Q?yjU9kdxk4IKLY1kGDLxCyFmNGRz84LHL+OVkUrgP0eBWGIB3Omk214FlDnMV?=
 =?us-ascii?Q?waDMa+tAQ4etWbT4oJ/5CDI8jyjqWIweny+uJhJgL0X/WtKtbPovsBit5x6X?=
 =?us-ascii?Q?YQApTNOyzQwJno3GZ3a6INLNWaEzk4mUOy71WM4XDEpsLRiHZUyRgVyTla2f?=
 =?us-ascii?Q?gGe7b2dwi7dselG8siidNpyf51lJeN3o1/LvIrcCJi7Y81esXaPZ29eeZyDO?=
 =?us-ascii?Q?u1jQWvUbDEayDMbetrS6unG+ynlBBA0o4YXRfrHlgQhGPKlnI4eH2RIDNAoq?=
 =?us-ascii?Q?8rdtpot82A+djrbY9rgFIZgvZOBaI8THZqTz/MFDKTtH5Ibk8MX33IcY021L?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cab856-3396-4d3b-77f7-08db1a6a58e4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 15:33:46.4218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uu6vBBi02orOOMpXVQgnz6ytj2bviodDGvyku3NR5zQzWLynQmTrf9EeQ59dpt+0Viy217/BpdPP2O/FOwRyeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9326
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Added BASS and Audio Announcement UUIDs, added OCF for
BIG Create Sync.

---
 lib/hci.h  | 2 ++
 lib/uuid.h | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/lib/hci.h b/lib/hci.h
index 50f385c1e..d01e6f8ee 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -1731,6 +1731,8 @@ typedef struct {
 } __attribute__ ((packed)) le_set_address_resolution_enable_cp;
 #define LE_SET_ADDRESS_RESOLUTION_ENABLE_CP_SIZE 1
 
+#define OCF_LE_BIG_CREATE_SYNC			0x006B
+
 /* Vendor specific commands */
 #define OGF_VENDOR_CMD		0x3f
 
diff --git a/lib/uuid.h b/lib/uuid.h
index 84ff46cd8..a6bbc3770 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -164,6 +164,13 @@ extern "C" {
 #define ASE_SOURCE_UUID					0x2bc5
 #define ASE_CP_UUID					0x2bc6
 
+#define BASS_UUID					0x184f
+#define BCST_AUDIO_SCAN_CP_UUID				0x2bc7
+#define BCST_RECV_STATE_UUID				0x2bc8
+
+#define BCST_AUDIO_ANNOUNCEMENT_SERVICE_UUID		0x1852
+#define BASIC_AUDIO_ANNOUNCEMENT_SERVICE_UUID		0x1851
+
 #define VCS_UUID					0x1844
 #define VOL_OFFSET_CS_UUID				0x1845
 #define AUDIO_INPUT_CS_UUID				0x1843
-- 
2.34.1

