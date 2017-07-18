Return-Path: <oneukum@suse.com>
Message-ID: <1500380982.502.12.camel@suse.com>
Subject: Re: [RFC PATCH v2] Bluetooth: btusb: Fix memory leak in
 play_deferred
From: Oliver Neukum <oneukum@suse.com>
To: jeffy <jeffy.chen@rock-chips.com>, Marcel Holtmann <marcel@holtmann.org>
Cc: briannorris@chromium.org, dianders@chromium.org, Johan Hedberg
	 <johan.hedberg@gmail.com>, xiyou.wangcong@gmail.com, "Gustavo F. Padovan"
	 <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Tue, 18 Jul 2017 14:29:42 +0200
In-Reply-To: <596DDB63.6010206@rock-chips.com>
References: <1500343579-9831-1-git-send-email-jeffy.chen@rock-chips.com>
	    <6E21F79E-93AA-4461-BA6B-67715501714F@holtmann.org>
	   <1500363015.16072.5.camel@suse.com> <596DC200.1080006@rock-chips.com>
	  <1500367310.502.0.camel@suse.com> <596DD6AE.2030704@rock-chips.com>
	 <1500370901.502.6.camel@suse.com> <596DDB63.6010206@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Am Dienstag, den 18.07.2017, 17:56 +0800 schrieb jeffy:
> Hi Oliver,
> 
> > I think that as soon as one URB fails, you should not even try
> > to submit any other deferred URBs. You are taking one out from
> > the middle of a sequence. That cannot be right.
> ok, that make sense.
> 
> new patch sent :)

Where to?

	Regards
		Oliver
