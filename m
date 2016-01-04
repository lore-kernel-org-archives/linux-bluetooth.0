Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1451921293.8726.9.camel@hadess.net>
Subject: Powered property and rfkill
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 04 Jan 2016 16:28:13 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

I was wondering the reasoning behind the recent changes in rfkill
handling for hci interfaces, in particular the addition
of MGMT_STATUS_RFKILLED as an error message.

Before those changes (for which I couldn't find an initial kernel side
commit), the Powered state of the adapter was tied to its rfkill
status.

When a soft rfkilled device showed up, which was to be the default
adapter, bluetoothd would remember that it was powered, and unrfkill
it. If the state was unpowered, or it had been rfkilled, GNOME's
Bluetooth panel would set Powered to true, un-rfkill'ing the adapter.

In 99% of cases, this meant that plugging in a Bluetooth adapter would
work out of the box.

Now, bluetoothd doesn't remember the power state, and the rfkill isn't
tied to the Powered state. Calling to set the Power state will fail
with the "Blocked" error, and we're expecting something else to unset
the adapter's rfkill status.

What did the developers making those changes hope that would unrfkill
and power up the adapter when plugged in?

Note that this might be a side-effect of the machine I'm using which
has 2 layers of Bluetooth rfkill:
$ rfkill list bluetooth
0: tpacpi_bluetooth_sw: Bluetooth
	Soft blocked: no
	Hard blocked: no
4: hci0: Bluetooth
	Soft blocked: yes
	Hard blocked: no

hci0 won't be visible if tpacpi_bluetooth_sw is soft-killed. The work-
around I have planned is to wait for "hci*" to appear if the Bluetooth
rfkill we unset doesn't start with "hci".

Any better ideas?

Cheers
