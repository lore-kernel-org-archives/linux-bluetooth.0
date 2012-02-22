Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1202221723020.13556@pfr2.frenkiel-hure.net>
References: <alpine.DEB.2.00.1202221723020.13556@pfr2.frenkiel-hure.net>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 22 Feb 2012 18:15:26 -0200
Message-ID: <CAMOw1v6eNs8722rGo5PD7Pi_w3YXjFVibUMO2sEt0hFWae6Cfg@mail.gmail.com>
Subject: Re: using a bluetooth headset
To: Pierre Frenkiel <pierre.frenkiel@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Feb 22, 2012 at 2:35 PM, Pierre Frenkiel
<pierre.frenkiel@gmail.com> wrote:
> hi everybody,
> I'm trying to use a Motorola bluetooth headset, and the only programs for
> which it works are Skype and aplay.
> The pairing worked perfectly with blueman-manager.
> Skype uses the alsa config file .asoundrc, and aplay needs the
> -D bluetooth flag.
> Impossible to make it to work with any other program (vlc, rhytmbox,
> xine, totem, ...)
> I tried several tricks found in several forums, but none worked.
> Had anybody a better result?
> PS: My OS is Debian/Squeeze.

If you use pulseaudio, it should work out of the box.


Lucas De Marchi
