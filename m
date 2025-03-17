Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D03238145
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220291; cv=none; b=TxkkjztqL5B6Mtl+GyYQBTSWJE1hQMy/gaiNfEh1vbk4wHClTz4qJoc/GvZWO4BnQd9UtHqquEhMDoEt9O7F8ti1heQoVDoL6QvoOl1TH+9sCKElcA9fcr7N7s7GtIT9Ox9Yi15U7ijOV6h/5kTaqVZq876U7yFBjL2dhPmhp80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220291; c=relaxed/simple;
	bh=CKasdhoi09+YHVbSX9fE543im61BLrjjWnk7EsaqLm8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JodCnBfLyXk/080pU6iVmKOTks42xZvUPwv3sNgngzLdXwl+tP1fW5Lrm1CA5NEirRPKU46F2rP63fNXJ1xXzBdp/diIiQbfuFcb1bvsbKmMjENeIF9IckgFdpNbZRR+JCijhq0P/4jgDTn0AC6IrLBE1lYszZD6o3lUV/olJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVJ/RyKx; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVJ/RyKx"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-868ddc4c6b6so1973488241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 07:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742220287; x=1742825087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HG9Rea0GaTD5/q5HNNFzvCEdn6QYIViiUNFlstKqX2E=;
        b=cVJ/RyKx5B4Pej7T9f1BWsKyG3Chn0H7SEOPT8Pd0hX1fdIL76jGEyvDk+jN8bgDWD
         YXNGzX4eC6fIEgiziMoai0i6TtDpcJ44niJYe8YVcmcUvrNnkB/eEO+uE33iZsFhobZp
         wZF7MkPm4KE8DHEvPI3sasPaIX5NJfF4/cBxDpRKH/VoCRRlaA4ytQYjr91Tq05OWSXW
         irdA5GrxeDHjJmZ26ZlXUoMk8zoie6j8JgUPP9gfpQ3SA8q/MzeOmod3ioeke7KarLT6
         +lqmilW7nda+zZJMtzTMCB8EI4xDgF15Xr9pSWLadbeHcAOayxYBHboN1/KnLktl+db0
         EyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742220287; x=1742825087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HG9Rea0GaTD5/q5HNNFzvCEdn6QYIViiUNFlstKqX2E=;
        b=qzxwjdC+B2hSk4ilZ8WASFOj768CqS6gHm26FnLXZFzuOhqVCTa3iukQcMEbHTAUfQ
         ykeF9dJDVw6TSdSv2qNtdQqUD7iTOAcKNmfJr+OLLCAXudpJfj07re4+o48E/DtlCJ0i
         Z7ozmednY2PxC6QvNOQGEWPljmXuvUubBeU0IxNw2WSZaOcFqkiyf78LngTr3lPvgjDW
         CUAvm02PnbTQerWzwnHKX3heQhSXNxNVLXDc02lNju8Ko+9IsjgdUXFav6kUrvKrPVrS
         yib/FmY3+nK2k5rM5AVqTOpLtg9i8+svPgDThnhC1QkQCO0v/+nC8IZIBNlY4T1/lgTy
         YRsw==
X-Gm-Message-State: AOJu0Yyah46AG/yP0ouzQDv3WSVBs2+/bGCQAw6k3bQHlFIAWnjYOkKJ
	DsL1mvcoupmF1T6gK1nSOm5lQDMWFD09niFMc2KaW3j+7kfO4F7pUtenH/ZddNc=
X-Gm-Gg: ASbGnculJMzOIRicQ+UlD09fR3ByC0KxXFJQuf1TsOxts5GhRH6gqMOjf/Uq6WEEYmd
	+2tBNKmy1G6Uk9xI5LriGpkkHc+x+f97SjWaz9NURzflh3huoolkYfmHjKJsLLWk3qp5czQkxDL
	jRLNGb0yjYNX6Ega+FdVY6YSRzXh2+w8dTIIRf1kZms1wy9vUKSyS/bnH4bmjQTEA+//iV8xVTc
	xcjRd2IZr0x5aXWbi7D3/1n4PC6rUVYHmJhqEEna5amfrWZzjIgFfcbX6wf9qXASuvPGWz1ErOr
	GbPolAJuFSKAQOHvAn6/XqP9g8tTDs72RKkTUBRPymBiX7U2GdOj0lK/w//WihqJ4mJjbRahILb
	va6L0w/OtYgJ4An4HhNmDwzjT
X-Google-Smtp-Source: AGHT+IFhU8pkDUnisxu8MlTfvP60cuvhLcwwvQdIQM5wyO/er9iGlrD0hB5eljDZ7PAcQ+tb6kRAHA==
X-Received: by 2002:a05:6122:3b8a:b0:516:18cd:c1fc with SMTP id 71dfb90a1353d-524499c8fddmr7594747e0c.8.1742220285529;
        Mon, 17 Mar 2025 07:04:45 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a70f59bsm1634741e0c.39.2025.03.17.07.04.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:04:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/hci: Make use of util_iov* to parse packets
Date: Mon, 17 Mar 2025 10:04:40 -0400
Message-ID: <20250317140440.470397-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Instead of pairing HCI directly this uses struct iovec and util_iov*
helper functions to parse packets.
---
 client/hci.c            |   8 +-
 mesh/mesh-io-generic.c  |  66 +++++----
 src/shared/hci-crypto.c |  16 +--
 src/shared/hci.c        |  50 +++----
 src/shared/hci.h        |   4 +-
 tools/3dsp.c            | 116 +++++++++-------
 tools/advtest.c         |  54 ++++----
 tools/bluemoon.c        | 104 ++++++---------
 tools/btattach.c        |  11 +-
 tools/btinfo.c          |  19 +--
 tools/eddystone.c       |  25 ++--
 tools/hci-tester.c      | 289 +++++++++++++++++++++++++++++-----------
 tools/ibeacon.c         |  25 ++--
 13 files changed, 463 insertions(+), 324 deletions(-)

diff --git a/client/hci.c b/client/hci.c
index 69fc4ba91707..8c8fe97cb51b 100644
--- a/client/hci.c
+++ b/client/hci.c
@@ -102,10 +102,10 @@ static uint8_t *str2bytearray(char *arg, size_t *val_len)
 	return util_memdup(value, i);
 }
 
-static void hci_cmd_complete(const void *data, uint8_t size, void *user_data)
+static void hci_cmd_complete(struct iovec *iov, void *user_data)
 {
 	bt_shell_printf("HCI Command complete:\n");
-	bt_shell_hexdump(data, size);
+	bt_shell_hexdump(iov->iov_base, iov->iov_len);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -198,12 +198,12 @@ static bool match_event(const void *data, const void *match_data)
 	return evt->event == event;
 }
 
-static void hci_evt_received(const void *data, uint8_t size, void *user_data)
+static void hci_evt_received(struct iovec *iov, void *user_data)
 {
 	struct hci_event *evt = user_data;
 
 	bt_shell_printf("HCI Event 0x%02x received:\n", evt->event);
-	bt_shell_hexdump(data, size);
+	bt_shell_hexdump(iov->iov_base, iov->iov_len);
 }
 
 static void hci_register(int argc, char *argv[])
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 13a863b48158..eb3dd00451d7 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -18,6 +18,7 @@
 #include <ell/ell.h>
 
 #include "monitor/bt.h"
+#include "src/shared/util.h"
 #include "src/shared/hci.h"
 #include "src/shared/mgmt.h"
 #include "lib/bluetooth.h"
@@ -144,14 +145,17 @@ static void event_adv_report(struct mesh_io *io, const void *buf, uint8_t size)
 	}
 }
 
-static void event_callback(const void *buf, uint8_t size, void *user_data)
+static void event_callback(struct iovec *iov, void *user_data)
 {
-	uint8_t event = l_get_u8(buf);
+	uint8_t event;
 	struct mesh_io *io = user_data;
 
+	if (!util_iov_pull_u8(iov, &event))
+		return;
+
 	switch (event) {
 	case BT_HCI_EVT_LE_ADV_REPORT:
-		event_adv_report(io, buf + 1, size - 1);
+		event_adv_report(io, iov->iov_base, iov->iov_len);
 		break;
 
 	default:
@@ -159,30 +163,29 @@ static void event_callback(const void *buf, uint8_t size, void *user_data)
 	}
 }
 
