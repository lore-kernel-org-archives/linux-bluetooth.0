Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793077932;
	b=JYDQY8F8l0IlX1fja99q4uLPUdeBaouzqbGTQkhOOtoiSk/Y8dvkeZRJnky/+bjU6UL4
	 DQjueaGjkU9Q0kMnfcsSNUUEw5k4UFiZMwFmxra4ZOI6CDt8K7JO/odtFqrofzT8NoDlo
	 9d2PxyEcbuRgWHPLxAn/OEX9N9d4qf1+nOzotsK3VaZM2R2eZFt98KSnZQ2+XuJhJF71X
	 6PwrpQpYHFmUQgzF3H/3yWIhNCx3YAjlOpubvoeeUP4VX98cK6LoAqm6oZ02zZMs8XtLS
	 cht+wqCLZKxH+1VKzk/xC3C7NPezyZNwIJkchWp0W4qlCUFHA+2Ik95D9PHUD1+OJNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793077932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DDC6E10EfEydyVw1LBoKyG+x83QvpFDQkS+xhhY+5v4=;
	b=KHITUiUFjve3U8Xy+DDkeSCijkN3fZoyN6R1Q1+65ebo7FAIrqorbxJ22fLudNJ/XEwd
	 Ib/6MFNFp7bZEN4bCbD/3erJht3dVeS7RqnKqfTLRKJqpjCtsVpd8tdmCRnRBEJiirgcm
	 UwAtAaQqKECx19Cap3uyDB90ccEnYw4Br8DY0oplUzaY9vhGT/XB83XphMG98rvmhdnvh
	 lo+fca+n4UbwUmKKeFTCiXoZkL1hGUooU8hHDM//pV467kFjuAV18Sj9TMPYQGadeW1z3
	 vJiOabUzVHW0tuVw0ZlmmEMW+4DVxeoqxTy4hzVlQ765L/ZXHRPPS8eKJzaSS/krkww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=KMm1YvEW;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC71F606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 05:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC71F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=KMm1YvEW
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1438d9363fbso606537c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 22:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793077931; x=1793682731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DDC6E10EfEydyVw1LBoKyG+x83QvpFDQkS+xhhY+5v4=;
        b=KMm1YvEW9L3//ya+R3bdjboe2+cj3SAKPonpTbcGR/ExCxur1gC5EM2fgADtpJJ/8I
         GDaJI2iTq/eGLppqYfkZh7+GBlZoQ6qQNtr6mSQuIyOLmTvFMMyQJtVzXnx4M7eIi4N+
         hFgNnGaPl+DJ+dpwns1vNpU8DhdgwZbfGFJkv8EDlax4TC+UAKCxCaKvjLuVqbg/KHYb
         DlAS826ihvAnyBORqCSSGLy6J7MGJJP8yRt8AfdZAInB4r7HTN5xGZIfsAQMdiNmsMI/
         Zz4aH1CrBFttyFghs1Db/r9aSATsXpU8PTAVPZD81AgkrikZ4xQSmDkc0j9Em3k1fADR
         056w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793077931; x=1793682731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DDC6E10EfEydyVw1LBoKyG+x83QvpFDQkS+xhhY+5v4=;
        b=YDupMDanUPGlB1E7vY/5HMdt1cJbsMscMz3fMagA6Y5rKcn4ozyoYNA6htI6Id0C+c
         kmsyjQTdxJHur5cjfVSLGIoSHzdb6OFfWIAqcByv7PRdPEk4ec5UDty2RWeE9Q+VGVL5
         50c4O7igEARXh8cds5hyT/TOCPwWRqhF9r3qFGsmRT7xMZa3aPk4w6mQAi/juJcFHlUB
         AttXNqidu0RdAXDP7ow/tU5HYJqq+d32DVdTEn6X5dcErmK0BXeXGOeuJZirJdDWsBAt
         5rpvcMvyt5FfDheeUxX2Vwy+A5/Nt+3VZSFZ6KFI+7QZBlDd+0VTZfJjYr/UaojUsbwQ
         FQPA==
X-Gm-Message-State: AFq9FYIdDHdTUHE32cDbbUld+8PrDGCkc7MU7QUnR2+MHQErI84v/Om/
	GzrFSElFIhgOZtzQMrWQd+aLKBKwkH3ScWwRO9JNrhPOewaEzyUZ9+awWgoKyOg51tIuvSiUVaM
	nKLt0yj8=
