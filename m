Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Ken Mandelberg <km@mathcs.emory.edu>
Subject: Bluetooth connect to Google Home?
Message-ID: <afdf0587-5e02-4df0-2ea8-17b137454576@mathcs.emory.edu>
Date: Fri, 19 Jan 2018 13:09:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Google Home speakers offer bluetooth connectivity which works with 
Android phones and tablets. I don't have IOS devices but I presume they
work too.

When I try to pair with bluez based bluetooth on Linux on my very first 
try it wants a pin. I try one of the generic pins and it fails. 
Subsequent pairing attempts fail but never ask for a PIN again.

After a long timeout bluetoothctl shows

Failed to pair: org.bluez.Error.AuthenticationCanceled

Info shows

Device E4:F0:42:60:85:DF
	Name: Office speaker
	Alias: Office speaker
	Class: 0x5e0400
	Icon: audio-card
	Paired: no
	Trusted: no
	Blocked: no
	Connected: no
	LegacyPairing: no
	UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
	UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
	UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
	UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
	UUID: Google                    (0000fe9f-0000-1000-8000-00805f9b34fb)

Any way to workaround?

