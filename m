Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2489057F72E
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062249; cv=none; b=gNCBnExqITg5u/5dsgQWeaN7enUuS4Jx502tUskNq/Ew/qLu5pk3jf5aCWtYhtoE+vJZMsoCJ1OWHaXT9FWd+ymIFWCtMh4zxxHPGXmsbJsHrpmaE1LbiKUtmg5VZrC31zyJ+cp1iMoMV2jvl4opa6Oed3xxSZDWdiKZ1LOJ24I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062249; c=relaxed/simple;
	bh=F49ZDPZJpUnIKDARmBFZqap33fNd/viKag091UkZZ08=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WoN7btp63+lVRxnat5uzlNcl8+bxnzohfwNRqduivdZmjKOaO1yqeFLSXSNehN/dTUPhx9PeN5k3bUmeX7v/pNtF2T6XElvSvHSPUcmtZiTl9dJS+7Y+fxj6MOr11TDGqCvMlZ108Ay82w74HVb2S4EY7N7bkLf5NMKMDYdEd68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bxw0P4kD; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bxw0P4kD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789062230;
	bh=7ZjJIDv7LZv95dMDIEa3yDyY5fuMEn8bnp3xcF75wVA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bxw0P4kDyc7ifTpbwmE4Sv+MXzZMtatSX5dmK4WBq4v/IXR/ucY6qba/zZF9buADQ
	 h6qGSO77dI/10o7CElLp6glBaw4GunKx/7XHLy98o+FUHdku7pg235dQQxp+daRpIg
	 N0x5yy34mQTrL0kKTfBzdgzvwrkRbNVucHMDdz/U=
Received: from github.com (hubbernetes-node-9f41bbf.ac4-iad.github.net [10.52.222.20])
	by smtp.github.com (Postfix) with ESMTPA id 3D4D5941075
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:43:50 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:43:50 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1161557/000000-aca79b@github.com>
Subject: [bluez/bluez] 0c5b92: build: add doc/test-functional.rst to
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

  Branch: refs/heads/1161557
  Home:   https://github.com/bluez/bluez
  Commit: 0c5b9211ce8a99afa4d5381d5efbf0c082a0b4ce
      https://github.com/bluez/bluez/commit/0c5b9211ce8a99afa4d5381d5efbf0c082a0b4ce
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


  Commit: 93e8e2aae4af57407f7f88b26148ed61f3f993ff
      https://github.com/bluez/bluez/commit/93e8e2aae4af57407f7f88b26148ed61f3f993ff
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


  Commit: 44a50bf9c754606bd8b96cca0ae3ef5952a3278d
      https://github.com/bluez/bluez/commit/44a50bf9c754606bd8b96cca0ae3ef5952a3278d
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


  Commit: fa0bef6899a0ab8ade319e7c5d5eb84e99183ede
      https://github.com/bluez/bluez/commit/fa0bef6899a0ab8ade319e7c5d5eb84e99183ede
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


  Commit: 71462b9df290f2e2fb16b07c9eb0915efbb9240f
      https://github.com/bluez/bluez/commit/71462b9df290f2e2fb16b07c9eb0915efbb9240f
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


  Commit: 17d960744f4fd229a731474bfc3c8f51257519e7
      https://github.com/bluez/bluez/commit/17d960744f4fd229a731474bfc3c8f51257519e7
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


  Commit: 12a5b0076eb9e9873f61b9467bffd63bd21e0698
      https://github.com/bluez/bluez/commit/12a5b0076eb9e9873f61b9467bffd63bd21e0698
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


  Commit: b7f2681c4f7b8bfac2f2c3cb625a73b393a8edb3
      https://github.com/bluez/bluez/commit/b7f2681c4f7b8bfac2f2c3cb625a73b393a8edb3
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


  Commit: c0ae00492e0cc79b0b40f4d85865649366cb7645
      https://github.com/bluez/bluez/commit/c0ae00492e0cc79b0b40f4d85865649366cb7645
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


  Commit: 47071a59cee9a04852bd06b45874d720b7965271
      https://github.com/bluez/bluez/commit/47071a59cee9a04852bd06b45874d720b7965271
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


  Commit: e071c2266e8f57e72cb81082e452a798e474a3a5
      https://github.com/bluez/bluez/commit/e071c2266e8f57e72cb81082e452a798e474a3a5
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


  Commit: aca79b6a378ff9a9551d6b6c9090a8ab1beb3bde
      https://github.com/bluez/bluez/commit/aca79b6a378ff9a9551d6b6c9090a8ab1beb3bde
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


Compare: https://github.com/bluez/bluez/compare/0c5b9211ce8a%5E...aca79b6a378f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
