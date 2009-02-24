Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Feb 2009 19:00:10 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: jayjwa <jayjwa@atr2.ath.cx>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: BT headset stops working
Message-ID: <20090224170010.GA21041@localhost>
References: <alpine.LNX.2.00.0902230153190.8142@nge2.ngu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.0902230153190.8142@nge2.ngu.pk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Feb 24, 2009, jayjwa wrote:
> ALSA lib pcm_bluetooth.c:1563:(audioservice_expect) BT_START_STREAM failed : Success(0)
> ALSA lib pcm_bluetooth.c:1531:(audioservice_recv) Bogus message type 5 - name received from audio service

The most common cause of messages like this is a mismatch between the
bluetooth alsa plugin and bluetoothd. Make sure they are both from the
same bluez version (hint: the alsa plugin is typically in
/usr/lib/alsa-lib).

> btusb_isoc_complete: hci0 corrupted SCO packet
>
> hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
> hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
> hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
> hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
> hci_scodata_packet: hci0 SCO packet for unknown connection handle 0

These look like kernel issues to me.

Johan
