Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F9FC6FA91
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 10:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiIWKZB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiIWKYm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 06:24:42 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150130.outbound.protection.outlook.com [40.107.15.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A759A2A254
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 03:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhnwmHnKBbyMUP7dezNgiJFwiT3oBK+8+ulzX0g+//0pEmHy/mZyCmzWqjD5IuI+lL9UXHDZOdQeiCPxOkNShYAcXp59/Shorz1xVXlZaspHzmQg8nC45g6QRb6Dq/k+0qJkLz++r7ThHHXHiM0OX3jj0ioFaKSMLSnkvdc8pFhcj+LOCeru3Aeo/g0Zm5joqUPATyTRJ+Uk8/Z7nP5EFyQv32cIP/bIyXthDMIXv5M7AtqQRmkOnlA0oaZKxzKKFHE6/pqhSv9DP4uwrcPImRciWplYLQCp17zz0ed2jxavtGCzKygEgj/C59Xz0ERBQB2c4rQwH5yq7ai3edc5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjbxFr4iddCxoS3QntGD62ky+vBohrSJzyTxRk0PoQU=;
 b=b4uGEmCUNkfTXspLQSOVWhLKP9KXOaSMJY4ZudOaQvTQ3EXDeVcC8bYC1MSMNbS5i6KKAcEEbKVL415vDhFOAJp/Zu3Z2QHsP/zf8WOgpYdKoD9/x1O1QM4q+c/ihPUGeIG0Oc1nAOh4DN3NikTf3XuxskXmuCegOLErCDgN8xGKSgiwrs2nmyVnH3pO5jCAj+qNSFRDt5PZJHpri1iaqBuTny6u28RpCiv+W8H41O/70pubBu3ZeSLOrFLHV7WZVnRvBeZ0CaeQW3vhC+ujWcANAtgfrX4/Qck2R9xY6U9+Rzv04/I7E2xcOWVWwZpGYl3arv5CeDstN4fjpwxGFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjbxFr4iddCxoS3QntGD62ky+vBohrSJzyTxRk0PoQU=;
 b=YcWL8RRjzm6dnTt9vJG9gsK1Y9IwjQ5CMaPsViZqnx4FAG1Og1F3Li2js/+KPXpZ4mg6JHqV+xFEhPaWqZwGQAZ7ujSN1x6fd8urgdRU9BTq4Q0h3TcBHMrJ4ENJUx1h4+b56f9gqvCWk4OvRhUUKxPMsPtqek4GHklHXyvrw5Y=
Received: from DB9PR06CA0024.eurprd06.prod.outlook.com (2603:10a6:10:1db::29)
 by AM7PR07MB6359.eurprd07.prod.outlook.com (2603:10a6:20b:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7; Fri, 23 Sep
 2022 10:24:37 +0000
Received: from DB5EUR02FT021.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:10:1db:cafe::25) by DB9PR06CA0024.outlook.office365.com
 (2603:10a6:10:1db::29) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 10:24:37 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 12:24:35 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 3/9] advertising: parse_secondary: check for NULL iterator
Date:   Fri, 23 Sep 2022 12:24:15 +0200
Message-ID: <20220923102421.10336-4-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923102421.10336-1-ceggers@arri.de>
References: <20220923102421.10336-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR02FT021:EE_|AM7PR07MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de2754f-027e-41af-41e0-08da9d4dd152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHFFKvkHZNuZ+Q8mw2H2TujlK1y3i+BF6eN4h6wevd8Z/ilVA5wZ2JPs4ezFj9PlhTSQBNlKFIqdnBfIEhUmtUZGXR5k4+VsSxn9AyOXgG2Mt83ZtyEzG9R998Jr//3RFKcwURsvaBnTeBsgVATjypjqV2Z3WXaVHZkoLk4N3vLwnj1N6s7xdKVyLLPIGMFjfMpjDlSR86OKriYEj+btrnArsgUpQp3Ih4Lc8BmyowJ2hTkO2y0Xpv+9OJbDFff9aESGUiSA2NGQtrbIvmgUnTTcwP8l3CLpFOujyI7DYDu+zdZ5+geTHL2NyfkQG/RuFgAnWhwaGz1GD/tiEyxqHwqyoWX79Sur6jFh4yUXk5jRPnN1CfTUW4CPCPA20/fCUe6E62jrDGgp+WgeAvm75v/YHVtLFdqMKgHcCCbqVztOE/zjpZfN4MXjZRykH2Yxvn08Je8rOf87Ha8jeBpliUvv9Zt5KCMgNSEc7s1TOcXmW5tvYPY2xL5CjCbRDjSKjMU3jOIdqVBANdv/vAVvjx0SiOWJjr9Md3RTCBWRaUVTXTtxLdCNhbcw3DSM9buKDTsCSFcgLBwmKnspwbVCzfpF3rlAkrhNlAebL8z0om9AgkwPkm/Uerae8qs0qnrGELQYHiJ4xpyoBHJ5qbXyGL5SjjsK/TDESup2KeSTjVFvY+HH0LpDQkII29ONxOaF4P6O1aAP5POOYxPE10+/mcMZxuyowyHlC+NBZ7ZgY5Xz+akLTI21xRuW1Vy/BHn4h3FHBKfYAUUGHVkFSCPbK4u692bCDueh13ezLjZIhaFpM42wAWSkCV/4r6w67e/s
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(46966006)(36840700001)(8676002)(2906002)(186003)(8936002)(36756003)(16526019)(7696005)(26005)(4744005)(5660300002)(4326008)(107886003)(6666004)(41300700001)(36860700001)(82740400003)(81166007)(82310400005)(356005)(336012)(47076005)(40480700001)(83380400001)(70586007)(86362001)(1076003)(426003)(2616005)(6916009)(316002)(70206006)(478600001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:24:37.5436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de2754f-027e-41af-41e0-08da9d4dd152
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR02FT021.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6359
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

