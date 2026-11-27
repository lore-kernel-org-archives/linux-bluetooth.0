Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769660;
	b=KP+Y3eJGH5ec2gSO1ira9lcqrcnDHzBWBvX6yBtARphYOte6mgckwhGSk3tmiaBE8Csx
	 1TcqzKmV1k8kL37a8ZAeojYB33Szyiq76uklO4JJWPEwx8cn6fXH0xZfsrqA3bx2cBPeC
	 uPUS1CrFzfiUO1bQEkPZMF1+PWkL/kufU7t6GXjM9+YUbiiawH4GUKQmRwo/59CF0YRe/
	 qa1agYKsrViNtnU8v7Fc/xzDNRnuHygeuT2g80fvbGf7F3IuINhBpiHp/iEgIay9N8ZLp
	 BH40XAYED4vNOk52Cq+Vk1Eck5oLvZypuw0oLnbduZu1ri1gpbEJlSwckElmnoOrqZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mOaoy0ZL3QSWc2gg4DhCW+8RE1X8eW7xdyZgwOVJnL4=;
	b=KY9ij9w1PEqTcBp23w+9wA+d6mJe2Q6iUVytLbcc/ud9aFb/lN781oK6dxjJutDAYh0k
	 7CU9AC91mHVZfHQ237pnYBi75cxv167qDS25C9AruJ8U7DyU4wS9xLCz50L92TtZuB3bQ
	 8LcqOgC8JqpyWsCtjDA75k41E3cDjuikQNWS8Lj7dGoBy0Nn8jj2nfPGirv4u0ZLuSLLw
	 XzVsOUUlDSz0NEaITvOLbytgQoDRM+Q1AfM5LXTMdcVUa/IZzGxbdKHPAMNvx7eJzzIbS
	 MgObv7m2glUqF8vC21bEdWE1uGYqqY2erePBlH7UEOPOVdRCtUoDiOZ9DgmsDC5p5wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="r/N62UWQ";
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8820606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8820606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r/N62UWQ
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c5187b42a2dso62331366b.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 00:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769658; x=1796374458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mOaoy0ZL3QSWc2gg4DhCW+8RE1X8eW7xdyZgwOVJnL4=;
        b=r/N62UWQVeFqI1xd92GE4IBuypInQsrS+xVzoYrWup9H8HtLbYHRBPuF+6BmuY0KAp
         1vM02uQuWjST4zLSCUhh3Hpe2tu89nKuxaoCnOou1gqPj+FKCY+Mctuq/hkJuYLZXoLI
         xGKwB/unNof4ZowgWOxg2ukxqqamwSuNLfbIzCocQQ/EuLP3RhFIhcQdGAuOfs2yUEe2
         KhWFgXtfpAU8saAH4DPsTGvhloz+8/SiJ+7XlFdoV10mRg1Y8ozSKtH7gFFLbmvOuuGU
         Y+M8rpGr+z+rBXF3FeRQw0CBU/rBzyZ0osEA/HZd1axE3uRKQ/aaXtGgiW5whjPKPGMd
         P70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769658; x=1796374458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mOaoy0ZL3QSWc2gg4DhCW+8RE1X8eW7xdyZgwOVJnL4=;
        b=182zsr8lm4vNdG9MascvZ8VT5UoNGiAWFP+BaGwMQn6YNs+BSHRpVVI2Ol8Q4DAwG1
         yOWTY6p+GktOWKlL8JIxrZzlL3p/hvRWHy0paKDYdNemj798taxgUOuSK/Un+YdvrV9u
         rXGy83Ro7vcsaLIyfox3PD5zpw0oflQeQptcJSDFQ155yyAvBqZHpv+9VnR6eOM3Bnlb
         0YwAm6E3rFlpwqpbEQ5Oa0az/UhG6rDxE1pcs6dLkUMuHSySt1ce+0VmGhL4K2rTCIlN
         vHeefVNTViVU4hGMGeZd4mYZ2FRKzfG8UuaJaN2NlxtUCeYX7H18BJaCO9ptsBceHS2x
         8SAQ==
X-Gm-Message-State: APuU4Z8vsvtj3QC+dsx1aAgMZEtXU23eKjpz+Z7zTgg7hzog9Q+VpRtG
	JYrV7kW943BYdJuVpwZJVBJgG5Q+qSkwe9MSosixQ7pNyArTqTuhLuT/0aiFp63k
