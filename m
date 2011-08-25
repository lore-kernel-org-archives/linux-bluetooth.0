Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <54172CBB083A479490A4625B74A68F82@freqoneremote>
References: <201108240807.09267.dstockwell@frequency-one.com>
	<CABBYNZLygk5nYnnLDL8zVcq52RReaWpK7jz+g46Ttdis5ZZjjQ@mail.gmail.com>
	<54172CBB083A479490A4625B74A68F82@freqoneremote>
Date: Thu, 25 Aug 2011 10:44:02 +0300
Message-ID: <CABBYNZL-DYMK=+RVWJkpvD9HscQ-21Hwq=Qt706WXk28CR4eAQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] AVRCP: Add Passthrough Signal
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: David Stockwell <dstockwell@frequency-one.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Thu, Aug 25, 2011 at 2:58 AM, David Stockwell
<dstockwell@frequency-one.com> wrote:
> +++++ OK, maybe a readwrite Passthrough property indicating how passthroughs
> are handled: Signal, Uinput, Both, None?  Or simply a PassthruSignal
> property (true/false, default false), given that the presence/absence of
> /dev/uinput handles the other case?
>
> I really think the Control should emit the signal...since it comes from a CT
> (and not really from a MediaPlayer or somesuch).

You are missing a very important point here, parsing of these vendor
specific commands would have to be split to each target thus we cannot
guarantee a consistent handling of them, if we stick to uinput I think
we should use KEY_VENDOR, otherwise we should send the commands
directly to the player.

-- 
Luiz Augusto von Dentz
