Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCF5C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 14:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiIWO5p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiIWO5o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 10:57:44 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2106.outbound.protection.outlook.com [40.107.104.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB43115F4F
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 07:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S23VdAeEw8JAWNYY3xOzrdP+dM77fI9ZoZbfCD9A7PikM2jgQP9IT3dRMJap/3FP2MJQMoiyIVP6rxIPTw/bAm/WgOm60j3v+V0buPYScEQBzsTO9i2i2gpa4UsKnLJvmWhdQ+xYgQp3+yGwrUBR9gMshjWHNhBeBL6+3KhuE1qnUtNkDpI2l1M07xSvEWzoev0yTjjtGxFKOu9Osg8kDpM/WvN4QWEcZhf7Ie6yzUOc1JZGDz0gSxEOCKUao4tQZ9UV/DGWhnywwWk1R9t0m/dhdHhwmlBRJiR6Jdi9LtfEVZGcAuECa3ofs5A5H3kF3MQZdRpqU9/rKLfcukg00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20GxCM1TBI8yh9oi30c2x/QL5EPjeVyvmbAQDgsqlyY=;
 b=KJg6FkVBN+br3+vrzGs9gIW4TreZi7PTE7Y2I9SxyEcymz6TJ//uDy628VeZ8R+wsvSgzNpwMPUWnXy1yXIrylHLJOW4cWsutBJl9jetaYYXrYy13xrl1tFLc2OggESNdawZxVaP/8uPGBtzTlcY+l94IWeYk87Wtx4sC7L7jhtNylQBg/jVFIs+Y80A7zKyuKifBAKy4TDqnDF1RAyFjgkh5OBKLFH/nmA7L+Wrv83eR9Q0GwhZj/9wH9m8ydPkqjqyFhWS4KA8O12Dvb0cb6si44yDRt9dWCPeT/N5FhNJaIw500xf6fd+U0Ma+fUnBau7qOYPYyqSlwnkdAFftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20GxCM1TBI8yh9oi30c2x/QL5EPjeVyvmbAQDgsqlyY=;
 b=gUIzP9InQlFup1XES9wBw35lnEhvv7IbZRkKIvNjvzaAXoB1gEGCFdSyIc4VWZA4b9zFXDkvzaqUzFhokiCaB1vW8gS3s4IbUXwwoJ8+CoxwHsfB2jxB0+zSc5Go5+zYMBufp2jxIq0tp4wLvzAEQQAzpku+LaoIQi3mTxCHmpk=
Received: from FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a1::7) by
 PA4PR07MB8392.eurprd07.prod.outlook.com (2603:10a6:102:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Fri, 23 Sep
 2022 14:57:41 +0000
Received: from VE1EUR02FT101.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:d10:a1:cafe::c2) by FR3P281CA0095.outlook.office365.com
 (2603:10a6:d10:a1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Fri, 23 Sep 2022 14:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 VE1EUR02FT101.mail.protection.outlook.com (10.152.13.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 14:57:41 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 16:57:40 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ v2 5/9] advertising: parse_[min|max]_interval: reset value if iter is NULL
Date:   Fri, 23 Sep 2022 16:57:31 +0200
Message-ID: <20220923145731.26014-1-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923145602.25872-1-ceggers@arri.de>
References: <20220923145602.25872-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR02FT101:EE_|PA4PR07MB8392:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7c8717-5f1d-45fe-52d5-08da9d73f6cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zwh/MVZNDzKENhxy8w/JWda29ugfk246A/go5RNSXXO2otadcnCXGg9AsT+wcG8mt2X3VritIu/p/L1Yx9PFcpTU1vd1lgEq01qntFDUmNlYyLw8KQtHk1nd7vjX2JEDhBGjZ/Qlouv1uH7VE4KH/UMFas4lMzhuHPjnvfLUXkiLiLdyesuIgPA4OaLqzr5lp+eOym23ThYzMzkn5sh025hdZWsuCIKryloUJzkC7udvz2KP0IaFul72lQ6s5wxil9sEgypP6eMCfAPnECWMhHI3Ff6FSWAOx0B+c/QiDhOC7jhftS9CGyHauZa+UAIfwEb44Agh3oK01qf5/WbTSl4S/51Gvc8Q9F007zR1j4+wKlB6suX3hPlan2FeNXUX/eBvKCQ6GMxk0guvAlW0kNqzveSGMYuMEmjsgBKs8P8zAsDDavLGs0gy4F4O6yoQq4iHxhyDNr3YePp2GoZyKqCBWAO6IQ01x0FKaeLzUi393/fhXuePZnHenIcNo4unwRswXqMwwBn8TF0cGhygcHs+JQs5IT/0n8gyx4oiekT6G7YS5k+yC7Z0JTk12iqumwMRub572J1GGj/n8As7Nl9gh6w9Lj013U3Jg5F7OYpFi5yM2EoGEcy/q/+nGpBMHyRhQWNfnQ+Jv8q2Hfo9yU4u56x0GHB9yTbOwUOtL51GdnEgA5E9O0dH7PtCaTm8QMZl8z3UWUGWdpdqeRHi0HZ3TkYsIZCGvxPnNa7Ga9OIZTc8RASeptAgEqvxtW4lF8TNaaqsSR43RdHDpQtrQVfOOZjDJYabwm6JJNSHcx7iEhoU6nHwxgD6F1CmdWuO
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(46966006)(36840700001)(83380400001)(36860700001)(7696005)(6916009)(426003)(5660300002)(47076005)(82740400003)(186003)(82310400005)(16526019)(356005)(316002)(1076003)(81166007)(336012)(70586007)(2906002)(41300700001)(26005)(2616005)(107886003)(6666004)(8676002)(4326008)(4744005)(8936002)(36756003)(478600001)(70206006)(40480700001)(86362001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:57:41.3328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7c8717-5f1d-45fe-52d5-08da9d73f6cd
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT101.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8392
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set property to its default value (as done in all other methods listed
in parsers[]).
---
 src/advertising.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index fbfd90b4e300..25df2297b3c1 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1120,8 +1120,10 @@ static bool parse_max_interval(DBusMessageIter *iter,
 	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
 		return true;
 
-	if (!iter)
+	if (!iter) {
+		client->max_interval = 0;
 		return false;
+	}
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
 		return false;
-- 
2.35.3

