Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031939;
	b=2YhQyd+uCPLdFsBqK9izca1ptJDVq7MlPVkWr+XnsqOrP5i070FJUbwKzMuhe4PXhUmL
	 za8sFbG6ilekGDSFLI812yT4GQS34u4e5mc3Zhy4nBdRXGjmwH3ucB03h/b5tbxNn0cCs
	 q0UN28IWSSsggJuioyZPw01Oij+l+poDL25GfGlcBEN33Kn7ZomzOu5qqh8urJzXbRIiK
	 scnkp1jIE8IhZRQJOz+QV2OhXsFVym3Ocyt8s/2J0qHLOAZdwhSEtxEGSrzu3CbXBDWdn
	 cYvDJymKL1cHNOddXfx7YcYEJLjtNLHcfPdlUGpEW9RD28aI4WLjvsdnqrUQUPsPRZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=022eQo8h9kU9nIHXfKYYOnp23W79u+iHIo1dSmOaVqQ=;
	b=zcoWqQCuk+Gf7NoQ74qUx80R8/Se9OiVirU/PhEt7s64SSkAiiK5TcdJ7N3OabM7L77P
	 cyVGqgy9+3Lv7pFfKFZCfzQPAOaRXiEgB1Z5K9H/XEoDqio2G7zyQWg3411GjGnStxUyl
	 0195diQjYkJzA7UeiqjvlttFpVz9O4Lvb2pft9gA6f3h/rYqpb0AzXD8fm2YXmKgtzGQo
	 dK68fC2L8UwKV+1SQS/c0ucNPog3/TIv3opph8YUtY7bUdbCL6sLMyeTCKYoHQecIbq5X
	 aIRBok86bN9w6KVuR8AidZ/Pb55F7qFGnsRunBDbTImbspiCd1HnAgW53D4+ydo7VaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YbbpmiGj;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD2B606A336
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FD2B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YbbpmiGj
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-99e145569c6so381108241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031938; x=1795636738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=022eQo8h9kU9nIHXfKYYOnp23W79u+iHIo1dSmOaVqQ=;
        b=YbbpmiGjo1i8kBJ/AWMhp3hiFEOkeBEIpVcOpo/w7nO5kteMkDmIQwY/7/y4F4Srf1
         SyUNaRZVzLgWz2aQBYBwVBOstKxkIV4TkItlrm7VxoDl2mz33oX/HWzkjpoDQh8a2TkR
         Ea+bMVrsjIQhEhS7F4GPH+/n9Jn30B7xtXEQxjSiF7MHuTUzZroc764n38wzB+bacdd/
         NsTH6Yf29HcD6WbaR5Y++R49P/fG4e0Vk/bb+mN8X+sOuYdPy3qPtP12Qj5yz0CX59/8
         kqc7TVeM3/g1WUcXYFzveyz4VjuD2TMBuunsdW1D+u4ljrBKq8HGB44Wp4AF7NK5miWZ
         0ALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031938; x=1795636738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=022eQo8h9kU9nIHXfKYYOnp23W79u+iHIo1dSmOaVqQ=;
        b=enfIJaMWMNml8HWs+DkTeHRx1yC8uc6cGVzY6SBGPHNZMRUVSXKiTxMzVL3zM+j6xy
         wESs3SurIczZUiTTg+z0Qt5QZWhMNcerxeW3uhY6VV4itQz6+NoRVUcBmu6A6bym13Y7
         EnLgLwT1G8dWyxSK12jzJtak6nTEgVCD8dEgeffM2iPM955moFtdY2xTqjvp0vPQjY7Q
         cW4lcXjSZrh4PNKgflz8bLbS65aeOe0OKNpjBL92uQGKtl3pRsltT1oRmiWbU9R3Qlzg
         62ATW/rnioFqKlBLdQE0EJm0Sd9Czz9OxtPKn5+L4oGwQyBt1nJzs2uxooySAW9/ez+a
         lLIg==
X-Gm-Message-State: APuU4Z/9+wjC+yG1rck0tJj1cgKWlGoadH18yEtqUGnczIKPfQ5NeoIF
	M3bAzxxMo/f8YLocPPVW9sN9cj8u4/Rp1WW2pz+PU7fpQKfGiJfgWi8nYtQqwW0j
