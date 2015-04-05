Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Apr 2015 09:21:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: hci_uart: Remove unneeded cast of
 tty->disc_data
Message-ID: <20150405062112.GB11977@t440s.P-661HNU-F1>
References: <1428202642-21621-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428202642-21621-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Apr 04, 2015, Marcel Holtmann wrote:
> Casting the tty->disc_data to (void *) is not needed at all. So just
> remove this cast and assign the object without a cast.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_ldisc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
