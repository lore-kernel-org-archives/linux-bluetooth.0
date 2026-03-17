Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E2A386C3F
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779230; cv=none; b=AJHI8rONLfT4C9aY17Urhif/fLE1g2hXrjF8JV4FC3B16vPeokwWYnu6NROViAsCHkuGdZ293znUwOAEFxxBwHgxGw+KsbasCVEPpKPfU0GDYf9O3g4Wl/qJjk+N3XpKOoG/kVZEPKt+dzJ7FppAoSFnT1VH37Y1SprLxXAl4MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779230; c=relaxed/simple;
	bh=dilSWcoQLoJx8SkdH/gpph35YjlIS6DZymSgaPzBpnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IptSk74fZAGx9qu0qVqe74cPmijn/q6yYXzzkVYpWkypHdyqtc92lj+WoLGwWo9yYWAve5H2YiZiXBImJ3wfcCoZ0xNmd5XYrABR9S0FEZia6NucZJrc78Zg4yC4BmRcftCdkf3HHoqmtwZgPLcDfsSqNcVdtw5Vs4d7BDuLfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=Kj3hDCX8; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="Kj3hDCX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773779224; x=1774384024; i=martinbts@gmx.net;
	bh=9ygRQjjF32wqrGf8pfkJdA6UKAhrT9WDTvac3V7VA7o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Kj3hDCX8cfu+GS2LpSCqev9H3m+IQ3LxUKg0ixn3ukLcdSzqM3uPYVqKbtRkDArg
	 ZdT8rhWtmfVEo1FL/i8+gWEE8VJgOz9FZdjIEzpWtTJ39W3pdd1x3CP+YSiXPwWN0
	 yUR614+JSOEWlHWpUjQu/Vm7FC1IxxbvRh/9SDvfBqZSKvH9td5hCUNNrTL/vc1bg
	 XPRALhP8BkZHsHM7f73cECKdSptxGcd6UImBgZxfeCtaqldRJjwBBzcOuwJArgIzM
	 urNquAlmsL4ZT8Z1Q7eUIXoNQxCuAyRJaO0KGMqrz7awc4Zk/UWtfqtODEJW3OiUx
	 Zn30pMS4nBB4uwWuVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeMt-1w7HzP2n7D-00Ia3v; Tue, 17
 Mar 2026 21:27:04 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v3 0/6] BLE-HID/Nintendo Switch 2 support
Date: Tue, 17 Mar 2026 21:26:26 +0100
Message-ID: <20260317202637.158997-1-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OaXFlSusYd98T8VhFAlqw8aNKDtvqgtwCNGfp2ktRz3ALXmPTVu
 yXe0AW97DaeQNeEatIEoeEf+Q/AhW9wQY6mtjLPU/XW6Gz7aqiS4PaxNzGAeqaqQJRB/5hj
 sSeX/XIkBMO1sAULUkQRhFi+Skv1GRSujO79t18v3zT2mNnaUY6YL6faKJerNtmwuiCXqXA
 PP/0MiEK9Wxg/dSrkOhog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LKb3Igd3+jQ=;y9OPPMd+4JAT/rEloHy2zkvOttn
 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
 82l7BFHmWDnKuNtY+xsPLbNfMI9hy

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

