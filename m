Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A011F1C6B8
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 02:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712198759; cv=none; b=nT62I11toJPVWRqxijlTMg4jC1TKlLhxMedJu0v2tNsLhY71KAo6E7ac8plUNnSPsTVyc8xWioz6v/U3636BGgRjkzdMAE37KphCmh2jtKUuFhWL1tUeJigk7T8KADeaPpEKJzuGCt9Bew0qWtHpDFY6F9vI3nFGXX2g7SQL80o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712198759; c=relaxed/simple;
	bh=6dKcgsSsKRcR2zluwdPeBCuYg1/K5k4r3QaqVHsTPK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZasNbNp7TKEWqFuiWPoC8ANt0hSmW+EA+OOs9R1YJiGLRyMhNphSht01tOw+OGlJSBYL5OWX2+txHBOB2nSfZhXLhCU9JzMCR8JQMfO4SfSkJxowBn1jFrL5p+gK5T5w+ihqznP83NIKnywGj1YMOkR8ReWp9eaIifix/HDK3B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2RIXBty; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2RIXBty"
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-22e7560b94aso275982fac.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 19:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712198756; x=1712803556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXeFRW6/7y6+A0LTRNjTlTWuylfSEcRX+XVrjnQMJOE=;
        b=J2RIXBtyKVs8OZST+sr6aaOQjlvaFU33mlPStHiCvcROPgjLS287xCY7Yxif/zKK8B
         rCPBV0vYB8eHgS8D5pio5BzBGXSgPzA/ZbmB4HhPW9aq2eWDa7mQaCW1XkBUF/3Jb14I
         fhCIgyRUnenA5hbSJUg0Q7Cfe/zu0jCXvHNN9NWia/JSQiVXUFs2bUK0UoMsVku4OWkV
         vIXnPjxryly5w7AE6SEiqwCemSwoLRUkgjISS0GYTiPeoeQmamSXEBRF3boYbrqIlgTu
         hGXKPqT03PTxsOxfF5ZO9IuwaqD58rnwOL25rINj4MQSc76lxvc4boy/xqbqYzhrhOMn
         Zs4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712198756; x=1712803556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXeFRW6/7y6+A0LTRNjTlTWuylfSEcRX+XVrjnQMJOE=;
        b=EHaP1f6cXctH21/mOw9P7pEJx69SHzTvWi+0OPaAcVNgm2x5hs3M90fkzRtVQmjalO
         eB/bU+jBImnAXKsm4alDnonzSphkONX5v+t5vzy8BFP8CLtfVb0zZ9Gtqqq0t+yYFdWl
         u929cc7e3rMqCl0lDvDg5k5Yq7d6qhDAgor7dfB3PbkSbl0SAEHw+SfIO1qbmFphyjs0
         V+Pzk7ZuKWhSab1VmDBOTDpnrVaFQSXs1JDhkLDLqGs6zkzwW85wVEbZHT31jmRvUOWO
         BKkJe5clqiEEyA2V5VySjvBZyYI2abBTtLaRUNCunxuoKxUjVJr0EN99RImte7tL5izM
         7qgQ==
X-Gm-Message-State: AOJu0Yw02Shaaw/suXpvyIX2ImeOx0kst4b0DBBwe3Gj0vx57VNMd0eg
	eR+KXChMxCAHGPnYd6fqV2Qj76NtNuS0aqlm9Z4kux9/x2vGia9gTTKekOdJMhA8qBZE
X-Google-Smtp-Source: AGHT+IEUNlG3GB7HO8J3QJY4t5JtKEVdZ1dTdp2JquNDu3b6OxX4Qc9KMVcZ2RgwLeB+hLfy7pwu4Q==
X-Received: by 2002:a05:6870:1391:b0:22e:a4ab:68cc with SMTP id 17-20020a056870139100b0022ea4ab68ccmr1131651oas.25.1712198755944;
        Wed, 03 Apr 2024 19:45:55 -0700 (PDT)
Received: from angua.lan ([2600:3c0a:e002:7f00::1001])
        by smtp.gmail.com with ESMTPSA id g8-20020aa79dc8000000b006e56da42e24sm12512869pfq.158.2024.04.03.19.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 19:45:55 -0700 (PDT)
From: Dimitris <dimitris.on.linux@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dimitris <dimitris.on.linux@gmail.com>
Subject: [PATCH BlueZ 1/1] Refactor btd_device_is_connected
Date: Wed,  3 Apr 2024 19:45:21 -0700
Message-ID: <20240404024521.120349-2-dimitris.on.linux@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404024521.120349-1-dimitris.on.linux@gmail.com>
References: <20240403205252.71978-1-dimitris.on.linux@gmail.com>
 <20240404024521.120349-1-dimitris.on.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Splitting the service state test out of btd_device_is_connected
and using the state-specific test from adapter_remove_connection.

This intends to fix a busy loop that happens when BT is disabled
from userspace with e.g. "rfkill block bluetooth".
---
 src/adapter.c | 2 +-
 src/device.c  | 7 ++++++-
 src/device.h  | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4bcc464de..0b7aab4b5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7486,7 +7486,7 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
 		device_cancel_authentication(device, TRUE);
 
 	/* If another bearer is still connected */
-	if (btd_device_is_connected(device))
+	if (btd_device_state_is_connected(device))
 		return;
 
 	adapter->connections = g_slist_remove(adapter->connections, device);
diff --git a/src/device.c b/src/device.c
index 5e74633c6..123b1b796 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3273,13 +3273,18 @@ uint8_t btd_device_get_bdaddr_type(struct btd_device *dev)
 
 bool btd_device_is_connected(struct btd_device *dev)
 {
-	if (dev->bredr_state.connected || dev->le_state.connected)
+	if (btd_device_state_is_connected(dev))
 		return true;
 
 	return find_service_with_state(dev->services,
 						BTD_SERVICE_STATE_CONNECTED);
 }
 
+bool btd_device_state_is_connected(struct btd_device *dev)
+{
+	return dev->bredr_state.connected || dev->le_state.connected;
+}
+
 static void clear_temporary_timer(struct btd_device *dev)
 {
 	if (dev->temporary_timer) {
diff --git a/src/device.h b/src/device.h
index d4e70b7ef..e3191f2a4 100644
--- a/src/device.h
+++ b/src/device.h
@@ -104,6 +104,7 @@ void device_set_rssi(struct btd_device *device, int8_t rssi);
 void device_set_tx_power(struct btd_device *device, int8_t tx_power);
 void device_set_flags(struct btd_device *device, uint8_t flags);
 bool btd_device_is_connected(struct btd_device *dev);
+bool btd_device_state_is_connected(struct btd_device *dev);
 uint8_t btd_device_get_bdaddr_type(struct btd_device *dev);
 bool device_is_retrying(struct btd_device *device);
 void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
-- 
2.44.0

