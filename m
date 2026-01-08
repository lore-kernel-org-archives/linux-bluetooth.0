Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F6435293E
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866509; cv=none; b=in0wwN3xTtApNPgorhjBYP5FFk1n6G2qIIz74BKZdwvsjPFpWzepJl7jvRaqJYsiQhZ/06RC8LTZfZE4zI3KSwub82Zy/Vv21uzsVjldvID2CiudCLOng4voRAvYT7HDB6iVTiwlpK89apW5RHvSrqs5NuR+/WYUqQLNhVYt0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866509; c=relaxed/simple;
	bh=F1mkWDH6EHXCIiWBNDJVdxDpSaKy1kdVki1zgVp6P0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BMBu9Ti1eOmna4T3ijDSEuP6T7c1rfoUnUb8fqPTEpvH/uKTySwCDWxF5w54aDnTtTTM2sds7MtNTsEevPXo3cpzSFKldbpWTXabYIQD4WF74lknuBuFw8Tyu3Q2juXlRJOJ1Ya21Fm7AH6V+dsOc+v919clfLKVoexn9KiXEAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzsSZ29B; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzsSZ29B"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7cee045187so306919366b.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jan 2026 02:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767866503; x=1768471303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nO/83ud45nt8smJXmgjdCr44kgoTQy6zcbsR69WAIe8=;
        b=EzsSZ29BNJ+S+DWW1jcsNYKTpDlOI1rvRYbxT3ans7RuYXGwBdM9ydNfetuIHYcXOS
         6MtiI9bpMhTLPzIcmzuzSbz5KyhaLqjyHapGIMOw61JpIoX0Z1X46UhsmxJUeKp8T7ty
         U1KNpH5wEWyiOUXzUC6pmOCiP/UMCw8UkwsfeYreQd1A9lb6CjB0BQr9JE8YadYvO7jR
         r/5C1CSDNnnjMg1e2THgoYCte7clciBBbbe/wsw1zx52dA+N8kI+BCe305HOdZxqSmlB
         rnFsi8a4w6q/n6Mz8WHhgCfNPbWnVUpCCIgaQa8Wzv/zwSmZ45MMShwOZDaaHT1Z0pFU
         UA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767866503; x=1768471303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nO/83ud45nt8smJXmgjdCr44kgoTQy6zcbsR69WAIe8=;
        b=V5Inh0ldKa7q7jeCDY5gn7H9BBBjax4baH1fTJ2xv8dG3Qdn64WiHgA/tUjR3mKxEU
         kozrmQkT5Er+oyXp5r2eAvYx0/6hUL0XhUr51Ze/w5YXygPSFV7aegpNH5tqVJgHo2KL
         sdQhHYCAjWkK/QRnDhJyoq1ltFI6wMTiq9OP16M9HpjT3SPW9+Wt20cZSqktl0lCk2jj
         hVdXnH5d4keTK2wGs2hGbazmQyhrNp8x5tDFp1HuZ4/yINGu6Q4TjljASxJz/drRiAv2
         ul/MRg2G8nE79iC6/QAoRDarJqrIZIO70OYz0grZJgtI7Nxcp8rMQQSazQFR96PPCUln
         GPTw==
X-Gm-Message-State: AOJu0YxmSuJ7hYd1stgU2lTXGiCxosjwqFUJ1C0/scYn5KU5DcwZnf+y
	i/Mde+JDkVmELp1a47EZ0GVBAr15r34348HS/3GZrAf736LrQ2JF44qYyX0K0g==
X-Gm-Gg: AY/fxX6wzOEYlDu6WL1MimVpo6bNkf1yxcABWl9mUkJFPaeN1FZcDetVdWzSNRrmAVR
	WHWdk2RKyzbxDjm+SpQ2YKbgPsIQSEHpjuimbDi9ve62cN4kq3CbQOlKSx5xd78k3WrJSkCxMSq
	VNhul7ImzIJJ7Sd9e+x4MFj07FC7PK+p/WO9xdo85Kayo4WIh3yYlpTlF0VL9PmriekfpOqA1h6
	nRPSnS8LYFkjYMC3vJFnr51OXQXbHcEy3CC3xYh1kpszmTvkjQ4LQ0OUYyRnADjKro5JAHnsH8t
	MOXoXwQ+spp08zVCN6vcew0ny6p/mKqMDIu1T3jwmJQflyS5U0lBnPRMjtJ2GyQdSKuID04T6ix
	h3x2rLTlbr3IEcNlJ6iJ6M/soymjBcZk4yjkon4vOY5dJTbTnpMEMNHTZyZ1j+ESsxLUgxRA6dk
	VDG7LPmjiXgef20G6+TlU3fcBft0kYvL0ZRXvoVvMT1Ho=
X-Google-Smtp-Source: AGHT+IGGsIxLPW7FJ9ScqWi1Es4+gIvQpwpzUToLgO1Mmdq5CS7FlmWh0lV/spbtezxX6g2vZDVx8A==
X-Received: by 2002:a17:906:4fd1:b0:b80:40ea:1d65 with SMTP id a640c23a62f3a-b8444fd5896mr657276566b.31.1767866503317;
        Thu, 08 Jan 2026 02:01:43 -0800 (PST)
Received: from yaaklasse0 (80.209.45.210.static.fibianet.dk. [80.209.45.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4cfe6bsm746254266b.34.2026.01.08.02.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:01:43 -0800 (PST)
From: Lasse Dalegaard <dalegaard@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lasse Dalegaard <dalegaard@gmail.com>
Subject: [PATCH BlueZ 1/2] gatt-client: fix use-after-free
Date: Thu,  8 Jan 2026 11:01:35 +0100
Message-ID: <20260108100136.486675-1-dalegaard@gmail.com>
X-Mailer: git-send-email 2.52.0
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

