Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05272345CBC
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780222713; cv=none; b=FSOe+fcXY4zvvsjf2t/glOdYX4wC/GM1IfNc7VjWi97ZQTyCnl9aCnR/niFD3KG7m1oyEXvvr25SDMUo5Z1eoE6UsIUNvjCPsG65s4w6nThCzcb6y50wc3c80NjyhlpRQIjanGZIcu6bShcy7uaq2u61xlqfsLBRokgTK36Mtqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780222713; c=relaxed/simple;
	bh=pF1YLTsmopNGrKFhrJ4Z06IwlkUfjdls1r9dkTuMYVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quw738PyBFtceP28bl3RLTBcCfyARb+eMqkf5blWbSTKoTZ80SM6bwyPvir5aWZCPEkTfxobBtkWgPb6gUgoZOWyUmXHEjEq9VX6FR1mk5H99foi8o39ZQoZ23RYywo7yGdLyb5eMcJqmrQjg14VzLf2HZuri1JKFA/2Ck3GSks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=MuimFAEQ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="MuimFAEQ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68d233bf083so596711a12.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780222709; x=1780827509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2im6ERplsh5bqJNRwbMnLW3mFU8/SjatcavZXhIbxCI=;
        b=MuimFAEQlHwfqPFvRQFqJBeaNLTiL9j66Pw87BWTtdDPSbA61hjapYUPafkdxw/VB7
         UEuHjdfnb9mfWmU5mcmmFGkjUYjUbsJrb9OuFH+J3XYrzp/t59vlU+dQ4Ilf8m2BpkDa
         k09bXNd1cl5odm5603N4WsSvmqy7TYan6bcvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780222709; x=1780827509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2im6ERplsh5bqJNRwbMnLW3mFU8/SjatcavZXhIbxCI=;
        b=nEn+R8CIzLujWSFqHlAezAsUs6KNXMc8GyzuluhdeVW6b9vLC8BB1Jb16Okawl8YXY
         AFPtRcFUUfduZVTcRWB2lnIOrmcxop0b8X/riTlziCkTJxH6zRGa6gBRehyCv7yklGJX
         9mkM02xwqeGjdj0xjbmELb8bMjorjLAgTDBBqUkEbaTwoGm2Ba9UfPVAhhGvmiaLUOY/
         CT989jkbkPCjBL9fIntwJ8H8B174kBlyXUSxXX1IWmdfpOmSNi6oYNc0XvF04lyR3N6w
         IWkttVa0jxcmiVL+xzw0xBKIjeGBwktpB5RW/cfYcCDjGHtrf2tdcEv0XnlPn+GyX1ZX
         yTnQ==
X-Gm-Message-State: AOJu0YxzjycbJj7Bvy10ERk7gUJv54lLtH6tS3uJrqx7Vvut949uYAn/
	bFp3XesU4Lsbt8k8RvoRW/e34RkmoBq3RANOEA7bfVcSB83Qqa6fBLX8nGqZWBrCY1X58lSr5sF
	Kr7hh9g==
X-Gm-Gg: Acq92OH4MSvreTKzSkgHxR7I2CJjW46gacQk5QxdBv0L/4xQziQYHeVwj8I0k2wiDyB
	LLcANXrRVRQOazm9jhrM5285lHQ2ec+HcEAcYSPOBPB8nztCfFF0yvU0HO8Xn6qA6A+mV1A2sF9
	t0yLXr3arOSV4NDK+p0RE8/60SQCXAqHEvfPj7MvGUh4F2LCuSWIOHMSxwb9O/rteDNpa3V+3hk
	RRTkbS7FHe+AHg09zl8jWAhdyl3MhiMNl8p6c4LZF/zVqLX/gBWnojEbPqwS3dDanAz0JkMkOik
	LMhyalzlwP9nE3tCcG9zYihs8kZ8QhuOcPUN12qxARLJ2jL7oGkuWRC1NKJpsSXqgf2hV9709+K
	u5MC+bmIrK3eZ+kTUmZu6Svfl3c4M1IDPdkA8znHAWdVOz1b8MCP8mM/eAeLvylkPFj2xkDBhAW
	8XfwHrlfO7okyhCf49Fd4g1DFwNhGVY6M95t9XJvgrlB4y8qT6LcjBthTGXjbsOkC8oIXf/VdoA
	0xii2rtFHOY
X-Received: by 2002:a05:6402:1943:b0:674:2565:f27a with SMTP id 4fb4d7f45d1cf-68c8cb30c19mr2976888a12.19.1780222709558;
        Sun, 31 May 2026 03:18:29 -0700 (PDT)
Received: from great-eastern2.. (user-46-113-6-2.play-internet.pl. [46.113.6.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68ceb6f98f8sm974823a12.0.2026.05.31.03.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 03:18:29 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v2 1/2] advertising: add property with advertisement Instance
Date: Sun, 31 May 2026 12:17:53 +0200
Message-ID: <20260531101754.3325247-2-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260531101754.3325247-1-michal.dzik@streamunlimited.com>
References: <20260531101754.3325247-1-michal.dzik@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instance is an internal value, but it must be exposed to client app if
client app wants to use a advertisement in BAP broadcast.
---
 doc/org.bluez.LEAdvertisement.rst |  6 ++++++
 src/advertising.c                 | 13 ++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.LEAdvertisement.rst b/doc/org.bluez.LEAdvertisement.rst
index aae80f08f..dbfc5f0bc 100644
--- a/doc/org.bluez.LEAdvertisement.rst
+++ b/doc/org.bluez.LEAdvertisement.rst
@@ -235,3 +235,9 @@ The provided value is used only if the "CanSetTxPower" feature is enabled on the
 **org.bluez.LEAdvertisingManager(5)**.
 
 Values must be in range [-127 to +20], where units are in dBm.
+
+byte Instance [read-write, optional]
+``````````````````````````````````````
+
+Instance of the advertisement. Set by bluetoothd after advertisement is registered with
+**org.bluez.LEAdvertisingManager(5)**.
diff --git a/src/advertising.c b/src/advertising.c
index 8970e65f7..c8b00a887 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1390,8 +1390,19 @@ static void add_client_complete(struct btd_adv_client *client, uint8_t status)
 		queue_remove(client->manager->clients, client);
 		g_idle_add(client_free_idle_cb, client);
 
-	} else
+	} else {
+		DBusMessageIter iter;
+
+		/* Check if the attribute has the Instance property */
+		if (g_dbus_proxy_get_property(client->proxy, "Instance",
+								&iter)) {
+			g_dbus_proxy_set_property_basic(client->proxy,
+				"Instance", DBUS_TYPE_BYTE, &client->instance,
+				NULL, NULL, NULL);
+		}
+
 		reply = dbus_message_new_method_return(client->reg);
+	}
 
 	g_dbus_send_message(btd_get_dbus_connection(), reply);
 	dbus_message_unref(client->reg);
-- 
2.43.0

