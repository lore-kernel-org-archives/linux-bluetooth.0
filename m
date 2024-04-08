Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8405511725
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612584; cv=none; b=AE7YNegYjx2LFXoSZcZSNTZ01FND0hiNih07odeWd03t5kABFaSgCY9OqKUJyCMnZBpjjh14+i+UaFpTrh7nyyS3vqq83yn3fc0wVZ59CEVzUl/PjxL25ZzFn5TaY5kO2XQeWJkIKC8JggfIew9Ke1zQVBm5u+3Nkw8hbjzZgSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612584; c=relaxed/simple;
	bh=Dck4espvsr4r0JfVqykZjMrOuRh8kFc8nrTrXlfaidA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xc5KCpRkbA/taeYfptXCq6lEDwvpxOu3kaM/W0vF5ImIgXJG4H/SCCT+ukNb1s3OrFyWOg1TghUdYdFURtgiTg8PiVM8TcRPIePtH0DfNwh4tlivFFhiwg7cK9UYw+xCnd46JHIwnwRTaoLH/ZWIDrzrKpDJWPFe2evFYRdSD8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5QE1dCC; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5QE1dCC"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4daa513e430so1446724e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 14:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712612580; x=1713217380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4JNlJdEJQVd6pskQVkKzxRA5s2a8Gk65I3u5U2jAkc=;
        b=I5QE1dCCPkYIx4TgmWSQsvBU5il2GSbaxfiO+qj2CeGWujROb7ULXaPpT7VpNijAcH
         NnqwI6RWLkbNt9bEteK6sAAiUJAJ3JFDDsKI2iyvuZkcEKmgZv9xIoZ7/BSuT4xNk2lu
         5GxaDHodco5q8nSxfOg6F1BZD12fn+ex57ZCfxnawr6OnyMVZl69Cf4mqHyogJnP9THb
         tMldXoI9kyzvmzuOWMnYCIneWtcr+mAL4R0KfOJ+sKz642svBA3lkZpzMMv+fZU6dCiE
         6liHwpq1hSRpfeQ/0iXjW3McnwRK2CQuphHRKELrS6nTc0ts4JASwJE1w2nyI3CUJJjr
         Wtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712612580; x=1713217380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4JNlJdEJQVd6pskQVkKzxRA5s2a8Gk65I3u5U2jAkc=;
        b=fast1GtsMhIh48URvlfGLYj3mL7J1+P1485bFE6UnKiWmRvG5hlJH+/Sz0nyayPkjr
         z8Bxyvp9evtBgWH2FK1F17jdkNTAAI7+xetoODb4jDPLfcKezqfaQQd6bkh/WrRslkV3
         w6WPsJ+kfAHpu23499PE0Polxi7Djlg+JUTqKWiRHYW3+5dRwxS5Mk4qxox596sZLJG3
         66+xxGOM29h8mEWZrqaEIQl0sJCK8Zeevejvo+KVg+UgJbaS8ZSjBNcqe8fqvD3Cm4ld
         L7OFitntwuL+bIByShHp5XNu6vvWgSy+ar5M9AVzo7Aaa5S57Rg5WQqaI0My2Z1iKKam
         VCqA==
X-Gm-Message-State: AOJu0Yzpj3fnWrc49eQxnSyxaVp/dDg8xuEtfPP8oeg8jAQNMgnUq2mn
	t9+Yy5I9RTL3X6y5jf5M9cmFFkPxmJCFAH9GsyZYvtX9p9/SpPE0+UoX61WQ
X-Google-Smtp-Source: AGHT+IGJNCT3vpvgO+hi7cE6CrtSAywN11VGaIzhnxKjXVoz6bbKkncfZetzdQ/TnLJyK4YSO2I0dA==
X-Received: by 2002:a05:6122:17a6:b0:4d4:872:c68a with SMTP id o38-20020a05612217a600b004d40872c68amr6800080vkf.1.1712612579355;
        Mon, 08 Apr 2024 14:42:59 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id h20-20020ac5c294000000b004ca7514ee1esm1063625vkk.32.2024.04.08.14.42.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 14:42:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] input/device: Make use of bt_uhid_replay
