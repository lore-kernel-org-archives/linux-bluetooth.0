Return-Path: <cyrus@holtmann.org>
Message-ID: <54172CBB083A479490A4625B74A68F82@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>, <johan.hedberg@gmail.com>
References: <201108240807.09267.dstockwell@frequency-one.com> <CABBYNZLygk5nYnnLDL8zVcq52RReaWpK7jz+g46Ttdis5ZZjjQ@mail.gmail.com>
In-Reply-To: <CABBYNZLygk5nYnnLDL8zVcq52RReaWpK7jz+g46Ttdis5ZZjjQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] AVRCP: Add Passthrough Signal
Date: Wed, 24 Aug 2011 18:58:58 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

-----Original Message----- 
From: Luiz Augusto von Dentz
Sent: Wednesday, August 24, 2011 5:47 PM
To: David Stockwell
Cc: linux-bluetooth@vger.kernel.org ; johan.hedberg@gmail.com
Subject: Re: [PATCH 3/3] AVRCP: Add Passthrough Signal

Hi David,

On Wed, Aug 24, 2011 at 4:07 PM, David Stockwell
<dstockwell@frequency-one.com> wrote:
> [PATCH 3/3] AVRCP: Add Passthrough Signal
>
> Send Passthrough signal, not only for simple keystrokes,
> but especially for Vendor Unique key, passing company-id
> and vendor-unique string as well.

I would like to do this differently, with target/controller/player
registering themselves to avoid having to blindly emit signals like
this which can no effect at all or loop effect, this should also make
us able to detect if there are multiple entities and address them
properly which is needed for 1.4.

+++++ OK, maybe a readwrite Passthrough property indicating how passthroughs 
are handled: Signal, Uinput, Both, None?  Or simply a PassthruSignal 
property (true/false, default false), given that the presence/absence of 
/dev/uinput handles the other case?

I really think the Control should emit the signal...since it comes from a CT 
(and not really from a MediaPlayer or somesuch).

-- 
Luiz Augusto von Dentz 

