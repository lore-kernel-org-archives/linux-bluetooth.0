Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63123341ACC
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646868; cv=none; b=gFKgdmEhxTcPwyUSyHdhGmVRtnBC2P5m6eYtg11KBnxr+50ObA+eoAlKNtwQ/T4oHihHYhaTU6W+LKwzMLhShuKb51AayRn7aOUAhushQzDikqZ6byxoVZqy6AGmlvsksPYCmflgX8BPbgGIvFKdlfYPdqtmJnJd/2JgdCwXP3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646868; c=relaxed/simple;
	bh=bGLLULti4Wl3ZgJsoHP3x1dirCXr8dMg+4WbVyu72sE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMKd1+sw3To32VEujECmZT5u4AAkH63CdRVXEqZvX57prHq2La4X3U+kyowQAOpAmMwHXL9sy7cBc2ow2Isgq0iHd9IeE45buYEVCa6shsDB1gKHoh7BPKyR6q6AFlITBCDUKOQrJ+HrAcOcFTvsACgLjELjhC8GuThm5NTbn6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CTCgW248; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CTCgW248"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763646864;
	bh=bGLLULti4Wl3ZgJsoHP3x1dirCXr8dMg+4WbVyu72sE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CTCgW248gtVljJjwYqKungxA6Uhh5Z6symE4PnVEXfXHgo9u54/hd1zhFRtXp+gEQ
	 xbEMIXBN+8XplHpuoISUWeQcDwWvb4z0p9ueUIbOJukIWJugt41N3nif3trYdGCVax
	 G8QyAlKBr+ebiHrbRLzYyDYaumzdJ9ivTMQmee59ig5HQJ6EwJbpIW18iQ1Oi78gb9
	 K9q56RTq5jTT+W4dVLe5Lu/8AH2xQBr64CsShBTIlhXKG+GkCPcwmGmQ2ewcXGoZro
	 BxM2lSF64GGc5Ql//SWTFJ566XZ2g5fztbArBktohqUi8sclN3TtxN5xPm8A3er75p
	 Jm1etcFZNDldg==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-aF44-1001-ec76-9D0e-ad8c-585A.rev.sfr.net [IPv6:2a02:8428:af44:1001:ec76:9d0e:ad8c:585a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 597D117E13B9
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 14:54:24 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] audio/hfp-hf: Add HFP SLC connection and event support
Date: Thu, 20 Nov 2025 14:54:15 +0100
Message-ID: <20251120135417.820220-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120135417.820220-1-frederic.danis@collabora.com>
References: <20251120135417.820220-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
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

