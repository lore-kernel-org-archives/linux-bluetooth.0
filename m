Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9175AC6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 14:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiIWO7J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiIWO7A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 10:59:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2123.outbound.protection.outlook.com [40.107.21.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3EE131F43
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 07:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAeAipDR7vRzfb2qA3TQz+JbwUKyByTbmCrWnmee02DaVI+xkwwaR++TaA3WyWPkkyMznF2qQfk/zH8NDrKx6Xcsi2wU+mdr8WUemUDcd4HdRWNgu0mZpVd2JtBfb3C5WylW4b2enzBVO0xRKQM9SNVFjMSwB6MoRrmKnZC7lr9gpHGB8O3XdEVU0OXOHJ1lHwSQyH6t4DuGDo2auQDUagFycI4CPxjVldgcybe5X+aNLj/9M+w8N7AV/IS4JoJMkp6dF03eu/KG2hWhFgqW48zZ05uIdBVANThDMJdiw+qrhkX3uyxmNHBB4+dq1/72ZVffmFNzCrSBCvZMID87VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSbi6+k37guWem+w6BlluuZ8MMzpI8/vEN1ugopTTr4=;
 b=GO4Skc/CnImLarPz4UgbENg6b+RS+6D1quyCptNUxcqYoxb63htJIbz6yInABb68lj58IdCpswMGkykCAG7VOce5hRPWVcQIyHtPmam60lscDKotpyMgu0WgWjDsGTyRK9F0Tw1uNRdSxb/pLjtLA8Gr1PUxREusQGDMEEobxP5jJOjHKGDPVp0adIawdSPA3Mbnu6iH13Y+/i2PFeGLfRVjwCDlqjjASNen8wAz3KZD6WAprgN8hecpR9tCTanr3W5dI2WVXUyrGjtX3T0R6QFYomzhonDLryma3ggWjPICWNzPhVAAaPh00AUiUwAv0qvS2v3bv71j0q6h+uoXng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSbi6+k37guWem+w6BlluuZ8MMzpI8/vEN1ugopTTr4=;
 b=f8HeioLZ4kW9Vd79DlL+qTTvslCV+dKcS667/+uAu4Z3Z/FugteL7I01L/5omHeZvfaYuPKIdZYPn47jaCijO5qOtGDbW5mN/MZlPfzAE2AlhP6H6jLRkiZvLzTvrYWZNSvKoQEfomUBxumuIo6gBS61jYK6G6bRGz6ldTQcif4=
Received: from AS8PR04CA0124.eurprd04.prod.outlook.com (2603:10a6:20b:127::9)
 by AM8PR07MB7586.eurprd07.prod.outlook.com (2603:10a6:20b:24f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7; Fri, 23 Sep
 2022 14:58:54 +0000
Received: from VE1EUR02FT077.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:127:cafe::cd) by AS8PR04CA0124.outlook.office365.com
 (2603:10a6:20b:127::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 14:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 VE1EUR02FT077.mail.protection.outlook.com (10.152.13.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 14:58:54 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 16:58:53 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ v2 9/9] battery: provided_battery_property_changed_cb: check iterator
Date:   Fri, 23 Sep 2022 16:58:14 +0200
Message-ID: <20220923145814.26077-4-ceggers@arri.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220923145814.26077-1-ceggers@arri.de>
References: <20220923145602.25872-1-ceggers@arri.de>
 <20220923145814.26077-1-ceggers@arri.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.71]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR02FT077:EE_|AM8PR07MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: f44ca46f-1409-41eb-5569-08da9d742234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WuBI2wv/bTxCXThkwB0rYPVL6XyBB7z5HTnnEFWHvwvEsLZiOtjhF/LD/9twD0iD5mbDuROOflcLGAqvhMaQjWdplkVwQnO3uhitsOOxy+CnWTL0gxQIQE/c3sMhVdRQ/ExSCodj1utca8b46OmwZorO6kMFstbikkfcRRKOxRquE2ScNBbK00o7vw/zpyjkrKnNCRZRevOhmPWuETACrytZFZNqh520kDlrifI1GFExPpNVJ+QhZxbAKzPHauYcSTgZ5tucp7pFC+GvQaW/OC+IuTGkhrP1IelHw1u+GvXvl+Szoxo+3QG26J82OWjCTk/wusYRRm3cxDvFEGX02QaftTyPo+1Ib3WjdO4PfoWRZR4YGbNv/MG4YeuRYzBA7tqZ5GMy/hoGBkCEtx2FqRxc/91YYxUcn88LjcFvMP1XGBXEyQ/cAvDr56FZfKAKLzhjr2WZLmFG2Fja23CbeWAgk+jdMgqPwisyENLqSkfvsasAlTCrcPv2Om2F0jO+uesqX9C5N2AlfswdXLVYTRTZnyGQKquFL2+bXNas3mRYEpsfXBpk/Q4rkw6A/nFyoz+vQ/VdlIalrZxFRbpXdAA3LmLaHuAcvXaMD5szQUNWWWedCyxrURM/XbmTxIyhsTqebVeI9Jn2vfemdTcXXiDhJhYUMYv5lyzR4tR+GoKdsp6q3dvG/N2vNWiaB65zPa5JDhTv2/ntZfpJhYcul7SZRGmHIM3HiZbPythGaMaJrl79URzCnT4T3B/qpHnM1htgtHsW19CUCjid2KbaVA==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(46966006)(36840700001)(36860700001)(26005)(6916009)(107886003)(36756003)(2906002)(7696005)(6666004)(2616005)(1076003)(16526019)(86362001)(186003)(4326008)(70586007)(70206006)(83380400001)(336012)(426003)(8676002)(316002)(41300700001)(40480700001)(47076005)(8936002)(5660300002)(81166007)(478600001)(82740400003)(82310400005)(356005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:58:54.1459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f44ca46f-1409-41eb-5569-08da9d742234
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT077.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7586
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

