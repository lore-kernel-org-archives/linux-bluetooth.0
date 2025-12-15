Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C281830F933
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807338; cv=none; b=UxozKfCI8kkwQIWacwFMvbKnWqf+QJ8NnmPQR/g1jRKRe+5aDIlJauZ9K8jmFfaSWX9+1HNH1CuzCphXrMhDjrphCg1g4ReknMxpEY83L6+g/tjy3rGa4FZAofLXsq68zLiMnH97w6G9B0v7KZVBE6Z8/NU3yVIJ0w3bjpDQyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807338; c=relaxed/simple;
	bh=CZJFQ70QdeF/bBSt/+Kic5lE7MIkUQhfFPEe49SDPvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vyd7poPKPq2G33VGR7vInP5Me1cYD8Xkhx6sbdbwDFrYKtNKu9Fm9Z/t8l6879lXn6aJRPxYpav3Qm0aWacx3nT1vjCytbwN6PwjHw6pIP1Ew7Dg3Jfa7pUOUuLgfeh0e6ptl87OhesXDxlVK6g7ObighPLI2+GfWzPdpEyCcEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfUb/xvU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfUb/xvU"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b73a9592fb8so753187766b.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 06:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765807335; x=1766412135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbNRHrorTpP/+rQbRL0YbnQp+DJZYluazFEnrRrYArs=;
        b=RfUb/xvUGj0ydAdCCPlK8sXnZaUySKix5IhoQddeC06N/50K0MckjBUc/oRb52NPvi
         170mr4UKrnfafHyZ7bb0cD0m+esoHftMZb8RXZWNmJh0gsB2trCzpzLprEzRXnjfT/+l
         QeZVzDGF7CJZfMwawfvT92EAD6rh9hW/K1S4XrUDAoc6YkjWQsKH3virWdfrD1UsrmuF
         YimXl3GruiCuU3ljO4GCapfirEPyjdUWiobhESPl/bWbrUUU6nsyEQQAJk1y5Ktbu/nU
         alDHtsx+3VFg5kwudd0itk0iqka0RQg/H2cX3mpily/KALtoJVrCjBkHKb9nLB4WWfCx
         7iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765807335; x=1766412135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbNRHrorTpP/+rQbRL0YbnQp+DJZYluazFEnrRrYArs=;
        b=XtLDLZ7umYMBXE5dYe4/T/wR8xm0fI9oWM+MzKBciht4ScFbo3tas0d35fyXHFtWzC
         LeDctV5aumSNdktJTV5N1lIbqKy2IeiPGIrvzAsYcuE0IUxMcy6mgSsms2Dr4LarV4+L
         zMaPLjGaUV7dzUXvxMLRyJXnLrHd75Qe265VUdkPS3th2sN77owBEvkp5jiGUA9Mxh30
         HwXVVef+lEZj1ywub6GNQYijocYrjLtmbUMA8F24k+MjK8aCFwBwG1j7sEF/R16Qd+MA
         /YLIQFiH1NqM19LtOU0HU2UAMIvvnyquojhNOVX80wQj4lju+ytZpGhMsxog/Ivtcuxi
         nzuA==
X-Gm-Message-State: AOJu0YwbFQ1lxEjpkzg5nLpTqPIAqcP9FbEbBAivG2UYO+5z11sQ42oC
	DU92LNe7okxwH3IZRwGzPCLgeldGDAuvKF51YM9zhqynZcTuP/KAfreXqow2CgIY
X-Gm-Gg: AY/fxX5+nnM0v09VmEvEl7W3RDrdBiHPMXMjBuZAL+VvF6tA3FNp7zKEAt0eSI83KOZ
	tpljtoQ9tXF7N4TcHBs+XyX5uiRi85gqVYvESnem8NfWIdDHFz6evhciUnjt4wwA8reot1vnxy5
	9o0o3K1FqelsvUwSzvpfPsChaNHdV2L5cC04zi7ps/raZi/kV4c4HGO1WiIZ8Y51LFQasQ90gtm
	Kn0oENu0PpZoXS66PqQ+BU59I/z/6goy26ALjo9B1I7UdPUzIKx1IxhYS8mEvIRjN7lqR8J2Lpw
	Jnp7N6/YwoBeraZbfCudY2dPzQDljuWN+fNaLzEQWlhfblocVILNSXu06xkXMT+0/VXKuXkBqvo
	w17PmCRJxsvh+nmZE8uLYzVLUCpGM9O3iB1ta5MlgtZ0mWR5epdEju7BMPy0ut74kKALxfbFYXd
	wAdgTfmUjiqA5+zzwbs/d4lHS34j5wlnDxaDlvcz9EwayWPTVhrmcbHnPdHRMnUr0xfxN6UaZTi
	/C4RIPXRA==
X-Google-Smtp-Source: AGHT+IH4sfYXjc0mooENjByeCRlkIQfk0F1uLDB5qdU0zmnMx4qyxPNXB2/MbHaGwrdZxoMxc54Tmg==
X-Received: by 2002:a17:907:ca09:b0:b7d:27dd:9a54 with SMTP id a640c23a62f3a-b7d27ddeeebmr853814666b.31.1765807334386;
        Mon, 15 Dec 2025 06:02:14 -0800 (PST)
Received: from localhost.localdomain (46.205.203.157.nat.ftth.dynamic.t-mobile.pl. [46.205.203.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-649821316e4sm14374148a12.31.2025.12.15.06.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:02:13 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH] client/player: Refcount registered endpoints
Date: Mon, 15 Dec 2025 15:02:03 +0100
Message-ID: <20251215140203.638669-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case when more than one adapter is available on the host, the
endpoint is registered on all of these adapters. When unregistering
we need to keep track of registration count, otherwise we might free
the endpoint structure prematurely (on the first unregister reply)
which will cause SIGSEGV.
---
 client/player.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/client/player.c b/client/player.c
index b6b02a000..cedb07d65 100644
--- a/client/player.c
+++ b/client/player.c
@@ -127,6 +127,7 @@ struct endpoint {
 	struct codec_preset *codec_preset;
 	bool broadcast;
 	struct iovec *bcode;
+	unsigned int refcount;
 };
 
 static DBusConnection *dbus_conn;
@@ -3323,6 +3324,7 @@ static void register_endpoint_reply(DBusMessage *message, void *user_data)
 	}
 
 	bt_shell_printf("Endpoint %s registered\n", ep->path);
+	ep->refcount++;
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -3737,9 +3739,13 @@ static void unregister_endpoint_reply(DBusMessage *message, void *user_data)
 
 	bt_shell_printf("Endpoint %s unregistered\n", ep->path);
 
-	local_endpoints = g_list_remove(local_endpoints, ep);
-	g_dbus_unregister_interface(dbus_conn, ep->path,
-					BLUEZ_MEDIA_ENDPOINT_INTERFACE);
+	ep->refcount--;
+
+	if (ep->refcount == 0) {
+		local_endpoints = g_list_remove(local_endpoints, ep);
+		g_dbus_unregister_interface(dbus_conn, ep->path,
+					    BLUEZ_MEDIA_ENDPOINT_INTERFACE);
+	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
-- 
2.51.0

