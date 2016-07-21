Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: btbcm issue
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANMsd02AgbF75N9tHckym-vBWP5daFqVd363yaFRZM84vX4gQQ@mail.gmail.com>
Date: Thu, 21 Jul 2016 11:00:27 +0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <69551ED2-6F91-4011-9F78-9AB21C27F596@holtmann.org>
References: <CANMsd02AgbF75N9tHckym-vBWP5daFqVd363yaFRZM84vX4gQQ@mail.gmail.com>
To: Ryan <ryanphilips19@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ryan,

> I am using btbcm on an embedded device which has a broadcom bt module.
> 
> I understand that the below code suspends the bt device. Can anyone show
> me where i need to specify wakeup irq and device_wakeup gpios?
> 
> I cant find examples of boards which do these? I understand that device_wakeup
> is required for suspending the device.
> 
> Below is the code segment for suspend-resume which i suppose will be
> called to suspend the device.
> 
> 
> +static int bcm_suspend(struct device *pdev)
> +{
> + struct bcm_device *dev = platform_get_drvdata(to_platform_device(pdev));
> +
> + BT_DBG("suspend (%p): is_suspended %d", dev, dev->is_suspended);
> +
> + if (!dev->is_suspended) {
> + hci_uart_set_flow_control(dev->hu, true);
> +
> + /* Once this callback returns, driver suspends BT via GPIO */
> + dev->is_suspended = true;
> + }
> +
> + /* Suspend the device */
> + if (dev->device_wakeup) {
> + gpiod_set_value(dev->device_wakeup, false);
> + BT_DBG("suspend, delaying 15 ms");
> + mdelay(15);
> + }
> +
> + return 0;
> +}

I think the current hci_bcm.c (and btbcm.c) only ever enabled ACPI enumeration. Meaning someone might want to update that to support device tree (DT). There were efforts from Broadcom to add support for this, but they never agreed with the DT maintainer on the definitions.

Regards

Marcel

