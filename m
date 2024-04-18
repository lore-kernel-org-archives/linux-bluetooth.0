Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BF6181B90
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 19:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469648; cv=none; b=gyckwycdobjUSzFg8KABDhEIwdY/ANVIPU0YvENI5OH8A0Orzax4Xv3pYFr+OXWb1M+QaAiDhL4umcG7sYOzkq9WgmC3hJzj/xz9nrMN1I/dVZffXZAkKUIr2sdI5amonHCgnwVPoSC8gi/vEFmneW4Fx0i20ZqWvLcXyCVk7dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469648; c=relaxed/simple;
	bh=QS7/7E8PZ5Vd8XOhb5KdSEXRpRo3qg8eq5R1LuE97uM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Agnr/6CMRMzEcwz5iIvY8hO5sbK7HxevKvYVpM6IYpALPPbfsTRx8yRQrgSCEbNi6m9Fg37dozEdCUP4LOwITix0gnfqwDmpUpidO/zNAyeWwbmh3EjsP7Y20pZGVnbYvNsCTUApvLLH+NuR0iCu4WrqR7UfKTVxjeGDg06wrjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fxcow7vP; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fxcow7vP"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7eb9cb7b657so287000241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 12:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713469646; x=1714074446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhCN9k/iYBz1KZ4MDFKNAVXFgSDdmQhmySicXxZ2jIQ=;
        b=Fxcow7vPUS1NYi48kpQQa/ldcR5JFnNoHnlV+zgzW+abNaYPoB9poaytPiI1n+SAMt
         bywKGfDMmsTsNliFg9vwMm6Hm5z1iMBJCs7I0P+h8z4ZBKgv9MSrEqVGYkt37KxAY2SX
         MvyNo0mksUyVms5sF52YDw5/UAqfaGvaX4zgyGKzk+rB/rkCxVUro+quq2Qk3Mt/VgWv
         Wa1JJwttAV38YV915/HsNrT9iiQPYwZTr4w1WUtZhbZmIlPdqkhmQFuy8Isl0SFf+R7l
         QFJ6aynmr3s6jKuAsB3Bl35MapvFjFpBmiakxqY0C54xfeTSlK55RM5f8EqcliCOsTzl
         slSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469646; x=1714074446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhCN9k/iYBz1KZ4MDFKNAVXFgSDdmQhmySicXxZ2jIQ=;
        b=IuzbVTFhNDLeGN5KfRSOVl4rZFcCrQpj6v5eh5NkI89Q/t4FE8QG7/ly+z2HKzmfWE
         Po0JKJ549D/5OWerLNqlq5vDf20/Mzhz5u9vWXXo45McFANEO13s/nVgKYKXLJ9MdujE
         d0joATN/vTMarkwy2VzAjJrgVeD4GoOz1/VP4sLehfpnBgi6rvxa8e00R3rRuR3cLKlS
         oZZ0sV+J1UrbyL/PjO0Nb0hCL6NED0VCgFbXacfqk+6xTojdhxyFZn2HT3dfXPDzgf+/
         14k4FLkGvf3lGeR1PIfOptjSPKHC9rYSBzFFZZoynim+ilt4Xss0ly7cRDEF1uRG//hc
         VO/g==
X-Gm-Message-State: AOJu0YxW9fO8ZsQjNo7WndwT9fDQ1LeTO0Sri+RtrvU7P8nytnfMN+XY
	gbSnXIYU6aheuDpqKdpDrY2holHA2lsATTOAShnX8Wb1Aws1e5XDIZxjVA==
X-Google-Smtp-Source: AGHT+IGXUDl2Jo4crKSU8cn/WFeZsThDkDpdDQYu2BlGNbCdTgNK061mXP/YfWLcdY1/MNbc7H0Bhg==
X-Received: by 2002:a05:6102:2041:b0:47a:4138:dc1e with SMTP id q1-20020a056102204100b0047a4138dc1emr4220421vsr.20.1713469645605;
        Thu, 18 Apr 2024 12:47:25 -0700 (PDT)
Received: from lvondent-mobl4.. ([107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ij22-20020a0561025e9600b00479f9f9da85sm306191vsb.18.2024.04.18.12.47.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 12:47:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] gatt-database: Fix sending notification to all devices
Date: Thu, 18 Apr 2024 15:47:23 -0400
Message-ID: <20240418194723.1440686-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If notifications where setup with GATT application that implements
AcquireNotify the code will attempt to setup a dedicate fd/io for each
device so when receiving a notification over the fd/io it is only meant
to be send to the device only.

Fixes: https://github.com/bluez/bluez/issues/820
---
 src/gatt-database.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 6c11027a79ed..7ca2f94222c6 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -112,6 +112,7 @@ struct external_profile {
 
 struct client_io {
 	struct bt_att *att;
+	struct external_chrc *chrc;
 	unsigned int disconn_id;
 	struct io *io;
 };
@@ -2588,7 +2589,8 @@ static bool sock_hup(struct io *io, void *user_data)
 
 static bool sock_io_read(struct io *io, void *user_data)
 {
-	struct external_chrc *chrc = user_data;
+	struct client_io *client = user_data;
+	struct external_chrc *chrc = client->chrc;
 	uint8_t buf[512];
 	int fd = io_get_fd(io);
 	ssize_t bytes_read;
@@ -2597,12 +2599,8 @@ static bool sock_io_read(struct io *io, void *user_data)
 	if (bytes_read <= 0)
 		return false;
 
-	send_notification_to_devices(chrc->service->app->database,
-				gatt_db_attribute_get_handle(chrc->attrib),
-				buf, bytes_read,
-				gatt_db_attribute_get_handle(chrc->ccc),
-				conf_cb,
-				chrc->proxy);
+	gatt_notify_cb(chrc->attrib, chrc->ccc, buf, bytes_read, client->att,
+				client->chrc->service->app->database);
 
 	return true;
 }
@@ -2652,6 +2650,7 @@ client_io_new(struct external_chrc *chrc, int fd, struct bt_att *att)
 
 	client = new0(struct client_io, 1);
 	client->att = bt_att_ref(att);
+	client->chrc = chrc;
 	client->disconn_id = bt_att_register_disconnect(att, att_disconnect_cb,
 							client, NULL);
 	client->io = sock_io_new(fd, chrc);
@@ -2809,7 +2808,7 @@ client_notify_io_get(struct external_chrc *chrc, int fd, struct bt_att *att)
 
 	client = client_io_new(chrc, fd, att);
 
-	io_set_read_handler(client->io, sock_io_read, chrc, NULL);
+	io_set_read_handler(client->io, sock_io_read, client, NULL);
 
 	if (!chrc->notify_ios)
 		chrc->notify_ios = queue_new();
-- 
2.44.0

