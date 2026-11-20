Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193723;
	b=yor7hdlPdQoXLtRILn8jc6jmU1KJ2qNFeQVaSCwTQ5UNMxBZ0JsuhcmeyGlii+Dz00Xn
	 geUsOgGUwOLcxCEYe4nL4RDaMk6aOH2fy9Ohmr5S11ghskWCwfDX8AuzmFiOfa5+UMZhy
	 gVq6Iw1usgu6Kp5KGNnQ5TLJim4amvIwvcYV1soihsEGBkrILGsmmJOEg4EsiY0QLrHmt
	 yft+m9+rFAw6/Vtn18PF0HzmPAwA3ZYmnzrAJL1C0Wt6Nw2C60pGx2b358EbpdO8KnMMe
	 Wo0tYxbpGsqgOUnUSn+l+dBraNE/tFhEfjdygS01ErKGU5USWGmHY+1XxlW42UmhgWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RYI+BoVF5pAYudFW+FQq2C9Gm83dzHHiguwstCW+PmA=;
	b=Hgl/NY1AyFAS3uHrHryrkWGLKhui0rowN9EKkMK1OsJvgNHnTxUdNet8ntyriKl9F5Bu
	 KDliuxDhuuro3mh2ih1b5EB0SAqREHJ91LFc4/dpDdnS7uNlzusjz4KBJjWa6IcZIxVyN
	 h7h0FcjA/84TJHlde8ieNhBsp7J+qVpm/Iwky5Jt2lmaxj7gfpTqK5+zpV2YEaCE1EsnB
	 9RzKpR3FWaiRfKT4u1ZA8s/BfGDw/UD22Y4o2SndXeEAc2Mtp9ZK03ujMTqIwG7XP7jge
	 YvXRT7a5mEiYzLjHNgmjf99vIYSmCM/IVI+n/s6k7b4DgQVLvWEUZde2tfZBrXUtubA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dBbpfEtl;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6997860A260A
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 16:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6997860A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dBbpfEtl
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7d2ca055399so347314137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 08:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193722; x=1795798522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RYI+BoVF5pAYudFW+FQq2C9Gm83dzHHiguwstCW+PmA=;
        b=dBbpfEtlzon3zw8AhT3C9I/m+FOlEmmQAnQRJPFNxhCMqzRnk6a8xRTIQm/gybmWau
         ZNjruqP1bd2BMkhkjdB3G9waKgJivMxJqXs8AWjpBqefQsKkNC2tpODo/Hy4dc6llg4f
         eBPnz8aDV8L6LK7AnpkGxe3yMm+GxtG42fLt5OfyncR/gsdpdIQa+HAES4TuP3xkkFAs
         uYmPBz9SiUqbEUKwt6U6I+5miNXWrg8DepQ2fvdfAHWTg4mSwCsDALAWxk8dhoyjGRJY
         vNtqkMQ2BJEUymtuAC4GdhbTHmb+DJzAmEDc/nhsTTxgo5eyLZzTj0X8qK2eqhPEMcV9
         PY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193722; x=1795798522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RYI+BoVF5pAYudFW+FQq2C9Gm83dzHHiguwstCW+PmA=;
        b=l5tjHrIYFtzCJy3Gvrs+Sh0uqjfdwRW6V8rak8c+/Q+wZt0LYDZ3bcoh5HOAObm4Tn
         YDu5pUnwF+ZeDZ0cDSe2xd61TnrW6XVTSjzf+B8biRORYWVw5hE4WCmKfoD8PIOjai6G
         RqleMwKw0761oYiYb5uc8V1P5nTshNEIv6BkU5JMOOcuFrkd71Jh8y6XmzCocBQiuH+j
         AVaYnliN4B+2svjGFOTw8sXNwrfxwrZmjaNbQutlBFCdvb81wkQi/01NIkoH4rcjvag+
         FDPCLRonAG8eTyJh4RchGs2tbr6x/M7Kv9dhWJUVeE5z3EM1a9NRR9Gx1UPsPw8plWPa
         Usxg==
X-Gm-Message-State: APuU4Z9nZr3PiA4FTVeNkR2Cp5GNYW0g6558x0h/7wvu0LdEPguHPxoj
	V3rlHropXC3HaIDaYEj0QWGni7L447oHtdVBAcHG9lI91B+YuAxQgexnoU7amMtu
X-Gm-Gg: AZFdTZcim88nuhejkFS9n1IcN24lIj9Fspkvky4UJLaKG4izP1S9as0yZ9XpunK//Sr
	glltQsmFqukEttqFgbYHtynBOkt1PmjWB0UW/5/Btfi832J7iPX76zFZrEczSKw50/MvCvPLyLJ
	VYVuGvqu94nTVX3vHne/ZG5+7si8VjZ9qxG6wViH4VjSyAVV0RPw4hiZ+3NMPtUtWvIkTumKi2M
	S1MWVW235FlgRMwpWI1+lFg5YLqNsztF/Rby7hIEOVMOt0kKNa5b/+MuJItqhqEn1iEWRrEK2gj
	UiHcEBOLmFEc+1AebTziPmAjFfKd09P2nlAXJysCPaAu77poewLJVXs/tXDAePLt+3Tm1yfAu2V
	WhL7EXq3XgmlTZYCYcTZpdUCdg1awGXPC0w8o+1EMlOnzHEJbNbGgZVpAgpJYmAoo5DH7MKOvid
	fqG8mDaF1wutE1bWfQpbGAIycDl36FTFkN3TazB/9EApUJrmPhyaD0VI0pmBMnTKFcv3axwsXT0
	iyF7gI2BMaTSafGjCyMs9cZi95xT0mth+pURcpu3s4eF+ebNpvLFNlLiQklyn1NyXgw35OwJI24
	2gpehQPOQeqm28mykOjTA7LV1aK27w4ewumlfmF0kl1Y53+1Djn6/u54i3gWqhvUt/xaDgCHr7h
	RLCAYweVaP2Ho7eGufTTcUXi1Ub0o0uUwLkZEXrcTn+ye1WqH4gl1QaJgTbJAuoEzIIv0v/JrTK
	nhjaE=
X-Received: by 2002:a05:6102:688c:b0:7ce:a69d:b020 with SMTP id ada2fe7eead31-7d72b36164amr1408467137.5.1795193722240;
        Fri, 20 Nov 2026 08:55:22 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm3486193241.4.2026.11.20.08.55.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:55:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 12/18] profiles/ranging: Defer CS Security Enable until the link is encrypted
Date: Fri, 20 Nov 2026 11:55:02 -0500
Message-ID: <20261120165510.1858959-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120165510.1858959-1-luiz.dentz@gmail.com>
References: <20261120165510.1858959-1-luiz.dentz@gmail.com>
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

