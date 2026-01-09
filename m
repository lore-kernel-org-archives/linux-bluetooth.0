Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F8B500969
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767990601; cv=none; b=FMabeXYcziojTTcUVzkdhFQqCesdg26bzMKXW8TPLgSxbSUqx+/LI2oXASNgJU82/tg2CLn4JuEIE4amqTp7Mb7u/MGU7Enm5zJb8PaggkAIgMb/kp7DZ+0NDH/Qvr4t5yawMKGp/FWa8p0Bgqjjpym25OerxmwUuBs6dK3jsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767990601; c=relaxed/simple;
	bh=REAZBVbrO1FwI080cNyaQYjsl8kxqEa4NqmGcUm5Ljw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NB9IL5OR3A4dAGOuOJ5pzOE7DnZrKuX4vLJ2PnRmLSzt4sm/q5HOdgXEJa69Fk1UUSdy34n9O3P7eIcUCgSGJpt/h+HUs+Muy0BH3YXgwdAyybzzoCuTUjpXklqxUYG77R0Wyr8Z0Kn8XIRu8tzFORsAgNj2gzPvM6Rm2m1kMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOL8V5Pr; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOL8V5Pr"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so917115266b.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jan 2026 12:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767990598; x=1768595398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2HH/HvrY8SenmCg+1YYwB0PKYGe0iuypcbG2EIkYmk=;
        b=KOL8V5Prc/IHP85+qtMu/K7/xS/cyTaQql6DjG5tu9S94/DiZPn2Gil7xZUBB6x41V
         lTKtiVzOu4/oO368OkkmrfGuAaLNeA4yWm4NnHmqXbknA+PvZoAUN4UmapSHoGO/GaYb
         5k+WFf88Sq7BcTyLMzEvCjibqmFiKtB8/9TcvueLDuU6692cOrLB4PMPWESnOO6LeOj+
         lxwMkaGyTA0KRo0rTzGleJiYkRO/byQQVskx+FMfOYiSGeOpUZtZ9eYeSHxSqhiiAKCN
         VUUVDD5bWDce7YTr/sA0k5vxI51LZHuYzUFQK75nAZMSvbTyKUCmWmVJanTccGIjYsYh
         QU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767990598; x=1768595398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b2HH/HvrY8SenmCg+1YYwB0PKYGe0iuypcbG2EIkYmk=;
        b=Q6FpDFL9nKNMdzp76Hm0jEdFH3gDl7Lm9c8TS9u9dpTNG7sDn3Fjg1sUIooYgfJ8qc
         7KjMHzcpB+mGrYE7FsdNjfVbOkAv2HxVOQ08FaVDsybEQ5cAkZlOwUvoyIOf7PZKKLVX
         3o9AtDsOn+2KkXvhxefi3evHUZchsGVAh2wZnvqldYZrWn5Li2uHlcwvikfz2mj51Gnr
         K9ZfXP+rcK22W0e9DQ3anggQnI6xU0zp68BF/bTcI+p1ybbEM1Y92o4SbqK4+gX0JrHJ
         p6FcjIvcKw7ALYOWb3sMM/+tfQKoeTQ0Sy9LnyoXhjIzRS2BAONM0zQ5mBqt+ei+LuN/
         A+5g==
X-Gm-Message-State: AOJu0YyngcrI2rdJoaUa9OtLUeXlIy7Hr/kUhYcgLDPIyzVQL+vO9x+C
	gT0AD0sWvbCx8MGhcV3Ja5poOcSlbkPEGB0YNisX0n9cjiuaQ4Mh5i0DX5VFUFkH
X-Gm-Gg: AY/fxX7hipuF0UiBhe4D0ZpTtw6A5YNz7Lg6vwoEt2QYF7sFznSdTatJbzrxBysSs9d
	gJLmuge/wqcswvkS9kP+Y+EfWBRfqTdfhSRAlk7FWNEWANT+HE2DNWNvAIM4fECRvOuNw88awHi
	Sksjt+7hzyPULF19x1Acc+js8Ng5xC3QONeyH9FY9u9qTuX0xIGOc1wgRzqvUfHHGpE5KdHCN4a
	y3Hlc0VLi5s1QM3eZcUKoBWzVrJIGgRYiCAXaimv6tpmHbjNoybgm+DNdXORW/Tf0r70ksblEtj
	ofrfUVQK+LYeGstGHdOXKhQPGf5SSoYaW14MpIidCSoEKEsTj6ym7nyzHMQA6oJFNB8FtOsXWAV
	UVlfEXHhPqROIZ7kF+9cFtu/imcUJv+idSygxF0uxuMhbYtoOE9XzGWwyFnppF4miPZDAE72SsD
	BiL/8iAmUdmbGnUX2V4t+GRJrLdWwc1vis
