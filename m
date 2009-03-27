Return-Path: <cyrus@holtmann.org>
Date: Sat, 28 Mar 2009 02:10:06 +0530 (IST)
From: pavan_savoy@indiatimes.com
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
Message-ID: <1831784371.90681238186406345.JavaMail.root@mbv7.indiatimes.com>
In-Reply-To: <35c90d960903261839q500b755cuc75c40e96e973225@mail.gmail.com>
Subject: Re: a2dp connection of HT820 vs. BT620s
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Nick,

I did post this on the android-group as well, I mentioned I get a "write blocked for ** msecs" when audio gap occurs.

Also, I tested Jabra with ubuntu's 3.16 bluez, it sounds funny [something to do with frequency, I suppose..], 
but no audio gap, basically same output as in Motorola head-set.

Also please elaborate on what part of Android plug-in do you suspect ? I would want to take a look into it.

regards,
Pavan


----- Original Message -----
From: Nick Pelly <npelly@google.com>
To: pavan savoy <pavan_savoy@indiatimes.com>
Cc: linux-bluetooth@vger.kernel.org
Sent: Fri, 27 Mar 2009 07:09:11 +0530 (IST)
Subject: Re: a2dp connection of HT820 vs. BT620s

On 3/26/09, pavan_savoy@indiatimes.com <pavan_savoy@indiatimes.com> wrote:
> Hi,
>
>  I am using android [bluez-3.36] and using a2dp over it. I observe that I get a lot of audio gaps, when I connect to headset "Jabra BT620s".
>
>  However when I connect to "Motorola HT820", everything seems fine, audio streaming is good.
>  I have the hcidump, when the Jabra was connected, and it kind of reads the same in terms of frequency, Stereo, block size as when connected to Motorola headset
>
>  What could be the problem ? Any inputs would help.

While I suspect this issue is specific to the Android a2dp audio
plugin, I would also be interested in hearing if the pulseaudio or
alsa plugin's have issues with Jabra headsets as Pavan describes.

Nick



--
Exclusive spy camera shots of the Tata Nano only on ZigWheels.com 
http://www.zigwheels.com/tata-nano/
