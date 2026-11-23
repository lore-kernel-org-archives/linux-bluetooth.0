Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456299;
	b=V2fHwVWWuJPx19aRPHmRShzlPM2NqbppkRlQP/fJTWwTt4pFs5tXg5XBHUP65SSV0fx6
	 i1r7oRvqjvIMaIU/TgdV3IwdTuQizLW2GW8vJC2e3gMV/nY9emcOSkovlim7q7NpV/ES6
	 mLXfTdG8gSHYqNwc1OCbC4bgsgq8KLv4/s7fklmQ0ZCzAgyXnaH/anpM2gQQSWQ56Vl/a
	 IWZsbGuj4CsR8W28UBKgq0OpdeAWAa8FjYahRyXLua72dFV+ekAX9VMzq2C2jE+AD0S5s
	 UD68JpE2dCSFbH7TjQ+TZqwJzzpg/MXqY/9nZWyvLhSCGIQMUHYv4WpaVs3egV22Qhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AtJxjTZNgO84ftKvVvjIcX3dl1Zwrzzg4A4Qa5HcUm0=;
	b=oz+u8VYMDbwbCJUgMssDayn/G4I8GmxoI7D/JiL64VT//MGCUQBXRT3EdskF3H7/NCG6
	 BBLEc3QTcjxNYiQtpXWXA+kczz5s2h9t7c8CwBmjqbyPbi8ka/7hpd9Gs4Hzvy3n+txng
	 8lgCuRH8SlLvvOcL34GXzbAcIDSmHxwuIGRFdw9jGmKF8hJ9qjSyGCdO+YLbp8zUM27R5
	 clW4xUAizduHHXxKkeOjIeF8pjbI/0eLuoYOb4nWhOucwtswUi0FvASeSFB2VlwfzFFJA
	 EWL9rS1XyY8Dpig7Puit1597Ie7ntzMVUL5omYCYMiOPjAMA7UfFReb1o/gAEBLUQTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x03bFEpg;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9AB606A32E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A9AB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x03bFEpg
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7d2da166818so2186079137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456298; x=1796061098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AtJxjTZNgO84ftKvVvjIcX3dl1Zwrzzg4A4Qa5HcUm0=;
        b=x03bFEpgPR8WvSsGsfXi7AjtDF2D+0InSQy2uhRrdS4WbDcpGIIggYC7eX+Gm2gAQG
         ZXdUKtLKu7ZNdLikN9cNN39Y6QAXTmmMydqTZdOUG291+Vou7sLP5qyo6qAAf/NrIbad
         nKnn8+N7789cy2ZySHFfHKhFHiCeDikMA6PZyRVwvqZjLLhBTe3RHeUrHSHQFV5x3KxK
         h44Pn82uD2Ay6OAi4aAuLJH2KahkuZDd4Aslq3yQfvZqiSbz9L0H7Y1zAvirjZIimLVi
         7NiPiFZLbpfLSwYKYD0gDL8ODd4XwGL1LPBc+Gu5b7bE9Hax3ko5XhGc6r4CRN2zPjet
         ZuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456298; x=1796061098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AtJxjTZNgO84ftKvVvjIcX3dl1Zwrzzg4A4Qa5HcUm0=;
        b=caoeYTK0B4Kl4ihv+MaNd74a7SUmLwMbo0QRVjnIqRcrBdlt/3ahMPAhN0nb1nWJ19
         Vz8Q4kbDAaJV1/ZP1LkTpEne45A1NOVTtSCm0c9UaEiaArpQGk/CNgv+1JywvSl3GjIJ
         uu9Iqr/FqDIotHJ+ATHDDjhYkZbExe1TbLXoG3JmxO1di0MUOpjcvDQOHFTVthyIjktV
         quqviSQs0SItBhx9dDiTCxfokmY8W0DoKA5V44sF+uJuHqS3WgeX2+YybupbM3t0BEC4
         lcvHY/c35raAR8G2T0E24iHS/kArzVqIy/bnd7miyQo2igR6pNjiZFUQXEASQO8S+r3b
         7L+Q==
X-Gm-Message-State: APuU4Z8XulF59olQuoet9Yrltko6j04OsOCs3UzGuZNhZxciFHTRDDrv
	YAB/A8fK/LBObre1wx+Vh8awmiVe5H1vbwCVJAPSldMSWUe/0JsgSLj73KuK6A==
