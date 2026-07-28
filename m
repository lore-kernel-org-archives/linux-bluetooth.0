Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58AE33D4F8
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262829; cv=none; b=GIcqmCBph8pIKngGCBpqtx4pn5n7/VsA7tbY8YpdI3F1PJQ+t86UKzWmqFrL5LoroXQyFjKvzSEh4RKEugNnhvzh1epctIyEdtnkxVXCEXT+I7ZRcvRJBAEzOZmImlRBFhYhelALi5/QnSVMBln5XY6SGzPTPOMCitgvCSt8IK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262829; c=relaxed/simple;
	bh=Mikba5usP6qdSQ7L2DdZV6KiFE0veifkAyjw+tV/euE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgfxR5WatueFoPmw1c9b4gcvDOvqUj5sbukyJS9YWq1Zwqcm80Dg3bINhPR+7fdFhE7iKs/WR9KZ8njrYxx0PFd4Ccyc5OD3igoRoOGO4NV0VXQP6NcwDsPm9EsyLYNFCUnS+eUAIImknhQsSzev2X6zKlU1FTtEglg9fy9c0Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWjSMJlG; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWjSMJlG"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-73720e58dafso36824137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 11:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785262826; x=1785867626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oKqPF7nwFsOZcAdMarQeGzeKY7dl1YKDiH+2Pw0qz4c=;
        b=UWjSMJlGHjNANvdEfrUBi9yr/QckvcIDeRRZlBWWuMv88Tmy44qhrPPXZyPK+S2MHG
         C3QUrI630ad5cRXOtaBh+vx2H3yNvldxuaqdy+n7dLMcXsiNxEMFURCKHZX6onVFBVsT
         owtc+huBOZQU9o8EDjcwta/EzFpKrYwNgq//ZDEL8wzybQSClL/bhrRsykdd16Z4GecZ
         asJP/5ym1c3yfTq4MpH/2UZFapW7O6LXlLeL68PUULAQBrt/7lwRvjNMl5gPAlbZy2LO
         EuUvUIFWBXgX3Ve4bJ19dl1UaGulfEU+tn+Q2bGhX2ch3fVNe//WeZ/1VTx3tucrNwan
         Q/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785262826; x=1785867626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oKqPF7nwFsOZcAdMarQeGzeKY7dl1YKDiH+2Pw0qz4c=;
        b=f6NtrBiW6eZ6ZXfVuxhFh6jP+DdDA9q6DXIg6bETmejMKL05NsYZJM3W8EOZqjYmQ8
         v9DMm9KovRwMCd8RaiyFNJZxWol0QzzvpDvGTj+8ZVmy2CP9F6752AQ+hWTAoWxlEWKn
         7Q0AqarNxq7C02yHouwry/YdOBsKgf1P6Rz88XJ6nDo94DdN2h/y+LMwWdguhPBb742A
         MLb6luvUOaHLe8Vk6oy2uVTJpx+FyP6cCM+4OscWMwDMgP9e7dNYZxaazwljMx3uxOiY
         WmlTgBEHr9maypYsVsyUFG1GdEPZW2RG5QBOyhY+ViPqYFKKT2kmnJQJId94cNgQas9f
         uWPQ==
X-Gm-Message-State: AOJu0YwhDm7kWCbjRFfUuFW3LxmZPRPHf6Wgy/PEd0zyZzsAkNabusFc
	dTx2F3vnNxkfD5Tz7MkS8Q8lLtzz13pDjRL1e0UvMHt3bvYUwGIW9CNF5j151KTu
