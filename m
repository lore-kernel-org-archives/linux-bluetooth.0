Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS PATCH]GetMajorClass
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0602230419p2e9c503ev7fca43499cb13fed@mail.gmail.com>
References: <e1effdeb0602230419p2e9c503ev7fca43499cb13fed@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1140699315.24721.37.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 23 Feb 2006 13:55:15 +0100

Hi Claudio,

> Here is the GetMajorClass service implemented according to your
> suggestion: it is returning "computer" for now.

the patch has been applied. Thanks.

The whole topic with the class of device settings is still open for
discussion. However after reading the specification once again, I
figured that we have to make the major class a config file option and
not changeable by the user. It will be getting too complex if we wanna
add support for access points or other classes that make use of the
minor device class in a different way. My current approach is to make
the major class and service classes readable and the minor class is also
changeable if the major class is "computer".

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
