Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078E339AFF
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182702; cv=none; b=KWUhEScySL9mEfi4mgQGZ2YqdMKF3lELvQ/3frxpW4q8FsG3VMytvnYkwmlq3QGBunqY2pzWg8aRx51YdN67Cf3G87/KmzBYaddl7ut8thvXHCEvShFDkjQJQXqCIEB307MtpD/KK8kgLerwjaUxpT4gt4Z/c3KGdO5fqTrnaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182702; c=relaxed/simple;
	bh=LHxjSWUW7L4su5LQZ+xO1z8qYBul1CUvwL5G+oKRD0Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DLsIL20zbfMw7BREqsYFCjczCpyge0MX99/jBvqca2o8lIz5waos+gYXClnlVNctD2b7bg1VEqDZB65WLyUjDORZALVcIfqdh7IHRy4W0UqNsvyl/Ll1BXIz/92O7pAByp67tPbK151lVjCfRtMDaJ1xvLYmPl6uwBlY6Yg5l9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m81JywLH; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m81JywLH"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4d342e854cbso875368e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 11:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710182699; x=1710787499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pAgGs/9bsOxQd6RMYAuYqdx1SzyswJpanvxRvdDtGPg=;
        b=m81JywLHcJ0eiD6fEQUMfUSWrsKq6Vo0KIjnwVng8nbRwz0bISoQovIEYZFC0gCTkm
         nRzOfrs9XlPL7c4Fgd0AiiIcBg+8S+xuTTx8a9s9atf9K1s/apMQ8MBGH5mtVlU735Uu
         g4ZREEl8VOujttf0BUwF1g1pyAMgz+/2covxoWpWsbrqOjUnaiz+ufIoUjrwBABJrjHw
         AxEs5zna94nfj9nPHaY8opzXU0v/u3sh1HDJ5ZWcmm5oRr+5Pzb0BLroEv1SJD+xqpTI
         8l1RF3dkTa+Kof6DYO/hB0V5t/JBCJiN6aD7Z1lKgREHBDpuM8zrCPAHzJgZ8Khi3w1G
         tR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710182699; x=1710787499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAgGs/9bsOxQd6RMYAuYqdx1SzyswJpanvxRvdDtGPg=;
        b=XndvpwUAaAFBA0e9MZSsxFe/ZDDJcFeT8eieApeOiV5QZeY6PH7n7oD5WPKXcz6QEe
         PYF1upI52cx0ZLnrgBAElaoCVx0HUBhUpCoqI6ezOppNEa8RNatNFAveFGzDsr/vVUBS
         Fk8QwahSRMbq2aJCdmmUQbIIwXP/EsaFQx7hq5x3eHpEqKbPCxkjsaXYL0cGPxtaQ6YC
         jmyQa8wE98mQ0l7bL28O0WDxtU+mVv6r/pFWUDlbX1RbiT97mUHd0w9QGuTuJ5id9sCJ
         UeeFGl7hxHLtkKwJ5ONsygfcuBLZfwCS3Lj1VII2I9L7FolRdZeIhAgZoURvGSOYJHdE
         lkhg==
X-Gm-Message-State: AOJu0Yy8OM+VPXuLfvJr1ekU5i8pQB2V8n+ZJ3/Hebr8AaV7ZiY73nat
	BKBBWO0O4FoJQRpr2tapdmjgfkoByyy534qFTBqWDQbnH5CEqLd1U+nPbjSL
X-Google-Smtp-Source: AGHT+IH8QxXS0isJa7lc8QNLUK/sYwleCA5yY+ifQPz1PJFQaZaP0lfd08IoJfR7sj96/PlRJEtr6w==
X-Received: by 2002:a1f:ca01:0:b0:4d3:3846:73bb with SMTP id a1-20020a1fca01000000b004d3384673bbmr1035539vkg.7.1710182698580;
        Mon, 11 Mar 2024 11:44:58 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id i15-20020a056122128f00b004c003cf5e14sm672510vkp.28.2024.03.11.11.44.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:44:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/4] shared/uhid: Add dedicated functions for each UHID opcode
