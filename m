Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluetooth USB device keeps same PID/VID after DFU
From: Marcel Holtmann <marcel@holtmann.org>
To: Steven Li <Steven.Li@Atheros.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	Bluettooth Linux <linux-bluetooth@vger.kernel.org>,
	Haijun Liu <Haijun.Liu@Atheros.com>,
	Hong Fan <Hong.Fan@Atheros.com>, Vic Wei <Vic.Wei@Atheros.com>,
	"Jack Chen(Taipei)" <Sheng-Kuan.Chen@Atheros.com>,
	Robert Chang <Robert.Chang@Atheros.com>,
	"Luis R. Rodriguez" <mcgrof@gmail.com>
In-Reply-To: <6AAC4214B9104E409FF4885ACB62A96101A78AD8B3@SHEXMB-01.global.atheros.com>
References: <6AAC4214B9104E409FF4885ACB62A96101A78AD8B3@SHEXMB-01.global.atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 May 2011 19:47:10 -0700
Message-ID: <1306378030.2681.50.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steven,

> Here is steven from Atheros.  Glad to contact you here. we have some concerns to the btusb device driver.
> Present USB Bluetooth implementation in Linux has some limitations. Many vendors need to load patch and other specific operations during device probe or disconnect to their Bluetooth device, but btusb driver gives limitation to this behavior.  It needs to add the Bluetooth device PID/VID into the btusb blacklist, and use the vendor specific driver to load firmware. By this, it causes the Bluetooth device "MUST" have two PID/VIDs in Linux.  But on windows platform, the device can always keep one same PID/VID.  It is hard for us to handle this issue with current btusb design.
> Moreover in our Atheros 3012 chip, we also need to switch the 3012 chip between "normal" mode and "pre-boot" mode during PC reboot,  with current btusb design, we have to make changes in btusb.c directly, but it is our chip specific requirements.  Therefore, we’d like to propose some methods to make the Bluetooth device has only one PID/VID by proper btusb modification and also for other vendor extensions such as mode switch. 
> 
> Currently, we have three proposals. And I attached our rough patches for these three proposals.
> They are totally not formal, I attached them just want to make you easy to understand.
> 
> And from here, Let me explain more of  these proposal one by one.
> 
> # Proposal 1.
> This option could be refer to what it’s working for lots of UART Bluetooth devices in Linux.
> Mainly, vendor driver would be built as an object of btusb.ko. This should be same as those UART Bluetooth drivers.
> In our case, ath3k would be built as an object file according to CONFIG_BT_ATH3K define.  
> Then btusb kernel module will be composed of btusb.o and ath3k.o.  So it is easy to make one PID/VID device work.
> This concept was oriented by hci_uart driver.  It can jump to individual entry function based on different ID.
> And things like mode switch also could be handled by just adding function like switch_mode() in ath3k.c.
> 
> # Proposal 2.
> This option is to export btusb common functions, and vendor driver (for example our ath3k) can be taken as the extension of btusb. 
> , and it can first downloads the firmware and then use those functions exported in btusb driver
> to setup the hci Bluetooth device.  Moreover if it is possible, we are also propose to refine the btusb.c and split the btusb.c to btusb_core.c and btusb_generic.c, 
> In the btusb_core.c. It includes all the  Bluetooth usb common operations and these Bluetooth usb functions will be exported, 
> and the btusb_generic.c is the real generic Bluetooth driver remains support all current Bluetooth device ,which uses the btusb_core functions.
> And vendor driver can also call those usb common operations in the btusb_core.c.
> With this proposal, Since the ath3k driver are the only owner of the bluetooth device, only one PID/VID is necessary.
> And it is very easy to handle the mode switch case in itself either. Please check btusb_ath3k_2.patch for detail.
> 
> # Proposal 3.
> This option is to add "quirk device" to btusb driver. We found actually you added lots of so-called “quirk” implementation in btusb driver for many vendors.
> http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commit;h=cfeb414537b1d7c23ba202f198fa4154cd5a4856
> Vendor specific driver can call btusb_register_quirk_device() function to  register itself to the btusb driver. 
> So during the device probe, the btusb will try to match the device id, and if it is a “quirk” device, it will call 
> the “quirk” device’s specific function first.  Every vendor can use this quirk to download their firmware and keep the same PID/VID with proper codes in btusb.c.
> This proposal is also able to handle the mode switch case. 
> 
> Please give your comments and suggestion for our proposals. 
> We are hoping to make one PID/VID work and contribute to the community.

why do you want this at all. You run a different protocol with different
endpoints on the device in DFU mode and on the device in H:2 mode.

So you actually have different functionality. And I personally do not
care what Windows is doing. This is Linux, so please follow what the
Linux community expect you to do.

Also in case of btusb, you can use the Bluetooth SIG (and for that
matter USB SIG) defined interface identifiers. The btusb driver does not
match by default to VID/PID. It uses a standard. If you wanna use the
same VID/PID here, then declare the interface identifiers properly and
everything would work out nicely.

You guys insist on lying to the USB subsystem and by that fact most
likely violating the USB standards. Don't do that and everything will
work out of the box with Linux. No extra patches or modification for
btusb needed.

Regards

Marcel


