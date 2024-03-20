Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B603C060
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935124; cv=none; b=RYR2p/AFcvRkhuWQb/MMUp42fceQPfU2XN5Ythn31+diKk6Q0EIuLt0aYLhVh/BgDUltnkE8iC2nffPbCi1diRYawOj41LwVcecj7P2BoHvOe5t0uAThTQ/BEYxU8Mkxrtu9v7OaYO00g0Yy/T/HsmoEp+gcLCMiUMKOlJ31XoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935124; c=relaxed/simple;
	bh=eNo00SgKgi6717p0ylQc8T5moT79vL+u+SzFKUGDK+o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HqqjMNUKhGSsSQzsFtb7KPZBwdRfbG++jEIarms+M6y/xS8Kv8U9uLtFACUjrKXxuIXi+3mCYgmRMxmkat6tW2t3g0FiulqHC7oc1bZAQ4lrVRmqld5L84qre35ik9Tkwy1rW3JiK8FRsfo1wcbuBNPHOfCMMxV+YuPKPghrg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/YkfWgO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/YkfWgO"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-341730bfc46so1966928f8f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 04:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710935121; x=1711539921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KuqGZjb9lC56guY2TJTJuZdQPD/hydA+QWdm6dhMgsk=;
        b=R/YkfWgOdQ3MSVYV46f3XXK5hohBWE2xWDvQjY1AAHVJoyc5pr5x2Y6fDpBkcpmNHy
         K5mTc129LhmT+n4NfqZk17PSDx98B1n05CSGtWhslOzjG2CGUJkjA/QZJRQ+W46mUQvE
         VvHbVS+O/0KcGw6pC/Du9aLCr2ZpDy1PwbCbNRCvgFO3sUqE/jgK1fmJjKK/jAGZ5CBZ
         i9asnarXII6d20isr8kGicIwi/lLwbldnd1iQCFcwjONHov+Ki2pDaNj7/HKAzP6pXJW
         St6sRQJTtGihFGP+Sg6VAAIJVHrdSwEdEzpcQA4YdiJD88C5EdVSPBcvr4qXSiP5lAWM
         OQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710935121; x=1711539921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuqGZjb9lC56guY2TJTJuZdQPD/hydA+QWdm6dhMgsk=;
        b=BJXA0ptFSBONIiz5dtHaajqE9lW272pbZCU296Z4OHYE0DK0jcCr00plQBZb/JHixk
         WLalup8TSbIXnmY+sO0FS/HMJIDVzTFQYoBBgpYg+3c9LskNLPqY/ym4e4H2ojO3lDDN
         upBaK5sgomTWSh/6PWnW8zhsC2gSPtI8Kc5gnwxf3N5jloQ7ZKwE8fKLcVR+OXDFRxNB
         QR0Bfw0oYxjbwkBJeUNEQfogmNWwBXCRFxDxsmkoVIzAZOkU2y4Ejo2+0jbqpP6KlTel
         OarZWDntGn2bJj4DM92Zww4TTT0KXR3wrOLmZK4nKUthQxkUnGP1PQLC7Q+MclGf392h
         /VoQ==
X-Gm-Message-State: AOJu0YzHh0bi7QDd9LqFZDctXpjYmh2Jp3a9IKhzKDUqnQmDj/L+aGkK
	341cZxVn6XOtRJTUzKe5Fj62RWEAjI984yuoT71K1A0QTQeGKw+4qemx3eB2LJBOVQ==
X-Google-Smtp-Source: AGHT+IE0cFtGa1byZO+ZpIZCnHNDkQpS/u6oxNK5EZ7+T7L7eccMewTcyBVt52RcqGozozdtbrn0sA==
X-Received: by 2002:a5d:6505:0:b0:33e:1e0:2679 with SMTP id x5-20020a5d6505000000b0033e01e02679mr12127283wru.47.1710935120445;
        Wed, 20 Mar 2024 04:45:20 -0700 (PDT)
Received: from lvondent-mobl3.. (ftip004290803.acc4.faraday.21cn-nte.bt.net. [109.144.76.63])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d5684000000b0033ec6c8e780sm14443751wrv.102.2024.03.20.04.45.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 04:45:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] input/device: Fix not handling IdleTimeout when uhid is in use
Date: Wed, 20 Mar 2024 11:45:18 +0000
Message-ID: <20240320114518.751185-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When uhid is in use IdleTimeout was not taking any effect, this also
attempt to force the destroy the input device node to make it useful
for users that don't want to keep the input node forever.

Fixes: https://github.com/bluez/bluez/issues/777
---
 profiles/input/device.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 1b28cdc17..3467ff79f 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -77,6 +77,7 @@ struct input_device {
 	unsigned int		report_req_timer;
 	uint32_t		report_rsp_id;
 	bool			virtual_cable_unplug;
+	unsigned int		idle_timer;
 };
 
 static int idle_timeout = 0;
@@ -139,6 +140,9 @@ static void input_device_free(struct input_device *idev)
 		g_free(idev->req);
 	}
 
+	if (idev->idle_timer)
+		timeout_remove(idev->idle_timer);
+
 	if (idev->reconnect_timer > 0)
 		timeout_remove(idev->reconnect_timer);
 
@@ -156,6 +160,29 @@ static void virtual_cable_unplug(struct input_device *idev)
 	idev->virtual_cable_unplug = false;
 }
 
+static bool input_device_idle_timeout(gpointer user_data)
+{
+	struct input_device *idev = user_data;
+
+	idev->idle_timer = 0;
+
+	DBG("path=%s", idev->path);
+
+	if (connection_disconnect(idev, 0) == -ENOTCONN) {
+		/* Force UHID_DESTROY on idle */
+		if (idev->uhid)
+			uhid_disconnect(idev, true);
+	}
+}
+
+static void input_device_idle_reset(struct input_device *idev)
+{
+	timeout_remove(idev->idle_timer);
+	idev->idle_timer = timeout_add_seconds(idle_timeout,
+					input_device_idle_timeout, idev,
+					NULL);
+}
+
 static bool hidp_send_message(GIOChannel *chan, uint8_t hdr,
 					const uint8_t *data, size_t size)
 {
@@ -191,6 +218,8 @@ static bool hidp_send_message(GIOChannel *chan, uint8_t hdr,
 		return false;
 	}
 
+	input_device_idle_reset(idev);
+
 	return true;
 }
 
@@ -297,6 +326,8 @@ static bool hidp_recv_intr_data(GIOChannel *chan, struct input_device *idev)
 		return true;
 	}
 
+	input_device_idle_reset(idev);
+
 	hdr = data[0];
 	if (hdr != (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
 		DBG("unsupported HIDP protocol header 0x%02x", hdr);
@@ -520,6 +551,8 @@ static bool hidp_recv_ctrl_message(GIOChannel *chan, struct input_device *idev)
 		return true;
 	}
 
+	input_device_idle_reset(idev);
+
 	hdr = data[0];
 	type = hdr & HIDP_HEADER_TRANS_MASK;
 	param = hdr & HIDP_HEADER_PARAM_MASK;
-- 
2.44.0

