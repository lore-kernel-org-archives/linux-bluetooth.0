Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108602;
	b=aaJzOyLCogyYXI9kpNY0nhcjWFmyVljGiIiXu4B90lla5QvQoJXM+hdLU+wuFqMLqU2U
	 7dQZ1doc/yDYII7zZZm9RGIz6p/Md6HZdvn7n30EytBBnW2BBgEcAYZ2Z4nPhEuonhvdT
	 vYv/XjbPkF/6j6esReNcAISFUUUpXCkpVhrWQGwv0NXTQcXQ5b/sl8SwMRqfzp8R0N4fW
	 aJKnt34YLV3LqGgbsl7nyCPVLfCJIfmSjFfE1RD/pjWy4OsdcrVCUjEkBw2jAWjHGTzKD
	 uNnYkqxA7s13mIrvrrjPmaPRZ5Vq/IOC0pVwdz4No4q5lEYBK7yluiNakAwjDf25lgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AtJxjTZNgO84ftKvVvjIcX3dl1Zwrzzg4A4Qa5HcUm0=;
	b=0Wbh+4S7xaJa6X9nsQxx6NQCe2F7++JnVV5jDXQPxLTkh2nvyxTSbymNHYDIYOyBczTg
	 RFMzkj7V5VJRKa/Mz2j9I5g/UI5bl1DHUqglJBe+P/hy5C+N258QxHdRDF4OTjYTxrXmg
	 I/qOgnldsjku2nMUkiOG9BKxFOxgKEAYohlLIfK3F11Ly9CuUPXMTejqECEYAl6oPqbeT
	 flhZFZivaRQlparIH4OvfntiTBpi4+PQzArPiAWsPM/QoTr/lXI5nwSTOmsFMeLi49x44
	 G8we7ngfSWehpTSXK1iSDZwyAO90EpFfsppsizDTGV2vU+/1nOJr3l1OrLZwum8E9Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T6DswpEX;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730F606A339
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2730F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T6DswpEX
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eafaeb8684so882769e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108600; x=1795713400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AtJxjTZNgO84ftKvVvjIcX3dl1Zwrzzg4A4Qa5HcUm0=;
        b=T6DswpEXh+suEdMQdkVUQRj1OQXc4SCplc4V7QIz5i0XA4DYkyBe1JSBq3Y+/+NbST
         UgXdLbgv9S/PC3m1ixVywT2TsRar1NfGbhzIJxaL2692Noa8ci/fnTgE9wdei6DdElsB
         kRCfJbPmdzqtnK4wsHfRAb8i0KkCKiAiD/raDhRePd2iH1wsotl/3J9ftbE12qTBM3u8
         hNJ2squyzpOtFuhZ8ODttPiruOPbwgzz5lSoEELTTG5iNql888vHEd+hsvwPSUXLyL1F
         eKejpktnL2WEijH1gyHhIk+Wjuyc9a167p78fRuRWg+cJOMd/XN5nl9jj7pnzygs4gx/
         edTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108600; x=1795713400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AtJxjTZNgO84ftKvVvjIcX3dl1Zwrzzg4A4Qa5HcUm0=;
        b=lJorUoHIGB3iu1a0Opghuluql7hGEq9DzZe2yGKozTQGjCll9zbSF7AwV+8PRUMLwX
         oTW0C6RXbHexzl9pOgdLPmSFeKrIbF6tDVKAyknuyQXxUU4qeOV3ym/o4rV2swhE85Uy
         uJ4AkSc+5yDufFOuZ4p1SvLTzAE1LQTAcyLjxawLeU4sVrhQ+q+tkDMTbVKotQiQNR46
         Oj9U7p8YFc8tUaa7YufsQ+zrUf//RFN8gpBaOqcGpvC2OqrXuJgnflfC07F9lNj+Y5Aw
         3EHkiF03HP/t2XMKcKswiKQn0MqG/1dnIFRVsAOc3coR+NIXGk2/gawy1uH7CWEaFwtX
         uOPA==
X-Gm-Message-State: APuU4Z98w1JmUzYZEQD6PXO8oQ62XS9bT3heaUDFGJO8qN3iNEgzEl2k
	a+ImE1rPyM4pYWGVgv+GMQLxMVJWkTxfE6heJHjjIA7mfk6OWcXytkB7DdzAS5qzVvo=
X-Gm-Gg: AYBFou1Tri9rjrVabEDHWuz2zwh4MPcg9WAtMnN0KgKhw9Y7BTAwDd2+ueabFWSgzJW
	giE2spiHUtItcuxd89ujDQkEc8vRdmQ+8IidrFFiE96DNeFhm/skAgOShMZVOhBTabPKVm07qKW
	/qEpz6rNBlXU3LSre7bLT2rtmkrVEoHT58cXWkaJzt58V/VEgl8xfJ/HyZTGf22zP1aR+3z70qb
	My00z7SokN2djpg5QRbAdwK5F+Rj3A8ZfTkX8AmZqA0o3Yf5RA9kJ+9gEcXAZC3sxSMaEqclJPB
	FgxL/3Zoeqa1mAxn6UXjCsijLRIH7jTiwPS2qzKvqGftUkQophEwTNa9T7in1KB4AmEju6a0VYW
	RZp6UiJjTBHrVIYhvTZVxtH7vw0fm6M+dqEXVVrxSFO7yw/oCjncFBqiUJGhTVXwTSJBr3OZ8Rf
	k26xkQIwmevW0Q/g8EXuLlnkPCbg/nbfhw1gAmw+k4FKvjtW9bwTC3OSD54OQkoB/KJt++MHEMN
	D0wWQYWzQpmdsy35V1H2+E7m3qRrdPtTXFUF5VsgDAbd4tAE8jYXWbkJOigxSospShfkQLHsAbA
	OHcTUxQtIYiC5FAQUUraEgaGV6O42qHEtUSHXkGBo/7FCWqoG4K/StF/Cc0q3QXHWBkDisFsFoE
	V/tzg15mbqjZkkvJzM615r9t/mTReKQWocZNWL12q+WWEvidr40td5m/s4d7c0RIJ0GZG5ysJcn
	T4WK/0
X-Received: by 2002:a05:6122:328c:b0:5ea:389c:51fe with SMTP id 71dfb90a1353d-5ee8af32dd5mr240908e0c.17.1795108600060;
        Thu, 19 Nov 2026 09:16:40 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5a8fd3sm131881e0c.8.2026.11.19.09.16.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:16:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 14/16] profiles/ranging: Do not start a procedure after StopMeasurement()
Date: Thu, 19 Nov 2026 12:16:22 -0500
Message-ID: <20261119171625.1014004-15-luiz.dentz@gmail.com>
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

