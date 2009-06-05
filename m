Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluetooth Headset not working with Linux2.6.28 ubuntu Intrepid
From: Marcel Holtmann <marcel@holtmann.org>
To: Benjamin Vasanthakumar J <j.benjamin@gdatech.co.in>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4A293628.3090105@gdatech.co.in>
References: <4A251CA6.5090205@gdatech.co.in>
	 <4A293628.3090105@gdatech.co.in>
Content-Type: text/plain
Date: Fri, 05 Jun 2009 17:21:36 +0200
Message-Id: <1244215296.23850.65.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Benjamin,

no top posting on the mailing list. This is a requirement and not a
recommendation.

> Can anyone tell whether snd-bt-sco driver and the btsco application are 
> still supported in the Linux 2.6.28 and Bluez latest versions?

They haven't been supported for over 3 years. And most likely will not
work or crash your system.

> Which are the required ALSA driver for the Bluetooth audio to work?

The bluetoothd comes with plugins for ALSA and GStreamer and PulseAudio
has a native plugin, too.

Regards

Marcel


