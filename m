Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534750;
	b=ZzBJlWfCnajm0XheVkaQpiTkvmOlTwS2FcLK6ms+G8sz8Ek0HgCy1ecXX377Tq37soip
	 qis4Z7f2+KovG414IWQ4SsKw1BJFwur64JsIbQzdj5Sh3EYmeBHe3f4b/Kdh2qeFle1PO
	 WBtxEQZ94OqNZ+fuNlC14nBr5ppdiNGR7SxfCtf4iJXkJRmbSOos/YyJPaLZDLo42A5Ob
	 ihJzwnlLxI9HpnGBF3aRlZ8fizZ2za/9OU6fy9uUF0dqpTRcTDBxfPIpHse6AJK0/mY45
	 x89PUPLEwXr6cIfrrDzjNiwsYL8FGc4qszA3KkDUnfn3p7N/UzgAwMWtrH3I5s0Znog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PLDlFe+KJtEJ8cmsDPz9y6U1O+oz4FvnS98zgiDePDM=;
	b=wqHWoyDu+So7AavSvWMQ6fZlI/Ztt6EcHeSCdCtMTKxJnwws22UwWocx6mxYHhnY6wIb
	 /mi7VngAzQw4XhWbsTdw5J/arkr0yoIL21tQ7O9VNMp8t5ZFEz2qeh616xyb4XHcaIVgH
	 jfvrFA3R0VGt9HEBk+LeAzIEY4zYGCZgDU5tmHbo11VGIufti64RhknXN+U9wm8t3PjAO
	 V4vp48/Fr7yBYzGkzT0EO4e5JQtDaabalrbGHFGCIuY1jL7KUEkD9xKd9RCXjUbcPsLvf
	 7M78uTNaW3tJ3MN2zO/3Xp7HpnLhJUqzJQLKhUZvVeKTaIYf6QZayqMUuoPxyH0IQfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tamdfKPn;
	arc=none smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD40606A331
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFD40606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tamdfKPn
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so3168385e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534749; x=1796139549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PLDlFe+KJtEJ8cmsDPz9y6U1O+oz4FvnS98zgiDePDM=;
        b=tamdfKPnalCcCt6c6MCBpDZp1IPUFWDC8n43QPTcbK+/MCjYYNiICygx8XX+pJTzBX
         0ASrsShhTuzXNQLjRSmqxm2E+IgjWb8QaK8GQfQt0Tu/0TfjVbWY+y6SQRAfrbwit8iT
         bladGCvsWgXJGqdVbPcqdqYgB2eBZlHJARknSZqDXG84Ih71QBLCmbMG8Zi78osTsctv
         Ri1KEOVFUR8LLY1U6OCRRyDu1rN86SXa3DUdAyg0HoCEfZ+5moFz5PAmVcL0RdYWRU3J
         zen8A4EuxJCVTf9qQ5URDwAOtw//hDFFSf1j0rbjPYw6qUfYQmh2G8TjcUxngxrf0VVu
         GHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534749; x=1796139549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PLDlFe+KJtEJ8cmsDPz9y6U1O+oz4FvnS98zgiDePDM=;
        b=MygVNANbsJSnUXEMrVljSTKImaqB4JHosROK1HJpaCzWB5yUwtnTgiPzaPz1Ug+vWU
         Rehl+OXkuAngun6DOgSjTCZJczTXpiLstPj3GaM8fYYJfjO7iC2ObQ1OjttLHBNHGRO5
         l9snu5rd80QEzExjYqUK1gsUC2KhQPHPy31c3R+0L4m5DCgDemQqOzD5YjEajPP9nD0p
         cxnatCAwZRbxQd/ULuH+4o2LITL7BoohvFXc3TUz5010cRMSQqcP5fSHpTJaGWsNvlNo
         TJoH4avfTfDYpWrAAIdJpnmmdU83GB2Bep1ojpaogpl31nj9jMUVg0T+6LHH11Y9gtOH
         wSCA==
X-Gm-Message-State: APuU4Z87yGStxhCIv6Hkp1nhvTdPcoU+ZLl6/MzxbkjdUdCmpKItMPTr
	tFNouvzJeIk0ykS5TN8l/hGhr+BrhNt7UnsF8tNV8+JBfWGb6Yo/+znci6RtTQ==
X-Gm-Gg: AZFdTZeyujYysbYNdekpFRuHzWmonkFrPRJDpQbAW7JasEgMMMFvm/VrvZraxx48tef
	8GfNAhMIfZYF96wr8sAezy++yiEZC3BRLvStMtnJG0U4j3d8rmJf/Bro4JSjYIotllnDNSrb789
	aZBot+8ldGNHqKx1DzuGdtvKi4MAertyVLcwp37GbE8kjlk++iEDsrF3SgJn/GMfU1frYwK1IKR
	LM5IKKYYri0nopHfS4upT5h/EjqwvBCE4D4GHTGdTdF+phSFujm7D6wBGAFz9rWWdQ9EaT7j9JD
	PPVy7+9nBMHKdpASPEl1uiMzrJ5BEQt14zDVe2WlbHQGpUZ3nJihSYw4OkOAN10z7oYQQcFqjd4
	yGlKqvjUlWyr2U/OuN0pa8svpEJcgI1zGfhWLrTjALkqx+nm+PPcgg3C+cpYYQmphcbenAZfK9S
	blFYcoadGCDuXs058zeFrTatTbqnDE1TFwSgKNGOrq8+/0/5IjHvqE+DKWyyJOdVa+g7MUynVRc
	NRRNyDD8eNL6cRShmNRjecKKp1LxoztjZCCZe0Yf/LHpjrl2S5yl422hpj3VBd0rT5o3FMMy4gQ
	bogDcjeXsfDF2LMHQijxZbx0W/axAvXMsIk9sHJ2wfIT8ju5gzAF19Si4wRhmDv8Zji6OG4QBei
	V8lc3/yAnBkE9wnSofnZkBfFcCrUSfbyQiVvRCC7eJjyXxqk/7OX/M7MxmmEswHilxmoUBu9MGq
	Uitwo=
X-Received: by 2002:a05:6122:3a0b:b0:5ea:cf9d:a5fe with SMTP id 71dfb90a1353d-5ee827438acmr6070832e0c.14.1795534748785;
        Tue, 24 Nov 2026 07:39:08 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5564a9sm14343463e0c.5.2026.11.24.07.39.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:39:08 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 11/18] profiles/ranging: Keep a peer-driven setup from being rewound
Date: Tue, 24 Nov 2026 10:38:48 -0500
Message-ID: <20261124153856.216054-12-luiz.dentz@gmail.com>
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

