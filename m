Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D292594A5
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944939; cv=none; b=pJG/3ve7B1EDRVLyEx5lCIO3732K4EOtrrODhUX6S3tcrFPD4tiQTI2IDgxg8npAMikl3vG9+niD3D+J4Q4kIEOtS3CBrYiXHWvUY8W6Y2HQFtQwi9+5P+ZDT+mJpQvvMjZGihax9vmfRwB1HqT4kJ4pyy8oX+xR4pa+3KKybPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944939; c=relaxed/simple;
	bh=I0n9LK9zLvKnXaW4qNFNgPI/oHV6vcN6W8qVrw58/zg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+KnQVhqm4UnTRCRMDyKqKrCYAxFAV11+cq+uFiJxRGuyKINxnLgCIT+Of1qFKufpYjVYMmF7vUvUynVau81loY4Wgsb6jKzjpXc7GUHhCPcrCSQ0BdPJMVW6ilqI/GaWG5CHRw+axEtZDPb/Yv57IvOtabZ0lz+FbD2eSaFqYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXImVlD3; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXImVlD3"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6eff8289d0eso41247517b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 11:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733944936; x=1734549736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqZ+hDDdMqwXULgN8ppCmOgZdkVn2oHoO3C1NkZIkZU=;
        b=EXImVlD37csdSeINeg4NHOqzduHrrE9P9X1bl/BrJMz5UV2Cy0Czcy9VU8yXRLzcTh
         +aVWrsRrfY06BpeLKUR1UIxugst8NmijxEGNFKXRg2yIBgMtqi3K0XIIroHzSyoOdPXY
         1VSh+DDWj7pMKpq2kFkC8pqThCtrAHsup7AxTwCY+sWuMnlFmKQqDOkrXdjae29RF9WI
         hhnzBadsgG3FpPrwDljr5oCwenSasIGeVT27et9P+oDlMMBBtJhFOoOf5bMcuqO6RaJY
         fVFmTHlgfhLwzIHw+gVTiGWRTJG/WEU59uaCeP+1pQpCGsoo6XNkiqAl2C7dsvh2x1j8
         ygTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733944936; x=1734549736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqZ+hDDdMqwXULgN8ppCmOgZdkVn2oHoO3C1NkZIkZU=;
        b=m1gQ9uo0yJ99YyaxQ/Nih39rFING4MZNk3yNUe332YXCWEdLOjF34DXFJ1n/mcRsfe
         JGvgw99A5Rg78A5KL/74HYVuAaHZtNQUR7ic8KuysEbWRqnvzO4GElkIzbEdN5DaP6YX
         QtIkaFdRLJWmHd0QgoRaGfboYsJPHpTfl2/4scpXl4Wu7eY3H3wxjTmkW5yuQJhFrg3q
         ynCAjqGwxFslKJeTNkX2pf+q7gyj2YJpwIZnYxDgO9eerv0d65iRqazd9LwUNPyKFOPN
         gFQfWtajwTvL1td7Y3Cj9mS5/10qk5TPGYNaZsykaVMVKCj8NKUyzqlH5G0WB4sixDBp
         C+gQ==
X-Gm-Message-State: AOJu0YxfycZZ3M8tNmRo2rBPuBcp0om/g7/fdhn22WK7+LaPdMvx8o1P
	/SxBJY+0/grpKAbKOAyhaYJd5m8pRSKTaLVOenDdJV4chqK2/6iTJAb3LA==
X-Gm-Gg: ASbGnctMcuzgdVv0zaeaT6Z164MQnKZVQlfSLux0jWfktN8bla8wJqwdnBtkfJq9Lr0
	SJog5CKAZDrJ2e7wYxrXUGQtRZ8HNnm+YqRxy2FIfPiKtMSQa2hZJtbt29x0e5QJCdQzp7ZM/Gt
	gZY7rXvhXLvfidpTD6TrHUKm1k/qKvPPrXQL2AVhNCmAUsx5AYqAvze8nZwGztOVh7HIZ2IWzkG
	Ec2m7P4OWXJxYSJcHp4QYstrZfzbOlD4C5uZBIUgvevnIiqoyPownoQxUgEsz1zkJU2nAEtfWXt
	bKdFXE1P7yi251xKvfaSUsrfyA==
