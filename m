Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Jul 2013 19:05:00 +0200
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: gustavo@padovan.org, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Subject: Re: [PATCH 6/8] Fix the reference counting of tty_port
Message-ID: <20130717170500.GA10640@sottospazio.it>
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it>
 <1373661649-1385-6-git-send-email-gianluca@sottospazio.it>
 <51E6A3F7.20202@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51E6A3F7.20202@hurleysoftware.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jul 17, 2013 at 10:02:31AM -0400, Peter Hurley wrote:
> >
> >@@ -687,7 +665,9 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
> >  					return;
> >  				}
> >
> >-				rfcomm_dev_del(dev);
> >+				set_bit(RFCOMM_TTY_RELEASED, &dev->flags);
> >+				tty_port_put(&dev->port);
> >+
> >  				tty_port_put(&dev->port);
> >  				rfcomm_dlc_lock(dlc);
> >  			}
> 
> While this is functionally correct, it ignores the larger issue in
> rfcomm_dev_state_change(); namely, what prevents the rfcomm_dev from being
> destructed immediately after
> 
> 	struct rfcomm_dev *dev = dlc->owner;
> 
> If the answer to that question is the dlc lock, then the whole function is
> _broken_.
> 
> No amount of reference counting will prevent the rfcomm_dev destructor
> from completing once the dlc lock is dropped. (Presumably the dlc is not
> subject to destruction once the lock is dropped. Is this true?)
> 
> This means:
> 1. Holding the dlc lock from the caller is pointless and should be dropped.
> 2. Some other solution is required to either preserve rfcomm_dev lifetime
>    or determine that destruction is already in progress.

I'm afraid I lied in the commit message: there are three places where the
tty_port may be released and the code above is the third one.

I wrote that message because at first I wanted to remove that code path but
then noticed I shouldn't.

Maybe we can simply save the dev->id before releasing the lock and then feed
that integer to rfcomm_dev_get? After all if the destruction is in progress
rfcomm_dev_get(id) == NULL and we return immediately. Otherwise we release the
tty_port.

Gianluca
