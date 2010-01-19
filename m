Return-Path: <cyrus@holtmann.org>
From: "Gunn, Brian" <bgunn@solekai.com>
To: Bastien Nocera <hadess@hadess.net>
CC: Marcel Holtmann <marcel@holtmann.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, BlueZ
 development <linux-bluetooth@vger.kernel.org>, Ping <pinglinux@gmail.com>,
	Jiri Kosina <jikos@jikos.cz>
Date: Tue, 19 Jan 2010 09:05:15 -0800
Subject: RE: [PATCHes] Implement Bluetooth Wacom tablet's mode change in the
 kernel
Message-ID: <FE57175CCE23E5419899C1B0CFA26FAD101B5F8B9E@EXMBXSD.dm.solekai.com>
References: <1263833399.20565.2905.camel@localhost.localdomain>
	 <1263886149.5591.166.camel@localhost.localdomain>
	 ,<1263897015.20565.3988.camel@localhost.localdomain>
	 <FE57175CCE23E5419899C1B0CFA26FAD101B5F8B9D@EXMBXSD.dm.solekai.com>,<1263920596.1816.56.camel@localhost.localdomain>
In-Reply-To: <1263920596.1816.56.camel@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

> Bastien Nocera wrote:
>On Tue, 2010-01-19 at 08:36 -0800, Gunn, Brian wrote:
>> I tested this with a Bluetooth remote control.  As I understand,
>> reports can be written to either the interrupt or control sockets.
>> I'm happy to test other changes to let this be selectable.

>Could you expand slightly on that? What make/model? What sort of tests
>did you do on it?

I used a custom remote control under development by the company I'm contrac=
ted to.  We have custom HID output reports that trigger actions on the remo=
te.  I was able to send the output reports and get the behavior I expected =
on the remote.  I have no faith that the company developing the remote impl=
emented their side correctly and would like to try it with the control sock=
et instead.

Brian
