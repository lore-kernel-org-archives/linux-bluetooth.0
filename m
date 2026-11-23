Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456297;
	b=GqeW8AN0PuebkZIZFQZkB1b7TKlObJDRqEdyePPDGenCeeaxFD1Se02kyEUbsLYU+34W
	 5WPfGPs9ZxACgrqSWueBCRcNmE+3y8lH1o3AiRGKEZaRXIPMJ3zGliXZyXQaSTfLJMO/A
	 D0AiNP8Rx6OnDtiSSBmBKba/wwI8F9ujua0PaNGnB9NknNV8u5uxwWdAqfdTDDJVF9ej6
	 XCeouEK/R7kni9FIhf+p4V5J5pWMA9hjrFlhR0kAKBk8ClkgDVQN/kif0IR6BRGn0dsDq
	 GUJr6iUEAYAviV35wsM6Rn4MXf2UO+AsssW2QIyTHdHWr8j8RizD0gJvcIpDXvvY60g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PLDlFe+KJtEJ8cmsDPz9y6U1O+oz4FvnS98zgiDePDM=;
	b=rXXLprPA21uleGm3z0EPQ9Ivq7eFjxze6cedEXnqFEKWxxeZvtTaJOSiJF4sdRRj/Bw1
	 rXBuQUROpknFPH8AC5H4E9ixx16sunKVuawAYBzv/y/9NxbCu2mUT9tIGPhQIGJuCXtFO
	 suwBZS9Qw1o55TpqGK6JojQcpWAhgRbjFWCvq0s9Mv+5XpuU69+zVgaEf8rYN3XqP7wXy
	 0mjMfMacfXhJDrNFqSj7nt+vZ/5xqTnu4Mt9WjN3PyLFck+h6kpsoxeXbDIr3pexEgg+8
	 aWJwdpOJPFxIdA2hBGHFdAKgHvrjNkd5JJ/HFQqjlM0TBuoj11AT4neDu54Gc6WYf5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hwgaAJJV;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD41606A333
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBD41606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hwgaAJJV
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7d2d1b4a83aso1185097137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456296; x=1796061096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PLDlFe+KJtEJ8cmsDPz9y6U1O+oz4FvnS98zgiDePDM=;
        b=hwgaAJJV0l9Jc7gcX7KvPkPN7gvcOFaqk/1TSRyr31OqZLQ4RF50dch6Jy0V1jkped
         /6zfAoMMqzSihlGAJIlqqTRVqVWedSDj4MddoRTIb3RItWGZ/pjmugfnVzH4hHwHfv22
         Nz4SekiHqpKbtRzPtLLDEvpobujH2ZX17dBtz3RaO/qTu/JhN3SID4q5XxIgkG1fsssE
         si5S2hVMC08KbIn5Z4cM+4JApVft6XKHS2YXVyV297N8lIDNptvH5TD6FVTBx6G7BDrH
         IdoX40qWmFa4hNUnxI05kC5eq6QDHclEa9MJ62TwklmnY2D3e/b9TGHjvc5FmVFekjQ6
         wH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456296; x=1796061096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PLDlFe+KJtEJ8cmsDPz9y6U1O+oz4FvnS98zgiDePDM=;
        b=QH++rlggitG+Ph9lhr6gZBj572n1j58LwfSCKD2K7wO0kENSKCCRqtv8ZvEsVE6Smh
         Rtge+YxM0U38kaMuGe1XXwtF6M512TDDrEG8f0nJWJZfcF4I7fOGhlesQaGlsOccu/cb
         80I4PEkH2ctxf94tKLyNmY2GhA1Gq9BZA93rzwVLc1It4s0j61AWFwBARj7LGtA31u6B
         6rAWVNF2aA5SNm1/wEAvw4TvVpt0JbJpwx7yBfneHfOZZjN0MNRLapg2k5KHiMzwFFVK
         1y5xaYSDrCWuKzeLkV7r4xO6ZT2AAiBZ1bB4D3fe+1TbrkRAl+Ve+oFy1/WBzcu/m2eY
         HPWQ==
X-Gm-Message-State: APuU4Z+8MB12MOI4V4tsqa6Y2p9W9iYtEHRPQxG+qz2aMeD2W4mIutu7
	x+4ehtyycKvpMxxXdSARBa1iiR8Y96hQDDJTXZd1OHXESPkaLv5zHRpqXuSU0w==
X-Gm-Gg: AZFdTZe7SmcN51u0VOs2T0Jz8oSd+3fI5fHq0mcslReQff3gsJhU7PQFLUvmdNKFrAe
	2jNKx2wt7vRd7We1dHX9Z4YQl2khfRVSpvQ5ubZH3322zWySDBj6Whj1c+R1mOKUSBVwn0nQROe
	Il3EZSmj4lX8kz6Ig2N1KrIdj/Faw2gdmeEOa16nyqLDQZBIOibXsWDbbk0eeEQK5KUyM8d48J9
	igJRUjUNCBe4Y0I7/yYznNkNyLJ+Fx2L1NGZKDix56lmfkrQsQw1/1Ct1Vg0BFaar4BHVaHA8kc
	USqN9I49U9Sj2Ru6QGQNcMryaARrT/aoPx9h4znk7P6umMuayAar1qprIRhkD7kFPyrxZ+iEtwK
	aDECG2QWvDGV/2pGl1nf/hnIEW4qOasU2o0/emP92+ZumBJmEFmpWqapL/C0oGDXehl9CUbduJ+
	jL9A/G2CVBiLM3ybrmcAe4X9lkVgZIKG9hNrDhH+wumMJDK/KrXvCCewbW+igSn8dacou6SlVe/
	9OzVXRcqL6LNVFpNJZ0rUE7p0W3lnRMTLqGdDe2GLv4gzS2zk6rs4t5Dy/esaUbQgW7g10zPoHm
	ddttijAaq7RN15aOZJ8fDqHxGhmi/yliirU4hU38b/IKilW3t1Ef52VhAVvyTeUrR2xo3dr8Uz6
	CpZGNYB+71eGucRLCw9ynd+Jv+t19+mKEF7shg3/1pcdCw7oGeuOnuMI66MwSzErDJuJ2MYCTq2
	M1RKM=
X-Received: by 2002:a05:6102:6890:b0:7be:37d8:1567 with SMTP id ada2fe7eead31-7d739696c76mr6066643137.10.1795456295704;
        Mon, 23 Nov 2026 09:51:35 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm12795393137.5.2026.11.23.09.51.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:51:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 11/18] profiles/ranging: Keep a peer-driven setup from being rewound
Date: Mon, 23 Nov 2026 12:51:14 -0500
Message-ID: <20261123175125.3642617-12-luiz.dentz@gmail.com>
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

