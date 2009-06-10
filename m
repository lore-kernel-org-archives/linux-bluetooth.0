Return-Path: <cyrus@holtmann.org>
Subject: Re: Apple Bluetooth devices: Battery level?
From: Marcel Holtmann <marcel@holtmann.org>
To: Dmitriy Geels <dmitriy.geels@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jkosina@suse.cz>,
	linux-bluetooth@vger.kernel.org,
	linux-input <linux-input@vger.kernel.org>
In-Reply-To: <78f5d6bf0906100014r5b7f5c14p4544ef13442c8f0b@mail.gmail.com>
References: <1244384236.30768.5690.camel@cookie.hadess.net>
	 <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz>
	 <1244589738.5973.1954.camel@cookie.hadess.net>
	 <78f5d6bf0906100014r5b7f5c14p4544ef13442c8f0b@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 10 Jun 2009 09:24:43 +0200
Message-Id: <1244618683.3068.36.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dimitry,

first of all, no top-posting. I really mean it.

> Kernel rebuilding is pretty easy, for ubuntu/debian it would be:
> - sudo apt-get install linux-source build-essential
> - tar xf /usr/src/linux-source*
> - cd linux-source-`uname -r`
> - cp /boot/config-`uname -r` .config
> - make menuconfig (find and enable HID_DEBUG)
> - make bzImage modules deb-pkg
> Then after some time you will get deb package, which you need to
> install and then run:
> - sudo update-initramfs -c -k 'new kernel version'
> - sudo update-grub
> 
> Then you can reboot into new kernel and use "echo 2 >
> /sys/modules/hid/parameters/debug" instead of debug module parameter.

that should be changeable on the fly and we should just export the HID
descriptor for users. Putting the burden to boot into a different kernel
is painful and we don't want that. Hell, I don't want to boot a new
kernel to just get the HID descriptor.

Regards

Marcel