X-Gm-Gg: AR+sD10jfDu39WTgFu0tolEA4lMytUh8YSG1cqQ2gamvGbuFtgp6mvAbqxUZvlxHzOd
	XtrIQL8iNlMmcDsAaM4XBbdq1InRY92aQ0VKRCnI9x6p8BvEekSDW1fNTcHpBMHexAuohMhxzcE
	3HkQMCH5BHpyT0Ir6YDBWkHnS+++rxTkEXDvughx5iG/kEm5ZmowK1nkLC6MqJVTBthMakcO42M
	fwyQIc23iic6HIlqyOJ0i7ZNvdZmz+jTnhHEjoRaHhkz6dgqOrjpR0Vh8jo+L/1ynfsdhM2XX2e
	7YY9SRjRE+DGlwjt6t0xqYp7PGuhRi/PtBSzTcaIvWg8WGYO3YnoqDxUjhME/dlxDdHtYg+zuut
	SLGwftgNX4SQHo7WPD0UGN/9W5o6U3XXVtikRuotqL2qS4ZRSnZSqCLRDeOSznHTBkNM2ardRP2
	RWHmVwtSrKwfosl+Vc4/kQL2bHIFIvpAdO9ICuAGHs3W7yiOh5jK90W8M8cehZkjBxNlLSNpfe
X-Received: by 2002:a05:6102:f0a:b0:74f:1fcf:cc29 with SMTP id ada2fe7eead31-754a16a5e1bmr1913872137.15.1785262826330;
        Tue, 28 Jul 2026 11:20:26 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-977b268a5cbsm360688241.9.2026.07.28.11.20.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 11:20:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: Add MGMT Load Connection Subrate command
Date: Tue, 28 Jul 2026 14:20:11 -0400
Message-ID: <20260728182011.2334554-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728182011.2334554-1-luiz.dentz@gmail.com>
References: <20260728182011.2334554-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add MGMT_OP_LOAD_CONN_SUBRATE (0x005C) command to load per-device
connection subrate parameters when the SCI feature is supported.

Add MGMT_EV_CONN_SUBRATE (0x0033) event to notify userspace when
connection rate changes occur via the LE Connection Rate Change HCI
event.

Add subrate fields (subrate_min, subrate_max, max_latency, cont_num)
to struct hci_conn_params to store the loaded subrate parameters, and
the corresponding le_rate_* fields to struct hci_conn to track the
parameters currently in use.

