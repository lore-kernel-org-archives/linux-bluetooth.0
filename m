Return-Path: <cyrus@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <0F7448E5-26BB-444D-8851-3FE66705FA28@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: "Li, Zhigang" <zhigang.li@intel.com>
In-Reply-To: <722F286E5CF54C459DDA462B750B07CE0C273E67E8@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain; charset=GB2312; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: headset doesn't work with mplayer in fc9
Date: Thu, 30 Oct 2008 19:05:00 +0100
References: <722F286E5CF54C459DDA462B750B07CE0C273E67E8@pdsmsx502.ccr.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zhigang,

>
> I have one problem with mplayer£º    
> mplayer -ao alsa:device=Bluetooth file.mp3
>
> There always display the errors:
>
> [AO_ALSA] alsa-lib: pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM  
> bluetooth
>
> [AO_ALSA] Playback open error: No such file or directory
>
> Could not open/initialize audio device -> no sound.
>
> Audio: no sound
>
> Video: no video
>
>
> But the mplayer work fine
>
> Also I can use aplay:  aplay works fine with Bluetooth headset.
>
> Perhaps I didn't set right configuration someone have the same  
> problem or idea?
>
>
>
> My OS is FC9
>
> bluez-libs-devel-3.30-1.fc9.i386
>
> bluez-utils-alsa-3.30-2.fc9.i386
>
> bluez-utils-gstreamer-3.30-2.fc9.i386
>
> bluez-libs-3.30-1.fc9.i386
>
> bluez-utils-3.30-2.fc9.i386

and the latest release is bluez-4.17. So you have too many versions  
behind what we are currently using and what all new distros are using.  
So please re-test with the latest versions please.

Regards

Marcel

