Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: David Llewellyn-Jones <david@flypig.co.uk>
Subject: BLE ad discoverability flags - missing when ads are generated, but
 needed when scanning
To: linux-bluetooth@vger.kernel.org
Message-ID: <68cc4a9b-5bbb-6dd0-3560-4de1594b8271@flypig.co.uk>
Date: Thu, 3 May 2018 17:32:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've been using bluez on a combination of an Ubuntu laptop running bluez
5.49 compiled from source and a Sailfish OS phone running the default
install bluez 5.47. On the laptop I'm using DBUS to interact with bluez;
on the phone I'm going via the QTBluetoothDiscoveryAgent interface,
running QT 5.6.

The difficulty I've been experiencing is that BLE advertisements sent
from the laptop in peripheral mode aren't being discovered by the phone.

I can see the advertisements being picked up by btmon on the phone, but
it doesn't filter up to the QT wrapper. Looking through the bluez source
code, it appears that the reason is because in the case of unfiltered
discovery, bluez ignores adverts that don't have either EIR_LIM_DISC or
EIR_GEN_DISC flags set, as in the following code:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/adapter.c?h=5.47#n5658

However, as far as I can tell (I could easily be wrong), bluez never
adds these flags into the advertising data. I was expecting to see them
added in the following bit of code:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/shared/ad.c#n423

As a result, I can't figure out a way to produce advertisements from my
laptop that can be picked up by my phone.

Adding the flags by calling the following function within
bt_ad_generate() with a value of 0x06 fixed the issue (i.e. allowed my
phone to discover my laptop).

static void serialize_flags(uint8_t value, uint8_t *buf, uint8_t *pos)
{
	if (value == 0)
		return;

	buf[(*pos)++] = sizeof(value) + 1;
	buf[(*pos)++] = EIR_FLAGS;
	buf[(*pos)++] = value;
}

My question is therefore whether there's a way for bluez to produce BLE
advertisements (on my laptop) that can be picked up by a non-filtered
scan using bluez (on my phone). I searched the Web and the list archives
but didn't find anything that seemed to help answer.

Thank you reading this far ("if indeed you still are", as Richard Ayoade
might say!).

David
-- 
Website: http://www.flypig.co.uk
