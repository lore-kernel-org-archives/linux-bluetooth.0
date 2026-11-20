Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189674;
	b=0R71BpUWHxwj9Z4glmY+VFdhqYh0UFEqPWFa1mA1hhq/jtx6H5wE4r8Kq6qJ3cPpZaCz
	 7k6bwJZ23o8fjeVBdWMlhpwVrQDLiKTfOEaVdwIVEx96/MvvTlj80NfroVu5u6THqwamg
	 yAF/YDa45N34buWkraQbsCyEuXlLN4FisXYCCbYEGScuwGeFuutRtbBWYRSdAeBZHqXLx
	 aFTG0qvzs+bzq/rRhKEO6YA5YMR1991EMFpsqQ8AagM52BNl39AtCF7l1Kzj0hMSAHBFH
	 2AP46mMVeTfgmP2aSXnIiXJ/FYgRsKyLT50pH/XOpiRzWHhI1nyjjS3QLbnIY8i9PEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jLLPiV1rvSMMGLBYkGcSf0yw0iogICCJHvUrydl9SsU=;
	b=mzsQWC4iYE4ADr/wrEE03mnMy1pnHBvGBFgLBX/T7YyXcgofD8UZOptP+jLjerIu3i/Z
	 kDig4Nb2bRYGThlE+whzyuIX/v+NqRNtGAn14+mps7/Zzj+1zh63ZJCfEShw5tRefl1WW
	 G0z93ONfTNZqn3/J6qsKPzWn8v4I3EVirM6H6kDv8v/0NoVYMOtc3flp1qKYi+19F3NfK
	 nvHhwKh5P8BBLnEr7QKYYBdvM/n3JkA9FWQBzr5dcsixGE5W9NGE6JYKKBD8qkTzgOymc
	 ctuusbanyWdIneQ2Qr4FRW6qqaB5+RZqMqzFuFH4owoIqReSWgdZimr0O/qzBMLhtRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QBra4AUs;
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A04C60A2609
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 15:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A04C60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QBra4AUs
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7cc53938a8fso758264137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 07:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795189673; x=1795794473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jLLPiV1rvSMMGLBYkGcSf0yw0iogICCJHvUrydl9SsU=;
        b=QBra4AUsliY/0Z6XgRJmuJ0nwlpLbrzMeAe1SDY1tQF+tFVxOmNBYzg/yptePHiJac
         KsfRmV5D6ej03LTHnyZkrA8wkMcZEnSjFxBbCOGti71/ORrs4iOSoebYYqRDJXfCDM3x
         SypB8cRuIqfJe996KzjDDBdUtYtp6fv3O9tl6+mlmOZjaT3iGJZtwR+UvqlPoEwH1ViO
         pKvMhdSj8/zbBdNq0C9kWuqUrtSGnkN6nOz69m6J17Xq0ESGaOXvhSkZqYbqoaiLaeEl
         OGvFQwPj5GLC050FIhTUeekhlKzukEE/YXq1/PwXh+mQSh59Lq29lah17mP5wqrjsmD4
         HBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795189673; x=1795794473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jLLPiV1rvSMMGLBYkGcSf0yw0iogICCJHvUrydl9SsU=;
        b=xZUYHEfKxjFfEons3uPTdZ/UbfsHQ92HV/Ub0NAmCH+8RJtVDTaYclWOegg7d9JQGj
         RYwm7rFPvSH3z4t5GWiHUNe2ECYLGN6q3S2Sy+Z9v9q2txWkgbbCLjH9VA6751JI2eed
         v02z3nRa2NZcRaLHMkfXdpl2yYAO10bj5AXLmfgm8BIKLhNI+/qII+jHEYx7eraGF5bY
         x4FN8oJa9pgYlDppIL6UVa/5pH8Fbgjzzd1dJEMRR2w/D5bXGlLNVMV8+7phfHF40/6y
         Eg2AORU3rp2DLM8oZYn7B5O7jnkV4LJVdwH18V3oPEQ/jwyKnKk8tMbBpThfBTOhQpn2
         gM9w==
X-Gm-Message-State: APuU4Z8NdV20NG8T65ptLqRSrsiKyYABIRQTWjCXv2Tb3VhbGw7szl8W
	eBw2eRRZjUwqHggkD/kMj8VmuklBfzSBdCyBEMhA87u71gC60j3XQ6CkRtNI6cfM
