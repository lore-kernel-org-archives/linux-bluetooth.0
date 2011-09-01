Return-Path: <cyrus@holtmann.org>
Message-ID: <4E5F1DD6.2090102@bluewatersys.com>
Date: Thu, 01 Sep 2011 17:53:26 +1200
From: Andre Renaud <andre@bluewatersys.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: PCM audio output
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
I am working with an embedded device which has a Marvell 8688 based
bluetooth chip. We would like to use an external headset, but rather
than have the audio be transmitted over the HCI layer, we'd like it to
be sent directly out the PCM lines from the bluetooth chip, thus Linux
really doesn't see any audio data, but is responsible for setting up the
link/keys/authentication etc...

Are there any instructions on how to go about this? I've had a quick
look around, and this doesn't seem to be a particularly popular
configuration.

Regards,
Andre