When a single entry is loaded for an already-connected central, or on
connection completion, the LE Connection Rate Request procedure is
initiated to apply the parameters.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  15 ++++
 include/net/bluetooth/hci_sync.h |   1 +
 include/net/bluetooth/mgmt.h     |  28 +++++++
 net/bluetooth/hci_event.c        |  30 ++++++--
 net/bluetooth/hci_sync.c         |  62 +++++++++++++++
 net/bluetooth/mgmt.c             | 128 +++++++++++++++++++++++++++++++
 6 files changed, 258 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index de0eb0ca5918..a5ea461f45c9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -720,6 +720,11 @@ struct hci_conn {
 	__u16		le_conn_interval;
 	__u16		le_conn_latency;
 	__u16		le_supv_timeout;
+	__u16		le_rate_interval;
+	__u16		le_subrate;
+	__u16		le_rate_latency;
+	__u16		le_cont_num;
+	__u16		le_rate_supv_timeout;
 	__u8		le_adv_data[HCI_MAX_EXT_AD_LENGTH];
 	__u8		le_adv_data_len;
 	__u8		le_per_adv_data[HCI_MAX_PER_AD_TOT_LEN];
@@ -810,6 +815,14 @@ struct hci_conn_params {
 	u16 conn_latency;
 	u16 supervision_timeout;
 
+	u16 rate_min_interval;
+	u16 rate_max_interval;
+	u16 subrate_min;
+	u16 subrate_max;
+	u16 max_latency;
+	u16 cont_num;
+	u16 rate_supv_timeout;
+
 	enum {
 		HCI_AUTO_CONN_DISABLED,
 		HCI_AUTO_CONN_REPORT,
@@ -2497,6 +2510,8 @@ void mgmt_advertising_removed(struct sock *sk, struct hci_dev *hdev,
 int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *skip);
 void mgmt_adv_monitor_device_lost(struct hci_dev *hdev, u16 handle,
 				  bdaddr_t *bdaddr, u8 addr_type);
+void mgmt_conn_subrate_notify(struct hci_dev *hdev, struct hci_conn *conn,
+			      u8 status);
 
 int hci_abort_conn(struct hci_conn *conn, u8 reason);
 void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 0756d6fe77d4..a6579a868678 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -183,6 +183,7 @@ int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 			    struct hci_conn_params *params);
+int hci_le_conn_rate_request(struct hci_dev *hdev, struct hci_conn *conn);
 
 int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index b285441db55b..1e22eab1081c 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -894,6 +894,23 @@ struct mgmt_cp_hci_cmd_sync {
 } __packed;
 #define MGMT_HCI_CMD_SYNC_SIZE		6
 
+#define MGMT_OP_LOAD_CONN_SUBRATE	0x005C
+struct mgmt_conn_subrate {
+	struct mgmt_addr_info addr;
+	__le16 min_interval;
+	__le16 max_interval;
+	__le16 subrate_min;
+	__le16 subrate_max;
+	__le16 max_latency;
+	__le16 cont_num;
+	__le16 supv_timeout;
+} __packed;
+struct mgmt_cp_load_conn_subrate {
+	__le16 param_count;
+	struct mgmt_conn_subrate params[] __counted_by_le(param_count);
+} __packed;
+#define MGMT_LOAD_CONN_SUBRATE_SIZE	2
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
@@ -1193,3 +1210,14 @@ struct mgmt_ev_mesh_device_found {
 struct mgmt_ev_mesh_pkt_cmplt {
 	__u8	handle;
 } __packed;
+
+#define MGMT_EV_CONN_SUBRATE			0x0033
+struct mgmt_ev_conn_subrate {
+	struct mgmt_addr_info addr;
+	__u8	status;
+	__le16	interval;
+	__le16	subrate;
+	__le16	latency;
+	__le16	cont_num;
+	__le16	supv_timeout;
+} __packed;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a2da7876b6b4..734a91c3351f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5867,6 +5867,17 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		}
 	}
 
+	/* If we are central and have subrate parameters stored, queue a
+	 * connection rate request to apply them.
+	 */
+	if (conn->role == HCI_ROLE_MASTER && le_sci_capable(hdev)) {
+		struct hci_conn_params *p;
+
+		p = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
+		if (p && p->subrate_max)
+			hci_le_conn_rate_request(hdev, conn);
+	}
+
 unlock:
 	hci_update_passive_scan(hdev);
 	hci_dev_unlock(hdev);
@@ -7371,16 +7382,23 @@ static void hci_le_conn_rate_change_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
-	if (ev->status)
-		return;
-
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
 	if (conn) {
-		conn->le_conn_interval = le16_to_cpu(ev->interval);
-		conn->le_conn_latency = le16_to_cpu(ev->latency);
-		conn->le_supv_timeout = le16_to_cpu(ev->supv_timeout);
+		/* Only update the stored rate parameters on success; on
+		 * failure the values in the event are not valid. Userspace is
+		 * notified either way.
+		 */
+		if (!ev->status) {
+			conn->le_rate_interval = le16_to_cpu(ev->interval);
+			conn->le_subrate = le16_to_cpu(ev->subrate);
+			conn->le_rate_latency = le16_to_cpu(ev->latency);
+			conn->le_cont_num = le16_to_cpu(ev->cont_number);
+			conn->le_rate_supv_timeout =
+				le16_to_cpu(ev->supv_timeout);
+		}
+		mgmt_conn_subrate_notify(hdev, conn, ev->status);
 	}
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9dfab81e40f8..27e23cde7a5e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7274,6 +7274,68 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
+static int hci_le_conn_rate_request_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_conn *conn = data;
+	struct hci_conn_params *params;
+	struct hci_cp_le_conn_rate cp;
+
+	hci_dev_lock(hdev);
+
+	/* Re-lookup the connection parameters under hdev->lock since the
+	 * request was queued asynchronously and the entry may have been
+	 * removed in the meantime (e.g. by Load Connection Parameters).
+	 * Snapshot the rate values so the blocking command below can run
+	 * without holding hdev->lock.
+	 */
+	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
+	if (!params) {
+		hci_dev_unlock(hdev);
+		return -ECANCELED;
+	}
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle	= cpu_to_le16(conn->handle);
+	cp.interval_min	= cpu_to_le16(params->rate_min_interval);
+	cp.interval_max	= cpu_to_le16(params->rate_max_interval);
+	cp.subrate_min	= cpu_to_le16(params->subrate_min);
+	cp.subrate_max	= cpu_to_le16(params->subrate_max);
+	cp.max_latency	= cpu_to_le16(params->max_latency);
+	cp.cont_num	= cpu_to_le16(params->cont_num);
+	cp.supv_timeout	= cpu_to_le16(params->rate_supv_timeout);
+	cp.min_ce_len	= cpu_to_le16(0x0000);
+	cp.max_ce_len	= cpu_to_le16(0x0000);
+
+	hci_dev_unlock(hdev);
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CONN_RATE,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+static void hci_le_conn_rate_request_destroy(struct hci_dev *hdev, void *data,
+					     int err)
+{
+	struct hci_conn *conn = data;
+
+	hci_conn_put(conn);
+}
+
+int hci_le_conn_rate_request(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	int err;
+
+	/* Hold a reference to the connection so it cannot be freed while the
+	 * request is pending or running on the cmd_sync worker.
+	 */
+	err = hci_cmd_sync_queue(hdev, hci_le_conn_rate_request_sync,
+				 hci_conn_get(conn),
+				 hci_le_conn_rate_request_destroy);
+	if (err < 0)
+		hci_conn_put(conn);
+
+	return err;
+}
+
 static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct hci_conn *conn = data;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 58f01fbfcf71..201969a21fdb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8160,6 +8160,115 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 				 NULL, 0);
 }
 
