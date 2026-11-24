Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534752;
	b=YnctjsNICyAdQPrEVpWed9sp5Ev7DBBLvrEPVlNd56EcuPUOKmuyZ6MJRnTtp0i+Qri3
	 m5gDNQV5Kg3gwq2OCyEdPJgZ/3g4ZJR6vW/KiZBwsDKqKu9V1x4RPjHTu9ly5ATQRSEUI
	 RfydQCy7TruQjWTyaMuEeiUY2aMzQF0t+rCfl0OBQQ7fPBkIW+pjT1s0HhSR3vRZptjyF
	 Tn+RnNCwHxhM9pM69byxfJUu+XF1VZ7lKHltKLgoy+kelXSHaS7E2OdREc8qauAmwTpo9
	 a+epNAKFfzYVGHB5UZba2miJQv/ekUmEZDlzINxX4CNLFdf0c+LICJqbxcgIkemt0Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AtJxjTZNgO84ftKvVvjIcX3dl1Zwrzzg4A4Qa5HcUm0=;
	b=LWu22L3QxZa1JTfiVM8QdMqbNp8hI0GL2XJpKKDC7hFb9FX1jJhnbI+JiVLI7x4qugZN
	 mN9CC5XPSaRpIcQ+X1o60hvZe7F0jTLnbrdtISQpUK8fMa5YRz+6y1moND3QcwnSJDmZr
	 WYpAX9Ch5iKGHUs8eqNkmO/9LcxegPuDJiD49J3cJzqZbaPmWvvdXWSI7xny+2Ap9BaVo
	 UZXBXS6TYZLW9XkUtXiru04En47ORgWqglz7gjCQR6WC0B6DX01DSrq5VxmjXdhnhBzgY
	 qDb0ig8L8+2QE8cAigtYCARRMu34nJsIrBpQ51BhOcvXdO+H3jCgJnmgdF61iEe2LPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gVgjkSfr;
	arc=none smtp.remote-ip=209.85.222.54
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E21606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20E21606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gVgjkSfr
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9905d61449cso1232582241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534751; x=1796139551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AtJxjTZNgO84ftKvVvjIcX3dl1Zwrzzg4A4Qa5HcUm0=;
        b=gVgjkSfruz9YVDZMyjHfUQvWixGJCbRwXSWwfiGdCZuh06sYb4kr8/MQ2brsF3Sl1+
         u4I8eO7LSQ185Gq/we0RkK3uPFmrwQ4Zylfi4IMDbo+EMJ09VwoZQkKqkuAdbbUnKjDZ
         Rs1i+yIMdhjOyNlfKHoqjL3sReHn+S++3mGk8YyRhymaPECZQZDfYwhLu6uz3CCONaIT
         uSxa8ikdIkLyTQEqTxsHcFFNsPAVyQk/Ry6O0G/A72Yc9+G46haa+NJ5CU2EiGJjzQ4/
         y+5KEbh/+NuR0fzayHQ6qHrlIc8WKM2YuPco4QTRrbNQVPwR7+qkCsIaw7777U1i2ULm
         q+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534751; x=1796139551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AtJxjTZNgO84ftKvVvjIcX3dl1Zwrzzg4A4Qa5HcUm0=;
        b=ncc+bYN+g8FwWxWOGJVggnrqPnZYcpJskIX91rsEN/MM+NZXiu+GrHg4zZQfyMu7ZA
         Z5q3ZiCYiT0AlRwD5Lwm/wb5AO5n3/+kdxl3DBf4MqvjkPpxV7wN/tL1THpWqsHGo+dd
         03ls6RhwbzHL0CdRqUgSTPa4b6sS+j18chRUN88lV4iNCLZpjKNajPZqoI6bItqfdr0G
         YgiTw8aBpjtg5v3cT0DUUU13anga9aB4FIWNLZ+b1vqzDumebIYCb70VEMUhZDN0WkL9
         Rd7b1Lfp7LEBwSZbt1ZMU2zsGuoG0bmgjsYESAN0afqmYPioheLVrNcMay4lc5pW4HT2
         Faag==
X-Gm-Message-State: APuU4Z9ND30Eadh9E1hS24eugXUm49AxCbvWu0aleBqfsvX7eHjWi74z
	QBUqvDXVmQBtuScEwnCUGWW4eHsTr2g6gOiFMcgJc+6wfvp6tIvFgC51/aQwRw==
X-Gm-Gg: AZFdTZeEqAfB1oV0ml3lN3CO7iw1R3LR3xTS1YwXP2DrFXmaRlkfOkTvtqeYd/tuGci
	jG2oHh3O/AsBwsUvxy4fQ7e2UghrxMz77oYjKCLrmLuR4RNPqP3ycYbp74VvxdRQmdxCtuMX8Av
	mdutVxHv1bn1DsMkiWugtN1N0jcsWUx7IvAq2OSaA+P8gJ2Af+gzCOEP2M1WnAuQqTvBpFYn5pb
	APP4bSgNoCoPNHKJIJOA7jSmmbBcYuSzxNDfa213lmDcXI64pX4bMBmqu4E/pZ9u/wV9xd/G12z
	4v4Rpn0lwWHVe7KD+J2y0+vQ4/p7zq9wtd8fcxAwmQ3hCBN9EYgGSvIsoQ8oncEZkVGZ84LNgOw
	+4ePMd9xvvnbdikyF0mp4qoU7yI0ZDtNYf9ib1zUgN9YbJ1rYabuys8Ec+ORs5z6o5o8oyFDhwm
	1klEUbP0zGQUUC7IELcWQp5egOUoM6CrlzEMVcSoU6iXiuknZ7/CbhsTn7z5pEriHonxjlMxirn
	VAQHNRF8cuJRabyzybBYBbDFMS9f2muK/ANfanhXOlucKVLOlFDigRxLKAyeCOTyYVmX9mi4gRb
	FETkpqBj/5k4N/mCsfhkbggpx3DWat+RLtUGP6RrPUQgtvdpTk4HJXVu4yoOjKcnkEvezqVeNip
	wo8SDG0LONBb89qBc4Gu0yXEbibVur0LB6MFkuicLUoCj1rq+6NKipTzqGVFnl/LzhTWeER6pNK
	3l9SCxf3UOJhTySFdvxtaF9Dxd
X-Received: by 2002:a05:6122:1784:b0:5dc:d0cb:7d74 with SMTP id 71dfb90a1353d-5ee8adf3de4mr7863605e0c.2.1795534750949;
        Tue, 24 Nov 2026 07:39:10 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5564a9sm14343463e0c.5.2026.11.24.07.39.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:39:10 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 14/18] profiles/ranging: Do not start a procedure after StopMeasurement()
Date: Tue, 24 Nov 2026 10:38:51 -0500
Message-ID: <20261124153856.216054-15-luiz.dentz@gmail.com>
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

