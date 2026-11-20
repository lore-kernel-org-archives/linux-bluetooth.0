Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193723;
	b=c726qeny7VNHZxujXUuEi3KS/abi1717UbCHrQucwFsTpPlX4nm7fVy/juVlRvGWbOns
	 0TF2GhCj1JmDlIRsqkP2yBxIRmg1D8TmeOdclmyblQ+PaetjtJMGaVLjY3s+1rMewNRFO
	 AiP1lYLIbqH+mb5328G+eszvoIJX2+1rNEoGBnVMie/YvxnymViE4aYVhKM5aXu6+oy/W
	 44HZSYAw7j+d/P4TTQi0OTJpjOdNHMXWOvdGTeHZTKS4ZBLdff7ndFKoYwjvt3CqzzgZ/
	 dfb4lsu9HBJXah4ljBciAD+rH11F4yMrr2irxVKHXO0yvqUJbL67FBynFSP2c7/8gsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PLDlFe+KJtEJ8cmsDPz9y6U1O+oz4FvnS98zgiDePDM=;
	b=XyO5GXNpMC617MA0O8sApnDv1K/3N++4q5mpKP99QKPdnjbXRoarX7t0mSTbf5wKPIQT
	 UAjr6Iy57lZCHreNp9Iqn7O6KHzrcDFfBRU1tEJhHtRPS5ViWinAOutJEA33jpqwtHiXi
	 GCXZ2/VBegjlMG3REPRHVnurctU5Vxp3HYdoCfbOBmreqbnNCLgjeGOgu1Iqpx1pgOXZE
	 s6Dk0h9MYTuK+jgEp6/2c/S6YqXpY6V8mgzbx8GOkL5Gm9zOv7NCcoAkS/rnTYkVUztkg
	 QJAYgnADbskHgPw9c80Y2toGoGbvVs1cWWl7fRNDOFYZN55iGHbF6XDhKcZDqOo0gmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SQP3SYKc;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC89B60A380C
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 16:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC89B60A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SQP3SYKc
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so675314241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 08:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193722; x=1795798522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PLDlFe+KJtEJ8cmsDPz9y6U1O+oz4FvnS98zgiDePDM=;
        b=SQP3SYKcxf9ljL4ajgrpO9FdKaHF81b9TWwVP4cgPSaziSZWhH0/Bgjg0qt/7i1fNt
         C3zEHVKzbbYsbpFmaM+F0FTmtahUDB0lbp176OrmwG01+Ig59lIP6WBRqKonOTtTd+Bo
         mEsSCxwnryOL0l+aOg5dXbR2iPyKel/BCywK5YMq7YsPRClfZFU0bnsOfFWvYefVRgjV
         QSX3Qn85UiPbZG+lZT3nxWj6bKwnEj1uyxJx/XZyXdkeYBCb4MRHlkA6mwpV9zmQA37J
         +1qJHy0OQXlaoAoim3hje6GSCw+5CB6EfGZXaWbtLuSrjW9CJw2Ucw0L5e8Q51nZOIxn
         5Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193722; x=1795798522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PLDlFe+KJtEJ8cmsDPz9y6U1O+oz4FvnS98zgiDePDM=;
        b=alPYouE2XyY9o91PNnLDfXpj/RpeL2ZBnDicjpOexBkZlWQzad8IKqshRO4738P2VS
         kEA4CIrYHTSA1xdhsubMGyIewZFcgGIOvEpEEqSX6FlVzjjt/hXlHmIg90ikT+V2AuKA
         0+QUo8YSbh+evUJLy7VMIwanpGCDMxt8S1jv282juZc8HpkbtBAdACpI3OyASzoRjqpR
         MxmZJgH6ASM6QFrDeGyUt0LLc5XHvC6ygpLUsu8JTZFUQdzqKyu4kxNGXYVN/IbnlDKu
         39judwIQlXZPqfNwCWK8u++mb5nNhtUjL0snSH6+EQnJGhf88TKVzthBpWkcn6vQQNtQ
         /jhg==
X-Gm-Message-State: APuU4Z8NM6iarO9c4mfG7gqz/lZeO9mBlaKo8uMBiaDMgFHbCcrTDPpn
	H27FvMerpNhZ+kxniBXEOX71vVkRJcVCJUH/192hadhD/19BSYHwROmtU4xCcuBe
