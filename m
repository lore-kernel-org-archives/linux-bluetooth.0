Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38254BCC
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710187214; cv=none; b=QkPPLINtJ2+n7YF2H/56uHIRbIG25di6m1sHscPq6oP5Y2e8kDPR6O281AUKrgCvUVHc8F6uR0iHc3irPaUJ7u2T6D6fvtuxVwrOP404d140GD2PPcaHQSqLXl5eeFygKF3XJ7gaoQQOugc3hUlm4oJoYTkd4+3vSEs427qH6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710187214; c=relaxed/simple;
	bh=0qk3hIXniN3RGvIMG2OS7xv0psPsLBNmLDGrxsvN5mw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDQ8Ai4RT6NibdAj3AZ/9SUfTToGdN9UHlqlGZVpnGpWRt+1sFZaDaBaJ9E/WClvhiel1auOtMwqRnLUBW05Qi0aLsI3T8f3YG1FvONRxXPWAH/O04VvFGOTT+UVYWeS6n+5QUfnKqBatdDJps7oY/D2sq+rKf+ZAP8kk4EzLTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyFU7gNU; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyFU7gNU"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4733d7040dfso245213137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710187210; x=1710792010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIvQTgHae/4fq61QrNemQwsEYWNjgsov7Sve74c7fFM=;
        b=EyFU7gNUF2bQsBONjKE0IXdBgYYhz+S3QDXU7lNm65+0gyCoPsUA6Qg5Ms3geC737/
         44OEVmY6i0ATcLoDpIuYI8z6uTMNig0Ij5QXM6iQQj95NIPR95wgqV2mrNzU9FEglPfP
         Um2vzzJODTMzZ/bdP5ayy9O8/ziXE1dN2O1hkyy1QM49eE/g5IQti1tTvXBygU4YKkNk
         SklpFv0Y8uRpQPKYWBiP1DqB9ESK0pwg/FWZOKuTISH50LmFia4vOLOMejwQoPMGpE+2
         SbXmvoq+IsvY3qnYMxwaZhFcZy+ILtUK0stSuxO9WpCoUwCHK6NF254Nst8/6RQ5yDSy
         MZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710187210; x=1710792010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIvQTgHae/4fq61QrNemQwsEYWNjgsov7Sve74c7fFM=;
        b=Dbfatkzs44UioM8IopNxK4EjnS1aBEHNtbR17K0e6s4QHDpVJwpjG47HNvSiZCGCGQ
         96VfMKuWw1h1UuN752rl3w6EbpDooSDPThj14mWJhMX6/klsBuTQL4qmh62G1DKcJUHW
         ekPqQrMapqoA7uG0r0/0rBnx/er6yqvTMM8tersETrRd2vg4bNsMIcgzPawz/mpkz5g4
         SRnInB5zjNkVU0/jo1NKRtY08bXK4LxUK+p3pJoVXkYVn8ZUSw1a2q1hiDqlHvnNT2u1
         UTxN8kMV8TSOBtJrjc9IrbynUiiAiARnU0aaklyTELQWFWGdPIqzxyfrzYGtS+rddYG3
         uHsw==
X-Gm-Message-State: AOJu0YygSTQpnYWv89mgUIQBMyK7XyoNaBGiJq9fpjglSbnnASTow3dK
	QCEYG1xRaVB5U7jOkhb+7QZ9cjABLBgKr9o9CoDVjgHeJnh11kQEIgZBvhGF
X-Google-Smtp-Source: AGHT+IHkHjIZpMZP2x+zGrl/7Yx5T6HWpTqkvhmuXpxllpQokYTPDmvu5avlCjvwXkv+2fuJd03NQA==
X-Received: by 2002:a67:f991:0:b0:473:1ffb:7773 with SMTP id b17-20020a67f991000000b004731ffb7773mr4975158vsq.30.1710187210055;
        Mon, 11 Mar 2024 13:00:10 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id g8-20020a056102080800b00472ca24e1c1sm1037414vsb.32.2024.03.11.13.00.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 13:00:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/4] input/device: Use bt_uhid functions
Date: Mon, 11 Mar 2024 16:00:03 -0400
Message-ID: <20240311200004.962953-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311200004.962953-1-luiz.dentz@gmail.com>
References: <20240311200004.962953-1-luiz.dentz@gmail.com>
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
 profiles/input/device.c | 92 ++++++++++-------------------------------
 1 file changed, 21 insertions(+), 71 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 0d32b705bd00..592eceb5535d 100644
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
@@ -625,7 +596,7 @@ static bool hidp_report_req_timeout(gpointer data)
 		break;
 	}
 
-	DBG("Device %s HIDP %s request timed out", address, req_type_str);
+	error("Device %s HIDP %s request timed out", address, req_type_str);
 
 	idev->report_req_pending = 0;
 	idev->report_req_timer = 0;
@@ -941,28 +912,15 @@ static int ioctl_disconnect(struct input_device *idev, uint32_t flags)
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
 
@@ -972,17 +930,14 @@ static int uhid_connadd(struct input_device *idev, struct hidp_connadd_req *req)
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
@@ -991,17 +946,12 @@ static int uhid_disconnect(struct input_device *idev)
 
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