X-Google-Smtp-Source: AGHT+IEYx4drA1UizXre/uRw+0P4CeJYm4ubmxPIKcvi97Bs/fBHoJZee3EjcjTHnDM+YGSfHdKpCg==
X-Received: by 2002:a17:907:9802:b0:b7c:e320:5232 with SMTP id a640c23a62f3a-b8444c4ce48mr1001651066b.5.1767990598046;
        Fri, 09 Jan 2026 12:29:58 -0800 (PST)
Received: from devrnd0.tailf8d75f.ts.net ([2a09:5e41:e74:6400:1e80:613f:f534:6580])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a51577bsm1191918366b.56.2026.01.09.12.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:29:57 -0800 (PST)
From: Lasse Dalegaard <dalegaard@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lasse Dalegaard <dalegaard@gmail.com>
Subject: [PATCH v2] gatt-client: prevent use-after-free when clients disconnect
Date: Fri,  9 Jan 2026 21:29:27 +0100
Message-ID: <20260109202925.774809-4-dalegaard@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109202925.774809-2-dalegaard@gmail.com>
References: <20260109202925.774809-2-dalegaard@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clients with an acquired characteristic subscription would free the
client during disconnect. When notify_io_destroy then tries to remove
the client, it'll use-after-free.

Add another reference when allocating the notify_io and unref it again
in notify_io_destroy.

This was found with AddressSanitizer:

==766875==ERROR: AddressSanitizer: heap-use-after-free on address 0x7b7782a31df0 at pc 0x55d19ae87cf0 bp 0x7ffcc28ea0d0 sp 0x7ffcc28ea0c0
READ of size 8 at 0x7b7782a31df0 thread T0
    #0 0x55d19ae87cef in notify_io_destroy src/gatt-client.c:1567
    #1 0x55d19ae83462 in sock_io_destroy src/gatt-client.c:1171
    #2 0x55d19ae83a4b in destroy_sock src/gatt-client.c:1192
    #3 0x55d19ae83c52 in sock_hup src/gatt-client.c:1207
    ...

0x7b7782a31df0 is located 0 bytes inside of 32-byte region [0x7b7782a31df0,0x7b7782a31e10)
freed by thread T0 here:
    #0 0x7f4784d1f79d in free /usr/src/debug/gcc/gcc/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x55d19ae85c57 in notify_client_free src/gatt-client.c:1360
    #2 0x55d19ae85dd5 in notify_client_unref src/gatt-client.c:1372
    #3 0x55d19ae86517 in notify_client_disconnect src/gatt-client.c:1418
    ...

previously allocated by thread T0 here:
    #0 0x7f4784d20cb5 in malloc /usr/src/debug/gcc/gcc/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x55d19af6154d in util_malloc src/shared/util.c:46
    #2 0x55d19ae86550 in notify_client_create src/gatt-client.c:1426
    #3 0x55d19ae880cd in characteristic_acquire_notify src/gatt-client.c:1593
    ...

Other avenues could also result in this use-after-free. The root issue
is that the client struct is put in to both the notify list, and the
notify_io struct, but without an extra reference increment.
---
 src/gatt-client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 44ec95db0..374e67c34 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1566,6 +1566,7 @@ static void notify_io_destroy(void *data)
 
 	if (queue_remove(client->chrc->notify_clients, client))
 		notify_client_unref(client);
+	notify_client_unref(client);
 }
 
 static DBusMessage *characteristic_acquire_notify(DBusConnection *conn,
@@ -1607,7 +1608,7 @@ static DBusMessage *characteristic_acquire_notify(DBusConnection *conn,
 	queue_push_tail(chrc->notify_clients, client);
 
 	chrc->notify_io = new0(struct sock_io, 1);
-	chrc->notify_io->data = client;
+	chrc->notify_io->data = notify_client_ref(client);
 	chrc->notify_io->msg = dbus_message_ref(msg);
 	chrc->notify_io->destroy = notify_io_destroy;
 
-- 
2.52.0

