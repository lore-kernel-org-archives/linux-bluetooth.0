Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1235951758.6074.49.camel@localhost.localdomain>
References: <aa4f458e0903010445j49d07c26j144210cb099540de@mail.gmail.com>
	 <1235931668.6074.47.camel@localhost.localdomain>
	 <D97BBDAF-F830-4495-B1CC-B56C5C235E72@gmail.com>
	 <1235951758.6074.49.camel@localhost.localdomain>
Date: Mon, 2 Mar 2009 12:22:15 +0100
Message-ID: <aa4f458e0903020322m22f18079j60b779b7381c7951@mail.gmail.com>
Subject: =?ISO-8859-1?Q?Re=3A_Bluetooth_radio_doesn=B4t_reply_to_inquiry_reques?=
	=?ISO-8859-1?Q?t?=
From: Carles Cufi <carles.cufi@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> do me favor and read the Bluetooth specification, because periodic
> inquiry is a low-level HCI command.

I believe you may have misunderstood my earlier post. I do know about
the HCI Period Inquiry Mode command, but this is a large, multi-person
project, and I am in charge of writing a library that provides an
Inquiry() and InquiryCancel() methods. Someone else writes the
application that uses those methods, and so it happens that some of
the time they are using them to periodically launch inquiries, but
then not always. I cannot use the above mentioned HCI command because
I do not receive anything resembling a period as a parameter, since my
API only allows the application to start and stop inquiries, no to
provide periodicity information to the underlying library
implementation. Unfortunately I cannot change the API requirements nor
have control over what the application does with my library.

> With btusb we were trying to send as less URBs as possible, but it could
> be that not having bulk URB running the chips behave funny. At least
> that is what we have seen with some hardware. So that could be an issue
> here. Nobody knows for sure.

So if I understand this correctly, at some point (apparently when
BlueZ transitioned from hci_usb to btusb?) you removed support for
bulk URBs and that causes problems with some chipsets. I will try the
bluetooth-testing.git repository, but could you confirm what I just
stated and let me know at which point did the transition you are
talking about happened?

Thanks very much again!

Regards,

Carles
