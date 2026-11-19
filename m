Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108597;
	b=TOexzYF5SgOwlX0ZFsB1sCVMjGgMwZvFyx5MB1Nr1DfErDUjWzXJqJj7oLDhTGGtRxQ+
	 C+81mNSSwf9JbHGkB4GwvHdrZ5sQ+mlT9k2+V/Ayv28NyhCLb9ZFpZDbWaBw01lD2SH0O
	 4gGlPyqXLsP3aB6o1AmpzKXS8HPXkBGqB3IMO9vYP2UaosfQOR4PCFkhDXl6bZC1TIhWK
	 RegFqU7PhtNabxi38ywBQlUbcF8ZQz3N8Mfkx0BGb//BB/xGTGOskJljNhPSkeInGf1SQ
	 HV4BGsYCbWa8VmY+lcfGvXeVyP9W3JJHM0PE9ihEtwbu2qIUzaZs0t7X6ZKAjmmy9xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JplftcisRZsqFBDbe+JoCHZ7SVTMMpx8C2MmZ2L7ADU=;
	b=DJrGUGv3rOGi3APqY50RcPTYkY01JKA2In+IfEE6Hn3OUgcuki6SwqJ/61S5B6yM9sI0
	 ucETVB/m2WE6dXFcR1cNTFzwAC6EAN71v+c1di3ZOea4+8abCrWhOb3ShBRmOIxiqwolN
	 ZJDOzNg/svG8G7v6kpgpuawjqJBwZLEL3B29xd/bW73mqoq7jgjNP6O+BRKFL2H7TSGog
	 WsqEs6ao5lnFV9lNJ6281QnrXVeK9NEpZGH00NXxyyhnbcB1984X3iCWVI902uLggEDCf
	 ABnmhL5jwObikut7Yc7vbVHx2Q7ndAwlhPMENvMFQCEnprxufW9XqUScG5y4BAfbYCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=moEx8f3N;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D10A606A332
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D10A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=moEx8f3N
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5edf97136aaso1459642e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108595; x=1795713395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JplftcisRZsqFBDbe+JoCHZ7SVTMMpx8C2MmZ2L7ADU=;
        b=moEx8f3Nuft0VO7g+LL4Qpm0Nn04ZeLC2li6OBb8Z1OP6VvOZBcxEOzGP+x2+RIHez
         vpJU9l3P4O7gWQ1zEBYeyjm0QidhTPuub3h7DTGXqqgWLTKbxHSb4rllaX3t12+H4GaX
         7oifHK0C80SLTv46PRTeKysa4e6NQ+ppQQ0XkdRu1nbyBY3a+6rX2tZLseliq9UdrQ1u
         08s8MYdUjGiJJtq32bSx0hk4YzvyAflUjE2VO/PkTM4cQi13w59vuq8NDTkAYfd/mkWj
         MRH0NBmurK6NVf7qV2n/kXWXWHhYj6TfPyf32W1cjgT0d2lbuQl9wiEb4xf0KXrYcp8y
         F42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108595; x=1795713395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JplftcisRZsqFBDbe+JoCHZ7SVTMMpx8C2MmZ2L7ADU=;
        b=OvQubwTEXafWacuY085icMM42ttLPx1dQ2yW9HhVycBATLhGJtEP1RgNK9PqGtT2/h
         WjTsg9xlpzDm+BGiVNbOmfWl+oNbrtuoMkKuW3WqhAJuRty1oDCpd9E/N2G3gcKoQXXV
         gnfBDCiy0EBwAZ3bgqj2N/TnJSRfWKPzMUw4CvUYT9qS4SfYQooHNxHEVNCN9ua9GUE3
         L2jaeNxhwepGdUCrI3VpcDoiUUr8A2QrFcPyLlIQkebvJL0h45TS58q21B4WybxwlR/i
         ZImSmMq8lGZWWerjEFYmmDm1WPafa/JmcifUBAtYIBVTE88SziUf4dtnIEpkZt1RXBRO
         cdew==
X-Gm-Message-State: APuU4Z+nvvAQzV3O88fZ+i5yuZcn5DB5N0gli88I0kI4FWnnjFynL5S/
	CN0XvjnuAKZSnjjwoxe4Z0+MrWtfIoq60sw2d7LAGVvYYiEPwOUCMWlmFFTyDbJ0U/s=