-static void local_commands_callback(const void *data, uint8_t size,
-							void *user_data)
+static void local_commands_callback(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_read_local_commands *rsp = data;
+	const struct bt_hci_rsp_read_local_commands *rsp;
 
-	if (rsp->status)
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status)
 		l_error("Failed to read local commands");
 }
 
-static void local_features_callback(const void *data, uint8_t size,
-							void *user_data)
+static void local_features_callback(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_read_local_features *rsp = data;
+	const struct bt_hci_rsp_read_local_features *rsp;
 
-	if (rsp->status)
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status)
 		l_error("Failed to read local features");
 }
 
-static void hci_generic_callback(const void *data, uint8_t size,
-								void *user_data)
+static void hci_generic_callback(struct iovec *iov, void *user_data)
 {
-	uint8_t status = l_get_u8(data);
+	uint8_t status;
 
-	if (status)
+	if (!util_iov_pull_u8(iov, &status) || status)
 		l_error("Failed to initialize HCI");
 }
 
@@ -278,17 +281,15 @@ static void configure_hci(struct mesh_io_private *io)
 				sizeof(cmd), hci_generic_callback, NULL, NULL);
 }
 
-static void scan_enable_rsp(const void *buf, uint8_t size,
-							void *user_data)
+static void scan_enable_rsp(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) buf);
+	uint8_t status;
 
-	if (status)
+	if (!util_iov_pull_u8(iov, &status) || status)
 		l_error("LE Scan enable failed (0x%02x)", status);
 }
 
-static void set_recv_scan_enable(const void *buf, uint8_t size,
-							void *user_data)
+static void set_recv_scan_enable(struct iovec *iov, void *user_data)
 {
 	struct mesh_io_private *pvt = user_data;
 	struct bt_hci_cmd_le_set_scan_enable cmd;
@@ -299,14 +300,13 @@ static void set_recv_scan_enable(const void *buf, uint8_t size,
 			&cmd, sizeof(cmd), scan_enable_rsp, pvt, NULL);
 }
 
-static void scan_disable_rsp(const void *buf, uint8_t size,
-							void *user_data)
+static void scan_disable_rsp(struct iovec *iov, void *user_data)
 {
 	struct bt_hci_cmd_le_set_scan_parameters cmd;
 	struct mesh_io_private *pvt = user_data;
-	uint8_t status = *((uint8_t *) buf);
+	uint8_t status;
 
-	if (status)
+	if (!util_iov_pull_u8(iov, &status) || status)
 		l_error("LE Scan disable failed (0x%02x)", status);
 
 	cmd.type = pvt->active ? 0x01 : 0x00;	/* Passive/Active scanning */
@@ -452,8 +452,7 @@ static bool dev_caps(struct mesh_io *io, struct mesh_io_caps *caps)
 	return true;
 }
 
-static void send_cancel_done(const void *buf, uint8_t size,
-							void *user_data)
+static void send_cancel_done(struct iovec *iov, void *user_data)
 {
 	struct mesh_io_private *pvt = user_data;
 	struct bt_hci_cmd_le_set_random_address cmd;
@@ -478,7 +477,7 @@ static void send_cancel(struct mesh_io_private *pvt)
 		return;
 
 	if (!pvt->sending) {
-		send_cancel_done(NULL, 0, pvt);
+		send_cancel_done(NULL, pvt);
 		return;
 	}
 
@@ -488,8 +487,7 @@ static void send_cancel(struct mesh_io_private *pvt)
 				send_cancel_done, pvt, NULL);
 }
 
-static void set_send_adv_enable(const void *buf, uint8_t size,
-							void *user_data)
+static void set_send_adv_enable(struct iovec *iov, void *user_data)
 {
 	struct mesh_io_private *pvt = user_data;
 	struct bt_hci_cmd_le_set_adv_enable cmd;
@@ -503,8 +501,7 @@ static void set_send_adv_enable(const void *buf, uint8_t size,
 				&cmd, sizeof(cmd), NULL, NULL, NULL);
 }
 
-static void set_send_adv_data(const void *buf, uint8_t size,
-							void *user_data)
+static void set_send_adv_data(struct iovec *iov, void *user_data)
 {
 	struct mesh_io_private *pvt = user_data;
 	struct tx_pkt *tx;
@@ -535,8 +532,7 @@ done:
 	pvt->tx = NULL;
 }
 
