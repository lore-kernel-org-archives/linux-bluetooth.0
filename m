Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526412;
	b=hHTUwZtcc4OBqVvmLHDopJ2yByt8X0Sc+XK7iCiccVtl8dt3qYdyUle8Ab89HuxT3ecd
	 NIU06Y70qVmiDwtH/jLNXbG8bmf2B6pm9H66gMabjxFlqOGC4oOp4kJbS4bOzxRBgoniq
	 YknFnIj6GlKVaVExTNLbi6KMn5qgFm+4afdHn3E/dLN03ZuCBrrOoSYat7vOVOuSENqkL
	 Gv5SYqyz0HI7/fTjv4em4ciQqu1c2bZYCsP1ZPush5QQVyyr982CaPyIKlHFIFKm2Olpz
	 TIJfDEj+2stnAF6XQfkFwosD7+xQ5ciKYPbgnnpanf/rTGL17j95cZ1XdyTrWOH0POw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4NhLCsyM7AEyj3ui997kE4c1tel5BAKPR/TxNBzzPcg=;
	b=WaL8wsseXTqRxBsubNrQlqersaOvfcUYxGH3Lno397YxwzfnrSKy08cJwAbc1cy7QLgT
	 LSF2dT1y3+encHxe/bvVyTDa5ih6flXjS7GkxXROKkaMjKWhdUM8A/pAbaILGHv6ywEd4
	 BcK0SlkZ/0InjoBLuWxbs2BtT47lvA25IeNI5mfnk9IaWi+xLJzMFqu1O43YO+IzY5mEj
	 YsqP3bcAJt0GnCEavhGfsg2TDuH017iW5UutCAW7kRNVDp/2P6HfLi7sYCfRNkG4vokfQ
	 RUdCDQXc0xps3j8DXeA/MALZSnUAwXv+be1EVhVL+GY8IKF67/+pgByQxASSzkctOPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=tdtxU94m;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A54606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9A54606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=tdtxU94m
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so37711545e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 05:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795526410; x=1796131210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4NhLCsyM7AEyj3ui997kE4c1tel5BAKPR/TxNBzzPcg=;
        b=tdtxU94mKeqirXXUAH4fVZYNmpRr+dPhk2DU1ozHXWm75NAYqkZfwLnW0+ucX3sGmf
         2C0ZU9rvjuHxOOG9i4Og/potuYbIfCLPhiEJa1Dy2gAVCg6X1/hZcrYhZ1pav7p/ftb5
         AEtEfIbzVCikauld1LdwteDQdtRDGvAloLR+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526410; x=1796131210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4NhLCsyM7AEyj3ui997kE4c1tel5BAKPR/TxNBzzPcg=;
        b=PjRidVzX940N39SQ2f24d9wV3sbRkLnpJHs6GD3HOWO/8Pt9WgWHjQlvS5KIVhMqqt
         LbDYUyS/OyG+ZSOrFqIe8RnNVJ5UwGDAQEBvSK8nz7FLA8GMF8lvo9VP9dGr88JN9gla
         5hF0LsHllDd1E4WgEzUDgrxz0O6RH0TJ24oEalupiIu77cJHEwAyLhQT4HayB7EX7dXh
         wDS+k9GxZKD6GTb1DeM7OJJvQGmafuTWEtPDHzdq3PVvVCy0X93IGuFJBN7CCM6FDDxz
         9kLYpw9HV2DVkQGf++9bi1qDMtV+g8K+00TsweBozFa9FPBJGIRxN3GxuZJs/JJx5H6K
         TL6Q==
X-Gm-Message-State: APuU4Z8HFpiyk3ZqVxVAJaIyTfUuo51zp/RwwsuepA1vKF/jWdFI4HBp
	IYi5xJ+Stx7eYJYl1/aohc/9iOmCEqlSw/xiiFVHeNQ44pJaSZ1eRHjnl8N+EMpwiNlmT3laZX1
	OBp+d
