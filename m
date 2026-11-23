Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456298;
	b=m7AGCyyUqkm8ChjQk1sLFgECPXDghyXcC1/kcggBJTQdcHk3+MkZUyAQltkBoiSTp/jb
	 PvFTL3zztvE+wwOfxl+fvzsovGFQSTof8kioW5VkofSqAysbzrJfPlEzjlBLTuYyhpHr0
	 JAI3dMiFO6CzdpMD6/9fKw8lIxGjZPGrQf1pSGjX4OWxqiAuQFmbHhp8zaPqkpntw24vy
	 vvjmsVkImkpG7oSDzqesBWnipPQfZMna3CVmt0W5KJqLLzhMiS/sb9wafRkCOJg2EZLyO
	 2w8f/HKW0CbV30c8kuysCb8Sq8AW+qnfHs4cdjh2Zt8mBkc5c97UB2/jnehT9S3lrtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RYI+BoVF5pAYudFW+FQq2C9Gm83dzHHiguwstCW+PmA=;
	b=TvfvdcJg2tut3nJlXCfmxh792F/gH5AW1aTyHJXzXu9vj29U1JKaqJWfHSYWqMA5YTI5
	 Ov0tlXbxF9MAWx0C1gDmqpw5P41UPtbclzC+vzD2ohKTqxpmxDj8S6j+NkWl/7N4kXCZB
	 L72BjJf7Zj/Y+TUMaS4VAETHv8r96RHWDxF7T/i4jpw450Dc+M8vwlQdmIbr9zSu52dVe
	 RN7+7m//0zEUqot9iZj78Evn6FY45bS1iry4JgXfg6UJPsmHBEY7uzTP9Y8J/nZTDTujk
	 +cxsYE3QnffjnmT0EQh4PSrjZV8zcfi8st1Bvq5F+7mx8JBjpuqStoPzP2mnjIHGq0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NQFi9niP;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96C606A33A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C96C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NQFi9niP
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-99071945aa7so2054249241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456296; x=1796061096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RYI+BoVF5pAYudFW+FQq2C9Gm83dzHHiguwstCW+PmA=;
        b=NQFi9niPG93zZ5E4XPqIZmrMX7rIUc9R+m1SEfsYWtwxC9VRnTAkhaES1+ZirgucMW
         6qgJBAwz70V8qcM24Rj9RJMI0MGPyo7odsgeCYH0Cf0kEuxOzOSITsv6xXOuRcNJUxiT
         OC1Sf5gbdMTQFJlOeAkXS/nLOsKyA8ikue8jnsWNtZOias2f5vx5KuVQQCw+34fwvpPV
         NcdQ+82xKBr8QGeq8+cmTfDMSi9RoZqEWDG1NNTFpE71Xh+2EJflsQye434dbHstM4Ai
         UUmBgj0BcWL4gXCunXuSOzTUYD052GnIrHp6FrMmuSF+eOhv9IlN6+VzurR+GaQdRnRz
         qy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456296; x=1796061096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RYI+BoVF5pAYudFW+FQq2C9Gm83dzHHiguwstCW+PmA=;
        b=Fdox6wmfo+B8uzhPJ3kg+bq5Lg/FHzMYyRIVIiSwb8vYElGk1Ez2tamh+BcuoL4CEu
         sEgRblp9TJ/CVgnDTFq3m/5mPpI4V89ecNhroDP4bZToZBpbIYJeeS1iLqtYRqYSqC1i
         ZrgTlyXuVWTj+qFW49xegV9JU2oCnreT5iXSr+9ZToS9p8PKfyatQZpM98UuT40B8L0J
         94eZdbhhy7672LElrzleuIJvSwmHE67g0jGWSGSfivXDVmqMU3qvC1TB889I3zCL61DC
         eMoS/Szr2rQNCJ7t3FhWHJOoceoau+N2qseoy60vJqRbmDQWo1sDtcCEmtcXmK9Pxr7S
         EyhQ==
X-Gm-Message-State: APuU4Z+QTR9+xFgmZ24Yth5T0Yv9eFDjgJiNeVWubVQvHRaWNsAT1pwF
	9iL90zQMhkCg5ShG9AYZwnpCNfAMXEKbLhJxVwg0NDtDgANlnCZYy7XgomZqNw==
X-Gm-Gg: AZFdTZeRW+mcNzS03ZH0wxOkVHq2eTUq0ZSz+oUFnvnHUw3EDQ/LRdvpqa/sVcObcza
	3V/vYX8S+pfKXdgn1aPrg8K8lJZGSKPrJlJ4Z8FsuM8m8l8ppbY1IAxltBCem/0qMy32K+jCjv5
	MbUpSU2SJD6wRckaWS5b/MqVikpc0FBtfbzuuShmbjsq3Np3Tmgh1y3sOYCihCAna57VYMlyFsH
	qje3uSzHGNH2qJxW3ai9lMfmqQKaEdgleCZJBeATkGQ3f1RDxNbARJTfFa6sVtlUHylzOpTIPH8
	VQxBPbqx2MT7YQ2qymBu7n92Ff4kM1nEQ/c9ZZ6kvfYwaiYiMJlx8nqpOA5zME0vzEtBXsA+PkT
	gvQHma7JTB6EuQPRJ7yGcmVTWSPY6Qd4oqkmT3mHzxpG3jU/KbkLJAsljsPnMu7XhM7OhB4yOHV
	2K+yCcFtCOM6bQ96Vb9Cm8eKHSQPiPAK7T90pW6pANVHHgM+er7+U1IdTOwM3BNtodIzSjv7ywf
	Sl+JKyc2CQFqQcaDnRdFRYjb8SJQ1wMxz7bZs3r3oF6nl9PIXxEtJIIkSbheFap4dD3nmOmcZy2
	E45MsZzvisCiBtVkg3tbwsvfkgEBkAwd4kJGFPO3OvDdQ5m2PQbU0Ji872FWAHfoXMjkOyNgTRg
	hyWsmRaeCWOV6tCMPAsnfwUBEysAccutaeUm4urazs0JXB9ywllI3oCc4XNfttn/9qof2kZZUZM
	B4t9JK
X-Received: by 2002:a05:6102:290b:b0:7cc:828b:421b with SMTP id ada2fe7eead31-7d7393aff24mr6725597137.6.1795456296405;
        Mon, 23 Nov 2026 09:51:36 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm12795393137.5.2026.11.23.09.51.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:51:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 12/18] profiles/ranging: Defer CS Security Enable until the link is encrypted
Date: Mon, 23 Nov 2026 12:51:15 -0500
Message-ID: <20261123175125.3642617-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123175125.3642617-1-luiz.dentz@gmail.com>
References: <20261123175125.3642617-1-luiz.dentz@gmail.com>
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

