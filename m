Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC83ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Aug 2022 20:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243778AbiHYUjD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Aug 2022 16:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243847AbiHYUit (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Aug 2022 16:38:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70114.outbound.protection.outlook.com [40.107.7.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87420B6D1E
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 13:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2MDkRnnHJ3TVU9PykLBqVT6+DqMd3zoeNtTuVnlSyoZyr9ywyHGEJX16EzC7cV0uE2ZYcdYvCkOYA5fr5nBP8tqzXP8R2TNPCps7fsYKPlUwpuNhe+kiSMMcI3X0pqVale+YLJh70htgvSsiZz+vzlNYQ9kOGB9YmvGzbsCCMOJjh7Oe0DYHm23x1LUxd4DlB11LnI0FHofq7M37D9dYPwFmdimOSgCpC6n7VLNdphuSLk9YBfD5z6nRCKs2QeKjTBaecKwlFdTkAr8isIgCKCyKqq7/ixZR6aXIu2OETVBrdO8ZLXh6KSW/sfveWCPvaQGQyoftNuVz7XjLr1cgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZkvTWsvJoCWf5lfuvjS18gVymGdxrcje0aIwwz7zHk=;
 b=hhu0FD/wE3UWnNIzHm8y/IQerSjfe3Eqwid0tDNerndhY23A/+utd+5q/x8Aptz/yD4vgnjRlzj5mZ56xWWa80doMCVEbkeLPbtNJKmDDTg7OHHgMjYcuNTErAEmw3AAT+ZiJsm1qtMjk912lvcVBlOU1/jMnwj61KWtmGN06jTvtDQzP+ND3YAFj2tcNtvsyXIPIjueuCMzX30NZTwrfdVbpLA2jRGITgOOClWwqHsfpS59axS1SQ6fFCJjYnuHQlt0WON5wg5aOR+a1zeJNAIlzFieXYjnJXNdA8HjyR6mlumQ9GBWeFCg6zcCu24OgPfI7YbOoWooAmCh2lFjJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZkvTWsvJoCWf5lfuvjS18gVymGdxrcje0aIwwz7zHk=;
 b=qO8l6k02AAulrjI4051KRt6ARVzWMwPsfieQMKpwwJQ8es3nUH4YtKHtb83poPQou9VEV+1XxdUci8qXgrY/PjVigi0AuFVRR/TbBtWXWm+dKxECZJwcxQTOT1I9l3KikfMgmgWJHPFoBbebJcpE4tE6Tagp0YRZsnAQnxVqN88=
Received: from OL1P279CA0054.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::23)
 by VI1PR0701MB2365.eurprd07.prod.outlook.com (2603:10a6:800:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3; Thu, 25 Aug
 2022 20:38:37 +0000
Received: from HE1EUR02FT006.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::1f) by OL1P279CA0054.outlook.office365.com
 (2603:10a6:e10:14::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 20:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 HE1EUR02FT006.mail.protection.outlook.com (10.152.10.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 20:38:36 +0000
Received: from N95HX1G2.arri.de (192.168.54.11) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 25 Aug
 2022 22:38:35 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Christian Eggers <ceggers@arri.de>
Subject: [PATCH] client/advertising: Fix typos: *_exits --> *_exists
Date:   Thu, 25 Aug 2022 22:38:28 +0200
Message-ID: <20220825203828.3380-1-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.11]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f26ab632-6c66-45c4-6b30-08da86d9c8fe
X-MS-TrafficTypeDiagnostic: VI1PR0701MB2365:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TlT+mAYH51W/EM5uyBbWzrFN6Qa64WwRX5Fq88Z6M40T0Xcv0QJdMmhzidMYNAkPckQEeF7dNBNcEWUplaHv+ASvL0aXx4xARJzTe9/AB/bpOZU9xOkkQecaUwBbZIrXxvFw2HIgWb6I+RWhkJVqMHnlTnnMdDKEQFuRUJWrazWdgxRCZo59H9zacUqDzoGSZY77GqnHGttA+1Hc7KgcKeCU98mzqzaFEvw6S6GrtRanCPxGvRqdzxwoH4yH5e9ueyD3+c9MtsxIFuSSdhIeruDTZuB+8OTh1gyTjudDrbWCWu336gB/AiCozkSDg2C0EzDST2mXwnEnFyvG9SdtxA/y/kRq73Itk7cbapfKiQqa9ZyfPCbSLTZWDs88iwhX80lDBlzuDqu3ZYdRHt+tdJngOuN16Z/DoG849Q6oL+ROxUyOSySr/Zzzx5is5gLrx3LN8/v32zsiHIvUcp7xpY8Oc53cHyVYtiv32WMiq2qxsjTgPpHfU8hpQvbEARKvGsPb8aGg5nIcJmNZW1Df4aeGHmKhqz/9Njjg4zH2VZr6bnmyjUSR7fnpSVK3LCCRMnU+xYuHaaU54dZKcJJeS8dA6yR32scht4X6THbWOQevNhSiQ+jYAfteghAnoQJzhKwgYyYpIgUzmLz8Tsmz21X4otjOpJQ/Yzgp6O2lNOs5Z3iGJ6oJ8ZjgC2+9ISNde2k9/SJEHCbXG/XrDbr6KQkicSxHepOWdJxuJ7p2DmrFu34bvRLwoWXNf29KOA4YDvWguk1Ks90KHuT/645kjRtVzptUQTqg9cNQefVklwEY7u7e2qvl/T3Wofgere2
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39850400004)(136003)(376002)(346002)(36840700001)(46966006)(5660300002)(6666004)(478600001)(26005)(41300700001)(1076003)(7696005)(107886003)(83380400001)(426003)(47076005)(82310400005)(2906002)(16526019)(8936002)(40480700001)(2616005)(54906003)(186003)(6916009)(316002)(336012)(356005)(8676002)(4326008)(82740400003)(70586007)(70206006)(86362001)(81166007)(36860700001)(36756003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 20:38:36.3707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f26ab632-6c66-45c4-6b30-08da86d9c8fe
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT006.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB2365
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fixes: bd0808bf01eb ("client: Add advertise.secondary command")
Fixes: 4e7780d0eb94 ("client/advertising: Add support for setting min/max intervals")
Fixes: 068e0ba214b9 ("client: Add set-advertise-{duration, timeout}")
Fixes: 5c3a39e642d5 ("client: Enable set-advertise-appearance to set Appearance")
Fixes: 177eccc14523 ("client: Enable set-advertise-name to set LocalName")
Fixes: 806276fe54fa ("client: Add advertise.discoverable-timeout command")
Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 client/advertising.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 5c9e3eeb3315..837cf817e871 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -329,7 +329,7 @@ static gboolean get_includes(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean local_name_exits(const GDBusPropertyTable *property, void *data)
+static gboolean local_name_exists(const GDBusPropertyTable *property, void *data)
 {
 	return ad.local_name ? TRUE : FALSE;
 }
@@ -342,7 +342,7 @@ static gboolean get_local_name(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean appearance_exits(const GDBusPropertyTable *property, void *data)
+static gboolean appearance_exists(const GDBusPropertyTable *property, void *data)
 {
 	return ad.local_appearance != UINT16_MAX ? TRUE : FALSE;
 }
@@ -356,7 +356,7 @@ static gboolean get_appearance(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean duration_exits(const GDBusPropertyTable *property, void *data)
+static gboolean duration_exists(const GDBusPropertyTable *property, void *data)
 {
 	return ad.duration;
 }
@@ -369,7 +369,7 @@ static gboolean get_duration(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean timeout_exits(const GDBusPropertyTable *property, void *data)
+static gboolean timeout_exists(const GDBusPropertyTable *property, void *data)
 {
 	return ad.timeout;
 }
@@ -420,7 +420,7 @@ static gboolean get_discoverable(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean discoverable_timeout_exits(const GDBusPropertyTable *property,
+static gboolean discoverable_timeout_exists(const GDBusPropertyTable *property,
 							void *data)
 {
 	return ad.discoverable_to;
@@ -435,7 +435,7 @@ static gboolean get_discoverable_timeout(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean secondary_exits(const GDBusPropertyTable *property, void *data)
+static gboolean secondary_exists(const GDBusPropertyTable *property, void *data)
 {
 	return ad.secondary ? TRUE : FALSE;
 }
@@ -449,7 +449,7 @@ static gboolean get_secondary(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean min_interval_exits(const GDBusPropertyTable *property,
+static gboolean min_interval_exists(const GDBusPropertyTable *property,
 							void *data)
 {
 	return ad.min_interval;
@@ -464,7 +464,7 @@ static gboolean get_min_interval(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean max_interval_exits(const GDBusPropertyTable *property,
+static gboolean max_interval_exists(const GDBusPropertyTable *property,
 							void *data)
 {
 	return ad.max_interval;
@@ -488,15 +488,15 @@ static const GDBusPropertyTable ad_props[] = {
 	{ "Data", "a{yv}", get_data, NULL, data_exists },
 	{ "Discoverable", "b", get_discoverable, NULL, discoverable_exists },
 	{ "DiscoverableTimeout", "q", get_discoverable_timeout, NULL,
-						discoverable_timeout_exits },
+						discoverable_timeout_exists },
 	{ "Includes", "as", get_includes, NULL, includes_exists },
-	{ "LocalName", "s", get_local_name, NULL, local_name_exits },
-	{ "Appearance", "q", get_appearance, NULL, appearance_exits },
-	{ "Duration", "q", get_duration, NULL, duration_exits },
-	{ "Timeout", "q", get_timeout, NULL, timeout_exits },
-	{ "MinInterval", "u", get_min_interval, NULL, min_interval_exits },
-	{ "MaxInterval", "u", get_max_interval, NULL, max_interval_exits },
-	{ "SecondaryChannel", "s", get_secondary, NULL, secondary_exits },
+	{ "LocalName", "s", get_local_name, NULL, local_name_exists },
+	{ "Appearance", "q", get_appearance, NULL, appearance_exists },
+	{ "Duration", "q", get_duration, NULL, duration_exists },
+	{ "Timeout", "q", get_timeout, NULL, timeout_exists },
+	{ "MinInterval", "u", get_min_interval, NULL, min_interval_exists },
+	{ "MaxInterval", "u", get_max_interval, NULL, max_interval_exists },
+	{ "SecondaryChannel", "s", get_secondary, NULL, secondary_exists },
 	{ }
 };
 
-- 
2.35.3

