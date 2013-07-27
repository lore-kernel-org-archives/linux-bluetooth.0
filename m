Return-Path: <cyrus@holtmann.org>
Message-ID: <51F3125F.30303@hurleysoftware.com>
Date: Fri, 26 Jul 2013 20:20:47 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: gustavo@padovan.org, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org,
 jslaby@suse.cz
Subject: Re: [PATCH v4 5/6] rfcomm: Fix the reference counting of tty_port
References: <1374859138-19467-1-git-send-email-gianluca@sottospazio.it> <1374859138-19467-6-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1374859138-19467-6-git-send-email-gianluca@sottospazio.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/26/2013 01:18 PM, Gianluca Anzolin wrote:
> The tty_port can be released in two cases: when we get a HUP in the
> functions rfcomm_tty_hangup() and rfcomm_dev_state_change(). Or when the
> user releases the device in rfcomm_release_dev().
>
> In these cases we set the flag RFCOMM_TTY_RELEASED so that no other
> function can get a reference to the tty_port.
>
> The rfcomm_dev_del function is removed becase it isn't used anymore.

While reviewing your RFC patch for fixing rfcomm_dev_state_change(),
I realized I missed a problem in this patch.

> @@ -614,7 +601,9 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
>   					return;
>   				}
>
> -				rfcomm_dev_del(dev);
> +				set_bit(RFCOMM_TTY_RELEASED, &dev->flags);
> +				tty_port_put(&dev->port);

Since this code can execute concurrently with rfcomm_release_dev(),
and the 'initial' port reference must only be dropped once, this should be

				if (!test_and_set_bit(RFCOMM_TTY_RELEASED, &dev->flags)
					tty_port_put(&dev->port);

Regards,
Peter Hurley
