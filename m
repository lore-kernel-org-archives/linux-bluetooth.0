Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C95FECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 10:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIWK2K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiIWK1j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 06:27:39 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2090.outbound.protection.outlook.com [40.107.20.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271D9127572
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 03:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyJotGus/iyhQDfoi0wN73mV2E2sGbFO/LP4a0p5MmkUS9JwwOLJQq97z2z1/oqZFI085MhGSUFRKpX7njuotp3xmRLDyZBfBLsWoMKD7CCZHz++lBUcIZZleh4Lc6QRhGbn1baICn2mCI7XaoErhnU+7TaoWkDW9/1PRqABwLZ59APk/fFHu8Jtu0dnDL2Pw7ai+426y8mQk7gwyTWR/T2+J/dzviFbbBbcU+zl8pRpibhBHfLQxG2tjCN7HjBtMdssWs7vZ5Cro3YMe4nPMDeroNPWF+As9I2dTZhwOjwlDsRU9IRhrZmN1zE9IRObm1V+WRMr3Tef8B7uCaB3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSbi6+k37guWem+w6BlluuZ8MMzpI8/vEN1ugopTTr4=;
 b=VraHaar6ctwokIPtzNGEDCsWVfHZtb2Sjby5GCi4OFZPIzSb4C/ogLWacfAmRD0VXSXrqLJfqbt2+oZeONIJjLNnYXNU7nYnth/brI6RfXpIudf+lG6S8+Vg4SxFNZLNs9LGiOvqhaY099bHwJE+27Wcp3iS+Ju12m2cJs8OA6sKUAawbglVBfm4JJUsGCfwI4hnwYp8mT0ujaZ4TDnv1G06tgA1YAyWbnsLTQMis2UbyuxmCyGlIkDAd0bsHNQHRFdjdv+wU1csY8OgAoW9ZA7SoGgKwXO5zioPRmLMvAvRcJHgSxsuj8yD99xwr5IBf+vUIBCWNTDsrpKd1nfIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSbi6+k37guWem+w6BlluuZ8MMzpI8/vEN1ugopTTr4=;
 b=Yh3wi+6rAO0icTuW24bFEENiYbcN75kn4L9L0xjLgktY3/4/ss2hKmMV1W6U/jFXu00h494VxdKSNHUwJgtEjZepMRZKO5jgEk6jKsAfKvn0PA5frqUHyjAWqKOrjqbVetzf6R/9hG4Xi1+pJwA9ReQuCT5kHBIx/rrirUwyKug=
Received: from AM7PR04CA0029.eurprd04.prod.outlook.com (2603:10a6:20b:110::39)
 by AM7PR07MB6423.eurprd07.prod.outlook.com (2603:10a6:20b:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.8; Fri, 23 Sep
 2022 10:27:36 +0000
Received: from AM5EUR02FT013.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:110:cafe::6) by AM7PR04CA0029.outlook.office365.com
 (2603:10a6:20b:110::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 10:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM5EUR02FT013.mail.protection.outlook.com (10.152.8.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.19 via Frontend Transport; Fri, 23 Sep 2022 10:27:35 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 12:27:34 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 9/9] battery: provided_battery_property_changed_cb: check for NULL iterator
Date:   Fri, 23 Sep 2022 12:27:27 +0200
Message-ID: <20220923102727.10636-1-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923102421.10336-1-ceggers@arri.de>
References: <20220923102421.10336-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5EUR02FT013:EE_|AM7PR07MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ad98f7-e45c-4e17-7c3b-08da9d4e3b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2K6hNs4Ir8WLEMYSIRkn9bN9lNgxkLccCKNPwoqIUstL/WGcDcWIUCXUeyaWtVCullDUU9ZBI7HEHzGBANnDCN4hnUeHS54Oqvv3m2B1VSRrBC8L7nQtRtJ7wBfD/foEPsAD5liJymzTYnHSioRPMH16tyvCxLx2FOTFk6ZJqJx6pUryKDAIeFGFJzNKvqM5dhImInqB3mjv3HcpgepnaK8oJwxujexBVFl0AjU6RScQK+ZcOkWMaSJlbhglt1YcIF/fY0s+4/TIGsGSojy/ipS7nwoogk42AWgwjOlmvaBKV7CRrPnmQ9XdxtpXlLKuHQL3cI3eu0ZEFqrZYryv0EFUJ/O48fIX40I8nZR1YmoIOUBb5GGBgOgxz5uD/XSfWnLVYYZdGzoWRUWpE3APy87iMWG2IhehFfqyRpmcccmu6ATJai7VT+ELU20ll0i2WFsm4heeIGVX5QezZqik9esjpBlV2Q8cjC12p9wRajz6lwZIQF5Hyu5nnMTzHxWx7jfZR4SYSolN/KExsMc4Spzhhd7HTlqRStrKkc9toajo1GAozp4a7eMq/pPdipnAX99YV0yCYN0kCPjU2Im90EunO0v5d5kF6LEZQ0GSWPpVgs8fsITbTFJKB3kcSCtyp8B6si9oewc3ajE9ue8uUEc8qteewtzaW8oObgOaWhvMLdWmNHNpkXdUGwFJAkk9Wmqr17Vz8IqnMyqMfpSfxbrQExJZh0vJLYWHhl0JUEGB11Mmt2f9ApWB8W7d/HysYfEpyRK8hMAq1d16XToR/g==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39850400004)(376002)(396003)(451199015)(36840700001)(46966006)(82310400005)(70586007)(70206006)(4326008)(26005)(7696005)(83380400001)(426003)(336012)(356005)(86362001)(107886003)(8676002)(36860700001)(41300700001)(40480700001)(5660300002)(6666004)(8936002)(36756003)(6916009)(316002)(81166007)(2616005)(47076005)(2906002)(16526019)(186003)(1076003)(478600001)(82740400003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:27:35.0917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ad98f7-e45c-4e17-7c3b-08da9d4e3b21
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT013.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6423
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The passed iterator can be NULL as in
gdbus/client.c::properties_changed():
...
   proxy->prop_func(..., ..., iter=NULL, ...)
   +--src/battery.c::provided_battery_property_changed_cb(, , iter, );
      +--dbus_message_iter_get_arg_type(iter);
...
---
 src/battery.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/battery.c b/src/battery.c
index 77fee22b6e61..88a53e80e890 100644
--- a/src/battery.c
+++ b/src/battery.c
@@ -252,7 +252,7 @@ static void provided_battery_property_changed_cb(GDBusProxy *proxy,
 						 DBusMessageIter *iter,
 						 void *user_data)
 {
-	uint8_t percentage;
+	uint8_t percentage = 0;
 	const char *export_path;
 	DBusMessageIter dev_iter;
 
@@ -264,10 +264,12 @@ static void provided_battery_property_changed_cb(GDBusProxy *proxy,
 	if (strcmp(name, "Percentage") != 0)
 		return;
 
-	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BYTE)
-		return;
+	if (iter) {
+		if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BYTE)
+			return;
 
-	dbus_message_iter_get_basic(iter, &percentage);
+		dbus_message_iter_get_basic(iter, &percentage);
+	}
 
 	DBG("battery percentage changed on %s, percentage = %d",
 	    g_dbus_proxy_get_path(proxy), percentage);
-- 
2.35.3