Date: Mon, 11 Mar 2024 14:44:53 -0400
Message-ID: <20240311184456.890351-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_uhid_create which uses UHID_CREATE2 and tracks progress of
when the device is ready to receive events and in the meantime queues
them while waiting for UHID_START and other dedicated functions for each
UHID opcode so users don't need to build each command manually.
---
 src/shared/uhid.c | 209 +++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/uhid.h |  13 +++
 2 files changed, 218 insertions(+), 4 deletions(-)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 1f15443cd6d0..5e846e52e244 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -26,11 +26,18 @@
 
 #define UHID_DEVICE_FILE "/dev/uhid"
 
+#ifndef MIN
+#define MIN(x, y) ((x) < (y) ? (x) : (y))
+#endif
+
 struct bt_uhid {
 	int ref_count;
 	struct io *io;
 	unsigned int notify_id;
 	struct queue *notify_list;
+	struct queue *input;
+	bool created;
+	bool started;
 };
 
 struct uhid_notify {
@@ -48,6 +55,9 @@ static void uhid_free(struct bt_uhid *uhid)
 	if (uhid->notify_list)
 		queue_destroy(uhid->notify_list, free);
 
+	if (uhid->input)
+		queue_destroy(uhid->input, free);
+
 	free(uhid);
 }
 
@@ -215,14 +225,11 @@ bool bt_uhid_unregister_all(struct bt_uhid *uhid)
 	return true;
 }
 
-int bt_uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev)
+static int uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev)
 {
 	ssize_t len;
 	struct iovec iov;
 
-	if (!uhid->io)
-		return -ENOTCONN;
-
 	iov.iov_base = (void *) ev;
 	iov.iov_len = sizeof(*ev);
 
@@ -233,3 +240,197 @@ int bt_uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev)
 	/* uHID kernel driver does not handle partial writes */
 	return len != sizeof(*ev) ? -EIO : 0;
 }
