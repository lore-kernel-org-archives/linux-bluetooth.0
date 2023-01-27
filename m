Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B28C54EAA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Jan 2023 20:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjA0Uya (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Jan 2023 15:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjA0Uy2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Jan 2023 15:54:28 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4B81E9F3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 12:54:26 -0800 (PST)
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id 43A311B002E4
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 22:54:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1674852864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+P0XmOEW5tJWbNu57VaFhxJHSLWAdSJrB0ZXEAplCYU=;
        b=HbyZ/b1S6i4qe4sERRZXpVCx8gsgoUCT+dcsod6KofzFFgEI1AKEBwzlQLXTJhKeq/lAGY
        +9FjGkCug/CkDQ3DsiBjIcG92/GpMtA4fjKyc/IKPFG/M3YeNIt7arD4j69goHnUx0PbuT
        8PuJohZQU24SC/hrH38LbSpTHCkC9WBaRTqANxDAS14gOCL1LFUcstBSuwfWo1JW0rv5pg
        zGbg2Owo9xRYvsTfXNV5Lv1qFwQfBTqAUe4ceZcHDEsyCsoXrxeHRvTz5V5+oYeu8lOiJj
        thNBnmL+KevXXJ4DyZ3nVtV1IbUzb1owP8oLnvjXF/qw0LMEvllzcLSdzyjxSQ==
Received: from monolith.lan (91-152-121-187.elisa-laajakaista.fi [91.152.121.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 0F1A0200C9;
        Fri, 27 Jan 2023 22:54:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1674852858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+P0XmOEW5tJWbNu57VaFhxJHSLWAdSJrB0ZXEAplCYU=;
        b=UDd3nqwml7xc5RHle6UBls0HnFglpYgL0BFw997q+ZS4GG1CbrfFADxp2ucSN7B1t32VGG
        28jHXBT3g1xxgX1cB/QjPzeqiZfRTyb85DGMZyGH6QszQRaduaE9Q/uVzOm33Gu6FO4AYd
        IZEdVlICUwuS6z8A/8jThSdm81lmYVo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1674852858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+P0XmOEW5tJWbNu57VaFhxJHSLWAdSJrB0ZXEAplCYU=;
        b=eYPczQT4hQq1/mwOHm9UY31ZvuC9zEwabw5cx4Im/NgBReK+ZDrzhp4tVzaymUqG7Q9klE
        Cy763G43izR1TkMRjZXyS2JM/KHLo3nyt0+HpxfXKv/xT8aACB1a9Q+/6zSQA+uOoI/5XY
        nHrY9bB8mqIMZcFgN8MrVa7vB2FxlhY=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1674852858; a=rsa-sha256; cv=none;
        b=NB5R4Ml3Evln1GZosSl23pXgyCkvky9MNdnx9OWD0aUQpycIXCrZuNKW63IS1vdwnXXUlC
        z8Ggqnq56HUZp7e6mu2BOF6VTk/CKSVk00dZa0OgM7nddTNvoZNLw/3RWREHYJ+ME6i3Zi
        TgdJFOlmnrljJKpJBuMzrHhKTtI43t4=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [RFC, BlueZ] bap: check adapter support before enabling BAP
Date:   Fri, 27 Jan 2023 22:52:06 +0200
Message-Id: <20230127205205.20235-1-pav@iki.fi>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

When the BT adapter does not have the "Connected Isochronous Stream - Central"
feature, establishing ISO connections fails at a late stage.  Namely, we get
EOPNOTSUPP in connect() due to cis_central_capable(hdev) being false.  However,
at that point BlueZ and the rest of the userspace like sound servers have
already set up the BAP stuff, and think they are trying to do something that
should succeed under normal conditions.

It appears the information about what features the adapter actually has should
be available to BlueZ earlier, and BlueZ should provide accurate information
about the adapter capabilities to the rest of the userspace.

For LE Audio in particular this is sort of important, because the adapter
support is not currently there, and only fairly new adapter models have these
features. There's also a few other bits (Core Sec 4.6, table 4.6) that BlueZ
might need to know later on, once support for more LE Audio parts is added.

At the moment the ISO sockets are under the experimental feature flag, so I'm
not sure if this is something that is to be added right now.

Below is a quick hack, which just exposes these bits to the mgmt settings a la
WBS and handles them in BlueZ.  But would this be the right place to put them
in the first place? Other ideas?  Trying to connect() to some random addresses
from userspace just to probe the feature capability probably is not the right
thing.


---
 doc/mgmt-api.txt       |  2 ++
 lib/mgmt.h             |  1 +
 profiles/audio/bap.c   |  5 +++++
 profiles/audio/media.c |  3 +++
 src/adapter.c          | 11 +++++++++++
 src/adapter.h          |  6 ++++++
 tools/btmgmt.c         |  1 +
 7 files changed, 29 insertions(+)

 include/net/bluetooth/mgmt.h | 1 +
 net/bluetooth/mgmt.c         | 6 ++++++
 2 files changed, 7 insertions(+)


diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 90d612ed8..11798629a 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -333,6 +333,7 @@ Read Controller Information Command
 		16	PHY Configuration
 		17	Wideband Speech
 		18	Quality Report
+		19	Connected Isochronous Stream Central
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
@@ -2926,6 +2927,7 @@ Read Extended Controller Information Command
 		16	PHY Configuration
 		17	Wideband Speech
 		18	Quality Report
+		19	Connected Isochronous Stream Central
 
 	The EIR_Data field contains information about class of device,
 	local name and other values. Not all of them might be present. For
diff --git a/lib/mgmt.h b/lib/mgmt.h
index 796190cd9..610770491 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -96,6 +96,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_STATIC_ADDRESS	0x00008000
 #define MGMT_SETTING_PHY_CONFIGURATION	0x00010000
 #define MGMT_SETTING_WIDEBAND_SPEECH	0x00020000
+#define MGMT_SETTING_CIS_CENTRAL	0x00040000
 
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index e5ffb7230..2cd12465a 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1264,6 +1264,11 @@ static int bap_probe(struct btd_service *service)
 		return -ENOTSUP;
 	}
 
+	if (!btd_adapter_has_feature(adapter, ADAPTER_FEAT_CIS_CENTRAL)) {
+		error("BAP requires CIS Central, but unsupported by adapter");
+		return -ENOTSUP;
+	}
+
 	/* Ignore, if we were probed for this device already */
 	if (data) {
 		error("Profile probed twice for the same device!");
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index fbb350889..873dee33e 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1259,6 +1259,9 @@ static bool experimental_endpoint_supported(struct btd_adapter *adapter)
 	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET))
 		return false;
 
+	if (!btd_adapter_has_feature(adapter, ADAPTER_FEAT_CIS_CENTRAL))
+		return false;
+
 	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
 }
 
