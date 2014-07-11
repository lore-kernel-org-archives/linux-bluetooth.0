Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Jul 2014 14:00:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Check for valid HCI UART driver flags
Message-ID: <20140711110030.GG14378@t440s.P-661HNU-F1>
References: <1405055578-30621-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405055578-30621-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jul 11, 2014, Marcel Holtmann wrote:
> Providing unknown or invalid flags to the HCI UART driver should
> result in an error. So check which flags are valid and otherwise
> return an error.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_ldisc.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
