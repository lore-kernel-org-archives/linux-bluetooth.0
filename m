Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170321223216.11733-12-sre@kernel.org>
References: <20170321223216.11733-1-sre@kernel.org> <20170321223216.11733-12-sre@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 22 Mar 2017 16:06:18 -0500
Message-ID: <CAL_JsqJBSSQsqDLVVedBp2T-GTcFy=ZM_xSterNRmM=YbV1Vjg@mail.gmail.com>
Subject: Re: [PATCHv2 11/11] ARM: dts: N9/N950: add bluetooth
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

On Tue, Mar 21, 2017 at 5:32 PM, Sebastian Reichel <sre@kernel.org> wrote:
> The Nokia N950 and N9 have a wl1271 (with nokia bootloader) bluetooth
> module connected to second UART.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
> Changes since PATCHv1:
>  - update compatible string
> ---
>  arch/arm/boot/dts/omap3-n950-n9.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
