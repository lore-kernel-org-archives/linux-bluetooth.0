Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769660;
	b=HVub5PbNTkv++CwPHtVexM7eYnq9N8FStciKxTa/0vg0/e64oGLkk8YwpdF8LyKoszwj
	 5asxICc/rW69kpkWi4b+Niz+mc1BS54Xmii8/BCUGFRA9Yz0w3Lve70cWqPRZYMTx+zIn
	 MQ5q4Ld3nJIqVM85vTPFMaiPe3v6S853FIGhDhxBx/x9hWtwXpe7rrx8wIT3LZjku7XCj
	 RRaNQRtL1rulcbkzX1UJcIJAycRYqO2DEprwE/ZfcqVQ6YZYfXV5ieU5+fXZWzjWQ8ZTK
	 mWp+Bi4QrA6kk98AB6BoN8n+IoNGgVUFKBWO29lNTTT/ferRlNFyVUNz5Z0eiEnsNlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9lHiYpZy+94MgOZ16q81hBSBOGLoapFsRRnOEDMTTgY=;
	b=TqOlK7Y7IhDnAmqeP7OfWf02/OXfEYbsi02RAtrrbThnflzMp0Qcu59F0ofC3lK/bcER
	 hz7NilBvA2KobPjElyLob8zwmvbOVo6vDFavhRW4sM0EVXc3hW7w0KMIMWWsWQTnYqmuI
	 1B/blxPP61ZS5EFL57oQ2z9CZeBKqDAl8kPpGRA5MkzficIjFMSnLTQPLuhAzgPMEP5v+
	 jX6Vob1IYNk9zqcTglLkqmBGtPT7IahSXMpT0ZLD/N37XC24IdmfJyOnPMHpN+4qjC27N
	 y7cE4dGFNa8rhlJQNV722xhHwcSgQtbIP/GPHE55ZTJtu3XeK9GjLDlQIhXAZrldk9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mu80+mc+;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D110606A333
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D110606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mu80+mc+
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c505994e5f5so117904766b.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 00:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769659; x=1796374459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9lHiYpZy+94MgOZ16q81hBSBOGLoapFsRRnOEDMTTgY=;
        b=mu80+mc+63TVbYv7oqE2Dy5mpaI/+47ezeIsBONCRkY79exstHQGdMQbwuASDRxfqY
         OuNIpx6yEZS5CGnsax6qzIOdX+S7bJPv1avZz+Yfzuh+wLT+8TijOyAbgDjfu9McOpZW
         sutYLj3etCIndEHek59E3+NwLbapVEt9AspkcHDBa65o2xyAoeQGDYR89pS88/kVqjCe
         gnbyGaVenuPUdvOyN2ofo0Dnwhr8ztXRoYX6gJlVH/sbCo4NX/CxN+RC/GjGnwvNHb+3
         u7TI29JfPpk2W6PS9QUMcTEvItmcpvdQDrN6FS7JB9Wsu12daXtIaCFzA+XRfjJx46+T
         5WSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769659; x=1796374459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9lHiYpZy+94MgOZ16q81hBSBOGLoapFsRRnOEDMTTgY=;
        b=2cSnygIcTF2expSRePGzAWVgqRiAXw9wKlF8tTP81xbx/J7OvUOYKy/JnbwdYHJYV8
         eJRATeC4HPs0+/RbG4DTCaXgrTOFV1S4TwEjYtgscxFNRaKACrVAOJYYxicRF/J7u9L7
         OEoMDjXC0RdzrqDu6naB7Hbw5FPvumlHfGESC9cRw8e/J5g4R85hLFdj65cJA2nHNRjU
         txDTEoyr+nBGk1F17F7Y193B1WaMXRu8Sjwyj85qvJXUBrPUs0hemdlwu7HLiXpdpQhl
         no2vvPYbapwCoSOiVbU44+PDJWEKyVicnbavg43Vq8QaUcltxZ3dO6UF0c7RskZE8yIG
         yWOw==