Date: Mon,  8 Apr 2024 17:42:53 -0400
Message-ID: <20240408214253.3758319-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408214253.3758319-1-luiz.dentz@gmail.com>
References: <20240408214253.3758319-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bt_uhid_replay to replay the GET/SET_REPORT messages
recorded as it offer the same functionality as hidp_replay.
---
 profiles/input/device.c | 169 +---------------------------------------
 src/shared/uhid.c       |   1 +
 2 files changed, 3 insertions(+), 167 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 21da16155b0c..2145c2da20f0 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -62,14 +62,6 @@ struct hidp_msg {
 	struct iovec *iov;
 };
 
-struct hidp_replay {
-	bool replaying;
-	struct queue *out;
-	struct queue *in;
-	struct queue *re_out;
-	struct queue *re_in;
-};
-
 struct input_device {
 	struct btd_service	*service;
 	struct btd_device	*device;
@@ -93,7 +85,6 @@ struct input_device {
 	uint32_t		report_rsp_id;
 	bool			virtual_cable_unplug;
 	unsigned int		idle_timer;
-	struct hidp_replay	*replay;
 };
 
 static int idle_timeout = 0;
@@ -129,30 +120,8 @@ static bool input_device_bonded(struct input_device *idev)
 				btd_device_get_bdaddr_type(idev->device));
 }
 
-static void hidp_msg_free(void *data)
-{
-	struct hidp_msg *msg = data;
-
-	util_iov_free(msg->iov, 1);
-	free(msg);
-}
-
-static void hidp_replay_free(struct hidp_replay *replay)
-{
-	if (!replay)
-		return;
-
-	queue_destroy(replay->re_in, NULL);
-	queue_destroy(replay->in, hidp_msg_free);
-	queue_destroy(replay->re_out, NULL);
-	queue_destroy(replay->out, hidp_msg_free);
-	free(replay);
-}
-
 static void input_device_free(struct input_device *idev)
 {
-	hidp_replay_free(idev->replay);
-
 	bt_uhid_unref(idev->uhid);
 	btd_service_unref(idev->service);
 	btd_device_unref(idev->device);
@@ -209,10 +178,6 @@ static int uhid_disconnect(struct input_device *idev, bool force)
 	if (!idev->virtual_cable_unplug && !force)
 		return 0;
 
-	/* Destroy replay messages */
-	hidp_replay_free(idev->replay);
-	idev->replay = NULL;
-
 	bt_uhid_unregister_all(idev->uhid);
 
 	err = bt_uhid_destroy(idev->uhid);
@@ -288,96 +253,12 @@ static bool hidp_send_message(struct input_device *idev, GIOChannel *chan,
 	return true;
 }
 
-static void hidp_replay_resend(struct input_device *idev)
-{
-	struct hidp_msg *msg;
-
-	if (!idev->replay || !idev->replay->replaying)
-		return;
-
-	msg = queue_pop_head(idev->replay->re_out);
-	if (!msg) {
-		DBG("uhid replay finished");
-		idev->replay->replaying = false;
-		return;
-	}
-
-	if (hidp_send_message(idev, NULL, msg->hdr, msg->iov->iov_base,
-				msg->iov->iov_len))
-		DBG("hdr 0x%02x size %zu", msg->hdr, msg->iov->iov_len);
-	else
-		error("uhid replay resend failed");
-}
-
-static void hidp_replay_recv(struct input_device *idev, uint8_t hdr,
-				const uint8_t *data, size_t size)
-{
-	struct hidp_msg *msg;
-
-	if (!idev->replay || !idev->replay->replaying)
-		return;
-
-	msg = queue_pop_head(idev->replay->re_in);
-
-	if (msg && (msg->hdr != hdr || msg->iov->iov_len != size ||
-			memcmp(msg->iov->iov_base, data, size)))
-		error("uhid replay input error... discarding");
-
-	hidp_replay_resend(idev);
-}
-
-static struct hidp_replay *hidp_replay_new(void)
-{
-	struct hidp_replay *replay = new0(struct hidp_replay, 1);
-
-	replay->out = queue_new();
-	replay->in = queue_new();
-
-	return replay;
-}
-
-static void hidp_record_message(struct input_device *idev, bool out,
-				uint8_t hdr, const uint8_t *data, size_t size)
-{
-	struct hidp_msg *msg;
-	struct iovec iov = { (void *)data, size };
-
-	/* Only record messages if uhid has been created */
-	if (!bt_uhid_created(idev->uhid))
-		return;
-
-	if (idev->replay && idev->replay->replaying) {
-		if (!out)
-			hidp_replay_recv(idev, hdr, data, size);
-		return;
-	}
-
-	if (!idev->replay)
-		idev->replay = hidp_replay_new();
-
-	msg = new0(struct hidp_msg, 1);
-	msg->hdr = hdr;
-	msg->iov = util_iov_dup(&iov, 1);
-
-	if (out) {
-		DBG("output[%u]: hdr 0x%02x size %zu",
-			queue_length(idev->replay->out), hdr, size);
-		queue_push_tail(idev->replay->out, msg);
-	} else {
-		DBG("input[%u]: hdr 0x%02x size %zu",
-			queue_length(idev->replay->in), hdr, size);
-		queue_push_tail(idev->replay->in, msg);
-	}
-}
-
 static bool hidp_send_ctrl_message(struct input_device *idev, uint8_t hdr,
 					const uint8_t *data, size_t size)
 {
 	if (hdr == (HIDP_TRANS_HID_CONTROL | HIDP_CTRL_VIRTUAL_CABLE_UNPLUG))
 		idev->virtual_cable_unplug = true;
 
-	hidp_record_message(idev, true, hdr, data, size);
-
 	return hidp_send_message(idev, idev->ctrl_io, hdr, data, size);
 }
 
@@ -684,12 +565,6 @@ static bool hidp_recv_ctrl_message(GIOChannel *chan, struct input_device *idev)
 	type = hdr & HIDP_HEADER_TRANS_MASK;
 	param = hdr & HIDP_HEADER_PARAM_MASK;
 
-	/* While replaying don't involve the driver since it will likely get
-	 * confused with messages it already things it has received.
-	 */
-	if (idev->replay && idev->replay->replaying)
-		goto done;
-
 	switch (type) {
 	case HIDP_TRANS_HANDSHAKE:
 		hidp_recv_ctrl_handshake(idev, param);
@@ -707,9 +582,6 @@ static bool hidp_recv_ctrl_message(GIOChannel *chan, struct input_device *idev)
 		break;
 	}
 
-done:
-	hidp_record_message(idev, false, hdr, data + 1, len - 1);
-
 	return true;
 }
 