X-Google-Smtp-Source: AGHT+IEEA5I2Z5bbD4RqQbjMiIiySjjuHSHIvcqSiCZohjSqGHav3PMQwKMrmnZtqcjlZiqlMu+OMA==
X-Received: by 2002:a05:690c:d8d:b0:6ef:5013:bfd9 with SMTP id 00721157ae682-6f19e4eea0dmr7828827b3.10.1733944935642;
        Wed, 11 Dec 2024 11:22:15 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f14ce8be30sm3670077b3.79.2024.12.11.11.22.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:22:14 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/5] share/hci: Introduce bt_hci_send_data
Date: Wed, 11 Dec 2024 14:22:08 -0500
Message-ID: <20241211192210.1864347-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211192210.1864347-1-luiz.dentz@gmail.com>
References: <20241211192210.1864347-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces bt_hci_send_data which can be used to send ACL, SCO or
ISO data packets to the underline HCI socket.
---
 src/shared/hci.c | 112 +++++++++++++++++++++++++++++++++++++++++++----
 src/shared/hci.h |   3 ++
 2 files changed, 106 insertions(+), 9 deletions(-)

diff --git a/src/shared/hci.c b/src/shared/hci.c
index f741a2bf5ca9..07fdffc82e0c 100644
--- a/src/shared/hci.c
+++ b/src/shared/hci.c
@@ -17,6 +17,11 @@
 #include <string.h>
 #include <sys/socket.h>
 #include <sys/uio.h>
+#include <sys/un.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
 
 #include "monitor/bt.h"
 #include "src/shared/mainloop.h"
