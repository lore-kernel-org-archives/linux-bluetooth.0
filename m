Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: multiple headsets for voice conference
To: Sebastian Hilbert <sebastian.hilbert@gmx.net>,
        linux-bluetooth@vger.kernel.org
References: <5473190.yLOflKejXQ@basti-thinkpad-t410>
From: David Teller <dteller@mozilla.com>
Message-ID: <f01abc0e-33c2-b4e8-c513-0951ee58f1a4@mozilla.com>
Date: Fri, 14 Oct 2016 22:23:51 +0200
MIME-Version: 1.0
In-Reply-To: <5473190.yLOflKejXQ@basti-thinkpad-t410>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

   Hi Sebastian,

 Newbie here: I have (very briefly) attempted to do something similar
and it was suggested to me that ofono, which is a higher-level API on
top of BlueZ, was a better starting point.

Hope this helps.

Cheers,
 David

On 14/10/16 21:59, Sebastian Hilbert wrote:
> Hi,
> 
> I was wondering if the following can be built using bluez. I would like two or 
> more people to communicate in something like a voice conference while wearing 
> BT headsets. 
> 
> I imagine that one can connect multiple BT dongles to a PC and pair each 
> headset with one dongle.
> 
> As far as I know ALSA can be used to setup the audio devices. Likely a 
> soundserver such as JACK2 can be used to manage the audio routing.
> 
> Is this the right path ? Or is there another/better way to establish a voice 
> connection between multiple headset units ?
> 
> Any pointers are appreciated.
> 
> Sebastian 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
