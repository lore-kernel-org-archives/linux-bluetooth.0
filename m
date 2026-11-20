Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193725;
	b=mu4jwaEWLOLqa+LLANm8866bLu6/oG3njbiwWE0pgG4JVwe7PuS8AgESHSzflQ8ZOfC/
	 /JaipCJGzKmNt+IN0Qz/BvMiJC6MRC82uMR1689BEFTq4hP3C/Vl3R3SUtWVps1hpEonR
	 2eImG4u5aGy/in9Jcdu03k3s4l52iiKjAkpP3BJFMvt980Zbv8MaiBGHxCZrP0bdBiscC
	 /3iYtV3LX29h6iC9bCJBNltC6wphVneHjQjGC7E74Fe0MMgH0Svlda+KD/lmZXp9HJGM5
	 EOUyttaYm1Olih0AO0L0ouEcVmduf7RPTNwY7fAykXfsetefl2Mc2sAVCd+8srSlGKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AtJxjTZNgO84ftKvVvjIcX3dl1Zwrzzg4A4Qa5HcUm0=;
	b=xsZV4Q4/wLa8HdWj8higvhPSTotMPJ5xVvZPATEA7b6+jk2qv/Lx2fIv9tyO6PBxcKMo
	 wiCpy9TvKlzTcAgvtt+Q4qLxaYNl74Iytp9ROWFslOAROK4MYwBWk7rWixGUZmP0y9rlD
	 wQ2ENiw3YXokIaYUuf5SSOvHG1k/QGgv5jUT91P8Jx39dS2g+WjBjxugzdbJDCqBQiNPJ
	 aFtC/kEiJNKvUwZTbtR6z9/ZcfYOLVw96b1vEoFd+ac0KgU0JchbkD/RNk4dzuuFPNUze
	 i7qOlZIlTuWQcQdodqtDzsBjK5vtAnuDdMGcCUB2+5A3BQBUAT7No6sss0z+BzZ7HGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JvUaOZc1;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2881B60A2611
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 16:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2881B60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JvUaOZc1
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7d2bf046ceaso713387137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 08:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193724; x=1795798524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AtJxjTZNgO84ftKvVvjIcX3dl1Zwrzzg4A4Qa5HcUm0=;
        b=JvUaOZc1bBJm+EhytSG5NfLvpLFMHrJhpiZ5eDVN9MB5yxD1+5s2kEdAxfvJ9D1C7o
         pbXJiGGBqzIFhtOeWUy0pD+awXUsOZl3hiscngLpkuS0oAKjadcrvxvHVPPVnIacK/6R
         YqTHGMrVY/KCABUatVrsSOOOeStwPXHLVBAL2Zw9Mr/rbkkeRfiqusbYRihcmb54vm3c
         DYV/ZhNxwjNZz0HXkUXLgH7424u19VMutbNm2MwFJqvM4QfdMKMNi0FBffH+XnLUASKb
         Ys0cGxZ4kmDPzGYUqNlDLsdepBNuj7yynApujSpIx6v86V8alLn7FkE3eimgMchIMXF7
         DViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193724; x=1795798524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AtJxjTZNgO84ftKvVvjIcX3dl1Zwrzzg4A4Qa5HcUm0=;
        b=PtSn2QrNbT69II7sWOqrNz/aESulpVMr9nRI5RmoQHwnFgZTfsqjV4yhej3LDpaz45
         j9jSDgIYBkEyyfHXErwSvOKK2BGSquObq1gSK9w+SJey2Gr6oCK1RaeaRbaHKb0O8CeV
         yZ54CczyTb+SvxvmSfx+ixQBTFCOQa0WYZpewkosgFwVujYFasW8ilEH/cuQSe2LJKgL
         rIyi2pBkXfGZTZtny83M4XgZEqt39/4Xm8CZwLQah/BHBbbyhqZ3ZBrUaqz/oZcMwvHk
         Ba/bD7rHPgGCcCXIpdoOoITDAf7komQ068Lk3doQH+54EoAJ42u3uxCGkm/tNuS9FaS1
         7kZA==
X-Gm-Message-State: APuU4Z9pU0KflXcynvPyX+zZKA+NC1uNphsaSE0Ac2Ls+tDMzXRVEgdf
	jjHEi2Wdq7LGGcAvBDIAROw9DVh0OTxrwe/oAI84RwriHaDdD7lgVqUWxqLh746y
X-Gm-Gg: AZFdTZcskn8KGFUEoBL9Iw00GWm8RolljJlcQOEtn1uebnMnU8eMb2C3bQ2oa57VtNN
	bsX5jPbwbSD0TEziBBFR240bauTeABJZxQU1U1MpztVPblUF6XOTXvHsswqOBRrudNfpkFRZBzz
	EO+05t6ZP1mEOc6SmNvlMrbiEE5La056C2Qrxv+2Z6ZdjoTmlVP0FreJyOFpjAFSgrxg+H1xY/q
	eXGEI84GkJwUTAryHWstGcEjXS3nkqJLyq2xcLrxHQFo59nKzuPTHbTucOwpTbaFUEklRcEuOux
	MGMdFsCKh1M7W0AUZzWTbFf1m1JJMB27M4ZUbX+G2Ij82h1ffkeMfLPCVDT3qimoVYn4VC+V+1J
	JHsbCr/fMeYqap5As3O2wYdhYJNgTcA1SL52p6Z40ytxdeQ1tNae43tAod5rn8VaPhTc0Xx91Jk
	1Lfb6cKmqPpd9UPk4LmgTF+tstjPIBB5mXtoQzTB133cj7MxgLPZf5P4uyZu5YkPN3oTiPjGPgs
	YjRDAZehHRs9Gxl0x3Oth3bbW1EO7zcc7NdlVkd8x61K0c+COY8I0gkSFf8eD8d993+wffPvqnR
	gXpVR+UEOF+WV5G5fW8ZkNCG8J60Y8K/Z7/CetygAPClh3mv4izOVwpY70CLVrw+hUX6sSF7QTy
	cgoPgZmgDWvIoR+B50OKL9YGEOy/fzbNxJSXGdIiFTakd6cvOSvKjFmTOjalC2gFUyPLg9tmlSK
	sUEec=
X-Received: by 2002:a05:6102:54a2:b0:7cc:3246:3095 with SMTP id ada2fe7eead31-7d739688233mr1968508137.34.1795193723781;
        Fri, 20 Nov 2026 08:55:23 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm3486193241.4.2026.11.20.08.55.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:55:23 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 14/18] profiles/ranging: Do not start a procedure after StopMeasurement()
Date: Fri, 20 Nov 2026 11:55:04 -0500
Message-ID: <20261120165510.1858959-15-luiz.dentz@gmail.com>
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

