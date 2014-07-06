Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Jul 2014 16:19:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Handle Intel USB bootloader with buggy
 interrupt
Message-ID: <20140706131952.GA8018@t440s.Elisa>
References: <1404651235-51172-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404651235-51172-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jul 06, 2014, Marcel Holtmann wrote:
> The interrupt interface for the Intel USB bootloader devices is only
> enabled after receiving SetInterface(0, AltSetting=0). When this USB
> command is not send, then no HCI events will be received.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Both patches have been applied to bluetooth-next. Thanks.

Johan
