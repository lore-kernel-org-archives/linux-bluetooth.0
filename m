Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08E7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 10:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbiI2KUJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 06:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbiI2KTc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 06:19:32 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2138.outbound.protection.outlook.com [40.107.20.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AC0FDFA6
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 03:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvbjAUQt5GW7w8lCq2T5ZKoZ8tAapANcdmn4LfpdJiIX96VSRPZ7I4QOgls9PjmSeAO2T89pTmjA2baThnW/BcG9Dm9AoYCX1jheTEyUa+0rHwD/j2wgCinkfIxs8kDkOfAVI5x5iHKuOyKHT0mnrNZOuRE/RY2JddMHLP/q8EPSTgPkmxSm1yRse6HBemYpbHmXkmdzNCI6Powfxk5Vg3mEkH3bxLIsQ8+79GB0ViRKIg7tLX1m+mSdItN38orcTOv33WeVIMab/5PKo/51EVCMAnc8nNq8THZ9fz07hTJdgCAxnL31n1sA7YumVGWLC+h7S8vjJVYT8v6XVRy7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyXlE/UN5V3zR/ha1nmkKGaXVHcgJEhV8zQ66FBB3cc=;
 b=FrlDefzVfnMIdXcCw+UnIx7CAvgvbAmL9mHCXg9QllZvMyX24MwXROJuOV+k0z+y3OqOInl4DQbBg/tZ9zZhUFwQ0JvvXGmPEN06AAKD37QFKgurltcH++2s72fYvTxMrhuq+fFozjLA4nZkeBOcoepJDW2kapZ5Ytc5Jn+mp+4oCQNfb5+E1twyiBB+ISB5Ez5jV7U3ah/CEGS0r5nkydPskynTF9DXkUM1OT2ZxrVvpy6YZUP9ico8Sj9xLxlM42eRA4Laylcsj+faFHidvtmwk5MdtlVD9s4fJqZMPqwfNXUW7g3ToGaTsjRJ5TsIWScM/yJxHGHaNFySzIu/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyXlE/UN5V3zR/ha1nmkKGaXVHcgJEhV8zQ66FBB3cc=;
 b=N3LSac6bRzcniw1RK3yaXDroNTDXoxqNp1hJewO9TrKNLcd7gJC2Gzr/LEEgDEbrV+rEcp4ReKKaX7oPPBlHTpFH914uoIhdZnss1fJ1eZIH7BesyOOs1u/unBqrMfovAK1KmCxO4aPlGCkeUadIWJ4h7aJw3tcF4fY8GJzkBNQ=
Received: from OS6P279CA0177.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:38::8) by
 AM7PR07MB6932.eurprd07.prod.outlook.com (2603:10a6:20b:1ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 10:19:27 +0000
Received: from HE1EUR02FT092.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:38:cafe::4e) by OS6P279CA0177.outlook.office365.com
 (2603:10a6:e10:38::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20 via Frontend
 Transport; Thu, 29 Sep 2022 10:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 HE1EUR02FT092.mail.protection.outlook.com (10.152.11.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Thu, 29 Sep 2022 10:19:26 +0000
Received: from N95HX1G2.arri.de (192.168.54.157) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 29 Sep
 2022 12:18:57 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH RESEND BlueZ] client/gatt: gatt_register_app: fix parsing of UUIDs
Date:   Thu, 29 Sep 2022 12:18:32 +0200
Message-ID: <20220929101832.30203-1-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.157]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR02FT092:EE_|AM7PR07MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: f9dcf5b5-1e2f-45ec-4b2f-08daa2041669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OdfZIWihWseIWVzrIeFYh0qsysvTGIM8vqaJ7olqrFUz5APZMLdgBAKxlXAlFC7soJa9WqlF4/KoYx1MowGVd+bAv/cifIQCqHUAwyD6QuSNm3NuMQl4oEjb/yfpKdgwJRlezrBLRlYs81ni2do64L5KiAMMbtsATpctchZoZiyw1w+iRledSElWIuMjQmm+5AAW2vQV/FPSETm62lb4ABvVien52fDZeSXstIN82Js3E/yGS9peNQzm1OT8E4fZtG9/zNiDwFSILDpIlvjxrVXmb2z0cIvZWUn4bvz5VZ7KHBjOHhPelitEuCCc1D1bipkgNLyvgCZICzVLyxW6dVAJIqBpiROm2X2n4s18kptOoZ6yjsfWkitMH58/UqhtIej/Xm/mwlt3ZqnqSqKu/RGTPjfmMB+h25A8iWoqtfJ0rNJjyXy47PJ1hqmpQ/Dgw959omzuv8/4T3dNGycwecUTPzucA4XTVz6/zdjVTgcJhjP66Ff2BZtCHdKgq/wbanZm/mxyA0YFnz3Fq2trUoCgGBlzrxfM1/HfsVPcrPKuQwU5bQ3iffLjbOArDSLM0fQlAVd5B4sKxmddULxDkJtvrj0ZHrNQ0M+WfzVBaYuflgQUR1LQZF2UmJMlKW8YZ7kxDVC2MNneK7TMbVyFTWzBXHqXhLbXOtDdcg1jSPnKucyIk3RHoJl90z9yBih9YWUT6sUzkhvAqMtrM8/byBoSPs6r72rLMf2hFOT75m0a6jd3FTfNO3KgRPrY/On/to0qBwhwqO6wI9aUtAsKZPznCcnJfeLpAg5AIwLGXDiXL/n/YCey2liZRtgCour0
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39850400004)(451199015)(46966006)(36840700001)(86362001)(36756003)(36860700001)(356005)(4744005)(5660300002)(81166007)(186003)(1076003)(2616005)(47076005)(16526019)(6916009)(426003)(336012)(8936002)(83380400001)(7696005)(82740400003)(478600001)(26005)(107886003)(6666004)(316002)(70586007)(70206006)(8676002)(4326008)(2906002)(82310400005)(41300700001)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 10:19:26.5289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dcf5b5-1e2f-45ec-4b2f-08daa2041669
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT092.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6932
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

- argv[0] (shell command) must not be used as UUID argument
- fixed linked list iteration
---
 client/gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 8f2920269118..13ff36193524 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1212,7 +1212,7 @@ static gboolean get_uuids(const GDBusPropertyTable *property,
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 				DBUS_TYPE_STRING_AS_STRING, &entry);
 
-	for (uuid = uuids; uuid; uuid = g_list_next(uuid->next))
+	for (uuid = uuids; uuid; uuid = g_list_next(uuid))
 		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
 							&uuid->data);
 
@@ -1238,7 +1238,7 @@ void gatt_register_app(DBusConnection *conn, GDBusProxy *proxy,
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	for (i = 0; i < argc; i++)
+	for (i = 1; i < argc; i++)
 		uuids = g_list_append(uuids, g_strdup(argv[i]));
 
 	if (uuids) {
-- 
2.35.3

