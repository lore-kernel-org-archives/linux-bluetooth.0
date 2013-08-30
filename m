Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Aug 2013 19:49:16 +0200
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Alexander Holler <holler@ahsoftware.de>, gustavo@padovan.org,
	marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	gregkh@linuxfoundation.org, jslaby@suse.cz
Subject: Re: [PATCH v5 0/6] rfcomm: Implement rfcomm as a proper tty_port
Message-ID: <20130830174916.GA7204@sottospazio.it>
References: <1375110493-5237-1-git-send-email-gianluca@sottospazio.it>
 <51F94E67.3040402@hurleysoftware.com>
 <52127E0A.6060208@hurleysoftware.com>
 <521CB03B.1030003@ahsoftware.de>
 <521CE6E1.2020206@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <521CE6E1.2020206@hurleysoftware.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 27, 2013 at 01:50:25PM -0400, Peter Hurley wrote:
> On 08/27/2013 09:57 AM, Alexander Holler wrote:
> >Am 19.08.2013 22:20, schrieb Peter Hurley:
> >>On 07/31/2013 01:50 PM, Peter Hurley wrote:
> >
> >>>I reviewed these changes and retested. All ok.
> >>
> >>Gustavo,
> >>
> >>This series fixes a crashing regression from 3.10+ forward.
> >>Why is this not in linux-next yet?
> >
> >3.8+ to be exact, just in case someone has to deal with older kernels.
> 
> Thanks for the reminder.
> 
> This series is too extensive to consider for -stable. Any ideas for
> how to address this crash for -stable?
> 
> Regards,
> Peter Hurley
> 

The tty refcount patch is needed but clearly not sufficient because the system
locks up when the device is released.

Unfortunately I cannot capture any oops, this is why I went and implemented the
tty port methods in the first place, inspired by the usb serial code.

I agree the patches are extensive and a solution is needed not only for 3.10
kernels but also for 3.11.

It's not clear for me how to debug the old code further. A couple of patches
to make the debug process easier were mentioned before but I cannot find
them. Could anybody point me at them?

Thank you,

Gianluca
