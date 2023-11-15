Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D439B
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Nov 2023 01:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IAh5JrF6"
Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16FCDC
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 17:14:32 -0800 (PST)
Received: from github.com (hubbernetes-node-2d8a012.ash1-iad.github.net [10.56.145.41])
	by smtp.github.com (Postfix) with ESMTPA id 01CA0340801
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 17:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1700010872;
	bh=7saOsnmgiMJJ6aaB1Ghyi6HjK/PoHxX+pBNjSy1SM3E=;
	h=Date:From:To:Subject:From;
	b=IAh5JrF6081q/c/RyHzfLbF/6BRBlS+jVVGtMTaMUOL1k3+MS6A/Ji3J3Zn1/3wL4
	 CkWTYUG1b2QFoARuNivkuxEoBGQR8K4PrQKzFeRokaCVhlWX0PncymJs2QcRv76J2V
	 y3AB/tygt3afZimMG+0Nibx//cOkm1q9t3dkTCRY=
Date: Tue, 14 Nov 2023 17:14:32 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4b353a-8b035b@github.com>
Subject: [bluez/bluez] ad089d: adapter: fix heap corruption during discovery
 filt...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: ad089d29945ffd0ffb2d8075c25f76ac7c267eba
      https://github.com/bluez/bluez/commit/ad089d29945ffd0ffb2d8075c25f76ac7c267eba
  Author: Philipp Meyer <Philipp.Meyer@weidmueller.com>
  Date:   2023-11-14 (Tue, 14 Nov 2023)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: fix heap corruption during discovery filter parsing

Must parse as dbus_bool_t, as booleans MUST be 4 bytes for dbus.
stdbool from the filter only has 1 byte in many cases. This will crash
dbus if parsing filter->duplicate directly in
dbus_message_iter_get_basic.


  Commit: 14dd4a75ceb284bf4fda00d1c318683fbaa4ac07
      https://github.com/bluez/bluez/commit/14dd4a75ceb284bf4fda00d1c318683fbaa4ac07
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-11-14 (Tue, 14 Nov 2023)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: add Retransmissions in SelectProperties QoS

The server preferred RTN is part of the server supported/preferred QoS
values, and should be passed on to SelectProperties.


  Commit: 8b035b70f379e45a32c94579ec8d00e48070c21e
      https://github.com/bluez/bluez/commit/8b035b70f379e45a32c94579ec8d00e48070c21e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-11-14 (Tue, 14 Nov 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: handle state transitions with old_state == new_state

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


Compare: https://github.com/bluez/bluez/compare/4b353ae99ab6...8b035b70f379
