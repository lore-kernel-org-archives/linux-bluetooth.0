Return-Path: <cyrus@holtmann.org>
Subject: Re: bluetooth pairing issue in kernel 2.6.30-rc5
From: Marcel Holtmann <marcel@holtmann.org>
To: balaji palaniswami <balaji_palaniswami@yahoo.com>
Cc: lan zhu <zhu.lan.cn@gmail.com>, linux-bluetooth@vger.kernel.org
In-Reply-To: <504288.41529.qm@web95402.mail.in2.yahoo.com>
References: <113d36d80905192336i337964a9hcbaa5ccb729434b6@mail.gmail.com>
	 <113d36d80905192341q4aa2463dyd0b1ed107792cff0@mail.gmail.com>
	 <113d36d80905192344p3caf4c3dm3ebe1a5c00eda3f9@mail.gmail.com>
	 <1242805691.3147.19.camel@localhost.localdomain>
	 <504288.41529.qm@web95402.mail.in2.yahoo.com>
Content-Type: text/plain
Date: Wed, 20 May 2009 12:56:41 -0700
Message-Id: <1242849401.3147.27.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this mailing list does NOT tolerate top-posting. If you keep doing it, I
will just ignore your emails.

> I upgraded kernel 2.6.30-rc5 which includes below fixes 
> 
> 
> Marcel Holtmann (4):
>       Bluetooth: Move dev_set_name() to a context that can sleep
>       Bluetooth: Fix wrong module refcount when connection setup fails
>       Bluetooth: Don't use hci_acl_connect_cancel() for incoming connections
>       Bluetooth: Don't trigger disconnect timeout for security mode 3 pairing
> i am using bluez 4.32 .After that i tried a2dp connection with automatic key option which is failed.
> because Error : Authentication failure is thrown by another end. Is this problem with remote bluetooth dongle ? 
> Do i need to upgrade bluez to latest version?

Please test 2.6.30-rc6 as I asked you to. And also use bluez-4.40 and
see if it works there.

Regards

Marcel