-static void set_send_adv_params(const void *buf, uint8_t size,
-							void *user_data)
+static void set_send_adv_params(struct iovec *iov, void *user_data)
 {
 	struct mesh_io_private *pvt = user_data;
 	struct bt_hci_cmd_le_set_adv_parameters cmd;
@@ -575,7 +571,7 @@ static void send_pkt(struct mesh_io_private *pvt, struct tx_pkt *tx,
 	pvt->interval = interval;
 
 	if (!pvt->sending) {
-		set_send_adv_params(NULL, 0, pvt);
+		set_send_adv_params(NULL, pvt);
 		return;
 	}
 
diff --git a/src/shared/hci-crypto.c b/src/shared/hci-crypto.c
index 5e6dd3e20361..548a943297e7 100644
--- a/src/shared/hci-crypto.c
+++ b/src/shared/hci-crypto.c
@@ -25,13 +25,13 @@ struct crypto_data {
 	void *user_data;
 };
 
-static void le_encrypt_callback(const void *response, uint8_t size,
-							void *user_data)
+static void le_encrypt_callback(struct iovec *iov, void *user_data)
 {
 	struct crypto_data *data = user_data;
-	const struct bt_hci_rsp_le_encrypt *rsp = response;
+	const struct bt_hci_rsp_le_encrypt *rsp;
 
-	if (rsp->status) {
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
 		data->callback(NULL, 0, data->user_data);
 		return;
 	}
@@ -66,14 +66,14 @@ static bool le_encrypt(struct bt_hci *hci, uint8_t size,
 	return true;
 }
 
-static void prand_callback(const void *response, uint8_t size,
-							void *user_data)
+static void prand_callback(struct iovec *iov, void *user_data)
 {
 	struct crypto_data *data = user_data;
-	const struct bt_hci_rsp_le_rand *rsp = response;
+	const struct bt_hci_rsp_le_rand *rsp;
 	uint8_t prand[3];
 
-	if (rsp->status) {
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
 		data->callback(NULL, 0, data->user_data);
 		return;
 	}
diff --git a/src/shared/hci.c b/src/shared/hci.c
index 575254c09d25..a3a24dc00a98 100644
--- a/src/shared/hci.c
+++ b/src/shared/hci.c
@@ -30,6 +30,8 @@
 #include "src/shared/queue.h"
 #include "src/shared/hci.h"
 
+#define HCI_MAX_EVENT_SIZE	260
+
 #define BTPROTO_HCI	1
 struct sockaddr_hci {
 	sa_family_t	hci_family;
@@ -213,7 +215,7 @@ static bool match_cmd_opcode(const void *a, const void *b)
 }
 
 static void process_response(struct bt_hci *hci, uint16_t opcode,
-					const void *data, size_t size)
+						struct iovec *iov)
 {
 	struct cmd *cmd;
 
@@ -233,7 +235,7 @@ static void process_response(struct bt_hci *hci, uint16_t opcode,
 	bt_hci_ref(hci);
 
 	if (cmd->callback)
-		cmd->callback(data, size, cmd->user_data);
+		cmd->callback(iov, cmd->user_data);
 
 	cmd_free(cmd);
 
@@ -246,44 +248,42 @@ static void process_notify(void *data, void *user_data)
 {
 	struct bt_hci_evt_hdr *hdr = user_data;
 	struct evt *evt = data;
+	struct iovec iov = { hdr + sizeof(*hdr), hdr->plen };
 
 	if (evt->event == hdr->evt)
-		evt->callback(user_data + sizeof(struct bt_hci_evt_hdr),
-						hdr->plen, evt->user_data);
+		evt->callback(&iov, evt->user_data);
 }
 
-static void process_event(struct bt_hci *hci, const void *data, size_t size)
+static void process_event(struct bt_hci *hci, struct iovec *iov)
 {
-	const struct bt_hci_evt_hdr *hdr = data;
+	const struct bt_hci_evt_hdr *hdr;
 	const struct bt_hci_evt_cmd_complete *cc;
 	const struct bt_hci_evt_cmd_status *cs;
 
-	if (size < sizeof(struct bt_hci_evt_hdr))
+	hdr = util_iov_pull_mem(iov, sizeof(*hdr));
+	if (!hdr)
 		return;
 
-	data += sizeof(struct bt_hci_evt_hdr);
-	size -= sizeof(struct bt_hci_evt_hdr);
-
-	if (hdr->plen != size)
+	if (hdr->plen != iov->iov_len)
 		return;
 
 	switch (hdr->evt) {
 	case BT_HCI_EVT_CMD_COMPLETE:
-		if (size < sizeof(*cc))
+		cc = util_iov_pull_mem(iov, sizeof(*cc));
+		if (!cc)
 			return;
-		cc = data;
 		hci->num_cmds = cc->ncmd;
-		process_response(hci, le16_to_cpu(cc->opcode),
-						data + sizeof(*cc),
-						size - sizeof(*cc));
+		process_response(hci, le16_to_cpu(cc->opcode), iov);
 		break;
 
 	case BT_HCI_EVT_CMD_STATUS:
-		if (size < sizeof(*cs))
+		cs = util_iov_pull_mem(iov, sizeof(*cs));
+		if (!cs)
 			return;
-		cs = data;
 		hci->num_cmds = cs->ncmd;
-		process_response(hci, le16_to_cpu(cs->opcode), &cs->status, 1);
+		iov->iov_base = (void *)&cs->status;
+		iov->iov_len = sizeof(cs->status);
+		process_response(hci, le16_to_cpu(cs->opcode), iov);
 		break;
 
 	default:
@@ -295,9 +295,11 @@ static void process_event(struct bt_hci *hci, const void *data, size_t size)
 static bool io_read_callback(struct io *io, void *user_data)
 {
 	struct bt_hci *hci = user_data;
-	uint8_t buf[512];
+	uint8_t buf[HCI_MAX_EVENT_SIZE];
+	struct iovec iov = { buf };
 	ssize_t len;
 	int fd;
+	uint8_t h4;
 
 	fd = io_get_fd(hci->io);
 	if (fd < 0)
@@ -310,12 +312,14 @@ static bool io_read_callback(struct io *io, void *user_data)
 	if (len < 0)
 		return false;
 
-	if (len < 1)
+	iov.iov_len = len;
+
+	if (!util_iov_pull_u8(&iov, &h4))
 		return true;
 
-	switch (buf[0]) {
+	switch (h4) {
 	case BT_H4_EVT_PKT:
-		process_event(hci, buf + 1, len - 1);
+		process_event(hci, &iov);
 		break;
 	}
 
diff --git a/src/shared/hci.h b/src/shared/hci.h
index 76ee72f54ace..655d410286e3 100644
--- a/src/shared/hci.h
+++ b/src/shared/hci.h
@@ -10,6 +10,7 @@
 
 #include <stdbool.h>
 #include <stdint.h>
+#include <sys/uio.h>
 
 typedef void (*bt_hci_destroy_func_t)(void *user_data);
 
@@ -24,8 +25,7 @@ void bt_hci_unref(struct bt_hci *hci);
 
 bool bt_hci_set_close_on_unref(struct bt_hci *hci, bool do_close);
 
-typedef void (*bt_hci_callback_func_t)(const void *data, uint8_t size,
-							void *user_data);
+typedef void (*bt_hci_callback_func_t)(struct iovec *iov, void *user_data);
 
 unsigned int bt_hci_send(struct bt_hci *hci, uint16_t opcode,
 				const void *data, uint8_t size,
diff --git a/tools/3dsp.c b/tools/3dsp.c
index 267a39e9043b..3acfc9c1aa6f 100644
--- a/tools/3dsp.c
+++ b/tools/3dsp.c
@@ -62,7 +62,7 @@ static bool shutdown_timeout(void *user_data)
 	return false;
 }
 
-static void shutdown_complete(const void *data, uint8_t size, void *user_data)
+static void shutdown_complete(struct iovec *iov, void *user_data)
 {
 	unsigned int id = PTR_TO_UINT(user_data);
 
@@ -85,11 +85,11 @@ static void shutdown_device(void)
 		mainloop_quit();
 }
 
-static void inquiry_started(const void *data, uint8_t size, void *user_data)
+static void inquiry_started(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
 
-	if (status) {
+	if (!util_iov_pull_u8(iov, &status) || status) {
 		printf("Failed to search for 3D display\n");
 		shutdown_device();
 		return;
@@ -112,19 +112,18 @@ static void start_inquiry(void)
 						inquiry_started, NULL, NULL);
 }
 
-static void set_peripheral_broadcast_receive(const void *data, uint8_t size,
-							void *user_data)
+static void set_peripheral_broadcast_receive(struct iovec *iov, void *user_data)
 {
 	printf("Peripheral broadcast reception enabled\n");
 }
 
-static void sync_train_received(const void *data, uint8_t size,
-							void *user_data)
+static void sync_train_received(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_evt_sync_train_received *evt = data;
+	const struct bt_hci_evt_sync_train_received *evt;
 	struct bt_hci_cmd_set_peripheral_broadcast_receive cmd;
 
-	if (evt->status) {
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!evt || evt->status) {
 		printf("Failed to synchronize with 3D display\n");
 		start_inquiry();
 		return;
@@ -152,13 +151,13 @@ static void sync_train_received(const void *data, uint8_t size,
 				set_peripheral_broadcast_receive, NULL, NULL);
 }
 
-static void brcm_sync_train_received(const void *data, uint8_t size,
-							void *user_data)
+static void brcm_sync_train_received(struct iovec *iov, void *user_data)
 {
-	const struct brcm_evt_sync_train_received *evt = data;
+	const struct brcm_evt_sync_train_received *evt;
 	struct bt_hci_cmd_set_peripheral_broadcast_receive cmd;
 
-	if (evt->status) {
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!evt || evt->status) {
 		printf("Failed to synchronize with 3D display\n");
 		start_inquiry();
 		return;
@@ -186,13 +185,13 @@ static void brcm_sync_train_received(const void *data, uint8_t size,
 				set_peripheral_broadcast_receive, NULL, NULL);
 }
 
-static void truncated_page_complete(const void *data, uint8_t size,
-							void *user_data)
+static void truncated_page_complete(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_evt_truncated_page_complete *evt = data;
+	const struct bt_hci_evt_truncated_page_complete *evt;
 	struct bt_hci_cmd_receive_sync_train cmd;
 
-	if (evt->status) {
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!evt || evt->status) {
 		printf("Failed to contact 3D display\n");
 		shutdown_device();
 		return;
@@ -209,12 +208,18 @@ static void truncated_page_complete(const void *data, uint8_t size,
 							NULL, NULL, NULL);
 }
 
-static void peripheral_broadcast_timeout(const void *data, uint8_t size,
-							void *user_data)
+static void peripheral_broadcast_timeout(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_evt_peripheral_broadcast_timeout *evt = data;
+	const struct bt_hci_evt_peripheral_broadcast_timeout *evt;
 	struct bt_hci_cmd_receive_sync_train cmd;
 
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!evt) {
+		printf("Failed to synchronize with 3D display\n");
+		shutdown_device();
+		return;
+	}
+
 	printf("Re-synchronizing with 3D display\n");
 
 	memcpy(cmd.bdaddr, evt->bdaddr, 6);
@@ -226,13 +231,13 @@ static void peripheral_broadcast_timeout(const void *data, uint8_t size,
 							NULL, NULL, NULL);
 }
 
-static void peripheral_broadcast_receive(const void *data, uint8_t size,
-							void *user_data)
+static void peripheral_broadcast_receive(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_evt_peripheral_broadcast_receive *evt = data;
+	const struct bt_hci_evt_peripheral_broadcast_receive *evt;
 	struct bt_hci_cmd_read_clock cmd;
 
-	if (evt->status != 0x00)
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!evt || evt->status)
 		return;
 
 	if (le32_to_cpu(evt->clock) != 0x00000000)
@@ -245,9 +250,13 @@ static void peripheral_broadcast_receive(const void *data, uint8_t size,
 							NULL, NULL, NULL);
 }
 
-static void ext_inquiry_result(const void *data, uint8_t size, void *user_data)
+static void ext_inquiry_result(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_evt_ext_inquiry_result *evt = data;
+	const struct bt_hci_evt_ext_inquiry_result *evt;
+
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!evt)
+		return;
 
 	if (evt->dev_class[0] != 0x3c || evt->dev_class[1] != 0x04
 					|| evt->dev_class[2] != 0x08)
@@ -270,18 +279,19 @@ static void ext_inquiry_result(const void *data, uint8_t size, void *user_data)
 	}
 }
 
-static void inquiry_complete(const void *data, uint8_t size, void *user_data)
+static void inquiry_complete(struct iovec *iov, void *user_data)
 {
 	printf("No 3D display found\n");
 
 	start_inquiry();
 }
 
-static void read_local_version(const void *data, uint8_t size, void *user_data)
+static void read_local_version(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_read_local_version *rsp = data;
+	const struct bt_hci_rsp_read_local_version *rsp;
 
-	if (rsp->status) {
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
 		printf("Failed to read local version information\n");
 		shutdown_device();
 		return;
@@ -336,8 +346,7 @@ static void start_glasses(void)
 
 static bool sync_train_active = false;
 
-static void sync_train_complete(const void *data, uint8_t size,
-							void *user_data)
+static void sync_train_complete(struct iovec *iov, void *user_data)
 {
 	sync_train_active = false;
 }
@@ -365,11 +374,15 @@ static void start_sync_train(void)
 	sync_train_active = true;
 }
 
-static void conn_request(const void *data, uint8_t size, void *user_data)
+static void conn_request(struct iovec *io, void *user_data)
 {
-	const struct bt_hci_evt_conn_request *evt = data;
+	const struct bt_hci_evt_conn_request *evt;
 	struct bt_hci_cmd_accept_conn_request cmd;
 
+	evt = util_iov_pull_mem(io, sizeof(*evt));
+	if (!evt)
+		return;
+
 	printf("Incoming connection from 3D glasses\n");
 
 	memcpy(cmd.bdaddr, evt->bdaddr, 6);
@@ -381,31 +394,35 @@ static void conn_request(const void *data, uint8_t size, void *user_data)
 	start_sync_train();
 }
 
-static void peripheral_page_response_timeout(const void *data, uint8_t size,
-							void *user_data)
+static void peripheral_page_response_timeout(struct iovec *iov, void *user_data)
 {
 	printf("Incoming truncated page received\n");
 
 	start_sync_train();
 }
 
-static void peripheral_broadcast_channel_map_change(const void *data,
-						uint8_t size, void *user_data)
+static void peripheral_broadcast_channel_map_change(struct iovec *iov,
+							void *user_data)
 {
 	printf("Broadcast channel map changed\n");
 
 	start_sync_train();
 }
 
-static void inquiry_resp_tx_power(const void *data, uint8_t size,
-							void *user_data)
+static void inquiry_resp_tx_power(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_read_inquiry_resp_tx_power *rsp = data;
+	const struct bt_hci_rsp_read_inquiry_resp_tx_power *rsp;
 	struct bt_hci_cmd_write_ext_inquiry_response cmd;
 	uint8_t inqdata[] = { 0x03, 0x3d, 0x03, 0x43, 0x02, 0x0a, 0x00, 0x00 };
 	uint8_t devclass[] = { 0x3c, 0x04, 0x08 };
 	uint8_t scanmode = 0x03;
 
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
+		fprintf(stderr, "Failed to read local tx power\n");
+		return;
+	}
+
 	inqdata[6] = (uint8_t) rsp->level;
 
 	cmd.fec = 0x00;
@@ -421,13 +438,14 @@ static void inquiry_resp_tx_power(const void *data, uint8_t size,
 							NULL, NULL, NULL);
 }
 
-static void read_clock(const void *data, uint8_t size, void *user_data)
+static void read_clock(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_read_clock *rsp = data;
+	const struct bt_hci_rsp_read_clock *rsp;
 	struct broadcast_message msg;
 	uint8_t bcastdata[sizeof(msg) + 3] = { LT_ADDR, 0x03, 0x11, };
 
-	if (rsp->status) {
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
 		printf("Failed to read local clock information\n");
 		shutdown_device();
 		return;
@@ -447,13 +465,13 @@ static void read_clock(const void *data, uint8_t size, void *user_data)
 			bcastdata, sizeof(bcastdata), NULL, NULL, NULL);
 }
 
-static void set_peripheral_broadcast(const void *data, uint8_t size,
-								void *user_data)
+static void set_peripheral_broadcast(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_set_peripheral_broadcast *rsp = data;
+	const struct bt_hci_rsp_set_peripheral_broadcast *rsp;
 	struct bt_hci_cmd_read_clock cmd;
 
-	if (rsp->status) {
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
 		printf("Failed to set peripheral broadcast transmission\n");
 		shutdown_device();
 		return;
diff --git a/tools/advtest.c b/tools/advtest.c
index 9ef69ed5124a..d0c00c3b0582 100644
--- a/tools/advtest.c
+++ b/tools/advtest.c
@@ -146,25 +146,25 @@ static void scan_le_adv_report(const void *data, uint8_t size,
 	}
 }
 
-static void scan_le_meta_event(const void *data, uint8_t size,
-							void *user_data)
+static void scan_le_meta_event(struct iovec *iov, void *user_data)
 {
-	uint8_t evt_code = ((const uint8_t *) data)[0];
+	uint8_t evt_code;
+
+	if (!util_iov_pull_u8(iov, &evt_code))
+		return;
 
 	switch (evt_code) {
 	case BT_HCI_EVT_LE_ADV_REPORT:
-		scan_le_adv_report(data + 1, size - 1, user_data);
+		scan_le_adv_report(iov->iov_base, iov->iov_len, user_data);
 		break;
 	}
 }
 
-static void scan_enable_callback(const void *data, uint8_t size,
-							void *user_data)
+static void scan_enable_callback(struct iovec *iov, void *user_data)
 {
 }
 
-static void adv_enable_callback(const void *data, uint8_t size,
-							void *user_data)
+static void adv_enable_callback(struct iovec *iov, void *user_data)
 {
 	struct bt_hci_cmd_le_set_scan_parameters cmd4;
 	struct bt_hci_cmd_le_set_scan_enable cmd5;
@@ -186,8 +186,7 @@ static void adv_enable_callback(const void *data, uint8_t size,
 					scan_enable_callback, NULL, NULL);
 }
 
-static void adv_le_evtmask_callback(const void *data, uint8_t size,
-							void *user_data)
+static void adv_le_evtmask_callback(struct iovec *iov, void *user_data)
 {
 	struct bt_hci_cmd_le_set_resolv_timeout cmd0;
 	struct bt_hci_cmd_le_add_to_resolv_list cmd1;
@@ -244,13 +243,13 @@ static void adv_le_evtmask_callback(const void *data, uint8_t size,
 					adv_enable_callback, NULL, NULL);
 }
 
-static void adv_le_features_callback(const void *data, uint8_t size,
-							void *user_data)
+static void adv_le_features_callback(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_le_read_local_features *rsp = data;
+	const struct bt_hci_rsp_le_read_local_features *rsp;
 	uint8_t evtmask[] = { 0xff, 0xff, 0x0f, 0x00, 0x00, 0x00, 0x00, 0x00 };
 
-	if (rsp->status) {
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
 		fprintf(stderr, "Failed to read local LE features\n");
 		mainloop_exit_failure();
 		return;
@@ -260,13 +259,13 @@ static void adv_le_features_callback(const void *data, uint8_t size,
 					adv_le_evtmask_callback, NULL, NULL);
 }
 
-static void adv_features_callback(const void *data, uint8_t size,
-							void *user_data)
+static void adv_features_callback(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_read_local_features *rsp = data;
+	const struct bt_hci_rsp_read_local_features *rsp;
 	uint8_t evtmask[] = { 0x90, 0xe8, 0x04, 0x02, 0x00, 0x80, 0x00, 0x20 };
 
-	if (rsp->status) {
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
 		fprintf(stderr, "Failed to read local features\n");
 		mainloop_exit_failure();
 		return;
@@ -285,8 +284,7 @@ static void adv_features_callback(const void *data, uint8_t size,
 					adv_le_features_callback, NULL, NULL);
 }
 
-static void scan_le_evtmask_callback(const void *data, uint8_t size,
-							void *user_data)
+static void scan_le_evtmask_callback(struct iovec *iov, void *user_data)
 {
 	bt_hci_send(adv_dev, BT_HCI_CMD_RESET, NULL, 0, NULL, NULL, NULL);
 
@@ -294,13 +292,13 @@ static void scan_le_evtmask_callback(const void *data, uint8_t size,
 					adv_features_callback, NULL, NULL);
 }
 
-static void scan_le_features_callback(const void *data, uint8_t size,
-							void *user_data)
+static void scan_le_features_callback(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_le_read_local_features *rsp = data;
+	const struct bt_hci_rsp_le_read_local_features *rsp;
 	uint8_t evtmask[] = { 0xff, 0xff, 0x0f, 0x00, 0x00, 0x00, 0x00, 0x00 };
 
-	if (rsp->status) {
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
 		fprintf(stderr, "Failed to read local LE features\n");
 		mainloop_exit_failure();
 		return;
@@ -310,13 +308,13 @@ static void scan_le_features_callback(const void *data, uint8_t size,
 					scan_le_evtmask_callback, NULL, NULL);
 }
 
-static void scan_features_callback(const void *data, uint8_t size,
-							void *user_data)
+static void scan_features_callback(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_read_local_features *rsp = data;
+	const struct bt_hci_rsp_read_local_features *rsp;
 	uint8_t evtmask[] = { 0x90, 0xe8, 0x04, 0x02, 0x00, 0x80, 0x00, 0x20 };
 
-	if (rsp->status) {
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
 		fprintf(stderr, "Failed to read local features\n");
 		mainloop_exit_failure();
 		return;
diff --git a/tools/bluemoon.c b/tools/bluemoon.c
index 9aaf6428da42..d8c4e4d9257e 100644
--- a/tools/bluemoon.c
+++ b/tools/bluemoon.c
@@ -154,11 +154,11 @@ static bool set_exception = false;
 static bool reset_on_exit = false;
 static bool cold_boot = false;
 
-static void reset_complete(const void *data, uint8_t size, void *user_data)
+static void reset_complete(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
 
-	if (status) {
+	if (!util_iov_pull_u8(iov, &status) || status) {
 		fprintf(stderr, "Failed to reset (0x%02x)\n", status);
 		mainloop_quit();
 		return;
@@ -167,11 +167,11 @@ static void reset_complete(const void *data, uint8_t size, void *user_data)
 	mainloop_quit();
 }
 
-static void cold_boot_complete(const void *data, uint8_t size, void *user_data)
+static void cold_boot_complete(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
 
-	if (status) {
+	if (!util_iov_pull_u8(iov, &status) || status) {
 		fprintf(stderr, "Failed to cold boot (0x%02x)\n", status);
 		mainloop_quit();
 		return;
@@ -186,12 +186,11 @@ static void cold_boot_complete(const void *data, uint8_t size, void *user_data)
 	mainloop_quit();
 }
 
-static void leave_manufacturer_mode_complete(const void *data, uint8_t size,
-							void *user_data)
+static void leave_manufacturer_mode_complete(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
 
-	if (status) {
+	if (!util_iov_pull_u8(iov, &status) || status) {
 		fprintf(stderr, "Failed to leave manufacturer mode (0x%02x)\n",
 									status);
 		mainloop_quit();
@@ -233,12 +232,11 @@ static void shutdown_device(void)
 	mainloop_quit();
 }
 
-static void write_bd_address_complete(const void *data, uint8_t size,
-							void *user_data)
+static void write_bd_address_complete(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
 
-	if (status) {
+	if (!util_iov_pull_u8(iov, &status) || status) {
 		fprintf(stderr, "Failed to write address (0x%02x)\n", status);
 		mainloop_quit();
 		return;
@@ -247,13 +245,13 @@ static void write_bd_address_complete(const void *data, uint8_t size,
 	shutdown_device();
 }
 
-static void read_bd_addr_complete(const void *data, uint8_t size,
-							void *user_data)
+static void read_bd_addr_complete(struct iovec *data, void *user_data)
 {
-	const struct bt_hci_rsp_read_bd_addr *rsp = data;
+	const struct bt_hci_rsp_read_bd_addr *rsp;
 	struct cmd_write_bd_address cmd;
 
-	if (rsp->status) {
+	rsp = util_iov_pull_mem(data, sizeof(*rsp));
+	if (!rsp || rsp->status) {
 		fprintf(stderr, "Failed to read address (0x%02x)\n",
 							rsp->status);
 		mainloop_quit();
@@ -285,12 +283,11 @@ static void read_bd_addr_complete(const void *data, uint8_t size,
 					write_bd_address_complete, NULL, NULL);
 }
 
-static void act_deact_traces_complete(const void *data, uint8_t size,
-							void *user_data)
+static void act_deact_traces_complete(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
 
-	if (status) {
+	if (!util_iov_pull_u8(iov, &status) || status) {
 		fprintf(stderr, "Failed to activate traces (0x%02x)\n", status);
 		shutdown_device();
 		return;
@@ -323,12 +320,11 @@ static void trigger_exception(void)
 	shutdown_device();
 }
 
-static void write_bd_data_complete(const void *data, uint8_t size,
-							void *user_data)
+static void write_bd_data_complete(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
 
-	if (status) {
+	if (!util_iov_pull_u8(iov, &status) || status) {
 		fprintf(stderr, "Failed to write data (0x%02x)\n", status);
 		shutdown_device();
 		return;
@@ -342,13 +338,13 @@ static void write_bd_data_complete(const void *data, uint8_t size,
 	shutdown_device();
 }
 
-static void read_bd_data_complete(const void *data, uint8_t size,
-							void *user_data)
+static void read_bd_data_complete(struct iovec *iov, void *user_data)
 {
-	const struct rsp_read_bd_data *rsp = data;
+	const struct rsp_read_bd_data *rsp;
 
-	if (rsp->status) {
-		fprintf(stderr, "Failed to read data (0x%02x)\n", rsp->status);
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
+		fprintf(stderr, "Failed to read data\n");
 		shutdown_device();
 		return;
 	}
@@ -389,12 +385,11 @@ static void read_bd_data_complete(const void *data, uint8_t size,
 	shutdown_device();
 }
 
-static void firmware_command_complete(const void *data, uint8_t size,
-							void *user_data)
+static void firmware_command_complete(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
 
-	if (status) {
+	if (!util_iov_pull_u8(iov, &status) || status) {
 		fprintf(stderr, "Failed to load firmware (0x%02x)\n", status);
 		manufacturer_mode_reset = 0x01;
 		shutdown_device();
@@ -434,12 +429,11 @@ static void firmware_command_complete(const void *data, uint8_t size,
 
 }
 
-static void enter_manufacturer_mode_complete(const void *data, uint8_t size,
-							void *user_data)
+static void enter_manufacturer_mode_complete(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
 
-	if (status) {
+	if (!util_iov_pull_u8(iov, &status) || status) {
 		fprintf(stderr, "Failed to enter manufacturer mode (0x%02x)\n",
 									status);
 		mainloop_quit();
@@ -448,7 +442,9 @@ static void enter_manufacturer_mode_complete(const void *data, uint8_t size,
 
 	if (load_firmware) {
 		uint8_t status = BT_HCI_ERR_SUCCESS;
-		firmware_command_complete(&status, sizeof(status), NULL);
+		struct iovec data = { &status, sizeof(status) };
+
+		firmware_command_complete(&data, NULL);
 		return;
 	}
 
@@ -563,24 +559,18 @@ static void request_firmware(const char *path)
 		firmware_offset = 1;
 }
 
-static void read_boot_params_complete(const void *data, uint8_t size,
-							void *user_data)
+static void read_boot_params_complete(struct iovec *iov, void *user_data)
 {
-	const struct rsp_read_boot_params *rsp = data;
+	const struct rsp_read_boot_params *rsp;
 
-	if (rsp->status) {
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
 		fprintf(stderr, "Failed to read boot params (0x%02x)\n",
 							rsp->status);
 		mainloop_quit();
 		return;
 	}
 
-	if (size != sizeof(*rsp)) {
-		fprintf(stderr, "Size mismatch for read boot params\n");
-		mainloop_quit();
-		return;
-	}
-
 	printf("Secure Boot Parameters\n");
 	printf("\tOTP Format Version:\t%u\n", rsp->otp_format);
 	printf("\tOTP Content Version:\t%u\n", rsp->otp_content);
@@ -628,26 +618,20 @@ static const struct {
 	{ }
 };
 
-static void read_version_complete(const void *data, uint8_t size,
-							void *user_data)
+static void read_version_complete(struct iovec *iov, void *user_data)
 {
-	const struct rsp_read_version *rsp = data;
+	const struct rsp_read_version *rsp;
 	const char *str;
 	int i;
 
-	if (rsp->status) {
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
 		fprintf(stderr, "Failed to read version (0x%02x)\n",
 							rsp->status);
 		mainloop_quit();
 		return;
 	}
 
-	if (size != sizeof(*rsp)) {
-		fprintf(stderr, "Size mismatch for read version response\n");
-		mainloop_quit();
-		return;
-	}
-
 	if (cold_boot) {
 		struct cmd_reset cmd;
 
diff --git a/tools/btattach.c b/tools/btattach.c
index 4ce1be78d69c..4e9a94e6de8b 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -88,10 +88,15 @@ static int open_serial(const char *path, unsigned int speed, bool flowctl)
 	return fd;
 }
 
-static void local_version_callback(const void *data, uint8_t size,
-							void *user_data)
+static void local_version_callback(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_read_local_version *rsp = data;
+	const struct bt_hci_rsp_read_local_version *rsp;
+
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
+		fprintf(stderr, "Failed to read local version\n");
+		return;
+	}
 
 	printf("Manufacturer: %u\n", le16_to_cpu(rsp->manufacturer));
 }
diff --git a/tools/btinfo.c b/tools/btinfo.c
index 5f3650c782bd..60521530fd56 100644
--- a/tools/btinfo.c
+++ b/tools/btinfo.c
@@ -83,7 +83,7 @@ static bool shutdown_timeout(void *user_data)
 	return false;
 }
 
-static void shutdown_complete(const void *data, uint8_t size, void *user_data)
+static void shutdown_complete(struct iovec *iov, void *user_data)
 {
 	unsigned int id = PTR_TO_UINT(user_data);
 
@@ -106,10 +106,15 @@ static void shutdown_device(void)
 		mainloop_quit();
 }
 
-static void local_version_callback(const void *data, uint8_t size,
-							void *user_data)
+static void local_version_callback(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_read_local_version *rsp = data;
+	const struct bt_hci_rsp_read_local_version *rsp;
+
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
+		fprintf(stderr, "Failed to read local version\n");
+		return;
+	}
 
 	printf("HCI version: %u\n", rsp->hci_ver);
 	printf("HCI revision: %u\n", le16_to_cpu(rsp->hci_rev));
@@ -128,14 +133,12 @@ static void local_version_callback(const void *data, uint8_t size,
 	printf("Manufacturer: %u\n", le16_to_cpu(rsp->manufacturer));
 }
 
-static void local_commands_callback(const void *data, uint8_t size,
-							void *user_data)
+static void local_commands_callback(struct iovec *iov, void *user_data)
 {
 	shutdown_device();
 }
 
-static void local_features_callback(const void *data, uint8_t size,
-							void *user_data)
+static void local_features_callback(struct iovec *iov, void *user_data)
 {
 	bt_hci_send(hci_dev, BT_HCI_CMD_READ_LOCAL_COMMANDS, NULL, 0,
 					local_commands_callback, NULL, NULL);
diff --git a/tools/eddystone.c b/tools/eddystone.c
index 4a593e823027..4c26d1b9042d 100644
--- a/tools/eddystone.c
+++ b/tools/eddystone.c
@@ -39,7 +39,7 @@ static bool shutdown_timeout(void *user_data)
 	return false;
 }
 
-static void shutdown_complete(const void *data, uint8_t size, void *user_data)
+static void shutdown_complete(struct iovec *iov, void *user_data)
 {
 	unsigned int id = PTR_TO_UINT(user_data);
 
@@ -106,12 +106,11 @@ static void set_adv_enable(void)
 					&enable, 1, NULL, NULL, NULL);
 }
 
-static void adv_data_callback(const void *data, uint8_t size,
-							void *user_data)
+static void adv_data_callback(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
 
-	if (status) {
+	if (util_iov_pull_u8(iov, &status) || status) {
 		fprintf(stderr, "Failed to set advertising data\n");
 		shutdown_device();
 		return;
@@ -122,13 +121,13 @@ static void adv_data_callback(const void *data, uint8_t size,
 	set_adv_enable();
 }
 
-static void adv_tx_power_callback(const void *data, uint8_t size,
-							void *user_data)
+static void adv_tx_power_callback(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_le_read_adv_tx_power *rsp = data;
+	const struct bt_hci_rsp_le_read_adv_tx_power *rsp;
 	struct bt_hci_cmd_le_set_adv_data cmd;
 
-	if (rsp->status) {
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (rsp || rsp->status) {
 		fprintf(stderr, "Failed to read advertising TX power\n");
 		shutdown_device();
 		return;
@@ -166,12 +165,12 @@ static void adv_tx_power_callback(const void *data, uint8_t size,
 					adv_data_callback, NULL, NULL);
 }
 
-static void local_features_callback(const void *data, uint8_t size,
-							void *user_data)
+static void local_features_callback(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_read_local_features *rsp = data;
+	const struct bt_hci_rsp_read_local_features *rsp;
 
-	if (rsp->status) {
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
 		fprintf(stderr, "Failed to read local features\n");
 		shutdown_device();
 		return;
diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index 79193220feec..e529f7c365c7 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -51,11 +51,17 @@ static void test_debug(const char *str, void *user_data)
 	tester_debug("%s", str);
 }
 
-static void test_pre_setup_lt_address(const void *data, uint8_t size,
-							void *user_data)
+static void test_pre_setup_lt_address(struct iovec *data, void *user_data)
 {
 	struct user_data *user = tester_get_data();
-	const struct bt_hci_rsp_read_bd_addr *rsp = data;
+	const struct bt_hci_rsp_read_bd_addr *rsp;
+
+	rsp = util_iov_pull_mem(data, sizeof(*rsp));
+	if (!rsp) {
+		tester_warn("Invalid response (length too short)");
+		tester_pre_setup_failed();
+		return;
+	}
 
 	if (rsp->status) {
 		tester_warn("Read lower tester address failed (0x%02x)",
@@ -69,11 +75,16 @@ static void test_pre_setup_lt_address(const void *data, uint8_t size,
 	tester_pre_setup_complete();
 }
 
-static void test_pre_setup_lt_complete(const void *data, uint8_t size,
-							void *user_data)
+static void test_pre_setup_lt_complete(struct iovec *iov, void *user_data)
 {
 	struct user_data *user = tester_get_data();
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
+
+	if (!util_iov_pull_u8(iov, &status)) {
+		tester_warn("Invalid response (length too short)");
+		tester_pre_setup_failed();
+		return;
+	}
 
 	if (status) {
 		tester_warn("Reset lower tester failed (0x%02x)", status);
@@ -89,11 +100,17 @@ static void test_pre_setup_lt_complete(const void *data, uint8_t size,
 	}
 }
 
-static void test_pre_setup_ut_address(const void *data, uint8_t size,
-							void *user_data)
+static void test_pre_setup_ut_address(struct iovec *iov, void *user_data)
 {
 	struct user_data *user = tester_get_data();
-	const struct bt_hci_rsp_read_bd_addr *rsp = data;
+	const struct bt_hci_rsp_read_bd_addr *rsp;
+
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp) {
+		tester_warn("Invalid response (length too short)");
+		tester_pre_setup_failed();
+		return;
+	}
 
 	if (rsp->status) {
 		tester_warn("Read upper tester address failed (0x%02x)",
@@ -119,11 +136,16 @@ static void test_pre_setup_ut_address(const void *data, uint8_t size,
 	}
 }
 
-static void test_pre_setup_ut_complete(const void *data, uint8_t size,
-							void *user_data)
+static void test_pre_setup_ut_complete(struct iovec *iov, void *user_data)
 {
 	struct user_data *user = tester_get_data();
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
+
+	if (!util_iov_pull_u8(iov, &status)) {
+		tester_warn("Invalid response (length too short)");
+		tester_pre_setup_failed();
+		return;
+	}
 
 	if (status) {
 		tester_warn("Reset upper tester failed (0x%02x)", status);
@@ -211,10 +233,16 @@ static void user_data_free(void *data)
 				test_post_teardown, 30, user, user_data_free); \
 	} while (0)
 
-static void setup_features_complete(const void *data, uint8_t size,
-							void *user_data)
+static void setup_features_complete(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_read_local_features *rsp = data;
+	const struct bt_hci_rsp_read_local_features *rsp;
+
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp) {
+		tester_warn("Invalid response (length too short)");
+		tester_setup_failed();
+		return;
+	}
 
 	if (rsp->status) {
 		tester_warn("Failed to get HCI features (0x%02x)", rsp->status);
@@ -242,10 +270,15 @@ static void test_reset(const void *test_data)
 	tester_test_passed();
 }
 
-static void test_command_complete(const void *data, uint8_t size,
-							void *user_data)
+static void test_command_complete(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
+
+	if (!util_iov_pull_u8(iov, &status)) {
+		tester_warn("Invalid response (length too short)");
+		tester_test_failed();
+		return;
+	}
 
 	if (status) {
 		tester_warn("HCI command failed (0x%02x)", status);
@@ -283,10 +316,17 @@ static void test_read_local_supported_features(const void *test_data)
 	test_command(BT_HCI_CMD_READ_LOCAL_FEATURES);
 }
 
-static void test_local_extended_features_complete(const void *data,
-						uint8_t size, void *user_data)
+static void test_local_extended_features_complete(struct iovec *iov,
+							void *user_data)
 {
-	const struct bt_hci_rsp_read_local_ext_features *rsp = data;
+	const struct bt_hci_rsp_read_local_ext_features *rsp;
+
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp) {
+		tester_warn("Invalid response (length too short)");
+		tester_test_failed();
+		return;
+	}
 
 	if (rsp->status) {
 		tester_warn("Failed to get HCI extended features (0x%02x)",
@@ -308,7 +348,7 @@ static void test_read_local_extended_features(const void *test_data)
 	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_READ_LOCAL_EXT_FEATURES,
 					&cmd, sizeof(cmd),
 					test_local_extended_features_complete,
-								NULL, NULL)) {
+					NULL, NULL)) {
 		tester_warn("Failed to send HCI extended features command");
 		tester_test_failed();
 		return;
@@ -345,16 +385,22 @@ static void test_le_clear_accept_list(const void *test_data)
 	test_command(BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST);
 }
 
-static void test_le_encrypt_complete(const void *data, uint8_t size,
-								void *user_data)
+static void test_le_encrypt_complete(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_le_encrypt *rsp = data;
+	const struct bt_hci_rsp_le_encrypt *rsp;
 	uint8_t sample[16] = {
 		0x7d, 0xf7, 0x6b, 0x0c, 0x1a, 0xb8, 0x99, 0xb3,
 		0x3e, 0x42, 0xf0, 0x47, 0xb9, 0x1b, 0x54, 0x6f
 	};
 	uint8_t enc_data[16];
 
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp) {
+		tester_warn("Invalid response (length too short)");
+		tester_test_failed();
+		return;
+	}
+
 	if (rsp->status) {
 		tester_warn("Failed HCI LE Encrypt (0x%02x)", rsp->status);
 		tester_test_failed();
@@ -404,20 +450,31 @@ static void test_le_rand(const void *test_data)
 	test_command(BT_HCI_CMD_LE_RAND);
 }
 
-static void test_le_read_local_pk_complete(const void *data, uint8_t size,
-								void *user_data)
+static void test_le_read_local_pk_complete(struct iovec *iov, void *user_data)
 {
-	const uint8_t *event = data;
+	uint8_t event;
 	const struct bt_hci_evt_le_read_local_pk256_complete *evt;
 	struct le_keys *keys = user_data;
 
-	if (*event != BT_HCI_EVT_LE_READ_LOCAL_PK256_COMPLETE) {
+	if (!util_iov_pull_u8(iov, &event)) {
+		tester_warn("Invalid response (length too short)");
+		tester_test_failed();
+		return;
+	}
+
+	if (event != BT_HCI_EVT_LE_READ_LOCAL_PK256_COMPLETE) {
 		tester_warn("Failed Read Local PK256 command");
 		tester_test_failed();
 		return;
 	}
 
-	evt = (void *)(event + 1);
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!evt) {
+		tester_warn("Invalid response (length too short)");
+		tester_test_failed();
+		return;
+	}
+
 	if (evt->status) {
 		tester_warn("HCI Read Local PK complete failed (0x%02x)",
 								evt->status);
@@ -432,13 +489,13 @@ static void test_le_read_local_pk_complete(const void *data, uint8_t size,
 	tester_test_passed();
 }
 
-static void test_le_read_local_pk_status(const void *data, uint8_t size,
-							void *user_data)
+static void test_le_read_local_pk_status(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
 
-	if (status) {
-		tester_warn("Failed to send Read Local PK256 cmd (0x%02x)", status);
+	if (!util_iov_pull_u8(iov, &status) || status) {
+		tester_warn("Failed to send Read Local PK256 cmd (0x%02x)",
+				status);
 		tester_test_failed();
 		return;
 	}
@@ -477,20 +534,31 @@ static void test_le_read_local_pk(const void *test_data)
 	}
 }
 
-static void setup_le_read_local_pk_complete(const void *data, uint8_t size,
-								void *user_data)
+static void setup_le_read_local_pk_complete(struct iovec *iov, void *user_data)
 {
-	const uint8_t *event = data;
+	uint8_t event;
 	const struct bt_hci_evt_le_read_local_pk256_complete *evt;
 	struct le_keys *keys = user_data;
 
-	if (*event != BT_HCI_EVT_LE_READ_LOCAL_PK256_COMPLETE) {
+	if (!util_iov_pull_u8(iov, &event)) {
+		tester_warn("Invalid response (length too short)");
+		tester_setup_failed();
+		return;
+	}
+
+	if (event != BT_HCI_EVT_LE_READ_LOCAL_PK256_COMPLETE) {
 		tester_warn("Failed Read Local PK256 command");
 		tester_setup_failed();
 		return;
 	}
 
-	evt = (void *)(event + 1);
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!evt) {
+		tester_warn("Invalid response (length too short)");
+		tester_setup_failed();
+		return;
+	}
+
 	if (evt->status) {
 		tester_warn("HCI Read Local PK complete failed (0x%02x)",
 								evt->status);
@@ -505,10 +573,15 @@ static void setup_le_read_local_pk_complete(const void *data, uint8_t size,
 	tester_setup_complete();
 }
 
-static void setup_le_read_local_pk_status(const void *data, uint8_t size,
-							void *user_data)
+static void setup_le_read_local_pk_status(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
+
+	if (!util_iov_pull_u8(iov, &status)) {
+		tester_warn("Invalid response (length too short)");
+		tester_setup_failed();
+		return;
+	}
 
 	if (status) {
 		tester_warn("Failed to send DHKey gen cmd (0x%02x)", status);
@@ -551,21 +624,32 @@ static void setup_le_generate_dhkey(const void *test_data)
 	}
 }
 
-static void test_le_generate_dhkey_complete(const void *data, uint8_t size,
-								void *user_data)
+static void test_le_generate_dhkey_complete(struct iovec *iov, void *user_data)
 {
-	const uint8_t *event = data;
+	uint8_t event;
 	const struct bt_hci_evt_le_generate_dhkey_complete *evt;
 	struct le_keys *keys = user_data;
 	uint8_t dhkey[32];
 
-	if (*event != BT_HCI_EVT_LE_GENERATE_DHKEY_COMPLETE) {
+	if (!util_iov_pull_u8(iov, &event)) {
+		tester_warn("Invalid response (length too short)");
+		tester_test_failed();
+		return;
+	}
+
+	if (event != BT_HCI_EVT_LE_GENERATE_DHKEY_COMPLETE) {
 		tester_warn("Failed DHKey generation command");
 		tester_test_failed();
 		return;
 	}
 
-	evt = (void *)(event + 1);
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!evt) {
+		tester_warn("Invalid response (length too short)");
+		tester_test_failed();
+		return;
+	}
+
 	if (evt->status) {
 		tester_warn("HCI Generate DHKey complete failed (0x%02x)",
 								evt->status);
@@ -593,12 +677,11 @@ static void test_le_generate_dhkey_complete(const void *data, uint8_t size,
 		tester_test_failed();
 }
 
-static void test_le_generate_dhkey_status(const void *data, uint8_t size,
-							void *user_data)
+static void test_le_generate_dhkey_status(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
 
-	if (status) {
+	if (util_iov_pull_u8(iov, &status) || status) {
 		tester_warn("Failed to send DHKey gen cmd (0x%02x)", status);
 		tester_test_failed();
 		return;
@@ -630,10 +713,16 @@ static void test_le_generate_dhkey(const void *test_data)
 
 }
 
-static void test_inquiry_complete(const void *data, uint8_t size,
-							void *user_data)
+static void test_inquiry_complete(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_evt_inquiry_complete *evt = data;
+	const struct bt_hci_evt_inquiry_complete *evt;
+
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!iov) {
+		tester_warn("Invalid response (length too short)");
+		tester_test_failed();
+		return;
+	}
 
 	if (evt->status) {
 		tester_warn("HCI inquiry complete failed (0x%02x)",
@@ -645,10 +734,15 @@ static void test_inquiry_complete(const void *data, uint8_t size,
 	tester_test_passed();
 }
 
-static void test_inquiry_status(const void *data, uint8_t size,
-							void *user_data)
+static void test_inquiry_status(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
+
+	if (!util_iov_pull_u8(iov, &status)) {
+		tester_warn("Invalid response (length too short)");
+		tester_test_failed();
+		return;
+	}
 
 	if (status) {
 		tester_warn("HCI inquiry command failed (0x%02x)", status);
@@ -679,10 +773,15 @@ static void test_inquiry_liac(const void *test_data)
 	}
 }
 
-static void setup_lt_connectable_complete(const void *data, uint8_t size,
-							void *user_data)
+static void setup_lt_connectable_complete(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
+
+	if (!util_iov_pull_u8(iov, &status)) {
+		tester_warn("Invalid response (length too short)");
+		tester_setup_failed();
+		return;
+	}
 
 	if (status) {
 		tester_warn("Failed to set HCI scan enable (0x%02x)", status);
@@ -693,13 +792,18 @@ static void setup_lt_connectable_complete(const void *data, uint8_t size,
 	tester_setup_complete();
 }
 
-static void setup_lt_connect_request_accept(const void *data, uint8_t size,
-							void *user_data)
+static void setup_lt_connect_request_accept(struct iovec *iov, void *user_data)
 {
 	struct user_data *user = tester_get_data();
-	const struct bt_hci_evt_conn_request *evt = data;
+	const struct bt_hci_evt_conn_request *evt;
 	struct bt_hci_cmd_accept_conn_request cmd;
 
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!evt) {
+		tester_warn("Invalid response (length too short)");
+		return;
+	}
+
 	memcpy(cmd.bdaddr, evt->bdaddr, 6);
 	cmd.role = 0x01;
 
@@ -734,11 +838,17 @@ static void test_create_connection_disconnect(void *user_data)
 	tester_test_passed();
 }
 
-static void test_create_connection_complete(const void *data, uint8_t size,
-							void *user_data)
+static void test_create_connection_complete(struct iovec *iov, void *user_data)
 {
 	struct user_data *user = tester_get_data();
-	const struct bt_hci_evt_conn_complete *evt = data;
+	const struct bt_hci_evt_conn_complete *evt;
+
+	evt = util_iov_pull_mem(iov, sizeof(*evt));
+	if (!evt) {
+		tester_warn("Invalid response (length too short)");
+		tester_test_failed();
+		return;
+	}
 
 	if (evt->status) {
 		tester_warn("HCI create connection complete failed (0x%02x)",
@@ -752,10 +862,15 @@ static void test_create_connection_complete(const void *data, uint8_t size,
 	tester_wait(2, test_create_connection_disconnect, NULL);
 }
 
-static void test_create_connection_status(const void *data, uint8_t size,
-							void *user_data)
+static void test_create_connection_status(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
+
+	if (!util_iov_pull_u8(iov, &status)) {
+		tester_warn("Invalid response (length too short)");
+		tester_test_failed();
+		return;
+	}
 
 	if (status) {
 		tester_warn("HCI create connection command failed (0x%02x)",
@@ -783,7 +898,7 @@ static void test_create_connection(const void *test_data)
 	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_CREATE_CONN,
 						&cmd, sizeof(cmd),
 						test_create_connection_status,
-								NULL, NULL)) {
+						NULL, NULL)) {
 		tester_warn("Failed to send HCI create connection command");
 		tester_test_failed();
 		return;
@@ -795,10 +910,15 @@ static void teardown_timeout(void *user_data)
 	tester_teardown_complete();
 }
 
-static void teardown_disconnect_status(const void *data, uint8_t size,
-							void *user_data)
+static void teardown_disconnect_status(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
+
+	if (!util_iov_pull_u8(iov, &status)) {
+		tester_warn("Invalid response (length too short)");
+		tester_teardown_failed();
+		return;
+	}
 
 	if (status) {
 		tester_warn("HCI disconnect failed (0x%02x)", status);
@@ -820,21 +940,34 @@ static void teardown_connection(const void *test_data)
 	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_DISCONNECT,
 						&cmd, sizeof(cmd),
 						teardown_disconnect_status,
-								NULL, NULL)) {
+						NULL, NULL)) {
 		tester_warn("Failed to send HCI disconnect command");
 		tester_test_failed();
 		return;
 	}
 }
 
-static void test_adv_report(const void *data, uint8_t size, void *user_data)
+static void test_adv_report(struct iovec *iov, void *user_data)
 {
 	struct user_data *user = tester_get_data();
-	uint8_t subevent = *((uint8_t *) data);
-	const struct bt_hci_evt_le_adv_report *lar = data + 1;
+	uint8_t subevent;
+	const struct bt_hci_evt_le_adv_report *lar;
+
+	if (!util_iov_pull_u8(iov, &subevent)) {
+		tester_warn("Invalid response (length too short)");
+		tester_setup_failed();
+		return;
+	}
 
 	switch (subevent) {
 	case BT_HCI_EVT_LE_ADV_REPORT:
+		lar = util_iov_pull_mem(iov, sizeof(*lar));
+		if (!lar) {
+			tester_warn("Invalid response (length too short)");
+			tester_setup_failed();
+			return;
+		}
+
 		if (!memcmp(lar->addr, user->bdaddr_ut, 6))
 			tester_setup_complete();
 		break;
diff --git a/tools/ibeacon.c b/tools/ibeacon.c
index 8dd1f4616c77..0f96c1f6b307 100644
--- a/tools/ibeacon.c
+++ b/tools/ibeacon.c
@@ -39,7 +39,7 @@ static bool shutdown_timeout(void *user_data)
 	return false;
 }
 
-static void shutdown_complete(const void *data, uint8_t size, void *user_data)
+static void shutdown_complete(struct iovec *iov, void *user_data)
 {
 	unsigned int id = PTR_TO_UINT(user_data);
 
@@ -106,12 +106,11 @@ static void set_adv_enable(void)
 					&enable, 1, NULL, NULL, NULL);
 }
 
-static void adv_data_callback(const void *data, uint8_t size,
-							void *user_data)
+static void adv_data_callback(struct iovec *iov, void *user_data)
 {
-	uint8_t status = *((uint8_t *) data);
+	uint8_t status;
 
-	if (status) {
+	if (!util_iov_pull_u8(iov, &status) || status) {
 		fprintf(stderr, "Failed to set advertising data\n");
 		shutdown_device();
 		return;
@@ -122,13 +121,13 @@ static void adv_data_callback(const void *data, uint8_t size,
 	set_adv_enable();
 }
 
-static void adv_tx_power_callback(const void *data, uint8_t size,
-							void *user_data)
+static void adv_tx_power_callback(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_le_read_adv_tx_power *rsp = data;
+	const struct bt_hci_rsp_le_read_adv_tx_power *rsp;
 	struct bt_hci_cmd_le_set_adv_data cmd;
 
-	if (rsp->status) {
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
 		fprintf(stderr, "Failed to read advertising TX power\n");
 		shutdown_device();
 		return;
@@ -159,12 +158,12 @@ static void adv_tx_power_callback(const void *data, uint8_t size,
 					adv_data_callback, NULL, NULL);
 }
 
-static void local_features_callback(const void *data, uint8_t size,
-							void *user_data)
+static void local_features_callback(struct iovec *iov, void *user_data)
 {
-	const struct bt_hci_rsp_read_local_features *rsp = data;
+	const struct bt_hci_rsp_read_local_features *rsp;
 
-	if (rsp->status) {
+	rsp = util_iov_pull_mem(iov, sizeof(*rsp));
+	if (!rsp || rsp->status) {
 		fprintf(stderr, "Failed to read local features\n");
 		shutdown_device();
 		return;
-- 
2.48.1

