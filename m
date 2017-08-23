Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4 3/4] ARM: dts: bcm2837-rpi-3-b: Add bcm43438 serial
 slave
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1502992791-10265-3-git-send-email-loic.poulain@gmail.com>
Date: Wed, 23 Aug 2017 16:22:11 +0200
Cc: robh+dt@kernel.org, f.fainelli@gmail.com, rjui@broadcom.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        stefan.wahren@i2se.com, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
Message-Id: <972AD2C1-FE7C-412D-AEC6-FFED22EC4B77@holtmann.org>
References: <1502992791-10265-1-git-send-email-loic.poulain@gmail.com>
 <1502992791-10265-3-git-send-email-loic.poulain@gmail.com>
To: Loic Poulain <loic.poulain@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Add BCM43438 (bluetooth) as a slave device of uart0 (pl011/ttyAMA0).
> This allows to automatically insert the bcm43438 to the bluetooth
> subsystem instead of relying on userspace helpers (hciattach).
> 
> Overwrite chosen/stdout-path to use 8250 aux uart as console.
> 
> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
> ---
> v2: dt-bindings as separate patch
>     rebase on upcoming pi3 dts changes
> v3: changes in bcm serdev drivers:
>     name refactoring and additional comments
>     Add generic host_set_baudrate method
>     Use agnostic device_property_read
> v4: changes in doc and dts:
>     Add additional params to broadcom bt dt-bindings
>     Set the max baudrate to 2000000 instead of 921600
>     use chosen/stdout-path instead of console=
>     remove useless earlyprintk
>     same changes in bcm283x.dtsi
> 
> arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 10 ++++++++++
> 1 file changed, 10 insertions(+)

do you mind resending the 2 pending patches with Rob’s ack on it. And ensure that this goes with DT tree since I can currently not take it since net-next has not pulled in the pending DT patches.

Regards

Marcel

