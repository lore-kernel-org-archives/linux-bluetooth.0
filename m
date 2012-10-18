Return-Path: <cyrus@holtmann.org>
Message-ID: <1350593239.2026.13.camel@aeonflux>
Subject: Re: [PATCH 08/21] TTY: hci_ldisc, remove invalid check in open
From: Marcel Holtmann <marcel@holtmann.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com,
	linux-kernel@vger.kernel.org, jirislaby@gmail.com,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 18 Oct 2012 13:47:19 -0700
In-Reply-To: <1350592007-9216-9-git-send-email-jslaby@suse.cz>
References: <1350592007-9216-1-git-send-email-jslaby@suse.cz>
	 <1350592007-9216-9-git-send-email-jslaby@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jiri,

> hci_ldisc's open checks if tty_struct->disc_data is set. And if so it
> returns with an error. But nothing ensures disc_data to be NULL. And
> since ld->ops->open shall be called only once, we do not need the
> check at all. So remove it.
> 
> Note that this is not an issue now, but n_tty will start using the
> disc_data pointer and this invalid 'if' would trigger then rendering
> TTYs over BT unusable.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> ---
>  drivers/bluetooth/hci_ldisc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


