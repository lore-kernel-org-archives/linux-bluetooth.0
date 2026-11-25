Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625954;
	b=eB9bKALbBZ1HrDjm3F2v9aDwzjDCXRgzFow+rXq0fKRZOoG1qsdPC6fXaAT12FiG6sEK
	 uDf97Ciqag7+I1WluYoqMHcmU6FUI09P90rWdSURsoT6/K0XmT7lrQTBBph6ZhNAMQACM
	 36E7NYleF7YCWzb0DAhuflnfDJ2qt+rgk5otcqKDiG1obqsBQpUpNhdJ9uxUEH3F0U/LD
	 /cDh2jpGH1V5EPIfcj9G+Ip5fItXSSe69c5FoX4Tdb46DpypCXe5JKXeiG4IP6sb1CZzs
	 4n/6pdAgy5WsLUjkFY1jQLzJ/PFXNMu5SDoDNhDhp8k9j1cf0tieSo1OQVaNinW+Rfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k7931+pByh+fm0RROpVCeoCKV9LNxZUw1ZYe/Wt/HJQ=;
	b=E2CuEMT51w1aFQ5e2McNxj6O9fCdq+bJ01IjTIaRVqWjOV6h6DBq0C35rOjIz2c5vtlG
	 zxuZWEoSNQ3xaoyErB3KYi4iGpZ7JWdSLz4HzFgGCK9ig+bsBv/y1W94V7jyQ5tyyjVnp
	 W+rZ+Ymgeu8M5kvyn5ZRMrf78yFAPZvE7R518oELDgHBx7EiHCB3cVT/PPSRwKZBLKz+e
	 YICP1qOIKTfYNtN3lTW6sCMiGT4Xcqntbg/+/uR+JAVA3Mb/EeJe1jKipL9xUjhaxyeI5
	 1pR46e2hD0Uizu5a7pN7QSX1I/qxbECSANrrSfZhTrkAUgTMGewkGJ7w8g0aFKOW3hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=fq35ug3g;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB525606A32C
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB525606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=fq35ug3g
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso57537345e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795625952; x=1796230752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k7931+pByh+fm0RROpVCeoCKV9LNxZUw1ZYe/Wt/HJQ=;
        b=fq35ug3gxmxz8S6uPQZ/1+pEO8iXDD6viNxnrt1H3swyI5muY3ZbltwVeXPJlhi1hg
         9QBnq58jBN8m2upmBzBnwcyveNSo9vw3kTDM6e29OkjRQ0suzcBoGh5H7HKpb8XpUAjn
         2i/M6K32kGC1gF2AjVzp6xx/OFnPYEOAfitis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625952; x=1796230752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k7931+pByh+fm0RROpVCeoCKV9LNxZUw1ZYe/Wt/HJQ=;
        b=xfC2skljDxhHxLjEVzVLARX2NH+n+oOetBoZsGxMmJIsmhTotJ6PtBEpJsnruLCmqV
         yx3V7NdaiCE0entK5I8RstUjenA5SROq6aqa2E59jO81N8XHtREY7hwrvolJp/1EhbwK
         DgqVueAXAOJdkEKAoiN5Vmz9D2rBj5e+wgPf5LKNFtUROPKGRYPQlCG3LShe4ceAkR4c
         hewIntnCk5gdwi/Wn+yvW44IhYC4Gq7lTjNg0lxCXxUjqAPDA2vki7zzoBiVk0p2P38L
         nST6zLwP9s7em2XtF6BS8JbD+Cjnjj+k0myB0vwvpTSLcoHFjY8EKMHRKfIZOaw6UTJe
         8niw==
X-Gm-Message-State: APuU4Z/0GWOkY0g95Eh32ot8VLDnpcZE+VOwMftCCTABGmHrtqesVNF9
	MlzrJ8PRluK5blo1BFT/qFm7VAXe8MaBbNCOuuUMEgL41TZPRPJ1M9AIHzbwfFMvxK98mDZa2nm
	Pzlj9
