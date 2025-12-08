Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419BE2E7F3F
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765222062; cv=none; b=Ih4aEOcF4Y+f2SmSv76Ht2cPfvudGEjOBiD2I1PfIjuzMxegWgyVkw2grnWxzehct6zf5VnOpXonNd4AsBEGbB3CQJgKf6urpKxhqIZccQw308ldUbdeF7DXptdt3LBM1Vas6jUSgiKI9jdYd5vW/97qS7ZUdL7C0qazxmQETuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765222062; c=relaxed/simple;
	bh=OGQu4gcOgKNRL0cEz/QzeVhwTAF7cJIH9GKzb2X7f7g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mJkRU0zUP5pcMfAlizIpjbyWqs9Rv/rQyDoVDNdseTzGSp30M0dUzaLq7jqRQEc8yr0D61cTZMH7wNjnVPPxlZkNOROXUGPd29iPrzSdhCfHdREa8UliTgyzGT+zuD29Zc4eVkliGWO30nekYHAuijdrsKNiLOqtVz+MzmIetyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=A8ehl52z; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="A8ehl52z"
Received: from github.com (hubbernetes-node-c9ad705.va3-iad.github.net [10.48.137.13])
	by smtp.github.com (Postfix) with ESMTPA id 577C34E08A1
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 11:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765222060;
	bh=02taGB4KXhlgrA9dJbAnM/V3Wf7sb856yhg49qbuAco=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=A8ehl52z/k8DfzXr/9JA4+a8TNU98wNltoniYP1rvI6+gi08fdvznKf+ikqorDuon
	 KA9LXKWxYSud03rGkLPEMQloIo20lmxIYFw2AzS/M5iOVJ1BeG6y2fUcL2Mlbpl1FF
	 nbp0EenzrHJv9JojVg401XCa7jGtvuf6FkqdB2dA=
Date: Mon, 08 Dec 2025 11:27:40 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d83198-f1bcd8@github.com>
Subject: [bluez/bluez] d23285: monitor: Fix
 BT_HCI_EVT_LE_READ_ALL_REMOTE_FEATURE...
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
  Commit: d232852d2a10b4801d642b38aae26dfaef546b1b
      https://github.com/bluez/bluez/commit/d232852d2a10b4801d642b38aae26dfaef546b1b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-05 (Fri, 05 Dec 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix BT_HCI_EVT_LE_READ_ALL_REMOTE_FEATURES_COMPLETE decoding

BT_HCI_EVT_LE_READ_ALL_REMOTE_FEATURES_COMPLETE does not have a CS
prefix.


  Commit: 2645d3f662ebe8e601df628432886d3712b421b3
      https://github.com/bluez/bluez/commit/2645d3f662ebe8e601df628432886d3712b421b3
  Author: Andrey Smirnov <andrew.smirnov@gmail.com>
  Date:   2025-12-08 (Mon, 08 Dec 2025)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input/device: Fix off by one report descriptor size error

Due to the way we handle SDP strings internally BlueZ ends up
including and artifically added 0x00 into the report descriptor it
passes on to UHID. This results in kernel error messages like

[371225.240843] microsoft 0005:045E:02FD.0019: unknown main item tag 0x0

or

[367200.458679] playstation 0005:054C:0CE6.0014: unknown main item tag 0x0

The error is ignored by the kernel's report parser, so this is benign,
but for the sake of correctness, let's not supply bogus data in the
first place.


  Commit: 715ed46a436ba865735d91c22be1d106115ee12d
      https://github.com/bluez/bluez/commit/715ed46a436ba865735d91c22be1d106115ee12d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-08 (Mon, 08 Dec 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: fix invalid BAP server transition releasing -> qos

When remote BAP Client requests Release during streaming, our upper
layer calls bap_ucast_disable() when releasing the transport.  This
causes invalid releasing -> qos transition.

Fix by properly checking valid states in stream_disable(); bail out also
when in DISABLING and RELEASING.  This leaves the valid states ENABLING
and STREAMING, so write them explicitly.

