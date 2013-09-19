Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Sep 2013 11:24:13 -0500
From: Gustavo Padovan <gustavo@padovan.org>
To: Gianluca Anzolin <gianluca@sottospazio.it>
Cc: peter@hurleysoftware.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org,
	jslaby@suse.cz
Subject: Re: [PATCH] rfcomm: don't release the port in
 rfcomm_dev_state_change()
Message-ID: <20130919162413.GG4006@joana>
References: <1377620926-23370-1-git-send-email-gianluca@sottospazio.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377620926-23370-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gianluca,

2013-08-27 Gianluca Anzolin <gianluca@sottospazio.it>:

> When the dlc is closed, rfcomm_dev_state_change() tries to release the
> port in the case it cannot get a reference to the tty. However this is
> racy and not even needed.
> 
> Infact as Peter Hurley points out:
> 
> 1. Only consider dlcs that are 'stolen' from a connected socket, ie.
>    reused. Allocated dlcs cannot have been closed prior to port
>    activate and so for these dlcs a tty reference will always be avail
>    in rfcomm_dev_state_change() -- except for the conditions covered by
>    #2b below.
> 2. If a tty was at some point previously created for this rfcomm, then
>    either
>    (a) the tty reference is still avail, so rfcomm_dev_state_change()
>        will perform a hangup. So nothing to do, or,
>    (b) the tty reference is no longer avail, and the tty_port will be
>        destroyed by the last tty_port_put() in rfcomm_tty_cleanup.
>        Again, no action required.
> 3. Prior to obtaining the dlc lock in rfcomm_dev_add(),
>    rfcomm_dev_state_change() will not 'see' a rfcomm_dev so nothing to
>    do here.
> 4. After releasing the dlc lock in rfcomm_dev_add(),
>    rfcomm_dev_state_change() will 'see' an incomplete rfcomm_dev if a
>    tty reference could not be obtained. Again, the best thing to do here
>    is nothing. Any future attempted open() will block on
>    rfcomm_dev_carrier_raised(). The unconnected device will exist until
>    released by ioctl(RFCOMMRELEASEDEV).
> 
> The patch removes the aforementioned code and uses the
> tty_port_tty_hangup() helper to hangup the tty.
> 
> Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
> ---
>  net/bluetooth/rfcomm/tty.c | 35 ++---------------------------------
>  1 file changed, 2 insertions(+), 33 deletions(-)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
