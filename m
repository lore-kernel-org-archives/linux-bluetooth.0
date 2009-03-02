Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1235931668.6074.47.camel@localhost.localdomain>
References: <aa4f458e0903010445j49d07c26j144210cb099540de@mail.gmail.com>
	 <1235931668.6074.47.camel@localhost.localdomain>
Date: Mon, 2 Mar 2009 18:32:44 +0100
Message-ID: <aa4f458e0903020932g4eb4e283w61d49473c7b20353@mail.gmail.com>
Subject: =?ISO-8859-1?Q?Re=3A_Bluetooth_radio_doesn=B4t_reply_to_inquiry_reques?=
	=?ISO-8859-1?Q?t?=
From: Carles Cufi <carles.cufi@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> Also should try the bluetooth-testing.git tree since it contains an
> updated btusb.ko driver.

I took the btusb.c from bluetooth-testing.git and compiled it into my
kernel. The symptoms remain exactly the same, the output of dmesg
looks identical, with the call to  __set_isoc_interface still failing.
Is there anything else I can try? Do you believe this problem has been
introduced recently into the kernel?

Thanks again!

Regards,

Carles
