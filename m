Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC701DC99A
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738083271; cv=none; b=ahwzbuU7cudC984ZdYzWgC//JfghiFh5C/fUF4yU31xWhBU+1bfVm1J0PcQKdKW7naqeUwsI7FCW7orvSoNfKQ9leNbfUZo/kNM9XAdbGXKfGjy9WhBY/07j0qZb04zBUE46SSnizkPBxLIq7/XdnPgDdhq1CYv4nHH0cBFJTDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738083271; c=relaxed/simple;
	bh=z4HCfqxZ3sQHJraAewbv9m8eLcNZcSwl/KeinOVOl/Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQ6U2w/NmqiLRzC6UBcOILQEF7Fuuf1Iy2vIOvj4StF4NhNXCzikDIyMUpoxNSOctqNLcOkHeayOmuO8EQRyjyWC15a5XZa2gbBx60e+UG9ZThuw04omOHPeC7GgLzrHkqXapk2ToJzYB3TUYkBe6ECvjTt4T8H7MTSnys3eXHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn91VQpe; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn91VQpe"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-518799f2828so2811038e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 08:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738083268; x=1738688068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4pIkOBbYPJjp4YwcPUEGpvrvFRBkcnv6neCh7t+e7c=;
        b=Yn91VQpeL9ZDgHfk5czjaNhfZ9Z5+f9Rs8VRWKxMObhMatw/lPu11TzHak/8C642SV
         kuq/sKGh3SsxbwFy2bg7MF4DTNE32701PS4+SxRNSBKAMAwxYVGeWU0kwzcbtUNdyeYg
         aunaObCrgMMyf5O0B+xp3xEioSeTKVQjQjjhOSNi9clm1OaHgF6WpmIyvjDvV2EB7FKZ
         GdyUy+Tyy1F6j/mnQD1nRjc1+QVhWkHsyqehPE3VyXy/gVd8tKdZadsA6OJdRsrhF3OQ
         EcoVAklcY5cMJ9uGG5BDPhvWUUE7g0mcai0l5CDuwZD0kBXcgosYIY/UOR2JNSEIVEJX
         aPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738083268; x=1738688068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4pIkOBbYPJjp4YwcPUEGpvrvFRBkcnv6neCh7t+e7c=;
        b=uMSDsEdUYYEXiq7VtrIEFn4qDMlv0TckmggeJLFMufslTUaUMlV8ZBKvltprjaXZxJ
         5Ya63Igd8PYdJJgh8hL5tEdUVSJRm9UEZOKomE6zRvrDgGSWodfDCzyF6++vckjyaA9j
         vWQJOilfo/NHFcFp5HB3nBTItDvGOPUcLD46zvE+aoB9kcwVBARjMMCQkmSMCiLYruBB
         nmy0ihV07EpduRyeL9E7V4o3o7QhvbGnFSapAMlNSJQ0FDMYgonuGr43bPLNaqhXYcWG
         0bjv4xg6A3VtVDQ/FrJPqkf+tzu0NnavlbPwwWybo50o5ZUCRcB8DbhT5F5Bq53v37hz
         E+kQ==
X-Gm-Message-State: AOJu0YwBYLEPRlsjDFxc3iLFgzg3nnl4sqV9t2If9j3Tg6Kne1cnbLo8
	LuyePBhS1ZnhCV6fuq7Nss64wf4Qkn9SeF0gjPDFWRGyVVZNv35WOAHMjA==
X-Gm-Gg: ASbGnct4elaroDIo8LDUmVIBEXrDCMx645hNbfy/czscm4ctVn737+jMgqsWXmBSN1b
	ofx+8UDSDpV8yDsYB/hPr20zGgZhqKqFmklHakgfDSH12744W+5sl30IANLRTya7Yw/IySvO7EJ
	Z6a7xGjGTiCACmQ19rE5ZBwN7IZ6KWz3a/ZxCxCDdO+EoGqGXaF5jvGig90vaLcLXiOacQdC5Ks
	bUrXuA1EFy1T56184zRG7YxADkZi82XF+g01XUDlXmX/v3xAtpmnCj+5ZeLNtZ/SmpRlsMDkKAd
	fcn/pZbSEzr9cdxUdj8cVAtJO2oLOqll/mRpc6NeGK9XTTZzkhyfkB0MgKib1Cc=
X-Google-Smtp-Source: AGHT+IFZcMRJCuViT/EKhRlCUiZEhaOWpE1LhcT+ZOIZP5DEd4qn7crlobRYf4MWzL4V93pgA31y2Q==
X-Received: by 2002:a05:6122:e5f:b0:516:dc0f:c925 with SMTP id 71dfb90a1353d-51e8e307315mr3345718e0c.6.1738083268310;
        Tue, 28 Jan 2025 08:54:28 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-864a9c40d58sm2575254241.32.2025.01.28.08.54.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:54:27 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] gatt: Implement confirmation support for AcquireNotify
Date: Tue, 28 Jan 2025 11:54:23 -0500
Message-ID: <20250128165424.1044479-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250128165424.1044479-1-luiz.dentz@gmail.com>
References: <20250128165424.1044479-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements AcquireNotify (fd based) confirmation so servers can be
notified when a client confirm the reception of an indication.

Fixes: https://github.com/bluez/bluez/issues/1081
---
 src/gatt-database.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index a5a01add40f7..7a105b8fe64a 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2601,6 +2601,24 @@ static bool sock_hup(struct io *io, void *user_data)
 	return false;
 }
 
+static bool sock_io_write(struct io *io, void *user_data)
+{
+	uint8_t buf[] = { 1 };
+	struct iovec iov = { buf, sizeof(buf) };
+
+	/* Send a 1 to the server as confirmation */
+	io_send(io, &iov, 1);
+
+	return false;
+}
+
+static void sock_io_conf(void *user_data)
+{
+	struct io *io = user_data;
+
+	io_set_write_handler(io, sock_io_write, NULL, NULL);
+}
+
 static bool sock_io_read(struct io *io, void *user_data)
 {
 	struct client_io *client = user_data;
@@ -2608,6 +2626,8 @@ static bool sock_io_read(struct io *io, void *user_data)
 	uint8_t buf[512];
 	int fd = io_get_fd(io);
 	ssize_t bytes_read;
+	struct notify notify;
+	struct device_state *state;
 
 	if (fd < 0) {
 		error("io_get_fd() returned %d\n", fd);
@@ -2618,8 +2638,22 @@ static bool sock_io_read(struct io *io, void *user_data)
 	if (bytes_read <= 0)
 		return false;
 
-	gatt_notify_cb(chrc->attrib, chrc->ccc, buf, bytes_read, client->att,
-				client->chrc->service->app->database);
+	memset(&notify, 0, sizeof(notify));
+
+	notify.database = client->chrc->service->app->database;
+	notify.handle = gatt_db_attribute_get_handle(chrc->attrib);
+	notify.ccc_handle = gatt_db_attribute_get_handle(chrc->ccc);
+	notify.value = (void *) buf;
+	notify.len = bytes_read;
+	notify.conf = sock_io_conf;
+	notify.user_data = io;
+
+
+	state = find_device_state_by_att(notify.database, client->att);
+	if (!state)
+		return false;
+
+	send_notification_to_device(state, &notify);
 
 	return true;
 }
-- 
2.48.1

