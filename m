Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33706249E5
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935813; cv=none; b=TuWNhwtas4oFKJ6BNmuRqXaHM+K73J1akjqcL7M5Qm2qmpLQSqRgkFXKbJs/jCE1HgPBQXVq6k8wlEsC1raLp+4puUXlBhKn3lOCcIcvjQFUIseTdNMQwsg6vWATeMXvyjG7FTnSzEajQaaQaYTGMbZkcYbVB4aM/GJd+w/zoU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935813; c=relaxed/simple;
	bh=DNyP33agfGHPY+dqdalB1KLZt2pi4f8waQaBbzx6DFQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=A3BbT0cvQIs+y/dd5id+8FveDjhyOM6SzT5Pl9vQgD4NM2jektXzDde6nCVayDnx1Y6R1I5pf6v3hiHKo6KYj2tAHGNICunKlBz9ihgMMdqhOltpnqwRC9av65RJyHaDkuJyw73Tw08JvqqIR0PeuK88Z/SMkfkHeUu/YEOf/20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEmFi5ly; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEmFi5ly"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7db36dbd474so672453241.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Mar 2024 14:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709935810; x=1710540610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qN6c7ByMY6yhJzfLVBeV1zP/KZNHGV/rYowEImsJWA=;
        b=EEmFi5lyeEK/NF8yEwv1ZcbhaApD89GNYIMJM6JRn+bkCdEYwVaeSKVPTpgR/PLxvV
         MVbgk5FuN9NkLqh+fJm/6ATHiqCMvk9SXSsZ+oa4wHMCVkQQqjRG8atwLEWdwt3LkR0J
         UkXG1ICONBNEqC0sb2RcVXIQk3hCtVcz3pkd7HEVgKnkCUvTLuyGzJFSQsPAhel1RxtE
         OvJ6sUFq2pniaYOzPH7Z465NhE7SN0/ASZzpkDPtUCseIuoNQyH6NtVdI4DF2InWXsGP
         S3zMzctNA+MnH8So2nm34sMsKyaoiV24CCHxEdmec1bG9msYGUuaboBDU6eIzntVcwXk
         ujTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709935810; x=1710540610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qN6c7ByMY6yhJzfLVBeV1zP/KZNHGV/rYowEImsJWA=;
        b=KpfBNNIVyKj8llCukzCOvKXOyDGsruWbWpIicYH7oeNRZNGGA0IUHxmRaRA++rU+k1
         S9e4L2g8b+PpCZv9+9hHhPHYMYJ3CB3GkXCCrsLTEY3t8WTlGLgi368Lu2LrcKT29uHt
         7abEd3fHyPdicP9kzKPmiE1iQtkz+TXpwbGcii4eeGa8sCXAnIV8mmpoI7G8Rl4yOxet
         TH8OzqWrMbf01RmO2K+qEjWxsLUKq7cSt9gjmNHkReGSySckMyfTFUKf2KlDtU+f3v8/
         rcT1FSvwHtQZyAJg83wX/aJk3BBKbsCuVdZHVBj+L4kd0E2JcfsCJV6evTw2KyiarG5k
         POxQ==
X-Gm-Message-State: AOJu0YxhfV97klHvIZlBYBZbMYXbrQ6RZZPOVCDDkQGHrSgA4WFgZb8Y
	n19br4ZGKRGAVPpV57ajTGo1UqiB88iJCl7WzhO7JTeIzPH6/xxXNmzDlO7k
X-Google-Smtp-Source: AGHT+IFBR0boDZqrEgSpDj02mcEtyUbYWOtMLIHJrHJGr5bRKCMmuNxKTGY2HlonsWozgs6peVK1Kw==
X-Received: by 2002:a05:6122:c9:b0:4d3:4aad:7bf0 with SMTP id h9-20020a05612200c900b004d34aad7bf0mr573624vkc.0.1709935809848;
        Fri, 08 Mar 2024 14:10:09 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id el15-20020a056122278f00b004d33d93758asm29039vkb.23.2024.03.08.14.10.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:10:09 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/4] shared/uhid: Add bt_uhid_create
Date: Fri,  8 Mar 2024 17:10:04 -0500
Message-ID: <20240308221007.250681-1-luiz.dentz@gmail.com>
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
them while waiting for UHID_START.
---
 src/shared/uhid.c | 134 ++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/uhid.h |   8 +++
 2 files changed, 138 insertions(+), 4 deletions(-)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 1f15443cd6d0..65e2d018a82e 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -31,6 +31,9 @@ struct bt_uhid {
 	struct io *io;
 	unsigned int notify_id;
 	struct queue *notify_list;
+	struct queue *input;
+	bool created;
+	bool started;
 };
 
 struct uhid_notify {
@@ -48,6 +51,9 @@ static void uhid_free(struct bt_uhid *uhid)
 	if (uhid->notify_list)
 		queue_destroy(uhid->notify_list, free);
 
+	if (uhid->input)
+		queue_destroy(uhid->input, free);
+
 	free(uhid);
 }
 
@@ -215,14 +221,11 @@ bool bt_uhid_unregister_all(struct bt_uhid *uhid)
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
 
@@ -233,3 +236,126 @@ int bt_uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev)
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
+		queue_push_tail(uhid->input, util_memdup(&ev, sizeof(ev)));
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
index 55ae839f3017..8d5dfd6e45c9 100644
--- a/src/shared/uhid.h
+++ b/src/shared/uhid.h
@@ -11,6 +11,7 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <linux/uhid.h>
+#include <bluetooth/bluetooth.h>
 
 struct bt_uhid;
 
@@ -29,3 +30,10 @@ bool bt_uhid_unregister(struct bt_uhid *uhid, unsigned int id);
 bool bt_uhid_unregister_all(struct bt_uhid *uhid);
 
 int bt_uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev);
+int bt_uhid_create(struct bt_uhid *uhid, const char *name, bdaddr_t *src,
+			bdaddr_t *dst, uint32_t vendor, uint32_t product,
+			uint32_t version, uint32_t country, void *rd_data,
+			size_t rd_size);
+bool bt_uhid_created(struct bt_uhid *uhid);
+bool bt_uhid_started(struct bt_uhid *uhid);
+int bt_uhid_destroy(struct bt_uhid *uhid);
-- 
2.43.0

