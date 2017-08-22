Return-Path: <robherring2@gmail.com>
Date: Mon, 21 Aug 2017 21:31:17 -0500
From: Rob Herring <robh@kernel.org>
To: Loic Poulain <loic.poulain@gmail.com>
Cc: f.fainelli@gmail.com, rjui@broadcom.com, marcel@holtmann.org,
	johan.hedberg@gmail.com, stefan.wahren@i2se.com,
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/4] ARM: dts: bcm2837-rpi-3-b: Add bcm43438 serial
 slave
Message-ID: <20170822023117.pdeocwozzxmlcvog@rob-hp-laptop>
References: <1502992791-10265-1-git-send-email-loic.poulain@gmail.com>
 <1502992791-10265-3-git-send-email-loic.poulain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502992791-10265-3-git-send-email-loic.poulain@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 17, 2017 at 07:59:50PM +0200, Loic Poulain wrote:
> Add BCM43438 (bluetooth) as a slave device of uart0 (pl011/ttyAMA0).
> This allows to automatically insert the bcm43438 to the bluetooth
> subsystem instead of relying on userspace helpers (hciattach).
> 
> Overwrite chosen/stdout-path to use 8250 aux uart as console.
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
>  arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
