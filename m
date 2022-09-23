Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2EFC6FA86
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 10:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiIWK1j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiIWK1O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 06:27:14 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2125.outbound.protection.outlook.com [40.107.22.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E284A128A00
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 03:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJ43ARvOtXcPBBBdc/wcEu7w4d5gT1SwRYmqP6+TNlYjhv3jmxrgFvhDWPVMNAJ7F6vTEoxVovV4i1EHjHhS5XteVT3yOhi4/Isxdy7RzHRt3saHRysD+3sxB2sMyl2JtQdsO3DbZj3AdQM1DzkdPa1ynd6x8Qt65nfL3TJxxCxJsC7/QMuVbZPHhTOWSHM6SHLFKGTSqIwQH9I6qDaaedwadJdF8yPcO2BYg7OWyktLNlqGkra86rnwZ82hXDMl2ZS5QL7kjo3G7r/O7mXURJla28SghmTVzqkSRIXdpz57s/LtinFipOwBlSbk+yF4qS1ToO0SVIKtxZlFyTy0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0fG/vhW8SJYh7la0GWZb0ZZv09JXSHwOOqg2rG5Vj8=;
 b=c4KaJnbbviywqk9W863wa3hD8WxQKNHNAL5/ZA/zPSYVDCu4b/MErT+dknbTCOntq2GYU1o9T552pmFZ+awmHidm7L+FYanlgFYjP45kquoBJJydovCFKXpcddqyh6Ju/s4Nasp/UEP4D0PjNHz84mT5PZM59+5Qy2NEhGgfKRAzf/Zvna0DpsjmB1pm1NUlMhI7nWx5EbmeQNU2xaVwd8ck42KdOnw020JmLteZjp64uss7BlBcJ6do4Y7Wmd5UJKmpprTMihUWAL7yhORkcQwP3eszvs4INxfSlgVph7efPo5AXvOrR9NCUmNliKv5jfURkrjgHtFuie4HXYfpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0fG/vhW8SJYh7la0GWZb0ZZv09JXSHwOOqg2rG5Vj8=;
 b=TvbjG4Ai30UxIo2VPCZ1Gv/DqZHu6kLSx0b0XSwJUEx5Lmi4sv/XoHgsLF8YNj5LlOO3s0XGTQr0to1U+HQ3He/TAUJuMgRSyWNB1MheVVejl4EyvsHZvZb/WVrc5sDRiwaKRI3+JdxsSyB3jmc+OzVLxNLED6gpKZAjzQbzqGY=
Received: from AS9PR06CA0297.eurprd06.prod.outlook.com (2603:10a6:20b:45a::35)
 by AS8PR07MB8054.eurprd07.prod.outlook.com (2603:10a6:20b:359::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.8; Fri, 23 Sep
 2022 10:27:09 +0000
Received: from AM5EUR02FT062.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:45a:cafe::65) by AS9PR06CA0297.outlook.office365.com
 (2603:10a6:20b:45a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 10:27:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM5EUR02FT062.mail.protection.outlook.com (10.152.9.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 10:27:07 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 12:27:06 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 7/9] client/gatt: proxy_property_changed: check for NULL iterator
Date:   Fri, 23 Sep 2022 12:26:59 +0200
Message-ID: <20220923102659.10549-1-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923102421.10336-1-ceggers@arri.de>
References: <20220923102421.10336-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5EUR02FT062:EE_|AS8PR07MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 582cdbf3-4ccd-43b1-c7cc-08da9d4e2a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0OzST4Dz+iS6XEBz4L88gmA9AaZ5MoAZibTO64YTsmoQbsowBaBeqswcoyq/DAVLTMVFB8k4C8As2GQoSdtCov+2pUCtvzusIAM8zs9K2jBl7Ejwa3et7tNHfKEacJTmGOL8SbvRp7Fl8EcJrgTSaFn+TYEdw12VOyeeqy4nbn9fAPXh11prDbgji0JgUsDYLxHlsO9gz1svSnBbgvqBGmveNyqtNTdYu8kWf6gT7+5aqs9PmJ8cpyeqneP47o1/5X8groBRyodGCgf/LsvsyFdV14nyhTS7CBCZQNc5v0H8CZjyGw7MlCVpAEQv96/8wfepHlAnadKA/HBEwrUaQRL5OFST5t5+u1zFZuz8VnGnMeS/Qt8Fm0Xtto0P4iCOC8iWprimmjZSVDrbHe7xeABJu31j8B62hEwqtZLlH5upFviENqhwqtyW1O4EwCBXg4CT6vUVBgKdkvZ0h0EzBpEbOI0wor19tu7O7wRx/AbjbQ8AWqfdThZLMFgWN+2XPfl4aysvArvqrUmt5S0xHnYtQ+yJwg9x5nDxE/aBFR/wxawqLpcKFJVGx4s22vbH6mZZ9DadaIAa9ZThQIerPG6BzesutjBUi4I3uZsvSY9H6JqjYQsu1DLrTakncf09hFdclPoawsnvqtdeam1WZDL/qrGfxo0LutY3t4vFE98la5lx8YvhGfHjZ121Dd8eyp+TK1zGTVwtayK6lPFQy32OgHv0Cx1NesAv2pHtu7+QRkjgcA5dv654FSHKF/YWT3RQM0ZdIFXxpkDuHV8zSA==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:ErrorRetry;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36840700001)(46966006)(6916009)(316002)(2616005)(83380400001)(478600001)(5660300002)(41300700001)(36756003)(82310400005)(70206006)(8936002)(70586007)(2906002)(36860700001)(356005)(47076005)(107886003)(4326008)(26005)(6666004)(8676002)(426003)(16526019)(1076003)(86362001)(336012)(7696005)(186003)(82740400003)(81166007)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:27:07.0976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 582cdbf3-4ccd-43b1-c7cc-08da9d4e2a70
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT062.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8054
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The passed iterator can be NULL as in
gdbus/client.c::properties_changed():
...
   proxy->prop_func(..., ..., iter=NULL, ...)
   +--client/gatt.c::proxy_property_changed(..., ..., iter, ...);
      +--dbus_message_iter_get_arg_type(iter);
...
---
 client/gatt.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index efd736b2359a..c3bdd4710897 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -3003,17 +3003,20 @@ static void proxy_property_changed(GDBusProxy *proxy, const char *name,
 			chrc->path, bt_uuidstr_to_str(chrc->uuid), name);
 
 	if (!strcmp(name, "Value")) {
-		DBusMessageIter array;
-		uint8_t *value;
-		int len;
+		uint8_t *value = NULL;
+		int len = 0;
+
+		if (iter && dbus_message_iter_get_arg_type(iter) ==
+				DBUS_TYPE_ARRAY) {
+			DBusMessageIter array;
 
-		if (dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_ARRAY) {
 			dbus_message_iter_recurse(iter, &array);
 			dbus_message_iter_get_fixed_array(&array, &value, &len);
-			write_value(&chrc->value_len, &chrc->value, value, len,
-					0, chrc->max_val_len);
-			bt_shell_hexdump(value, len);
 		}
+
+		write_value(&chrc->value_len, &chrc->value, value, len,
+				0, chrc->max_val_len);
+		bt_shell_hexdump(value, len);
 	}
 
 	g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE, name);
-- 
2.35.3

