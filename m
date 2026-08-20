Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A938333A711
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234393; cv=none; b=jDcfjOqxqw2uMsoH0PtYeGl4MY3YL0BTuOyT3LLWWmF2BRQhFjSUoWCmVnoLcRlZ3yUcb9idWxyoyGSHVmIlwG8k0aC7f7X8RLDAAwntDu05EMCfIVkCl557XUEEO10JtBamjKfknLbHMZ8m8nLUNxGTX2AuXbfYkuKzqjq+wJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234393; c=relaxed/simple;
	bh=noJyPldZrd42S8pgaOGMwh+T6dTALtDDvvepJZDzfgk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=grX05UlTzX1BOAYoROVImtMMbPbwdMkVIgzuSE+oKm7MQAPJt13dBkF9x2NaJ5dA2JJdTnmJfifgoKrnBKF7EfasTbzxj/Q+Wvhr8NA3pr4UI8GelxyKoqZRA766MrOPDmZ1W2fkU2xI+RcfsX8ZVJBGV6jF9HdI2YDW8h1KpRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id EAD203F519;
	Thu, 20 Aug 2026 13:59:46 +0000 (UTC)
Message-ID: <4131b2bc92a81467d11ce8bdf8748ace7e146514.camel@hadess.net>
Subject: Re: [PATCH BlueZ 0/4] Add component batteries and Fast Pair Message
 Stream
From: Bastien Nocera <hadess@hadess.net>
To: Matthias Kurz <m.kurz@irregular.at>, linux-bluetooth@vger.kernel.org
Date: Thu, 20 Aug 2026 15:59:46 +0200
In-Reply-To: <20260819223144.82045-1-m.kurz@irregular.at>
References: <20260819223144.82045-1-m.kurz@irregular.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTF9BlPYzyI1UH7GGWjwBP/Y1sGzmxdmbQkbppnckdMpgAITzMqCuQ6WaNsN5KMGDKXILTQ8xgvsV+/flS1DLNqAe8JDLB37wLc5DJ6qy54YYNnIycQGcJTtdtqD7Mx4rH7TMpjl37hS6+2jaV7+maylDZ/HEqW7AV8r3nbvOP6O7+L2nbyql57SRk+Nm6KVDab53GpS5Vq1Q2H62uo47dhaZdg5KrY0DC7OjD7O5VZQTDXWOB/a2q4q+RofcUeDm0bsyYIbXLBEPQAkH2fp8bKGNRM0TVyF+utk/jXNgQ9LtXUrHOk7pbHAkl6RcivJtWnupvYKVARtkIgVANxo7Z2htg0Ber49o/xspZiRXyfqpg20D5dVKHWrSBLVJsPYn+a1toecg7n3aahXFraRe4oxMpm33epkv+B62vHM+ohAdBB//jilKvbCcAEavvkWUnl+C/nqN105Sy5wf/4Pmjen2mINw1CATkwJ9/5iMEtAJIoQV5Ggw3nfoFdY8IaLaooqxCJKF9Kk3Lh6ZfHs8ng1yrCVRcNWaioRjcVNOxHDA+91iDqq9waOPTq/DjhzwFpr4sMWOZ/to1CBltr8x4O9P8z7550Lfu2rGyEz8gXXnfEUmGyg9Tj9z9CwGg5x7UUYlirhGu03I6UqJgZgQ5kVA5wY8mhTiYrLLvxzgMftXA

Hey Matthias,

I have a couple of very high-level comments about various patches, I'm
putting them here so as to avoid getting too deep into the details.

On Thu, 2026-08-20 at 00:31 +0200, Matthias Kurz wrote:
> True wireless earbuds can report separate charge states for the left
> bud,
> right bud, and charging case. Battery1 currently has one fixed object
> per
> Device1, so BlueZ cannot expose those values without collapsing them
> into
> one percentage.
>=20
> Extend the battery core and provider API to support child Battery1
> objects
> with a stable identifier, optional percentage, and optional charging
> state.
> The existing Battery1 object at the Device1 path remains the
> aggregate
> compatibility interface. Component objects and their new properties
> remain
> experimental.

