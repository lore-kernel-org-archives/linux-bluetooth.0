Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FCC2DBF48
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765478083; cv=none; b=jhZ2fE9Oi8njbjja/shp0PFteYWNBYwg6ttG7+EyoZpkJPOTQxPTRXqVNJQJ8nB/SwsW4HGJeDWEoApXGTKrRn2sDbH2pv4/WDBVS498yu6GgwoflP6t0lmUPDJvZ769fFVyBhsPi6IUeQKqh4RwGILfkRlb5HRSDMDUqRSK1L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765478083; c=relaxed/simple;
	bh=FGFODAy+vKlq+mGswhaFOuB5ypDbidtTu29RxQ2Gk0U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hK5jMpri1lP3S+nl6WI0St6+1V0jYHFTlOiUFpQpkpXO3TRmiaAOeStijva6d03JxLFq+9PGwrbSMGgUxkXt+1nvs+Ckq363Nl3hhszpbU18gxBRcsGcYRCN6sm36fgIeiCw/2fWfp1oNGq3Kq3koj8p7V5peeIpnd0AB5+tOiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lOlrsiWO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lOlrsiWO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1765478079;
	bh=FGFODAy+vKlq+mGswhaFOuB5ypDbidtTu29RxQ2Gk0U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lOlrsiWOtQuQJ/ftvVy4QUAdUmKVSa+bYKB9DHgI4msxQQ12bDAC4QKGfslhrgB1F
	 tLyI4czfgcj7UtJuzONYRWWagEagNqVkiQoNdE73Dlc3sOPE/u70zkJnPGjAtSzqmp
	 NseYtFgD8eKXX55lPM2INN3CvfGyXVbx2XjG61TC98L8furfym0ymGbn9P2gZ3sVMQ
	 tCu+rRLCnWdwT0uxhlHd7YiMxpwKZ4Ytj8LzbhW0WhjGmfREdeBd/OrgAw7ZGaKeIX
	 KhcvdxyhoWoyX/Veyz19c9+RAyZ16SC7S925GMhkaKHZXkUylp3h5FZ5UqtWFyY6u2
	 93/675ewNO4ew==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-F1a6-5002-c5C6-5e5c.rev.sfr.net [IPv6:2a02:8428:af44:1001:f1a6:5002:c5c6:5e5c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5949717E35D9
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 19:34:39 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/5] audio/hfp-hf: Add HFP SLC connection and event support
Date: Thu, 11 Dec 2025 19:34:28 +0100
Message-ID: <20251211183429.419619-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211183429.419619-1-frederic.danis@collabora.com>
References: <20251211183429.419619-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This implements the HFP HF SLC connection and events support for the
Telephony DBus interface.
---
v1->v2: Improve commit message

 profiles/audio/hfp-hf.c | 96 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 5375168cf..d25cda389 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -40,6 +40,7 @@
 #include "src/plugin.h"
 #include "src/profile.h"
 #include "src/service.h"
+#include "src/shared/hfp.h"
 
 #include "telephony.h"
 
@@ -50,12 +51,25 @@ struct hfp_device {
 	struct telephony	*telephony;
 	uint16_t		version;
 	GIOChannel		*io;
+	struct hfp_hf		*hf;
 };
 
+static void hfp_hf_debug(const char *str, void *user_data)
+{
+	DBG_IDX(0xffff, "%s", str);
+}
+
 static void device_destroy(struct hfp_device *dev)
 {
 	DBG("%s", telephony_get_path(dev->telephony));
 
+	telephony_set_state(dev->telephony, DISCONNECTING);
+
+	if (dev->hf) {
+		hfp_hf_unref(dev->hf);
+		dev->hf = NULL;
+	}
+
 	if (dev->io) {
 		g_io_channel_unref(dev->io);
 		dev->io = NULL;
@@ -64,6 +78,62 @@ static void device_destroy(struct hfp_device *dev)
 	telephony_unregister_interface(dev->telephony);
 }
 
+static void hfp_hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
+							void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	switch (indicator) {
+	case HFP_INDICATOR_SERVICE:
+		telephony_set_network_service(dev->telephony, val);
+		break;
+	case HFP_INDICATOR_CALL:
+		break;
+	case HFP_INDICATOR_CALLSETUP:
+		break;
+	case HFP_INDICATOR_CALLHELD:
+		break;
+	case HFP_INDICATOR_SIGNAL:
+		telephony_set_signal(dev->telephony, val);
+		break;
+	case HFP_INDICATOR_ROAM:
+		telephony_set_roaming(dev->telephony, val);
+		break;
+	case HFP_INDICATOR_BATTCHG:
+		telephony_set_battchg(dev->telephony, val);
+		break;
+	case HFP_INDICATOR_LAST:
+	default:
+		DBG("Unknown signal indicator: %u", indicator);
+	}
+}
+
+static void hfp_hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
+							void *user_data)
+{
+	struct hfp_device *dev = user_data;
+
+	if (res != HFP_RESULT_OK) {
+		error("Session setup error: %d, dropping connection", res);
+		hfp_hf_disconnect(dev->hf);
+		return;
+	}
+
+	telephony_set_state(dev->telephony, CONNECTED);
+}
+
+static struct hfp_hf_callbacks hf_session_callbacks = {
+	.session_ready = hfp_hf_session_ready_cb,
+	.update_indicator = hfp_hf_update_indicator,
+};
+
+static void hfp_disconnect_watch(void *user_data)
+{
+	DBG("");
+
+	device_destroy(user_data);
+}
+
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct hfp_device *dev = user_data;
@@ -76,8 +146,27 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		goto failed;
 	}
 
+	dev->hf = hfp_hf_new(g_io_channel_unix_get_fd(chan));
+	if (!dev->hf) {
+		error("Could not create hfp io");
+		goto failed;
+	}
+
+	hfp_hf_set_debug(dev->hf, hfp_hf_debug, NULL, NULL);
 	g_io_channel_set_close_on_unref(chan, FALSE);
 
+	hfp_hf_set_close_on_unref(dev->hf, true);
+	hfp_hf_set_disconnect_handler(dev->hf, hfp_disconnect_watch,
+					dev, NULL);
+	hfp_hf_session_register(dev->hf, &hf_session_callbacks, dev);
+
+	if (!hfp_hf_session(dev->hf)) {
+		error("Could not start SLC creation");
+		hfp_hf_disconnect(dev->hf);
+		goto failed;
+	}
+
+	telephony_set_state(dev->telephony, SESSION_CONNECTING);
 	btd_service_connecting_complete(service, 0);
 
 	return;
@@ -149,8 +238,15 @@ static int hfp_connect(struct btd_service *service)
 
 static int hfp_disconnect(struct btd_service *service)
 {
+	struct hfp_device *dev;
+
 	DBG("");
 
+	dev = btd_service_get_user_data(service);
+
+	if (dev->hf)
+		hfp_hf_disconnect(dev->hf);
+
 	btd_service_disconnecting_complete(service, 0);
 
 	return 0;
-- 
2.43.0