+
+int bt_uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev)
+{
+	if (!uhid->io)
+		return -ENOTCONN;
+
+	/* Queue events if uhid has not been created yet */
+	if (!uhid->started) {
+		if (!uhid->input)
+			uhid->input = queue_new();
+
+		queue_push_tail(uhid->input, util_memdup(ev, sizeof(*ev)));
+		return 0;
+	}
+
+	return uhid_send(uhid, ev);
+}
+
+static bool input_dequeue(const void *data, const void *match_data)
+{
+	struct uhid_event *ev = (void *)data;
+	struct bt_uhid *uhid = (void *)match_data;
+
+	return bt_uhid_send(uhid, ev) == 0;
+}
+
+static void uhid_start(struct uhid_event *ev, void *user_data)
+{
+	struct bt_uhid *uhid = user_data;
+
+	uhid->started = true;
+
+	/* dequeue input events send while UHID_CREATE2 was in progress */
+	queue_remove_all(uhid->input, input_dequeue, uhid, free);
+}
+
+int bt_uhid_create(struct bt_uhid *uhid, const char *name, bdaddr_t *src,
+			bdaddr_t *dst, uint32_t vendor, uint32_t product,
+			uint32_t version, uint32_t country, void *rd_data,
+			size_t rd_size)
+{
+	struct uhid_event ev;
+	int err;
+
+	if (!uhid || !name || rd_size > sizeof(ev.u.create2.rd_data))
+		return -EINVAL;
+
+	if (uhid->created)
+		return 0;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_CREATE2;
+	strncpy((char *) ev.u.create2.name, name,
+			sizeof(ev.u.create2.name) - 1);
+	if (src)
+		sprintf((char *)ev.u.create2.phys,
+			"%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x",
+			src->b[5], src->b[4], src->b[3], src->b[2], src->b[1],
+			src->b[0]);
+	if (dst)
+		sprintf((char *)ev.u.create2.uniq,
+			"%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x",
+			dst->b[5], dst->b[4], dst->b[3], dst->b[2], dst->b[1],
+			dst->b[0]);
+	ev.u.create2.vendor = vendor;
+	ev.u.create2.product = product;
+	ev.u.create2.version = version;
+	ev.u.create2.country = country;
+	ev.u.create2.bus = BUS_BLUETOOTH;
+	if (rd_size)
+		memcpy(ev.u.create2.rd_data, rd_data, rd_size);
+	ev.u.create2.rd_size = rd_size;
+
+	err = uhid_send(uhid, &ev);
+	if (err)
+		return err;
+
+	bt_uhid_register(uhid, UHID_START, uhid_start, uhid);
+
+	uhid->created = true;
+	uhid->started = false;
+
+	return 0;
+}
+
+bool bt_uhid_created(struct bt_uhid *uhid)
+{
+	if (!uhid)
+		return false;
+
+	return uhid->created;
+}
+
+bool bt_uhid_started(struct bt_uhid *uhid)
+{
+	if (!uhid)
+		return false;
+
+	return uhid->started;
+}
+
+int bt_uhid_input(struct bt_uhid *uhid, uint8_t number, const void *data,
+			size_t size)
+{
+	struct uhid_event ev;
+	struct uhid_input2_req *req = &ev.u.input2;
+	size_t len = 0;
+
+	if (!uhid)
+		return -EINVAL;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_INPUT2;
+
+	if (number) {
+		req->data[len++] = number;
+		req->size = 1 + MIN(size, sizeof(req->data) - 1);
+	} else
+		req->size = MIN(size, sizeof(req->data));
+
+	if (data && size)
+		memcpy(&req->data[len], data, req->size - len);
+
+	return bt_uhid_send(uhid, &ev);
+}
+
+int bt_uhid_set_report_reply(struct bt_uhid *uhid, uint8_t id, uint8_t status)
+{
+	struct uhid_event ev;
+	struct uhid_set_report_reply_req *rsp = &ev.u.set_report_reply;
+
+	if (!uhid)
+		return false;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_SET_REPORT_REPLY;
+	rsp->id = id;
+	rsp->err = status;
+
+	return bt_uhid_send(uhid, &ev);
+}
+
+int bt_uhid_get_report_reply(struct bt_uhid *uhid, uint8_t id, uint8_t number,
+				uint8_t status, const void *data, size_t size)
+{
+	struct uhid_event ev;
+	struct uhid_get_report_reply_req *rsp = &ev.u.get_report_reply;
+	size_t len = 0;
+
+	if (!uhid)
+		return false;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_GET_REPORT_REPLY;
+	rsp->id = id;
+	rsp->err = status;
+
+	if (!data || !size)
+		goto done;
+
+	if (number) {
+		rsp->data[len++] = number;
+		rsp->size += MIN(size, sizeof(rsp->data) - 1);
+	} else
+		rsp->size = MIN(size, sizeof(ev.u.input.data));
+
+	memcpy(&rsp->data[len], data, rsp->size - len);
+
+done:
+	return bt_uhid_send(uhid, &ev);
+}
+
+int bt_uhid_destroy(struct bt_uhid *uhid)
+{
+	struct uhid_event ev;
+	int err;
+
+	if (!uhid)
+		return -EINVAL;
+
+	if (!uhid->created)
+		return 0;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_DESTROY;
+
+	err = bt_uhid_send(uhid, &ev);
+	if (err < 0)
+		return err;
+
+	uhid->created = false;
+
+	return err;
+}
diff --git a/src/shared/uhid.h b/src/shared/uhid.h
index 55ae839f3017..d70533882727 100644
--- a/src/shared/uhid.h
+++ b/src/shared/uhid.h
@@ -11,6 +11,7 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <linux/uhid.h>
+#include <bluetooth/bluetooth.h>
 
 struct bt_uhid;
 
@@ -29,3 +30,15 @@ bool bt_uhid_unregister(struct bt_uhid *uhid, unsigned int id);
 bool bt_uhid_unregister_all(struct bt_uhid *uhid);
 
 int bt_uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev);
+int bt_uhid_create(struct bt_uhid *uhid, const char *name, bdaddr_t *src,
+			bdaddr_t *dst, uint32_t vendor, uint32_t product,
+			uint32_t version, uint32_t country, void *rd_data,
+			size_t rd_size);
+bool bt_uhid_created(struct bt_uhid *uhid);
+bool bt_uhid_started(struct bt_uhid *uhid);
+int bt_uhid_input(struct bt_uhid *uhid, uint8_t number, const void *data,
+			size_t size);
+int bt_uhid_set_report_reply(struct bt_uhid *uhid, uint8_t id, uint8_t status);
+int bt_uhid_get_report_reply(struct bt_uhid *uhid, uint8_t id, uint8_t number,
+				uint8_t status, const void *data, size_t size);
+int bt_uhid_destroy(struct bt_uhid *uhid);
-- 
2.43.0