@@ -1108,49 +980,12 @@ static int ioctl_disconnect(struct input_device *idev, uint32_t flags)
 	return err;
 }
 
-static void queue_append(void *data, void *user_data)
-{
-	queue_push_tail(user_data, data);
-}
-
-static struct queue *queue_dup(struct queue *q)
-{
-	struct queue *dup;
-
-	if (!q || queue_isempty(q))
-		return NULL;
-
-	dup = queue_new();
-
-	queue_foreach(q, queue_append, dup);
-
-	return dup;
-}
-
-static void hidp_replay_init(struct input_device *idev)
-{
-	if (!idev->replay || idev->replay->replaying)
-		return;
-
-	idev->replay->replaying = true;
-
-	queue_destroy(idev->replay->re_in, NULL);
-	idev->replay->re_in = queue_dup(idev->replay->in);
-
-	queue_destroy(idev->replay->re_out, NULL);
-	idev->replay->re_out = queue_dup(idev->replay->out);
-
-	hidp_replay_resend(idev);
-}
-
 static int uhid_connadd(struct input_device *idev, struct hidp_connadd_req *req)
 {
 	int err;
 
-	if (bt_uhid_created(idev->uhid)) {
-		hidp_replay_init(idev);
-		return 0;
-	}
+	if (bt_uhid_created(idev->uhid))
+		return bt_uhid_replay(idev->uhid);
 
 	err = bt_uhid_create(idev->uhid, req->name, &idev->src, &idev->dst,
 				req->vendor, req->product, req->version,
diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 1d04dc5a780c..0a74c6d5c1ae 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -508,6 +508,7 @@ int bt_uhid_destroy(struct bt_uhid *uhid)
 		return err;
 
 	uhid->created = false;
+	uhid_replay_free(uhid->replay);
 
 	return err;
 }
-- 
2.44.0

