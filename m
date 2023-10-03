Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CB4E82CAD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 19:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbjJCTTM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 15:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240870AbjJCTTL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 15:19:11 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBD2AB
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 12:19:08 -0700 (PDT)
Received: from monolith.lan (91-152-120-176.elisa-laajakaista.fi [91.152.120.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4S0SL12WcSz49Q1K;
        Tue,  3 Oct 2023 22:19:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1696360745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1MEhbW0nWTmSakaI2804F0vVc0JXe0co/LMBZhrcWAY=;
        b=YToLu/nEWqY3uSN7g0NFzMuenyQ3fAwKzx/Ru14jrV8EyqGY/6EHPsTj7PsGAG4Zmxnq38
        mm4hJdomDohrSmRITXGbakNpZ/ntu4yDxdkJgoBNiwKdjTKiRS0skBQxgU7qn0rDrzDzA5
        7xPbkjCacI1OufhKlmtUjrPMiG3ZDqRPd7LFbIJpp5Xk7FRygAFkkpSCSheNVd6xVZefdv
        vJKGUrx0KcSE6sCF9lzdtIjjTDFfNWfnm4Ua3795PXzSSfSlr60kL4n7TLGNwfOKY2tCCU
        UxURwEhHK5hhU5uITMHjrXn+oQLJUYke1DFHn3hXWfoSosc+SEKChXLCXIycYw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1696360745; a=rsa-sha256;
        cv=none;
        b=pYJKgZW4uOOVmJa09mf8/7ZTn2U1CgESZrfVz83N/w9FdnUYMCVCl911rFfEJ6+PMeoI8X
        gr7Cba6kQCBwhtf6pqvYXzD2qNJWIkXEoi3OWgXB/cRZGbNiLI+Wc2+9fjIhAuV8MKH2nz
        VT3IABOFdlg5FzTUSmqZB26gQIh7YD8pAjDxGESa80IMNw78DrOdR/a43mTrfMFoG6mq6e
        /EoASeHitJXIkNqxlamQH2PWvrxtbOfpkFoQZif95pFru9OJ9AxM9oyKK0vAaf6rdajKmg
        5EwOPDZ/ffxY/yEqZitNxPrTQkfsp2El7xlI5vFy1kzkBDppmDe36bVWDObvhQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1696360745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1MEhbW0nWTmSakaI2804F0vVc0JXe0co/LMBZhrcWAY=;
        b=JpgGVFf0rF6beEFTEeIcuwr7s+5kePhn7Rxbf/luzaEhCwW9Rrjh+dDWaMr2AxPEXt7cFZ
        HUFzAgd0BU1J8Wdqywk5fyuG4snoLiGGoiLdSVME29fH470toqeRh/YqxMwUHDyelsC080
        ZRGAnHdtEVVvfwBIzVoffLsgrE0qAMrR+yNsZU7Ns1d/oEa88qlElJqIdaFwWcJBDlSZTe
        zmBnl5DSKTcoZ+tzZNcJL5+JbPWmyB1DPjba7C/9lBpVQCm7Wyhy9Mrg0ZKe5eAO3RNym4
        5nGz3ZFBsy622ZjcZ+tyaB2018JYppN67K1CTBT2s/cWvWwuJICvMSx/DuL1Kg==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 1/2] bap: use MediaEndpoint related properties consistently
Date:   Tue,  3 Oct 2023 22:19:03 +0300
Message-ID: <530fedd2233740d401c67bc1470756c86cb578a2.1696360700.git.pav@iki.fi>
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

Fix typoed ppd_min -> ppd_max in SelectProperties input.

Use the name "Locations" for SelectProperties supported locations input
parameter, to match the MediaEndpoint property name which indicates the
same thing.
---

Notes:
    v3: remove spurious duplicated properties, fix duplicated ppd_min
    v2: put SelectProperties QoS things to "QoS" dict

 profiles/audio/media.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 8345487d7..1d98ac5a1 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -965,7 +965,7 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 
 	loc = bt_bap_pac_get_locations(rpac);
 	if (loc)
-		g_dbus_dict_append_entry(&dict, "Location", DBUS_TYPE_UINT32,
+		g_dbus_dict_append_entry(&dict, "Locations", DBUS_TYPE_UINT32,
 									&loc);
 
 	if (metadata) {
@@ -977,26 +977,41 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
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
-					DBUS_TYPE_UINT32, &qos->ppd_min);
+		g_dbus_dict_append_entry(&qos_dict, "PreferredMaximumDelay",
+					DBUS_TYPE_UINT32, &qos->ppd_max);
+
+		dbus_message_iter_close_container(&variant, &qos_dict);
+		dbus_message_iter_close_container(&entry, &variant);
+		dbus_message_iter_close_container(&dict, &entry);
 	}
 
 	dbus_message_iter_close_container(&iter, &dict);
@@ -2749,7 +2764,7 @@ static void app_register_endpoint(void *data, void *user_data)
 		dbus_message_iter_get_basic(&iter, &qos.phy);
 	}
 
-	if (g_dbus_proxy_get_property(proxy, "Latency", &iter)) {
+	if (g_dbus_proxy_get_property(proxy, "MaximumLatency", &iter)) {
 		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
 			goto fail;
 
-- 
2.41.0

