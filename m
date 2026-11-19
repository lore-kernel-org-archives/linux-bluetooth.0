Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108599;
	b=bzS+3nGXpz4T4HOFTwaglONNbFP1mRNRTJv9e/ZOrCG76NwtUPkuxBU0jV5rphPolIRO
	 07GcmPo2TLJ8IWlQY2R48w8oVRCCIgfKgyaZJ1Sb2/ssk2vnk6CHb/11eR03vK9pgBhX/
	 d6KHWEx77zaaHdVBczsNKYq/gwk02v4uxs0wBnAZqoEoCM54lHDGiRZ0yZpmtqZ2m15g9
	 TNOmzhhpHXsR9iPNBQk/YQ+WAmJBZs3zcQgnrWnUz4ADTIpZvqz9JX+6D44pao7dayn//
	 On9Y8JPBcxJ9Yb3RF14Cy1LVnrYC2tugrd5wQqRzITh+IhCvzM2pFEjh5pLn2JhXWWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RYI+BoVF5pAYudFW+FQq2C9Gm83dzHHiguwstCW+PmA=;
	b=JOE5qkCqI1F+5d1fh8uExViBrMQQl+SIY5zsNYNFmnhS2Fn8+9ShWe8sbWdWL4mPFvTD
	 Aoo6b6TAiB/MpALWAoA6Ia8gaITSmjHczYi7wg/CE8OCYPHQy99GiFeF03BKAnQicSbHo
	 1m2E0p4MhbLH0pOuvy3Bi64mkVPYYl3QSJ7YgoAOoJzYOBO7MYkHv7/4YrsFJEuGbzuPs
	 +49IpyNDymaOS4EydvBbcSeQWSZ6oiCg1HfcVzgmuV7d92YmwYo4rOWHo4sZWwk2HGVr0
	 EUdCjj8VBsbAj22QqR9mTqLGgU05MMZ+kv5/39WW+5b0VKNzDmJU7yL9LDiDjhxOeQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tqk0JSON;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2C1606A33D
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F2C1606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tqk0JSON
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ee3e658c72so1433871e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108598; x=1795713398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RYI+BoVF5pAYudFW+FQq2C9Gm83dzHHiguwstCW+PmA=;
        b=Tqk0JSONmOIKa/VJdOGxxXIq6jQW96nxbKtwisXAfyp3zGUlQwUPgorzB3bdq5zUGh
         zbyrvN6EE4hXWQdAwrHFHXGICEddGI65sYbL+AfavavXPKVfx2poPvQjaLg1i0YtdQdo
         deq2NzYJPG6Yw7Ag4rh9B1hqxojtHqyviRiXa/iTmfiQEIvV1VkPFzkxiULfvh+tbIfg
         BN7DAQ+FebNYq5rnwXhPijhU94NiMfhgEScO7y4vVaOY7LkPl/iiT+0U8q+knKFM6E4r
         /ysjWhevykm1FnXXv/ae3ru/Jy7yMKfzfdX/i6HWIGDyPJAPhYDamK5+hyaWP8qoIHGo
         fkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108598; x=1795713398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RYI+BoVF5pAYudFW+FQq2C9Gm83dzHHiguwstCW+PmA=;
        b=A4FpOIBnveiEmrVODwgumzFe6QljFxU8qPpSKDk2VbATPfN4hgCFUyNeVKx4nW8P6V
         hH19hQZBORbkJxCegQhCEmFuBMLxvaxBaoUaBP4Y6isMLytL6sRwS360mUZGocNI2Xsb
         nw9u5HgYGFep69btnA1WzDYs5k3BFfzn2B4EipH2T+5F8fTcEK6b2ePD5j4QYJkwGyIU
         wntCNq5rb61lqTn8Ij1Iv915wHoPou2ul4d6efsCYROx4TRCvlYyT6ImpUmluipVlILr
         LPZC3r2sOkZGcl3mbBgCMN5vbOioiupQl/VCclx8pcjFhMNt8BCzIP+39/MQQ+THrWSV
         54nQ==
X-Gm-Message-State: APuU4Z9v+aFMY5pdq55jl3NhD9l5bPxzi718FqlBV77v+LWZ+0gJzLc+
	xtB5ZA/Gu4hlzmjcQK+ikRZm8bStcL//bbVAfDtNYLBZRi7zB+qKZE0IiDSGhm/Rfjg=
