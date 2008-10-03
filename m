Return-Path: <cyrus@holtmann.org>
Subject: Re: Untrusted input devices by default
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Mario Limonciello <mario_limonciello@dell.com>,  "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1223015855.11272.34.camel@violet.holtmann.net>
References: <48E3F51B.6050001@dell.com>
	 <1223015855.11272.34.camel@violet.holtmann.net>
Content-Type: text/plain
Date: Fri, 03 Oct 2008 07:53:11 +0100
Message-Id: <1223016791.3328.9.camel@macbook.infradead.org>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2008-10-03 at 08:37 +0200, Marcel Holtmann wrote:
> 
> > In my efforts to get BlueZ 4.x into Intrepid a question was posed.  How
> > come input devices don't default to "Trusted" when paired in the
> > Wizard?  This makes for a weird experience the next time you reboot (or
> > disconnect the device for that matter) that you need to give it
> > "authorization".
> 
> that is a bug. We should set the input device as trusted after we
> connected to it. Any chance you have a patch for it?

I thought I was testing this a couple of weeks ago and it was working
fine.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
