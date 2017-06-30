Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: BCM43430 BT driver almost working...
To: Ian Molton <ian@mnementh.co.uk>
References: <c4cf0689-d28e-492d-399e-968a70488e22@mnementh.co.uk>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
From: Loic Poulain <loic.poulain@intel.com>
Message-ID: <d65a5225-84f5-11ae-d9ab-2175480552d8@intel.com>
Date: Fri, 30 Jun 2017 17:41:45 +0200
MIME-Version: 1.0
In-Reply-To: <c4cf0689-d28e-492d-399e-968a70488e22@mnementh.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Ian,

On 29/06/2017 20:06, Ian Molton wrote:


> I've created a dt entry that looks like:
>
> bt_brcm {
>                 compatible = "brcm,b43430a1";
>                 wakeup-gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
>                 ttydev = <&uart2>;
>                 status = "ok";
>         };
> };
>
> This allows me to get the code to correlate the UART and the GPIOs,
> thus: (forgive the very messy patch - this is my WIP, for illustration
> only...)
>
> The code below *works* - toggles the power GPIO, loads firmware, and
> attaches fine.

Be careful here, you add only one gpio in our DT entry, the wakeup one.

Typically (bcm43xx) you need 2 gpios + 1 irq:
power (gpio): toggle the chip off/on
wakeup (gpio): wakeup the chip, allowing send/recv data over UART
host-wakeup (gpio): Request attention, data to send


In suspended mode, if you have wakeup gpio but no host-wakeup,
the controller will be unable to inform the host about data readiness,
So the host will not allow the controller to send its data (via wakeup).

The only 3 working conditions are:
1 - you don't have any resource, chip is powered on by default (hw
pull-up or firmware config), the driver operate without power mgmt.
2 - you have the power gpio, controller is power on/off on
attach/detach. No low-power mode except if condition 3.
3- you have the wakeup and host-wakeup resources, so the host is
able to manage the low-power mode (suspend/resume)


>
> However, if I uncomment the line containing:
>
>     err = bcm_setup_sleep(hu);
>
> The driver dies, with timeouts, thus:
>
> Bluetooth: hci0: BCM: chip id 94
> Bluetooth: hci0: BCM43430A1 (001.002.009) build 0000
> Bluetooth: hci0: BCM: failed to write clock (-56)
> Bluetooth: hci0: BCM (001.002.009) build 0182
> Bluetooth: hci0 command 0x0c56 tx timeout
> Bluetooth: hci0 command 0x0c7a tx timeout
> Bluetooth: hci0 command 0x0c6d tx timeout
> Bluetooth: hci0 command 0x2008 tx timeout
> Bluetooth: hci0 command 0x2009 tx timeout

bcm_setup_sleep enable low power mode, so I think problem is
that the wakeup gpio is not correctly drove.
-> Are you sure that you don't toggle the power gpio instead of the 
wakeup one.
-> Without host-wakeup gpio, you are not able to get controller events.

>  static struct platform_driver bcm_driver = {
>         .probe = bcm_probe,
>         .remove = bcm_remove,
>         .driver = {
>                 .name = "hci_bcm",
>                 .acpi_match_table = ACPI_PTR(bcm_acpi_match),
> +               .of_match_table = bcm_of_match,
>                 .pm = &bcm_pm_ops,
>         },
>  };
>                                                               13
>

I think you should look at the serial device driver solution
(e.g nokia.c), This is the preferable way now.

Regards,
Loic
