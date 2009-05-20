Return-Path: <cyrus@holtmann.org>
Subject: Re: bluetooth pairing issue in kernel 2.6.27
From: Marcel Holtmann <marcel@holtmann.org>
To: lan zhu <zhu.lan.cn@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <113d36d80905192344p3caf4c3dm3ebe1a5c00eda3f9@mail.gmail.com>
References: <113d36d80905192336i337964a9hcbaa5ccb729434b6@mail.gmail.com>
	 <113d36d80905192341q4aa2463dyd0b1ed107792cff0@mail.gmail.com>
	 <113d36d80905192344p3caf4c3dm3ebe1a5c00eda3f9@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 20 May 2009 00:48:11 -0700
Message-Id: <1242805691.3147.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> When pairing two Android devices which are supported by Bluez on
> kernel 2.6.27, it will always fail if the user can't finish the whole
> procedure in 10 seconds. After some analysis we found the root cause
> is that Bluez's HCI link's time out timer is set to 10s in the kernel,
> and in Bluez's create_bonding() function it calls l2raw_connect() to
> create only HCI link without L2CAP channel.
> 
> One easy way to fix this issue is to create L2CAP link when creating
> bonding, but this is not a final solution, because
> according to Bluetooth Specification, creating L2CAP link is only
> optional in the bonding establishment procedure, so the thorough way
> to fix it is to alter the HCI link's time out timer when handling
> bonding request.
> 
> Does anyone know has this been fixed on Bluez kernel's patch on
> 2.6.27, or on the 2.6.29 and later's kernel?

the 2.6.30-rc6 kernel should contains fixes for this to make pairing
smooth with either Legacy or Simple Pairing.

Regards

Marcel


