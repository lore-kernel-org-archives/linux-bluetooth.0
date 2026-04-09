Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098338A733
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775773293; cv=none; b=hPQ7KzUgoi+U0usZ5UL4fTOYk1IslzGkEZZlra3aPef94SJ9O9qmLU3rO5wq05dJVtXhVtDXVEfC/snH04AmAJ5wmpwC95i36sPe1Yx7zdJzV4t+517T5Sr0pCaj63KmIGaZv9yh44wCWTFdEKByVWsXJ7Sgucn90gWlfItLJWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775773293; c=relaxed/simple;
	bh=ELpEJq4hWPejOhX1umgjnAWmFI2U0MnzcCPyQrkkao4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WTmoOSmwP3aHt/ixHoIIBwUdeIyL1XKlc+UF208Fbfc35KgNA/2MS9xkQJUUWDRCk8d1g/xfDCLoZ+4Q69mnRzOpyqOQgQIjZUc8VX11bq0kv0twk0aefIRucpqctFYpDrJY0+wta0IAgggPNgBwPCBQlPbR9gqQBiM3UrYLlT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRqkFbor; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRqkFbor"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a3be187ffbso1092132e87.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 15:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775773290; x=1776378090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QNBQanKMIAX+nqjKA0RH5nuh36MoZELT9XDcsN4ym6c=;
        b=dRqkFbor06QqOUIEsBR9EREZ3Jc6Hw7A4j+aeDS8T90ilasBFuSb+7p/6fCAU9/ncC
         7HdRCpcfo/icGJLh72jsVQybMC9qKKG7AEn3TrBT3NCPtfooLgGJACF00rsZu3jf1vPa
         BFk/Q7wV8kD+QcJVHrB4/N90Qxe/NtGWp47GRLKq6pj0qBNzrymylCJUhHIyhecQyaWH
         nVxnXLJ7G5wqdVvhl6SOdO+n3L4ivbuC5te9nOJ7GHuP2fY5o3zuhF+9oCnE54QNCYVK
         DxbRB4Ciduimw7s6bbHacMYdF4ksM3NaFN2hsYEH/4Rz+Nf1YTgrXQV1ZSFK1ikP1wcm
         s0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775773290; x=1776378090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNBQanKMIAX+nqjKA0RH5nuh36MoZELT9XDcsN4ym6c=;
        b=Bg2yxBKqkFcGH3kuyS35NN4rMgoxEwtdSdCHAyVKhqtyjGBPTRBh8Ot+nXxDYhvmou
         /IdKg/q6X7PfbKKdZghcMYKRJL44+XW7v2FhGSt2TIx0fgzkDg+oR6jKf20QIVJr7Es6
         Hna4NgSNzNb4nV3FNEOo0JUJ1M2szgTAxi54Feay2XkV4wJveA/5sOFFmXkU+AbXRgiz
         uJIKt5qq7Pun9fwM/PFw+5vIJlw/I2+jYfkM4Pk37KgMEx6/cm3AMHVAvlcUDews0v/Q
         Zg+5ntHJ+5xrer2fK3ANODoyvNcf/0Um60yWNl/hncUW7wLlLvSPtpFRM5nGJ/Y5Ujv/
         mBQw==
X-Gm-Message-State: AOJu0YynNmS/pSOjUqoc7wWmRLbJL+xuSkEvIZA3DfhHpDN9W+IjVV23
	fDXCdvaSnOeYXZB3Q0Viw67Z8KxUHU82DHUwKNlLcE98F1v2S/njgj+V
X-Gm-Gg: AeBDieu/7tJMnaMYTBodu78aDyEra+uhPQSF273ddYxaYNaVIk4zSjY/tHu7fp2gc8u
	vXu+gCbaYlhg4KXPYKk37vVCxKz1Fk6EZazLEEoU8ZY1tnBDIUqV6wrLtUz6yIZ5pe1/cbBPqwp
	mIo7BZwPOI7QELNzDmXlOB9sUkt8+YjGyZGjGHAwZETlw4ADcdnq/4UGqJMqJ0r1pxt035tx/zv
	JlBWUBq6TZwmWbM/90avmxe+wXnfXzI3/T7bG6YGW+m6zM+/x6pa26llW4RaMk1Mzow4DKOAe8n
	CZFDOHBKQlEFo+SvNc14FsA8vvwx9jGO8CfHrhZ59Qgb5lnigI6ykaW9SBUdK4EEDTzEXL10Dj8
	s1uWu5Hl8gLQt8FLIv9Y6vX3jB0QmNw8E0S9mjzzC4KmCG2FA5ttaNjd3VZsxwBZ9E7SDdon+uU
	eDbeVGGLCmu1+ewAcp9tbB7P3w6DtwwVfv0Q==
