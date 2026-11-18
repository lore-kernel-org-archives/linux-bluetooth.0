Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031937;
	b=H6wF0dExR6TofUYLpNZUaAYSxugxw9+CjFP0y8vEkDMeHZHJcUPU+pX84ShYTJ7K10ts
	 jE9u69Osg8Nf5sPih5gGsKfiPfI0yvaS/KaU8NGAwYLHrYMkXWlzMeRuK7yaXHNbnYThz
	 NmY/T1Fmw3fHecfxjSJGP8lFC4CDFFKG5CbK3ynSd4upokZ3SiVLKtTYrt1Eqw/6cDe6Q
	 vILqhbA0L8aJICotpnDmz94IfI+TW4kKNtpjs0FRTTomY+v7JK9YtDOM+F8yRqZrn6eBV
	 5Yry2rEduXP8bNq46+An/TeVu3MvnBbZASjjdnorHsQmhTCN1fH6SXYS3Peat/YL93w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XmI8ZmkJ+CVZZcWiK3ZqKZP4uHGT4PA6Afj8pqP3cF0=;
	b=JnsvnbAyWHS4cQMu+ZwIDKE5bgkB8rju/PQwi1HzKVnWRPHxxRoYxziizw0hWsg0uhg+
	 zAPZzXSpzmjyt2EJlVu86MTW9IBYnO624i/PYQ+aInMaGWUABrTvqOkqlcofpDWwkjJXq
	 CUZPiHocvLjq2AmLq4H36EnpX5mdLA0WOGn6JkL8wufW9Kz1AqSYAM8uqvCenzzmVolgU
	 fC0QEdoVvRLvX/3Bi5qEzyTGlbJU25buHg/EopzK0MPV+wQwX+xbo8dNA8NfkKc0c20UL
	 xLCtkYLW0AbFxuNyuRErxWht+qhRXi10jvzmfCn6lcqdP5Hgz43F+xHeOIGMhVD2PeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pfer+Ds2;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C898960A2614
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C898960A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pfer+Ds2
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7d2c8141dc6so678464137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031936; x=1795636736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XmI8ZmkJ+CVZZcWiK3ZqKZP4uHGT4PA6Afj8pqP3cF0=;
        b=pfer+Ds2m5l3Fj5KDeZXOBMTPiJnIWsytZ0W8jBERpxtxfUQY0lEk6HdQjZ2DsFHcv
         b0g+T4kYliGlNOMuXa8vT3pGk5bvK8N/U4QFmDXCJw+E9Emk/SeznQemgg+EJTMSlwzm
         LXJa7BjoWaUGX96NL0R5Mq+dRDNTCF8yEZeAj6vObUX098DeXdJKjIGXjq8TXUxJYGQs
         cDAxdv1hShR35kLX5lRLByvO/haTceWv1h3B82ZOv+1Hq4tEtNlx4bQLYNig1yaahojG
         s+iFFbmA/esJQwHcIUIZAdtgYApqa/pBpu04XHKoy2JS0g3+kIIZwEltJ9/j8B9NuMBY
         T+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031936; x=1795636736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XmI8ZmkJ+CVZZcWiK3ZqKZP4uHGT4PA6Afj8pqP3cF0=;
        b=ebJJniQbYNfpYwOqEKsgsf1tsYdI1Yivat3kVx2MVrtVo9stNt3NFMNWlMSvt++nVY
         YNpALLGo0CiU4srwR93Jo8aaj4JieDWsb4rjZvC0peH8pdsPMvx8vCBEPyTqTvgMfjhe
         Ex0xQ5jixAlrKZ13NNylEnuuwX2jdLMoVKU6QW59hJuOlYozcCnRRnevh0laOiPoI3n3
         0u0GhVcvW2FHIc5gcYyhN//VD6f64Nxd0rREtZ6uBh9ck4+Mzi+bb23m5fhSEqyoDw7y
         2W/WKP3i/8dCTjZcYzsD5slfPNalDGaSF0jK74Ylr2tVtGq/uFJMzRI9Ko5g8RCbZPZ6
         1ldA==
X-Gm-Message-State: APuU4Z+uxk4QGPVDm5WKNWLL72pw9+4YJxNxh/MFxWkPtPfa58uvM/D8
	VOXbWPQkYjjauOaX1SytHRZyO1rtwLp8bhI0JF3hALe+12iKD3QdwgBHL4S9C72z
