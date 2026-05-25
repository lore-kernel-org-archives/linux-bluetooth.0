Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48C130C16B
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 04:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779682343; cv=none; b=kYR+Hf1u/DRYmxw278SqA0kalvskgKqEh1k0w2w4Uakt0y7Rj1xYwqTv4u2SWlxk9jlIhoa0BmoGYfT9zI1Y0PRnu6AVeOH8SWcOgdFXbWwEunDwwhpZZaGc7k6fFuz6OWNJ3NUC/tbtj5WYYf18dLx2Ku5Mi8jF+QJ/JezGMZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779682343; c=relaxed/simple;
	bh=16HDUW0Ovz4wulyEj3TQq0mLoaixvdfvhOFLQ9Di0eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ApmyfkO7ngy75RDRhVdVCsjB7U/Mqy4fMypZX3GjnwG4ekFd3d9DDDH+p9SWXgTn1vCq5AcXMF9J5VEav8H4Bbt5lIa9FlqwDOEVoctWB1CbJi7dvpQ6IqPBlPlEDRJja6VNSZZWnKVIOKAe6sR6koyij+7eHn0PJJcopi1LyXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=K4YWFSjh; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="K4YWFSjh"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso7429415f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 May 2026 21:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1779682339; x=1780287139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4yBi6BPh+UXXZzgh/Y/uB92Co2L+V2zJvUgtSBj0qPg=;
        b=K4YWFSjhSh7OCMisa4OJfXzmEyKrB1zBoIErDIau/dIdEWmcwk06jZSIUlFirLx0m/
         to2/FtY18c4oHO5jD7I06KSZO5gCgp5tYx93c+JUT9cb31cnYJE71KfxAWzR9yGU46ba
         xHWpRqI1DJb5a55woJ0Y/bZ6RE2ZVIEQwL5hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779682339; x=1780287139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yBi6BPh+UXXZzgh/Y/uB92Co2L+V2zJvUgtSBj0qPg=;
        b=SuQLB1wrBE7ZnAj/ucLcEAcxHBjKYUa/ZSoGbwNegk8lGDvAj8xywC0lvR9GL5aH6/
         LRPf8oTte+fepNOcyFnCTkL4FRTTVfVZsAMy3bLTmPOVW4aFvzxSQVWYIPH2izpsmmI0
         ALCBirSxpeK7izuRNwQ1WFjtk5/jC1pRvps3fpgb7i29LfQLK9vsEzYOESUwI+MNb3JU
         KR3emcApwvHTPLENity+4k3HeKQ6zN7fwvba7z+zivYbMfhTTWmwjL1EPOX2NiPkJLop
         JhBcFLAve1iSHsGRATXyOU9KmdgE5qG+EFR5TBZAopEO8z11YW1ks3lacQGp3FnS5I0x
         D1aA==
X-Gm-Message-State: AOJu0Yzifb1zlZKnM0eQf9etUzqwNyuaIXDEoNn1NjCtkT3RJNgJ7VkD
	E1H3+/mQBTD7IkMb9PAKoeFbke/MzNldYhFzwdsVbKNIilVCwy8YtMg3D5buefU+WgnlaNDZEyM
	CRkc=
X-Gm-Gg: Acq92OEWqQ1gtVKaUA5JhVKTrLtA6KOWnu+fT7ucvgCLZzXzOsivJLQNJn9vdUEGuHt
	t+F1Anie2bqTRKIxeU80tn2xrrBA4ng2+x44fHv7zQ70Yw1zjWWIwskLzzj2XOOPbVjKgHqe2Vh
	3+E95DuHp++TzbBpKq17f25YfIMEBtKX6vaXOmyomRWuI7uNPeYMgQvqfeapdOyo6+B9QcbnJGx
	adufa4xNE8FseZmZUK9jSL+EPnV7GCmsxEB8+fbqyR2mXDG09kZEL1vZk/33dON/0UvgWXc0eO6
	D75htgwzljnRRTIGGAx1ochrZN6E005a+Wcl3/xjE7zIEdbBcNZ4v/AbWYldK47VEk7ER4obrq4
	rjzd8+HhtHrgMa+TrjZBCnBHUVCGIBOK8CK5pTJySjE+qVZEUsCOjOBgzWTmv7Bj+0ESdoMdZss
	WCjXzkKneSAgDx65i9evhIf06JhrYyv8TgK+OWy5YcqvcfFyMyrPoOdqzgQI3iXcG52uEsypQD/
	Wnp1ak=
X-Received: by 2002:a05:6000:4701:b0:45d:b14b:2412 with SMTP id ffacd0b85a97d-45eb369ca6fmr21020439f8f.6.1779682338988;
        Sun, 24 May 2026 21:12:18 -0700 (PDT)
Received: from great-eastern2.home (public-gprs184177.centertel.pl. [46.134.58.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6cce0a4sm23267478f8f.12.2026.05.24.21.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 21:12:18 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ] advertising: add property with advertisement ID
Date: Mon, 25 May 2026 06:11:51 +0200
Message-ID: <20260525041151.3893522-1-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Identifier is an internal value, but it must be exposed to client app
if client app wants to use a advertisement in BAP broadcast
---
 doc/org.bluez.LEAdvertisement.rst |  6 ++++++
 src/advertising.c                 | 13 ++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.LEAdvertisement.rst b/doc/org.bluez.LEAdvertisement.rst
index aae80f08f..4dd36a0cc 100644
--- a/doc/org.bluez.LEAdvertisement.rst
+++ b/doc/org.bluez.LEAdvertisement.rst
@@ -235,3 +235,9 @@ The provided value is used only if the "CanSetTxPower" feature is enabled on the
 **org.bluez.LEAdvertisingManager(5)**.
 
 Values must be in range [-127 to +20], where units are in dBm.
+
+byte Identifier [read-write, optional]
+``````````````````````````````````````
+
+Identifier of the advertisement. Set by bluetoothd after advertisement is registered with
+**org.bluez.LEAdvertisingManager(5)**.
diff --git a/src/advertising.c b/src/advertising.c
index f529ecd14..3b758f51e 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1511,8 +1511,19 @@ static void add_client_complete(struct btd_adv_client *client, uint8_t status)
 		queue_remove(client->manager->clients, client);
 		g_idle_add(client_free_idle_cb, client);
 
-	} else
+	} else {
+		DBusMessageIter iter;
+
+		/* Check if the attribute has the Identifier property */
+		if (g_dbus_proxy_get_property(client->proxy, "Identifier",
+								&iter)) {
+			g_dbus_proxy_set_property_basic(client->proxy,
+				"Identifier", DBUS_TYPE_BYTE, &client->instance,
+				NULL, NULL, NULL);
+		}
+
 		reply = dbus_message_new_method_return(client->reg);
+	}
 
 	g_dbus_send_message(btd_get_dbus_connection(), reply);
 	dbus_message_unref(client->reg);
-- 
2.43.0

