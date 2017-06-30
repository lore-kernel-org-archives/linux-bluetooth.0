Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: BCM43430 BT driver almost working...
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <d0c4a580-82ac-d710-8678-f147ce81a9ce@mnementh.co.uk>
Date: Fri, 30 Jun 2017 19:02:04 +0200
Cc: Loic Poulain <loic.poulain@intel.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <F9B6438D-2D83-46BD-AE63-DBECB3A0B9A1@holtmann.org>
References: <c4cf0689-d28e-492d-399e-968a70488e22@mnementh.co.uk>
 <d65a5225-84f5-11ae-d9ab-2175480552d8@intel.com>
 <d0c4a580-82ac-d710-8678-f147ce81a9ce@mnementh.co.uk>
To: Ian Molton <ian@mnementh.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

>>> However, if I uncomment the line containing:
>>> 
>>>    err = bcm_setup_sleep(hu);
>>> 
>>> The driver dies, with timeouts, thus:
>>> 
>>> Bluetooth: hci0: BCM: chip id 94
>>> Bluetooth: hci0: BCM43430A1 (001.002.009) build 0000
>>> Bluetooth: hci0: BCM: failed to write clock (-56)
>>> Bluetooth: hci0: BCM (001.002.009) build 0182
>>> Bluetooth: hci0 command 0x0c56 tx timeout
>>> Bluetooth: hci0 command 0x0c7a tx timeout
>>> Bluetooth: hci0 command 0x0c6d tx timeout
>>> Bluetooth: hci0 command 0x2008 tx timeout
>>> Bluetooth: hci0 command 0x2009 tx timeout
>> 
>> bcm_setup_sleep enable low power mode, so I think problem is
>> that the wakeup gpio is not correctly drove.
>> -> Are you sure that you don't toggle the power gpio instead of the
>> wakeup one.
> 
> Possibly not - AFAIK, I only have one GPIO on this board, so I *assume*
> its the power one. I'll see if I can find out if wakeup/irq are connected.
> 
> *HOWEVER* the code checks for success of bcm_request_irq() when deciding
> to execute bcm_setup_sleep(). This makes sense to me, as I'd expect the
> hardware to want to interrupt the host when it wakes up.
> 
>> -> Without host-wakeup gpio, you are not able to get controller events.
>> 
>>> static struct platform_driver bcm_driver = {
>>>        .probe = bcm_probe,
>>>        .remove = bcm_remove,
>>>        .driver = {
>>>                .name = "hci_bcm",
>>>                .acpi_match_table = ACPI_PTR(bcm_acpi_match),
>>> +               .of_match_table = bcm_of_match,
>>>                .pm = &bcm_pm_ops,
>>>        },
>>> };
>>>                                                              13
>>> 
>> 
>> I think you should look at the serial device driver solution
>> (e.g nokia.c), This is the preferable way now.
> 
> damnit! thats very similar to my first idea on the matter, but I
> couldn't see how it was supposed to work.
> 
> Whats the right path forward here? both the drivers you listed have some
> merit - the hci_bcm driver, I have working, and it seems to support
> loading different firmwares well.
> 
> hci_nokia.c seems very similar, but only supports 2 firmwares, AFAICT.

the hci_ll.c for TI chips was changed to support ldisc and serdev. So clearly both can be supported from within the same driver.

If you have an embedded board with a proper DT definition, and the UART is hard-wired to the Bluetooth chip, then go for serdev. It means no btattach is needed. The kernel will enumerate this properly for you. That is the way forward. Someone needed to adapt the hci_bcm.c driver for this anyway. It just happens that you are the first one.

Regards

Marcel

