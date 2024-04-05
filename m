Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72EB174EFF
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351514; cv=none; b=jMFCWO/LS87VwMllkyRGY4U/01pcxsoOwWgabX3WzdnXNj7gfkl2MhnoxrecNShZZ7oNgCuSDyARGlleJ04XJXZzbxFIHpBHLQ60jLTBB6gRMztQpg9bWxhDyQavUKEewBfX03S7uKFkHH2vB6XStICYcBWqs99urM//xgO274U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351514; c=relaxed/simple;
	bh=1yzERKIilyRiTFlJHPGsD6mNM+htdmPWv2jvYHpSa5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjHHLY5lHyOEoqvOCTkp6b9RgmSbX+QK+TDrHPOj5D5nvqKWkWasfLgVr8d1U9CG/k6dINgUHhrnnBxKs7mmToA8byMGZVlW+4mIzstyymjD5ZVDOHAeCuEvfdm3PSR6kYrMDlnnJJlV6Wgaxxsq1lt676bCIct3DO8FkXOO/Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU5yYSZy; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU5yYSZy"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-479dbcdba2dso443390137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 14:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712351511; x=1712956311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jRkz3xIMUtWDjyEVKXZ0P/9jWENEqXJMLXLfsYwVQmE=;
        b=YU5yYSZyZP+fPJUekSLxrFWh6Xb+wdNZ4kOV2L9JUowc4L327o8wyveDT/9Jnbb1qN
         5OELm7miYXJXzIv+KpD3wcTRuWJ1fcVH6Dn1Dcq4N9tfQdXTr1XZEYTgcZJsmeKNwrVB
         EDjVMbu0T2rAaNSd7vM6yo/AXpurN53DH6279RmYIPB3ps5UNaDch0oFUe3hBxhqjE5K
         yWNHsseR0eIBEjEMRHP7DJN7/XvKMDjTfRwPXr77KL/2GxiXN/nQb4RuKsqFMHuQdMfP
         9Bwwn5XE69wltNffEvkhVElt673ioUevOh5x4wuQliv6fXOwu7F3bjn9RGtpxGk+pZ5T
         j8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712351511; x=1712956311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRkz3xIMUtWDjyEVKXZ0P/9jWENEqXJMLXLfsYwVQmE=;
        b=iynJycww9F1NnhjuflqwGrySZJYI/ZiqjurgR5g5nQWhkAYvjVwNmWGuuKt3ieFeLU
         RVULbQhjxIGmVItMkozt1vg/UdXXgHBvtHHTEyZQvA8bhynoFwIM7F5Uig6QfZHoAjX1
         qYQNeY1SylVT7v2qKThTQhTBZuOO3U7hRvL7QNrgj2UzEs8YpGwZPKekw+h89oQsdaJz
         0mYjb1kI8JNc+bg5fEm58ADb6fsXGuCnYUD7vcy3iHetJEnhaO83cCvLD6ZZ6QmxbZby
         IvPRvkZW6rICcAKcykMw/ROvSFRoWqhSLF26XwYRtIA9Ukiw+uelCnNymUKGp44mCtOJ
         slUQ==
X-Gm-Message-State: AOJu0Yw1O9ZlAkZk5Ql7cKgsIQb6C8gnPp7R+uurZiP8fQL8W89K8s55
	ccPFr57j/rnInjGaLJKiopwbBo3wdAZjt/5bPNHP6S0QaL/a15f6UDrfdooe
X-Google-Smtp-Source: AGHT+IGa9qq9/PeqVcD06wPH0Fm4OYMm3IDZGo8DqnzmpmO6K4uykiM7wiHVdPEtnkZnkhs/xciq9Q==
X-Received: by 2002:a05:6102:4189:b0:478:37c4:b20e with SMTP id cd9-20020a056102418900b0047837c4b20emr2751640vsb.20.1712351510986;
        Fri, 05 Apr 2024 14:11:50 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id dx26-20020a056130291a00b007e3d1347195sm306723uab.3.2024.04.05.14.11.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:11:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 3/3] input/device: Add replay support
Date: Fri,  5 Apr 2024 17:11:45 -0400
Message-ID: <20240405211145.3463154-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405211145.3463154-1-luiz.dentz@gmail.com>
References: <20240405211145.3463154-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds replay support when uhid is in use and the input node is keep
while disconnected:

