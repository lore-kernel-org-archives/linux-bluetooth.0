Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AFEC6FA86
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 10:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiIWK0f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiIWK0M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 06:26:12 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2133.outbound.protection.outlook.com [40.107.20.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B016C122634
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 03:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7f8KgGno26jOosnZ+LfOqjZ4ivizYEyV/XJwyUHyDgYlh2XAclJ+vkqrOgtDYkb9IYpgDdZ/V2FYXHePcXBXjONdcSkzazzdufTEz8dUCYEAx2LeQJ1s+agAvdK/Ccp0W5giV26NDCD1GlvO2t25jXJfMF+UpyaUNl7Sw4KiOf+dSDFwEaWz8X9aZ7sHRuGhwLU+Y+Mb5va5p3ksGteP8oFXTi0AosvMQIHPstNACIpWZ389nRHD0z52YHNCfkATk0zetWl0M6FAN2rxmTMmgghHRlOgodNiu8pkrOPPRL+9PgTbvvcyItTbbQn3blNb38mbPDczbvphaFpPk9grQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtlWoDHzNopj+BVHx9q7iaBrxukZTMksACG3+HW6T+s=;
 b=G97V/cvx72k3P/PhElVgBO9ee7iWOuyNfNP4Bktj/FDEzupn1wAFIuywVovJgfVrM94Dd93MXNfTgef1wYUL9vVeUUZQlE7qbIu7SDDE8cpE9axVq4IlUICr88SuN7KSLo1YetxV/vOyxj8BF0TqabKlIc+OSkiPVLkuqFayxQ3CeXj4A/Av5b2aiOG9iTBxHIPv2PnUbm0/JZRfa+k9Nf2QJoEZMcM0cycXxwz0IsHDpgPzEzFMVDlcYPtYu5PSvN00BpcXb431t5H5zpw9vKBgIMA89gsz3itvfJmS0uhN2LLEkWC/N40ZioBJTDPjNschqN6A2HiWvCWWsmgXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtlWoDHzNopj+BVHx9q7iaBrxukZTMksACG3+HW6T+s=;
 b=TI8hPvbrtxWTKZd65+zAC5HiVTQTB9+DPuS/HnHU4TnxwTpxMobQcYwX3/imFmZNetUFyvUvKQYOLcBEa+XQ46EM6HFJkUEO25Z7/QJag2reVzQ4Wfnboc/HzwDUeWtFG/roj1jn2yX9Isn4asd78MB92pY6F8WBMuOAPRUt0CY=
Received: from AS8PR07CA0036.eurprd07.prod.outlook.com (2603:10a6:20b:459::14)
 by AS8PR07MB9042.eurprd07.prod.outlook.com (2603:10a6:20b:56c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Fri, 23 Sep
 2022 10:26:09 +0000
Received: from AM5EUR02FT086.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:459:cafe::13) by AS8PR07CA0036.outlook.office365.com
 (2603:10a6:20b:459::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.8 via Frontend
 Transport; Fri, 23 Sep 2022 10:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM5EUR02FT086.mail.protection.outlook.com (10.152.9.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.19 via Frontend Transport; Fri, 23 Sep 2022 10:26:09 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 12:26:08 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 4/9] advertising: parse_min_interval: reset min_interval if iter is NULL
Date:   Fri, 23 Sep 2022 12:26:00 +0200
Message-ID: <20220923102600.10455-1-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923102421.10336-1-ceggers@arri.de>
References: <20220923102421.10336-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5EUR02FT086:EE_|AS8PR07MB9042:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3a0faa-84d6-4b07-b5af-08da9d4e07ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qnqf8e1wpBOoeu/l3MQaKA4HXfh7+IaRayI8NqXoyNWiMnrEXmMFl4e3ns1LYRLHZ6a/6hDo4y0yBW/F9dB8z8/o6tr0sbOsHCxzehvWYDDJ8DU2j2b0hGau6ZpSjSCPtmHBQcjFnUphhea8zILOhfGs5lTukWVZ+CoJsgs/e4RYCvm6WYIGaHeqwtKAUN4yR3u4JzGipAJRkZbrxn5LbW4j5bLC5umyrRx24vdt5f9/qIQ9mNP443ryu86NlnYLEcTenEBXEkwL7vlKQOQPDuVIMul3xtI74yAlAb0x9UqFXxq5jCgKpFbRj2FvADc2GcStT9tTO4ggFr8C5A2MNW1VZz57xwhR0MyUsqQG4L+WS7tH4+LDoJ5y8szFs3asJ8nrCOQK6fDKKJJif7GeWLGCehZPzwLdPccUAxdq3mO/wm3+8z8YBbxm9K5H+wryIYDfuleBN05B35PLK3PTiYYri2XFay7L/cskHVxrYcrz2giBQrzm7aXrFoJ168RicYi2uRaSuCcoNdPYwXHx2LXriG3HTPBoU33s3VKjd71lJRCC2sXwMWswuBCZIzLGWfV6ZANml4QfTjKhg7Iubdui8KP8nFzB7AqgOTAVBefQvepEuSzCIw9uTTQlmy8X3oNs1T+/13oupgN4qi3WNrDgCuP5zEXD+DSx+cHAvCZJXxF9BUd5wT/5z2HKPQZgh0rJ7jktN9oeyjapkMNzxzyXY7hgBZU0SwVJeolK49Id6YtawXHJMuQojiklWVl1ZELLXbmcQq8j7gy3AZ13OpP428wMxwuvHR11PIESxOKVAP9LmDAwi1WStjRXVV4
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(36840700001)(46966006)(1076003)(16526019)(336012)(186003)(47076005)(83380400001)(86362001)(36860700001)(356005)(2616005)(8936002)(82740400003)(4744005)(70586007)(70206006)(5660300002)(4326008)(2906002)(81166007)(40480700001)(82310400005)(107886003)(26005)(41300700001)(6666004)(7696005)(478600001)(426003)(316002)(6916009)(8676002)(36756003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:26:09.3086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3a0faa-84d6-4b07-b5af-08da9d4e07ff
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT086.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9042
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

