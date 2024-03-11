Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B17B39AFF
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182707; cv=none; b=k0xiXAujA2Jbdd6cM79i06pNweORaA0KW8/YdirlX3Ay1Cb8tgAgf7Wvbo1z5JDQ+q4/iswIz2QrwxLmB2FBdwrD8VKAbsW+YA3/ZqVYawsirhZaeboeMRcS9lCWxEjBb1qfBcGi9uskT7l0XTuYW/nq21wJgV7GdW5C1+zs21U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182707; c=relaxed/simple;
	bh=wNj26PraHcEw8yE90IConBqwxRjg/GHV5qR1YVdh1ds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYFvg9qae7L0q/wAPffCayWCe9kjgdg4hqZ6dvmErlrStM22hMQrJVpel7pzr4qgsYYYbVbEL6EpSZTRAS3ftYb+0gbzEDVHYzjR8zO8QhDHn/Pse3a8cehoQ7/56xsScjV97G++jsiIXCN0YFkCRrzphtssHPmjIOdUOlAO9T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWWcEQ2o; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWWcEQ2o"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4d34abf66deso568734e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710182703; x=1710787503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46gHxfO1Y6JgU/ZP2rR3ttnUiAQrvsi8cyTI5/MOx7g=;
        b=fWWcEQ2oFs56wPm2jALL7vDaeT7QuHT95TLnZHLZ7h43v8Dr1/vHadHI+AN7yrT5Pk
         ycIsxOJgpY9SJwDk7PeDRgZR5DcAvsffGYWJx3/1nO4buciky2x20xiVIz9L1I9tpEo9
         qSa/PpkfZPm68ffkxh9L26XzZpcOqtUIRH+nC2Gu/5xfczao4lIq2KSpblU6Y/df7vT6
         WrDcM0c5o2sfkqF4fnfDk/lCq3g2u2FWPrxpsUmENSpxZC0ob4g84A3x+5bmC4NK8ZAC
         oH3sKm+MuX0HrgxSgRNfwBkHGC+m4YScF2fkpLc28YNIQ/QMbBEylJrSNRfqpWQ5aIAh
         iRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710182703; x=1710787503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46gHxfO1Y6JgU/ZP2rR3ttnUiAQrvsi8cyTI5/MOx7g=;
        b=i0TIJB4vfv2CIf0KAspkCaApK5QMk4YOQAmiTtx99RVO1+Ok+J4neindKC8662k7po
         WgbdTCNNIBtYVgTZxWHqjG4Um+zaG3vwLmlggIR6pPxxNVa3Nzec570poGHymelubLTf
         z/DxOq/i8V5sFM33acc/stAD6SV9+tD8bfbsMNkYEzUzXIKXCHjWfeKUGgrvlZGb1Ceo
         mm7S8ItoFN9IrCcWHSj7XYeDhZOTI9O/2FfRS7Ni3c+aG65r2fEfpLXs3xK3NknXicOB
         1ylolvInCddKIvum0nXt3ehLX/iOY8AKVIKfW9FTV0qqAS59OO3AIYnZd9uvJVRLtBqD
         exrQ==
X-Gm-Message-State: AOJu0Yzp/ezRi7YnMnq4/EGAlcQGbxDhl8b8XTrXKLpNGQSMe9lboz9O
	jBYBxCYe353FDrrX8pew5PaOce0IPnyq4W/X6ecoTL4f85DSPrzRfY+rjx0J
X-Google-Smtp-Source: AGHT+IF6+0FOIfsW4gSZIrunnK6r3KgoIbc+eN64Sr7Qm3RZ15DrOMCF/IYgQTNtSljPPWvC+RiIHA==
X-Received: by 2002:a05:6122:1c0e:b0:4d3:4aad:22d4 with SMTP id et14-20020a0561221c0e00b004d34aad22d4mr4159186vkb.0.1710182703537;
        Mon, 11 Mar 2024 11:45:03 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id i15-20020a056122128f00b004c003cf5e14sm672510vkp.28.2024.03.11.11.45.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:45:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/4] input/device: Use bt_uhid functions
Date: Mon, 11 Mar 2024 14:44:55 -0400
Message-ID: <20240311184456.890351-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311184456.890351-1-luiz.dentz@gmail.com>
References: <20240311184456.890351-1-luiz.dentz@gmail.com>
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
 profiles/input/device.c | 90 +++++++++--------------------------------
 1 file changed, 20 insertions(+), 70 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 0d32b705bd00..ce335c7cdb68 100644
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

