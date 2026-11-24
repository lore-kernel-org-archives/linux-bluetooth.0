Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520416;
	b=NhIzqw+sGYCcxWlMpHUPLI4sX9Ki828lwTCBlIRknttzMEXzS7U3SpM8VE8W2R7x3PY/
	 L4aa7hOYSkW8wXMmN8+LvRIOxxe3Pz8aEAV9yvmd2MeFZO+4HrRjz4zI6UX/4yuRwjpab
	 6X4mQ+n7mTnn7jHU4aZ3K1tuiPOQLtsgl7ziL1ksIdG+/IuiBqRMutphzxLwQrHGgl+ME
	 MlBQh5ESi0so7SomOgSeUew8wi/xmMLq1wQmKbzClGqIt6jJ3s0okp0qXrI4DGlgEOGBM
	 InmRPJsqqXX3e+JVq3J3CvjNRFrRWgBjtmi3Gg1G3USEeQqTQVW/tUdvETgOF1EV9BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NDYjESqBLUg1GNm1AyKfWdsE1IVDEH8BqTkPogtKPPg=;
	b=FTkE/jjiYDWe8eR/v3FJ9fBZzlvqMQMO1FrOGPmkDsp94qgqlWdH01xsmsvUwk6n4UGz
	 p95YqYCWORLESCHoYvphO8LOBZDUSjalCdjCzQYQoRIi6Y1Y8qeQMxsU78/+oYYabup9R
	 dZyDAPIEvh7LcrksX/v1TE2ph6WIrFN2YUClZPhN2EDxUsZwlRQnHv+z0vlESRCKsaASM
	 ja9IIYpryMF7VZEd+sKj/zPZ75f7sRjOqY82ds8inJ9BqzrFN9KlxaQbyaM+qBC+04/y8
	 B4vELwE+1qZmVOTUsGW6+CtL9kR6Yfp5MAnaNp8lXye6dTzUXQrZ+P+9JffMsycLW8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=yvQQvQ6U;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F3606A32D
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 11:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 320F3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=yvQQvQ6U
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so33930195e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 03:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795520414; x=1796125214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NDYjESqBLUg1GNm1AyKfWdsE1IVDEH8BqTkPogtKPPg=;
        b=yvQQvQ6Un72maWSRLRe7fsBylDdg2eliFyxENvzgQJ36fz8i98BP5o8/cLT+7t3ELC
         HPB7RDPqSXC2x9sB8rLmXf6AjhXHVVmneaA95H/Bc3yBJS+sHF3e9R8Rj1Ec2llCcDMg
         wZkeZbCCWjOilgPjAdjYNZpZmLEJ2LrAANkVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795520414; x=1796125214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NDYjESqBLUg1GNm1AyKfWdsE1IVDEH8BqTkPogtKPPg=;
        b=qntMqRt79rhRfwpVy+p1SZHIKJTCtH7Uc9aWKpJ8qA78B7f4tcuXuJgxrh/gWsjfvW
         D4EPm2oeW3h6BnoJ2Kk4rY6TIm23ZK8Xq6pJxUekWGB8Tl7qYwEBA5dN4ydHPtTt+W46
         uDWc3V7hHbImSrUdjccpRKcH9OnjvyzaR8sprbgYqJV2o5bj/rvYpIzgGoBJy9lVtRNz
         risZ8BHg4F5qtSIXU8ajUfI/0VaeKQ0ADpEQiaRo/o8rQ9PnweHWepitCzhjymy/OEjM
         K9o+kaE4vf3G8kYUWLQBprX6TYgWVKNsP6940J72nqNklEwFnXX2XTHqDi73PDkRhP5Y
         BoEg==
X-Gm-Message-State: APuU4Z+Cq70JxOhFCXhdHrKPMQVGgpD5FOL2GnWXaRR1h+v97v462HTE
	Yl2YTksu7ab2pkuHefQ5gROM0GpYD1y82coxsNha8JIkmMBykQJtFMGDhQoI4VUFJe92rnx3uAE
	drkmN