X-Gm-Message-State: APuU4Z/V+/z43WmWP3UiiBxh6VDawKm+BubrQ3QP7Q3l1HlrMhqsgcC6
	mpTgD4DG/JyrYqslSVEXCv5mI0BUe6KOHw9d72WwTboOK/J4r34MI4IIFXW3Z1+Y
X-Gm-Gg: AZFdTZdT5wz0pP1Ka8+vbYL/GNo2DJ1rXkVpHLsW2yffrAXAq4D8VVUFZrUS5gl/puq
	d6pYyM014auSQh51dB0XzNOkwlp8FuiC2SpgzR/kHTSYzDUcCablesrsDzTEM/9bKeDA7KcapX6
	wO5WYRizktu/r/bI/tf/81hMXuxjHE/V+NrZNz+iuWxJg7wL7qrRQyHhK2YBK+tZDjlSzrcPnmG
	2vYlVgTLIoBr8tCLvUOjkwisglQKdHDFT4iKDPwRqNP9Ylf/MfEeZ2DvRlXL+dVzQuPzkBgNFI5
	0Jvw3nndsNYUcjfM1DHG3IXAk8f2KeO6ORjDkuavAOrIwDRpdyK9KHQ/uwBJpr201TuFFnE/nad
	2jGk+s3yPAGq3vt05bAAPrmLVLYDHQP3VKn0xqE1h4qf34pKeX1piWbRF4UlsQFPO7I09enzCX7
	ryVF8yu7Nt4b9vXSvVRsMQ1BpHHvVh98pgEuj1C4boU7D5XGCVRIZp8evIforFmxZIkYLle1OtJ
	hSgbXHu5V8JUGXEM0eED/RPBxmcNXUamnfEdbchwhxNtgiUx9Wj4T2aef5lK050VZlhoORVrIa0
	Uy7I0Jt+smKcn0egntf6AG4gxnUiw2ZZc3k=
X-Received: by 2002:a17:906:80d7:b0:c51:9c26:7f10 with SMTP id a640c23a62f3a-c519c26a5cfmr740835966b.3.1795769658616;
        Fri, 27 Nov 2026 00:54:18 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea28f4sm870688166b.33.2026.11.27.00.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:54:18 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Roland Schober <rolandschober1968@gmail.com>
Subject: [RFC PATCH 4/5] Bluetooth: MGMT: Add Add Periodic Advertising Data command
Date: Fri, 27 Nov 2026 09:53:59 +0100
Message-ID: <20261127085401.263615-5-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127085401.263615-1-rolandschober1968@gmail.com>
References: <20261127085401.263615-1-rolandschober1968@gmail.com>
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

Add a MGMT command which sets the data of the periodic advertising
train of an instance made periodic with Add Periodic Advertising
Parameters. It can be sent again to change the data while the train
runs.

The data is limited to what one LE Set Periodic Advertising Data
command takes, as the data of a BIG is. An instance with subevents is
refused: the controller does not allow the command for it.

Assisted-by: Claude:claude-fable-5-2
Signed-off-by: Roland Schober <rolandschober1968@gmail.com>
---
 include/net/bluetooth/hci_sync.h |  1 +
 include/net/bluetooth/mgmt.h     | 14 +++++
 net/bluetooth/hci_sync.c         |  2 +-
 net/bluetooth/mgmt.c             | 87 ++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 03d7e267af7c..e6d3d3de482e 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -119,6 +119,7 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 sid,
 
 int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance);
 int hci_setup_per_adv_instance_sync(struct hci_dev *hdev, u8 instance);
+int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance);
 
 int hci_remove_advertising_sync(struct hci_dev *hdev, struct sock *sk,
 				u8 instance, bool force);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 57b9d8d8b57d..a46e87a9152c 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -938,6 +938,20 @@ struct mgmt_rp_add_periodic_adv_params {
 	__u8	instance;
 } __packed;
 
