Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB960ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 14:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiIWO6h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiIWO6c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 10:58:32 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2107.outbound.protection.outlook.com [40.107.22.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D227126B62
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 07:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsOgfvDTV9+INle6fEOyBV/jGJ298dxAVVSmdFUbUCabh4uteSrBw5wz72MziXNEea0FeeYr+Lq4YzN05pmoe7bpZuHP9J9M6DkuRTOZL2AQymmpy9bi5s9CY1olJ3vOoHYGBuxjpuexIPtghFy7H4Uj3tq+S3bpi2dcMXGeNEaCrGriYFFdyvyAl0nO1fIqHZGMtd6BUA06pDhYQzL/0fuKo1PO7VLjasxDmr+HkBAWrEQEEKDDKSri0p3bNRWTVSHP9QjAPmhYvsd0pXTXXcdOIo4UkMWlpM9aeLMXRfH0SEtnAqo2RkV6BIINsxc176s05hxiyRscXeNbUFLd+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2Ar3/IHr7PCHuTCmT+0HHaWWtL1ue4SMFifUCj3vuU=;
 b=d4CHxgVye7IuWQJKbIf0vuAH9k09KEMHsKfaxa1rOzadNjLBnjEez+b5DpAvuwnU5vIKzh7u3SNImOhUuDGeRgGtiogY+DNddhS5lB3CaoRAxa1rOqXRbyOM/uwLfbHoENtWIpkVykaPL3uJ0/JMqnfk5dOQ3QmEH2sDA5rIlk3DkBLrzwUDTyJhh04D2wbOfcy3tOpX8qiHT5AcmKpVm3W1FSJAVdDTMlIORkw6WoYjc2L6+FutbWgm7jBoVUHopul3ZMoJ+F2ydYmWrYrKKXk/DvpzfznT1ao4Qi5qDlQwzeRSNODfxq0j8whz/H0zprdVwjpxOgNSdDis1VDp8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2Ar3/IHr7PCHuTCmT+0HHaWWtL1ue4SMFifUCj3vuU=;
 b=KRaZ2UrYxLPSa+nJKh0kE8JmbtdMxvlzm0QROtfsIkuD+89kX3rvBFc3WBMm663N0QztN+UavcW7K6JnFThqNXv4DDRP6tzTJ6ZoMoSFxll5LlPNtjYwOOS7ONWPSIvChaTRavIerXT3xZdYDvWA61HpIqr17pc7qq7+a3oHlI0=
Received: from AS9PR0301CA0037.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::22) by PA4PR07MB8840.eurprd07.prod.outlook.com
 (2603:10a6:102:269::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Fri, 23 Sep
 2022 14:58:28 +0000
Received: from VE1EUR02FT107.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:469:cafe::d7) by AS9PR0301CA0037.outlook.office365.com
 (2603:10a6:20b:469::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20 via Frontend
 Transport; Fri, 23 Sep 2022 14:58:28 +0000
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
Subject: [PATCH BlueZ v2 7/9] client/gatt: proxy_property_changed: check for NULL iterator
Date:   Fri, 23 Sep 2022 16:58:12 +0200
Message-ID: <20220923145814.26077-2-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: VE1EUR02FT107:EE_|PA4PR07MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e356fa-b7d4-43da-cc56-08da9d7412eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5eeruld3RnHHYThsOcClUAvTH59rfrLFXfwMVdW4kO8oMuXBQuoZS9Rk/AxRuxzARBtnfphA2fBGOIc06KVGXKZfZO23nQNxG2x/uKstRF6T6/8Ko8V6CKCFyPWaa/Edni00FN4MhLNzWoCeTGqG/3NnIu/ncGIfaPqr6KBtLB8Y9GooOlX4L1rLroO0tFGS2nSr13KqcXGt3L1+9+jQVVLFfI6MEkb5F6CzD+6aP2GrpHVnpUd0h2GPXYD/AdmgdtWekpbNwRTgcgIQNMTgCJ8Wbv2G9AMkdd4+dXGyR7i46oqL9z16QeQT9o0/rZLID3638d/N9Oc1K5vCUn1cGs0ZVBY6VUDZwk9FZDSmED/LdVFIj0sEDIJR5IBCiiVRsXMxEWx+p4V+g17cwnm1WMlXhAX1R4Sd8RG4ygu2SjeKc9tUc7NeXPA6FgJsOfcNvZBGfGwq2Z0jEwSByNhP7BIPOV5i3bCkOOfEQbnOo1W2MumEkgNAburBV84ker3+jOwHQFmBN5KyZ2vqbNWKLSo2E5iOrIYVnKIhIUY5jmzNNp0MvtcNUXoIn352bsj0XWL99QYKPlOZaBoKUJ+c0ItJi1nd5HpF1JklsMOa3ou/aanK1PApZ/cpLzCKTNn9fHn/nrf341pzWq/tZMThFqYcltd7DLXFv0nW1I/lS+w0gDac5XhptXT7/5jZmeEGadeou6Meh9YD/XnDrtXXEgXFIo+AoG+0SLK/PuojsKZUieM4WyUF44bh7PXJpgz3ai1PoqXKuhlISKsT4onnw==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(46966006)(36840700001)(82740400003)(86362001)(36860700001)(70586007)(426003)(81166007)(356005)(70206006)(8676002)(4326008)(6916009)(316002)(8936002)(336012)(40480700001)(82310400005)(16526019)(5660300002)(2906002)(1076003)(186003)(2616005)(47076005)(83380400001)(478600001)(7696005)(36756003)(26005)(41300700001)(107886003)(6666004)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:58:28.4931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e356fa-b7d4-43da-cc56-08da9d7412eb
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT107.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8840
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
index efd736b2359a..e945b524b071 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -3003,17 +3003,20 @@ static void proxy_property_changed(GDBusProxy *proxy, const char *name,
 			chrc->path, bt_uuidstr_to_str(chrc->uuid), name);
 
 	if (!strcmp(name, "Value")) {
-		DBusMessageIter array;
-		uint8_t *value;
-		int len;
+		uint8_t *value = "";  /*don't pass NULL to write_value() */
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

