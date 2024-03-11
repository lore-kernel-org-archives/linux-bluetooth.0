Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0845810E
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197012; cv=none; b=QERIgXihTcQ3AfqDxV3Pia6z1uLNdCd/pAcGvif6I2XUYWOnFik1GTP/UFPL4abdL6oUVl1xztkf1BXlfIs5pIDSCLeuYZ6ZyoE8Nd33xqwwBFTxFd6o0yjen7tHVGV72mIxF7CADGJJkDRMueVxRX4rocB1FsRpD1lfIPlmdhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197012; c=relaxed/simple;
	bh=Pn6EWEVUKNTfV4qrfT5gE9mwsrrqeA5yMSPrmvJ1Gvg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Un+by6+pCKJNtisuxPHYwYLMTh4IwC/ME7UdMIH6d3Fo3v7FtUDnSUNk3M1qJu+204mNPY1YNXolhaYHp4sNRHh1YE89ciP4wZIwgKh50qpVhuk0pt5ClkRAFQ7yszqCV42Yp85B2Ghh4xR9NUvvmUBqVlQPQLY/uwPWYYaQfkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJC4gZ7c; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJC4gZ7c"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7db44846727so1436014241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 15:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710197009; x=1710801809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jpVoNOZ5bJ9h+Ontz3yq/pYf6LGv4IQfxUBts9yOcSc=;
        b=YJC4gZ7cPk7TDauIYHJYXYwhlXjB2QhPiYFHlh2vunFs9qJY0VBTKXgztollas1BDr
         phtAiEY/zDGF5QVbPz/aIsmRenLld09oUGJzE1cR3II6++1Uh20uIai1bdXBlz+EOUaa
         YxrBodSr19om4Q9mFyiEqAvtZRV3rvhe24CCW1hANULLQEc2gxB3/0gFa737x27D3Hmc
         hGqVXBJ6bLrHiH4WQgWzY0F6C7WBv5Hor9sWOKgcpjqIs5EIHVypEo4iwo3VMnDEjjrY
         BqQiEE05g/NQG8wSDJJtKiaJYxG0fR1ZKxHuSaxp6niIFtgMU+wcve5HONSsFrKUAYKv
         9o+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710197009; x=1710801809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpVoNOZ5bJ9h+Ontz3yq/pYf6LGv4IQfxUBts9yOcSc=;
        b=d3w/Ap+hlFYifQGjJKBErIMDwEQdC1mGt4IH7uFANYBNg/ikiVXKNCcpjKZUafL7J+
         Uq1WIz2CJopckQfgJziiQNDZBek+D5NP0nnEBNP1792iM0+cauNRyU1Nd7sypzUt6uRE
         1ZMMUsUko/gpGi8qp2Yx+7ga7EW+P1OLwllLvWUw1/rWWbzGtjgWIjqMvWmyvSKR+zaQ
         ku2308+UamMq7NxsN5mCDBpsE/8+NIRZSPUXwLpDWWV6xBr4YfbgTxSao3II+a78nHGv
         IxNrahycPzvyv9aw6Qz9+1In0MRfJgOeMPImrZ7KpENjSgMUBcH41rOclRFiKDof2lho
         jhPQ==
X-Gm-Message-State: AOJu0Yx2zixlOV3lOP+eJVItJFBxHj3NxPP7YarEgW3Bf5QbqkgB2my8
	0gFhCOHt9n+fit2zpqLax9MKtSa8dOZOvaFxlZ1i6JYECu3hHEeEXzZgRtBF
X-Google-Smtp-Source: AGHT+IE5geR8MPiJusXr3+10tG126rjkz4iiUqvt/ZDmJGy0xDntEgIjBd+LKdK1KpiXFBzEU4MV7g==
X-Received: by 2002:a67:b64c:0:b0:471:e077:6ae6 with SMTP id e12-20020a67b64c000000b00471e0776ae6mr3806544vsm.34.1710197008996;
        Mon, 11 Mar 2024 15:43:28 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id db12-20020a056130238c00b007dbb2f61472sm829979uab.38.2024.03.11.15.43.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 15:43:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/4] shared/uhid: Add dedicated functions for each UHID opcode
Date: Mon, 11 Mar 2024 18:43:24 -0400
Message-ID: <20240311224327.1023070-1-luiz.dentz@gmail.com>
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
 src/shared/uhid.c | 212 +++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/uhid.h |  13 +++
 2 files changed, 221 insertions(+), 4 deletions(-)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 1f15443cd6d0..46edb3bfa3ba 100644
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
 
@@ -233,3 +240,200 @@ int bt_uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev)
 	/* uHID kernel driver does not handle partial writes */
 	return len != sizeof(*ev) ? -EIO : 0;
 }
+
+int bt_uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev)
+{
+	if (!uhid || !ev)
+		return -EINVAL;
+
+	if (!uhid->io)
+		return -ENOTCONN;
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
+	err = bt_uhid_send(uhid, &ev);
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
+	/* Queue events if UHID_START has not been received yet */
+	if (!uhid->started) {
+		if (!uhid->input)
+			uhid->input = queue_new();
+
+		queue_push_tail(uhid->input, util_memdup(&ev, sizeof(ev)));
+		return 0;
+	}
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

