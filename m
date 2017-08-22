Return-Path: <robherring2@gmail.com>
Date: Mon, 21 Aug 2017 21:30:14 -0500
From: Rob Herring <robh@kernel.org>
To: Loic Poulain <loic.poulain@gmail.com>
Cc: f.fainelli@gmail.com, rjui@broadcom.com, marcel@holtmann.org,
	johan.hedberg@gmail.com, stefan.wahren@i2se.com,
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/4] ARM: dts: bcm283x: Use stdout-path instead of
 console bootarg
Message-ID: <20170822023014.q7cc3v3nlocyjlog@rob-hp-laptop>
References: <1502992791-10265-1-git-send-email-loic.poulain@gmail.com>
 <1502992791-10265-2-git-send-email-loic.poulain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502992791-10265-2-git-send-email-loic.poulain@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 17, 2017 at 07:59:49PM +0200, Loic Poulain wrote:
> Add the serial port config to "chosen/stdout-path".
> Create serial0/1 aliases referring to uart0 ant uart1 paths.
> Remove unneeded earlyprintk.
> 
> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
> ---
>  v2: dt-bindings as separate patch
>      rebase on upcoming pi3 dts changes
>  v3: changes in bcm serdev drivers:
>      name refactoring and additional comments
>      Add generic host_set_baudrate method
>      Use agnostic device_property_read
>  v4: changes in doc and dts:
>      Add additional params to broadcom bt dt-bindings
>      Set the max baudrate to 2000000 instead of 921600
>      use chosen/stdout-path instead of console=
>      remove useless earlyprintk
>      same changes in bcm283x.dtsi
> 
>  arch/arm/boot/dts/bcm283x.dtsi | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
