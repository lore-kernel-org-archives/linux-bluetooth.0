Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Dec 2013 21:20:44 +0100
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Alexander Holler <holler@ahsoftware.de>, marcel@holtmann.org,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org,
	jslaby@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] rfcomm (userland) broken by commit 29cd718b
Message-ID: <20131216202044.GA19746@sottospazio.it>
References: <1377620926-23370-1-git-send-email-gianluca@sottospazio.it>
 <20130919162413.GG4006@joana>
 <52AA1854.500@ahsoftware.de>
 <52AA1E62.1030109@hurleysoftware.com>
 <52AA483E.4080706@ahsoftware.de>
 <20131215112413.GA8980@sottospazio.it>
 <52ADB6B7.5010503@hurleysoftware.com>
 <20131215150847.GA10288@sottospazio.it>
 <52AF55B4.6000303@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52AF55B4.6000303@hurleysoftware.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Dec 16, 2013 at 02:34:12PM -0500, Peter Hurley wrote:
> 
> This solution is acceptable to me, but I think the comment should briefly
> explain why this fix is necessary, and the changelog should explain why in detail.
> 
> Perhaps with a fixme comment that rfcomm_tty_install() should just take over
> the port reference (instead of adding one) and rfcomm_tty_cleanup() should
> conditionally release on RFCOMM_RELEASE_ONHUP.
> 
> Because then:
> 1) this fix would not be necessary.
> 2) the release in rfcomm_tty_hangup() would not be necessary
> 3) the second release in rfcomm_release_dev would not be necessary
> 4) the RFCOMM_TTY_RELEASED bit could be removed
> 
> 
> Regards,
> Peter Hurley

Taking over the refcount in the install method would certainly look better. I'm
going to test it ASAP :D

But why getting rid of the release in in rfcomm_tty_hangup()?
We could lose the bluetooth connection at any time and the dlc callback
would have to hangup the tty (and release the port if necessary).

Also the RFCOMM_TTY_RELEASED bit should still be necessary if the port is
created without the RFCOMM_RELEASE_ONHUP flag.

Besides any process could release the port behind us (with the command rfcomm
release rfcomm1 for example).

Gianluca
