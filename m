Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A958200
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197016; cv=none; b=Zf1XJYLNwJKSVeKeGPHGeSm9JfA0+jBrSrH3+y8eq3/wZjffnhQCulRv7EaBZVsOsftYqXtKgYtU+tb2jJ8T8r8fBg3Lbj+a4symZbru+eXW9pPUxpTtDX15S307etnXB0jBVjgziwJTNUVhJCXSUcEjlN99qU/pzVMObsrLPkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197016; c=relaxed/simple;
	bh=kCl/FjyFg2v0d19c8o1f/+lxhrSPQp9UZRKB3ZY/9v0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LR1Ooc8xJfZnSRBV1AFoUuHF/UOkbIWYHvDM5ZnNFLpvAh5zXMVjVXruAX4ayvLcbAHcUynoW6MnxDglVKbH4VJjwDz8006Ps3NF5OR1OZJBWHkyYGlvkCAIDna4BAo2T+Y8ciQ9JjmDVgIUS/FwKelPhROlmADRbRsUxI5clNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQ7J8Mxb; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ7J8Mxb"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-472d80cda16so1104309137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 15:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710197013; x=1710801813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBbU+hM+5RPM0xomTDkCuqOrXyZs6r1aenEFhKfWOBo=;
        b=TQ7J8Mxb76MgO71ED75cFqZRhVMbzOwxk616Giu8MmS9alldxy58VpXycqk22Fpmfp
         pIh699abXGJoFZ+Kbm4Qlps+uH/mUgG0GwOX0mUvrZ9n0GF3Eq+JG21uOgZT4LUcrS5l
         LL9iGtzfPvkeZAn774tCdZcJ5W5IIw1flaycKa7xc+eRy7XXBK+4oolW5p51PIW9XKnI
         qXa13odW3iwOoZthAXrDoGuKJ+1BwqKQE4u0n7uSzE3AfHxX3osZS1mxkj3Zokkd1dbv
         C54ROZT0GfMsEOVIETtd9x2mcoKZsxsWu/Srof+B1xyAzAi+kVdyaA2xHl3+giAOacvR
         rZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710197013; x=1710801813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBbU+hM+5RPM0xomTDkCuqOrXyZs6r1aenEFhKfWOBo=;
        b=V4c1P3KPamf6yGQnwkMvBvwobBRpxah+dc2EnwHy32MF2MfTt11RbIfB2X9HLJKJg1
         Kf0JExT2bjsWvfNS+vBn24WVo9opHgVhpm5u3KJsiXjakqRYz7VQFQ6DAXO1D95JbvFE
         Ph7FVCZH423rvNjkgUq5jUyH2uc5VvAJdfIzLaXf7IEglrgYb2XM8WLacfHknttL/fVU
         5FmZovoCtLxaA1Gd2eyuOlYPbvztQTEs1dTvmzhZiboR/SjOH/UdHs1i/gtaqXwDdo6k
         TP5QhGd79Sn+ZQIhGepRPc+Z1fV1uSwT7wuW2u5AlxIu+kBxwftdD+BeozS0fvOeJn9O
         mTJw==
X-Gm-Message-State: AOJu0YyF6B5FDF1r6nxR/l2VHIohLW0SlUqVXmPjWmlaEF0vZA/Uxf7j
	4tWnixrgSQsv4lHq6Ww8sNO/7kJ5R2Q8ng7v3eulrZrQTDupFEfBsXvJgQo7
X-Google-Smtp-Source: AGHT+IEI7nCg43Fn5AL8WJ1uPvvJlzyuuP04yZ9B8syKdh8A65wOj1n728Y7RKvzloV0J4lOlRydng==
X-Received: by 2002:a05:6102:358e:b0:473:4173:d45b with SMTP id h14-20020a056102358e00b004734173d45bmr1887013vsu.17.1710197013095;
        Mon, 11 Mar 2024 15:43:33 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id db12-20020a056130238c00b007dbb2f61472sm829979uab.38.2024.03.11.15.43.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 15:43:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 3/4] input/device: Use bt_uhid functions