Fixes: https://github.com/bluez/bluez/issues/777
---
 profiles/input/device.c | 174 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 173 insertions(+), 1 deletion(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index b622ee8cd681..21da16155b0c 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -42,6 +42,8 @@
 #include "src/sdp-client.h"
 #include "src/shared/timeout.h"
 #include "src/shared/uhid.h"
+#include "src/shared/util.h"
+#include "src/shared/queue.h"
 
 #include "device.h"
 #include "hidp_defs.h"
@@ -55,6 +57,19 @@ enum reconnect_mode_t {
 	RECONNECT_ANY
 };
 
+struct hidp_msg {
+	uint8_t hdr;
+	struct iovec *iov;
+};
+
+struct hidp_replay {
+	bool replaying;
+	struct queue *out;
+	struct queue *in;
+	struct queue *re_out;
+	struct queue *re_in;
+};
+
 struct input_device {
 	struct btd_service	*service;
 	struct btd_device	*device;
@@ -78,6 +93,7 @@ struct input_device {
 	uint32_t		report_rsp_id;
 	bool			virtual_cable_unplug;
 	unsigned int		idle_timer;
+	struct hidp_replay	*replay;
 };
 
 static int idle_timeout = 0;
@@ -113,8 +129,30 @@ static bool input_device_bonded(struct input_device *idev)
 				btd_device_get_bdaddr_type(idev->device));
 }
 