X-Received: by 2002:a05:6512:138e:b0:5a1:42ae:88b6 with SMTP id 2adb3069b0e04-5a3e7cbd1a7mr1636035e87.18.1775773289577;
        Thu, 09 Apr 2026 15:21:29 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eee8c7f8sm205144e87.20.2026.04.09.15.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 15:21:27 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion
Date: Fri, 10 Apr 2026 03:21:22 +0500
Message-ID: <20260409222122.21394-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a BLE peripheral sends an L2CAP Connection Parameter Update Request
the processing path is:

  process_pending_rx()          [takes conn->lock]
    l2cap_le_sig_channel()
      l2cap_conn_param_update_req()
        hci_le_conn_update()    [takes hdev->lock]

Meanwhile other code paths take the locks in the opposite order:

  l2cap_chan_connect()          [takes hdev->lock]
    ...
      mutex_lock(&conn->lock)

  l2cap_conn_ready()            [hdev->lock via hci_cb_list_lock]
    ...
      mutex_lock(&conn->lock)

This is a classic AB/BA deadlock which lockdep reports as a circular
locking dependency when connecting a BLE MIDI keyboard (Carry-On FC-49).

Fix this by deferring the hci_le_conn_update() and mgmt_new_conn_param()
calls to the hci_cmd_sync workqueue via hci_cmd_sync_queue(), which runs
outside any of the involved locks.

Fixes: f044eb0524a0 ("Bluetooth: Store latency and supervision timeout in connection params")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 net/bluetooth/l2cap_core.c | 76 ++++++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 95c65fece39b..e59d3af250ef 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4670,6 +4670,59 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn,
 	return 0;
 }
 
+struct conn_param_update_data {
+	u16	handle;
+	bdaddr_t dst;
+	u8	dst_type;
+	u16	min;
+	u16	max;
+	u16	latency;
+	u16	to_multiplier;
+};
+
+static int l2cap_conn_param_update_sync(struct hci_dev *hdev, void *data)
+{
+	struct conn_param_update_data *d = data;
+	struct hci_conn_params *params;
+	struct hci_cp_le_conn_update cp;
+	u8 store_hint = 0x00;
+
+	hci_dev_lock(hdev);
+
+	params = hci_conn_params_lookup(hdev, &d->dst, d->dst_type);
+	if (params) {
+		params->conn_min_interval = d->min;
+		params->conn_max_interval = d->max;
+		params->conn_latency = d->latency;
+		params->supervision_timeout = d->to_multiplier;
+		store_hint = 0x01;
+	}
+
+	hci_dev_unlock(hdev);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle		= cpu_to_le16(d->handle);
+	cp.conn_interval_min	= cpu_to_le16(d->min);
+	cp.conn_interval_max	= cpu_to_le16(d->max);
+	cp.conn_latency		= cpu_to_le16(d->latency);
+	cp.supervision_timeout	= cpu_to_le16(d->to_multiplier);
+	cp.min_ce_len		= cpu_to_le16(0x0000);
+	cp.max_ce_len		= cpu_to_le16(0x0000);
+
+	hci_send_cmd(hdev, HCI_OP_LE_CONN_UPDATE, sizeof(cp), &cp);
+
+	mgmt_new_conn_param(hdev, &d->dst, d->dst_type, store_hint,
+			    d->min, d->max, d->latency, d->to_multiplier);
+
+	return 0;
+}
+
+static void l2cap_conn_param_update_destroy(struct hci_dev *hdev, void *data,
+					    int err)
+{
+	kfree(data);
+}
+
 static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 					      struct l2cap_cmd_hdr *cmd,
 					      u16 cmd_len, u8 *data)
@@ -4677,6 +4730,7 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_conn_param_update_req *req;
 	struct l2cap_conn_param_update_rsp rsp;
+	struct conn_param_update_data *d;
 	u16 min, max, latency, to_multiplier;
 	int err;
 
@@ -4707,14 +4761,22 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 		       sizeof(rsp), &rsp);
 
 	if (!err) {
-		u8 store_hint;
-
-		store_hint = hci_le_conn_update(hcon, min, max, latency,
-						to_multiplier);
-		mgmt_new_conn_param(hcon->hdev, &hcon->dst, hcon->dst_type,
-				    store_hint, min, max, latency,
-				    to_multiplier);
+		d = kmalloc(sizeof(*d), GFP_KERNEL);
+		if (!d)
+			return 0;
 
+		d->handle = hcon->handle;
+		bacpy(&d->dst, &hcon->dst);
+		d->dst_type = hcon->dst_type;
+		d->min = min;
+		d->max = max;
+		d->latency = latency;
+		d->to_multiplier = to_multiplier;
+
+		if (hci_cmd_sync_queue(hcon->hdev,
+				       l2cap_conn_param_update_sync, d,
+				       l2cap_conn_param_update_destroy) < 0)
+			kfree(d);
 	}
 
 	return 0;
-- 
2.53.0

