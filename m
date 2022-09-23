Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B89ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 10:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIWKwR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiIWKwC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 06:52:02 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70102.outbound.protection.outlook.com [40.107.7.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2F5A6C57
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 03:51:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCERd2Q06qte1J9erj54QRI/dW7+QrjxRkBu4x/551ZGVMkkvy5kv6ooYexo9yHgnFBtQdKyHwLpeIukdGT9d4T/PljJl6hyqExfEFSGSRwCp8gV/JRFQKyLhHt/ygX4DIAiydwxxXxSjTIPhBNwg5r2ufNOpIBvHkhjq6ZXI4sAHi0T7HSdNyKu1wLqilOw0ddC1ojqJjDB6GYp7nyN7G9ruLvdwSJoUZn0Zq+rCRVPEZTlIXPm6hviWnV0UlMY7iew5LoVHRN1ygUMP6kJip/FPrzVDWNNcyxzKj4eZtvM5jWDuvSjnEyrBL/5qGzVO/ZgIhNzeZ7ps3V+jcqIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpHqeuIKsEsGRDsZvj7O0lI1rwtdZ/lSaqEmOLIK3rY=;
 b=RApy04e302thO7lLvgwafiBw/cnUnDm0DRxdf81n2euKhIYAIxLgRpt8d1F7kb9L4kZixhcpLPeSTP2XWhl/al3tBY0z5gTmzHWtpFvaOu4FxSpMKpLyOGE+d8oRy7E/YFxMDiYC70COqDW/Fk5ucisJByiiLGgkVpRamSRUs8h6ZgWbqdkTwthqC02+BYWPOUbiQWMwxRHuxh42FT4b7n4kHdGoK5ccA1Oeq7NCsu05p+Lyanc/9DZDWf9bp2FAywEdqM7R491P5la/AUDOtcXamlDZLda4ZjTacvz+2azuWnU3s6VZ6oaZoe2NWO8id5XBOps+PYUYVhTRPfjoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpHqeuIKsEsGRDsZvj7O0lI1rwtdZ/lSaqEmOLIK3rY=;
 b=i8qbAaxbWiuqSqxuV/rSARR4loHckb/xpzjuHmz5saX7Am3VwpQmIfXXZJCV1GkLwI8sDz9jBjV8hCw/Cly0WZqyeuhWo13VBl0HCmCnjNc1dqix2OqTJ45Of3wJY/ZF5YkRB1tOjwvjYGZZ4yGnv7pLlNT4VuomvWCfgCL4eWI=
Received: from GV3P280CA0030.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::35) by
 DU2PR07MB8078.eurprd07.prod.outlook.com (2603:10a6:10:23a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.7; Fri, 23 Sep 2022 10:51:56 +0000
Received: from HE1EUR02FT065.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:150:b:cafe::f4) by GV3P280CA0030.outlook.office365.com
 (2603:10a6:150:b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Fri, 23 Sep 2022 10:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 HE1EUR02FT065.mail.protection.outlook.com (10.152.11.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 10:51:55 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 12:51:54 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 1/3] client/player: fix printf format string
Date:   Fri, 23 Sep 2022 12:51:39 +0200
Message-ID: <20220923105141.20176-1-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR02FT065:EE_|DU2PR07MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 4364c82c-4ecb-4127-ace2-08da9d51a1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsKZl5ejnDeKSoOJddEq1DqZgFqkv33LQlxTV/JVHghpLQdDJ5rGgtxQVsGQSvOrZa3Gn0Y++FcdmCHjwWSjL9diYhUq20W6TaV/X/3HDTn7IApOO+C4nX3wEXN9Lm8bZ0KFz3VANMVWgszLcGOVCSXiTLpX4bKEPemi7aFITTFM44Ti03RDL3mmg8nUgQAF9jvHLet/A+Y3gcXIFBLzsYSs/urycVS7mBkhEwDWtyiTg8lPdKoOUUZvlAFra3K2CuIU4+5cznTj4duDSxrLtf8HH0KV/h6slaUnp7UmEcijyc4i32fJhOc17HhzpIBOqCFp1mlV1CLmuunjEgY+CsamSCW3CwwS/fpbMeHqgvZIU2mOwHDlJyRSNsFU9EBnB7mjc0skF6aZMdKnYODm6ozIAZxLIXoO+usN5Z0PaQGxwrwTvjIrlsJf9M+Ve09ciorNMB5NUYdZidgVk+VnpjnppsoAnjSEjBJ8C9TGutLNOxp0r58tIGsa/YEKRaMHyTcumv32JxS3Ip6zH6khnSzO/cEGwp68aDUfrhtqpolfIjTPztmdBqHnSzpisWgugVjFa2avA87DCu+U+PwZwOVDaierdCsiwlOKb4pDUDjT+Dzkw29N4uLEBk2N5P3vwD/coe0dN/QLLbAje4ZcDrPEYfbqjeNh5n6DIfQuRCHkfDgS/aAvNTldBGQRr7ZiAEqxed+NWkBR8G7xkXwMS6diQAbKeR/yFU9RwUKZFPckVwVxUHTZL2UD4P5OjfbgLurMhqBfp6GR8ankmfkUvpdEI6CLLq++x2TBuYAFwsO8t+m+8ooiGB9HPGjzgfka
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(46966006)(36840700001)(36756003)(2906002)(186003)(8936002)(2616005)(4744005)(16526019)(336012)(86362001)(1076003)(26005)(426003)(41300700001)(356005)(70586007)(47076005)(4326008)(70206006)(8676002)(81166007)(82310400005)(316002)(82740400003)(36860700001)(7696005)(6916009)(83380400001)(5660300002)(6666004)(107886003)(478600001)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:51:55.6683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4364c82c-4ecb-4127-ace2-08da9d51a1b7
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT065.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8078
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use macros from inttypes.h for correct printf format specifier for
int64_t
---
 client/player.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index 0daacabf3c27..30ae263c8e41 100644
--- a/client/player.c
+++ b/client/player.c
@@ -15,7 +15,7 @@
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <stdbool.h>
-#include <stdint.h>
+#include <inttypes.h>
 #include <errno.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -3056,7 +3056,7 @@ static void send_wait(struct timespec *t_start, uint32_t us)
 	delta_us = us - TS_USEC(&t_diff);
 
 	if (delta_us < 0) {
-		bt_shell_printf("Send is behind: %zd us - skip sleep",
+		bt_shell_printf("Send is behind: %" PRId64 " us - skip sleep",
 							delta_us);
 		delta_us = 1000;
 	}
-- 
2.35.3