X-Gm-Gg: AZFdTZfMTAe6vV5UN/ZB463T8IihCs+squAFqT4JLJDRSvaducMBgJ5DEKVUwld70mW
	oYswDaIAxCs5wxh9G1T+Dy89LunP1vgJdih2YMop+I4H34ROUhpy4yvjsdknq1Ve4Z57dHF0av5
	toHrPZ98Z1hNKoWF08CSS36+DY2b3FgkQATl0voBrqIbqmvFjWPFfA91/FqX4PBgZ0ua5PEg17s
	jIqaeLgtIdRP1P8SoprIl4MiAd/RSP64bSbNh35nyDZdMGeuFURiesKUqMCj4FUWM/P21fEOadP
	XRfdMJKVw8+YT4dZHUY0XGfKyya2KXPkT73rj7GP/icWQBrMPk2+FRL2Zj9Ri0r6KKrQr6xHOGx
	Dwca0FTDRKOo8Ur2JiFWtCW71uWpT+Q1tOtPQvHiu1X1KCWfLvuDAdDYmsqeWqdwLPUilB09XN2
	mc9gGcisnRAQuPbi0JmMbxADQFisi877M5+oM6cDHyQPyDmUGor/vdsNs9HelLdMLMCYrF+Pa+W
	8lY0KSiiTyU2mpDa6NtQJTHdawyk9I9f9LNIQWK8P7wgnOhLFLFvJ9tbjpiwgx5/WiG4XCK3PW/
	eHUGVcsgdAOtHG34J3gJOqgy7etXklkvjrc=
X-Received: by 2002:a17:906:68d5:b0:c51:4fd:1aef with SMTP id a640c23a62f3a-c513a50ab80mr1922563966b.2.1795769658138;
        Fri, 27 Nov 2026 00:54:18 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea28f4sm870688166b.33.2026.11.27.00.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:54:17 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Roland Schober <rolandschober1968@gmail.com>
Subject: [RFC PATCH 3/5] Bluetooth: MGMT: Add Add Periodic Advertising Parameters command
Date: Fri, 27 Nov 2026 09:53:58 +0100
Message-ID: <20261127085401.263615-4-rolandschober1968@gmail.com>
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

Periodic advertising can only be started by an ISO broadcast socket so
far. Add a MGMT command which makes an advertising instance periodic:

  Add Extended Advertising Parameters    creates the instance
  Add Periodic Advertising Parameters    makes it periodic (new)
  Add Extended Advertising Data          enables it

The command takes the periodic advertising interval and the parameters
of Periodic Advertising with Responses (PAwR): number of subevents,
subevent interval, response slot delay and spacing, number of response
slots. With a number of subevents of 0 the instance is plain periodic
advertising; otherwise the controller has to support the PAwR
advertiser feature and LE Set Periodic Advertising Parameters [v2] is
used. The values are those of the HCI command, in its units.

The instance has to use the extended advertising PDUs and must not be
connectable. Its extended advertising parameters are set again when the
command runs, since they may have been sent before the instance became
periodic.

Assisted-by: Claude:claude-fable-5-2
Signed-off-by: Roland Schober <rolandschober1968@gmail.com>
---
 include/net/bluetooth/hci_core.h |   8 ++
 include/net/bluetooth/hci_sync.h |   1 +
 include/net/bluetooth/mgmt.h     |  26 ++++++
 net/bluetooth/hci_sync.c         |  60 ++++++++++++++
 net/bluetooth/mgmt.c             | 133 +++++++++++++++++++++++++++++++
 5 files changed, 228 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 250245186702..117408645b9b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -260,6 +260,14 @@ struct adv_info {
 	bool	scan_rsp_changed;
 	__u16	per_adv_data_len;
 	__u8	per_adv_data[HCI_MAX_PER_AD_LENGTH];
+	/* Periodic Advertising with Responses, if num_subevents is not 0 */
+	__u16	per_adv_min_interval;
+	__u16	per_adv_max_interval;
+	__u8	num_subevents;
+	__u8	subevent_interval;
+	__u8	response_slot_delay;
+	__u8	response_slot_spacing;
+	__u8	num_response_slots;
 	__s8	tx_power;
 	__u32   min_interval;
 	__u32   max_interval;
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index eab827dfa829..03d7e267af7c 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -118,6 +118,7 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 sid,
 			   u16 max_interval, u16 sync_interval);
 
 int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance);
