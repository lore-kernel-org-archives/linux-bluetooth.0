Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F0911725
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612580; cv=none; b=R05uD48slph9ygIWh+S2Oqq/LikKTLOyLnd9Eo8QfH0wMJfO2BoeAFFyQQxr24nqckUwFYWDFICICiyjCW8QiW/ECZYOskN5qUTVuLdeuRAgx2ssKzeKfujyP4RZVIns7LQ2tIg/OtqPbg+yDScYawqnMzMfJ/+OAma2t3+ROYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612580; c=relaxed/simple;
	bh=ILElJJf6pzqU4jWqZleD4XVJyNPanZRvKDIV156pH4Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZLsJRcUj/27CspCCp5i7/oHpBdHOKToSRgq0sgB0eC8Ny+mYHUyw+UL1e0/IO5HaUB+PG/WB2IEEan51JHDAf0hF/O/l46gJ2/XqZipUZCmROx/wR0CN3bFqF3QNKxDFiTG1oDPxyPL6b+Fz/+VjDkB5odahoLZn1JLpERN5HtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzwlyPRY; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzwlyPRY"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4dab344ace5so757038e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 14:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712612577; x=1713217377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jb6IJaEcSDhAiBNDodo1z6fcnlHWYbR338+e9/I0VzI=;
        b=CzwlyPRY+h+ABZsZJuZQMigNUw4EurtF7P439XDu8vYs+LWdsJLUyMqEQWAjSwqd38
         TaOc5go0c3MthOCrKkot2T8irs1raPsM4WVCuZ1HZVvoEpk1JMH4Nv7vbYXQgkAC/rC5
         ngTOUuHS+E7kRPNV44J6ehwnthf5UAuPHTPOtpb15upNRy/KoG0NWm0pEvsIaxQ/FFOI
         oOZkbtlrb7EFXW3TwRibJBfedmc3gkqmQXJ+QFBlzuy8LJOckmxgiokAWNy5LUIERCZm
         +NLiP9LQP1fmQTFjZQ1kxeA5cEzsTh/4InqfDFkaulOQfKcEQuKvxiEp9khNz19oW84f
         gOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712612577; x=1713217377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jb6IJaEcSDhAiBNDodo1z6fcnlHWYbR338+e9/I0VzI=;
        b=Hb38Rughd4GT+EuFgUnQodUae2YqqRHAp1/fjckp5dCItwwzIw3/9OM0b+GCwPNvz8
         es5UTtl473B6W9B2VufwxjBvIQJ2Yv0Ui/rYR7p8sb4T9w2d6glhGsbYgm7KMFgHE2+h
         8YvaNf+bsVKO65qmRIIZMVnhEhDaElPncq+fwnBZ1ulukxioe2n0kpoLX0nWkAxxujwk
         NGFEKFjXUYW3h5HDLjUBPzYBAL4q/Jd6KO/W6dKvlflvimCPyFzvlnVcZSUTaisxE6Vh
         Li53RiYxJdRJy3830JlfhxAnltiS/H9rh4VXAIeHMA9SiC3Mxq4nh5oPKVXo+byjJ5y0
         cICQ==
X-Gm-Message-State: AOJu0YztYO+OU2yBM5bMTNb27+tk+ZyeDFRfJh5Xgcma/o2bJUIS3KLz
	BneZlwQtNIRmCabaDEag/NTcJu6XBlebWcIuu8OmFH1f+YEf9gxahAVmNZrz
X-Google-Smtp-Source: AGHT+IG/bKdlyK6s3WWMlD+5QPIUxi8bG4PtF+JdvjgILimURc+aCqX6w/9i0pQTaQAB27prOMBPdw==
X-Received: by 2002:a05:6122:4d1c:b0:4d8:9541:41a0 with SMTP id fi28-20020a0561224d1c00b004d8954141a0mr7481016vkb.12.1712612576227;
        Mon, 08 Apr 2024 14:42:56 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id h20-20020ac5c294000000b004ca7514ee1esm1063625vkk.32.2024.04.08.14.42.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 14:42:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] shared/uhid: Add support for bt_uhid_replay
Date: Mon,  8 Apr 2024 17:42:51 -0400
Message-ID: <20240408214253.3758319-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for bt_uhid_replay which enablind replaying
GET/SET_REPORT messages stored during the first time a device is
created.
---
 src/shared/uhid.c | 125 ++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/uhid.h |   1 +
 2 files changed, 126 insertions(+)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 46edb3bfa3ba..1d04dc5a780c 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -30,6 +30,14 @@
 #define MIN(x, y) ((x) < (y) ? (x) : (y))
 #endif
 