X-Gm-Gg: AYBFou1FgrkTucguRmffdIlKr96qdd05Er5M475sVJtAEJ7JT5Y9DDHF/Pg72cJfu/M
	QOHjT6w2jtUlJ/eu3IQsf4uYr/8TWZDNs+FIUX4LDqspNappL8STOgqUPoB9EXEei0TIzNuYVLa
	twur553aC0XEoBlbg4o1MfQBBqAtO0OPG07jpDbOSrlH8WcFN9tleyxGviiYh4eSAQSDbTvATo/
	gzSrYpBLOswVhu3iguc/9LgoiFpbUTwkJodJ1SXJF2QJwqmugw+gPOLBg3rwbtdC6i5CAHb7FqF
	T171CJ5ZPBNOWBw9sLkRhp8z4w4dOU8M6Xm0WCQByj17/g31+xbZ1Jt0vtltG5iOdLzS4S8K3tK
	XcKMdb3eU9SZJjZJNbWjlN9MGbLrCH7SMaKMqIveaJ740Oqf6VICaLfKFPD/yzHxDKLmn1fN400
	vLPll0vTflGFyPMjs/nXigYyy7Fc0dSg0lnOncWqdYWyhSRkgCkutdneszkU8Dg505zq2k+bvpw
	N6pks8pyqd05o4jCKGPfgT5CWNm8HQiwfrFuTN/6gNxMzPsk4+z6GWHhfE501EMnCoPeJYXTT26
	0+NNwCwK2IZcg8llFsNivINE0/zWqXhsGI4z8/5DPJ1fxWnyJi9l5k/N/hdOQzjvFYO5mBVhGpR
	DZxtW82HowA2+2HdhhhimUf5DfXgdDccZP3lQeKFF//GZ+e+g5YmphSnPl28vOl/rIrgvvwxsJ8
	6rkXgLwp32Y3HuVWiGzVG81S4E
X-Received: by 2002:a05:6122:3d10:b0:5ec:16d2:4537 with SMTP id 71dfb90a1353d-5ee8aebfff6mr303321e0c.7.1795108598005;
        Thu, 19 Nov 2026 09:16:38 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5a8fd3sm131881e0c.8.2026.11.19.09.16.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:16:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 12/16] profiles/ranging: Defer CS Security Enable until the link is encrypted
Date: Thu, 19 Nov 2026 12:16:20 -0500
Message-ID: <20261119171625.1014004-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119171625.1014004-1-luiz.dentz@gmail.com>
References: <20261119171625.1014004-1-luiz.dentz@gmail.com>
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

From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>

LE CS Security Enable is only valid on an encrypted link (Core v6.2
Vol 4 Part E 7.8.133, which fails it with Insufficient Security
otherwise). On the Central, the Config Complete handler checked the ATT
security level once and put the state machine on hold if the link was
not yet encrypted, so a configuration completing before encryption
never got its Security Enable.

Defer the command instead and send it when the HCI Encryption Change
event reports the link as encrypted. Track the encryption in the
connection mapping, so the check no longer depends only on an ATT
instance being attached, and keep the ATT security level as a fallback
for a link that was encrypted before the state machine was attached.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap_hci.c | 93 ++++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 13 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 7f82bbafb2a5..3a6d514cfcf9 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -75,6 +75,8 @@ struct cs_state_machine {
 	bool procedure_active;
 	struct bt_rap_hci_cs_options cs_opt;  /* Per-instance CS options */
 	uint8_t role_enable;  /* Role value for HCI commands (1, 2, or 3) */
+	bool sec_enable_pending;  /* Security Enable deferred until encrypted */
+	unsigned int encrypt_evt_id[3];  /* Encryption Change v1/v2/v3 */
 	/* Negotiated CS role for this config (CS_INITIATOR/CS_REFLECTOR), taken
 	 * from LE CS Config Complete. Unknown until that event arrives, which
 	 * is why it is kept apart from role_enable: the latter is the bitmask
@@ -99,6 +101,7 @@ struct rap_conn_mapping {
 	uint8_t bdaddr[6];
 	uint8_t bdaddr_type;
 	bool is_central;  /* true if local device is BLE Central on this link */
+	bool encrypted;  /* set from the HCI Encryption Change event */
 	struct bt_att *att;
 	struct bt_rap *rap;
 };
@@ -910,7 +913,8 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 	 * the ones for other links: acting on them would overwrite this
 	 * link's negotiated role and advance its state.
 	 */