diff --git a/src/adapter.c b/src/adapter.c
index aadad4016..2e038ace0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -10717,6 +10717,17 @@ bool btd_has_kernel_features(uint32_t features)
 	return (kernel_features & features) ? true : false;
 }
 
+bool btd_adapter_has_feature(struct btd_adapter *adapter, uint32_t feature)
+{
+	size_t i;
+	uint32_t features = 0;
+
+	if (adapter->supported_settings & MGMT_SETTING_CIS_CENTRAL)
+		features |= ADAPTER_FEAT_CIS_CENTRAL;
+
+	return features & feature;
+}
+
 bool btd_adapter_has_exp_feature(struct btd_adapter *adapter, uint32_t feature)
 {
 	size_t i;
diff --git a/src/adapter.h b/src/adapter.h
index 78eb069ae..6a9a626bc 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -256,6 +256,12 @@ void btd_adapter_for_each_device(struct btd_adapter *adapter,
 
 bool btd_le_connect_before_pairing(void);
 
+enum adapter_features {
+	ADAPTER_FEAT_CIS_CENTRAL	= 1 << 0,
+};
+
+bool btd_adapter_has_feature(struct btd_adapter *adapter, uint32_t feature);
+
 enum experimental_features {
 	EXP_FEAT_DEBUG			= 1 << 0,
 	EXP_FEAT_LE_SIMULT_ROLES	= 1 << 1,
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 29f86091f..de614ced1 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -353,6 +353,7 @@ static const char *settings_str[] = {
 				"static-addr",
 				"phy-configuration",
 				"wide-band-speech",
+				"cis-central",
 };
 
 static const char *settings2str(uint32_t settings)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 743f6f59dff8..dc284c5f5cbb 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -109,6 +109,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_STATIC_ADDRESS	0x00008000
 #define MGMT_SETTING_PHY_CONFIGURATION	0x00010000
 #define MGMT_SETTING_WIDEBAND_SPEECH	0x00020000
+#define MGMT_SETTING_CIS_CENTRAL	0x00040000
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0dd30a3beb77..d802faf60f26 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -859,6 +859,9 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	    hdev->set_bdaddr)
 		settings |= MGMT_SETTING_CONFIGURATION;
 
+	if (cis_central_capable(hdev))
+		settings |= MGMT_SETTING_CIS_CENTRAL;
+
 	settings |= MGMT_SETTING_PHY_CONFIGURATION;
 
 	return settings;
@@ -932,6 +935,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (hci_dev_test_flag(hdev, HCI_WIDEBAND_SPEECH_ENABLED))
 		settings |= MGMT_SETTING_WIDEBAND_SPEECH;
 
+	if (cis_central_capable(hdev) && iso_enabled())
+		settings |= MGMT_SETTING_CIS_CENTRAL;
+
 	return settings;
 }
 
-- 
2.39.1

