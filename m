Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35381ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 14:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiIWOds (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbiIWOdo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 10:33:44 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2138.outbound.protection.outlook.com [40.107.20.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458985F7FE
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 07:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7t/RXIgTZsJ3LAKV3XThfRzNaWhFcQnfdIWVJdoPDwzLtRTIgkOruz8KcP+CBa3AKxC4yFgWeKOhMRu/7+3PdLiGtwIqf4QtLYNjWxYvlttDqNMOarKw4Cx75NbAYlf++C2jaYfXG8mCwIjE32kJVBz3l56ZwMudoUbN2qKXJ/gDW4kbgqcaEp8iibf5pphLa86/7rkx6UFKC4A0JZ9ekPILRJKcCpFlwtixDXWMWT4toFErr+cYwP8DtgVkYxv7lcaO/0y7m2nCp+3HYg93ONcLCOHN2k5cDZX/w2UCJvniM2IJVnhG+z8dvZ+tuOsEXsII/NrFCwLHGk22RqRJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gwpdCX4zhWYQYqMM9N1rfmOKJD6EHK+Cytu+ZmBeZY=;
 b=i6AyrYxacpgm5nJVuHH9AI64vbCWD+6aU5qm+a3vD8cxmwIClfD/YR9lp88OyZ0UKD8i3gYagCv1JUG4i587PIN+v3le2ehIV54PONbwdqMArAhnR+t7UYc1rveciDR7EanowUXJvn1SITfR1VbJi75yFGNtyGbbEJio1MKEJkgMzsrzptrLS51UxU37nbUa1zUf6BS+T7g7Vpvvom9DmZawpSSzztZo/NHmqWT0SGJMWUDx3EyKxDKQ7HPwJG0iyKzLQuVrX37Em735ynQ7vNIOYiRwkQijvZNGArxO/5uLTmiA7N3Oe0W6ByYkqEUl20O0rsMALLRrP+4K8CLAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gwpdCX4zhWYQYqMM9N1rfmOKJD6EHK+Cytu+ZmBeZY=;
 b=gZ/6R1cfH7FQl1ZSGx5r7XCqBd88gx/mqlbXa5L5ed2Ape/Vtp38HfXNteLB5Cz/G+cMiHzfiFEY0yz7kiwIqWbFRSfMnq4DJ5bfGeVNh8DuiwEkDqKXuHAulBK4YPc56kxE25SvQp14jMGk1/meVzmCXFds4EDTJOeyRLRNcgg=
Received: from AS9PR06CA0769.eurprd06.prod.outlook.com (2603:10a6:20b:484::24)
 by AM0PR07MB6292.eurprd07.prod.outlook.com (2603:10a6:20b:152::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Fri, 23 Sep
 2022 14:33:40 +0000
Received: from AM5EUR02FT062.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:484:cafe::9a) by AS9PR06CA0769.outlook.office365.com
 (2603:10a6:20b:484::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 14:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM5EUR02FT062.mail.protection.outlook.com (10.152.9.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 14:33:39 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 16:33:38 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ] client/gatt: gatt_register_app: fix parsing of UUIDs
Date:   Fri, 23 Sep 2022 16:33:31 +0200
Message-ID: <20220923143331.18926-1-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5EUR02FT062:EE_|AM0PR07MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 5123dcc4-a9b1-4160-c301-08da9d709b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLBNo+hwIH7u6Zx4le2XLrDy2RfSOMek4OquFPphQZyuy1uIaU0m/WV8T4FQv0ra6sNnF5LOH5U+udSyf6nFtVWzqm+zDA4cJZS48CJRXcyrkwhFPsYqlrtBozLTbflaTLBHdPEhHGq/U6HecWFBEm5mf4c+4QMbA+ZtAIGzviLqWCKelkq5WEwF2nb+xpzbZT2lIR6hJpYaxpyF7BftLcGuf91B23SEth3f0cIx2qlQcUDT18neJdZelDUSV/wkTtZMDI3bqeOilsRfjuG3QhtZa6utI16SAiXCZCykOhKcR+oNvIIkfWVr6JdzxuoE3oxlYJj/gMLssuS2CdTQyYK+kiMLzgYlddqjzBSqvvC8T3jSzd8M3faQDXEl0hui2wktjDmacuTyWQVOdQRbolQMiUsdR7yfiQflrKHJyKPqOiueXkPo39hvgCJPneTmXBxqWRdSw1c07obp9Q/fyU8MzhfC+4bQNAifzVmCiCyO1wn5z29Yw3PWFSXeYb6ZuvPxmyvQdG5dWeDDWpoDYaYOXLe3h2nTRsZOi8DlXtSRXH8gKY2TSoao/dW52LpMXdKtO4yIPHNqwi9jKZiAR6xoxbpPmAdbq9eR4+iPSw8mRugzJGMCR03/ZWeNjtBbAIp5YjrQ4f6qnRQzH3UBcTdYBO4msXvnf77yRDn3rpAE+ju/zJglewp8p3kXWRewKC71eTedTUz8ObazTlOPlA35XkjzjLleSXVnqhof3wpeu4SMr6mihVJJGc86HmMJeguq8glGLmJc1MrckbCjmZRj4dRLm1keuxMa3hTYUMd7jlq0hM07sog3nNo9CZRk
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(46966006)(36840700001)(426003)(336012)(47076005)(6666004)(2906002)(36756003)(107886003)(86362001)(7696005)(356005)(478600001)(81166007)(6916009)(8936002)(16526019)(4744005)(82740400003)(41300700001)(26005)(82310400005)(1076003)(2616005)(186003)(5660300002)(40480700001)(8676002)(316002)(4326008)(70206006)(70586007)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:33:39.6918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5123dcc4-a9b1-4160-c301-08da9d709b83
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT062.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6292
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

- argv[0] (shell command) must not be used as UUID argument
- fixed linked list iteration
---
 client/gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index c3bdd4710897..e9f505172735 100644
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

