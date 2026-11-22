Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795344635;
	b=Ebo95iTWtIwTVgPeI1j9lG+VxAXq9xmdlavUgJLD2E0LgJ3c/hWUstv05hyX289hzjxX
	 d+VidT7Gu942UQeK+/DUA+oh/sYAu1el1mjYkmeqeDRzy0XAxYb8fjp+qHqyCCzorRDjc
	 eqL8l+243+KBe4u9TjpW5u+b6yayaaSERQLRON72lkMZg9XEnsJFIIz4udb+VlI0Tn3Uu
	 QS7mEpqldpUIJOYbjfXGgfQWWCV9Qm3BZtPIwd7eZQ6nx9HkxPPHNrymtV1MGiPMGTS6z
	 Ru6xxevi7htJIbeor9kBxI7m4S1LhCblqL91BCvclAeEG9ryGNKMxB4EBJHCjYse2pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795344635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9Gdgh9/HURZmqT/vmz3lgo52jcy8RCjBV1YiQb/mL/c=;
	b=fQi5UHpNovZpzV8BTFZ5Gf/TrSut3S4ZpRbAZ35WpRbht+eqR5CsilN+UJqzjRdEHoUJ
	 aqmLHgJ90A4/XrQ9AO7fpIDfwTjGbKfv2NIzKFH5A1bOFSZ/FbE2OwBGBpLyE5nMDnCpH
	 54ZXCQcg/g186P6CEdc3O5qdzfhD2JpAK98c/BrOeYczm2P36wN163vF12AJ/ua7w/FrG
	 TITpWo3hNWhtrJJhmjcyQr6HkHCcIxqzKF+bLaQZlf/h6Tp3gMgHMOlijUyWldZTzm2Qp
	 JqwIupeoVJz3QNgFWV8p32vqkPGebS9C+BYJA77JlCInQAl5GK4mTaEHrBW74McDRTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=W4u8IkNc;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD910606A333
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD910606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=W4u8IkNc
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-492f0a1b685so1609667f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795344633; x=1795949433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Gdgh9/HURZmqT/vmz3lgo52jcy8RCjBV1YiQb/mL/c=;
        b=W4u8IkNcIm76k9p50NbVz1mhks61agYV7NtQrR0Iu5RaAVB7J/Y7L7/Q/z24knoZew
         3P0Vu7kMkoWosgKOUjf9Wp6EC/pyeYde+SDUBr4tx2/6qe/PvS6WKt3oKOO/9+nYEp3o
         EeJS9RTVva20TI58f6idN8i/HJupiS6gwt6tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795344633; x=1795949433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Gdgh9/HURZmqT/vmz3lgo52jcy8RCjBV1YiQb/mL/c=;
        b=x52X8nYLvTs9t7KPP3ijweNeo0+i4Fs9jB4cc74Ivjda0sFwKWJHPtg7ljaRpOsNFu
         YgJH2uX3fqPjl6IvsGLhGiLIQHAkanPeDekBn1Z0H0YZ94F+kl+LXJ3tLeID3pO2NsRg
         Ein8r5pTW7j1huy782wYqgiflCRtOkOSfh4X4odZMS9ZgvevZmroYbDXP6K+svIJArSe
         jgsyycVY1OmF3qzRmrU+lNo95aWby1Xc269cc+PLvW47AmoudiO3ewM766mMQLSPGcBE
         XwHPz6DucxD735RvhWvsTZfGSD4WTe4jDqK/mSUACRxIleZClZIRp0xp5nwMPi0F6d/N
         X5HQ==
X-Gm-Message-State: APuU4Z+7ZAE8HWuDya+gRpBUTQhPHyk6keaAAIwVVKRjkYFAC5i4ssXU
	DUE+QvnRkrwLsCkAfOo7jOB1aLJOjXcHUvUss0GjuqYpYcji7PbdFoiIiSWO8CUffG6EsL/SXv0
	zUF1W
X-Gm-Gg: AZFdTZflUPeldUMGtQ22CCRv03+G9g4L88h/h9IeDSFNL0906itEap6TNJ90ZccypfL
	8g91F4GQ+ZUX2ET0L1duhsufwkfL5z2/KWvKpP0c2VcabaJ/A5zHj/B3aVqJ+dvGB43C92HHI50
	ShnV5CDofeGkW8oiI7jG8xhn7q0+OX4JR4YJ+e0hC8jN68kxxgxZ1YLw9FOa9AZG4Mots80IhBh
	0vUXbC3DRkoVgF93gY6Prbc3HBjfsxF8RsCgoeJAtGpo3d7mdWUDYCtwxIfs61jsTLeTSbzMlbj
	IyC3zQBf3HFWvqzL4thTXIPBPA0h86dkqOj1nwlvuq1MeLS3JXxylMgnXUMW+oH/Mb0GsyjOxsz
	rtq0f/t3bk+UWHJ7/PYEV6zbPsoSXp4r+oOJ0QaTzmnM8GQIpeN4B4n2UoWCsZzCKsz7DeBVvVl
	z5LENa0GFxjzGo6sCvkrG1ptHr2TnD1FUKkNSydQEgSmcsZkIa3dCJhOGXWvOTVfberZgQ+hAa4
	7LyeW/PSt8eFNjx925B/icX3MaMTImfBdYywpUDpjZLORX7aRaekaNQ/2Pt+/P1SQmi578Aw5to
	UTJ42n65lILrdvN05LjnzgaexjKUV8w+lOq0Z9NvM/yDEM8SpJs=
X-Received: by 2002:a05:600c:3b84:b0:4bb:6f45:2a6d with SMTP id 5b1f17b1804b1-4bb888074bbmr210387445e9.12.1795344633031;
        Sun, 22 Nov 2026 02:50:33 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm17959915f8f.24.2026.11.22.02.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:50:32 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/2] media: Signal SupportedUUIDs when the adapter's ISO settings change
Date: Sun, 22 Nov 2026 11:50:26 +0100
Message-ID: <20261122105026.753191-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122105026.753191-1-simon.mikuda@streamunlimited.com>
References: <20261122105026.753191-1-simon.mikuda@streamunlimited.com>
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
 profiles/audio/media.c | 22 ++++++++++++++++++++++
 profiles/audio/media.h |  1 +
 3 files changed, 24 insertions(+)

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
index 3433a7b6e..78eb0982f 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -3864,6 +3864,28 @@ int media_register(struct btd_adapter *btd_adapter)
 	return 0;
 }
 
+void media_settings_changed(struct btd_adapter *btd_adapter, uint32_t changed)
+{
+	GSList *l;
+
+	if (!(changed & (MGMT_SETTING_CIS_CENTRAL | MGMT_SETTING_CIS_PERIPHERAL |
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

