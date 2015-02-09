Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 9 Feb 2015 15:25:05 -0800
Message-ID: <CAHrH25QaW3kB5tvpgxs9L8pokbct096x6ifh7Gwu1EYHs-bZPw@mail.gmail.com>
Subject: GattManager1 and multiple-controllers
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

We had some discussion about this on IRC but I thought I'd gather
everything into an email and keep the discussion going on the mailing
list.

The question I have was regarding how bluetoothd should behave as a
GATT server when there are multiple controllers on the system. The
main things to figure out here are:

   1. Should there be a single global gatt_db or should there be a
gatt_db instance per-adapter? holtmann@ suggested that the latter
makes the most sense, since the spec always appears to talk always
about a host that acts on a single controller. With a single GATT
database, we get into undefined territory when multiple controllers
want to access it; for instance, if a service wants to send a
notification will that cause all attached controllers to send out the
same notification? Seems a bit strange.

   2. If gatt_db is per-adapter, then should GattManager1 be a global
interface or should it be on the adapter object? Basically, what
happens when an external application registers a service? Do we want
it to automatically show up in the databases of all local adapters?
Should the application be able to say which adapter to use? What if
some of the adapters are single-mode BR/EDR-only adapters?

I personally think that exposing the GattManager1 interface on each
adapter object is the simplest approach but a lot of people seem to
have voiced opinions on this, hence it would be nice to discuss this
here and figure out what makes the most sense.

Thanks!
Arman
