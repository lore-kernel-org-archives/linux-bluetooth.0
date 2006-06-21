Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060621091250.43316.qmail@web15809.mail.cnb.yahoo.com>
References: <20060621091250.43316.qmail@web15809.mail.cnb.yahoo.com>
Date: Wed, 21 Jun 2006 11:25:22 +0200
Message-Id: <1150881922.3950.28.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] =?UTF-8?Q?=E5=9B=9E=E5=A4=8D=EF=BC=9A?= Re:
	=?UTF-8?Q?=E5=9B=9E=E5=A4=8D=EF=BC=9A?=	=?gb2312?q?=20Re:=20=BB=D8=B8=B4=A3=BA=20Re:=20=20RE=A3=BA=20RE:=20FWD=A3?=	=?gb2312?q?=BA=20Re:=20Re:Request=20with=09RSSI?=
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

>  I reviewed the hciconfig.c.
>  If you set mode 5, it just output like you test. I can see any
> limitation of the mode num, 5 it can be dealt with. So, I don't think
> it can give such a conclusion you claimed.

this has nothing to do with our code. The chip must refuse any values
other than 0 and 1. And such a behavior leads the conclusion that their
implementation doesn't care about the inquiry mode at all. Otherwise
they would have been more careful with the implementation.

Anyway, the firmware of this chip is broken. Get yourself a working
dongle from CSR and you can use Inquiry with RSSI. Otherwise you can't.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
