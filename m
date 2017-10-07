Return-Path: <greg@kroah.com>
Date: Sat, 7 Oct 2017 08:41:14 +0200
From: Greg Kroah-Hartman <greg@kroah.com>
To: Ian W MORRISON <ianwmorrison@gmail.com>
Cc: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>,
	Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Loic Poulain <loic.poulain@gmail.com>,
	Johan Hovold <johan@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] serdev: Update drivers/tty/serdev/Kconfig for ACPI
 support
Message-ID: <20171007064114.GA19450@kroah.com>
References: <a4051ac2-1156-751d-ec16-2dbbb30b9258@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a4051ac2-1156-751d-ec16-2dbbb30b9258@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Oct 07, 2017 at 05:16:31PM +1100, Ian W MORRISON wrote:
> The current Kconfig for serdev is not compatible when adding ACPI support as it does not work when built as a module as it requires config SERIAL_DEV_CTRL_TTYPORT to be set. This patch makes serdev compiled into the kernel if selected so that config SERIAL_DEV_CTRL_TTYPORT can be correctly set if requiring ACPI support.
> ---
>  drivers/tty/serdev/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
> index cdc6b820cf93..a9fb09a9c105 100644
> --- a/drivers/tty/serdev/Kconfig
> +++ b/drivers/tty/serdev/Kconfig
> @@ -2,7 +2,8 @@
>  # Serial bus device driver configuration
>  #
>  menuconfig SERIAL_DEV_BUS
> -	tristate "Serial device bus"
> +	bool "Serial device bus"
> +	default y
>  	help
>  	  Core support for devices connected via a serial port.
>  
> @@ -11,6 +12,6 @@ if SERIAL_DEV_BUS
>  config SERIAL_DEV_CTRL_TTYPORT
>  	bool "Serial device TTY port controller"
>  	depends on TTY
> -	depends on SERIAL_DEV_BUS != m
> +	default y
>  
>  endif
> -- 
> 2.11.0


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
