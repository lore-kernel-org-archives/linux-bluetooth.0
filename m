Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <A2B80C7C-697D-44E5-80EA-B398E62EE608@warski.org>
References: <6E6C1573-4744-486B-B2E6-2D3DC45D024B@warski.org>
	<CAJdJm_PMAVyiY-=13puBHAucCzObUWOSOXZ+maOL2z11YwOh-g@mail.gmail.com>
	<A4DDF6F3-8DD4-4CF7-A5C0-205F5B4EE489@warski.org>
	<CAJdJm_PN3xGjdNOtr3o-J0SJ8N6MJXBChUCwOWOZBrdFKDBfGA@mail.gmail.com>
	<407CD6A9-AFA8-4A8A-BA2C-882D7A64EF40@warski.org>
	<0BA8DEFD-9E73-4A6A-A9E6-1957634CABF8@warski.org>
	<CAJdJm_P6gnpW5AhO9j4+LV6KX30J4sTWd_tWW=x=E+ejQq3cTQ@mail.gmail.com>
	<A2B80C7C-697D-44E5-80EA-B398E62EE608@warski.org>
Date: Mon, 3 Mar 2014 19:07:19 -0400
Message-ID: <CAJdJm_MXR08tvceb0-vHT=VD+dKY_dz2MbkO3eaUoBneeFxXMA@mail.gmail.com>
Subject: Re: Passive scanning of iBeacons results in a "Data Buffer Overflow"
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Adam Warski <adam@warski.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

On Mon, Mar 3, 2014 at 5:25 PM, Adam Warski <adam@warski.org> wrote:
> But I guess even if it was a USB issue, it would be caught earlier? The advertisement packets have a certain preamble, and a CRC, so the shifted data would be discarded? Anyway, that doesn't seem to be the cause.

There are are a few things that point out to USB issue (in my opinion):

1) You said that having ethernet cable connected or not modifies the
behavior. on RPI, the ethernet chip is attached to the USB. As I said,
strange things happen to me as well when not using powered USB hub
(specially with WiFi dongles and USB cameras) :)

2) As you noticed, the "truncated" adv. packet is not being discarded
by the controller as we would expect. This means that the BT
controller is actually receiving a correct packet, but it is being
"truncated" when being sent to the host. The CRC/preamble, after
parsed and verified by the BT controller, is removed before sending
the packet to the host, so there is no way for the host do detect
corruptions between the BT controller and the kernel.

The dynamic debug messages may help identify whether there are
missing/truncated USB packets (there is a debug message in
btusb_intr_complete() from drivers/bluetooth/btusb.c to help identify
HCI reassembly issues).

Did you try using only the BT dongle and removing the Wifi one (and
connecting through ethernet cable)? Wifi dongles tend to be very power
hungry.

Also check whether the power source for the USB hub is working
properly... unfortunately I don't know how to check from the RPi side,
so you have to rely on first attaching it to the outlet, checking some
LED, and then attaching to the RPi. Also make sure the RPi uses its
own power adapter (instead of powering from the hub itself).

Well, at least you found a workaround (attaching an ethernet cable) :)

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
