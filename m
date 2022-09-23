Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B799FC6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 14:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiIWO4h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiIWO4e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 10:56:34 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20114.outbound.protection.outlook.com [40.107.2.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D68115BEF
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 07:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lm82qConztU3acubbzLyrHn4CyPnzT5MXePWjJ23jHsIewZBSlcsj+KY/TnLJIOEHHnz9aA57BLhM/yC3VOsRwJKPg21QSGf3ZlnObu/RwSOJ8oPclVVAS+0N+oQQs+r3sGojlwt79SfxYyOZWsIrD/emKPuWJzCbDmVBOmj5y72FJ0b98tjGl3vHFdwzmDAx9pX2zMY8q4AtzwEOfFAqo4SQWEfmMvqKn9/Y5EQf6hU/UIZRAUNvU2h0DWJcyZwPcMDmQRtBrp6Gpxg+r708wLluPVKIspahcBVDmq1VSMr1UthMGsbcOC6hIRyU+AaRFOhEBo1A0HKmwFJCFeNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjbxFr4iddCxoS3QntGD62ky+vBohrSJzyTxRk0PoQU=;
 b=MfO5+Ua4xQ/PHGXRzph2x7GUHlbuSyZ/Pyo4a+5lWbHvIjanmhq2pEg9KsaD+G908Lm+LPJxRC4PtyqA40RespILXaAbM5IofS2QkRWck8V5VEOywchOp651hdCg4e4uqn55xzG4XHo4UAtRhlTjOVUOeNMoD7NUgLjSk6avHfbeJs9vesfJ9PJnyf0yy37Gb1ac23bsbS/djXpzy8TVEoJhAwUKy/1f+iOlXpWCrYESEwKxcnuHKz9Nw+SMuWigrA0w3o4RrTxxGIn4QAiSUym3nMfj1pjmHIBmI7kU+vACaw3pKY4Y6WgI5xjdvI4Ug5btTHpjZvRgLY394FxIQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjbxFr4iddCxoS3QntGD62ky+vBohrSJzyTxRk0PoQU=;
 b=dl44vbfpMfuyjLOXithwB7CvOxviVSxzTUbWsWBViSF6SfQZqCBBxlmQgHMlTl35wEfJd0tD09u8kGrggRZv4osPp0/7zx184xumYpQjVNx0F3iDQjPL2mL8z8wOh+zNyVJKpfv7K7bQgMlO3knISLXoLqA1/nz1XMuNPIImFX4=
Received: from AS9PR06CA0635.eurprd06.prod.outlook.com (2603:10a6:20b:46f::7)
 by DBBPR07MB7499.eurprd07.prod.outlook.com (2603:10a6:10:1f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Fri, 23 Sep
 2022 14:56:28 +0000
Received: from VE1EUR02FT084.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:46f:cafe::11) by AS9PR06CA0635.outlook.office365.com
 (2603:10a6:20b:46f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 14:56:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 VE1EUR02FT084.mail.protection.outlook.com (10.152.13.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 14:56:27 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 16:56:27 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ v2 3/9] advertising: parse_secondary: check for NULL iterator
Date:   Fri, 23 Sep 2022 16:55:56 +0200
Message-ID: <20220923145602.25872-4-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923145602.25872-1-ceggers@arri.de>
References: <20220923145602.25872-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR02FT084:EE_|DBBPR07MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: b23e515a-a347-42b4-505e-08da9d73cb0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MvedsCCCglsDpqyQOfbn19QhRFweCsToOOd66nIGJGS2kOKWbftgopMGPANuVFJmX8RmTO/acXoSAhmiQ8JnRkwWpVsVUkzmOv2Gcxhtqs+TEO8eKz8JZOhuEaxlo/v59/uo2cZfNV5KwnDNYaIui8Mj5+rm+0pm4FJRU89SEoThQ1ApcAK+Sz0G3tA5MitqGY9vl89CutjBffWrMCqu+dZhryDPAI71dlksjpLbmRGPWc+voikeYZYMvun1Tx2HQrpLTYNDU0xSXPmyuTfb7BQbnNOElNYPOPPW6r2pz5UI59HrQC5xB+29bP3+cRh/riCSEw9msXFlVnnrbuCAmRC6fevX0NMvpoCafJagQA0K8KNsEzoju8nM2Byq5nuxeEOfTNskVsbSykNCjLW5yBBv9Iai5wP1YKlSZAVlcZDmYAok9ex4+pqwhGJ668s4Lk9UPs2vkIvVjx58kQOFMVMRdhb+4zTo7w+Bk3bM6CCVMlVDv1QdvM1RQBuaq+GCwfVcR4N+IhmxRl4z7vuVK6HtYMeR/jD6ihTKsg+/hqTAsHfWeiaWdj3IUu4t3cbx0QquJDfiauLGcEc/mP9v4htOPnniK+SyoKQgVONkl/FydwkrYrzyB8zUY3nphJrugj3l2FVns5WxLITiMBlEloIqPHschsSNOTPcQNhIMdiophpDDzEibh7K5r7IQZvAZEJibomnM8+mNPI5IJjGgINdriKAbMuSQxrIDlquanX7FYbgSS0WqI55Z8qOnxsEic50XpOYeLRIWpW2jc1+JXTAxfLNP0AJhzQVCTscRkch2/ne8dW+YhEhKQGoKM/z
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(46966006)(36840700001)(7696005)(478600001)(6666004)(316002)(82740400003)(356005)(36756003)(81166007)(6916009)(107886003)(83380400001)(70586007)(36860700001)(40480700001)(2616005)(26005)(426003)(47076005)(1076003)(70206006)(186003)(16526019)(336012)(86362001)(2906002)(8676002)(82310400005)(41300700001)(5660300002)(8936002)(4744005)(4326008)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:56:27.9193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b23e515a-a347-42b4-505e-08da9d73cb0b
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT084.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7499
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The passed iterator can be NULL as in
gdbus/client.c::properties_changed():
...
   proxy->prop_func(..., ..., iter=NULL, ...)
   +--src/advertising.c::properties_changed(..., ..., iter, ...);
      +--parse_secondary(iter, ...);
...
---
 src/advertising.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 42ac627604fe..6d8d06edd34f 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1047,6 +1047,12 @@ static bool parse_secondary(DBusMessageIter *iter,
 	const char *str;
 	struct adv_secondary *sec;
 
+	if (!iter) {
+		/* Reset secondary channels */
+		client->flags &= ~MGMT_ADV_FLAG_SEC_MASK;
+		return true;
+	}
+
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
 		return false;
 
-- 
2.35.3

