Return-Path: <oneukum@suse.com>
Message-ID: <1500370901.502.6.camel@suse.com>
Subject: Re: [RFC PATCH v2] Bluetooth: btusb: Fix memory leak in
 play_deferred
From: Oliver Neukum <oneukum@suse.com>
To: jeffy <jeffy.chen@rock-chips.com>, Marcel Holtmann <marcel@holtmann.org>
Cc: briannorris@chromium.org, dianders@chromium.org, Johan Hedberg
	 <johan.hedberg@gmail.com>, xiyou.wangcong@gmail.com, "Gustavo F. Padovan"
	 <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Tue, 18 Jul 2017 11:41:41 +0200
In-Reply-To: <596DD6AE.2030704@rock-chips.com>
References: <1500343579-9831-1-git-send-email-jeffy.chen@rock-chips.com>
	   <6E21F79E-93AA-4461-BA6B-67715501714F@holtmann.org>
	  <1500363015.16072.5.camel@suse.com> <596DC200.1080006@rock-chips.com>
	 <1500367310.502.0.camel@suse.com> <596DD6AE.2030704@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Am Dienstag, den 18.07.2017, 17:36 +0800 schrieb jeffy:
> Hi Oliver,
> 
> On 07/18/2017 04:41 PM, Oliver Neukum wrote:
> > 
> > Am Dienstag, den 18.07.2017, 16:08 +0800 schrieb jeffy:
> > > 
> > > > 
> > > > I am afraid not. We cannot silently drop one part of a transmission.
> > > > I am afraid that the correct algorithm, if we encounter an error at
> > > > that stage, is to abort the operation and report an error.
> > > > 
> > > so i should break the loop when error happens right?
> > 
> > Yes
> ok, i'll do that.
> > 
> > 
> > > 
> > > 
> > > and i uploaded 2 version of patches, which one do you prefer to go on?
> > 
> > Where to?
> https://patchwork.kernel.org/patch/9847037
> and
> https://patchwork.kernel.org/patch/9846617

I think that as soon as one URB fails, you should not even try
to submit any other deferred URBs. You are taking one out from
the middle of a sequence. That cannot be right.

	Regards
		Oliver
