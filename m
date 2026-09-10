Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F54718E7
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789076536; cv=none; b=MWv80FAoWhsR7t7RhB2+FzONq3EdBSA4xI9V58KY99+cvU2aC83HHLbtJFIIYrzt8+Ih1I69GSMUcmiJ3iKVfOzD3YbwQsJBTpKYs4AzzVOD1RFIUMp/jNW5MRtR8OQfACIXoenmnV6LXkoMMeeJ4SAjCyZHRKiGO1cP+VvIFD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789076536; c=relaxed/simple;
	bh=++13+1JVkYyK+7q+9Kgij291bW0HSt7c0ZQnq7hPeHE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BzZUi0WiDimASG7TwtY/I8/zVCDhftXIXY6f1QZ2CvXhuTnZoOHNbUhA4XJwT26qW4o0QogCJ50gc5SdETs10msFD7bVcR6gNQQMOnsWqhZuizLFT6wprgXUHzcJLM98yIYUC/zdCPD4XT4GlKcN4V/y8fhSism6PhPLVTLxezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YLF9jhiL; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YLF9jhiL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789076530;
	bh=VEeXXnUvbzwFMtxFkgYewU2YlQGG2Oy0vYej1+RPeb8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YLF9jhiL5KZEaGKZXtoW21QoyGATd/7kfwQzu/J3pBCyGuDthcRrxDQs5x6Al13gv
	 YJuH7VvJAFeEsoMS2bb/u05uLA95zZ972txk+9KkJG7LUoWfDk5CVo5ZV7YuRSoFrj
	 xzCFCKf0xFQTuol1Cx3F2MH/uSobLRRrytFsjFrc=
Received: from github.com (hubbernetes-node-6038e73.ac4-iad.github.net [10.52.125.19])
	by smtp.github.com (Postfix) with ESMTPA id CDDF7A0176
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:42:10 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:42:10 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/1b9a0e-61a2b3@github.com>
Subject: [bluez/bluez] 8df638: build: add doc/test-functional.rst to
 EXTRA_DIST
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
  Commit: 8df6386b97c8f5d61c50b518ab02434a87493409
      https://github.com/bluez/bluez/commit/8df6386b97c8f5d61c50b518ab02434a87493409
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: add doc/test-functional.rst to EXTRA_DIST

The functional testing documentation was not distributed with the
tarball, unlike the other documents in doc/.

Assisted-by: opencode:claude-opus-5


  Commit: fb3457bcd1e5cbf31c2a6dd9b47be178c15b3882
      https://github.com/bluez/bluez/commit/fb3457bcd1e5cbf31c2a6dd9b47be178c15b3882
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M Makefile.am
    A doc/functional-avrcp.rst
    A doc/functional-obex.rst
    A doc/functional-testing.rst

  Log Message:
  -----------
  doc: describe the functional test cases

Add doc/functional-testing.rst describing the test cases under
test/functional as setup, steps, expected outcome and notes, so a test
can be reproduced and reviewed without reading its source, and the
reason behind the way it is written is not lost. The setup of each test
includes a topology diagram showing how many hosts are used and the
role each of them takes.

It also documents the pytest markers (vm, sa, tester) and the
convention of naming security advisory regression tests after their
GHSA id.

Tests for a specific profile need more context than the core ones, so
they are documented separately, in doc/functional-<profile>.rst.

Assisted-by: opencode:claude-opus-5


  Commit: 45b123f3a9c2971d3470a88bb52cfdf35b272c05
      https://github.com/bluez/bluez/commit/45b123f3a9c2971d3470a88bb52cfdf35b272c05
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client: do not prompt for LE Audio settings on A2DP endpoints

Registering an A2DP endpoint prompted for Locations, Supported
Context, Context, CIG and CIS, which are LE Audio/ISO specific and
have no meaning for A2DP. Worse, answering Locations with a single
location pushes an LC3_CHAN_COUNT LTV into the capabilities, which
corrupts the SBC capabilities.

Register A2DP endpoints right after Max Transports instead, and use
the same helper in endpoint_init_defaults(), which compared against
A2DP_SOURCE_UUID twice and therefore left A2DP Sink endpoints with
ISO and broadcast defaults.

Assisted-by: opencode:claude-opus-5


  Commit: 23fac1a310c0011348550ceb37838812d75e9da6
      https://github.com/bluez/bluez/commit/23fac1a310c0011348550ceb37838812d75e9da6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    A client/scripts/a2dp-sink.bt
    A client/scripts/a2dp-source.bt

  Log Message:
  -----------
  client: add A2DP endpoint registration scripts

Add scripts registering an A2DP Source and an A2DP Sink endpoint with
SBC, so a peer can be set up with a single command:

  bluetoothctl --init-script client/scripts/a2dp-source.bt

Assisted-by: opencode:claude-opus-5


  Commit: a888c89ead5aa21522f1ba22eea5ef15aa3bffd0
      https://github.com/bluez/bluez/commit/a888c89ead5aa21522f1ba22eea5ef15aa3bffd0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M Makefile.am
    A doc/functional-a2dp.rst
    M doc/functional-testing.rst
    A test/functional/test_a2dp.py

  Log Message:
  -----------
  test: functional: add A2DP tests

Add tests covering A2DP via bluetoothctl: the central registers an
A2DP Source endpoint and the peripheral an A2DP Sink endpoint, using
the endpoint registration scripts. The endpoints are registered before
pairing so the SDP records are in place when the peer resolves the
services.

test_a2dp_transport_created checks a MediaTransport1 object is created
on both sides with the expected endpoint, codec and state, and
test_a2dp_transport_acquire checks the central can acquire it.