-	if (!find_mapping_by_handle(sm, evt->handle)) {
+	mapping = find_mapping_by_handle(sm, evt->handle);
+	if (!mapping) {
 		DBG("Not for this link, ignoring");
 		return;
 	}
@@ -1018,26 +1022,68 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 	/* Success - proceed to Security enable complete */
 	cs_set_state(sm, CS_STATE_WAIT_SEC_CMPLT);
 
-	/* CS Security Enable may only be issued by the BLE Central */
-	mapping = find_mapping_by_handle(sm, evt->handle);
-	if (mapping && mapping->is_central) {
-		if (bt_att_get_security(mapping->att, NULL) <
-						BT_ATT_SECURITY_MEDIUM) {
-			error("CS Security Enable skipped: not encrypted");
-			cs_set_state(sm, CS_STATE_HOLD);
-			return;
-		}
-
+	/* CS Security Enable may only be issued by the BLE Central, and only on
+	 * an encrypted link. The LE role comes from the connection mapping
+	 * (set from the LE connection event), not from the CS role in rap_ev.
+	 * If the link is not encrypted yet, defer: the Encryption Change event
+	 * retries it (rap_encrypt_change_evt).
+	 */
+	if (!mapping->is_central) {
+		/* Peripheral link: the Central's Link Layer starts CS Security
+		 * Start (Core v6.2 Vol 6 Part B 5.1.23). The local controller
+		 * reports completion with LE CS Security Enable Complete when
+		 * it responds to the peer's request (Vol 4 Part E 7.7.65.41),
+		 * and that event continues the procedure. Do not stop here.
+		 */
+		DBG("Peripheral link: waiting for peer CS Security Start");
+		sm->sec_enable_pending = false;
+	} else if (mapping->encrypted ||
+			(mapping->att && bt_att_get_security(mapping->att,
+					NULL) >= BT_ATT_SECURITY_MEDIUM)) {
 		DBG("Central,encrypted: Sending CS Security Enable command");
 		rap_send_hci_cs_security_enable_command(sm, evt->handle);
 	} else {
-		DBG("Peripheral: Waiting for security enable event...");
+		DBG("Central, not yet encrypted: deferring CS Security Enable");
+		sm->sec_enable_pending = true;
 	}
 
 	/* Send callback to RAP Profile */
 	bt_rap_hci_cs_config_complete_callback(size, &rap_ev, sm->rap);
 }
 
+static void rap_encrypt_change_evt(const void *data, uint8_t size,
+					void *user_data)
+{
+	struct cs_state_machine *sm = user_data;
+	const struct bt_hci_evt_encrypt_change *evt = data;
+	struct rap_conn_mapping *mapping;
+	uint16_t handle;
+
+	if (!sm || size < sizeof(*evt) || evt->status != 0)
+		return;
+
+	handle = le16_to_cpu(evt->handle);
+	mapping = find_mapping_by_handle(sm, handle);
+	if (!mapping)
+		return;
+
+	mapping->encrypted = (evt->encr_mode != 0x00);
+
+	if (!sm->sec_enable_pending || !mapping->is_central ||
+						!mapping->encrypted)
+		return;
+
+	DBG("Encrypted: sending deferred CS Security Enable");
+	sm->sec_enable_pending = false;
+	rap_send_hci_cs_security_enable_command(sm, handle);
+}
+
+static const uint8_t encrypt_evts[] = {
+	BT_HCI_EVT_ENCRYPT_CHANGE,
+	BT_HCI_EVT_ENCRYPT_CHANGE_V2,
+	BT_HCI_EVT_ENCRYPT_CHANGE_V3,
+};
+
 static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 					 void *user_data)
 {
@@ -1807,6 +1853,19 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 		queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
 	}
 
+	/* Encryption Change is a plain HCI event; it lets a deferred CS
+	 * Security Enable be sent once the link is encrypted. The controller
+	 * reports it with the v2 or v3 event instead of the legacy one when
+	 * those are enabled; all three start with status, handle and mode.
+	 */
+	for (i = 0; i < ARRAY_SIZE(encrypt_evts); i++) {
+		sm->encrypt_evt_id[i] = bt_hci_register(hci, encrypt_evts[i],
+					rap_encrypt_change_evt, sm, NULL);
+		if (!sm->encrypt_evt_id[i])
+			error("Failed to register Encryption Change 0x%02x "
+				"handler", encrypt_evts[i]);
+	}
+
 	DBG("HCI state machine attached (role=%u, ant=0x%02x, power=%d)",
 		sm->role_enable, sm->cs_opt.cs_sync_ant_sel,
 		sm->cs_opt.max_tx_power);
@@ -1962,6 +2021,7 @@ void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
 	remove_conn_mapping(sm, handle);
 	sm->procedure_active = false;
 	sm->cs_role_known = false;
+	sm->sec_enable_pending = false;
 	sm->current_state = CS_STATE_UNSPECIFIED;
 }
 
@@ -2001,6 +2061,7 @@ void bt_rap_set_proc_active_cb(void *hci_sm, void (*func)(bool, void *),
 void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm)
 {
 	struct cs_state_machine *sm = hci_sm;
+	size_t i;
 
 	if (!rap)
 		return;
@@ -2010,9 +2071,15 @@ void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm)
 	/* Cleanup the per-instance state machine */
 	if (sm) {
 		/* Unregister HCI events */
-		if (sm->hci)
+		if (sm->hci) {
 			queue_foreach(sm->event_ids, unregister_event_id,
 								sm->hci);
+			for (i = 0; i < ARRAY_SIZE(sm->encrypt_evt_id); i++) {
+				if (sm->encrypt_evt_id[i])
+					bt_hci_unregister(sm->hci,
+							sm->encrypt_evt_id[i]);
+			}
+		}
 
 		if (sm->measurement_timeout_id) {
 			timeout_remove(sm->measurement_timeout_id);
-- 
2.56.0

