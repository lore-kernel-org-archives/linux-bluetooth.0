Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C33B28F
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="euMHhCPf"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059C3A9
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 11:57:56 -0800 (PST)
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4SRqPF6nwWzyQj;
	Fri, 10 Nov 2023 21:57:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1699646274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tdyZHuLIhy866iHM7p6erjROQXYArwIjpy1RasqprSc=;
	b=euMHhCPfQ/xMb/P2RTZ0Q/KEd421Q0AYkvh8FjB0b+hTdl1pYJjMABHUQYVPuSHPZT87Rm
	yHFU6jv4GL99QCdbS4OyPmfuk+6CvAezBEynJUYVBa6+5PYu74SUvaXKcuA/FS9tZ9RrZ5
	TZWUGeEKC8HK0IZD80BbZDwQ2QEzTA0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1699646274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tdyZHuLIhy866iHM7p6erjROQXYArwIjpy1RasqprSc=;
	b=d4KzlwVmGPPJacRbSaX6HT0QyG6r+VyZraOMzhK+Wma6tLF0HFEWX9I3Mpb7JZMUvmp1yh
	a2Tn2VfPALzYYgp1HR7m/e6af19Bz9Jy8gmjTZ6Z5/ncFoqEVV2xT3nbuSixtYHKsofg0l
	6kAcsQc7ZSTKOYD7qFwflaQJ/mj83xo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1699646274; a=rsa-sha256; cv=none;
	b=vKmvnYS1Qz0bw52EW7CsM9hZcknbCofNMHvIL4z1N4gSNpuctET3g4dQNaia48j0hJcqWV
	4dYqJR/jU1D7uUzWXWJB7J3nuXZr3B2JezlKWMpJq3nqEc2ztdlLEDzIQ46/bHqee/Vs77
	/YBmyonaldsE3gV8PBJpXbVKwkDe7H0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] bap: handle state transitions with old_state == new_state
Date: Fri, 10 Nov 2023 21:57:48 +0200
Message-ID: <5c65fa8da174de15074310ec368f537c717ded43.1699646238.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ASCS allows transitions from Codec/QoS Configured back to the same
state.

E.g. NRF5340_AUDIO devkit starts in the config(1) state, which is
allowed (only Config QoS, Release, Enable, Receiver Stop Ready
transition are client-only). In this case, as client, we do Config Codec
ourselves and end up with config(1)->config(1) transition.  We currently
ignore that event, so QoS won't be setup and transports won't be
created.

Handle the config(1)->config(1) transition by continuing to Config QoS
if it occurs.

Log:

src/gatt-client.c:btd_gatt_client_connected() Device connected.
src/shared/gatt-client.c:exchange_mtu_cb() MTU exchange complete, with MTU: 65
src/shared/bap.c:bap_ep_set_status() ASE status: ep 0x604000039a90 id 0x01 handle 0x000f state config len 42
src/shared/bap.c:ep_status_config() codec 0x06 framing 0x00 phy 0x02 rtn 2 latency 10 pd 4000 - 40000 ppd 4000 - 40000
src/shared/bap.c:ep_status_config() Codec Config #0: type 0x01 len 2
src/shared/bap.c:ep_status_config() Codec Config #1: type 0x02 len 2
src/shared/bap.c:ep_status_config() Codec Config #2: type 0x03 len 5
src/shared/bap.c:ep_status_config() Codec Config #3: type 0x04 len 3
src/shared/bap.c:ep_status_config() Codec Config #4: type 0x05 len 2
src/shared/bap.c:bap_stream_state_changed() stream 0x60c0000334c0 dir 0x01: idle -> config
src/shared/bap.c:bap_stream_update_io_links() stream 0x60c0000334c0
profiles/audio/bap.c:bap_state() stream 0x60c0000334c0: idle(0) -> config(1)
profiles/audio/bap.c:bap_ready() bap 0x60e000001d20
profiles/audio/bap.c:pac_found() lpac 0x608000017520 rpac 0x6080000183a0
profiles/audio/bap.c:ep_register() ep 0x60d000006910 lpac 0x608000017520 rpac 0x6080000183a0 path /org/bluez/hci0/dev_C9_C9_76_21_08_4F/pac_sink0
profiles/audio/media.c:media_endpoint_async_call() Calling SelectProperties: name = :1.604 path = /MediaEndpointLE/BAPSource/lc3
...
src/shared/bap.c:bap_stream_state_changed() stream 0x60c0000334c0 dir 0x01: config -> config
src/shared/bap.c:bap_stream_update_io_links() stream 0x60c0000334c0
profiles/audio/bap.c:bap_state() stream 0x60c0000334c0: config(1) -> config(1)
---
 profiles/audio/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b74498c4c..30a585ede 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1887,7 +1887,7 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 			bt_bap_stream_statestr(old_state), old_state,
 			bt_bap_stream_statestr(new_state), new_state);
 
-	if (new_state == old_state)
+	if (old_state == new_state && new_state != BT_BAP_STREAM_STATE_CONFIG)
 		return;
 
 	ep = bap_find_ep_by_stream(data, stream);
-- 
2.41.0