+struct uhid_replay {
+	bool active;
+	struct queue *out;
+	struct queue *in;
+	struct queue *rout;
+	struct queue *rin;
+};
+
 struct bt_uhid {
 	int ref_count;
 	struct io *io;
@@ -38,6 +46,7 @@ struct bt_uhid {
 	struct queue *input;
 	bool created;
 	bool started;
+	struct uhid_replay *replay;
 };
 
 struct uhid_notify {
@@ -47,6 +56,18 @@ struct uhid_notify {
 	void *user_data;
 };
 
+static void uhid_replay_free(struct uhid_replay *replay)
+{
+	if (!replay)
+		return;
+
+	queue_destroy(replay->rin, NULL);
+	queue_destroy(replay->in, free);
+	queue_destroy(replay->rout, NULL);
+	queue_destroy(replay->out, free);
+	free(replay);
+}
+
 static void uhid_free(struct bt_uhid *uhid)
 {
 	if (uhid->io)
@@ -58,6 +79,8 @@ static void uhid_free(struct bt_uhid *uhid)
 	if (uhid->input)
 		queue_destroy(uhid->input, free);
 
+	uhid_replay_free(uhid->replay);
+
 	free(uhid);
 }
 
@@ -73,6 +96,44 @@ static void notify_handler(void *data, void *user_data)
 		notify->func(ev, notify->user_data);
 }
 
+static struct uhid_replay *uhid_replay_new(void)
+{
+	struct uhid_replay *replay = new0(struct uhid_replay, 1);
+
+	replay->out = queue_new();
+	replay->in = queue_new();
+
+	return replay;
+}
+
+static int bt_uhid_record(struct bt_uhid *uhid, bool input,
+					struct uhid_event *ev)
+{
+	if (!uhid)
+		return -EINVAL;
+
+	if (uhid->replay && uhid->replay->active) {
+		if (input)
+			queue_pop_head(uhid->replay->rin);
+		else
+			queue_pop_head(uhid->replay->rout);
+
+		return bt_uhid_replay(uhid);
+	}
+
+	if (!uhid->replay)
+		uhid->replay = uhid_replay_new();
+
+	if (input)
+		queue_push_tail(uhid->replay->in,
+					util_memdup(ev, sizeof(*ev)));
+	else
+		queue_push_tail(uhid->replay->out,
+					util_memdup(ev, sizeof(*ev)));
+
+	return 0;
+}
+
 static bool uhid_read_handler(struct io *io, void *user_data)
 {
 	struct bt_uhid *uhid = user_data;
@@ -93,6 +154,13 @@ static bool uhid_read_handler(struct io *io, void *user_data)
 	if ((size_t) len < sizeof(ev.type))
 		return false;
 
+	switch (ev.type) {
+	case UHID_GET_REPORT:
+	case UHID_SET_REPORT:
+		bt_uhid_record(uhid, false, &ev);
+		break;
+	}
+
 	queue_foreach(uhid->notify_list, notify_handler, &ev);
 
 	return true;
@@ -382,6 +450,9 @@ int bt_uhid_set_report_reply(struct bt_uhid *uhid, uint8_t id, uint8_t status)
 	rsp->id = id;
 	rsp->err = status;
 
+	if (bt_uhid_record(uhid, true, &ev) == -EALREADY)
+		return 0;
+
 	return bt_uhid_send(uhid, &ev);
 }
 
@@ -412,6 +483,9 @@ int bt_uhid_get_report_reply(struct bt_uhid *uhid, uint8_t id, uint8_t number,
 	memcpy(&rsp->data[len], data, rsp->size - len);
 
 done:
+	if (bt_uhid_record(uhid, true, &ev) == -EALREADY)
+		return 0;
+
 	return bt_uhid_send(uhid, &ev);
 }
 
@@ -437,3 +511,54 @@ int bt_uhid_destroy(struct bt_uhid *uhid)
 
 	return err;
 }
+
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
+int bt_uhid_replay(struct bt_uhid *uhid)
+{
+	struct uhid_event *ev;
+
+	if (!uhid || !uhid->started)
+		return -EINVAL;
+
+	if (!uhid->replay)
+		return 0;
+
+	if (uhid->replay->active)
+		goto resend;
+
+	uhid->replay->active = true;
+	queue_destroy(uhid->replay->rin, NULL);
+	uhid->replay->rin = queue_dup(uhid->replay->in);
+
+	queue_destroy(uhid->replay->rout, NULL);
+	uhid->replay->rout = queue_dup(uhid->replay->out);
+
+resend:
+	ev = queue_pop_head(uhid->replay->rout);
+	if (!ev) {
+		uhid->replay->active = false;
+		return 0;
+	}
+
+	queue_foreach(uhid->notify_list, notify_handler, ev);
+
+	return 0;
+}
diff --git a/src/shared/uhid.h b/src/shared/uhid.h
index d70533882727..4e288cb192aa 100644
--- a/src/shared/uhid.h
+++ b/src/shared/uhid.h
@@ -42,3 +42,4 @@ int bt_uhid_set_report_reply(struct bt_uhid *uhid, uint8_t id, uint8_t status);
 int bt_uhid_get_report_reply(struct bt_uhid *uhid, uint8_t id, uint8_t number,
 				uint8_t status, const void *data, size_t size);
 int bt_uhid_destroy(struct bt_uhid *uhid);
+int bt_uhid_replay(struct bt_uhid *uhid);
-- 
2.44.0

