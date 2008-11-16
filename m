Return-Path: <cyrus@holtmann.org>
Message-ID: <4920929A.30703@powercraft.nl>
Date: Sun, 16 Nov 2008 22:37:30 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: Brad Midgley <bmidgley@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: possible sbc codec bug with audio glitches
References: <4920099A.9030109@powercraft.nl> <d89ddf300811160629v29a0602cgdfcf25ade32c4cfc@mail.gmail.com>
In-Reply-To: <d89ddf300811160629v29a0602cgdfcf25ade32c4cfc@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------040206000806070906010204"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040206000806070906010204
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Brad Midgley wrote:
> Jelle
> 
>> The strange thing is that I can only hear the glitches on the right side
>> of the headset.
> 
> That is very strange it is only on one side. Do you know if you were
> you using the joint stereo setting in the codec?
> 

Thank you Brad for taking the time to read and answer to my question,
this is really appreciated. I dont exactly know what you mean with joint
stereo settings in the code?

I use the bluez git build on 2008-11-06. The only info I got is from the
bluetoothd running in debug mode, please see the attachment for more
information.

I hope the below section is the most relevant?

config a2dp - device = 00:0C:55:D1:C9:78 access_mode = 2
codec sbc - frequency = 1 channel_mode = 1 allocation = 1 subbands = 1
blocks = 1 bitpool = 44
a2dp_source_config: selected SEP 0xb81b1020
avdtp_ref(0xb81acbf0): ref=3
setup_ref(0xb81b62a8): ref=1
avdtp_set_configuration(0xb81acbf0): int_seid=1, acp_seid=1

Thanks in advance,

Jelle

--------------040206000806070906010204
Content-Type: application/x-gzip;
 name="bluez-glitches-debug.txt.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="bluez-glitches-debug.txt.tar.gz"

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
--------------040206000806070906010204--
