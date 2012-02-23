Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Feb 2012 10:27:22 +0100 (CET)
From: Pierre Frenkiel <pierre.frenkiel@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
cc: Pierre Frenkiel <pierre.frenkiel@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: using a bluetooth headset
In-Reply-To: <CAMOw1v6eNs8722rGo5PD7Pi_w3YXjFVibUMO2sEt0hFWae6Cfg@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1202231016050.13162@pfr2.frenkiel-hure.net>
References: <alpine.DEB.2.00.1202221723020.13556@pfr2.frenkiel-hure.net> <CAMOw1v6eNs8722rGo5PD7Pi_w3YXjFVibUMO2sEt0hFWae6Cfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 22 Feb 2012, Lucas De Marchi wrote:

> If you use pulseaudio, it should work out of the box.
   not really out of the box for me:
   I already tried with pulsaudio, without success.
   the command:
     pactl load-module module-alsa-sink device=btheadset
   gives
     Failure: Module initalization failed
   and all what I get after re-installing pulseaudio is that
   it no more works neither with skype nor aplay.

   Have you any doc about the exact config needed for pulseaudio to work?

-- 
Pierre Frenkiel
