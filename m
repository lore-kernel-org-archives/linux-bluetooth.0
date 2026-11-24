Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534748;
	b=cDa0HwhvrsKZ2Ef8anOWFIOfXESia/yNbzOPFcHluBSNwFCGcsCjSCXnr8ttj4jlKohq
	 WTE1gl6LRK6A36J56buoCMlGxu379te1YpPpqPcH+68nhh0GT0nGhTxd0hpK4Sa2AiYLi
	 gucSCxBw7gCyogujQmsOnteF8/edDG6ncT0IxGMBgnnUok5yEBr0u+fpFFMWD4hqDje3f
	 M2m4ZXCqUNjjFwR7u+RrBo6OtJiBg8WTBG7B3fW+P6SraxC1OKseWZUkUJDHzo3JuHnp6
	 SOVmUteLGNobHc2zGNN4w2CEV3QqmE+zN4FSKZ5mzUOLB38kbV9Co6i/+Hw4TuLi1og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JplftcisRZsqFBDbe+JoCHZ7SVTMMpx8C2MmZ2L7ADU=;
	b=cTm57302HisFNvULJa58TQfLq25zcPT4CwGeMrquuTKZfVH7Q7lr7TGUGIxpHZoOA9NI
	 NVEPSGZpkPqhQcy8/n8usEXv6YOVn4thr6/+REX9zp6lmUk7b2/6sVckyYWMCRl3M2Pqr
	 auMfCKJUjf44pmXY/nh+asfPQrwgSH0EysegyDz4QOnN/zuDQoKgqm5X7PbF95ERPBjrW
	 gEtfBvqJp2eNttzW0onvP/FB6uPH1uQhdhSTLnTaX0OQTQmULMtBWA7LTMJFTNoIziqmd
	 TgkCC+nDDAisiTuBBF+rDXyyAeRp0Q1rtC51PwdDeSZGsc+CEiWUv3N1lqnPObbHChA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rfl5JBTM;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED9606A332
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84ED9606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rfl5JBTM
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso1798975e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534747; x=1796139547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JplftcisRZsqFBDbe+JoCHZ7SVTMMpx8C2MmZ2L7ADU=;
        b=Rfl5JBTM50PsvcVdn0EbqDylEHRwxHR3B3FdAltFbpHD5AWshZVrfT+f3G2luAHn6E
         VesduV3Xqk2osLsrMj9xmVesaJVrxPh8fPBJRIt/+MLjeHSaJmaOhpaLk3ekU475mksG
         UkBgugdl/ctX/jvvZpT7xVEpGCunlCVOf7wWPmdJCuUopMByxe27nOQcrX0CnC+dkcQ3
         6qNwSB2+25bZrf4kD8nulTQnahCAY6k3hCfZwZfMGXXCcC4tDb3go1m0QDTr2MGw/K+c
         T0/dNriRdZASY5h5S6BP/2XD7p3Qb8ChwSWDGxTefYkMGv05Ya+/WJLbMO2qjMZurw/r
         T0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534747; x=1796139547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JplftcisRZsqFBDbe+JoCHZ7SVTMMpx8C2MmZ2L7ADU=;
        b=Q2A9cgf7IdrillXKihz8AsTdpHA1eSz6t82cHppKOlq72/LZhAUS4d3QP6mbxvAEps
         1FcwwejHg+zw8o5XCJC2ZCYQinghIC89nH7kBLJ+Op4Dbwl6HxFinQ1p4f5IZb98OjDc
         c3nAHzc+V1KNvyTK4M63LU933BJVp/xfl8yZx433RePLXzfppn00R1pgPtadSVMnSjqu
         kT9ZZ9YTnFMO/xxwL8rwTv1dg6yql4S2cDF0stJyuehZxV06RkNX1IQbcfLBOKp1H8l/
         sF4+J61RHVPODQuouTLMz2dS6JDih5njXij9FsoMsS5jfdvb6d34hR11Nt2RJkV0C3HF
         80Wg==
X-Gm-Message-State: APuU4Z+CMPYOyHrjwKOJqQRl7q97eZrkZCD1T72THYsv2Xu/iY8uYqnj
	LTNuDeB+QXzSWqk31uqR1oqQlDwAZuIQXmDnpIM9Gv47wfkZNnJ7mt59MiPbQQ==
X-Gm-Gg: AZFdTZfvHo//hiPNjmR7zDUymsEVMsV8CdyxWhJCj8Jb/FfvXJwGaO+FzUSULT0NWGJ
	omqZY4aL+2Jkh2nz8O2oU+84zEXrO7T22RjQ9Zp8QCpQIQT/pYOvrKMihAw23Ku2qLa8XJBqHxT
	Z/QFuSHZ3qhd3N5jDFTfRNR7hamsjUzwZ+ytPjLha32Rbkz6diz1EJDZOsRj4Ymp4zRSTFBq/VU
	xLlWuNIhAIhU2UzY4Bx70R8CI7h/geLOTnlijVI/pufQ9gKttsvJq5niZ8JtE3D4cnolLXa7z9M
	URXppT4rIGc9atac7dm+RVNQ0r84hAd188MWefz2wnfpJMlXfkX3X5Me6j3td0ugzPHnispIui9
	AW031c7KRn4gwAghkQqQOfpDl8vLAI9HUx2IXt6yDz3AbOPYwSU9F5l+MyVL6Bgb2OTYsZLOlVA
	lsosV5YP1gIpTpAZCgXirURTtZmXagjdRmlUMkMuL7VpSv0LX7jwLl3+uYXeaMXfOBiFeN6Cbm1
	DN+kxR7nMxa8jquU6iuoUDnhoY/XUEI6rgU9LVnnilEupCi57BPVlweWWyCk+XRMWDkyY3yjnQ4
	3Bn1O7BuYtLar9lnmc38eKkxtEqCUbIyefcdetTFP9y7KZbnaWnZ/PcOlBTtyNTQFbO6pt2mRYB
	QsmvMr/I71wChwP/ace6vmnPeWHyB8DclRjYOQWjfA/z7S82r+O7jkIFBrR2TTOqcq+D3X0cyKC
	SPVRU=
X-Received: by 2002:a05:6122:3b84:b0:5ea:e324:7c0c with SMTP id 71dfb90a1353d-5ee8af8d6fdmr7747081e0c.22.1795534747225;
        Tue, 24 Nov 2026 07:39:07 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5564a9sm14343463e0c.5.2026.11.24.07.39.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:39:06 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 09/18] profiles/ranging: Take the CS role from Config Complete
Date: Tue, 24 Nov 2026 10:38:46 -0500
Message-ID: <20261124153856.216054-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124153856.216054-1-luiz.dentz@gmail.com>
References: <20261124153856.216054-1-luiz.dentz@gmail.com>
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

