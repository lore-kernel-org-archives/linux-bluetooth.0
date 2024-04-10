Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6848516EC05
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757732; cv=none; b=l/XOKJLm33wOxv+D8DQ5slxer4nlT5YoOdwNZV9gZxOk+vre7mlnzy2/+B43UytA+yYn4tT9HaXKbH84fs/h/j82WFPPR+7dxTq/fpo8El14eEFxJPPGymVwqtHIbaAAF5ZtCq3jdg7SmMOlKl4iHgnQlgXQywRY7jCRwuEg2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757732; c=relaxed/simple;
	bh=9qEeY8ce9NTsYeXB9XR4V94CfHOjFW4i3Rh4UyztQt0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LWlnp7TcR69gjESYfeq54mH/M+J8AWUVm6D+NQyuOVXfR69vwGmKNoVGrguTtXor215lFkbbb2u0GiDWt5HnQd8Eh7WEMZ2ms62TtSLyApKJQmjb/lGqtkYB2b/j0HUOmLgg7deG53QvrSlA3wSTvf+XFFU4B+EEBqjyrB5K8XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQvrh8hn; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQvrh8hn"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ea1ef9e4e9so1161193a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712757727; x=1713362527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=znUCbzAFqqxj2EC3Fo1pRbFzH6GbgNSgZ0IkeF55glU=;
        b=dQvrh8hn7kO0YcRI1dI2rcZrfcBsRmHu8m9pUmFwO8k40hWC9KQCoihThcIiuCMPsM
         LEKatxQl/qrpyQJA+vOM3RVX5aG3xsjC6gA+K7PRoirn//oc2Keto+Ovq+ctZAbBs3KF
         qUL891FnkyfbCANJ7QENSnu7z9ypnePMz+nsa5OAB2PEZOW0LLbq+DQ+BexHKL9B/w4C
         dTLEliRdAujrDRbm+i/sId+zYSzcrPZMl17OPX1F5SJixh9l7s48WgV//X1bBRgKUlZu
         BV2sbaj28HumZ6l/EI5Od7hSNRownp6OwW/ZfvNTvc1coX2Aou/nYc8oKJmS6VXQ1bj3
         LdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757727; x=1713362527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znUCbzAFqqxj2EC3Fo1pRbFzH6GbgNSgZ0IkeF55glU=;
        b=O0AMEYKtLa2ID+tGnpIn6O+ZUNZ431/J5H8+E72Q8omy4iK61tVp5WfNgkw0cLynWr
         pmjYI3kYWYTu37SGPO3BNNZCwdcnoAslL0TU40NUlWxuLFoAs0Xjxd/w0t8JQj6mAr6R
         EQYqbSspnE5vX8XOTGZmUYWnhyyc/oOmgScVKLfA1nLN4pcJU49jFORaN61vV/UQ1PMJ
         TgTIU93uCJmMy8GGbj4QQZeEHuclQZyAzJnrBwTAz4AQiX9xUyJ4V/FHZvBa+8LlWMlb
         lwsgvz8+qi8z6wbCANNY9BNDeNeGf+Y9wIU5kwdDqnMNxAL/aMaCub2onW+f7NmN9ZZd
         bcgA==
X-Gm-Message-State: AOJu0Yyy8WUp7Csvki/9/EEsj/exb7T0lIrTSw7gqYEz2UKa+hQsusAa
	e41LG+cKb58YQdrh408fkH83iIbCgTGdG/HKxrCkkkPH4LMW9uBrLnUc1c+2
X-Google-Smtp-Source: AGHT+IEARmW5oLs+hnd5Hy9a/l8b20theT6ProWHhtL4hqHi83e+YklvD8wqleIUaHJ7uXQWuXpdEQ==
X-Received: by 2002:a05:6808:3a96:b0:3c5:e03a:23be with SMTP id fb22-20020a0568083a9600b003c5e03a23bemr2602536oib.42.1712757727271;
        Wed, 10 Apr 2024 07:02:07 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id k21-20020ab07555000000b007e3199adc5dsm1382051uaq.0.2024.04.10.07.02.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:02:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/4] shared/uhid: Add support for bt_uhid_replay
Date: Wed, 10 Apr 2024 10:02:02 -0400
Message-ID: <20240410140205.4056047-1-luiz.dentz@gmail.com>
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
 src/shared/uhid.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/uhid.h |   1 +
 2 files changed, 124 insertions(+)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 46edb3bfa3ba..690d58d7bd78 100644
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
 
@@ -73,6 +96,42 @@ static void notify_handler(void *data, void *user_data)
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
+	/* Capture input events in replay mode and send the next replay event */
+	if (uhid->replay && uhid->replay->active && input) {
+		queue_pop_head(uhid->replay->rin);
+		bt_uhid_replay(uhid);
+		return -EALREADY;
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
@@ -93,6 +152,13 @@ static bool uhid_read_handler(struct io *io, void *user_data)
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
@@ -382,6 +448,9 @@ int bt_uhid_set_report_reply(struct bt_uhid *uhid, uint8_t id, uint8_t status)
 	rsp->id = id;
 	rsp->err = status;
 
+	if (bt_uhid_record(uhid, true, &ev) == -EALREADY)
+		return 0;
+
 	return bt_uhid_send(uhid, &ev);
 }
 
@@ -412,6 +481,9 @@ int bt_uhid_get_report_reply(struct bt_uhid *uhid, uint8_t id, uint8_t number,
 	memcpy(&rsp->data[len], data, rsp->size - len);
 
 done:
+	if (bt_uhid_record(uhid, true, &ev) == -EALREADY)
+		return 0;
+
 	return bt_uhid_send(uhid, &ev);
 }
 
@@ -437,3 +509,54 @@ int bt_uhid_destroy(struct bt_uhid *uhid)
 
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

