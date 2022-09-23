Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E15C6FA8B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 14:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiIWO6u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiIWO6e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 10:58:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2108.outbound.protection.outlook.com [40.107.22.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95B8118B20
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 07:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exHm5JALNMAIkOQSzr3BpwUE0qtmzNznBzqtC0Y3f83wAK3LeDqh7aMgp0bzhCzRZ3jXNviTn2/DZhwmeA9W+EmbdKxs53UAm88Mlr2cY5TkY6COf2j20klPSf4BMCcTktwfAgBA/I5Xht3PvVIaWjz6fgm9SDJshnUjYlNXGIJuCwNZ4qEd47NyG750MsXArcFHVr+EuFe+Cy+Q7DtX/2ksSiRuC6N54kUiqEjrEf79JLT176wc2YfS5Gfm1mx2CcKikpyzOmsbyHKo2UwJ03VNOOCJciQQMe+QyIm6hG95so+MH+zn6U8SYpBT70xbGDJThZMuTCtlqbnWEyvGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmE3MKKIlxMOZt+/ILTc5UuPKfu/KwXQxlum2V0NXJk=;
 b=cj1ES65opK7CZgiBDS0J0PXUXMHjBVrarFBMhj6izv5bULrzarPBlqtCwQIGzSNI7vQSuFh86w6bYvol2F3a1vL2fqO0hEf6wNmF3cigCULA7E8e9AYD5Pf1ofL6AEu/B5H5zJNNMnTBZqOXQUgneWOsEfDDxQE526Zf2/e/d3tS5xJHep88UwLgK7JkmqS4rLoMOpr2uzs9Y8RZleZ4eEBYQcw5dT8yvVtuk9HsMhK1IvXmTCrlMACVcC+F4OEGrEuG7/4q5hUr6jpywEFXSgF4QkVfyokzbI1SnJXhEZhNH6XbEZJo0zEtViKRllUCh4NpvWHJ/ZiE8khDRDDgyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmE3MKKIlxMOZt+/ILTc5UuPKfu/KwXQxlum2V0NXJk=;
 b=cOX6cl4s3jNjj52w4HhJ+Vue7S6T8MP9ysJLRvBKcuDufOymEQLjOiJH8pthoKjLtLJvakH4j0nbzdWQOrrXlVt369CUNicNKYipUaYUJ39WmVQ7CkRamrr1Sx51ns6/wC1mj8cZNQ4JBWGQ9zGMj2Zk6PJoTchB5tQKHFjiFTQ=
Received: from AS9PR0301CA0051.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::28) by PAXPR07MB8721.eurprd07.prod.outlook.com
 (2603:10a6:102:243::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Fri, 23 Sep
 2022 14:58:29 +0000
Received: from VE1EUR02FT107.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:469:cafe::af) by AS9PR0301CA0051.outlook.office365.com
 (2603:10a6:20b:469::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 14:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 VE1EUR02FT107.mail.protection.outlook.com (10.152.13.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 14:58:28 +0000
Received: from N95HX1G2.arri.de (192.168.54.71) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 23 Sep
 2022 16:58:27 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ v2 8/9] gatt: proxy_property_changed: check for NULL iterator
Date:   Fri, 23 Sep 2022 16:58:13 +0200
Message-ID: <20220923145814.26077-3-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: VE1EUR02FT107:EE_|PAXPR07MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: aefe4258-4b8e-43c8-1656-08da9d741338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ggz/9qAS7485X6wYXwvo7fBQCUoFXDOqdcDvIvJQQQAyyxoZOKEJvDsv1R05XvZPMosHcFXnpIZ0Lv0Ed1Vl7xKvCuINEyLk2Y9mJmGkE/8jLOAwr0Gv4XJ0mAMLcw1968s+YZDjxLrMlreUubFDJHwWyqmBNp36lOMaafaCsv3zPPtfnNTv4YqnTJDjTcHwnOLwnQn0RRGyaRJu29QujFs7FCJKd7lXM4msa/iS9dc8tlKxIS8pBOeRRR8laicaRk/K4XGGdTFTJeDe+LR9bKVB/i4pIe965PhRS+sG6/ZD/Eg5Py9gq3M3HE6d+r/vG8aJMqxUMHwjyl/sdSOAaSO9TfyUwWxDLpStgrDX5F9GPKT6tPU00cqdpf6e6JGI+36/WKKxF3NPhmSGlDcPXTKmzMaJizTwsDv/qPNMh8+uutZg54Aijf29QWqi/eYVDMgwM0cEYmC2C2gKBrguMPeIn7OXlrgovJ1CszwfL4qlk3Vmk5pQn/XBHLTCAgwuTSBgnkyfTORADGpoAad4SfmfmqQvbtG0X+/RPCoJzkXnywBo2QuD2VE7MnrIfRw4uF1sOxAuUmKx9nEVQBt9CrXM3s/SgoMkGqYeBPoDkvgSSbGFIQ6XqrdNCjmRCUHZ6J6yEeU27CwqNkK8rY/5ch2CKtaFmclnWFmYuURfsHpo1CfbI58F/7Qc7UGaLCOkTwcKBGS3xYXvwY3JV5v8gfRPC6D6p26c8GpWOBmW2Vd6wGTZyABwWRWKMAVs9SEFZh7aa987rj4vUSAfiCXkAQ==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(36840700001)(46966006)(40480700001)(26005)(8676002)(4326008)(6666004)(70206006)(70586007)(16526019)(186003)(316002)(336012)(426003)(47076005)(1076003)(36756003)(36860700001)(2616005)(6916009)(478600001)(82310400005)(5660300002)(356005)(86362001)(8936002)(82740400003)(41300700001)(2906002)(107886003)(81166007)(7696005)(83380400001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:58:28.9931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aefe4258-4b8e-43c8-1656-08da9d741338
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT107.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8721
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The passed iterator can be NULL as in
src/gatt-database.c::properties_changed():
...
   proxy->prop_func(..., ..., iter=NULL, ...)
   +--client/gatt.c::property_changed_cb(..., ..., iter, ...);
      +--dbus_message_iter_get_arg_type(iter);
...
---
 src/gatt-database.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index c72f4a4d5c54..ea282d4bc193 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2867,17 +2867,19 @@ static void property_changed_cb(GDBusProxy *proxy, const char *name,
 	if (strcmp(name, "Value"))
 		return;
 
-	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY) {
-		DBG("Malformed \"Value\" property received");
-		return;
-	}
+	if (iter) {
+		if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY) {
+			DBG("Malformed \"Value\" property received");
+			return;
+		}
 
-	dbus_message_iter_recurse(iter, &array);
-	dbus_message_iter_get_fixed_array(&array, &value, &len);
+		dbus_message_iter_recurse(iter, &array);
+		dbus_message_iter_get_fixed_array(&array, &value, &len);
 
-	if (len < 0) {
-		DBG("Malformed \"Value\" property received");
-		return;
+		if (len < 0) {
+			DBG("Malformed \"Value\" property received");
+			return;
+		}
 	}
 
 	/* Truncate the value if it's too large */
-- 
2.35.3