+int hci_setup_per_adv_instance_sync(struct hci_dev *hdev, u8 instance);
 
 int hci_remove_advertising_sync(struct hci_dev *hdev, struct sock *sk,
 				u8 instance, bool force);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 17bdd6345d19..57b9d8d8b57d 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -912,6 +912,32 @@ struct mgmt_cp_load_conn_subrate {
 } __packed;
 #define MGMT_LOAD_CONN_SUBRATE_SIZE	2
 
+/* Turn an instance added with Add Extended Advertising Parameters into
+ * periodic advertising; with num_subevents not 0, into Periodic Advertising
+ * with Responses.  The values are those of the HCI command, in its units:
+ *
+ *   min_interval, max_interval	1.25 ms (0x0006 to 0xffff)
+ *   subevent_interval		1.25 ms
+ *   response_slot_delay	1.25 ms
+ *   response_slot_spacing	0.125 ms
+ *   num_subevents, num_response_slots	counts
+ */
+#define MGMT_OP_ADD_PERIODIC_ADV_PARAMS	0x005D
+struct mgmt_cp_add_periodic_adv_params {
+	__u8	instance;
+	__le16	min_interval;
+	__le16	max_interval;
+	__u8	num_subevents;
+	__u8	subevent_interval;
+	__u8	response_slot_delay;
+	__u8	response_slot_spacing;
+	__u8	num_response_slots;
+} __packed;
+#define MGMT_ADD_PERIODIC_ADV_PARAMS_SIZE	10
+struct mgmt_rp_add_periodic_adv_params {
+	__u8	instance;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a1c723aad55e..3d8327180c6e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1968,6 +1968,66 @@ static int hci_enable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
 	return 0;
 }
 
