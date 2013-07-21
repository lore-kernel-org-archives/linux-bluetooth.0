Return-Path: <cyrus@holtmann.org>
Date: Sun, 21 Jul 2013 10:08:38 +0200
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: gustavo@padovan.org, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Subject: Re: [PATCH 3/8] Move device initialization and shutdown to
 tty_port_operations
Message-ID: <20130721080838.GA2998@sottospazio.it>
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it>
 <1373661649-1385-3-git-send-email-gianluca@sottospazio.it>
 <51E5B196.7010704@hurleysoftware.com>
 <20130720071059.GA28216@sottospazio.it>
 <51EA9AA6.3000000@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51EA9AA6.3000000@hurleysoftware.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Jul 20, 2013 at 10:11:50AM -0400, Peter Hurley wrote:
> Sorry Gianluca, I should have been more specific here.
> 
> There's no need to test for dlc->state == BT_CLOSED in carrier_raised().
> At the point where port->carrier_raised is called, the tty will have been
> linked with the file descriptor, so if the dlc->state goes to BT_CLOSED,
> then rfcomm_dev_state_change() will call
>   tty_hangup() -> driver hangup() -> tty_port_hangup() -> tty_port_shutdown()
> This call chain will
>   1. set the file_ops to hung_up_tty_fops which will cause tty_hung_up_p() to
>      return true
>   2. clear ASYNCB_INITIALIZED in port->flags
>   3. wakeup port->open_wait
> 
> So an open() parked in the schedule loop of tty_port_block_til_ready()
> will wake and exit the loop with either -EAGAIN or -ERESTARTSYS.
> 
> rfcomm_dev_state_change() should only do a wakeup on port->open_wait when
> dlc->state == BT_CONNECTED.
> 
> >In case of success I should also call some device_move,
> >rfcomm_tty_copy_pending and rfcomm_dlc_unthrottle. Could I do it in
> >carrier_raised directly?
> 
> I wouldn't. That would be a nasty hack and a potential problem if a
> signal occurred.
> 
> The device_move() isn't dependent on success, and can stay in .activate().

I changed the code and it's cleaner than before, very nice. However the
device_move() is really dependent on success: the parent device is there only
when the connection has been successfully established.

So I have to call that function after the carrier is raised, or right before.
Since you already told me that calling it in the .carrier_raised method is
unwise the only place left is the state_change callback of the dlc.

Conversely in .shutdown the check for the device parent == NULL takes care of
the scenario in which the aforementioned device_move() is never called.

Another unrelated question: I'm working on the rfcomm_dev_add function to avoid
the two nested locks. When the patch is ready should I send it separately or
can I include it with the other patches?

Thanks,
Gianluca