X-Gm-Gg: AZFdTZdexZUqwtSC1O4XxSkMUFVw3QUagQY4uSqCSq4RLo+BGwtUOpvwQ6kRahstOLY
	bdMUs6XsOqWUt1Glwhf7CQMKaZo+BVAqBKwAWpI60fwPh/3n00nXLidkY+TkPnzm9S3TyBXDfgM
	kVKScmOkXOP60glREkg8qf2OYEO1ZxIxO614uV7YW/F0jCwnBWaxjoymantCaVxQNsP1q23JGF4
	ZrXoQO2rTL9vha9aaAH8t9Qy5w4znxKwKwSe/4N8pLG/4r3aQIZ84iFl+gD86i68eRAk7bvtY6l
	S9w9lPlDM6pt+GYgev7fpPIpxdkG8g0FGENCcKo0anEi9ITNXMlaK1Z/QLiH8znh0gChLTTBsae
	90jfi0NRcKWjLOvnw7cEXVOOBBHrpJo1feRKlN06TyXbL5Ti29rurwgFO5U8FTMDVbm8qeXmBos
	y+RZFc7Kayk2S6q6UDfVCuI+FxiMAKVo6pzgm9RGxaid0+PgH2es21xXF6yvT1hvsRyOHoPnDGX
	RQ8uVyiCZ7KE1KrKCqGEokQu62tKzLx66+Gn3RgAkUAnv1i+gfOZu8ahd3jyRxliN70XLURoeTz
	5Dxbq9X+oitwz+lrFv9gVl5tIf9+j5hIQ8NreYv8CxVo9MjCQ1J6qUvM4vUwL4qPxc5pwyw=
X-Received: by 2002:a05:600c:310f:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4bb8881f9b7mr400385565e9.34.1795625952248;
        Wed, 25 Nov 2026 08:59:12 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm754943945e9.13.2026.11.25.08.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:59:11 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 7/8] device: Don't accept LE profiles over ATT on BR/EDR
Date: Wed, 25 Nov 2026 17:59:05 +0100
Message-ID: <20261125165906.1645581-8-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125165906.1645581-1-simon.mikuda@streamunlimited.com>
References: <20261125165906.1645581-1-simon.mikuda@streamunlimited.com>
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

When ATT runs over BR/EDR, every profile accepts the GATT services found
on it, LE only ones included: BAP reads the PACs, VCP, MCP and BASS
attach, MCP creates a player and RAP a ChannelSounding1 interface for a
device without an LE link.

Skip the profiles of the LE bearer when ATT runs over BR/EDR.

Assisted-by: Claude:claude-opus-5-5
---
 src/device.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7a85403f0..8508fed81 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4806,6 +4806,19 @@ static bool device_match_profile(struct btd_device *device,
 	return true;
 }
 
+static void device_accept_gatt_service(struct btd_device *device,
+						struct btd_service *service)
+{
+	struct btd_profile *profile = btd_service_get_profile(service);
+
+	/* A profile of the LE bearer doesn't run over ATT on BR/EDR */
+	if (profile->bearer == BTD_PROFILE_BEARER_LE &&
+			bt_att_get_link_type(device->att) == BT_ATT_BREDR)
+		return;
+
+	service_accept(service, btd_device_is_initiator(device));
+}
+
 static void add_gatt_service(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct btd_device *device = user_data;
@@ -4845,7 +4858,7 @@ done:
 	}
 
 	/* Notify driver about the new connection */
-	service_accept(service, btd_device_is_initiator(device));
+	device_accept_gatt_service(device, service);
 }
 
 
@@ -4907,17 +4920,16 @@ static void device_add_gatt_services(struct btd_device *device)
 static void device_accept_gatt_profiles(struct btd_device *device)
 {
 	GSList *l;
-	bool initiator = btd_device_is_initiator(device);
 	GSList *services;
 
-	DBG("initiator %s", initiator ? "true" : "false");
+	DBG("initiator %s", btd_device_is_initiator(device) ? "true" : "false");
 
 	/* Accept in profile priority order */
 	services = g_slist_copy(device->services);
 	services = btd_profile_sort_list(services, get_service_profile, NULL);
 
 	for (l = services; l != NULL; l = g_slist_next(l))
-		service_accept(l->data, initiator);
+		device_accept_gatt_service(device, l->data);
 
 	g_slist_free(services);
 }
-- 
2.43.0