X-Gm-Gg: AYBFou1MZYSaqJFwCkGLiref2D/t1CigujsjsIfKEBbMZmpZVB5JHnoybGiJs7N9KPr
	vKivu8rj4McwSf9Zvk3XGldqs60nluIyYY7Fn/kj9fHY84PwvdIKf8ZQ6DahlnaCCMPyBNI9dB8
	MzydYBgP2lcreMh4GuOa9/kx4vAdBDd9C5n/lcb7TmUu6KPUjgYO2omx73GrdNF6OM7K4VSKeK3
	AxuVD9FZBFv+pRqHOlMof2G4s2q8qBFkNQOuDpiJMZDV8bb20WyECXmoiG1SNOO1KiT4R72HmOg
	RYC+tgzn7mKYAWwSr7vJ6GMym2oxlihe4ry53D1kytRTeZu4It/bEfqK99ghPpr9JA5mMS2r4J6
	BF0cAferA8Tpn1sajmJ63KNYQJJaBOntghwf7rhCxM6FnSPbWqapCd245pEYcPLxMOeggbf9XI0
	9lLzsB40Kv6HRJg2eJD0OXC2OPdYwvQnCoZV0P9768hVTICZ59BqD0nbG1EsdI48BmaMOj9BU3x
	B1und165u2vm1lUQji5iXYj30+zNf3dcyhRajq5lRAMVgPvX41zSk9qyKbC52idh8e0fyw/uWSO
	oMjs1o3nwsv8Hpfo0QQpKav+3zufbeQCBNVviOPtYhi9Ia+M0pPatZTOG0zzphJ0UDiqbYA/A8M
	I2f+lKQe7JcNSzToYYWAutP+wel8OEOy82Fgqju6EJ+uNDw6xIWDapoRYY2PflHzMRaNfHYIB5L
	XpbKpBHT0ABAiat5tLyzuQuvG9
X-Received: by 2002:a05:6102:91b:b0:7d0:9587:1b99 with SMTP id ada2fe7eead31-7d6b9ee48fcmr1531882137.0.1795031937886;
        Wed, 18 Nov 2026 11:58:57 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b91e87f4sm2685571137.7.2026.11.18.11.58.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:58:57 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 12/16] profiles/ranging: Defer CS Security Enable until the link is encrypted
Date: Wed, 18 Nov 2026 14:58:40 -0500
Message-ID: <20261118195846.393710-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118195846.393710-1-luiz.dentz@gmail.com>
References: <20261118195846.393710-1-luiz.dentz@gmail.com>
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
 profiles/ranging/rap_hci.c | 78 +++++++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 13 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 1d59eaa6efb1..ad9c4c0feb9b 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -75,6 +75,8 @@ struct cs_state_machine {
 	bool procedure_active;
 	struct bt_rap_hci_cs_options cs_opt;  /* Per-instance CS options */
 	uint8_t role_enable;  /* Role value for HCI commands (1, 2, or 3) */
+	bool sec_enable_pending;  /* Security Enable deferred until encrypted */
+	unsigned int encrypt_evt_id;  /* Encryption Change registration */
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
@@ -902,7 +905,8 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 	 * the ones for other links: acting on them would overwrite this
 	 * link's negotiated role and advance its state.
 	 */
-	if (!find_mapping_by_handle(sm, evt->handle)) {
+	mapping = find_mapping_by_handle(sm, evt->handle);
+	if (!mapping) {
 		DBG("Not for this link, ignoring");
 		return;
 	}
@@ -1010,26 +1014,62 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
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
 static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 					 void *user_data)
 {
@@ -1799,6 +1839,14 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 		queue_push_tail(sm->event_ids, UINT_TO_PTR(id));
 	}
 
+	/* Encryption Change is a plain HCI event; it lets a deferred CS
+	 * Security Enable be sent once the link is encrypted.
+	 */
+	sm->encrypt_evt_id = bt_hci_register(hci, BT_HCI_EVT_ENCRYPT_CHANGE,
+					rap_encrypt_change_evt, sm, NULL);
+	if (!sm->encrypt_evt_id)
+		error("Failed to register Encryption Change handler");
+
 	DBG("HCI state machine attached (role=%u, ant=0x%02x, power=%d)",
 		sm->role_enable, sm->cs_opt.cs_sync_ant_sel,
 		sm->cs_opt.max_tx_power);
@@ -1943,6 +1991,7 @@ void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
 	remove_conn_mapping(sm, handle);
 	sm->procedure_active = false;
 	sm->cs_role_known = false;
+	sm->sec_enable_pending = false;
 	sm->current_state = CS_STATE_UNSPECIFIED;
 }
 
@@ -1991,9 +2040,12 @@ void bt_rap_detach_hci(struct bt_rap *rap, void *hci_sm)
 	/* Cleanup the per-instance state machine */
 	if (sm) {
 		/* Unregister HCI events */
-		if (sm->hci)
+		if (sm->hci) {
 			queue_foreach(sm->event_ids, unregister_event_id,
 								sm->hci);
+			if (sm->encrypt_evt_id)
+				bt_hci_unregister(sm->hci, sm->encrypt_evt_id);
+		}
 
 		if (sm->measurement_timeout_id) {
 			timeout_remove(sm->measurement_timeout_id);
-- 
2.56.0

