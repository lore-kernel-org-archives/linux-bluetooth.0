Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9938CC6FA86
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 10:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiIWKZA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiIWKYm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 06:24:42 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2127.outbound.protection.outlook.com [40.107.21.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60BD2B1A6
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 03:24:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncou++TMR1Ht/hu/CFbsDEwKctqJX+x3PakuuO7NCPZRyTH+BQdWIl88Ta2vw3SArfa6LW99fq+biGzZlgFUKmh8EZZTF15f2YlNAgpgcmi8+JwgjPG/3aHzkEO7Ud0Pzd93aSixM7ag32Vf1Zi9Tds7StS1MWIeJhfoFrBqahJH9kzZ6grCebTX/4+T3nM82Y7Z/zmP60hX1eftHiQWiXYoWROF4lCC5wLfZTX+ctsY3v6B38+rbzTelWbfAO2lwRtVU5a10LsxTe/fkcbrJbFGtg3idXOv6064+heQvlmm+HymvrfihPI+unTRAaiqStcqmp0/lwiVZ63cowNZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtlWoDHzNopj+BVHx9q7iaBrxukZTMksACG3+HW6T+s=;
 b=eRTKnw2IGhl8J7xL2zLfjeDWjDcchgInItyAebwQPuGDZ5iQX/oapqCKB4R/dEiMLFCNRL8GhnvA/MO20TLIGZzQ2sMSTDvHBZjG+JBIyVT5TasNIJ4ZD/N5wVt6+QHS06BSqUPwk4oAvklJs0V6roYPQQYodzrPewTNoqVSqQlOeWH/FSJgqgl+RT974DFu5wvEQ2tzG2b7smh6yt2qh9zWq5FBIU4ccuLc09w/eoKXxKkkoIHY+vuIwERUolohAPOL69IaiWwRMUYceyXqu/3YITz8Tsz6zp4S9ade+VcyyECpq0B1Ef1FF+b08ngGxM6aBHf1AlSpvxZj8UFEHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtlWoDHzNopj+BVHx9q7iaBrxukZTMksACG3+HW6T+s=;
 b=MfkYeVq4GQ8R5u6Z7QhUWVCUfg48PpkWxsFYvNIa10ZtX95k561V0ODccNVXuALRf2+s1HxAjCCgzWqFXuEX4hJYHbFSgSpD5TSB67Qk122UEJo6MQmS/H5e/TsBJklR0XG1qnr7pmxkanPAYq1pl+qSZ9aiutEYm0rB3t2c9iY=
Received: from DB9PR06CA0030.eurprd06.prod.outlook.com (2603:10a6:10:1db::35)
 by AM7PR07MB6627.eurprd07.prod.outlook.com (2603:10a6:20b:1ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Fri, 23 Sep
 2022 10:24:38 +0000
Received: from DB5EUR02FT021.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:10:1db:cafe::f9) by DB9PR06CA0030.outlook.office365.com
 (2603:10a6:10:1db::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 10:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5EUR02FT021.mail.protection.outlook.com (10.13.58.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 10:24:37 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 12:24:35 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 4/9] advertising: parse_min_interval: reset min_interval if iter is NULL
Date:   Fri, 23 Sep 2022 12:24:16 +0200
Message-ID: <20220923102421.10336-5-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923102421.10336-1-ceggers@arri.de>
References: <20220923102421.10336-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR02FT021:EE_|AM7PR07MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 20670faa-7a60-4ad5-3e0a-08da9d4dd190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHXAPa5o6x53nbAsdH3tMDJ60hHqxVTTB76MhQKm6zSym3uQUUZt66XpUXCUH1+aOZc7LySKFhPOCLttA9uX+b6sRa2pJSh6sp4qqGmiQx3aQmhSztz0gtApszXJcaO50HO0DBU9UCrs/nOYN2LkutIGNr4ce2RTQOSf64lmvgxzYR4RnFM8+Ay54yM6+CLvCDiasN32DkoN5xevfAhBbS+t9bjZOkwm96VDytUIB2AWa3hg/UsGhq0oDs8ygQ12oU95OAkuSQRKtj2RrqV8TguKkleCXlsonvqnFUHNtaxFMl7Pj0j49p+Kg3zQnAzt/0aQSWYjbEpQfWbn2f2rgTaQkwJMHn2ZHLbaLJjjLGwy5R3X7CStV1fC4lzstXXSrVq26RgmhSXMCcN3WnjQXSXIFSK1Amn0G0MRcoU3A4J/unVHv93ZNQsOo5Yr9xU0jTLyeIHr+4Gnrd6sSoYU2BewuFmrxtUe+bXW6uUsmT8djzEhBooGt19LuF/MRmnrQ93C1nftjOwEqaWohEOW8T9jJzsRE6YtVxHqYXFLhLHWujVBMoDHHcJvEbxG05LQwgnch4/tlrQX11miWYxumXlyMgCogbSSHGW60S28agq3O7z5esCgMNblWNQs97F3MIL9c3yLY9v/ScSsGsOw3rRQEE7TcuhulbVtdfJZ3hFs9CE+r2/f2o1hX9QqQq+cCywc0/DXKMiHoUmV3NoM7e8zIKTBPLIxlYmRoVEYmOBeggokqOTPkzqni372iEcUf7S4bRnj9xn+mvCJq1wWSg==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(36840700001)(46966006)(7696005)(36756003)(6666004)(107886003)(82310400005)(82740400003)(6916009)(83380400001)(47076005)(40480700001)(316002)(26005)(86362001)(2906002)(8676002)(478600001)(81166007)(4326008)(70586007)(70206006)(356005)(36860700001)(186003)(1076003)(41300700001)(2616005)(336012)(426003)(8936002)(5660300002)(4744005)(16526019)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:24:37.9499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20670faa-7a60-4ad5-3e0a-08da9d4dd190
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR02FT021.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6627
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set property to its default value (as done in all other methods listed
in parsers[]).
---
 src/advertising.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index 6d8d06edd34f..fbfd90b4e300 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1087,8 +1087,10 @@ static bool parse_min_interval(DBusMessageIter *iter,
 	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
 		return true;
 
-	if (!iter)
+	if (!iter) {
+		client->min_interval = 0;
 		return false;
+	}
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
 		return false;
-- 
2.35.3

