Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79326C6FA86
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 10:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiIWK1I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiIWK04 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 06:26:56 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2128.outbound.protection.outlook.com [40.107.21.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB861288BC
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 03:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBPR/42gAOHhHKg7V/5ZA16Cu8NP2jNiWOZrR/l54CkXjxMlyUeUm5mQlcYgb6lbLy8MV3kphopfaZ1lLHkKtQH8ee2DI+y+6U8It4FayljnJdD5/HB7g/nyI0/fkIkGQRFmC6QpJqnVjUyaQKte13szTk8Ai/fHj+woXfCfMv7zHbgk4FwnbqM9lAYV4kP/lObzqBjnm3vMI9z+w2QzYd1e4M/iyUpF6z+8Z5OiTs8VF97UQE08e9K4tiGW2A+tNuuY/9Y6r2VJCGnfdGAA5lwyDDIKtPU4Q/FAvmEJtCsl4Ya+k63SCwDBONj4jKeyEwvP2lYZpgl/uOxZOT28Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7Kk0q5xn5naleEfJu53J/kxWhCv147kuPzhvuzCRmI=;
 b=n89pgY9gI3YIkvi24P0SD0BMjkqOEAu9M+C9K+nnLe58ZNSP+CUy6gKykYp3OQXmcXp935O8F2r9A8Nd2kikCiV322BEa9UB4UE3LWk3L6TZXdKgXLfWu4XOEFOzlM774h4CSqDUT8QL9kcXmGZqtbhAQk4Shk2g6CgOi8l4o+35Ty1Z66lrY2ijMa7ie+jPBVNmeWVX01yBjpuHuJ/ZjljnD8VwMFRB1w50foKBYG/+xpo7pFxL59mElGgvKseuL0z2rLVbvriORL7kH/577fleqMM0lHMzbBZyo8QLhqg/lVn3pxxd6IIMiAARqrE43nQso9PXDc8w1cZzZbNrgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7Kk0q5xn5naleEfJu53J/kxWhCv147kuPzhvuzCRmI=;
 b=jI6xEuyl6x77S0jxRZrBsOkmKxb11M4xfhmzRSttoHwPPOtz/5MMjWpy+dkAAtfJQ+gCUN5VB7EV5FPUgYRiP6uoVQbdYPcEJ+osnMngD3TUMoWiPqDssBPMTsIHq3frsPCu0wJ2/zHAZfXb5Ei22RTDs/yPhQBtveUCgLiMhBg=
Received: from AS9PR0301CA0034.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::23) by PAVPR07MB9285.eurprd07.prod.outlook.com
 (2603:10a6:102:315::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Fri, 23 Sep
 2022 10:26:52 +0000
Received: from AM5EUR02FT079.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:469:cafe::fa) by AS9PR0301CA0034.outlook.office365.com
 (2603:10a6:20b:469::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19 via Frontend
 Transport; Fri, 23 Sep 2022 10:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM5EUR02FT079.mail.protection.outlook.com (10.152.9.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.19 via Frontend Transport; Fri, 23 Sep 2022 10:26:51 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 12:26:51 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 6/9] advertising: parse_tx_power: reset value if iter is NULL
Date:   Fri, 23 Sep 2022 12:26:44 +0200
Message-ID: <20220923102644.10526-1-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923102421.10336-1-ceggers@arri.de>
References: <20220923102421.10336-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5EUR02FT079:EE_|PAVPR07MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 265c1e0f-eac7-4619-fe76-08da9d4e2160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: POZKqNQR/1z7zbSP6ApoPGTDZL0twAyHTNyYU+uI+BekZuTGOPhwTHuVvqrD+K2hN71pIILcMfZW2UYwyJa7f0XuocbAGUURqzpM5xL2rzeP8iL1EMOX++gQmhqbbyOCqQa05Yyy0owaI6q3uQz2Ah0AdMxzrMhD05ZDLtRWQXSy4D4vQLJPO9zb4sKAdnG86QaBQNkhFNZypV4Y4giAN02KseoITSJYJLrcK0nU2GFnl6MmdboC8nV4UEvgPbaFDaPBojQwPIy9rM1o7dVUQd9htHuNOVSXZgbOSKv6Odq+dqiYDLhYXL750nv+52J8V+/N4aDiqVy9uf22ApaKnE/cHwG0yKTUkgBwQRFrTWqvqkxlvcFRdapVb2GG9VSLGTU4eKyhIqlHukHAK2/Os1a3ep9yPSangBYKbsc607bQ57TEeSDiPD+KEtf2vxk+ifgleIq8rpAlq8DHRGFPaWP8yBr/fQ0JnYBteOWnFPC//ryuhBMwBur253Y0PEjOGexbRecoMpDBnxr4M/TOKbu/fOkhKe6pai3pmU610Asmx+rHg3G1aIn7s6lNIXEZktS7bBSJ2bUPdupGuTFsDmtphuB51L9a6rFaf1hJniu2BLoBs7OtjVfj3FwKYcicqqZFLLJPHAKk6LeX2OIXQ2sGNmPqdVjdKers1fxPuhCTNTVs5Oc2S2SEEI4RctuStTBSvd8cYWaCJyQQra6LMkbQejkqAZk2GpAJaSbh+JgCBZZ1ZTmXui2HK30aB+R3iX7NKsi2objfvfK5sJNujA==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(36840700001)(46966006)(40480700001)(36756003)(82310400005)(86362001)(107886003)(70586007)(70206006)(316002)(478600001)(6666004)(7696005)(8676002)(4326008)(82740400003)(356005)(81166007)(336012)(41300700001)(1076003)(2616005)(5660300002)(16526019)(186003)(426003)(47076005)(2906002)(83380400001)(36860700001)(8936002)(4744005)(6916009)(26005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:26:51.8906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 265c1e0f-eac7-4619-fe76-08da9d4e2160
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT079.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9285
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set property to its default value (as done in all other methods listed
in parsers[]).
---
 src/advertising.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index 25df2297b3c1..f9748b1328bc 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1153,8 +1153,10 @@ static bool parse_tx_power(DBusMessageIter *iter,
 	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
 		return true;
 
-	if (!iter)
+	if (!iter) {
+		client->tx_power = ADV_TX_POWER_NO_PREFERENCE;
 		return false;
+	}
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_INT16)
 		return false;
-- 
2.35.3