Date: Mon, 11 Mar 2024 18:43:26 -0400
Message-ID: <20240311224327.1023070-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311224327.1023070-1-luiz.dentz@gmail.com>
References: <20240311224327.1023070-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bt_uhid function instead of directly submitting
events directly using bt_uhid_send.

Fixes: https://github.com/bluez/bluez/issues/771
---
 profiles/input/device.c | 93 ++++++++++-------------------------------
 1 file changed, 22 insertions(+), 71 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 0d32b705bd00..c4f75c7442e8 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -73,7 +73,6 @@ struct input_device {
 	unsigned int		reconnect_timer;
 	uint32_t		reconnect_attempt;
 	struct bt_uhid		*uhid;
-	bool			uhid_created;
 	uint8_t			report_req_pending;
 	unsigned int		report_req_timer;
 	uint32_t		report_rsp_id;
@@ -215,32 +214,20 @@ static bool uhid_send_get_report_reply(struct input_device *idev,
 					const uint8_t *data, size_t size,
 					uint32_t id, uint16_t err)
 {
-	struct uhid_event ev;
 	int ret;
 
 	if (data == NULL)
 		size = 0;
 
-	if (size > sizeof(ev.u.get_report_reply.data))
-		size = sizeof(ev.u.get_report_reply.data);
-
-	if (!idev->uhid_created) {
+	if (!bt_uhid_created(idev->uhid)) {
 		DBG("HID report (%zu bytes) dropped", size);
 		return false;
 	}
 
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_GET_REPORT_REPLY;
-	ev.u.get_report_reply.id = id;
-	ev.u.get_report_reply.err = err;
-	ev.u.get_report_reply.size = size;
-
-	if (size > 0)
-		memcpy(ev.u.get_report_reply.data, data, size);
-
-	ret = bt_uhid_send(idev->uhid, &ev);
+	ret = bt_uhid_get_report_reply(idev->uhid, id, 0, err, data, size);
 	if (ret < 0) {
-		error("bt_uhid_send: %s (%d)", strerror(-ret), -ret);
+		error("bt_uhid_get_report_reply: %s (%d)", strerror(-ret),
+			-ret);
 		return false;
 	}
 
@@ -252,20 +239,15 @@ static bool uhid_send_get_report_reply(struct input_device *idev,
 static bool uhid_send_set_report_reply(struct input_device *idev,
 					uint32_t id, uint16_t err)
 {
-	struct uhid_event ev;
 	int ret;
 
-	if (!idev->uhid_created)
+	if (!bt_uhid_created(idev->uhid))
 		return false;
 
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_SET_REPORT_REPLY;
-	ev.u.set_report_reply.id = id;
-	ev.u.set_report_reply.err = err;
-
-	ret = bt_uhid_send(idev->uhid, &ev);
+	ret = bt_uhid_set_report_reply(idev->uhid, id, err);
 	if (ret < 0) {
-		error("bt_uhid_send: %s (%d)", strerror(-ret), -ret);
+		error("bt_uhid_set_report_reply: %s (%d)", strerror(-ret),
+			-ret);
 		return false;
 	}
 
@@ -275,30 +257,19 @@ static bool uhid_send_set_report_reply(struct input_device *idev,
 static bool uhid_send_input_report(struct input_device *idev,
 					const uint8_t *data, size_t size)
 {
-	struct uhid_event ev;
 	int err;
 
 	if (data == NULL)
 		size = 0;
 
-	if (size > sizeof(ev.u.input.data))
-		size = sizeof(ev.u.input.data);
-
-	if (!idev->uhid_created) {
+	if (!bt_uhid_created(idev->uhid)) {
 		DBG("HID report (%zu bytes) dropped", size);
 		return false;
 	}
 
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_INPUT;
-	ev.u.input.size = size;
-
-	if (size > 0)
-		memcpy(ev.u.input.data, data, size);
-
-	err = bt_uhid_send(idev->uhid, &ev);
+	err = bt_uhid_input(idev->uhid, 0, data, size);
 	if (err < 0) {
-		error("bt_uhid_send: %s (%d)", strerror(-err), -err);
+		error("bt_uhid_input: %s (%d)", strerror(-err), -err);
 		return false;
 	}
 
@@ -385,7 +356,7 @@ static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data
 		virtual_cable_unplug(idev);
 
 	/* If connection abruptly ended, uhid might be not yet disconnected */
-	if (idev->uhid_created)
+	if (bt_uhid_created(idev->uhid))
 		uhid_disconnect(idev);
 
 	return FALSE;
@@ -445,6 +416,7 @@ static void hidp_recv_ctrl_handshake(struct input_device *idev, uint8_t param)
 			timeout_remove(idev->report_req_timer);
 			idev->report_req_timer = 0;
 		}
+		uhid_send_set_report_reply(idev, idev->report_rsp_id, 0);
 		idev->report_rsp_id = 0;
 	}
 }
@@ -625,7 +597,7 @@ static bool hidp_report_req_timeout(gpointer data)
 		break;
 	}
 
-	DBG("Device %s HIDP %s request timed out", address, req_type_str);
+	error("Device %s HIDP %s request timed out", address, req_type_str);
 
 	idev->report_req_pending = 0;
 	idev->report_req_timer = 0;
@@ -941,28 +913,15 @@ static int ioctl_disconnect(struct input_device *idev, uint32_t flags)
 static int uhid_connadd(struct input_device *idev, struct hidp_connadd_req *req)
 {
 	int err;
-	struct uhid_event ev;
 
-	if (idev->uhid_created)
+	if (bt_uhid_created(idev->uhid))
 		return 0;
 
-	/* create uHID device */
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_CREATE;
-	strncpy((char *) ev.u.create.name, req->name, sizeof(ev.u.create.name));
-	ba2strlc(&idev->src, (char *) ev.u.create.phys);
-	ba2strlc(&idev->dst, (char *) ev.u.create.uniq);
-	ev.u.create.vendor = req->vendor;
-	ev.u.create.product = req->product;
-	ev.u.create.version = req->version;
-	ev.u.create.country = req->country;
-	ev.u.create.bus = BUS_BLUETOOTH;
-	ev.u.create.rd_data = req->rd_data;
-	ev.u.create.rd_size = req->rd_size;
-
-	err = bt_uhid_send(idev->uhid, &ev);
+	err = bt_uhid_create(idev->uhid, req->name, &idev->src, &idev->dst,
+				req->vendor, req->product, req->version,
+				req->country, req->rd_data, req->rd_size);
 	if (err < 0) {
-		error("bt_uhid_send: %s", strerror(-err));
+		error("bt_uhid_create: %s", strerror(-err));
 		return err;
 	}
 
@@ -972,17 +931,14 @@ static int uhid_connadd(struct input_device *idev, struct hidp_connadd_req *req)
 	bt_uhid_register(idev->uhid, UHID_SET_REPORT, hidp_send_set_report,
 									idev);
 
-	idev->uhid_created = true;
-
 	return err;
 }
 
 static int uhid_disconnect(struct input_device *idev)
 {
 	int err;
-	struct uhid_event ev;
 
-	if (!idev->uhid_created)
+	if (!bt_uhid_created(idev->uhid))
 		return 0;
 
 	/* Only destroy the node if virtual cable unplug flag has been set */
@@ -991,17 +947,12 @@ static int uhid_disconnect(struct input_device *idev)
 
 	bt_uhid_unregister_all(idev->uhid);
 
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_DESTROY;
-
-	err = bt_uhid_send(idev->uhid, &ev);
+	err = bt_uhid_destroy(idev->uhid);
 	if (err < 0) {
-		error("bt_uhid_send: %s", strerror(-err));
+		error("bt_uhid_destroy: %s", strerror(-err));
 		return err;
 	}
 
-	idev->uhid_created = false;
-
 	return err;
 }
 
-- 
2.43.0