I know of one direct consumer of the org.bluez.Battery1 interface, and
it's upower.

Did you verify whether your changes cause the current versions of
UPower any problems? Do you have any work planned on upower to add
support for those sub-devices?

I think that it might be very useful to show how exactly D-Bus objects
appear on the bus, as well their paths, interfaces and properties, so
people without the hardware can reproduce "mock" versions using python-
dbusmock:
https://github.com/martinpitt/python-dbusmock

This is most likely what I would do to be able to test gnome-
bluetooth's battery information, where it coalesces info from both
bluetoothd and upower to show battery info next to Bluetooth devices.

>=20
> Add an experimental Fast Pair Message Stream profile which connects
> to the
> advertised RFCOMM service and publishes its left, right, and case
> battery
> updates through the new component objects. The generic unknown-level
> status
> bit is retained for earbuds. Treat the TWS-specific case value 0xff
> as
> unavailable.

I've seen some magic numbers appearing in the implementation. It might
be useful to have those defined in a header which you can reference in
the tests.

> If the Message Stream closes while BR/EDR remains connected,
> invalidate the
> values and reconnect with exponential backoff. Reset the backoff only
> after
> a battery-producing stream remains connected for the maximum backoff
> interval, and do not retry permanent local errors. Once BR/EDR
> disappears,
> cancel pending work and remove the component objects. The final patch
> adds
> a standalone diagnostic and provider tool for interoperability
> testing.
>=20
> This was tested with Pixel Buds Pro using an ASan/UBSan build. The
> live
> tests covered fresh left/right/case reports, an unavailable case
> value,
> explicit Message Stream disconnection, remote device disconnection,
> reconnection, adapter power-down, and cancellation of a profile
> connection
> in progress. Component properties were invalidated or removed as
> appropriate, and the daemon reported no sanitizer failure.
>=20
> The full 40-test make check suite passes under ASan/UBSan. The Fast
> Pair
> parser tests cover payload fragmentation, a complete frame followed
> by a
> partial frame, invalid input, a zero-length frame, the maximum 65535-
> byte
> payload, unknown-level status bits, the unavailable-case sentinel,
> and
> reserved battery values. The Python tool compiles and its matching
> decoder
> was checked directly.

Tests are great, but what's the coverage like? :)

Cheers

>=20
> Matthias Kurz (4):
> =C2=A0 battery: Add component battery objects
> =C2=A0 doc: Document component battery objects
> =C2=A0 fastpair: Add Message Stream battery profile
> =C2=A0 test: Add Fast Pair Message Stream tool
>=20
> =C2=A0.gitignore=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 8 +
> =C2=A0Makefile.plugins=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
> =C2=A0Makefile.tools=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 2 +-
> =C2=A0doc/org.bluez.Battery.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 35 +-
> =C2=A0doc/org.bluez.BatteryProvider.rst=C2=A0 |=C2=A0 16 +
> =C2=A0profiles/fastpair/fastpair.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
650
> +++++++++++++++++++++++++++++
> =C2=A0profiles/fastpair/message-stream.c | 129 ++++++
> =C2=A0profiles/fastpair/message-stream.h |=C2=A0 42 ++
> =C2=A0src/battery.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
401 +++++++++++++++---
> =C2=A0src/battery.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 4 +
> =C2=A0test/test-fastpair=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 561 ++++++++++++++++++++=
+++++
> =C2=A0unit/test-fastpair.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 286 +++++++++++++
> =C2=A013 files changed, 2079 insertions(+), 61 deletions(-)
> =C2=A0create mode 100644 profiles/fastpair/fastpair.c
> =C2=A0create mode 100644 profiles/fastpair/message-stream.c
> =C2=A0create mode 100644 profiles/fastpair/message-stream.h
> =C2=A0create mode 100755 test/test-fastpair
> =C2=A0create mode 100644 unit/test-fastpair.c