X-Gm-Gg: AZFdTZfDrzSNEd3cxJFTtoPm79FXbbhURVWbKcyIhy81r34YpgxhsrScZzGnWb4ThQX
	5cLGJ5SeqVnyVEfmvAazkX8kRbQ4M0rCNtVD8IGh79vTWr3Xk3SOikkOMbcFWVcoY+z5lBcPZom
	OWz1PjqUhvqMgrTcOUGfNriV9jXvgDmNkDJzSCdqlKGZr2ldfZEqsBHHvI0HqhnSApzST3ObBRW
	gdy2BAeA875RK8VPezDVS4GZUxdhR5p9c+GIAg/pMtskoDY13WDmJe/EPEmbsWGaW/Fx+Xmoa5/
	GG1J0hxCTflZ+0I5t/SdzjRRW5POSGnBRjJxcq6z3H4mNiqUgxLdAGsDSSDK9tAKIzWGJx11b/x
	yQRQkmpo/l7h90296QVfsBsCoWeRAuPQubKCPo/6iI6HKpjU/twSdzt0mMubUPzA3PVQHFIdt67
	fnoX3hwWBCKUh/a2Qe3VJwNyMZSfibjacNJMKCkz1zQ+gwr0/by1QlqOSCrTyLTS32EbmYwaXV/
	4ssYa3yqoN7TSyw27JmRhNZtPLO8vxvrujAy9oKrtFOcjikgIU9bA1dyYl1OF6R+kifZ/NMopk+
	Iu42TS9ffuTUYvgpgmKO7Ud3V3lE0Zn8HB8Y67eVeHljJinFvg==
X-Received: by 2002:a05:600c:638e:b0:4bb:6c5e:b006 with SMTP id 5b1f17b1804b1-4bb887e265fmr278162435e9.3.1795526410149;
        Tue, 24 Nov 2026 05:20:10 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067846esm270963015e9.4.2026.11.24.05.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:20:09 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 4/4] client/player: Add transport.mute command
Date: Tue, 24 Nov 2026 14:20:03 +0100
Message-ID: <20261124132003.3899120-4-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124132003.3899120-1-simon.mikuda@streamunlimited.com>
References: <20261124132003.3899120-1-simon.mikuda@streamunlimited.com>
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

Get or set the Mute property of a transport, like transport.volume.

Assisted-by: Claude:claude-opus-5-5
---
 client/player.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/client/player.c b/client/player.c
index 932338ef5..591c73a62 100644
--- a/client/player.c
+++ b/client/player.c
@@ -6160,6 +6160,54 @@ static void cmd_volume_transport(int argc, char *argv[])
 	}
 }
 
+static void mute_callback(const DBusError *error, void *user_data)
+{
+	if (dbus_error_is_set(error)) {
+		bt_shell_printf("Failed to set Mute: %s\n", error->name);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Changing Mute succeeded\n");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_mute_transport(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+	dbus_bool_t mute;
+
+	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
+					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Transport %s not found\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (argc == 2) {
+		print_property(proxy, "Mute");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!strcasecmp(argv[2], "on") || !strcasecmp(argv[2], "yes") ||
+				!strcmp(argv[2], "1"))
+		mute = TRUE;
+	else if (!strcasecmp(argv[2], "off") || !strcasecmp(argv[2], "no") ||
+				!strcmp(argv[2], "0"))
+		mute = FALSE;
+	else {
+		bt_shell_printf("Invalid argument: %s\n", argv[2]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!g_dbus_proxy_set_property_basic(proxy, "Mute", DBUS_TYPE_BOOLEAN,
+						&mute, mute_callback,
+						NULL, NULL)) {
+		bt_shell_printf("Failed to set mute\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static void set_metadata_cb(const DBusError *error, void *user_data)
 {
 	if (dbus_error_is_set(error)) {
@@ -6278,6 +6326,9 @@ static const struct bt_shell_menu transport_menu = {
 	{ "volume",      "<transport> [value]",	cmd_volume_transport,
 						"Get/Set transport volume",
 						transport_generator },
+	{ "mute",        "<transport> [on/off]", cmd_mute_transport,
+						"Get/Set transport mute",
+						transport_generator },
 	{ "select",      "<transport> [transport1...]", cmd_select_transport,
 						"Select Transport",
 						transport_generator },
-- 
2.43.0