X-Gm-Gg: AYBFou1XWqRMdK5jrq2vtlDiu1Udeyj97L8+oYvcMIdRj2cVD8Gx9+J48WxFtLgnNj1
	5n6VkGKLrB4utp0mbzGihGxmZuBxDCo9Kup/ISlWC/jnTHgrpAwwpLo5p0Ul+yvo7e/9/1K/NsK
	L0emeQk2SXo/JtibwHc2ga+S0HZxO4uLF1SkzBHIactrfFKQshWS5jr4QBKBPO1Mw95unnPECG4
	YSS7/eSoSTQxInDgiYoySVPRyNBS1VZ79DswGTYGi53Rt13uK0qL6xzTUTQZcV8Zv2i+D+6KnKL
	iyU14qqNFSh16ibiBPc7WeR+odKvlAGt7pnuRVvgAqWtBHIalLqkfrHWkNGNpCUz+Vh+4PDsGlZ
	HN8ArAFnbKkqEv2FbRwSHpVnzL6OHQb+5aLC/wsyDVhZ0VpVtqFAgWsaqB9fCIUsewMAGcOY1sI
	Owmx7+i89S+1/et/z7RwR898UyLPWkm/p30e8091ooPuxidu4nwcVphESClapVA1gCQxPVa4Tfw
	q3dI0TDbxstyZUsO1QiLlA2F0Wtss8XAuc7ojIV60oLqIBMKS8tKzwj9KZ4i+LPjREY6Y9rgNix
	7LWbhpShzFM+QmQJpedRWm7XWCkGc4Wk+vaTQCPJUN0P/THtWJP9d3lsQjYqhxlvHnLKFBpUDCo
	GF4IhdewBLKmArorh9L0GoE5P7zG6sEh5gUEivlrzoXny/uhtbLRIwYEpN/eoiHSj1V2mpvx3D1
	jdAGc=
X-Received: by 2002:a05:6102:6e88:b0:7c3:2168:d603 with SMTP id ada2fe7eead31-7d6b9ee7d79mr1401273137.0.1795031935684;
        Wed, 18 Nov 2026 11:58:55 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b91e87f4sm2685571137.7.2026.11.18.11.58.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:58:55 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 09/16] profiles/ranging: Take the CS role from Config Complete
Date: Wed, 18 Nov 2026 14:58:37 -0500
Message-ID: <20261118195846.393710-10-luiz.dentz@gmail.com>
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
index f23e89cfeb3c..ef01e60c559a 100644
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
@@ -956,7 +962,8 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 		return;
 	}
 
-	sm->cs_opt.role = rap_ev.role;
+	sm->cs_role = rap_ev.role;
+	sm->cs_role_known = true;
 	sm->cs_opt.rtt_type = rap_ev.rtt_type;
 
 	DBG("config_id=%u, action=%u, ",
@@ -1042,7 +1049,7 @@ static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 		cs_set_state(sm, CS_STATE_WAIT_PROC_CMPLT);
 
 		/* Check if role is initiator */
-		if (sm->cs_opt.role == CS_INITIATOR) {
+		if (sm->cs_role_known && sm->cs_role == CS_INITIATOR) {
 			DBG("Initiator role: Sending CS Set Procedure Params");
 			if (!rap_send_hci_cs_set_procedure_parameters(
 							sm, handle)) {
@@ -1516,7 +1523,7 @@ static void rap_cs_subevt_result_evt(const void *data, uint8_t size,
 		return;
 	}
 
-	cs_role = sm->cs_opt.role;
+	cs_role = sm->cs_role;
 	cs_rtt_type = sm->cs_opt.rtt_type;
 	max_paths = MIN((num_ant_paths + 1), CS_MAX_ANT_PATHS);
 	steps = MIN(num_steps_reported, CS_MAX_STEPS);
@@ -1608,7 +1615,7 @@ static void rap_cs_subevt_result_cont_evt(const void *data, uint8_t size,
 		return;
 	}
 
-	cs_role = sm->cs_opt.role;
+	cs_role = sm->cs_role;
 	cs_rtt_type = sm->cs_opt.rtt_type;
 	max_paths = MIN((num_ant_paths + 1), CS_MAX_ANT_PATHS);
 	steps = MIN(num_steps_reported, CS_MAX_STEPS);
@@ -1832,9 +1839,12 @@ bool bt_rap_stop_measurement(void *hci_sm)
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
@@ -1891,6 +1901,7 @@ void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
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

