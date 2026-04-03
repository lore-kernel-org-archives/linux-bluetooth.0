Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF32DB7BD
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206600; cv=none; b=Skdd3/jPK9TF6ReS35liYJNJ/2IbdM/ISL232E6vWnuhpcoiLIOcsLP3LVroTBUc4Lx+fKYXuGj3nrsQ9lkwpuwzAxfYwW6woG+cI9AB2mkCMkyhEEBEQuuxqOq/DLhiTqaoT5rRlTVpQqUnoyE1DJVYHGk20FDhCKXzD8F5Tx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206600; c=relaxed/simple;
	bh=dilSWcoQLoJx8SkdH/gpph35YjlIS6DZymSgaPzBpnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tWz1szbxfhopbjrmDLHhbEPabCkhuavr37O//wQ8mIAdGnBmUFwpr2nU2aRodGjT2uo+Zm/D9Vs+1mgGxPlwzxOIGovbLS8JiNoklrXIW6gOgheRCZkGkhIzEZyiVqhJgGjV1PVGGhIBtFy7CYD01Zy3zPtZcLvNIOnG1l7eIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=lE5Yw6Gq; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="lE5Yw6Gq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1775206594; x=1775811394; i=martinbts@gmx.net;
	bh=9ygRQjjF32wqrGf8pfkJdA6UKAhrT9WDTvac3V7VA7o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lE5Yw6GqmBjuQNA28EiTUOiPaYGwbYpLQVDjWeMAmLaHnubqKXfGTnGbZQYTm0TF
	 mKeAWZOvsmoZ5bVKH/gVQaxX9NrqhwC/j4sqskm8+wFgLwWolnfRwpVkLrN8oBTR4
	 TtTHsMActD5ai56FKNEsGCh1g+SDhU92qNWN5gy4HmX08LFA9JewQHz4XrFkl/Ya/
	 QuV2ZkwGetrzyujOITr2qamBaW3KkVUrlr/ljv3/seLD7GU9xR17nrYJ7T0cPkGkz
	 ZHca0bMLt/ljnsr+8Is4HmW2BUJmATh0UsfT5hdQeKo/M7VSWmp/nCuLX8n5gQQrV
	 fbh5epueLxubl3ZV2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybKf-1vIZi842Wr-00tiLJ; Fri, 03
 Apr 2026 10:56:34 +0200
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v3 0/6] BLE-HID/Nintendo Switch 2 support
Date: Fri,  3 Apr 2026 10:55:47 +0200
Message-ID: <20260403085555.23871-1-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sLSwZEO+22TgN3yzZ7FDoLOc3gFvJ6LwDo6vjJsUCXzAEBWd25m
 NNOXy3t/EMIb4kfMu3EKNPwyhasjatz6tWg7LwP1uvXm9nv8c+q8YkBddE4iNoppPAgw6pK
 k7dXcjbqU+f1oUvGiC/JHgOix5wcRJbiW+i+1mGiy/4tm0nWpOHtlAY+phzxWDpdKVCYTpE
 77h2AX+pudfqAcgB21XZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h2FeoH1RkvU=;ThH1hGIuBVIzLuR5S/fu2i0hXaT
 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

Changes v3:
* Simplified config setting approach.
* Added a 2-second timeout for secondary discovery.
* Separated BLE/GATT-to-HID code from Procon 2 code.
* Removed all Switch/Procon 2 overlap with the HID kernel driver.
* Link to v2: https://lore.kernel.org/all/20260308124745.19248-1-martinbts=
@gmx.net/

v3 blurb:

While the overall motivation for my work is the Procon 2 controller, there
are two things very BlueZ specific:

A) Devices (e.g. the Procon 2) may deviate from the spec and not respond
   to service discovery, which currently must result in a failed
   connection attempt.
B) (I think) There currently isn't a facility that allows feeding HID
   devices BLE/GATT traffic.

* Patches 1 and 2 are two alternatives to resolve problem A.
* Patch 5 attempts to resolve problem B.
* Patches 3-4 are minor cleanups (rename set_alias, add Gaming
  appearance class), unchanged from v2.
* Patch 6 is minimalistic support for the Switch 2 controllers so that
  HID drivers can take over

Patch 1 uses a configuration setting (v1 feedback), while
Patch 2 uses a new 2-second timeout (v2 feedback).

Both work, but connecting the controller using only Patch 2 is a lot
less reliable. The Procon 2 does only try/wait for a connection for
a few seconds. BLE discovery tends to take so long that together with
the 2 second timeout the controller gives up before the timeout fires.
Patch 1 always worked, when the device showed up in bluetoothctl.

Patch 1 and Patch 2 are both individually suited to solve my
immediate problem. From my point of view it is not necessary to apply
both. I am submitting both for side-by-side comparison and discussion.

Patch 5 is a GATT-UHID bridge that forwards notifications from the
controller to the hid device and hid-device-writes to the
controller. This was previously burried in all the other code that
supported the Procon 2. It can now be used for other input devices that
use only GATT. As far as I can tell, this does not overlap at all with
other Switch 2 support efforts.

Patche 6 is specific to the Switch 2 controllers so that they can be
interacted with through uhid. In contrast to v1 and v2 this is "minimal"
code that makes bluetoothd create a HID device and does the plumbing for
a GATT-HID bridge. There is no overlap to any published Switch 2 driver (t=
hat
I am aware of). The result is not usable. One still needs a driver that
"does the right thing". I am keeping my "works on my machine" code here:
https://github.com/martin-bts/hid-switch2-dkms. I will keep using it
until we get proper driver support in the kernel.

Disclaimer (as in v1): I only have a Nintendo Switch 2 Pro Controller
and cannot attest to anything related to any other controller.

Martin BTS (6):
  shared/gatt: Add skip_secondary option for GATT client
  shared/gatt: Add timeout for secondary service discovery
  device: Rename set_alias to  btd_device_set_alias()
  dbus-common: Add Gaming appearance class (0x2a)
  plugins/gatt-uhid: Add generic GATT-to-UHID bridge
  plugins/switch2: Add Nintendo Switch 2 Controller plugin

 Makefile.plugins         |   5 +
 peripheral/gatt.c        |   3 +-
 plugins/gatt-uhid.c      | 350 +++++++++++++++++++++++++++++++++++++++
 plugins/gatt-uhid.h      |  56 +++++++
 plugins/switch2.c        | 255 ++++++++++++++++++++++++++++
 src/dbus-common.c        |   2 +
 src/device.c             |  24 +--
 src/device.h             |   2 +
 src/shared/gatt-client.c |  70 +++++++-
 src/shared/gatt-client.h |   3 +-
 tools/btgatt-client.c    |   2 +-
 unit/test-bap.c          |   2 +-
 unit/test-gatt.c         |   2 +-
 unit/test-gmap.c         |   2 +-
 unit/test-mcp.c          |   2 +-
 unit/test-micp.c         |   3 +-
 unit/test-tmap.c         |   2 +-
 17 files changed, 762 insertions(+), 23 deletions(-)
 create mode 100644 plugins/gatt-uhid.c
 create mode 100644 plugins/gatt-uhid.h
 create mode 100644 plugins/switch2.c

=2D-=20
2.47.3

