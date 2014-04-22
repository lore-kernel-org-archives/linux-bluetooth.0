Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Apr 2014 09:52:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Return EOPNOTSUPP for HCISETRAW ioctl command
Message-ID: <20140422065207.GA27455@t440s.lan>
References: <1397703878-44875-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397703878-44875-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Apr 16, 2014, Marcel Holtmann wrote:
> The HCISETRAW ioctl command is not really useful. To utilize raw and
> direct access to the HCI controller, the HCI User Channel feature has
> been introduced. Return EOPNOTSUPP to indicate missing support for
> this command.
> 
> For legacy reasons hcidump used to use HCISETRAW for permission check
> to return proper error codes to users. To keep backwards compability
> return EPERM in case the caller does not have CAP_NET_ADMIN capability.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_sock.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
