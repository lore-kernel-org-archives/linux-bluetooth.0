Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795375805;
	b=SWlx1meKa2WDkcLN8TgLTcV8YLj2u1MS3dpbBuAkqtye5iAvhsKaDJqMKv5Vtz2u7Za8
	 BwJUDudOd5jkO3cI+1fJsFV2sWhe6TAzrlcD1CZzpVlCVk5eJYjBWMSDY6chGcrVnTYUW
	 BtMcCWKeAIJr5HtyVzOoo/59ZfS1CCU9YquwsFya4IVaypHHxQhRqAIblrIkXQ+005XjO
	 luHe4hHS9XBKDBTWVOqTNc8crpOCKORcYhyd3rhEklGUBrVM4JC+epUyuL8tFG1hXHDtm
	 IFvgW84uBvV4A3MweiNSFwNXSAwr3LV4Xm1Uh7qI+2qwT/C5Yy4kj+Sq0afm1oQsZyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+Pa6lsrAg+HmueYf9sXo3pJenWU5hwCU57CMQ3F4LLg=;
	b=1YRdwxrepXlHbIuTuBY7S9oiKcioDrnCvLm4uD4muZLQBHzlBxsbG+Ak3UQ7wPQOoWsM
	 sxuYLJu9gBv0t/hNfAVgVO0urTX62/wWWyZDZlvtEAZItZ+vLjlmvmccnWNW2Yuno+plo
	 +LeizSWwizBAk7ru/zXtxoVjEa45HvFmxIvY+N64tXiwEhr3f+ABVo1swEVg/NaPRBQW7
	 XX6TmeSGksMCXELaI8zyTbLrOdTevI3OQpJ14nSNKnIV7i9zlNZI9jDAO4X5u4Cg7tCI0
	 E/3wtpoklnjnp7FiITJum1er/lRcF2u7EqZp7A9+VA7Ia+nEFSKplp8gcrecLM0Yjhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=P3ZCQksw;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B39606A333
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 19:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99B39606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=P3ZCQksw
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so31432395e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795375802; x=1795980602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Pa6lsrAg+HmueYf9sXo3pJenWU5hwCU57CMQ3F4LLg=;
        b=P3ZCQkswKcTilYDZ1zyK3QAoolTuyqdPJUf3MYhPUff5puvTgXlAuRzjFAcQ+TKYuI
         8+klcmOi4KnFt4yQF778ArjcFMRk5Cl2NbP10aKjEECNkW7hnL86q+8ySKCF5PlwX17P
         0Z3iuxjI3VEh1UP+SdEXrslfmH/NtwZpU9Fgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795375802; x=1795980602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Pa6lsrAg+HmueYf9sXo3pJenWU5hwCU57CMQ3F4LLg=;
        b=oeC+w+raRv8MhIBQ3/oP3UFBcD/yG8Zcf9qBcR1tN4hbzXBm6Oh3vrxDnpzAHLlC0A
         5EpL29hXRJbeRVFcR1M+QqBbYa8+ULbN5uwo9SvBrh+edxqhZg9A8V5VJEDKicNclMKm
         97fpsELmsG24FAu+h2iy52KqMBZgbU6uMUDB0KfuX/DEEK4YxnVvqMfbD87ubzsXMzxA
         niw91+U5rar1Js0PUOXqLGFu4INFW4Co2Z1dEbDA1bHLQRV43djPvzZRKPE7FR5+D+Fh
         cLPabcFJ4dehJv7cJKg0ijJCZ4qZMnFj+cdmdogKUrQ78kSjmCg3CYDYtn1fQPzxq/ho
         kmmg==
X-Gm-Message-State: APuU4Z98k4V/ULRrcUiudCf5CBxowSE31MrmSdJZzDfatKEGIFIMyXWk
	L6IPjByuFhUZhVankNYkeHdD6OlssFVoV76hlSkR7TlyWXuQe0zj53GNTbVkyfoXfvwneXycfod
	IgYLu
