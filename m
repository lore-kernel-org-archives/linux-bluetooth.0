Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170322005837.6047-1-sre@kernel.org>
References: <20170321223216.11733-7-sre@kernel.org> <20170322005837.6047-1-sre@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 22 Mar 2017 16:18:25 -0500
Message-ID: <CAL_Jsq+7-TUiGoOEZZveyT-vzHT-TKYw3sQb8f0NqKp5UEdtWw@mail.gmail.com>
Subject: Re: [PATCHv2.1] serdev: implement get/set tiocm
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 21, 2017 at 7:58 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Add method for getting and setting tiocm.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
> Changes since PATCHv2:
>  * fix serdev_device_set_tiocm inline definition for disabled SERDEV
>  * use <linux/termios.h> instead of <asm-generic/termios.h>
> ---
>  drivers/tty/serdev/core.c           | 22 ++++++++++++++++++++++
>  drivers/tty/serdev/serdev-ttyport.c | 24 ++++++++++++++++++++++++
>  include/linux/serdev.h              | 13 +++++++++++++
>  3 files changed, 59 insertions(+)

I'm not that big of a fan of {set,get}_tiocm, but I guess it is fine.

Acked-by: Rob Herring <robh@kernel.org>

Rob
