Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20060713091840.63659.qmail@web50503.mail.yahoo.com>
References: <20060713091840.63659.qmail@web50503.mail.yahoo.com>
Date: Thu, 13 Jul 2006 11:23:36 +0200
Message-Id: <1152782616.25987.20.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Bluetooth USB dongles
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Mahtab,

> Thanks for your help. I know it may be irrelevant to ask this......but
> I have no other way! This group seems to be the only one where I can
> get a bit help.

you know that you are trying to exploit the open source community ;)

> 1. I want to know the golden receiver power range (GRPR) of the
> bluetooth dongles I am using (specifically the upper & lower
> threshold). From your reply, I guess it should be implemented in the
> chips (BlueCore4-Ext or BlueCore4-ROM) and so will be a chip paramter.
> Should reading the data-sheets of those chips help me in finding their
> Golden Receiver Power Range (i.e. the upper & lower threshold level)?
> Or any other way to find it?

Check the CSR documentation.

> 2. Is Link Quality (LQ) also a chip-parameter? Is the link quality
> algorithm same for all CSR chips (the one posted in your website)? How
> could you find that algorithm?

It is described on my webpage and you will also find it in the CSR
documentation.

> 3. Does the power-control (stepping up or down of power) vary from
> chip to chip?

For the CSR chips, I is fully configurable as far as I know. For other
vendors, I have no idea.

> 4. What's the main purpose of the driver (Toshiba or Level1 etc.)?

How should I know? Toshiba and Level1 are dongle manufactures and I
don't care about any Windows based driver at all.

Regards

Marcel




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
