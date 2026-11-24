Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534744;
	b=5sk4DTJzXWSOeAEsGRXlIaPw/VCZg8H/B5+H3rN82XZMjtMdkSQJ26a4yIu9PvlpF1R9
	 X+ExGXfNN2wYFTfITzFnhL41L0o8CXFwynHmDx7seRc8EQpobBdOYErWhC2mLNAYNhw2Q
	 Q4NGuUi3oNmC6fJpgYzjc7jsbKyiuXWTjOXe15AOXPCaSWa+qDER6pzbSUf71ZmNmxGYL
	 zB+ePClu0eXJNXM7Igj6E066x6xIqY1b4V2sXlXOHB/Y4WTmOOWc+QxbSzBqeZ6lcY7IF
	 Gq7qrErACzU5MQ0Mf+PUKC4m7EgxjJY0OdXYTXIYBmtbUkhjtxQy+sktoqFt0gRNnmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vAl/b7hMYAIDcmGXFZYO+BcVuKc9G5RZS9zq595xucY=;
	b=FRx+rddYS6ZkDGD3Wr+UN5QPJ8rtfbABwiNesb4Or4x1T8qQUxGlnNkhBqtzt0H9T/VV
	 8fqtwwVVVSrCTlrvyCItG83CPxUubYSqIJVtJ8bbTgOuM6F7/LsjL5HNXlVjK3gbhzHwx
	 Ig0cnJCt70dzDV2g9M6pFwmz67CzehwK7gGBzk+AJJFHljie/3O9kqNbq2lGdpmcjFcrN
	 imW1z4uvEf1NZLprTq6OkDEzJNoI8z2goSnOUTgSEVnjlQLlmzA12/zu5ojJ49Mv0YP9r
	 0w+zNLJq7pxzjXt54K93ltA+0CrztGn0u04W1BKR/ykLn1UrgxjUpr9I8rj/cs6H6iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I9ZZEhZA;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311F606A323
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1311F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I9ZZEhZA
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-98301b325c4so1214535241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534743; x=1796139543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vAl/b7hMYAIDcmGXFZYO+BcVuKc9G5RZS9zq595xucY=;
        b=I9ZZEhZACVZYX8m/dSN2mCFnCZ9idigHxJfxFZbJ77TUfM/uUSLiv+oHDVPYi1sopG
         ME8/8w/pSZGwdzxS5Su37NOXBKzSe9tT62V8klnb73H5AMyz8gMs6l+lthuxoyDZXT9+
         rZvawW3fq43JjEjSvLuX2otWVSwGf4VFdSzhb7T+OaWw8AOI6QLpwNLuP40AJ2X8T3hO
         tKMgUkR2wwoVDNe6xQkJmIlCtHEYYjqn3Ms7Ux4TWcUvEeTDoa7pQLZRRUxjVZWO+Ct5
         qtq1smeKkLsRXEGgXUNI7mrYLSp7lyVNmcVRZ8j8hNjKblrpC4AcnsEvhILbF2gNh1wp
         LQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534743; x=1796139543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vAl/b7hMYAIDcmGXFZYO+BcVuKc9G5RZS9zq595xucY=;
        b=fXbf8YNRDmW0xyT1SqzDWqBq6SevzD1sLfrH2qNtHCLKo1Wy4EquFPiP5n/xZ4qNO8
         UO3nTvHNGPinLG509Gmbp5ShKFjIaQpHG8p7C3qU7q8DWoWVE6wF/58j3v/HtJZ9Lkw1
         vz0j01BRShoc9HO53PtMCxKLJOAlM9BzYEyG/0WoepKmNBSRC2AWbhqyuVt2L1+2pGCH
         faXabn3uMe7VYOqk2UPC06GlZ/ImEYsLwZyxN7csjIfpGH82ni1mOMh3o7cfBvnk/90U
         T7aBiOmszmNrjjOU6H1/1Y0fPbi3z89MBUI++d8fotkYt5uMy+1vK5CTxnY5Vhvh8D9n
         cs+A==
X-Gm-Message-State: APuU4Z8rGrjgkLpc4hx6GDvSlTz8+7/+++aoTyxZTmh4Ch8Hnrh38kfL
	dI47g/ndzfEwx1ss7EkBd0ylaz6XEFLq3n6jJI4IUoumJhWQVCmk51KTRkSpTw==
X-Gm-Gg: AZFdTZdSCs8+01AmvdZdaTaIk3E4v6syV6AmdRvUwIMX7Ke6wFoboFbGwBKsbGJtetU
	7r4S/PfNHaLSEgGh89JG4Mt1blet2jGUQubS6A2hZpjUiXGytIPLQ5mVbarUriLWFL4fDBhJ7LZ
	/IRUqoLb2Twzb2CTfiFa7kmBE+fxZdeeOt4Yp5V94E6N5uiddvEDYmMBRADyfmX+9nTqEeZd0DL
	8veoFB9HZy8H3noQ2lsIRoNva9vxIrx8ZKqBB/iHUUU4xqmQvcOwvUjorSKimEoAGQJDNKEIf9K
	7kVv9i56uIB0Al1JjfFszKng4Y4+PlS3MlMg+ENwMYajgVTkJmMIWTGNZSa7UAeg1LHqo9L4OZk
	H2qWZy/msHaTyZtnPTsv4kac39yoiI/WnXbS3MtDYZA3WU3dKg88/jIXBj3mLUh68ZMRY0AaYN2
	Sxu9uCrKzHx/1D0L/PJV5jpDEk+bdiyLBYBMMm22VMnF9WxOqaBnnCs2IGv2pZjtyrFpdowL8O4
	CQvJlPXMeplVTV3bPGqiYKTXflydkYOWfDEsC1MourPVLs7onR3k9AuWmnjc7drCaL/gvEkzqn+
	fBcy93gOCWzsdcQPUzKS06anOZ7b6e1DQZaUPk+MiyAs8sqlz/YMfNgVvYD5hkkr0v7kN8CxM/S
	l5XEkgod74nn2GPgwVOdLdqIZ+W7QXbfRpT75gMl4nXxL8dOIB8O8QBe8JF90Qe+y4F9j9KAvf2
	ydMss=