X-Gm-Gg: AZFdTZebJja1SifwFEP64sdNSdiw+HffShI+vvkuxBxLnuZo27eMG4MtCOs5vX+PvOE
	5uMWkG0XfSjGjN+crRwuYmbL/43NKBS+JpAeMAfC00N6wLJW0c3KMktsfEQM7qCt414FzYZDa30
	biU5I1lbCnw8/JPTPl36Pu3QaHWHtIcYxVW1bpCAL+aZ9XilBL7MhIvt2us7uq94wJxWHKu2k7h
	Oe5SQJP6rjx9Gw7w7/Rvk87ILPiBjEPqt9qBHcBD/q8NfLEfZqE7tc0qGyZf3BzhPuU5ku4AXCE
	aIJkcfrh0htH+vfp2FqZ8tQnGRx+0b19ZtI4GzBDAIYrXM95V0K3fRazFmJJzi0xroK03fnRSkj
	B9zyWMjvVX6IYoO/XGnQgCEy7j+GPah+nKX9z/gTWPCiNt/AUNJXWKBXCJEEamQGo73n9gQLars
	O1E3L/9oEZ1qt+Eu/sPQ+CzCBy3o75mCJmcmSjeq8f7dKJJuhUOXTvHFjYkO9zNC+JNfpsblwFi
	Ywm8hRx/yeBsAe2L30WbvYE0O+I/95KcmNAL8/AMpDv8Nnz9gdLi/JAwcFtcL38TOW508v9vlT6
	hwRMu+3FHk0ixm/loSqo5k15XzUzojvJGRgLh5SLiyE+osfJJ9K5LERA0WawJABMiflLigsSLko
	rJq2EOyZggPqsJx6vhIkNMTUK/+IiFRNixlt5duOSqHFvseARCfW2iGPk7PIchgkLZOnOP3NoFh
	849WU=
X-Received: by 2002:a05:6102:5698:b0:7d2:8610:3223 with SMTP id ada2fe7eead31-7d73968ae3emr1809272137.34.1795189673258;
        Fri, 20 Nov 2026 07:47:53 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7b12eb7sm3358243137.0.2026.11.20.07.47.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:47:52 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/5] emulator/bthost: Add helpers to test security of deferred setup
Date: Fri, 20 Nov 2026 10:47:46 -0500
Message-ID: <20261120154750.1745643-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120154750.1745643-1-luiz.dentz@gmail.com>
References: <20261120154750.1745643-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add helpers so testers can control the remote side while a connection
is pending:

 - bthost_hold_auth_request()/bthost_release_auth_request() hold the
   reply to a PIN Code or IO Capability Request, keeping pairing in
   progress until it is released.
 - bthost_set_l2cap_rsp_pending() keeps a request while its Connection
   Response is pending, so its callback is called with the final
   response as well.
 - bthost_set_conn_encrypt() enables/disables the encryption of a
   BR/EDR connection.