+/* Program periodic advertising on an instance and enable it. The extended
+ * advertising parameters are set again first: they may have been chosen
+ * before the instance became periodic, and a periodic instance can neither be
+ * connectable nor use a non-resolvable private address. An instance with
+ * subevents is Periodic Advertising with Responses and takes the [v2]
+ * parameters. The train starts once extended advertising is enabled as well.
+ */
+int hci_setup_per_adv_instance_sync(struct hci_dev *hdev, u8 instance)
+{
+	struct hci_cp_le_set_per_adv_params_v2 cp;
+	struct adv_info *adv;
+	u16 min_interval, max_interval;
+	int err;
+
+	err = hci_disable_per_advertising_sync(hdev, instance);
+	if (err)
+		return err;
+
+	err = hci_setup_ext_adv_instance_sync(hdev, instance);
+	if (err)
+		return err;
+
+	memset(&cp, 0, sizeof(cp));
+
+	hci_dev_lock(hdev);
+
+	adv = hci_find_adv_instance(hdev, instance);
+	if (!adv || !adv->periodic) {
+		hci_dev_unlock(hdev);
+		return -EINVAL;
+	}
+
+	min_interval = adv->per_adv_min_interval;
+	max_interval = adv->per_adv_max_interval;
+
+	cp.handle = adv->handle;
+	cp.min_interval = cpu_to_le16(min_interval);
+	cp.max_interval = cpu_to_le16(max_interval);
+	cp.periodic_properties = 0x0000;
+	cp.num_subevents = adv->num_subevents;
+	cp.subevent_interval = adv->subevent_interval;
+	cp.response_slot_delay = adv->response_slot_delay;
+	cp.response_slot_spacing = adv->response_slot_spacing;
+	cp.num_response_slots = adv->num_response_slots;
+
+	hci_dev_unlock(hdev);
+
+	if (cp.num_subevents)
+		err = __hci_cmd_sync_status(hdev,
+					    HCI_OP_LE_SET_PER_ADV_PARAMS_V2,
+					    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	else
+		err = hci_set_per_adv_params_sync(hdev, instance, min_interval,
+						  max_interval);
+	if (err)
+		return err;
+
+	return hci_enable_per_advertising_sync(hdev, instance);
+}
+
 /* Checks if periodic advertising data contains a Basic Announcement and if it
  * does generates a Broadcast ID and add Broadcast Announcement.
  */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d21538634bc3..2870278d51b0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -130,6 +130,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_MESH_SEND,
 	MGMT_OP_MESH_SEND_CANCEL,
 	MGMT_OP_HCI_CMD_SYNC,
+	MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
 };
 
 static const u16 mgmt_events[] = {
@@ -9797,6 +9798,137 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static void add_periodic_adv_params_complete(struct hci_dev *hdev, void *data,
+					     int err)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_add_periodic_adv_params *cp = cmd->param;
+	struct mgmt_rp_add_periodic_adv_params rp;
+	struct adv_info *adv;
+
+	bt_dev_dbg(hdev, "err %d", err);
+
+	if (err) {
+		/* The instance stays as it was added, without periodic
+		 * advertising.
+		 */
+		hci_dev_lock(hdev);
+		adv = hci_find_adv_instance(hdev, cp->instance);
+		if (adv) {
+			adv->periodic = false;
+			adv->num_subevents = 0;
+		}
+		hci_dev_unlock(hdev);
+
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
+static int add_periodic_adv_params_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_add_periodic_adv_params *cp = cmd->param;
+
+	return hci_setup_per_adv_instance_sync(hdev, cp->instance);
+}
+
+static int add_periodic_adv_params(struct sock *sk, struct hci_dev *hdev,
+				   void *data, u16 data_len)
+{
+	struct mgmt_cp_add_periodic_adv_params *cp = data;
+	struct mgmt_pending_cmd *cmd;
+	struct adv_info *adv;
+	u16 min_interval, max_interval;
+	u8 status;
+	int err;
+
+	bt_dev_dbg(hdev, "sock %p", sk);
+
+	status = mgmt_le_support(hdev);
+	if (status)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_ADD_PERIODIC_ADV_PARAMS, status);
+
+	if (!ext_adv_capable(hdev) || !per_adv_capable(hdev) ||
+	    (cp->num_subevents && !pawr_adv_capable(hdev)))
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
+	min_interval = __le16_to_cpu(cp->min_interval);
+	max_interval = __le16_to_cpu(cp->max_interval);
+
+	if (min_interval < 0x0006 || min_interval > max_interval ||
+	    cp->num_subevents > 0x80)
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	if (!hdev_is_powered(hdev)) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+				      MGMT_STATUS_REJECTED);
+		goto unlock;
+	}
+
+	/* Periodic advertising needs an advertising set which uses the
+	 * extended PDUs and is not connectable.
+	 */
+	adv = hci_find_adv_instance(hdev, cp->instance);
+	if (!adv || !(adv->flags & MGMT_ADV_FLAG_SEC_MASK) ||
+	    (adv->flags & MGMT_ADV_FLAG_CONNECTABLE)) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+				      MGMT_STATUS_INVALID_PARAMS);
+		goto unlock;
+	}
+
+	if (adv_overridden_by_global(hdev, adv)) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_ADD_PERIODIC_ADV_PARAMS,
+				      MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_new(sk, MGMT_OP_ADD_PERIODIC_ADV_PARAMS, hdev, data,
+			       data_len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	adv->periodic = true;
+	adv->per_adv_min_interval = min_interval;
+	adv->per_adv_max_interval = max_interval;
+	adv->num_subevents = cp->num_subevents;
+	adv->subevent_interval = cp->subevent_interval;
+	adv->response_slot_delay = cp->response_slot_delay;
+	adv->response_slot_spacing = cp->response_slot_spacing;
+	adv->num_response_slots = cp->num_response_slots;
+
+	err = hci_cmd_sync_queue(hdev, add_periodic_adv_params_sync, cmd,
+				 add_periodic_adv_params_complete);
+	if (err < 0) {
+		adv->periodic = false;
+		adv->num_subevents = 0;
+		mgmt_pending_free(cmd);
+	}
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
@@ -10058,6 +10190,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ mgmt_hci_cmd_sync,       MGMT_HCI_CMD_SYNC_SIZE, HCI_MGMT_VAR_LEN },
 	{ load_conn_subrate,       MGMT_LOAD_CONN_SUBRATE_SIZE,
 						HCI_MGMT_VAR_LEN },
+	{ add_periodic_adv_params, MGMT_ADD_PERIODIC_ADV_PARAMS_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.47.3