+static int load_conn_subrate(struct sock *sk, struct hci_dev *hdev, void *data,
+			     u16 len)
+{
+	struct mgmt_cp_load_conn_subrate *cp = data;
+	const u16 max_param_count = ((U16_MAX - sizeof(*cp)) /
+				     sizeof(struct mgmt_conn_subrate));
+	u16 param_count, expected_len;
+	int i;
+
+	if (!lmp_le_capable(hdev) || !le_sci_capable(hdev))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_CONN_SUBRATE,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
+	param_count = __le16_to_cpu(cp->param_count);
+	if (param_count > max_param_count) {
+		bt_dev_err(hdev, "load_conn_subrate: too big param_count value %u",
+			   param_count);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_CONN_SUBRATE,
+				       MGMT_STATUS_INVALID_PARAMS);
+	}
+
+	expected_len = struct_size(cp, params, param_count);
+	if (expected_len != len) {
+		bt_dev_err(hdev, "load_conn_subrate: expected %u bytes, got %u bytes",
+			   expected_len, len);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_CONN_SUBRATE,
+				       MGMT_STATUS_INVALID_PARAMS);
+	}
+
+	bt_dev_dbg(hdev, "param_count %u", param_count);
+
+	hci_dev_lock(hdev);
+
+	for (i = 0; i < param_count; i++) {
+		struct mgmt_conn_subrate *param = &cp->params[i];
+		struct hci_conn_params *hci_param;
+		u16 min, max, subrate_min, subrate_max;
+		u16 max_latency, cont_num, supv_timeout;
+		u8 addr_type;
+
+		bt_dev_dbg(hdev, "Adding subrate %pMR (type %u)",
+			   &param->addr.bdaddr, param->addr.type);
+
+		if (param->addr.type == BDADDR_LE_PUBLIC) {
+			addr_type = ADDR_LE_DEV_PUBLIC;
+		} else if (param->addr.type == BDADDR_LE_RANDOM) {
+			addr_type = ADDR_LE_DEV_RANDOM;
+		} else {
+			bt_dev_err(hdev, "ignoring invalid connection subrate parameters");
+			continue;
+		}
+
+		min = le16_to_cpu(param->min_interval);
+		max = le16_to_cpu(param->max_interval);
+		subrate_min = le16_to_cpu(param->subrate_min);
+		subrate_max = le16_to_cpu(param->subrate_max);
+		max_latency = le16_to_cpu(param->max_latency);
+		cont_num = le16_to_cpu(param->cont_num);
+		supv_timeout = le16_to_cpu(param->supv_timeout);
+
+		/* Validate the parameters before storing them. Reject
+		 * logically inconsistent values instead of forwarding them to
+		 * the controller.
+		 */
+		if (min > max || subrate_min > subrate_max ||
+		    subrate_min < 1 || supv_timeout < 1) {
+			bt_dev_err(hdev, "ignoring invalid connection subrate parameters");
+			continue;
+		}
+
+		hci_param = hci_conn_params_add(hdev, &param->addr.bdaddr,
+						addr_type);
+		if (!hci_param) {
+			bt_dev_err(hdev, "failed to add connection parameters");
+			continue;
+		}
+
+		hci_param->rate_min_interval = min;
+		hci_param->rate_max_interval = max;
+		hci_param->subrate_min = subrate_min;
+		hci_param->subrate_max = subrate_max;
+		hci_param->max_latency = max_latency;
+		hci_param->cont_num = cont_num;
+		hci_param->rate_supv_timeout = supv_timeout;
+
+		/* If the device is connected as central check if the
+		 * connection rate parameters need to be updated.
+		 */
+		if (!i && param_count == 1) {
+			struct hci_conn *conn;
+
+			conn = hci_conn_hash_lookup_le(hdev,
+						       &hci_param->addr,
+						       addr_type);
+			if (conn && conn->role == HCI_ROLE_MASTER &&
+			    (conn->le_rate_interval < min ||
+			     conn->le_rate_interval > max ||
+			     conn->le_subrate < subrate_min ||
+			     conn->le_subrate > subrate_max))
+				hci_le_conn_rate_request(hdev, conn);
+		}
+	}
+
+	hci_dev_unlock(hdev);
+
+	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_LOAD_CONN_SUBRATE, 0,
+				 NULL, 0);
+}
+
 static int set_external_config(struct sock *sk, struct hci_dev *hdev,
 			       void *data, u16 len)
 {
@@ -9577,6 +9686,8 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 						HCI_MGMT_VAR_LEN },
 	{ mesh_send_cancel,        MGMT_MESH_SEND_CANCEL_SIZE },
 	{ mgmt_hci_cmd_sync,       MGMT_HCI_CMD_SYNC_SIZE, HCI_MGMT_VAR_LEN },
+	{ load_conn_subrate,       MGMT_LOAD_CONN_SUBRATE_SIZE,
+						HCI_MGMT_VAR_LEN },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
@@ -10725,6 +10836,23 @@ int mgmt_init(void)
 	return hci_mgmt_chan_register(&chan);
 }
 
+void mgmt_conn_subrate_notify(struct hci_dev *hdev, struct hci_conn *conn,
+			      u8 status)
+{
+	struct mgmt_ev_conn_subrate ev;
+
+	bacpy(&ev.addr.bdaddr, &conn->dst);
+	ev.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
+	ev.status = mgmt_status(status);
+	ev.interval = cpu_to_le16(conn->le_rate_interval);
+	ev.subrate = cpu_to_le16(conn->le_subrate);
+	ev.latency = cpu_to_le16(conn->le_rate_latency);
+	ev.cont_num = cpu_to_le16(conn->le_cont_num);
+	ev.supv_timeout = cpu_to_le16(conn->le_rate_supv_timeout);
+
+	mgmt_event(MGMT_EV_CONN_SUBRATE, hdev, &ev, sizeof(ev), NULL);
+}
+
 void mgmt_exit(void)
 {
 	hci_mgmt_chan_unregister(&chan);
-- 
2.54.0

