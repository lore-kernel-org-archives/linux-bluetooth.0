Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B867ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 10:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiIWKY5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiIWKYm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 06:24:42 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2124.outbound.protection.outlook.com [40.107.20.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0073D286FE
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 03:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKewYyN1bDokN7hB7XqrEgwF7aLTDBPBvrplhU1Dp70YSu+3i/38w3JVp6dI0jzpMh4IeV4cy+4CjDj0DSocE798AFnLjJGNEdva4bQYJ6B6F7s1BqYBpGXkbUHyi9iE/WjT0/KcmTtsIr3FfTVLg6rGpAgmVAhC1vCkFWSS8bO/M5sOFXjRyg17DEdyybfiqZQEn3UC8X0LeGxjOFPUYETiDQwoKPS0zlRBe5DpEBJ4EWZnlP/CqL/I9noexlfruGesJGMJcHcrlj/qFCqGnTJEPP6Rs/PVIFvw7217ILAWpvZynBBzY7LRqU3pXs9TrW9fWJUk4kypiEC+x4hI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx4n8Ey4jJHwDiuMCCRfDkEVcTiu6ibOVcG6Lobm8bU=;
 b=XJyjJtoHBB/ggKmg1UJplukWBAS0Nrei1rFAyofv7y8ZfLHLiOFPc0MXwEr9SFlOEpCyFGJo5BWpETnJiJsaAVy3k9sORJL7ZWHm22k3ABzZfi07ZYzCVAhZ25eNm4b66kJxFPG+Kg03ZPyaw5BnE84pNZapjZfpCt4lpqcP3D42vi5ueC9Wl+pNobuEY+r3zzVlASDMY2KGmgzVtLVrYLlDUcP3I9kL7E0tKQ/SN6+fJ9iyZEIZ0T9upbZydRGLSa5KaeLfJF6EFwSj3jZrPbyp8T9NP/CkKv/llHn5RNluzUrG1M/W9PZRbDymyZhLnxF9kL5Kqo4Janlu/NAVwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx4n8Ey4jJHwDiuMCCRfDkEVcTiu6ibOVcG6Lobm8bU=;
 b=NLEUhxJUPyvwOOlDtyWjNsWFgsPuJbo7TYjiEkXLtgkEbWulH0u0HbYdGseba4d5fGUlVUxVVVw4McEXP5sW9fID00ObBGCuMuSccC6Ju/8BeBpmhp86XwQVCCiyxJorj1eEAg2FOWyNRAiwlqOX44Xq7hLM2Hh//RN/WXmaYNE=
Received: from DB9PR06CA0016.eurprd06.prod.outlook.com (2603:10a6:10:1db::21)
 by DU0PR07MB8465.eurprd07.prod.outlook.com (2603:10a6:10:354::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7; Fri, 23 Sep
 2022 10:24:37 +0000
Received: from DB5EUR02FT021.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:10:1db:cafe::69) by DB9PR06CA0016.outlook.office365.com
 (2603:10a6:10:1db::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 10:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5EUR02FT021.mail.protection.outlook.com (10.13.58.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 10:24:36 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 12:24:34 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 1/9] advertising: parse_secondary: fix loop condition
Date:   Fri, 23 Sep 2022 12:24:13 +0200
Message-ID: <20220923102421.10336-2-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923102421.10336-1-ceggers@arri.de>
References: <20220923102421.10336-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR02FT021:EE_|DU0PR07MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0f8d89-bda8-4c19-8307-08da9d4dd0f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARAdVxJeFgEYrROC+RslRg7HgmFmsBEGdjBqVvgIU+zLfnQXYxYk7o/9PNShHrKl+SGq2/B/tWtKETNlMv5MhXEelOV0DlVYyEEMzxr4XpYs4qgoN6QhzmnRXejTXKTMztz90O7AcMZIGK9+afWViIiKoOSaxi6dCkm16+I6rftWBk92CVjRb4ky9SXhUgMo0V8Yyz6mUCwfFWYuebwzCQncl9XBg8QjjeJFpO8m0gaEL70ArPSxgI9/hdv0/3sA6emF2vzBkKo7hr5fgnkA6u3iUaZkVK53/9vmY/v+WLUBaQPQT3LB/lp6/08M5BPZUIdmU5LpK5erJFf8aaHc/Ad458vg/S2oIHa60RkYHQisfle9dXod6qXBo2pMiOPLJ1dh2JeznDihm2Oh/bGEa238KlFbuBCdXSKPp2ke1sIbxXh6CMbz3jF5nr23Uwr95laTw1x7kEMBkMQ3j6c4TljBD5B7VtnA/8aeBa0aG5/Czwxf61AIZk/+24G26rJb3J/UOuwsD8wzCpxUXWjxAtxe6nTMUppzqQBNEi+g3tFgQTYjOY2R/N1+GEOuukRK0ryV1qeHKDMfB7KSdDKGeTUNhArOJ6g6Nt7mv8s8Y1cy/I1P+84PYhhhQIYD94zi+X+HCkcYKuvfwOa+f+44RTyxurKUK3AtDSKsVqAjR/mAkIC5chcqb/JrC4pVsWi6frY9rOQXaTpAzRPMvFwlTHHNgZr6UxZWFl67On3i2fzxOg7ra9+A1OyMqk84mPqpQO7YMBxcktrzGWVwt3WnOQ==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(46966006)(36840700001)(82740400003)(336012)(81166007)(16526019)(1076003)(186003)(86362001)(36860700001)(5660300002)(316002)(426003)(47076005)(70586007)(70206006)(8936002)(2906002)(40480700001)(6916009)(82310400005)(7696005)(478600001)(83380400001)(6666004)(41300700001)(107886003)(4326008)(36756003)(26005)(4744005)(356005)(8676002)(2616005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:24:36.8093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0f8d89-bda8-4c19-8307-08da9d4dd0f0
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR02FT021.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8465
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

"secondary" isn't an array of pointers, so the iterator can never be
NULL.
---
 src/advertising.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index 1fe371a9f345..15ef44def031 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1055,7 +1055,7 @@ static bool parse_secondary(DBusMessageIter *iter,
 
 	dbus_message_iter_get_basic(iter, &str);
 
-	for (sec = secondary; sec && sec->name; sec++) {
+	for (sec = secondary; sec->name; sec++) {
 		if (strcmp(str, sec->name))
 			continue;
 
-- 
2.35.3

