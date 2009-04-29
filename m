Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 29 Apr 2009 15:57:03 +0200
Subject: RE: FW: Upgrade bluez-4.17 to 4.36 - headset no longer works
Message-ID: <6AC5A55546F64545AE996F8200E3AC4EFCAB6E@NL0105EXC01V01.eur.slb.com>
References: <6AC5A55546F64545AE996F8200E3AC4EFCA329@NL0105EXC01V01.eur.slb.com>
 <2d5a2c100904260730v3598634boaee9ff24eb7bf45b@mail.gmail.com>
In-Reply-To: <2d5a2c100904260730v3598634boaee9ff24eb7bf45b@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


-----Original Message-----
From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
Sent: 26 April, 2009 18:30
To: John Frankish
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: FW: Upgrade bluez-4.17 to 4.36 - headset no longer works

Hi,

On Sun, Apr 26, 2009 at 6:54 AM, John Frankish <j-frankish@slb.com> wrote:

> Playing WAVE '/usr/local/share/sounds/alsa/Noise.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
> ALSA lib pcm_bluetooth.c:1607:(audioservice_expect) BT_START_STREAM failed : Success(0)
> ALSA lib pcm_bluetooth.c:1566:(audioservice_recv) Too short (1 bytes) IPC packet from bluetoothd

This normally indicates a mismatch version of ipc, iirc any failing
code will be EIO. You should make sure both audio plugin and alsa
plugin are compiled and installed with the same ipc.h, in the future
we can probably add a version check for ipc to really indicate what is
the real problem.

--
Luiz Augusto von Dentz
Engenheiro de Computação

------
Thanks for the reply, but I'm not sure I fully understand...

If the audio plugin and the alsa plugin are compiled at the same time, why wouldn't they use the same version of ipc.h ??