X-Gm-Gg: AZFdTZe80UyGAjvwLWZTufgpEXpK0Q5Nf4u3xJkS2vbJA3/E/f1+QGxiksK/AkOSuU5
	zPZj6MZRiGlSC+t1bsjLf3+ryPqbBVfxEb0iMdP97ymqsAwtUIKWVPlRf8jWGdxvDyvECWt6RAx
	YiHMfI8x91PLTXbntKEr4fxfkbSvQTZ/x/3wbrzbce+rVhIKA8tX8Fhq5vTX2ZfofEpdHgaJgpC
	WQmdt8LZOd3z/43RBH7GCzQezlxzt7plRadPmCaPHfY65S6RhgeK8Mf4Xs/5Qwy5CaILCXkQHYv
	6BDsUCHa+yLYiPMZE7hSQ0VYMJ7EuqDR9z5M4fzOZcx3A3hT9essKC/HmfaMYmJnQTQlecjHXvP
	tF1QKkIfx1JDZ3dKrJpek2bytGpjNkuBD+/9Ov1GifegWzA+4kC8CoSOSmxOykMG05+5H3iwvh/
	7/1rRaV+lEo0thoGj5A7f4WjuHaf8xg9kjK6sEuMgKQ9X0gM38/gOzqhIx4V9159HPRFYFrbuje
	qM7osy49Lg0W/kAB6qGKsm8LTEbE1F1Iz6r/+KyaV8oTrs3bAq771ZnLKODITxA51gwD0mW0iu6
	BnlYpH+MGlBywM+FFqJpJvEvl8U68XYhPAZFu0BfQB/a/odfbiGuYDkKu5J+DL0SNXAEdNI=
X-Received: by 2002:a05:600d:82d0:b0:4bb:818d:8d8f with SMTP id 5b1f17b1804b1-4bb88818955mr346872705e9.23.1795520414476;
        Tue, 24 Nov 2026 03:40:14 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9846sm506581225e9.11.2026.11.24.03.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:40:14 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2 3/3] Bluetooth: hci_sync: Fix closing all BISes while their BIG is created
Date: Tue, 24 Nov 2026 12:40:10 +0100
Message-ID: <20261124114010.1696510-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124114010.1696510-1-simon.mikuda@streamunlimited.com>
References: <20261124114010.1696510-1-simon.mikuda@streamunlimited.com>
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

LE Create BIG does not wait for LE BIG Complete. If all BIS sockets of
the BIG are closed in between, their BISes are still bound and the BIG
is not marked as created, so the cleanup of the last one disables the
periodic advertising and removes the advertising set the BIG is being
created on. The BIG is terminated only afterwards, when LE BIG Complete
finds no BIS for it.

Steps to reproduce, with btmon running: open two ISO sockets for one
BIG as BlueZ does (BT_ISO_QOS and BT_ISO_BASE on both, BT_DEFER_SETUP
on the first, then connect() both, the second one non-blocking, which
sends LE Create BIG) and close() both right after that connect().

With the Zephyr controller (on an nRF54L15) and a 7.3-rc2 based kernel,
in 5 of 5 runs:

  < HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068)
  > HCI Event: Command Status (0x0f) plen 4
          Status: Success (0x00)
  < HCI Command: LE Set Periodic Advertising Enable (0x08|0x0040)
          Periodic advertising: Disabled (0x00)
  > HCI Event: Command Complete (0x0e) plen 4
          Status: Success (0x00)
  < HCI Command: LE Set Extended Advertising Enable (0x08|0x0039)
          Extended advertising: Disabled (0x00)
  > HCI Event: Command Complete (0x0e) plen 4
          Status: Success (0x00)
  < HCI Command: LE Remove Advertising Set (0x08|0x003c)
  > HCI Event: Command Complete (0x0e) plen 4
          Status: Command Disallowed (0x0c)
  > HCI Event: LE Meta Event (0x3e) plen 23
        LE Broadcast Isochronous Group Complete (0x1b)
          Status: Success (0x00)
  < HCI Command: LE Terminate Broadcast Isochronous Group (0x08|0x006a)

  Bluetooth: hci1: Opcode 0x203c failed: -16

The BIG is terminated, but the advertising set stays in the controller
and as an advertising instance in the host.