@@ -53,6 +58,7 @@ struct bt_hci {
 	struct queue *cmd_queue;
 	struct queue *rsp_queue;
 	struct queue *evt_list;
+	struct queue *data_queue;
 };
 
 struct cmd {
@@ -73,6 +79,13 @@ struct evt {
 	void *user_data;
 };
 
+struct data {
+	uint8_t type;
+	uint16_t handle;
+	void *data;
+	uint8_t size;
+};
+
 static void cmd_free(void *data)
 {
 	struct cmd *cmd = data;
@@ -94,6 +107,14 @@ static void evt_free(void *data)
 	free(evt);
 }
 
+static void data_free(void *data)
+{
+	struct data *d = data;
+
+	free(d->data);
+	free(d);
+}
+
 static void send_command(struct bt_hci *hci, uint16_t opcode,
 						void *data, uint8_t size)
 {
@@ -126,17 +147,44 @@ static void send_command(struct bt_hci *hci, uint16_t opcode,
 	hci->num_cmds--;
 }
 
+static void send_data(struct bt_hci *hci, uint8_t type, uint16_t handle,
+						void *data, uint16_t size)
+{
+	struct iovec iov[3];
+	struct bt_hci_acl_hdr hdr;
+
+	hdr.handle = cpu_to_le16(handle);
+	hdr.dlen = cpu_to_le16(size);
+
+	iov[0].iov_base = &type;
+	iov[0].iov_len  = 1;
+	iov[1].iov_base = &hdr;
+	iov[1].iov_len  = sizeof(hdr);
+	iov[2].iov_base = data;
+	iov[2].iov_len  = size;
+
+	io_send(hci->io, iov, 3);
+}
+
 static bool io_write_callback(struct io *io, void *user_data)
 {
 	struct bt_hci *hci = user_data;
 	struct cmd *cmd;
+	struct data *data;
 
-	cmd = queue_pop_head(hci->cmd_queue);
-	if (cmd) {
-		send_command(hci, cmd->opcode, cmd->data, cmd->size);
-		queue_push_tail(hci->rsp_queue, cmd);
+	if (hci->num_cmds) {
+		cmd = queue_pop_head(hci->cmd_queue);
+		if (cmd) {
+			send_command(hci, cmd->opcode, cmd->data, cmd->size);
+			queue_push_tail(hci->rsp_queue, cmd);
+		}
 	}
 
+	data = queue_pop_head(hci->data_queue);
+	if (data)
+		send_data(hci, data->type, data->handle,
+					data->data, data->size);
+
 	hci->writer_active = false;
 
 	return false;
@@ -147,10 +195,7 @@ static void wakeup_writer(struct bt_hci *hci)
 	if (hci->writer_active)
 		return;
 
-	if (hci->num_cmds < 1)
-		return;
-
-	if (queue_isempty(hci->cmd_queue))
+	if (queue_isempty(hci->cmd_queue) && queue_isempty(hci->data_queue))
 		return;
 
 	if (!io_set_write_handler(hci->io, io_write_callback, hci, NULL))
@@ -300,11 +345,13 @@ static struct bt_hci *create_hci(int fd)
 	hci->cmd_queue = queue_new();
 	hci->rsp_queue = queue_new();
 	hci->evt_list = queue_new();
+	hci->data_queue = queue_new();
 
 	if (!io_set_read_handler(hci->io, io_read_callback, hci, NULL)) {
 		queue_destroy(hci->evt_list, NULL);
 		queue_destroy(hci->rsp_queue, NULL);
 		queue_destroy(hci->cmd_queue, NULL);
+		queue_destroy(hci->data_queue, NULL);
 		io_destroy(hci->io);
 		free(hci);
 		return NULL;
@@ -353,8 +400,11 @@ struct bt_hci *bt_hci_new_user_channel(uint16_t index)
 	int fd;
 
 	fd = create_socket(index, HCI_CHANNEL_USER);
-	if (fd < 0)
+	if (fd < 0) {
+		printf("Unable to create user channel socket: %s(%d)\n",
+			strerror(errno), -errno);
 		return NULL;
+	}
 
 	hci = create_hci(fd);
 	if (!hci) {
@@ -423,6 +473,7 @@ void bt_hci_unref(struct bt_hci *hci)
 	queue_destroy(hci->evt_list, evt_free);
 	queue_destroy(hci->cmd_queue, cmd_free);
 	queue_destroy(hci->rsp_queue, cmd_free);
+	queue_destroy(hci->data_queue, data_free);
 
 	io_destroy(hci->io);
 
@@ -523,6 +574,7 @@ bool bt_hci_flush(struct bt_hci *hci)
 
 	queue_remove_all(hci->cmd_queue, NULL, NULL, cmd_free);
 	queue_remove_all(hci->rsp_queue, NULL, NULL, cmd_free);
+	queue_remove_all(hci->data_queue, NULL, NULL, data_free);
 
 	return true;
 }
@@ -556,6 +608,48 @@ unsigned int bt_hci_register(struct bt_hci *hci, uint8_t event,
 	return evt->id;
 }
 
+bool bt_hci_send_data(struct bt_hci *hci, uint8_t type, uint16_t handle,
+				const void *data, uint8_t size)
+{
+	struct data *d;
+
+	if (!hci)
+		return false;
+
+	/* Check if type really reflects to a data packet */
+	switch (type) {
+	case BT_H4_ACL_PKT:
+	case BT_H4_SCO_PKT:
+	case BT_H4_EVT_PKT:
+		break;
+	default:
+		return false;
+	}
+
+	d = new0(struct data, 1);
+	d->type = type;
+	d->handle = handle;
+	d->size = size;
+
+	if (d->size > 0) {
+		d->data = util_memdup(data, d->size);
+		if (!d->data) {
+			free(d);
+			return false;
+		}
+	}
+
+	if (!queue_push_tail(hci->data_queue, d)) {
+		free(d->data);
+		free(d);
+		return false;
+	}
+
+	wakeup_writer(hci);
+
+	return true;
+}
+
 static bool match_evt_id(const void *a, const void *b)
 {
 	const struct evt *evt = a;
diff --git a/src/shared/hci.h b/src/shared/hci.h
index 9298442e512a..76ee72f54ace 100644
--- a/src/shared/hci.h
+++ b/src/shared/hci.h
@@ -34,6 +34,9 @@ unsigned int bt_hci_send(struct bt_hci *hci, uint16_t opcode,
 bool bt_hci_cancel(struct bt_hci *hci, unsigned int id);
 bool bt_hci_flush(struct bt_hci *hci);
 
+bool bt_hci_send_data(struct bt_hci *hci, uint8_t type, uint16_t handle,
+				const void *data, uint8_t size);
+
 unsigned int bt_hci_register(struct bt_hci *hci, uint8_t event,
 				bt_hci_callback_func_t callback,
 				void *user_data, bt_hci_destroy_func_t destroy);
-- 
2.47.1

