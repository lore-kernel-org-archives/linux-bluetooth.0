Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456295;
	b=WHcNlXcEj6438joAPg2uQeeC5tNFPaZrhP56DhHKWurN2dWS8IOkLTXoURdWlybADrpV
	 6VF1/WCsUf7wVao3BiElrN0TQd5CcX4qEtpctYie4QQ1GHG6q9XUE0gjpSvhpkB26sdGz
	 f7pbCYJdzCYN3mWsGBGilK9phXitCaxFfmG2jyOy6x3pkI56aeFdtI+XNxxTenMmMi9Ua
	 AEekyeEQ1w8xnfTja4ikQMe7VRpx94hMjQzcsdUZOHOskCp4XGdklL2HtXtivVK224T2i
	 MdRZBHNX2qNrmgHUne63e19S3ZdZxQVgWCl0kzr9/IbOCByG4EZyaCdGSloRVSFPRbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JplftcisRZsqFBDbe+JoCHZ7SVTMMpx8C2MmZ2L7ADU=;
	b=sdcVE9NyT5BjFi409D3LzN+E+21/U9jGmQqZFGnw73w1YlmEGhXKg8sNGN8xiLTgM3ls
	 79zVJeV4Vjkrvm5cZjh5g/DESDR3G8m+g7l+mDFm1uQG8b7zuQYNVtP/CCVjDS2jVxepg
	 5D2f0eaFsVR2f0SULePDCPECbObYkaXds71Ij2xJrX9E+qM4FaWvKQW2eRgXBqvDzV5N7
	 L/PxQzHRXJj6YVNSriP4lt0dSUPlT2i2EX+jk7X5TWJY079RbjkS4W88og0ULC8GP/HD8
	 6dcwLKRsPz1HsTqU8bVO1l4/MWzSk5BxYMXeAZSkH6FI+ZVNYXlheNllj8+SZC6WHFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Z/erfdlt";
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C00D606A33E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C00D606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z/erfdlt
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-98c7798ce74so913313241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456294; x=1796061094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JplftcisRZsqFBDbe+JoCHZ7SVTMMpx8C2MmZ2L7ADU=;
        b=Z/erfdltR7dlGTKXIVzrVooLLDX3IVu5UY5BKDFqEvqPhW/fD9ADHLpKmIkcMJj0Qf
         VphAjEjLVF6zipz4E6oR3X+8xHZeTSOzUOMsf9Ubxu6/BNWrghoJwLua0Lt5ZOtlwZh4
         gKNC2CoS/tKASkZX4ZxiYnBictSl3UdjoYIx7MmqQNPBT8G81uNhoII1bO2mebjj19A4
         /bXQub13Mcy/5wHUVrIls2huMj2lrFbKWWFFrT8KqNyLcv5Ov+ckuz/xkddPWMC8RUW/
         QPEr27EN2Si8WnyJIrCu1xBteYdDpcxs05jwSOCTlZUer7locDTYgpSoYCnlysIpweCq
         HF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456294; x=1796061094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JplftcisRZsqFBDbe+JoCHZ7SVTMMpx8C2MmZ2L7ADU=;
        b=BWk5cABvU1W4LV5RIs2SB/ZefVTIaDOpamG6VbVqCw10rK0IJ1jpoQfLAiXPANF5Ka
         V9P9+DSRsXsc9QIuPEILF5ceZIVZ4XCrUtvlqHVCyxxL0LSF4/HCkAoZ+nUI4qbIMSXH
         ogw+Gp11lLat1MwkE65Apv16D4Qap/pCg0yT188RiiMeiTBB63gygXoFNktbEqNDIXu/
         cec/X5RGr49UqXIWIKG5VUPoD5kFI1pJNXbfRgNWFq6zQWd0QDpZoZz6crl68iE9l8tB
         3Dxm/qI5tC+2tqOSgDLbmWXLWSYqtzso/QASvxMzQ8QJomkOoINhKl+Ig7hdI/a+Wha9
         n5rQ==
X-Gm-Message-State: APuU4Z+JkEpK5zdz6N8lvQtITLyDfqrK8POrrtsTrUb6TFhEt15z771l
	sSECbFZRPI2doCeUZflxUARcHXAv2JPmBfjXWTySynRmJarm94J89estQ/LbCg==
X-Gm-Gg: AZFdTZc7xEJ05OgW97p+Ou4vCIX1gzj3cTGYA0E0DwDXeFwsRHeYNuNhc678IfEPQBO
	DVV6YnPJ01Dy66QoOnoP5Cde5Pn8IMiGI7KgXHgFVie1C4sGu3NBUiy/qgtngN4w7RG4PNqjtZy
	ltQELJUHLySov5i5h4r9zKfXnvBdFHQvp0KkI+t9R+rmjaMMWlk0NA/10jt4jd88ewuTVSExb9a
	Bzp2WRaRVBaikf8GwhdoFgGDwUhEmtpg8mGq/fDoa81J3zvoyXG7YNbKEj38VBuz7ZoCP6Gon4s
	ZGUHuo3t9a06E2BgKvtg7u8E6ql5+cmDjpTTdhdff0u8eCTtChV+XDFJm+zblrv75yKC3JT4B0q
	NAtChPfxdKLhmXWpkLGi8ej3dp/C6t4ceagj8C/J2io9ZEBdmClCMYHp4XOnF3qoidaoQURNZec
	qc+XZnUv19rm1Z4wdqyPa0uin9o/BX2e5crI5l3Wy5JpM1rjJJvgdiLbieMvLm3LVCYejVAEjrR
	0hr6+WaOYfDMD2sjTdUmFC5EFGO5VMwWCi96XdYNlErgsfXYBtgeAT5MyIqIP0/wG/nVZtBHcbP
	YfZgsmRwfn6xulJhuSwrQSyag+oB4Q7xoJFPqLURuNzF+5MDxz4sa9Ml/n8+U91Qf0Lrta36QrT
	Znp+L0VaFEljDWw6zoQAhGHZBxBnhnDAcQvNJ4nc19D2VtL+9ZLkG594vMVw0OZdh9TeLW3Bi9u
	FQl0E=
X-Received: by 2002:a05:6102:5127:b0:7d2:d65f:b479 with SMTP id ada2fe7eead31-7d73962b75amr4755518137.28.1795456294128;
        Mon, 23 Nov 2026 09:51:34 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm12795393137.5.2026.11.23.09.51.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:51:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 09/18] profiles/ranging: Take the CS role from Config Complete
Date: Mon, 23 Nov 2026 12:51:12 -0500
Message-ID: <20261123175125.3642617-10-luiz.dentz@gmail.com>
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

