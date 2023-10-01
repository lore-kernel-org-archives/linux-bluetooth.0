Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEE4E748ED
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Oct 2023 10:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjJAK53 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Oct 2023 06:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbjJAK52 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Oct 2023 06:57:28 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D18AC
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Oct 2023 03:57:23 -0700 (PDT)
Received: from monolith.lan (91-152-120-176.elisa-laajakaista.fi [91.152.120.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4Rz1Hx7293zybZ;
        Sun,  1 Oct 2023 13:57:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1696157838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9BlBv/2Xp8qYvgYxs+dlophEqLLDcw2DVFjV3yp2+Vc=;
        b=q4EPvWZSMfH0+ieeUXODq93UTDe99vH5xFPvdk6twFoHy2S/cX4H6awCuOIYmUTw6x/ct9
        yZqGAOeZQftaTtif20iqPHxWbLVtbIirkeGi5CAB0phLzYnLlDqCzBU5SVjevII8uS7wLO
        LT48VDVRKIKdvLAA2z0Oet6amD5PBDM=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1696157838; a=rsa-sha256; cv=none;
        b=vjLyrtLPVIHt/DmKtoBt4ClQA2KhgrqwOHhGFPxQEM/qg8/Krv6R46fns3ZMoAS2gLURs1
        hh8qCAdJkZKWrfRvY1mMCHkyXdepGMaqGjj68dgQ9BWjWEXjq6Uiq4uz7AqwoFqtaVxH1O
        i65WgIF/pfI5agSaOEN+2iAGOvrH1m0=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1696157838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9BlBv/2Xp8qYvgYxs+dlophEqLLDcw2DVFjV3yp2+Vc=;
        b=mv6ccJZ4e7UVqqxpT4jAKbV8nAUgoxmO7vHlByjYYyyIFQnLktQDZqaqxqyDO6HnaCBjsA
        6rpNU+EtAIx0+whHoiF574Hdyt3FmqMW/seqBKxBPr0bHKdtTcuFxOMrXPHYOMx0P1NyTs
        GD4lfdFY8XY+jszj7uaUjFAWHNdwFkI=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] bap: use documented MediaEndpoint property names consistently
Date:   Sun,  1 Oct 2023 13:57:14 +0300
Message-ID: <3358dfd1591df242507755cea63d00db3d2c959e.1696157794.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use the documented name "MaximumLatency" for the MediaEndpoint QoS
Max_Transport_Latency field, in SelectProperties input parameters and
expected client MediaEndpoint properties.

Use the name "Locations" for SelectProperties supported locations input
parameter, to match the MediaEndpoint property name which indicates the
same thing.
---
 profiles/audio/media.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 8345487d7..85ece47c4 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -965,7 +965,7 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 
 	loc = bt_bap_pac_get_locations(rpac);
 	if (loc)
-		g_dbus_dict_append_entry(&dict, "Location", DBUS_TYPE_UINT32,
+		g_dbus_dict_append_entry(&dict, "Locations", DBUS_TYPE_UINT32,
 									&loc);
 
 	if (metadata) {
@@ -983,8 +983,8 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 		g_dbus_dict_append_entry(&dict, "PHY", DBUS_TYPE_BYTE,
 							&qos->phy);
 
-		g_dbus_dict_append_entry(&dict, "Latency", DBUS_TYPE_UINT16,
-							&qos->latency);
+		g_dbus_dict_append_entry(&dict, "MaximumLatency",
+					DBUS_TYPE_UINT16, &qos->latency);
 
 		g_dbus_dict_append_entry(&dict, "MinimumDelay",
 					DBUS_TYPE_UINT32, &qos->pd_min);
@@ -2749,7 +2749,7 @@ static void app_register_endpoint(void *data, void *user_data)
 		dbus_message_iter_get_basic(&iter, &qos.phy);
 	}
 
-	if (g_dbus_proxy_get_property(proxy, "Latency", &iter)) {
+	if (g_dbus_proxy_get_property(proxy, "MaximumLatency", &iter)) {
 		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
 			goto fail;
 
-- 
2.41.0

