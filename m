Return-Path: <jhovold@gmail.com>
Sender: Johan Hovold <jhovold@gmail.com>
Date: Tue, 23 Jan 2018 12:34:34 +1100
From: Johan Hovold <johan@kernel.org>
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: marcel@holtmann.org, linux-renesas-soc@vger.kernel.org,
	linux-serial@vger.kernel.org, johan@kernel.org, sre@kernel.org,
	linux-bluetooth@vger.kernel.org, robh@kernel.org,
	martin.blumenstingl@googlemail.com, gregkh@linuxfoundation.org,
	magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com,
	wsa@the-dreams.de, geert@linux-m68k.org
Subject: Re: [PATCH v2] serdev: add method to set parity
Message-ID: <20180123013434.GK3286@localhost>
References: <1516643792-22840-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516643792-22840-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 22, 2018 at 06:56:32PM +0100, Ulrich Hecht wrote:
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
>   to tty_set_termios().

Thanks for the v2. Looks good to me now.

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
