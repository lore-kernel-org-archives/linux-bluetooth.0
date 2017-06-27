Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: what to do with brcm_patchram_plus?
To: Ian Molton <ian@mnementh.co.uk>
References: <7cef65c9-b831-b0bb-8029-38fcd99e75aa@mnementh.co.uk>
 <1f37eeff-7ce8-9242-13bc-0c718b1acefa@intel.com>
 <e3ade999-25c1-a28f-02d6-85dbcc583017@mnementh.co.uk>
From: Loic Poulain <loic.poulain@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Message-ID: <b99e7bff-6113-b77e-3798-fe87c92de952@intel.com>
Date: Tue, 27 Jun 2017 10:30:45 +0200
MIME-Version: 1.0
In-Reply-To: <e3ade999-25c1-a28f-02d6-85dbcc583017@mnementh.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

> OK, so it looks like it is capable of loading the firmware - thats a big
> step. sadly,
>
> hciconfig hci0 up
>
> results in:
>
> Bluetooth: hci0: BCM: chip id 94
> Bluetooth: hci0: BCM (001.002.009) build 0022
> Bluetooth: hci0: BCM (001.002.009) build 0022
> Can't init device hci0: No such device (19)

Good, Looking at the hci_bcm/btbcm driver, seems that you go through the 
the bcm_setup procedure
and successfully load the firmware, you rename it BCM.hcd, right ?

However I think the bcm_setup failed because of:

err = bcm_request_irq(bcm);
if (!err)
         err = bcm_setup_sleep(hu);

return err;

bcm_request_irq fails since there is no platform device attached to this 
uart/tty (no acpi nor DT entry).
So the driver is unable to retrieve resources like gpios/irq, 
bcm_request_irq returns -ENODEV.

This should NOT be a problem, since the driver supports this case 
(without power control).
However, the bcm_setup procedure returns the err value set by 
bcm_request_irq.

Would you be able to apply the following change to your kernel/module 
and retry ?

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f87bfdf..b6e94ab 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -423,7 +423,7 @@ static int bcm_setup(struct hci_uart *hu)
         if (!err)
                 err = bcm_setup_sleep(hu);

-       return err;
+       return 0;
  }


Regards,
Loic

> however, I can use the old hciattach method to attach to the uart and it
> works - thus the firmware is running.
>
> I'll prod this a bit tomorrow - in the meantime, is there a known
> current/good firmware for this chip? (43430a)
>
> Thanks,
>
> -Ian

