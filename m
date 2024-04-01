Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADDE4EB24
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711997899; cv=none; b=MjP5WdA/Yas0NF4/bfFUyl4GM+0DRRDToxJmRRItDQabLbKRb/KZFRxq8AagxWBSqHMqoZ1VBSHW5WJgTfL9o/0lplJzVH+XKqxJL23O3ViFE0cPZNTGDAAnqBQ4Z9tbaz/rfMR+i6JoMMJhafBTXeJrD+1aeFpL8GW4tGN7RUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711997899; c=relaxed/simple;
	bh=hw8OXYTtBKtj9JO0Gr0/1t8xbk4BmKmZqW3GagAzeF8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K10L8utiivFhGhBS6v5bfnNgab09BHh5DpeXB2d9mtZX/kXy2rS88PH3puZVtL+bYSBGzwPHHSntb9xRzalYM207HXaNoEYypB0urW4UExXZbn6s1m79QHJjj48rdf8z5E2lb91Y4ffOtyJIsRX1rVkg1sbUfo9luaBW8W8NQgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhWC0yhI; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhWC0yhI"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso4065528276.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Apr 2024 11:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711997896; x=1712602696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OQ2+f5h0a/jQeGROK30s9fYXFaaR/lH4klznMiUDcY=;
        b=VhWC0yhI5kefcalmyQsSnmRMLJtOI9zHf1jmat4gdXgBFHEGnAfspN3aAuBFrS7yqp
         20ylHPU1UZFFLaFOu7vphvm1QauxDxwoqUYNMvslymPF+CNYVV/U6eQBuoxQ7HBfVAkv
         NSDAB06rlgID3KE3Fktl9+97dzUYBvoXmv/5CHiUcz49OBKo3c2as/7ITRgzoBtmAwfi
         GvY58fvUB1YlKtktIcEGA4TQ5gkA/CnEUs1hMnzBBwJ8QgrxQdMLZR+/wecpTnO2phTB
         Mj8IOiY1DWPgK5P03A5CKuDvPkCvGmDxsHZ93C7PQO+1FdyB+1+oB6vvPjySfcrxKrnS
         XF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711997896; x=1712602696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OQ2+f5h0a/jQeGROK30s9fYXFaaR/lH4klznMiUDcY=;
        b=GbXuzLG3eZYVfhq2JrJyGaCXF8UhTZZfkgeQt7WkQlpSdLtV5tchRvmcjc2O78sIC7
         klK/qivViswpFdhFLbA7iG7VsB83HJfKPT3zWfDQyPXgYSGxHKK9gLJbtJuGJx3Fj8fD
         yHzufeEJxQGZMaXab5GJ0RO+WmLAR5467F8lxemsW7pQyDy4Lg9M5hR8GIDvJyMuFhrH
         2tpAcnl/gBW3HcxBW+LPuO0pxW39uMCBmNhN4nUu0DOktYaqtpOuaKAhxelYBk00s+8l
         Vlmdcgl5N2EsQsAlxVizXdzOt8cnGVfLS7iCeTj10v+e/KrEDqCYeOl01GxRVKQrmOw6
         3rMQ==
X-Gm-Message-State: AOJu0YyBfqhbP4m51VfIWwKXgY2D8N62jHoiSXVR+QJQzYTN7OrpD/Z2
	i5tdgfFDf2yhJo5ep8Du+8GKPpmuGZmfOZ/GX+5eWIez7O73SarUyad/fmfS
X-Google-Smtp-Source: AGHT+IHnkKoescqXHuE3AEFctXQSQXki3MZVSZ1OICLVk9eQ6EaJ2BwH15Cjt9uCxSVvHoNPq6LmBw==
X-Received: by 2002:a25:1e54:0:b0:dcd:3d6:68ad with SMTP id e81-20020a251e54000000b00dcd03d668admr7641989ybe.0.1711997895819;
        Mon, 01 Apr 2024 11:58:15 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id o9-20020a25ea49000000b00dcc234241c4sm2153739ybe.55.2024.04.01.11.58.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 11:58:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 3/3] input/device: Add replay support
Date: Mon,  1 Apr 2024 14:58:08 -0400
Message-ID: <20240401185808.2520694-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401185808.2520694-1-luiz.dentz@gmail.com>
References: <20240401185808.2520694-1-luiz.dentz@gmail.com>
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
 profiles/input/device.c | 169 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 168 insertions(+), 1 deletion(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index b622ee8cd681..b3d69d86f3d4 100644
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
@@ -246,12 +284,95 @@ static bool hidp_send_message(struct input_device *idev, GIOChannel *chan,
 	return true;
 }
 
+static void hidp_replay_send(struct input_device *idev)
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
+	DBG("hdr 0x%02x size %zu", msg->hdr, msg->iov->iov_len);
+
+	hidp_send_message(idev, NULL, msg->hdr, msg->iov->iov_base,
+			  msg->iov->iov_len);
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
+	hidp_replay_send(idev);
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
 
@@ -558,6 +679,12 @@ static bool hidp_recv_ctrl_message(GIOChannel *chan, struct input_device *idev)
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
@@ -575,6 +702,9 @@ static bool hidp_recv_ctrl_message(GIOChannel *chan, struct input_device *idev)
 		break;
 	}
 
+done:
+	hidp_record_message(idev, false, hdr, data + 1, len - 1);
+
 	return true;
 }
 
@@ -973,12 +1103,49 @@ static int ioctl_disconnect(struct input_device *idev, uint32_t flags)
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
+	hidp_replay_send(idev);
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

