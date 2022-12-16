Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DEFC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Dec 2022 23:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiLPXpY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Dec 2022 18:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLPXpW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Dec 2022 18:45:22 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8084F641
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 15:45:21 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c13so2791499pfp.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 15:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=//D6eVyyNlgL1BudVAeRPTRIQYvUVCrzzG6FE7SSoxw=;
        b=E55yHcAF3d4SNYi/FdW0Yz/GyrcC7wpTOS6dOJQTmfaOFhf8/6KasXa9d0t7qvPsza
         y4VAk27Sk1qO2MwyOZQqXgVqeh6RaYUR8k3rESXMgUsGck9iOvIpABCXLBHZOKSO3OSZ
         8YAigPrlvr3l0KHMYPq26lCBdyQrfRaqEBVCHzGrbLRt7pkdhYrvahaSEjAOdqKPQWNS
         trQjegCYt/l0+INjfRAZC75Jg6AL5aS8lxdAnjl39TkswkO2Al7c96CV6LrN6qiqe15C
         dbuJDWZuVPIvV3j80g9Il50R62Zp/gFcTQXbARmyYvhXX16cHWtkS8PboMDZStnoKlSI
         Z8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//D6eVyyNlgL1BudVAeRPTRIQYvUVCrzzG6FE7SSoxw=;
        b=E3VuCjllx7vcGPzOZnVYRd97atZa64da6cDeoNK/3nyIEXjfmQundfd+H1NGfi3f4X
         LY8y/2/15w8hjmBdbkAR/Tu5tXYFuNj9C3N/k67zmfCiN69FkVHaZX10ltWkT3k83KyE
         LIw1t0VPX6YMxoLfxBNHz3WseHpQQHs6GbVAZIjoKCyjQjys7Jl5eDsOtz6NjKi2iZv7
         HuR9rKMGaksaqmn456Lca3r2iFAA+0gx+Oz522SKcFWEWMpUfxvUtE1JUxIZ1MN1NDdv
         J5mFlhWGMrvxmhP5V96NvbPNonZ4kDxpe/waDbFBNUsZwAT2G6LvgsGx0xN5ynbjaY0t
         7CaA==
X-Gm-Message-State: ANoB5pnP1aei9avKgj/QWGYsz27LsaRoV+V2m01CxlPvyOLulaWcAphH
        1XJSyXeAiiimzwVAf1C5IXIy4T4IIi6GBA==
X-Google-Smtp-Source: AA0mqf4g9QddjRf7Afd8u55QbZJe0+m9x6+YPeMdWz4w+tp1kPyI6rt2ILdDMjtl6k2KgS5kouZeVA==
X-Received: by 2002:a62:7983:0:b0:577:8d87:d8f4 with SMTP id u125-20020a627983000000b005778d87d8f4mr35028865pfc.34.1671234320325;
        Fri, 16 Dec 2022 15:45:20 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f196-20020a6238cd000000b0056d2317455bsm2020332pfa.7.2022.12.16.15.45.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:45:19 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3] shared/gatt-client: Fix not marking service as active
Date:   Fri, 16 Dec 2022 15:45:17 -0800
Message-Id: <20221216234517.3026289-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there are no characteristics to discover, or for some reason
bt_gatt_discover_descriptors is skiped, or the last attribute is
actually a included service the service should be marked as
active as there will be no more attributes to be discovered.

Fixes: https://github.com/bluez/bluez/issues/438
---
 src/shared/gatt-client.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index cf0d2e2b749d..8eb5e0fea621 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -576,12 +576,26 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 				gatt_db_attribute_get_handle(attr), handle);
 			goto failed;
 		}
+
+		if (!gatt_db_attribute_get_service_data(attr, NULL, &end,
+							NULL, NULL)) {
+			DBG(client, "Unable to get service data at 0x%04x",
+								handle);
+			goto failed;
+		}
+
+		/* Skip if there are no attributes */
+		if (handle == end)
+			gatt_db_service_set_active(attr, true);
 	}
 
 next:
 	range = queue_pop_head(op->discov_ranges);
-	if (!range)
+	if (!range) {
+		/* Skip if there are no attributes */
+		gatt_db_service_set_active(op->cur_svc, true);
 		goto failed;
+	}
 
 	client->discovery_req = bt_gatt_discover_characteristics(client->att,
 							range->start,
@@ -696,6 +710,9 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 							&ccc_uuid, 0, NULL,
 							NULL, NULL);
 			if (attr) {
+				if (dest_start == end)
+					/* Done with the current service */
+					gatt_db_service_set_active(attr, true);
 				free(chrc_data);
 				continue;
 			}
-- 
2.37.3

