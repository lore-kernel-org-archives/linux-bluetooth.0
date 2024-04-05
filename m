Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E008716F84B
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329483; cv=none; b=D/60OIADdZ0fWR00ez7Wgy2VHh2+tRsL4K4EMo/Iv22nwvy9dtsT2KN4ZVTznkSQ9EmG+iei6JSFVMoGeSikyEaHB4/+UXS9tpzI8buUpuZ/sjrjRBU/w2YIEfz1t6N2aywx68I1bBq4jsyqSqre0/QqVlHMTIXQzDc863qL08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329483; c=relaxed/simple;
	bh=PZedFUojdZGevPqhCkU4fbPhrOFUesMfi8wf2Fzd15o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmIMvu18PmMPYwZEtFYMYYzgXFVjbjfA+c8zP3d1lEejlFW1sP7/Ype4oYZyYtlnHz5Go/aQDhoUSxSTAego4DIqSyD4n7mi41whbhI9S76LhEQ+OR2OcRL6gWnxrl8GcwNkyW7JW0/U7YL559L1lQhHTzH8iICzrz+hWmC1lIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRth6ZH3; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRth6ZH3"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e9eccfc4b7so1073909a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712329480; x=1712934280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=roXnatHc1olblQwivZ+qgo/qtCf91xZF52/uQoJhlnk=;
        b=fRth6ZH3MWIDZhMGS3eiudBVJFZCt+IENl2goKMHoFvbUfHYleIU3qLNPD+LQVtVsn
         tyd2TY5t678MIRnP3UNDJqiDtXesIfdRV3A6WwEVvUez4a7guuTwNh+cMorWkP/dI4+u
         RET11bJlzb649k5nV3sOjE3KH38UxZ/R5SSm7nOnVGa2GsgGvt6L97lIb6086E2zb8SI
         RAIZeSWEokb5Jmw62bQntiO1YsBQ2gExJ8kbVBYDIcJaHuawik3fEe8W4k1gNuV/xEqc
         es9154ArOzHrIkNzgVyqpTz+SStHfAv+x75vwVU2r9lAvrlfj3cMj7nuVmwsoWOHqqua
         nRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712329480; x=1712934280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roXnatHc1olblQwivZ+qgo/qtCf91xZF52/uQoJhlnk=;
        b=eq6e2YmfT/Od1NKckeXUp38AnjFYsef+Kd49pQp3Z3JyqGexRcKdErXtrkRjwryMKr
         1l3MX1m4wKakUD886Ypcnph77ioC30fjTmXKb5mJvGNOp6EPhkLDsvgzpRlndML6vjoT
         BJXFMoRQoaEyIAX3kXbwjPO7zVIkGesaXhazSTArXFmN2zKfI8v5QJuIeVfPZEdWr9Bv
         Z6jNjXC4zbrQXTrmuXBNA/sx3H9X36i0Dt5zSilErhfdJRTFRosY/G1aR2Gd59JEiUz4
         9z7OxxADTxBgsozwsFF7y3TwGkQ4jSFiyOnX37b7VWQ9m0li6BQwEkTPjjwrgWhUUI/U
         juRQ==
X-Gm-Message-State: AOJu0Yz0zI+ZodWss7B80SlqZ1RIr6DZeW+K2YtjKkR0Q8DWKch34gQw
	NQ6fYMfDawAKJ17FvyB0zy3/AaLMgnyh35RxfwyIHwoc/0feqYA//87w8NEc
X-Google-Smtp-Source: AGHT+IEHMLrigG8S3HKZp3yTxQPggWw5z6nNfRL73GV6jN8i4/NrLUjyQrFePx1R8/YhZn3+wD00Ug==
X-Received: by 2002:a05:6830:217:b0:6e6:c4e0:a2bf with SMTP id em23-20020a056830021700b006e6c4e0a2bfmr1884522otb.24.1712329479741;
        Fri, 05 Apr 2024 08:04:39 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id l9-20020a9d4c09000000b006e82f65ad4esm306451otf.11.2024.04.05.08.04.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:04:38 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 3/3] input/device: Add replay support
Date: Fri,  5 Apr 2024 11:04:32 -0400
Message-ID: <20240405150432.3360157-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405150432.3360157-1-luiz.dentz@gmail.com>
References: <20240405150432.3360157-1-luiz.dentz@gmail.com>
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
 profiles/input/device.c | 173 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 172 insertions(+), 1 deletion(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index b622ee8cd681..4cb4870196dc 100644
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
@@ -246,12 +288,95 @@ static bool hidp_send_message(struct input_device *idev, GIOChannel *chan,
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
 
@@ -558,6 +683,12 @@ static bool hidp_recv_ctrl_message(GIOChannel *chan, struct input_device *idev)
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
@@ -575,6 +706,9 @@ static bool hidp_recv_ctrl_message(GIOChannel *chan, struct input_device *idev)
 		break;
 	}
 
+done:
+	hidp_record_message(idev, false, hdr, data + 1, len - 1);
+
 	return true;
 }
 
@@ -973,12 +1107,49 @@ static int ioctl_disconnect(struct input_device *idev, uint32_t flags)
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

