Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108598;
	b=bFbFW9DNdVcXRDmzEBa2mxyEwfP/diGN1MJhoa5honP5ZMm2zJ9uHIrU7mIcyoD9gsmj
	 3VJuIPUpuE/4OmICW7SKu3soiQggAXoZaR5+6sZiXg9XA65jmkKTcy6sDjBJvXUEa7pjl
	 8qDVaG48CM8x6jMGI0Lx6dmGSPnfVp8WSdkgYXExh1AF8tiQk/ooB4ip+mVy/eRKn/kod
	 7VYXdZn5X9jiEstFKJNVHMUcWRg39oxOWOI4TOAsPIDO6+EfkFIX8frhrPrG9+Fmh0NfG
	 jitNbxMxRi0cjuMWPocPTLsvtaKGf5Y2S9oWbmpJDHdkwmlsTew0j2q5r5GZIxlokqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PLDlFe+KJtEJ8cmsDPz9y6U1O+oz4FvnS98zgiDePDM=;
	b=dZdhB8x+WUp+lnFEfQAEjKJbR/1bUFLYLoz4J3JStbUGuq24zS7jxKqpinFd1dFe0jrl
	 kWHc8boEDO5uIIbtbbtRCw75Ez7xxHUbGx12nnpkX1HRr0wQnkAKDhnj3L9erNGgdZisA
	 tE+cfC/rE+PNLCtsGujGmDX6orMXj7iJX+ykFrNjFL9yIn3YPnvj9SKQrC5105IIqKioT
	 KrtXLwdnSnwdXAqsvIFsu1h+HMEFWfHp/WQsojp0Ak5GRPRLYdmCQmMN6hvExwj+2A4ed
	 XCYfVzEm1Tgy8U47fhBGxx0Aqi2QH5YzbnCD8W/13Y74cJHU2g6yKrU08y1M3p3UMOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="yZ/Ig5bc";
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F8F606A33B
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37F8F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yZ/Ig5bc
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so1134561e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108597; x=1795713397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PLDlFe+KJtEJ8cmsDPz9y6U1O+oz4FvnS98zgiDePDM=;
        b=yZ/Ig5bc+J+FWwqUktR3pvZ0IVYKW8OmkCQK0na/ETuvwg0j2MJn8s+vhr45VTt5s9
         t8n54qyMpnK5wLE4/qX5bYdodiOsH9R0b2KE0RxqnXVacRKyJ82MP/EkCjNR2EnbZlJi
         Q/yPbGRde7rFvFAWmT5hDwsZXZhvka1v3UAccCaII35pRBZDGTHU/T3Qu/48secp4Ue6
         F+xLnmUamDuCZw9X3VNTOgKqP4QBgKCAulTquhquK4C69N3/myuHE+S+3HtGxJvvQp8D
         oH1KMBlHfhJmsymeZ+aQIr6VdggsCw3pWLi17xjyO4CxvUQ9WuFweAk3e4+VpZvPX8Kw
         TUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108597; x=1795713397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PLDlFe+KJtEJ8cmsDPz9y6U1O+oz4FvnS98zgiDePDM=;
        b=kcTz6EGcOl9B87kfL5czG0S7FbC5jgLn0w9+kZldrA6GAPeHWMHrs02YHVJwod11s2
         OkNuL1Ym3WqkbWugt4zeQjKrWFNNi0LM4NgiENRbosAC6CqfExezV1NG0ECShR1vy5iD
         ZIqA5XhC0m5mxy7QLZkgG/gmrr+LLA0o137CdUQElOAEPiA0+AQm9zA2sWoXhGTC4NoF
         bRAS6U0xohbXNWAjoPox9P1N2M3iv7nTqyzpEEsNwS1ufsPQM7YqUD7iXXQszF30G5z0
         HCQFcUqqfLe2jbJCfbGgqgh2nNBztJEiTWUTZo9s5Oqr80Najsycq0nl+LrS4qckWXuk
         UKnQ==
X-Gm-Message-State: APuU4Z86vLrpbWGoxZofFfBrTr9tDHU927XqW9Wkp+C6zidtjAbnCJOR
	0Ru3lQLVkSrVqP2heLHZ2z6X23+oETtRviAbNFRjtupBXb0H2n0rhLCKdJyUfvcog/E=
X-Gm-Gg: AYBFou2HepvOJmEnujm1wSQLNeQvZO4sB7XKa02/13I/RHKpL1cDG2v3gcxVASTBQY0
	+6SVOHcgSiVopDX0TIwekaDGbpqkzcMNta21Td2hX7uVtZE1tZQke+jKq1f1irJW3nMTxmXji/B
	m7WXmTxuJaraVEYJT43qRA9O3BRv1vrXeX1b9t0QpwdRZ6gsAbExA/KGYIo1ELFyBzwko22KZx6
	Yix6cEYH5wC5s+mDz/6mFnucmNnlauP7ld7bZjA/wAavDM6hTb+jWB3rvfc5U3iqKM4Y5oNQdbr
	Aif0PodX0gO4ha3I93qedcYjcRQQ8PiYh8T189kpkgddp92gV6w5B+uzg9gPc0K5i7zxU1srPTl
	VipapFjPWuj70JV7P1KoMZNbZcupL1iyb4dFfCQUVy6XdsPKnGsMuIratTo3URE4a6uQVFZokvr
	rjJ23c+IopSfC9dZHO+Ex5w1mNYQWj6j16soL98eHE86bCW9N35IDJaRzdvrR8svxYohRHXp0qR
	zFb7ftbCgdjQ85xTIRiwgCBwYWW8lgqfrsVAvuliRlSIC6OiWdmgXJZSven6XWT9L9cW139uQ0p
	bz4vdRtvV/cePZdp3SrQl2k9z1eU1xAci051n8Q2ZZFSr3f+EHV4je3HUlxyJ6goqFIfHM5xnOy
	vU9tYK/jvogcQOW8oNEqodqZSO6JAWNM048ftpTx0lEAlmg/i2ZVHzz7m4Piz0KBO1nwXtwbpaw
	AA3sU=
X-Received: by 2002:a05:6123:110:b0:5ea:aedd:6077 with SMTP id 71dfb90a1353d-5ee8aee227bmr172048e0c.5.1795108597060;
        Thu, 19 Nov 2026 09:16:37 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5a8fd3sm131881e0c.8.2026.11.19.09.16.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:16:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 11/16] profiles/ranging: Keep a peer-driven setup from being rewound
Date: Thu, 19 Nov 2026 12:16:19 -0500
Message-ID: <20261119171625.1014004-12-luiz.dentz@gmail.com>
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

