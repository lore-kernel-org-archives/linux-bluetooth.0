Return-Path: <cyrus@holtmann.org>
Message-ID: <1F0E337666E14ACEB2FF4AA1846273F6@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>, <johan.hedberg@gmail.com>
References: <201108240807.09267.dstockwell@frequency-one.com><CABBYNZLygk5nYnnLDL8zVcq52RReaWpK7jz+g46Ttdis5ZZjjQ@mail.gmail.com><54172CBB083A479490A4625B74A68F82@freqoneremote> <CABBYNZL-DYMK=+RVWJkpvD9HscQ-21Hwq=Qt706WXk28CR4eAQ@mail.gmail.com>
In-Reply-To: <CABBYNZL-DYMK=+RVWJkpvD9HscQ-21Hwq=Qt706WXk28CR4eAQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] AVRCP: Add Passthrough Signal
Date: Thu, 25 Aug 2011 07:45:59 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, Luiz

-----Original Message----- 
From: Luiz Augusto von Dentz
Sent: Thursday, August 25, 2011 2:44 AM
To: David Stockwell
Cc: linux-bluetooth@vger.kernel.org ; johan.hedberg@gmail.com
Subject: Re: [PATCH 3/3] AVRCP: Add Passthrough Signal

Hi David,

On Thu, Aug 25, 2011 at 2:58 AM, David Stockwell
<dstockwell@frequency-one.com> wrote:
> +++++ OK, maybe a readwrite Passthrough property indicating how 
> passthroughs
> are handled: Signal, Uinput, Both, None?  Or simply a PassthruSignal
> property (true/false, default false), given that the presence/absence of
> /dev/uinput handles the other case?
>
> I really think the Control should emit the signal...since it comes from a 
> CT
> (and not really from a MediaPlayer or somesuch).

You are missing a very important point here, parsing of these vendor
specific commands would have to be split to each target thus we cannot
guarantee a consistent handling of them, if we stick to uinput I think
we should use KEY_VENDOR, otherwise we should send the commands
directly to the player.

+++++
Actually, I expected that the routing of these passthroughs would be handled 
outside BlueZ, from Control(s) to (whatever) media playing app(s) in a 
supervisory app/daemon.  Whether the signal is issued from the Control or 
from the MediaPlayer interface is not significant to me; an easy code change 
in the patch and in my supervisory app.  Any additional thoughts or 
comments?
+++++
-- 
Luiz Augusto von Dentz 

