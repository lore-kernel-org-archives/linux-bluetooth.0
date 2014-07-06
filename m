Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Jul 2014 17:12:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Enforce providing hdev->send driver callback
Message-ID: <20140706141231.GB9808@t440s.P-661HNU-F1>
References: <1404654627-7257-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404654627-7257-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jul 06, 2014, Marcel Holtmann wrote:
> The hdev->send driver callback is mandatory to be provided by a driver
> before calling hci_register_dev. So enforce it and return EINVAL in
> case it is not available.
> 
> All existing drivers are providing this callback anyway, so this is
> just an extra sanity check.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
