Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD8C2045B7
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744818912; cv=none; b=TZeHXJhX+ihv0+Rya5Udjs50fRU3Hhw9R2B/GdXn9bJ/wJaxgz6Q69/zKIKeAzBsBpsmXINch1+JHNBFBHmxbQArMpb2KgZJU5F6OATTKGySolXqCIUfn26wHAJIGxofci+ylJELMVVjKI0d6WHcbE7rWto3YPd4zg9n+mvhmN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744818912; c=relaxed/simple;
	bh=iAQPmX16cDOzwPLlIilGb02YB41RjtdOLemfhmEP33k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ku1vOq+gEMqdjiPO9tFfvU1pPrIaTErDeBWF9EYPsRjpzjE5HO4I+8no3t2k6sXFK/XP1TY8f20zJ56GXvVWWnwQS5Flx2CD7Mtquve1r+SUl1D8GY8NFqKY9pkAlUxkRa5avKYxamBQvJ7NyQ4j131b+Fz3QYMx53GwQe9rrzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dVKL2kdQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dVKL2kdQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744818908;
	bh=iAQPmX16cDOzwPLlIilGb02YB41RjtdOLemfhmEP33k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dVKL2kdQGNOL5MMgmyyzhtu1bG5ENwNicahrL4JlSwNvm33IAv/My09VZozdSzkxg
	 r9/tF8TLXDmiC0BL5EKFAT8xMRHmkTe2XdxMvehxmqnPNLc8t3AbS2M2a25Fyo6BZJ
	 vfUQr2uQOQSQVmVWT2RwNUB1RK6FsTwDz15l+ZDUAKQJnc/EDBqTkdXDH5AycBO+Cn
	 QQrvF2QIQS40d0gs1kaa+5fiW7NoHyX2kYx1ooLkXW2uyBjqKvxxv1qHZmLHUj28vK
	 0NWyseYYj0+zF9hG36seuRjJmecsDoar0xgwVDPh5P94IX1CXE/NjE8ccqzE+KiPhQ
	 UbW81Cl4Ej2Mw==
Received: from fdanis-XPS-13-9370.. (2a02-8428-af44-1001-B876-6480-8eAf-ACd0.rev.sfr.net [IPv6:2a02:8428:af44:1001:b876:6480:8eaf:acd0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3EE4017E09B5
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 17:55:08 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] input: device: Browse SDP records if not cached
Date: Wed, 16 Apr 2025 17:55:02 +0200
Message-ID: <20250416155503.250763-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416155503.250763-1-frederic.danis@collabora.com>
References: <20250416155503.250763-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

For a HID paired device, if the cache file containing the SDP records
is not present this will prevent the device to connect and need to
remove it and pair again.

Current bluetoothd traces:
src/shared/mgmt.c:can_read_data() [0x0000] event 0x000b
src/adapter.c:connected_callback() hci0 device EC:83:50:76:BD:67
  connected eir_len 31
src/shared/mgmt.c:can_read_data() [0x0000] event 0x0006
profiles/input/server.c:connect_event_cb() Incoming connection from
  EC:83:50:76:BD:67 on PSM 17
profiles/input/device.c:input_device_set_channel() idev 0x5580c6a331b0
  psm 17
profiles/input/server.c:confirm_event_cb()
profiles/input/server.c:connect_event_cb() Incoming connection from
  EC:83:50:76:BD:67 on PSM 19
profiles/input/device.c:input_device_set_channel() idev 0x5580c6a331b0
  psm 19
profiles/input/device.c:hidp_add_connection() Could not parse HID SDP
  record: No such file or directory (2)
profiles/input/device.c:ctrl_watch_cb() Device EC:83:50:76:BD:67
  disconnected
profiles/input/device.c:intr_watch_cb() Device EC:83:50:76:BD:67
  disconnected

This commit tries to retrieve the SDP record from the remote HID then
to add the HIDP connection.
---
 profiles/input/device.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index b162c0bc7..c1bb5588d 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -86,6 +86,7 @@ struct input_device {
 	bool			virtual_cable_unplug;
 	uint8_t			type;
 	unsigned int		idle_timer;
+	bool			sdp_rediscover;
 };
 
 static int idle_timeout = 0;
@@ -1045,6 +1046,22 @@ static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 	return FALSE;
 }
 
+static void input_device_update_rec(struct input_device *idev);
+static int hidp_add_connection(struct input_device *idev);
+
+static void hidp_sdp_cb(struct btd_device *dev, int err, void *user_data)
+{
+	struct input_device *idev = user_data;
+
+	DBG("");
+
+	/* Attempt to update SDP record if it had changed */
+	input_device_update_rec(idev);
+
+	if (hidp_add_connection(idev) < 0)
+		btd_service_disconnect(idev->service);
+}
+
 static int hidp_add_connection(struct input_device *idev)
 {
 	struct hidp_connadd_req *req;
@@ -1061,6 +1078,18 @@ static int hidp_add_connection(struct input_device *idev)
 	if (err < 0) {
 		error("Could not parse HID SDP record: %s (%d)", strerror(-err),
 									-err);
+		if (err == -ENOENT && !idev->sdp_rediscover) {
+			err = device_discover_services(idev->device);
+			if (err < 0) {
+				error("Could not discover services: %s (%d)",
+							strerror(-err), -err);
+				goto cleanup;
+			}
+
+			idev->sdp_rediscover = TRUE;
+			device_wait_for_svc_complete(idev->device,
+				hidp_sdp_cb, idev);
+		}
 		goto cleanup;
 	}
 
-- 
2.43.0