X-Received: by 2002:a05:6122:328c:b0:5ea:389c:51fe with SMTP id 71dfb90a1353d-5ee8af32dd5mr7992329e0c.17.1795534742834;
        Tue, 24 Nov 2026 07:39:02 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5564a9sm14343463e0c.5.2026.11.24.07.39.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:39:02 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 04/18] shared/rap: Subscribe to Ranging Data when a measurement starts
Date: Tue, 24 Nov 2026 10:38:41 -0500
Message-ID: <20261124153856.216054-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124153856.216054-1-luiz.dentz@gmail.com>
References: <20261124153856.216054-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>

Reading RAS Features subscribed to Real-time Ranging Data whenever
On-demand ranging was not configured. The subscription also arms the
5 s first segment timer, and at connection time there is normally no
CS procedure running yet, so the timer fires and writes 0x0000 back to
the CCCD. The connection-time subscription therefore only adds an
enable and a disable write that no application asked for, and a test
that expects the IUT to enable Real-time Ranging Data only when told
to (RAP/REQ/RRD/BV-01-C) sees both. It also subscribed to nothing when
the peer does not support Real-time Ranging Data, although the RREQ
has to enable On-demand Ranging Data then (RAP v1.0 4.4.2).

Subscribe at connection time only for the configured On-demand mode.
When StartMeasurement() is called and SetRangingDataMode() has not
subscribed to either mode, subscribe to the configured one, using
On-demand if the peer lacks Real-time Ranging Data.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap.c |  6 ++++++
 src/shared/rap.c       | 28 +++++++++++++++++++++++++---
 src/shared/rap.h       |  5 +++++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index f1717d932eab..2d8b1a7a1364 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -843,6 +843,12 @@ bad_type:
 	if (settings.role == 0x02)
 		return dbus_message_new_method_return(msg);
 
+	/* Nothing is subscribed at connection time unless On-demand is
+	 * configured, so subscribe now if SetRangingDataMode() was not called.
+	 */
+	if (!bt_rap_ensure_ranging_data(data->rap))
+		DBG("Unable to subscribe to Ranging Data");
+
 	if (!bt_rap_start_measurement(data->hci_sm, data->conn_handle,
 							duration_secs))
 		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
diff --git a/src/shared/rap.c b/src/shared/rap.c
index 1c4b5239e1ba..bc6f133b5da9 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -4712,6 +4712,28 @@ bool bt_rap_set_ranging_data_mode(struct bt_rap *rap,
 	return rap_subscribe_ranging_data(rap, mode);
 }
 
+bool bt_rap_ensure_ranging_data(struct bt_rap *rap)
+{
+	enum bt_rap_ranging_data_mode mode;
+
+	if (!rap || !rap->client)
+		return false;
+
+	if (rap->realtime_notify_id || rap->ondemand_notify_id)
+		return true;
+
+	/* The RREQ has to enable one of the two (RAP v1.0 4.4). Real-time
+	 * Ranging Data is optional for the RRSP, so fall back to On-demand
+	 * when it is not supported (RAP v1.0 4.4.2).
+	 */
+	if (rap->ondemand_mode || !(rap->ras_features & 0x01))
+		mode = BT_RAP_RANGING_DATA_ONDEMAND;
+	else
+		mode = BT_RAP_RANGING_DATA_REALTIME;
+
+	return rap_subscribe_ranging_data(rap, mode);
+}
+
 static void read_ras_features(struct bt_rap *rap, bool success,
 			uint8_t att_ecode,
 			const uint8_t *value, uint16_t length,
@@ -4771,9 +4793,9 @@ static void read_ras_features(struct bt_rap *rap, bool success,
 		return;
 	}
 
-	if (!rap_subscribe_ranging_data(rap, rap->ondemand_mode ?
-				BT_RAP_RANGING_DATA_ONDEMAND :
-				BT_RAP_RANGING_DATA_REALTIME))
+	if (rap->ondemand_mode &&
+			!rap_subscribe_ranging_data(rap,
+					BT_RAP_RANGING_DATA_ONDEMAND))
 		DBG(rap, "Failed to subscribe to requested Ranging Data mode");
 }
 
diff --git a/src/shared/rap.h b/src/shared/rap.h
index af4fab057e97..7ee51143c0ef 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -322,6 +322,11 @@ bool bt_rap_set_ranging_data_mode(struct bt_rap *rap,
 			enum bt_rap_ranging_data_mode mode,
 			enum bt_rap_ranging_transport transport);
 
+/* Subscribe to the configured Ranging Data mode unless one is already
+ * subscribed, falling back to On-demand if the peer lacks Real-time.
+ */
+bool bt_rap_ensure_ranging_data(struct bt_rap *rap);
+
 /* Initiator role: stop receiving Real-time Ranging Data. The GATT client
  * disables the characteristic CCCD when this is its final subscription.
  */
-- 
2.56.0