X-Gm-Gg: AZFdTZeFO+hYp1ZBAkbGduOcHmJKUZhmqwyNwl/dKihV8R9YEnECLet8+7y4a7hUR3P
	3WJw+gc+AEbRrBl5YZOe5/6BcsHbJAjRpsYYY3e6DFBzcw6d3E6wqGwHquQV0PFrriDYY9URhp4
	GCGrDlZT/ZEPc/yz2eCGzUPUx3CCYRz23oIK5ldQB/7axKbC2c4tg4zlplJegCFUVrHdcVr/ikT
	xZhszx6MY52GpMBRhx4eL9zuV47jxkoWwo8il1xoudNedaLMDQDm4i/2qRKdP/XvumWzh8Ps/sx
	y6DplZKMuahLBvRzAS5zB6rrtw95tn/ScGKrCAZX0FvtlvO4nXg2tjDze27vowPFKSkPVAyVKVe
	WUWx6g79iKOUSCrukUS+lrv/evIjJe1bgk7EETRTjNG6KgpMd3CuT1H2GIqCGDHdCf9vzNjnqTY
	gGc3bh9X1goC7K2339gCDLds5Tt6YVfk4UDyhi20ElJzMNk8brqbdh2V5YuADJ8CZoFiAe6eRKf
	BrCMoG+hXaYvMi7nwIizD91G+KZIiD3DbltZZlbip5GJYsU74FU+awo3fNAHr0VEkRgcUwjTu0o
	25RINLrWL8S7VPx4EI9VsYwdL0zQZWD31IS8I/i+48kkDaPkFW0LEBGRHxGgN+dsFBsRhFrQYZJ
	1B3J8E/WqAzkseNYv/Y8M8EJFHvUAyWGFHea5JDaEnTqVOu8tif0OBNnPXkd0qNZ8kQ==
X-Received: by 2002:a05:6102:1627:b0:7d2:8529:6892 with SMTP id ada2fe7eead31-7d739390113mr1774497137.11.1795193721410;
        Fri, 20 Nov 2026 08:55:21 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm3486193241.4.2026.11.20.08.55.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:55:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 11/18] profiles/ranging: Keep a peer-driven setup from being rewound
Date: Fri, 20 Nov 2026 11:55:01 -0500
Message-ID: <20261120165510.1858959-12-luiz.dentz@gmail.com>
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

The Set Default Settings response moved the state machine to
CS_STATE_WAIT_CONFIG_CMPLT unconditionally. A remote Initiator does
not wait for the local setup phase, so its configuration can complete
while the capabilities are still being read over the air or while
this response is pending, for instance when the local Controller still
has a CS role enabled from an earlier StartMeasurement(). Its Config
Complete now advances the state on its own, so the response put the
state back and, on an Initiator, created a second configuration.

Only advance from CS_STATE_INIT, the state the setup phase is in until
then.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap_hci.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 91dea3d91a9e..7f82bbafb2a5 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -458,9 +458,6 @@ static void rap_rd_loc_supp_cap_done_cb(const void *data, uint8_t size,
 
 	bt_rap_set_local_sw_time(sm->rap, rsp->t_sw_time_supported);
 
-	/* Transition to INIT state before reading remote capabilities */
-	cs_set_state(sm, CS_STATE_INIT);
-
 	DBG("Sending read remote capabilities for handle 0x%04X",
 		sm->active_conn_handle);
 	bt_rap_read_remote_supported_capabilities(sm, sm->active_conn_handle);
@@ -537,6 +534,16 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 	}
 
 	if (rp->status == 0) {
+		/* A configuration created by the peer may have completed
+		 * while the capabilities were read or this response was
+		 * pending. Do not rewind its state.
+		 */
+		if (cs_get_current_state(sm) != CS_STATE_INIT) {
+			DBG("Setup already advanced to %s",
+				state_names[cs_get_current_state(sm)]);
+			return;
+		}
+
 		cs_set_state(sm, CS_STATE_WAIT_CONFIG_CMPLT);
 
 		/* Only the Initiator creates the config; the Reflector waits
@@ -1826,6 +1833,7 @@ bool bt_rap_start_measurement(void *hci_sm, uint16_t conn_handle,
 			      uint32_t duration_secs)
 {
 	struct cs_state_machine *sm = hci_sm;
+	enum cs_state state;
 
 	if (!sm || !sm->hci)
 		return false;
@@ -1842,6 +1850,22 @@ bool bt_rap_start_measurement(void *hci_sm, uint16_t conn_handle,
 		sm->measurement_timeout_id = 0;
 	}
 
+	/* Enter INIT before the asynchronous capability reads, so progress
+	 * made by a configuration created by the peer in the meantime is not
+	 * rewound by their completion. A configuration the peer already
+	 * created before this call (Config Complete does not wait for the
+	 * local setup phase) has moved the state past INIT: keep it, or the
+	 * events that follow would fail their state checks.
+	 */
+	state = cs_get_current_state(sm);
+	if (state == CS_STATE_WAIT_SEC_CMPLT ||
+			state == CS_STATE_WAIT_PROC_CMPLT ||
+			state == CS_STATE_STARTED)
+		DBG("Keeping %s from a peer-created configuration",
+			state_names[state]);
+	else
+		cs_set_state(sm, CS_STATE_INIT);
+
 	if (!bt_rap_read_local_supported_capabilities(sm))
 		return false;
 
-- 
2.56.0

