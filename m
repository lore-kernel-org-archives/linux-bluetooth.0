Return-Path: <cyrus@holtmann.org>
Date: Sat, 27 Jul 2013 06:48:09 +0200
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: gustavo@padovan.org, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org,
	jslaby@suse.cz
Subject: Re: [PATCH v4 5/6] rfcomm: Fix the reference counting of tty_port
Message-ID: <20130727044809.GA22696@sottospazio.it>
References: <1374859138-19467-1-git-send-email-gianluca@sottospazio.it>
 <1374859138-19467-6-git-send-email-gianluca@sottospazio.it>
 <51F3125F.30303@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51F3125F.30303@hurleysoftware.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jul 26, 2013 at 08:20:47PM -0400, Peter Hurley wrote:
> On 07/26/2013 01:18 PM, Gianluca Anzolin wrote:
> >@@ -614,7 +601,9 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
> >  					return;
> >  				}
> >
> >-				rfcomm_dev_del(dev);
> >+				set_bit(RFCOMM_TTY_RELEASED, &dev->flags);
> >+				tty_port_put(&dev->port);
> 
> Since this code can execute concurrently with rfcomm_release_dev(),
> and the 'initial' port reference must only be dropped once, this should be
> 
> 				if (!test_and_set_bit(RFCOMM_TTY_RELEASED, &dev->flags)
> 					tty_port_put(&dev->port);
> 
> Regards,
> Peter Hurley

I somehow convinced myself that it was safe but clearly it wasn't. Should I
also change the same way the code in rfcomm_tty_hangup()?

Thanks,

Gianluca