Assisted-by: OpenCode:claude-fable-5.2
---
 emulator/bthost.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++
 emulator/bthost.h |  6 ++++
 2 files changed, 92 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index e65d29faa989..afc83891778e 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -207,6 +207,7 @@ struct l2cap_pending_req {
 	bthost_l2cap_rsp_cb cb;
 	void *user_data;
 	struct l2cap_pending_req *next;
+	bool pending;
 };
 
 struct l2cap_conn_cb_data {
@@ -273,6 +274,11 @@ struct bthost {
 	uint8_t io_capability;
 	uint8_t auth_req;
 	bool reject_user_confirm;
+	bool hold_auth_request;
+	bool auth_request_held;
+	bool auth_request_pin;
+	bool l2cap_rsp_pending;
+	uint8_t auth_request_bdaddr[6];
 	void *smp_data;
 	bool conn_init;
 	bool le;
@@ -1543,6 +1549,13 @@ static void evt_pin_code_request(struct bthost *bthost, const void *data,
 	if (len < sizeof(*ev))
 		return;
 
+	if (bthost->hold_auth_request) {
+		memcpy(bthost->auth_request_bdaddr, ev->bdaddr, 6);
+		bthost->auth_request_held = true;
+		bthost->auth_request_pin = true;
+		return;
+	}
+
 	if (bthost->pin_len > 0) {
 		struct bt_hci_cmd_pin_code_request_reply cp;
 
@@ -1667,6 +1680,13 @@ static void evt_io_cap_request(struct bthost *bthost, const void *data,
 	if (!conn)
 		return;
 
+	if (bthost->hold_auth_request) {
+		memcpy(bthost->auth_request_bdaddr, ev->bdaddr, 6);
+		bthost->auth_request_held = true;
+		bthost->auth_request_pin = false;
+		return;
+	}
+
 	memcpy(cp.bdaddr, ev->bdaddr, 6);
 	cp.capability = bthost->io_capability;
 	cp.oob_data = 0x00;
@@ -2437,6 +2457,29 @@ static void handle_pending_l2reqs(struct bthost *bthost, struct btconn *conn,
 			continue;
 		}
 
+		/* A request kept while its response was pending only expects
+		 * another Connection Response, other requests may be using
+		 * the same identifier.
+		 */
+		if (req->pending && code != BT_L2CAP_PDU_CONN_RSP) {
+			curr = &req->next;
+			continue;
+		}
+
+		/* Keep the request while the response is only pending */
+		if (bthost->l2cap_rsp_pending &&
+				code == BT_L2CAP_PDU_CONN_RSP &&
+				len >= sizeof(struct bt_l2cap_pdu_conn_rsp)) {
+			const struct bt_l2cap_pdu_conn_rsp *rsp = data;
+
+			if (le16_to_cpu(rsp->result) == 0x0001) {
+				req->pending = true;
+				req->cb(code, data, len, req->user_data);
+				curr = &req->next;
+				continue;
+			}
+		}
+
 		*curr = req->next;
 		req->cb(code, data, len, req->user_data);
 		free(req);
@@ -4276,6 +4319,49 @@ uint8_t bthost_get_auth_req(struct bthost *bthost)
 	return auth_req;
 }
 
+void bthost_hold_auth_request(struct bthost *bthost, bool hold)
+{
+	bthost->hold_auth_request = hold;
+}
+
+void bthost_release_auth_request(struct bthost *bthost)
+{
+	bthost->hold_auth_request = false;
+
+	if (!bthost->auth_request_held)
+		return;
+
+	bthost->auth_request_held = false;
+
+	if (bthost->auth_request_pin) {
+		struct bt_hci_evt_pin_code_request ev;
+
+		memcpy(ev.bdaddr, bthost->auth_request_bdaddr, 6);
+		evt_pin_code_request(bthost, &ev, sizeof(ev));
+	} else {
+		struct bt_hci_evt_io_capability_request ev;
+
+		memcpy(ev.bdaddr, bthost->auth_request_bdaddr, 6);
+		evt_io_cap_request(bthost, &ev, sizeof(ev));
+	}
+}
+
+void bthost_set_l2cap_rsp_pending(struct bthost *bthost, bool enable)
+{
+	bthost->l2cap_rsp_pending = enable;
+}
+
+void bthost_set_conn_encrypt(struct bthost *bthost, uint16_t handle,
+							uint8_t encr_mode)
+{
+	struct bt_hci_cmd_set_conn_encrypt cp;
+
+	cp.handle = cpu_to_le16(handle);
+	cp.encr_mode = encr_mode;
+
+	send_command(bthost, BT_HCI_CMD_SET_CONN_ENCRYPT, &cp, sizeof(cp));
+}
+
 void bthost_set_reject_user_confirm(struct bthost *bthost, bool reject)
 {
 	bthost->reject_user_confirm = reject;
diff --git a/emulator/bthost.h b/emulator/bthost.h
index b3e18114638a..92aaf42305da 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -206,6 +206,12 @@ void bthost_set_io_capability(struct bthost *bthost, uint8_t io_capability);
 uint8_t bthost_get_io_capability(struct bthost *bthost);
 void bthost_set_auth_req(struct bthost *bthost, uint8_t auth_req);
 uint8_t bthost_get_auth_req(struct bthost *bthost);
+void bthost_hold_auth_request(struct bthost *bthost, bool hold);
+void bthost_release_auth_request(struct bthost *bthost);
+void bthost_set_l2cap_rsp_pending(struct bthost *bthost, bool enable);
+void bthost_set_conn_encrypt(struct bthost *bthost, uint16_t handle,
+							uint8_t encr_mode);
+
 void bthost_set_reject_user_confirm(struct bthost *bthost, bool reject);
 bool bthost_get_reject_user_confirm(struct bthost *bthost);
 
-- 
2.56.0

