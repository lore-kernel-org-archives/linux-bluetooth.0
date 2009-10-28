Return-Path: <cyrus@holtmann.org>
Subject: bluetooth-agent
From: =?ISO-8859-1?Q?Germ=E1n?= Pedrosa
	<german.pedrosa@fundacionctic.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain
Date: Wed, 28 Oct 2009 12:55:46 +0100
Message-Id: <1256730946.6820.14.camel@german-desktop>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am newbie with bluez and I'm developing a research project where I
need to use various Bluetooth USB-dongles.

I need to deploy an automatic bluetooth pairing by command line (it is a
project requirement), but the problem is that bluetooth-agent does only
listen to hci0 device (I mean, if in any case I need to pair with any
other dongle, bluetooth-agent does not reply).

Is there any possibility where bluetooth-agent could respond to the
other devices? The man page for bluetooth-agent is missing, and I have
not found any way to get it.

Thanks a lot and best regards.