X-Gm-Gg: AZFdTZcC1Uc8p+LJWCChCCMXPJMzoQ/7zFdReLvbDMCrECR1chwVIDeEPh5cip8y3c7
	16Pe2Y8kTtAdAtAFXJ5ZXC6By8elXtNh2UNO499XfsXHz28hqGSZeujgqHqrAzrBspyZfciA0S0
	mjemn7fOGmEqupmu27rk8GAS+GGML0dIu/r82aNSB7pulYpx02AtuKUJxxq47XxIQ7huVSnXD9Z
	vkpa3Q0SWtEJwB7I+YkqEt3pRQQkBdQZwPKv4W1Gzex+xzGgk1izqgGYTg1FR6YitUzuieYF5Ya
	eDV0WrdyexZytwxbaNvodpBGkvV63zJtus2XJ6jSNLSgv2abtcmWu7h9irRwcRg5hhvihWp+PJk
	TLoc+E2blr/KtMP7qSq/eoxiSN9FcHnCtu/ByYEYXxkoNTF4RypmBWcBL+kU3qxLj3tQUJUdk/f
	YHXqWhU08nmZSsSD8H+CBiqY2U9nlRhbvno/V8az0jtqbF5Xw6L3E7Qt6ZTrRo9FiZHL2+ymEeT
	xNx9mdiMoF/RSc5hJXE/sa0Zi9BwSY8oyjbfxywGRCvZhqOoMFjJHP95a2DUqBsNA5WOsQbUiXi
	VHOgQ8KMRPSmKUyVAxV7QAsf93HJDRckMTgWGbwCQlsKAD74nQ==
X-Received: by 2002:a05:600c:8486:b0:4a6:4d6b:a840 with SMTP id 5b1f17b1804b1-4bb88819468mr200073235e9.31.1795375802616;
        Sun, 22 Nov 2026 11:30:02 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8d4f9aa8sm238371825e9.4.2026.11.22.11.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:30:02 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 2/2] media: Signal SupportedUUIDs when the ISO settings change
Date: Sun, 22 Nov 2026 20:29:55 +0100
Message-ID: <20261122192955.2329174-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122192955.2329174-1-simon.mikuda@streamunlimited.com>
References: <20261122192955.2329174-1-simon.mikuda@streamunlimited.com>
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

Media1.SupportedUUIDs lists the LE Audio endpoints only when the
adapter has the CIS or ISO broadcast settings, which the kernel sets
once the controller is up. An adapter registered before that, such as
a USB controller that finishes loading its firmware after bluetoothd
started, first lists none, and no PropertiesChanged followed when the
settings came on. PipeWire then registered its A2DP endpoints only, and
the adapter had no LE Audio until PipeWire was restarted.

Signal SupportedUUIDs from the media driver's settings_changed callback
when a CIS or ISO broadcast setting changes.

Fixes: f2a29899297a ("media: Check adapter CIS support to add BAP in SupportedUUIDs")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/a2dp.c  |  1 +
 profiles/audio/media.c | 23 +++++++++++++++++++++++
 profiles/audio/media.h |  1 +
 3 files changed, 25 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 3b29ec204..3eb3e3bfd 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -3893,6 +3893,7 @@ static struct btd_adapter_driver media_driver = {
 	.name		= "media",
 	.probe		= media_server_probe,
 	.remove		= media_server_remove,
+	.settings_changed	= media_settings_changed,
 };
 
 static int a2dp_init(void)
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 3433a7b6e..13fead886 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -3864,6 +3864,29 @@ int media_register(struct btd_adapter *btd_adapter)
 	return 0;
 }
 
+void media_settings_changed(struct btd_adapter *btd_adapter, uint32_t changed)
+{
+	GSList *l;
+
+	if (!(changed & (MGMT_SETTING_CIS_CENTRAL |
+				MGMT_SETTING_CIS_PERIPHERAL |
+				MGMT_SETTING_ISO_BROADCASTER |
+				MGMT_SETTING_ISO_SYNC_RECEIVER)))
+		return;
+
+	for (l = adapters; l; l = l->next) {
+		struct media_adapter *adapter = l->data;
+
+		if (adapter->btd_adapter == btd_adapter) {
+			g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						adapter_get_path(btd_adapter),
+						MEDIA_INTERFACE,
+						"SupportedUUIDs");
+			return;
+		}
+	}
+}
+
 void media_unregister(struct btd_adapter *btd_adapter)
 {
 	GSList *l;
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index a84634fff..eb95a8b06 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -17,6 +17,7 @@ typedef void (*media_endpoint_cb_t) (struct media_endpoint *endpoint,
 
 int media_register(struct btd_adapter *btd_adapter);
 void media_unregister(struct btd_adapter *btd_adapter);
+void media_settings_changed(struct btd_adapter *btd_adapter, uint32_t changed);
 
 #ifdef HAVE_A2DP
 struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint);
-- 
2.43.0