X-Gm-Gg: AYBFou1LfLJetVZEq0RL6aP4fgRwkd3fOqclFR6Wt1yqj++oBE7ynTwr6hblP7SQRM7
	ofu/M01mlYuJfo54MPmgFheZ6LYVwNiNNUFFSHCdrzUp7wQVVf7UVr3rSfIDS2nDjJg6tDRlXwI
	ug/rhaTpDikdilt5jeZIpQCTa1r/dLUO1+s4HQcInD8zz7fr+MX27E2t80RRN1Ev5bt0P9eloXe
	DAZUYtOyfj/rKHSC0LfZoZXzciJvOePg72u5b6CQQvfKhrtIoTNhAVDQfPvydVJnNTpApnoHAJB
	iloOZLmTME/dmiLEUFPnmaXcTxbtBEqJbNf0pZNt8xyt9dLkhzIo6mDLTpgHVlYRoJiUKvY7Riv
	rfXVY6lkc8p6mSH25syDYJM9MwkcmLF9NXZzVS5dFNCRPweYPVPnsDQjxGvX2wCEyk13WyXuG6a
	Y4X5AENrs/km5dAX+AwQRseJRU7Jp5BuOGRhsdeR3d/uk7WdKRI5RIscz543CToB2AP01zQFXgP
	KR23np1nuz5IyGeDt8A+NZxZeWfIzYxNc/pCmPtp5LkXKP8wXqUrrr+x4kWEJodKBS+ZNzv287r
	3oYAgMQCsiJn8rnvSybgjCZo7XFbIUqCVcuGGNSeD1vvHtJA7QlT8mAnKbvAFsUc5/2EK72+OoC
	Z2dV3Im+tQ7+w8TKIniziv+eWaF7tCOLU8zYh6kytNdj2Dr3GepFjwL4hkWKDcmDzIkbVhIAh/m
	4jfGyK
X-Received: by 2002:a05:6122:32c8:b0:5eb:7686:48f5 with SMTP id 71dfb90a1353d-5ee8af0af4bmr300374e0c.8.1795108595520;
        Thu, 19 Nov 2026 09:16:35 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5a8fd3sm131881e0c.8.2026.11.19.09.16.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:16:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 09/16] profiles/ranging: Take the CS role from Config Complete
Date: Thu, 19 Nov 2026 12:16:17 -0500
Message-ID: <20261119171625.1014004-10-luiz.dentz@gmail.com>
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

The LE CS Config Complete handler stored the CS role it reports in
cs_opt.role, overwriting the Role_Enable value set by StartMeasurement().
StartMeasurement() seeds its settings from that field, so a second call
without a role key sent Set Default Settings with the negotiated role
instead: 0x00 for an Initiator, which is not a valid Role_Enable, and
0x01, Initiator only, for a Reflector.

Keep the negotiated role in its own field, known only once Config
Complete has arrived, and report Role_Enable back to StartMeasurement().