X-Gm-Gg: AYBFou2JWpb9azc8OcNKsSkAr+vnKV6x9oRGbNYq5jmMWdHp4eNUB3tmrt7GaoEKlNO
	q3zxROIFxMoD7bjkMDIK0Kb+wPSyvUAloY7Vu9UbqX2UkBiANT4V0mgeUTSbm4p2aTrPZu94P2l
	A7M4YZGWrACxXJjSesn0HCRB8G5eiGpE+euaZcRwK2yHfjC6Kfb8G+lrtj043gQorUvNdQDKAWj
	CItMHtCF3wpdh4+EKM5unJs2kF2lFmCzgQ92KqU6wOtbi/FyCkoyrlJKbmSyvkO2Z/koUJ5wZM4
	U4R2MXRoSl5YigKZzuc+QcIBKT9HLE7RsrOfo0Gxsqfb5YHlFPOshbCe9woIvsj/Nf8DZZRzINI
	PjNFBAL9Z/Uy8c3wwMXEC1NWUyE6QftqhnlxM2dEAfJLrbOpjvYBOIi05zdF1l3XutLbtNH/fZ5
	NEzqiNxqOccoJWZQJW6EMTiZvwb1wt8DehOvhIhrn15H9BeUzdID1NSiWapFyaIIR6/5NpgKkRS
	jklPeFWQbSdjyLcRnop/BrZpy+XOcIFoqb+1NHf0GZ1I+fpuA6yIh6AB0/cm/DB1G+8VdYTqb9G
	B+9ZvERtKT+sagcZgOK5QjnhGu3houkzRN+1hcX9xSRgNOf1gphGi0lBpBog33Jgv46o9oh9p4Z
	HdRsXb9hikQj2KCbzRC4z2w==
X-Received: by 2002:a05:701b:204f:10b0:151:7831:e403 with SMTP id a92af1059eb24-1a3c48541a6mr2223759c88.13.1793077930674;
        Mon, 26 Oct 2026 22:12:10 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaf25sm30406607c88.14.2026.10.26.22.12.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 22:12:10 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ] advertising: Fix leaking clients that exit while registering
Date: Mon, 26 Oct 2026 22:12:06 -0700
Message-ID: <20261027051206.92829-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
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

RegisterAdvertisement allocates an instance and adds the client to the
list ActiveInstances counts, but only watches for the client
disconnecting once the advertisement has been added. A client that goes
away before that, for example one that never answers GetAll on its
advertisement object, is never removed, and its instance stays
allocated until bluetoothd restarts. Once all instances have leaked,
every registration fails with "Maximum advertisements reached".

Watch for the disconnection when registering instead, and clear the
watch on the registration failure paths, which free the client from an
idle callback.

Closes: https://github.com/bluez/bluez/issues/969
Fixes: cf99200d1505 ("core/advertising: Implement RegisterAdvertisement")
Assisted-by: Claude:claude-opus-5.5
---
Reproduced with a functional test that kills a client while it is
registering an advertisement: on master, ActiveInstances stays at 1
after the client exits (3 of 3 runs); with this patch it goes back to 0
(5 of 5). I can send the test as well if you want it.

 src/advertising.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 1ed09c902..5c929d6c2 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1388,6 +1388,7 @@ static void add_client_complete(struct btd_adv_client *client, uint8_t status)
 		reply = btd_error_failed(client->reg,
 					"Failed to register advertisement");
 		queue_remove(client->manager->clients, client);
+		g_dbus_client_set_disconnect_watch(client->client, NULL, NULL);
 		g_idle_add(client_free_idle_cb, client);
 
 	} else {
@@ -1427,8 +1428,6 @@ static void add_adv_callback(uint8_t status, uint16_t length,
 
 	client->instance = rp->instance;
 
-	g_dbus_client_set_disconnect_watch(client->client, client_disconnect_cb,
-									client);
 	DBG("Advertisement registered: %s", client->path);
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
@@ -1641,6 +1640,7 @@ static void client_proxy_added(GDBusProxy *proxy, void *data)
 
 	/* Failed to publish for some reason, remove. */
 	queue_remove(client->manager->clients, client);
+	g_dbus_client_set_disconnect_watch(client->client, NULL, NULL);
 
 	g_idle_add(client_free_idle_cb, client);
 
@@ -1757,6 +1757,9 @@ static DBusMessage *register_advertisement(DBusConnection *conn,
 
 	queue_push_tail(manager->clients, client);
 
+	g_dbus_client_set_disconnect_watch(client->client, client_disconnect_cb,
+									client);
+
 	return NULL;
 }
 

base-commit: b0bf49270d445da0852851f393cd67a0a1e5f05e
-- 
2.54.0 (Apple Git-157)

