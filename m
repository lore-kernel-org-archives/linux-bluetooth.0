Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA538DD2
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ER6IZKyC"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E665C4229
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 13:48:28 -0800 (PST)
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SRsrp15d5z49PwQ;
	Fri, 10 Nov 2023 23:48:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1699652906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NDuQPaV7BmEZ25pZdMaZJ7eCczVqhfhV0gpiH1BxHR4=;
	b=ER6IZKyC/a5DJiu1Yw/V2E0vQ6pNbw1DwN7m4qFij/fsEDzTbeKhf6ykrewlyf+ir7p2pY
	pT9WC368voSVFEQ5H/bDTK43W+/84GROMD9zTrlgNGQ5p89URNZPto9HGD3F4chDNX3IVX
	WMzPSXT79ZR7qzfnk3+o/c9suezE6d9G0URviOVPA747qqumO9fr8g8a5jXOd7HOwKjC1u
	Av/Z8Xk28HkOJ5Na58fIKtY9VkMDXu7ZO4IJzsPYirHd0SZJGf0zNj+70mCud/caJdSIX6
	/flK+eEOCsbYwM19Ohahog+RrztkcG72Vazoah/IVFuDlkH+OtlnTW0uq+s7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1699652906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NDuQPaV7BmEZ25pZdMaZJ7eCczVqhfhV0gpiH1BxHR4=;
	b=NKe6llsO/xhKj5/rgmiT/pFgLczuVKSTpmJDxYumnuk9DziW0toH66epsRqaz1o24m5Uv2
	uRxCte8hf6nK/3MWWvfnSIVf89ernZbuCp/u1r6fZF34LpH0Nph/uVbtqLETzt8A+HrH6W
	/jKpjORMH5eP0eEg9WLrXUcW1t+bIrCe4ZC+rxTHs9YHj+vcR0YMOS/A9MYjl6zeXVD2ll
	QZJpsKww0sSflX9Xa3/tHgJBh2AvqN2psXsejPpWxe1TnPngpKTAivbX+0sFw+JJGFPjLB
	CW4vDNa4nNdC1RbnJ65xu/GLMhb4S/jRWgx6Tg/De83Q2NNy1GJi7tN+LZYXyg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1699652906; a=rsa-sha256;
	cv=none;
	b=TigaiYDJ0a6HSl+GbMVILgrr8IYNh0hbZ3g3CCTsZBIWI/cbtsvhMoQtZyAvEauouTYVA+
	5qHZDl9TBwz972zNN2SqRisXCIb1zbGC31LFhN8tooyA3YMXYhYY2nxJWdHmMdpoFzHCD7
	6F89A0wpQ9CiaNPylGWMHwwfeHV4dahWcL3N7ZVEUx8VbMASHAkp6rbpeWeEb4E7iWti22
	WSz788/JpSkkAywwc/NXhD4UN2aGhKw1uiqsTPjNJk/qdM1OFx2qlu6C9PwicP19V9UaDH
	sFR5UYD21ciHcOVhmsXIW3usq4Jgjyw2a678DeRL4m6d7lcYPA68P0PAj+rSfA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2] bap: handle state transitions with old_state == new_state
Date: Fri, 10 Nov 2023 23:48:19 +0200
Message-ID: <e8a45a4796f024825318996d68d1b92ebcc9b04a.1699652713.git.pav@iki.fi>
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

Notes:
    v2: add comment
    
    We can also avoid no-op reconfiguration by proceeding straight to QoS if
    the codec settings are already what we want.  We'll still need this
    patch, since we may need to reconfigure.
    
    I'll do that in separate series.

 profiles/audio/bap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b74498c4c..780dff412 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1887,7 +1887,11 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 			bt_bap_stream_statestr(old_state), old_state,
 			bt_bap_stream_statestr(new_state), new_state);
 
-	if (new_state == old_state)
+	/* Ignore transitions back to same state (ASCS allows some of these).
+	 * Of these we need to handle only the config->config case, which will
+	 * occur when reconfiguring the codec from initial config state.
+	 */
+	if (new_state == old_state && new_state != BT_BAP_STREAM_STATE_CONFIG)
 		return;
 
 	ep = bap_find_ep_by_stream(data, stream);
-- 
2.41.0