With the Reflector now running the setup phase, StopMeasurement() can
also be reached on a Reflector whose procedure is running. Only the
Initiator enables a procedure, so do not send Procedure Enable from a
Reflector to stop it.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap_hci.c | 29 ++++++++++++++++++++---------
 src/shared/rap.h           |  1 -
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 103431847538..84b94d8d453d 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -75,6 +75,13 @@ struct cs_state_machine {
 	bool procedure_active;
 	struct bt_rap_hci_cs_options cs_opt;  /* Per-instance CS options */
 	uint8_t role_enable;  /* Role value for HCI commands (1, 2, or 3) */
+	/* Negotiated CS role for this config (CS_INITIATOR/CS_REFLECTOR), taken
+	 * from LE CS Config Complete. Unknown until that event arrives, which
+	 * is why it is kept apart from role_enable: the latter is the bitmask
+	 * of roles the host permits, not the role actually in use.
+	 */
+	uint8_t cs_role;
+	bool cs_role_known;
 	struct queue *conn_mappings;  /* Per-instance connection mappings */
 	uint16_t active_conn_handle;  /* current measurement handle */
 	struct timespec last_chan_class_time;  /* For 1-second rate limit */
@@ -129,7 +136,6 @@ bool bt_rap_set_default_settings_params(void *hci_sm,
 		return false;
 
 	sm->role_enable            = settings->role;
-	sm->cs_opt.role            = settings->role;
 	sm->cs_opt.cs_sync_ant_sel = settings->cs_sync_ant_sel;
 	sm->cs_opt.max_tx_power    = settings->max_tx_power;
 	return true;
@@ -167,7 +173,7 @@ bool bt_rap_get_default_settings_params(void *hci_sm,
 	if (!sm || !settings)
 		return false;
 
-	settings->role            = sm->cs_opt.role;
+	settings->role            = sm->role_enable;
 	settings->cs_sync_ant_sel = sm->cs_opt.cs_sync_ant_sel;
 	settings->max_tx_power    = sm->cs_opt.max_tx_power;
 	return true;
@@ -277,7 +283,7 @@ static void cs_state_machine_init(struct cs_state_machine *sm,
 
 	/* Store role_enable for HCI commands (1, 2, or 3 from config) */
 	sm->role_enable = role;
-	sm->cs_opt.role            = role;
+	sm->cs_role_known = false;
 	sm->cs_opt.cs_sync_ant_sel = cs_sync_ant_sel;
 	sm->cs_opt.max_tx_power    = max_tx_power;
 	sm->cs_opt.rtt_type        = 0;
@@ -964,7 +970,8 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 		return;
 	}
 
-	sm->cs_opt.role = rap_ev.role;
+	sm->cs_role = rap_ev.role;
+	sm->cs_role_known = true;
 	sm->cs_opt.rtt_type = rap_ev.rtt_type;
 
 	DBG("config_id=%u, action=%u, ",
@@ -1050,7 +1057,7 @@ static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 		cs_set_state(sm, CS_STATE_WAIT_PROC_CMPLT);
 
 		/* Check if role is initiator */
-		if (sm->cs_opt.role == CS_INITIATOR) {
+		if (sm->cs_role_known && sm->cs_role == CS_INITIATOR) {
 			DBG("Initiator role: Sending CS Set Procedure Params");
 			if (!rap_send_hci_cs_set_procedure_parameters(
 							sm, handle)) {
@@ -1524,7 +1531,7 @@ static void rap_cs_subevt_result_evt(const void *data, uint8_t size,
 		return;
 	}
 
-	cs_role = sm->cs_opt.role;
+	cs_role = sm->cs_role;
 	cs_rtt_type = sm->cs_opt.rtt_type;
 	max_paths = MIN((num_ant_paths + 1), CS_MAX_ANT_PATHS);
 	steps = MIN(num_steps_reported, CS_MAX_STEPS);
@@ -1616,7 +1623,7 @@ static void rap_cs_subevt_result_cont_evt(const void *data, uint8_t size,
 		return;
 	}
 
-	cs_role = sm->cs_opt.role;
+	cs_role = sm->cs_role;
 	cs_rtt_type = sm->cs_opt.rtt_type;
 	max_paths = MIN((num_ant_paths + 1), CS_MAX_ANT_PATHS);
 	steps = MIN(num_steps_reported, CS_MAX_STEPS);
@@ -1840,9 +1847,12 @@ bool bt_rap_stop_measurement(void *hci_sm)
 	 * there is nothing to disable, and the Controller answers Procedure
 	 * Enable with Invalid HCI Command Parameters. A procedure that is
 	 * being enabled has not reported yet, so still disable that one.
+	 * Only the Initiator enables a procedure, so the same holds for a
+	 * Reflector once the Initiator's procedure is running.
 	 */
-	if (!sm->procedure_active &&
-			cs_get_current_state(sm) != CS_STATE_WAIT_PROC_CMPLT) {
+	if ((!sm->procedure_active &&
+			cs_get_current_state(sm) != CS_STATE_WAIT_PROC_CMPLT) ||
+			!sm->cs_role_known || sm->cs_role != CS_INITIATOR) {
 		DBG("No local CS procedure active, nothing to disable");
 		return true;
 	}
@@ -1899,6 +1909,7 @@ void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
 	DBG("Clearing connection mapping: handle=0x%04X", handle);
 	remove_conn_mapping(sm, handle);
 	sm->procedure_active = false;
+	sm->cs_role_known = false;
 	sm->current_state = CS_STATE_UNSPECIFIED;
 }
 
diff --git a/src/shared/rap.h b/src/shared/rap.h
index 7ee51143c0ef..7ff5de227d70 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -19,7 +19,6 @@ struct bt_att;
 
 /* Channel Sounding Events */
 struct bt_rap_hci_cs_options {
-	uint8_t role;
 	uint8_t cs_sync_ant_sel;
 	int8_t max_tx_power;
 	int rtt_type;
-- 
2.56.0

