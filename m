Return-Path: <cyrus@holtmann.org>
Subject: Re: A2DP multiple sink support
From: Marcel Holtmann <marcel@holtmann.org>
To: Anil Sasidharan <anilvpr@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <f6c5b8d91001170450n415bf083l5044e193014d8f85@mail.gmail.com>
References: <f6c5b8d91001170441m1d0d8755x15147f92b85b477f@mail.gmail.com>
	 <f6c5b8d91001170450n415bf083l5044e193014d8f85@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 17 Jan 2010 12:41:03 -0800
Message-ID: <1263760863.5591.59.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anil,

>                 We are trying to use Bluecore BT module (from CSR) for
> A2DP profile support. In the present use case, our device acts as a
> A2DP SRC. We are able to stream 44.1kHz stereo audio to a A2DP
> headset. Now the next use case scenarios that we would like to try out
> in A2DP context are the following:

look at /etc/bluetooth/audio.conf for settings. You can configure it for
multiple sources.

The difference between same audio stream and different audio stream is
not really for bluetoothd itself to make. If it goes to a different
remote it has to transmit it separately anyway.

If you wanna optimize this, then using GStreamer and some kind of
mulitplexing magic of the stream could for same stream on different
targets to reduce the SBC encoding. Otherwise you have to encode the
stream twice.

This whole thing with one source adapter works, but during inquiry and
page it is almost impossible for a Bluetooth chip to transmit any data.
So expect some cracks in the audio until both connections are setup
properly.

Regards

Marcel


