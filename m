Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193722;
	b=t6iOQi0eXFNGK3uFeXE4lHVgPNijGuwfQcMB5WRVFm2jiMWajk8ro2gvJ/suH0z9hbWP
	 j7sjEDW7PSLvRYew+FmCHy+1eCMetbsSccos7NvhAKctjAhwR1s2GZceXwPnLM3zFxJY3
	 USEQ/pu1fg3EfBTH2DSxQr4ttACtA58OeYkEOxbpLZEKuVtXckoiXqnXnjgR8ZS3t78sY
	 9UDIEdfR9INoU0LxGSAS+1ArgQNO97Dd474FppsYEzR6gQizEpxz2p7PzfHDMb3RDKAbr
	 BIgyKgR3Qcx/tA3YA6mmZURrGndc84DzIWfFJZV6aqh3VJq0VVVf9MWN48SgocAM4xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JplftcisRZsqFBDbe+JoCHZ7SVTMMpx8C2MmZ2L7ADU=;
	b=q1pd3k30W360FPtqjUSUaobHrJ1Jfy/4aeeK6Iq+E0QwdPoeqqRW+SIMgWunbQQoFGJM
	 SbFbw7dWIrHGpjHggUY/jhKFgZgsPO59kD9I7eu3yMw35jBEAUgi9A//vbRL+fuvr5djX
	 cNsjNTuexSLizID1c6axEaz5+KrHP1c4SgIaLmT920DgmNcpSz2VhuqnLLpsVgHp4L5GL
	 bhBFFTX7qUYn/6WZOKXORSKWCKS73vxPsJSe/JfIEA40bJH2HmpHXktb7o8kClUve0Tum
	 /By514XZh1nqOdj1U31IAMKz4/328thfnKZUDWrdba5MK4ycsS31sIHnw2QCmWdcSvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EKEdibU4;
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CBF606A325
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 16:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29CBF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EKEdibU4
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-98301b325c4so348630241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193720; x=1795798520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JplftcisRZsqFBDbe+JoCHZ7SVTMMpx8C2MmZ2L7ADU=;
        b=EKEdibU45P8ir/jygD30AKkc8H3hC8Kg0BMDnp8HTurL/rlw/a7ubJnfPWymi2a8hO
         mn9aqEThWblLrRRPifCWYcpIev9Ihqd3ALOIi6njMCz68P4gd/1rLYX0GnVuABs2eCw5
         DARLkXy3zcfUUSDRkYGE9BbDvtKSPp++8/67oFC8shtJti45Ifjl6CBkM+4dKU1nW/vk
         f2MAwoo5j+qaxFd9tdWV9yXxZC7RThUZs5e1zD0/2/sW5vPrCfP+aYbp3dUZxHsjUOoj
         e8QK0SkMXnJWYyfgqG9lCQklksVGLOaxDD+udPsH4Vd+CPA7un0XWqayyxTLJroFcunz
         qtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193720; x=1795798520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JplftcisRZsqFBDbe+JoCHZ7SVTMMpx8C2MmZ2L7ADU=;
        b=j/4PsEVKWfVExO0ZA7G5ZJFEn0EKSosri7SdNP61XhdJFSGwKmPUjQ8VrCD4Sf64/q
         yNyYqbhZYjn2mTg/B7ivojWjP66U/fiMxtP+n4zwpI0ZYhGGbQXmg25AeNX4Ghb6PoXr
         mvl9P9iRrb4qneO84KCZWlO84+Pu/v+N4PXXFHHk+rqC0hSvnF3cVjEyAdWfNQ4tHf7C
         e5aoO6qdkIffY6daONpBaKW5S4DRuyc15K71J1j//9Btnlif5Wpq6+X36veWB6VJ6XoH
         9NHfzQflN/ol9S896tNKDInpUQNS7Vtn+1rTrkin7WDd6IBbt3WfkmCZvMI+R/s9a5iu
         +ipQ==
X-Gm-Message-State: APuU4Z+obRtsqg1kNHgl++bn6dlepKz7ezGSwL8/VgCIz+pS++i6aiLA
	XuoZUfMTggOzE4P87FdZWWPo8O/wVAZEw4H+BussXMkomF6bOPMgAk01p1/yW2aT
X-Gm-Gg: AZFdTZc9If1tenwH0Ocsk5zq+p+4mkfmyFcao/E+os3X2lKzFp9Aqhd72cHheJfg8C1
	dLCVb6XzNP+z+YLXupnFNfJIVx/ZYoj2V/EYXLqfjxYwMGgvi67V87aNPj9Ji38/RF07mEmBlwG
	CbLndhsNXuxWDFtzzMbVpeYimAPomAjfWI4yGUReM723a23WgWWIHlsydffgL5xuVXqGvmuHbJQ
	oIRifYxP0XsjKXjCuFexDFJPLzZyn7/MNuDtKTZkae4cgLCvvBHS8Bh8qU8nVKHwyKFTg6pe0Wi
	SMPLOhZLUMPjWokcRA7UaI0zJ39MNUIxbWqS8F/4SQ4KrHaQm8F6mlV5VuAus07ZRb2s9LFDWkR
	Cmb84yy5HkFYMVvLiIs6myFGp2LCbMkG/3waNB1IQaFJ6zmItEWqpSBxAX1FrKP/I3lyubj1n3S
	ipVZDujjWgaQVOR248SFtlXFbQmD7txfE5axyT6HluqR17xgZEqAIwk3/xKWLc8bivBnlKTzLze
	9tqD9Le7R/U5cUoVCWDstAZDnrNnHvH6qESJhziBJBqgoA0wxyeVNdQsrvqNh8h/s848V8DVspb
	aEIJynYIg9P4Jzu8bfoEZkIY8Vy4SeN6SU6Hdvcxl6iYpAslkyJ0X28j+MKvptSyaaME2xC2bXV
	VtFEfUY5CrLAtmNdtMAoHzaaKb9CH/Tq4d/ixE4hTAO2b+EUO8hBNuQkv1V38DOz2zX+iingqTR
	Olgno=
X-Received: by 2002:a67:e112:0:b0:7cc:2152:4f88 with SMTP id ada2fe7eead31-7d7395cc4f9mr1199003137.21.1795193720050;
        Fri, 20 Nov 2026 08:55:20 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm3486193241.4.2026.11.20.08.55.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:55:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 09/18] profiles/ranging: Take the CS role from Config Complete
Date: Fri, 20 Nov 2026 11:54:59 -0500
Message-ID: <20261120165510.1858959-10-luiz.dentz@gmail.com>
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

