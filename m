Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED95F2C69D
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052250; cv=none; b=NQN0ZtnUrGWPdRkBN7r/GpNIJc4Nyf1D+n9FX1uyvKNJgzF9Ihnzmb8Qucr7vGkqTwDQ3MtkoKEjcYk7HA+qvM+TW1y5dxQR0nztFiMUbr78robZFjyiN+/sd0iJvi0S9ZDz8itaPljMExA3xN7KCDDxYSW8fwfAp6vDc8sdZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052250; c=relaxed/simple;
	bh=ubKQJPV5hCvqV4OpR8OcKERTXKdBFJBog/T2TFvYut4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6CIDphPEwtDBe6DoEzG+ORN/D33m8MRIExobHb3Cv6+E7nbVKtiBD+vZ5fTUzikV+ngjZLV4BZO0Qu9y60nS1uo6Z5wsR0wP1eiq80Z6qgkQTSP05VdMUiz6vWfWYl/mxP4TLXIbUJvtg4/Jm0EO88hUMbT/4/pB9tfIq86hMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ff4XqUJw; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ff4XqUJw"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-47048ea1b17so543324137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 08:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709052246; x=1709657046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vLhphde7KiKM567H6JdrwgApp0exKrb3Gp/hXUliMc=;
        b=ff4XqUJwgolJeEaiDQWn8jGHqhT7cygOVK//UpLfuh8AOzs5D31iNWMQGK1hCzyz4b
         1NJ1ZQQulefWJXxDcxWmG+i1HFgybsrcuLlgegPhQBvTRki2XPMcNxaPZVXm/a90kkC6
         NCnHWRPtx6vbJ4SGpXfNB6ZbmWbNVwQurkPctJ4SIWRc6f0bT3yLltbtykP1rI9Rus54
         jHXP9k9eiUZwciyxm/hGroPx0SfmQ5c+pLU9h4iqugMQCnjlLaMonTLnqwOjmV4LN2tX
         j9op+EF4djUatJZrhfjRPyTIUiftw/F3RUgoYdLKSD3wZBj/UxWcPN7KMtG9mX2CIzjX
         uiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052246; x=1709657046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vLhphde7KiKM567H6JdrwgApp0exKrb3Gp/hXUliMc=;
        b=TcDfFS1q2Uuxoz6B58YKKow9r345EQfX9zN+K9+GqliQIA7JEf21Qc3YdiHIdJbpHv
         Wd9fzPqf2TO2wumdZLROIg7dClNFwqHvbhrGEDPfO5gnjZjleV+FJNxjYIKxBUT61rvz
         1XCikN9+QSdU6imZOQRAVmUU2JCy8YWkrMoZrNt20DQDReAZAMZrPss5Fl9mWiW9IrBD
         JUj4gmoQu+8fqzWMepaO9Ugh945mjTXDMxeyuO3enXSeLKtidQV+UJ6SS7wHwY8PFZTs
         f/TcRuEUhLpGBIPEWHbiD3Vg1F1A9TtdTzRUuZcI3jER1/Qfscj+7mPlrc05ccQJz+2t
         nY4Q==
X-Gm-Message-State: AOJu0Yz/s70s0G/nJ+DOu2IVLBoMn/VwNmX03oWwdzbVMRari7NvSp4H
	jlY6grezdqWsGAaQfOh7qGoN4eBcZCI7JbSB73l1PwR1DAfPrqerwrWFNBoR
X-Google-Smtp-Source: AGHT+IHkZKuWXlMeR81/QvRhvhDc5YarUFfZoE29KHcnqjKq10VEQdyWtcnoi/DglgGW/L/bMPenIg==
X-Received: by 2002:a05:6102:55aa:b0:470:4a5f:684d with SMTP id dc42-20020a05610255aa00b004704a5f684dmr10516771vsb.29.1709052245898;
        Tue, 27 Feb 2024 08:44:05 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id j30-20020a0561023e1e00b0046d28239032sm1378126vsv.5.2024.02.27.08.44.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:44:05 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] device: Consider service state on device_is_connected
Date: Tue, 27 Feb 2024 11:44:03 -0500
Message-ID: <20240227164403.1904213-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227164403.1904213-1-luiz.dentz@gmail.com>
References: <20240227164403.1904213-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This checks if there is any service connected on device_is_connected
since some profiles maybe probed using advertising data which doesn't
require a connection.
---
 src/device.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 1db96d9a672c..e5191cabe81a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3225,7 +3225,11 @@ uint8_t btd_device_get_bdaddr_type(struct btd_device *dev)
 
 bool btd_device_is_connected(struct btd_device *dev)
 {
-	return dev->bredr_state.connected || dev->le_state.connected;
+	if (dev->bredr_state.connected || dev->le_state.connected)
+		return true;
+
+	return find_service_with_state(dev->services,
+						BTD_SERVICE_STATE_CONNECTED);
 }
 
 static void clear_temporary_timer(struct btd_device *dev)
@@ -3276,6 +3280,13 @@ static bool device_disappeared(gpointer user_data)
 {
 	struct btd_device *dev = user_data;
 
+	if (btd_device_is_connected(dev)) {
+		char addr[18];
+		ba2str(&dev->bdaddr, addr);
+		DBG("Device %s is marked as connected", dev->path);
+		return TRUE;
+	}
+
 	/* If there are services connecting restart the timer to give more time
 	 * for the service to either complete the connection or disconnect.
 	 */
-- 
2.43.0

