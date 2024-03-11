Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB4652F82
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710187210; cv=none; b=mivnjk/SA1+eRoLiOKZRID4BYpWkzNB3vKv921zkAvj+mw6sXF6Gxyz98R27W0A5V561hpR6x+8ZMT7x9zEIwDu91du0yF7BROtC27IDNhl7731eL35BY7Waea/uN3u3k8VWm/xbect3nNgoUkVIyKYMcL51i09PaFFsAm+mZK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710187210; c=relaxed/simple;
	bh=Pn6EWEVUKNTfV4qrfT5gE9mwsrrqeA5yMSPrmvJ1Gvg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LaYF02lVO7v62B7FG+wHbmBvwLkAgZa0EYiGAV7bkY4FvGUIgQeuEhlZ7eqT+H1ZssTpukBAiTDnx91w+91j/emFGFPdPUlBm1kVqE4yCq71PMxQ0dXXIAjNU30F6hZhZt7B9HnTdm0rz5sDi0Q/jEv7O+qkKyMFe1xGyGW730Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqZiHiEo; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqZiHiEo"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-472640aba12so651489137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 13:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710187206; x=1710792006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jpVoNOZ5bJ9h+Ontz3yq/pYf6LGv4IQfxUBts9yOcSc=;
        b=RqZiHiEoyAeg1n3cQryrHFINdJ3nGZR6oIm5ntZXMh8NT4gI0gGOS3wt6a8PSvXMwH
         siWrwC8MVHWeZpQ8Nx4azGdaKcrdvwmBghCERcT4p+MwiBLKKM8DrpsPNNl5eMTJ10Wh
         TC1/y4dNEELHTSSgl8QM8aW6l/DUOJ1W0s386Ztq7uvU0MvklP5TqVmdxAXmpNfEBzkF
         l8O6TviuMxVAfJiU5db7P+n76EwMIQXhmIX35J6Z8XzEmkt3A99NDZjrgmDhU4p0iIqI
         es+SV2dBDfYlyO/rKZ2folEk0X8p6v2l3yhQOZaYYXwSXLYjA7C6voiw7F7RjPz9e9qS
         DwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710187206; x=1710792006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpVoNOZ5bJ9h+Ontz3yq/pYf6LGv4IQfxUBts9yOcSc=;
        b=vwGJWi4W22Mr6GUPrNMnL/KAccfdwaIfFqqBnt5ld5rkatrUvEeFYnvbi6kbxMQrgQ
         Yp5jyCdh4zm2ZQA0LAuohcxqQddVkyQA8ckB3fFP57TF1ouCbgnQJ+rTgYNZCKj/6VJv
         3wTjkYh33PBW5Vk78agMg1KLicGAxcd5lCL3Edn9WCZb8EfKPRbtganaToa/wGMFgwB9
         zbBhxmw+s6kzCUKQixvS1kPqM/+q7jjQXJhHxgRCJzxA0eFaokz3iL0xH1AsR+7K5E0Q
         guq0YfnZIX4iCOdmdWRBTu3TJUZDe5G8X7Qrvra8YLmpnklE2Ury9YH2g71CqyY2RmiV
         TPvw==
X-Gm-Message-State: AOJu0YzbUBdWafGy6AWpPPcZDOaBfLkqUdi7gQfgIGSNcHkHfnP5sI7Y
	R0IxtiCFQZ+mn2gwrSl5Z4jwCyv3gX7mR0M0NbusjBlTE/QqMLCYqyOee9k8
X-Google-Smtp-Source: AGHT+IF3+yVnHp2KgYEf3wAWSfEXKtzu11o/CHBVaEx3Q/ToBnHNysqVmvkI9/5YGShdfGJWKaqb9A==
X-Received: by 2002:a05:6102:1886:b0:472:eb81:ef29 with SMTP id ji6-20020a056102188600b00472eb81ef29mr4719409vsb.23.1710187205754;
        Mon, 11 Mar 2024 13:00:05 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id g8-20020a056102080800b00472ca24e1c1sm1037414vsb.32.2024.03.11.13.00.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 13:00:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/4] shared/uhid: Add dedicated functions for each UHID opcode
Date: Mon, 11 Mar 2024 16:00:01 -0400
Message-ID: <20240311200004.962953-1-luiz.dentz@gmail.com>
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