Assisted-by: opencode:claude-opus-5


  Commit: d6d9a13775af63dd5ac77fae9e307e5d0b518840
      https://github.com/bluez/bluez/commit/d6d9a13775af63dd5ac77fae9e307e5d0b518840
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    A client/scripts/a2dp-sink-sbc.bt
    R client/scripts/a2dp-sink.bt
    A client/scripts/a2dp-source-sbc.bt
    R client/scripts/a2dp-source.bt
    M doc/functional-a2dp.rst
    M test/functional/test_a2dp.py

  Log Message:
  -----------
  client: rename media endpoint scripts to include the codec

Name the scripts registering a media endpoint
<profile>-<role>-<codec>[-<preset>].bt, so it is clear what they set
up without having to read them.

Assisted-by: opencode:claude-opus-5


  Commit: 304e388070f569c3abe4956fc68afd97ef85d31b
      https://github.com/bluez/bluez/commit/304e388070f569c3abe4956fc68afd97ef85d31b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    A client/scripts/bap-sink-lc3.bt
    A client/scripts/bap-source-lc3.bt

  Log Message:
  -----------
  client: add BAP endpoint registration scripts

Add scripts registering a local PAC Source and a local PAC Sink
endpoint with LC3, to set up the two sides of a BAP unicast stream:

  bluetoothctl --init-script client/scripts/bap-source-lc3.bt

The locations and contexts match the ones bluetoothctl uses when
registering the endpoints itself, so that the metadata of a stream is
not rejected.

Assisted-by: opencode:claude-opus-5


  Commit: 2fccbd5040e9a7e900e86d9608ad1a7f6be0a880
      https://github.com/bluez/bluez/commit/2fccbd5040e9a7e900e86d9608ad1a7f6be0a880
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M doc/bluetoothctl.rst

  Log Message:
  -----------
  doc: bluetoothctl: document init script option and scripts

The --init-script option was not documented. Document it, along with
the scripts shipped in client/scripts and the roles they set up.

Assisted-by: opencode:claude-opus-5


  Commit: a60d81439eab43d110fa939544a0cf0de0b36cc1
      https://github.com/bluez/bluez/commit/a60d81439eab43d110fa939544a0cf0de0b36cc1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M Makefile.am
    A doc/functional-bap.rst
    M doc/functional-testing.rst
    A test/functional/test_bap.py

  Log Message:
  -----------
  test: functional: add BAP unicast tests

Add tests covering BAP unicast via bluetoothctl: the initiator
registers a PAC Source endpoint, the acceptor a PAC Sink endpoint, and
after pairing the initiator configures the remote endpoint with a
preset.

test_bap_unicast_transport_created checks a MediaTransport1 object is
created on both sides with the expected endpoint, codec and state, and
test_bap_unicast_transport_acquire checks the initiator can acquire
them.

The endpoints are configured for stereo, so a stream is created per
location, each with its own CIS in the same CIG. All the transports
have to be acquired, as the CIS are only created once every CIS of the
CIG is ready.

Assisted-by: opencode:claude-opus-5


  Commit: 8c99eaa01d53fc5762f40ac11dcd517e2aed4471
      https://github.com/bluez/bluez/commit/8c99eaa01d53fc5762f40ac11dcd517e2aed4471
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M doc/functional-bap.rst
    M test/functional/test_bap.py

  Log Message:
  -----------
  test: functional: add BAP broadcast tests

Add tests covering BAP broadcast via bluetoothctl: the Broadcast
Source registers a BCAA endpoint, configures it and starts the
broadcast, while the Broadcast Sink registers a BAA endpoint and scans,
syncing to the periodic advertising on its own, without a Broadcast
Assistant. Run them for a plain broadcast and for a Public Broadcast
Profile one.

test_bap_broadcast_transport_created checks a MediaTransport1 object is
created for each BIS of the BASE, and test_bap_broadcast_transport_acquire
checks selecting the transport with the broadcast code moves it to
broadcasting and acquiring it succeeds.

Assisted-by: opencode:claude-opus-5


  Commit: 4f77841df4ac8a8d8631eab709f53f08b1759dbd
      https://github.com/bluez/bluez/commit/4f77841df4ac8a8d8631eab709f53f08b1759dbd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M doc/functional-bap.rst
    M test/functional/test_bap.py

  Log Message:
  -----------
  test: functional: add BAP broadcast assistant test

Add a test covering the Broadcast Assistant sharing a broadcast with a
Scan Delegator, with the Broadcast Source and the Broadcast Assistant
colocated so the assistant shares its own broadcast. The delegator
receives the periodic advertising sync over the connection to the
assistant (PAST), instead of scanning the source itself.

The topology where the assistant relays a source it scanned, which
does not use PAST, needs the assistant on a third host and can be
added later.

Assisted-by: opencode:claude-opus-5


  Commit: 61a2b3d93897b04fb921a4fb229c0831d13807a8
      https://github.com/bluez/bluez/commit/61a2b3d93897b04fb921a4fb229c0831d13807a8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: reuse the PA sync established to discover a Broadcast Source

A Broadcast Sink creates a short lived PA sync to read the BASE of a
Broadcast Source, closes it, and creates a new one once a stream is
enabled, as syncing to the BIG requires a PA sync. The second sync has
to be established again before the BIG sync can be requested, which
delays the start of the stream.

Keep the sync of the BIG Info report around instead, and reuse it, but
only while there is nothing else to discover, as a sync holds resources
that are needed to discover other Broadcast Sources: it is released as
soon as another source is probed, and after a grace timeout if no
stream is enabled in the meantime.

Assisted-by: opencode:claude-opus-5


Compare: https://github.com/bluez/bluez/compare/1b9a0eca8cdf...61a2b3d93897

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
