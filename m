Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v2] serdev: add method to set parity
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1516643792-22840-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Date: Tue, 23 Jan 2018 09:16:56 +0100
Cc: linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com,
        wsa@the-dreams.de, geert@linux-m68k.org
Message-Id: <73650B8B-31E8-4578-BEF9-13ED1217E8B7@holtmann.org>
References: <1516643792-22840-1-git-send-email-ulrich.hecht+renesas@gmail.com>
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulrich,

> Adds serdev_device_set_parity() and an implementation for ttyport.
> The interface uses an enum with the values SERIAL_PARITY_NONE,
> SERIAL_PARITY_EVEN and SERIAL_PARITY_ODD.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
> 
> Hi!
> 
> This revision addresses Johan's comments (see below for details) and adds
> Sebastian's Reviewed-by tag. Thank you for your reviews!
> 
> CU
> Uli
> 
> 
> Changes since v1:
> - added Reviewed-by tag
> - expanded commit message
> - shuffled stuff around to keep line-setting bits together
> - clear CMSPAR
> - (hopefully) detect errors correctly by checking tty->termios after call
>  to tty_set_termios().
> 
> 
> drivers/tty/serdev/core.c           | 12 ++++++++++++
> drivers/tty/serdev/serdev-ttyport.c | 24 ++++++++++++++++++++++++
> include/linux/serdev.h              | 10 ++++++++++
> 3 files changed, 46 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

