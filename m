Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <895461867.5591238086704517.JavaMail.root@mbv7.indiatimes.com>
References: <895461867.5591238086704517.JavaMail.root@mbv7.indiatimes.com>
Date: Thu, 26 Mar 2009 18:39:11 -0700
Message-ID: <35c90d960903261839q500b755cuc75c40e96e973225@mail.gmail.com>
Subject: Re: a2dp connection of HT820 vs. BT620s
From: Nick Pelly <npelly@google.com>
To: "pavan_savoy@indiatimes.com" <pavan_savoy@indiatimes.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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
