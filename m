Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Zephyr Controller with legacy tools
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <895cbd85-4813-b2fe-031d-47ca08d72ccd@kontakt.io>
Date: Tue, 18 Jul 2017 11:36:56 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <47B2E14F-5E66-4B40-8F4F-110C93FFE5C8@holtmann.org>
References: <895cbd85-4813-b2fe-031d-47ca08d72ccd@kontakt.io>
To: Jacek Chmiel <jacek@kontakt.io>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jacek,

> We are trying to use Zephyr (https://www.zephyrproject.org) nrf52 hci
> example as BLE scanning device. We were able to sucessfully run the
> example according to this tutorial:
> https://devzone.nordicsemi.com/blogs/1059/nrf5x-support-within-the-zephyr-project-rtos/
> 
> 
> We've successfully set up and communicate with Zephyr based controller
> using ubuntu 16.06 with kernel 4.8.0 and newest bluez release.
> 
> Unfortunately our target final design is using embedded linux with quite
> old kernel (3.10.93). On this kernel, latest bluez release lacks btmgmt
> interface used in the example above. We are trying to use legacy tools
> like hciattach, hciconfig, hcitool to run scanning on nrf52 with zephyr
> hci example.
> 
> After running:
> $ hciattach  ttyACM0 any -s 1000000 flow
> 
> we can see new hci device as:
> 
> hci0:	Type: BR/EDR  Bus: UART
> 	BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
> 	DOWN INIT RUNNING
> 	RX bytes:0 acl:0 sco:0 events:0 errors:0
> 	TX bytes:8 acl:0 sco:0 commands:2 errors:0
> 
> Unfortunatelly we cannot get interface 'up'
> 
> ./hciconfig hci0 up
> Can't init device hci0: Cannot assign requested address (99)
> 
> so we cannot also start scanning
> ./hcitool -i hci0 lescan
> Invalid device: Network is down
> 
> What I'm asking for is some advice on how to debug this problem and
> bring Zephyr based controller up.

the Zephyr controllers do not have a public address configured. In addition they are LE only. So older kernels that do not have mgmt interface will stumble over this. I think you will not have much luck with such an old kernel. Look at linux-backports project to port the Bluetooth subsystem from a recent kernel back to your outdated kernel.

Regards

Marcel