With a Synaptics SYN43756 controller and a 6.18.2 based vendor kernel,
LE BIG Complete came 2 to 66 ms after LE Create BIG and the cleanup
started 43 to 55 ms after the command, so there the order depends on
timing: 5 of 10 runs went wrong. In 4 of them the set was removed
first, with Success. LE BIG Complete then never came, and the next LE
Create BIG with that BIG handle got Command Disallowed. In the fifth,
LE BIG Complete arrived during the cleanup; the controller answered the
LE Terminate BIG that followed the removal of the set with a Command
Status, then sent 2690 vendor events instead of LE Terminate BIG
Complete and answered no command after that.

Wait for LE BIG Complete, or LE Create BIG Complete v2 on an HDT capable
controller, for up to conn->conn_timeout, as LE Create CIS waits for LE
CIS Established. Delete a BIS closed meanwhile as one of a created BIG, so
that the last one terminates the BIG first.

Both test kernels lack hci_le_create_big_sync() and send LE Create BIG
from hci_le_create_big() in hci_conn.c, so the same wait was tested
there, and LE Create BIG v2 was not run on either controller. With the
wait, both controllers get LE Terminate BIG after LE BIG Complete, and
the periodic advertising is disabled, the advertising disabled and the
set removed after LE Terminate BIG Complete, all with Success: 5 of 5
runs with Zephyr, 15 of 15 with the Synaptics controller. In these runs
one of the two BISes is connected at LE BIG Complete and gets LE Setup
ISO Data Path before LE Terminate BIG.

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/hci_event.c | 11 +++++++++++
 net/bluetooth/hci_sync.c  | 23 +++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b6c7f9a9f55a..25bf13a06179 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7894,6 +7894,17 @@ static void hci_le_create_big_complete(struct hci_dev *hdev, u8 status,
 			continue;
 		}
 
+		/* A BIS closed during LE Create BIG is still bound. Delete it
+		 * now, so that the last one terminates the BIG first.
+		 */
+		if (conn->abort_reason) {
+			i++;
+			set_bit(HCI_CONN_BIG_CREATED, conn->flags);
+			hci_connect_cfm(conn, conn->abort_reason);
+			hci_conn_del(conn);
+			continue;
+		}
+
 		if (hci_conn_set_handle(conn,
 					__le16_to_cpu(bis_handle[i++]))) {
 			bt_dev_err(hdev,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 83e59ba2a45b..01a691269f37 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -8998,8 +8998,15 @@ static int hci_le_create_big_v2_sync(struct hci_conn *conn,
 		cp.bis.hdt_rates = cpu_to_le16(qos->bcast.out.rates ? :
 					       hci_hdt_tx_rates(hdev));
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_BIG_V2,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	/* Wait for LE BIG Complete, so that the cleanup of BISes closed
+	 * meanwhile terminates the BIG before removing its advertising set.
+	 * An HDT capable controller reports it with LE Create BIG Complete v2,
+	 * which hci_le_set_event_mask_sync() unmasks for it.
+	 */
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_BIG_V2,
+					sizeof(cp), &cp,
+					HCI_EVT_LE_CREATE_BIG_COMPLETE_V2,
+					conn->conn_timeout, NULL);
 }
 
 int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_ext *qos,
@@ -9025,8 +9032,16 @@ int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_ext *qos,
 	cp.bis.encryption = qos->bcast.encryption;
 	memcpy(cp.bis.bcode, qos->bcast.bcode, sizeof(cp.bis.bcode));
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_BIG,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	/* Wait for LE BIG Complete, so that the cleanup of BISes closed
+	 * meanwhile terminates the BIG before removing its advertising set.
+	 * An HDT capable controller reports it with LE Create BIG Complete v2
+	 * even here, since that is the one unmasked.
+	 */
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_BIG,
+					sizeof(cp), &cp, hdt_capable(hdev) ?
+					HCI_EVT_LE_CREATE_BIG_COMPLETE_V2 :
+					HCI_EVT_LE_CREATE_BIG_COMPLETE,
+					conn->conn_timeout, NULL);
 }
 
 static void le_enable_encrypt_complete(struct hci_dev *hdev, void *data, int err)
-- 
2.43.0

