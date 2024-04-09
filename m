Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFAA4D9F4
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712694446; cv=none; b=AqYcQE82+JuAFWiTXA20LiO2QP03mBlqPSJoWC9pfA2nF33fpQklwHij5howue/HL+PJ+OILhh8Sms6l6PfcVnmlkK9TAaF/TijU+YdpSi2/ZSEYFUaGjb1NeAHUKhZ9LX4O/KZ7UTZ/5FE7SwAVExXsYMlc07Z+SgY4eFF26Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712694446; c=relaxed/simple;
	bh=ILElJJf6pzqU4jWqZleD4XVJyNPanZRvKDIV156pH4Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sHfeTXY3heGYWZae/kXuIx4ZziHUOCGMRD3CMIxWb7OciI3CEmhuPbu+ZnIohJFJxpsRANfIwJr3Kb7BuJ2ZNOqL/sVBVEYArGiCnYWWXjL8bt53fjw5QGgPNWzu2+7oKSueO7CR0tI17V/a5MPXpDZfv9PBS7+koJrv6qnwpaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+BkuWNu; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+BkuWNu"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4dad331b828so952066e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2024 13:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712694442; x=1713299242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jb6IJaEcSDhAiBNDodo1z6fcnlHWYbR338+e9/I0VzI=;
        b=b+BkuWNumZXY6oWJ8hVvsW/YOTPw9/FabIkko45NmKF1XlziGD9HcJU0N2bks9jvFX
         bcVPb2TQesDKh8czGu8wfyQYNM7v9glitL+h4xPpDmpmiSaG6/j/52KqpfXGhyT1lZ40
         GfOInNELKQDrmTZmDHVichhdioLJwGQEhXKtlF5RYSI9RGjjvtpPruoscc709Vq5JJhh
         l1sCF9OZI34UFGSYl61n1oannY4LOxHv5QUyMiNf1qymGvbaE4KF3FBzo7jrGVkYJO3S
         7xwsF4FL5UyHQOQ0RirbMaXwt2ODSoJRYMiwJE5B/GCWs1xbLzRM08w8UeOV23So5bci
         xicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712694442; x=1713299242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jb6IJaEcSDhAiBNDodo1z6fcnlHWYbR338+e9/I0VzI=;
        b=oIMILv5XN8T2GzO1y2bClvvZK8K89IO2s88n2i3mfXLLI6e+TaH+wLAj6bkypW3RfJ
         tIqdL09C/9/D+TsW65wmzSneHx3EIs6v3Qtrdng1SUtULKAKe3AQkUw7WCpg0+vl8x85
         GuGZDrhLLl292Frn4BSa+K6Pjn9sYSKUlLx+rrengeETlaF7cQ9/kQfM4vrlVZnOQbFL
         +cWa7pIt+kneAgFRvuU7XQUvRCHuh+VCOuZl4dkZuc3VicQOerEiIsFf/+WC6SNVFyQP
         6+AdiZ3tdEmIfM5zgMzz5FjACn3gWM0ei4TJJdELO8JAGNChZe6Ibj8d5869hIra6Q1b
         qI0A==
X-Gm-Message-State: AOJu0YyJEjxrMIfaKI5SIwGpqURSzlTnpn6iA+taIb8mXJAdo3r9MGzV
	RxwbCoFTGVMwUHjNd8+CR+ipXIbkFSPagmtI6+n53Fwg006DwKidWWqxqxWS
X-Google-Smtp-Source: AGHT+IGDQ/4/EB+7wXEdySk8FWEuEePO2YhvWx5zw6ceajGvRyf66jFP4zDH9yEpx8kopTcTVEGT4Q==
X-Received: by 2002:a05:6122:1817:b0:4d4:b89:bd2a with SMTP id ay23-20020a056122181700b004d40b89bd2amr1118621vkb.3.1712694442335;
        Tue, 09 Apr 2024 13:27:22 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id s184-20020a1ff4c1000000b004d42135c509sm1435323vkh.5.2024.04.09.13.27.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 13:27:21 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/4] shared/uhid: Add support for bt_uhid_replay
Date: Tue,  9 Apr 2024 16:27:17 -0400
Message-ID: <20240409202720.3894858-1-luiz.dentz@gmail.com>
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

