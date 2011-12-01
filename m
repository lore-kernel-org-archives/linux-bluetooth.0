Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <939a364c4487c47a6293b8584613af80@optimaster.eu>
References: <939a364c4487c47a6293b8584613af80@optimaster.eu>
Date: Thu, 1 Dec 2011 09:39:47 +0200
Message-ID: <CABBYNZ+jerHKHri41gF+FytB7so9tHofpvPPhrQEobwF2pae+Q@mail.gmail.com>
Subject: Re: Cracking Sound
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: krisztian.kocsis@optimaster.eu
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 30, 2011 at 9:27 PM,  <krisztian.kocsis@optimaster.eu> wrote:
> Hi!
>
> I'm trying to get bluetooth audio working on a PowerPC machine, but it has
> some strange effects.
> I'm using a bluetooth headset (HSP profile) via ALSA but it seems that it
> has some problem with various sample rates and other data related stuff.
> The asound.conf contains the appropriate device address, profiles is set to
> voice, device is named as 'btheadset' (the share/alsa/bluetooth.conf is also
> included).
>
> In BlueZ's output it seems that is is playing (statu is PLAY_IN_PROGRESS or
> PLAYING - I don't remember correctly) the stream.
> When BlueZ is connecting to the device I hear a beep in the headset but the
> "stream" is only a cracking, clicking and poping noise, nothing from the
> original sound.
> Also this sound comes if I force aplay to 4KHz or 8KHz, in other settings or
> without forcing, it plays nothing (no sound, only beeps).
>
> Do somebody know which problem can cause this side effect?
>
> I' using ALSA 1.0.24 and BlueZ 4.96 (both are untouched, no patches and no
> config file modifications - except that I had to create an asound.conf).
>
> Is anything else I can provide about the problem?

ALSA plugin is consider deprecated since Media became the default API
for requesting audio transport, in the future it will probably be
removed as alsa plugin architecture do not allow a sane integration
with mainloops necessary for Media API.

If possible use PulseAudio.

-- 
Luiz Augusto von Dentz
