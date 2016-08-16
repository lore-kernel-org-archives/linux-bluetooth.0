Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC 5/7] Bluetooth: hci_nokia: Introduce new driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1471058078-5579-6-git-send-email-sre@kernel.org>
Date: Tue, 16 Aug 2016 10:10:07 +0200
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>,
	=?utf-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Pavel Machek <pavel@ucw.cz>,
	=?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	linux-serial@vger.kernel.org,
	linux-omap <linux-omap@vger.kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <08EF658B-2BCB-46E2-B3DC-24FD12B4D5D8@holtmann.org>
References: <1471058078-5579-1-git-send-email-sre@kernel.org> <1471058078-5579-6-git-send-email-sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastien,

> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index a7d67aec3632..314b243df996 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -35,7 +35,7 @@
> #define HCIUARTGETFLAGS		_IOR('U', 204, int)
> 
> /* UART protocols */
> -#define HCI_UART_MAX_PROTO	10
> +#define HCI_UART_MAX_PROTO	11
> 
> #define HCI_UART_H4	0
> #define HCI_UART_BCSP	1
> @@ -47,6 +47,7 @@
> #define HCI_UART_BCM	7
> #define HCI_UART_QCA	8
> #define HCI_UART_AG6XX	9
> +#define HCI_UART_NOKIA	10

since it seems the driver is getting closer to be ready, lets merge this extra protocol identifier as a separate patch. Then we can adapt btattach as well for it.

Regards

Marcel
