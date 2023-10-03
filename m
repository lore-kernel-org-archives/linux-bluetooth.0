Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E71E7542C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 17:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjJCRta (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 13:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbjJCRtZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 13:49:25 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE62D8E
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 10:49:21 -0700 (PDT)
Received: from monolith.lan (91-152-120-176.elisa-laajakaista.fi [91.152.120.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4S0QLQ0ksVzyRq;
        Tue,  3 Oct 2023 20:49:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1696355359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M5k91QPsDI3nSGiLWU40+DcpGwSOpNfwfI5MNpLeW7A=;
        b=drmerg0oS/31TKf/xJZSU9RnZfX/NDf442hFLMjmqAMEUuHjGJtLEmiPVa5qjoQM5V6ZKm
        5gkIToHlWkv3Dd+N+ZeMWF/qrZGy2MGo0buw+xUOfnRt26DAm1SdPalaynXCu5n7yi0BYb
        xKEJwdpkqUMQ5LOgEMoD2Xdz/2LHKbM=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1696355359; a=rsa-sha256; cv=none;
        b=I/cOEhyJ63XS0V2/PLTRwu8MEsQijSSDJLAge+Q5ef/NFtPzh6UFOxIvyx2Ur+35LLc16k
        qFuuDYCyQS5LxUVplUlVaF8JVfWCbBiUPqIszHptxFx69LGnqLHXu0rzOqoxy09waFKNvO
        LixZrpuGIWND0s/35V9e1shjSDSvJVk=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1696355359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M5k91QPsDI3nSGiLWU40+DcpGwSOpNfwfI5MNpLeW7A=;
        b=Yvnhk18g37+IpoIY5a/vc0McTldsmBm8RlwwM85ifCp+5dR6ddk+xB8nIHQiL9oHT18OL3
        /gv9udXS1C9wqHTiVEflgetIYUhDR+FdfEurMRyGq0eohJ4u22pMy6zAUer9aXt3CMrhOH
        Hl+1M/rVmSA2ielbHAoSWcxF7dtBpfU=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 1/2] bap: use MediaEndpoint related properties consistently
Date:   Tue,  3 Oct 2023 20:49:13 +0300
Message-ID: <112613bc64e4d17573b75a9d245b5fe5e51b5fa1.1696354690.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use the documented name "MaximumLatency" for the MediaEndpoint QoS
Max_Transport_Latency field, in SelectProperties input parameters and
expected client MediaEndpoint properties.

Put QoS fields to a "QoS" dict in SelectProperties input.

Use the name "Locations" for SelectProperties supported locations input
parameter, to match the MediaEndpoint property name which indicates the
same thing.
---

Notes:
    v2: put SelectProperties QoS things to "QoS" dict

 profiles/audio/media.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 8345487d7..4bffc9cde 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -965,7 +965,7 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 
 	loc = bt_bap_pac_get_locations(rpac);
 	if (loc)
-		g_dbus_dict_append_entry(&dict, "Location", DBUS_TYPE_UINT32,
+		g_dbus_dict_append_entry(&dict, "Locations", DBUS_TYPE_UINT32,
 									&loc);
 
 	if (metadata) {
@@ -977,26 +977,47 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	}
 
 	if (qos && qos->phy) {
-		g_dbus_dict_append_entry(&dict, "Framing", DBUS_TYPE_BYTE,
+		DBusMessageIter entry, variant, qos_dict;
+
+		key = "QoS";
+		dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY,
+								NULL, &entry);
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+		dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+							"a{sv}", &variant);
+		dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+							"{sv}", &qos_dict);
+
+		g_dbus_dict_append_entry(&qos_dict, "PreferredMaximumDelay",
+					DBUS_TYPE_UINT32, &qos->ppd_min);
+
+		g_dbus_dict_append_entry(&qos_dict, "PreferredMaximumDelay",
+					DBUS_TYPE_UINT32, &qos->ppd_min);
+
+		g_dbus_dict_append_entry(&qos_dict, "Framing", DBUS_TYPE_BYTE,
 							&qos->framing);
 
-		g_dbus_dict_append_entry(&dict, "PHY", DBUS_TYPE_BYTE,
+		g_dbus_dict_append_entry(&qos_dict, "PHY", DBUS_TYPE_BYTE,
 							&qos->phy);
 
-		g_dbus_dict_append_entry(&dict, "Latency", DBUS_TYPE_UINT16,
-							&qos->latency);
+		g_dbus_dict_append_entry(&qos_dict, "MaximumLatency",
+					DBUS_TYPE_UINT16, &qos->latency);
 
-		g_dbus_dict_append_entry(&dict, "MinimumDelay",
+		g_dbus_dict_append_entry(&qos_dict, "MinimumDelay",
 					DBUS_TYPE_UINT32, &qos->pd_min);
 
-		g_dbus_dict_append_entry(&dict, "MaximumDelay",
+		g_dbus_dict_append_entry(&qos_dict, "MaximumDelay",
 					DBUS_TYPE_UINT32, &qos->pd_max);
 
-		g_dbus_dict_append_entry(&dict, "PreferredMinimumDelay",
+		g_dbus_dict_append_entry(&qos_dict, "PreferredMinimumDelay",
 					DBUS_TYPE_UINT32, &qos->ppd_min);
 
-		g_dbus_dict_append_entry(&dict, "PreferredMaximumDelay",
+		g_dbus_dict_append_entry(&qos_dict, "PreferredMaximumDelay",
 					DBUS_TYPE_UINT32, &qos->ppd_min);
+
+		dbus_message_iter_close_container(&variant, &qos_dict);
+		dbus_message_iter_close_container(&entry, &variant);
+		dbus_message_iter_close_container(&dict, &entry);
 	}
 
 	dbus_message_iter_close_container(&iter, &dict);
@@ -2749,7 +2770,7 @@ static void app_register_endpoint(void *data, void *user_data)
 		dbus_message_iter_get_basic(&iter, &qos.phy);
 	}
 
-	if (g_dbus_proxy_get_property(proxy, "Latency", &iter)) {
+	if (g_dbus_proxy_get_property(proxy, "MaximumLatency", &iter)) {
 		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
 			goto fail;
 
-- 
2.41.0