Log:
profiles/audio/transport.c:media_transport_suspend() Transport /org/bluez/hci1/dev_FF_FF_FF_FF_FF_FF/fd0 Owner
profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci1/dev_FF_FF_FF_FF_FF_FF/fd0: TRANSPORT_STATE_ACTIVE -> TRANSPORT_STATE_IDLE
src/shared/bap.c:stream_disable() stream 0x7c41327f1060
src/shared/bap.c:bap_ucast_set_state() stream 0x7c41327f1060 dir 0x01: releasing -> qos


  Commit: 17a227b77b4ebcb3bd83cc2444f5c3ebd09a174c
      https://github.com/bluez/bluez/commit/17a227b77b4ebcb3bd83cc2444f5c3ebd09a174c
  Author: Andrey Smirnov <andrew.smirnov@gmail.com>
  Date:   2025-12-08 (Mon, 08 Dec 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Limit the number of retries on auth failures

Currently BlueZ has no retry limit on reconnection attempts in case of
authentication failures. This leads to a very unpleasant user
experince with, for example, XBox controller. The scenario is as
follows:

1. Host A is running BlueZ and XBox controller is paired and connected
   to it.
2. Host A shuts down (for example)
3. XBox controller is put into pairing mode and is paired to a Host B
4. Host B is powered down
5. Host A is powered on
6. XBox controller is powered on
7. Host A/BlueZ will start spamming XBox controller with connection
   attempts in an endless loop

What happens under the hood is:

1. BlueZ starts up, sees that there's LTK saved for XBox controller,
   so it adds it to kernels autoconnect list
2. Once XBox controller is on and advertising, kernel connects to it
3. BlueZ tries to elevate the security level, but is rejected by the
   controller with "Key or PIN missing" because the controller is already
   paired to another host.
4. Controller disconnects, controller goes back to advertising, goto 2

To avoid this, let's add a simple auth failure counter and disable
autoconnect for the device once we go past the failure
threshold. Let's also implement an expoenential backoff in our retry
logic to avoid blasting our retires in a single burst.


  Commit: 0e5f8b6431a3dee54de07eff953dda51110596bd
      https://github.com/bluez/bluez/commit/0e5f8b6431a3dee54de07eff953dda51110596bd
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-08 (Mon, 08 Dec 2025)

  Changed paths:
    M lib/bluetooth/uuid.h
    M profiles/audio/bap.c
    M profiles/audio/vcp.c

  Log Message:
  -----------
  lib: move VCS, TMAS, GMAS uuid strings to uuid.h

These are needed in several places, so move also string version of the
uuid to uuid.h.

The naming in string vs. uint16_t uuid is not systematic in this file.
Retain the _STR suffix to be clearer.


  Commit: d3b7f5324ebe0fdcc0c79de6d5e551e3c48b0869
      https://github.com/bluez/bluez/commit/d3b7f5324ebe0fdcc0c79de6d5e551e3c48b0869
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-08 (Mon, 08 Dec 2025)

  Changed paths:
    M src/shared/tester.c

  Log Message:
  -----------
  shared/tester: check size before trying debug print


  Commit: b03626a9bc147b9cdc8121f014ef3ae00f35ca9f
      https://github.com/bluez/bluez/commit/b03626a9bc147b9cdc8121f014ef3ae00f35ca9f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-08 (Mon, 08 Dec 2025)

  Changed paths:
    M profiles/audio/bap.c
    M src/shared/gmap.h
    M src/shared/tmap.h

  Log Message:
  -----------
  shared/tmap, gmap: add macros for feature names and listing

Better use constants for feature names to avoid typos.

Add macros for generating lists containing all features / roles.


  Commit: cf0e70407e70cf3c11c6e602bdd6389f14b7b897
      https://github.com/bluez/bluez/commit/cf0e70407e70cf3c11c6e602bdd6389f14b7b897
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-08 (Mon, 08 Dec 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: use tmap/gmap macros for listing features

Use listing macros to generate the feature lists.


  Commit: 814e54ba288f68c174ed0d439389d7b21950a351
      https://github.com/bluez/bluez/commit/814e54ba288f68c174ed0d439389d7b21950a351
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-08 (Mon, 08 Dec 2025)

  Changed paths:
    M src/shared/tmap.c

  Log Message:
  -----------
  shared/tmap: deactivate service if setting Role to 0

Deactivate TMAS if roles are removed.

Also add NULL checks to the set() routine for convenience.


  Commit: b8d21420af2bd30843630071ab7bad9063f65023
      https://github.com/bluez/bluez/commit/b8d21420af2bd30843630071ab7bad9063f65023
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-08 (Mon, 08 Dec 2025)

  Changed paths:
    M src/shared/gmap.c

  Log Message:
  -----------
  shared/gmap: deactivate service or remove feature chrc if role removed

When role is removed, the associated feature chrc must be removed too as
it's then Excluded in spec.  If all roles are removed, deactivate the
service instead to avoid consuming ATT handles.

Reserve exactly the right number of handles for the service.

Also add null checks to the feature set routines for convenience.


  Commit: ef647782839231a64931fad35e122899b7ba68f2
      https://github.com/bluez/bluez/commit/ef647782839231a64931fad35e122899b7ba68f2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-08 (Mon, 08 Dec 2025)

  Changed paths:
    M unit/test-tmap.c

  Log Message:
  -----------
  test-tmap: test removing and adding role


  Commit: 60d7075142958f74644a642d7e593028b5acf20d
      https://github.com/bluez/bluez/commit/60d7075142958f74644a642d7e593028b5acf20d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-08 (Mon, 08 Dec 2025)

  Changed paths:
    M unit/test-gmap.c

  Log Message:
  -----------
  test-gmap: test removing, adding, and changing role

When role is changed the old characteristic is removed, which shifts the
attribute handles.


  Commit: e4b968ca4f285e3d7940d2d08d8db3f6a78dcc68
      https://github.com/bluez/bluez/commit/e4b968ca4f285e3d7940d2d08d8db3f6a78dcc68
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-08 (Mon, 08 Dec 2025)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: parse SupportedFeatures from registered MediaEndpoints

Parse SupportedFeatures for TMAP and GMAP features, and update the
values to the local services if present.


  Commit: 8dcfe76b1b39a10eb467d2de6387eb52e640b8b4
      https://github.com/bluez/bluez/commit/8dcfe76b1b39a10eb467d2de6387eb52e640b8b4
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-08 (Mon, 08 Dec 2025)

  Changed paths:
    M profiles/audio/tmap.c

  Log Message:
  -----------
  tmap: remove service on device remove

Remove service on device_remove() as disconnect() is not necessarily
called on device remove.


  Commit: f1bcd84a0fb7f019f4233e04573080fe95ab6602
      https://github.com/bluez/bluez/commit/f1bcd84a0fb7f019f4233e04573080fe95ab6602
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-08 (Mon, 08 Dec 2025)

  Changed paths:
    M profiles/audio/gmap.c

  Log Message:
  -----------
  gmap: remove service on device remove

Remove service on device_remove() as disconnect() is not necessarily
called on device remove.


Compare: https://github.com/bluez/bluez/compare/d83198c78ee1...f1bcd84a0fb7

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