X-Gm-Gg: AZFdTZe3UfNd40C4LpcEqMsdqXd+HNZEvNqq6hs5G3ZUH3oqJ7nwXNHj5exeZ2m1zP8
	blpdodvnaEullA/YpQjAmBoWCdgfFPIqjmkCHqCkBpfc1N/o7GY1dYGndit6++RlNQK02aplAU+
	FhZNrLqTZR3efHgrMQfXuEQ9TvfccMJGap7rPGjZUVUXblgtMHPFsU7jEE3GWP8ARDpHxLK0tby
	CtyjfQYpOs2lrc3wtD0Cy2VaYyJQgOSh/lwuOa2Z+VSxx4NyDR6svKh4ArKDuvDhzLWk5AWjPKa
	lr0chcZV5sSNIrIniqB7ILG9c5kcRGOnhiTrc7MzEnXgQbrEblaKVo1OLDqLqhwbY7TMYzwOCxK
	NYo6Db0BNbyr4VIxhQTEIp09aMPF/UviRhZIovAXhHd/3XhFHtor86OdaClfC+SZJuyp5t+pIki
	dnwEfjTYEu6k3Mf7fuY1Kug/Gi7ICePdTeLRA0zte50s8bRkFBlH5POuTeOmz6m0vvkTBXVAweG
	B/V/DLrGLpPygOGP0jBcYK19PNCDCT2wMXyk9iLZkTR/Jd1UtmVSoXtu9B3VQOqrZLAtClKjiiy
	c951QpF1DHS17hmdqPvPIDpBgWfDe9VdwunKNCErW/SysP7XB3JomhKrr4j0O66EoFrE1G1KYBh
	7YA01Iw2MgvHy7k9SLkDgsj9exhgzPOiHW31eiYoaBd9MGJsTOGO18c1XftfenL2Ftu95Uua8p5
	M2YZQ=
X-Received: by 2002:a05:6102:cd1:b0:7c1:9f20:36ad with SMTP id ada2fe7eead31-7d72b3585a3mr6805202137.2.1795456298011;
        Mon, 23 Nov 2026 09:51:38 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm12795393137.5.2026.11.23.09.51.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:51:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 14/18] profiles/ranging: Do not start a procedure after StopMeasurement()
Date: Mon, 23 Nov 2026 12:51:17 -0500
Message-ID: <20261123175125.3642617-15-luiz.dentz@gmail.com>
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

StopMeasurement() during the setup phase, or the measurement duration
expiring there, found no procedure to disable and returned without
touching the setup. The pending Set Default Settings response, Config
Complete and Security Enable Complete still arrived, and the Initiator
went on to create a configuration and enable a procedure that nobody
was waiting for any more.

Remember that a stop was requested until the next StartMeasurement(),
and while it is set do not send Create Config, and do not send Set
Procedure Parameters and Procedure Enable as the Initiator.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap_hci.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 6181bc0f12d5..8dbb6b847c11 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -73,6 +73,7 @@ struct cs_state_machine {
 	unsigned int measurement_timeout_id;
 	bool initiator;
 	bool procedure_active;
+	bool stop_requested;  /* StopMeasurement() since StartMeasurement() */
 	struct bt_rap_hci_cs_options cs_opt;  /* Per-instance CS options */
 	uint8_t role_enable;  /* Role value for HCI commands (1, 2, or 3) */
 	bool sec_enable_pending;  /* Security Enable deferred until encrypted */
@@ -565,7 +566,9 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 		/* Only the Initiator creates the config; the Reflector waits
 		 * for its own CS Config Complete.
 		 */
-		if (cs_local_is_initiator(sm))
+		if (sm->stop_requested)
+			DBG("Measurement stopped during setup, no config");
+		else if (cs_local_is_initiator(sm))
 			rap_send_hci_cs_create_config_command(sm, rp->handle);
 		else
 			DBG("Reflector role: Waiting for CS Config Completed");
@@ -1271,6 +1274,15 @@ static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 
 		/* Check if role is initiator */
 		if (sm->cs_role_known && sm->cs_role == CS_INITIATOR) {
+			/* StopMeasurement() during the setup phase had no
+			 * procedure to disable, so do not enable one now.
+			 */
+			if (sm->stop_requested) {
+				DBG("Measurement stopped during setup");
+				cs_set_state(sm, CS_STATE_STOPPED);
+				return;
+			}
+
 			DBG("Initiator role: Sending CS Set Procedure Params");
 			if (!rap_send_hci_cs_set_procedure_parameters(
 							sm, handle)) {
@@ -2035,6 +2047,7 @@ bool bt_rap_start_measurement(void *hci_sm, uint16_t conn_handle,
 	}
 
 	sm->active_conn_handle = conn_handle;
+	sm->stop_requested = false;
 
 	if (sm->measurement_timeout_id) {
 		timeout_remove(sm->measurement_timeout_id);
@@ -2074,6 +2087,11 @@ bool bt_rap_stop_measurement(void *hci_sm)
 	if (!sm || !sm->hci)
 		return false;
 
+	/* The setup phase may still be running, with nothing to disable yet:
+	 * keep it from creating a config or enabling a procedure.
+	 */
+	sm->stop_requested = true;
+
 	if (sm->measurement_timeout_id) {
 		timeout_remove(sm->measurement_timeout_id);
 		sm->measurement_timeout_id = 0;
@@ -2155,6 +2173,7 @@ void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
 	sm->cs_role_known = false;
 	sm->sec_enable_pending = false;
 	sm->remote_caps_known = false;
+	sm->stop_requested = false;
 	sm->current_state = CS_STATE_UNSPECIFIED;
 }
 
-- 
2.56.0