+static void hidp_msg_free(void *data)
+{
+	struct hidp_msg *msg = data;
+
+	util_iov_free(msg->iov, 1);
+	free(msg);
+}
+
+static void hidp_replay_free(struct hidp_replay *replay)
+{
+	if (!replay)
+		return;
+
+	queue_destroy(replay->re_in, NULL);
+	queue_destroy(replay->in, hidp_msg_free);
+	queue_destroy(replay->re_out, NULL);
+	queue_destroy(replay->out, hidp_msg_free);
+	free(replay);
+}
+
 static void input_device_free(struct input_device *idev)
 {
+	hidp_replay_free(idev->replay);
+
 	bt_uhid_unref(idev->uhid);
 	btd_service_unref(idev->service);
 	btd_device_unref(idev->device);
@@ -171,6 +209,10 @@ static int uhid_disconnect(struct input_device *idev, bool force)
 	if (!idev->virtual_cable_unplug && !force)
 		return 0;
 
+	/* Destroy replay messages */
+	hidp_replay_free(idev->replay);
+	idev->replay = NULL;
+
 	bt_uhid_unregister_all(idev->uhid);
 
 	err = bt_uhid_destroy(idev->uhid);
@@ -246,12 +288,96 @@ static bool hidp_send_message(struct input_device *idev, GIOChannel *chan,
 	return true;
 }
 
+static void hidp_replay_resend(struct input_device *idev)
+{
+	struct hidp_msg *msg;
+
+	if (!idev->replay || !idev->replay->replaying)
+		return;
+
+	msg = queue_pop_head(idev->replay->re_out);
+	if (!msg) {
+		DBG("uhid replay finished");
+		idev->replay->replaying = false;
+		return;
+	}
+
+	if (hidp_send_message(idev, NULL, msg->hdr, msg->iov->iov_base,
+				msg->iov->iov_len))
+		DBG("hdr 0x%02x size %zu", msg->hdr, msg->iov->iov_len);
+	else
+		error("uhid replay resend failed");
+}
+
+static void hidp_replay_recv(struct input_device *idev, uint8_t hdr,
+				const uint8_t *data, size_t size)
+{
+	struct hidp_msg *msg;
+
+	if (!idev->replay || !idev->replay->replaying)
+		return;
+
+	msg = queue_pop_head(idev->replay->re_in);
+
+	if (msg && (msg->hdr != hdr || msg->iov->iov_len != size ||
+			memcmp(msg->iov->iov_base, data, size)))
+		error("uhid replay input error... discarding");
+
+	hidp_replay_resend(idev);
+}
+
+static struct hidp_replay *hidp_replay_new(void)
+{
+	struct hidp_replay *replay = new0(struct hidp_replay, 1);
+
+	replay->out = queue_new();
+	replay->in = queue_new();
+
+	return replay;
+}
+
+static void hidp_record_message(struct input_device *idev, bool out,
+				uint8_t hdr, const uint8_t *data, size_t size)
+{
+	struct hidp_msg *msg;
+	struct iovec iov = { (void *)data, size };
+
+	/* Only record messages if uhid has been created */
+	if (!bt_uhid_created(idev->uhid))
+		return;
+
+	if (idev->replay && idev->replay->replaying) {
+		if (!out)
+			hidp_replay_recv(idev, hdr, data, size);
+		return;
+	}
+
+	if (!idev->replay)
+		idev->replay = hidp_replay_new();
+
+	msg = new0(struct hidp_msg, 1);
+	msg->hdr = hdr;
+	msg->iov = util_iov_dup(&iov, 1);
+
+	if (out) {
+		DBG("output[%u]: hdr 0x%02x size %zu",
+			queue_length(idev->replay->out), hdr, size);
+		queue_push_tail(idev->replay->out, msg);
+	} else {
+		DBG("input[%u]: hdr 0x%02x size %zu",
+			queue_length(idev->replay->in), hdr, size);
+		queue_push_tail(idev->replay->in, msg);
+	}
+}
+
 static bool hidp_send_ctrl_message(struct input_device *idev, uint8_t hdr,
 					const uint8_t *data, size_t size)
 {
 	if (hdr == (HIDP_TRANS_HID_CONTROL | HIDP_CTRL_VIRTUAL_CABLE_UNPLUG))
 		idev->virtual_cable_unplug = true;
 
+	hidp_record_message(idev, true, hdr, data, size);
+
 	return hidp_send_message(idev, idev->ctrl_io, hdr, data, size);
 }
 
@@ -558,6 +684,12 @@ static bool hidp_recv_ctrl_message(GIOChannel *chan, struct input_device *idev)
 	type = hdr & HIDP_HEADER_TRANS_MASK;
 	param = hdr & HIDP_HEADER_PARAM_MASK;
 
+	/* While replaying don't involve the driver since it will likely get
+	 * confused with messages it already things it has received.
+	 */
+	if (idev->replay && idev->replay->replaying)
+		goto done;
+
 	switch (type) {
 	case HIDP_TRANS_HANDSHAKE:
 		hidp_recv_ctrl_handshake(idev, param);
@@ -575,6 +707,9 @@ static bool hidp_recv_ctrl_message(GIOChannel *chan, struct input_device *idev)
 		break;
 	}
 
+done:
+	hidp_record_message(idev, false, hdr, data + 1, len - 1);
+
 	return true;
 }
 
@@ -973,12 +1108,49 @@ static int ioctl_disconnect(struct input_device *idev, uint32_t flags)
 	return err;
 }
 
+static void queue_append(void *data, void *user_data)
+{
+	queue_push_tail(user_data, data);
+}
+
+static struct queue *queue_dup(struct queue *q)
+{
+	struct queue *dup;
+
+	if (!q || queue_isempty(q))
+		return NULL;
+
+	dup = queue_new();
+
+	queue_foreach(q, queue_append, dup);
+
+	return dup;
+}
+
+static void hidp_replay_init(struct input_device *idev)
+{
+	if (!idev->replay || idev->replay->replaying)
+		return;
+
+	idev->replay->replaying = true;
+
+	queue_destroy(idev->replay->re_in, NULL);
+	idev->replay->re_in = queue_dup(idev->replay->in);
+
+	queue_destroy(idev->replay->re_out, NULL);
+	idev->replay->re_out = queue_dup(idev->replay->out);
+
+	hidp_replay_resend(idev);
+}
+
 static int uhid_connadd(struct input_device *idev, struct hidp_connadd_req *req)
 {
 	int err;
 
-	if (bt_uhid_created(idev->uhid))
+	if (bt_uhid_created(idev->uhid)) {
+		hidp_replay_init(idev);
 		return 0;
+	}
 
 	err = bt_uhid_create(idev->uhid, req->name, &idev->src, &idev->dst,
 				req->vendor, req->product, req->version,
-- 
2.44.0