+/* The data of the periodic advertising train of an instance made periodic
+ * with Add Periodic Advertising Parameters.
+ */
+#define MGMT_OP_ADD_PERIODIC_ADV_DATA	0x005E
+struct mgmt_cp_add_periodic_adv_data {
+	__u8	instance;
+	__u8	data_len;
+	__u8	data[] __counted_by(data_len);
+} __packed;
+#define MGMT_ADD_PERIODIC_ADV_DATA_SIZE	2
+struct mgmt_rp_add_periodic_adv_data {
+	__u8	instance;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3d8327180c6e..05151cf6f413 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1896,7 +1896,7 @@ static int hci_set_per_adv_params_sync(struct hci_dev *hdev, u8 instance,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
-static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
+int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	__context_unsafe(/* conditional locking */)
 {
 	DEFINE_FLEX(struct hci_cp_le_set_per_adv_data, pdu, data, length,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2870278d51b0..0f8a58ad1e3c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -131,6 +131,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_MESH_SEND_CANCEL,
 	MGMT_OP_HCI_CMD_SYNC,
 	MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+	MGMT_OP_ADD_PERIODIC_ADV_DATA,
 };
 
 static const u16 mgmt_events[] = {
@@ -9929,6 +9930,90 @@ static int add_periodic_adv_params(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static void add_periodic_adv_data_complete(struct hci_dev *hdev, void *data,
+					   int err)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_add_periodic_adv_data *cp = cmd->param;
+	struct mgmt_rp_add_periodic_adv_data rp;
+
+	bt_dev_dbg(hdev, "err %d", err);
+
+	if (err) {
+		mgmt_cmd_status(cmd->sk, hdev->id, cmd->opcode,
+				mgmt_status(err));
+	} else {
+		rp.instance = cp->instance;
+		mgmt_cmd_complete(cmd->sk, hdev->id, cmd->opcode,
+				  MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
+	}
+
+	mgmt_pending_free(cmd);
+}
+
+static int add_periodic_adv_data_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_add_periodic_adv_data *cp = cmd->param;
+
+	return hci_set_per_adv_data_sync(hdev, cp->instance);
+}
+
+static int add_periodic_adv_data(struct sock *sk, struct hci_dev *hdev,
+				 void *data, u16 data_len)
+{
+	struct mgmt_cp_add_periodic_adv_data *cp = data;
+	struct mgmt_pending_cmd *cmd;
+	struct adv_info *adv;
+	int err;
+
+	bt_dev_dbg(hdev, "sock %p", sk);
+
+	if (data_len != struct_size(cp, data, cp->data_len) ||
+	    cp->data_len > HCI_MAX_PER_AD_LENGTH)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_ADD_PERIODIC_ADV_DATA,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	if (!hdev_is_powered(hdev)) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_ADD_PERIODIC_ADV_DATA,
+				      MGMT_STATUS_REJECTED);
+		goto unlock;
+	}
+
+	/* The data of an instance with subevents is that of its subevents */
+	adv = hci_find_adv_instance(hdev, cp->instance);
+	if (!adv || !adv->periodic || adv->num_subevents) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_ADD_PERIODIC_ADV_DATA,
+				      MGMT_STATUS_INVALID_PARAMS);
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_new(sk, MGMT_OP_ADD_PERIODIC_ADV_DATA, hdev, data,
+			       data_len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	adv->per_adv_data_len = cp->data_len;
+	memcpy(adv->per_adv_data, cp->data, cp->data_len);
+
+	err = hci_cmd_sync_queue(hdev, add_periodic_adv_data_sync, cmd,
+				 add_periodic_adv_data_complete);
+	if (err < 0)
+		mgmt_pending_free(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+
+	return err;
+}
+
 static void remove_advertising_complete(struct hci_dev *hdev, void *data,
 					int err)
 {
@@ -10191,6 +10276,8 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ load_conn_subrate,       MGMT_LOAD_CONN_SUBRATE_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ add_periodic_adv_params, MGMT_ADD_PERIODIC_ADV_PARAMS_SIZE },
+	{ add_periodic_adv_data,   MGMT_ADD_PERIODIC_ADV_DATA_SIZE,
+						HCI_MGMT_VAR_LEN },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.47.3

