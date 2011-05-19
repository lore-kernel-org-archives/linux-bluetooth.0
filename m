Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 19 May 2011 17:56:18 +0530
Message-ID: <BANLkTi=xGCsnyzdQK=w6qYp6dJE4tg6fHA@mail.gmail.com>
Subject: Audio streaming to 2 A2DP headsets
From: Vijayalakshmi N <vijayalakshmi.nk@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

We have a requirement of establishing A2DP connections to 2 headsets
simultaniously (on android).

After changing the audio.conf with SBCSources=2, I am able to connect
to 2 devices from DBUS (audio.sink).
But this establishes the Signaling channels only.

And the data channel is established when the Media player plays the audio.

But the audio is streamed to only the first device.

Is it possible to establish the data channel to the 2nd device also
and stream the audio on bluez?

Could anyone please give a hint on this?

Thanks,
Vijayalakshmi
