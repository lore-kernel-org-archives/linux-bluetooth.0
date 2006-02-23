Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS PATCH] GetServiceClasses
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0602231329r446c015bh172515b7eebec548@mail.gmail.com>
References: <e1effdeb0602231250q18912898td65b1ff0edf278@mail.gmail.com>
	 <1140729493.24721.69.camel@localhost>
	 <e1effdeb0602231329r446c015bh172515b7eebec548@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1140731482.24721.83.camel@localhost>
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
Date: Thu, 23 Feb 2006 22:51:22 +0100

Hi Claudio,

> > the patch has been applied. So what have been left?
> 
> - GetFeatures
> - PinCodeLength
> - EncryptionKeySize
> - MinorClassChanged
> - dbus-test update

we might wanna leave the GetFeatures part out of it, because I am not
sure if it is useful at all.

The PinCodeLength needs some work from my side, because we actually need
to store the length of the used PIN codes.

Support for EncryptionKeySize can be only implemented for CSR chips,
because I have no idea how to get this from other manufacturers.

The MinorClassChanged signal is kinda easy to add.

And I am not touching the dbus-test script ;)

> I am going home now. I think we can try finish it until tomorrow.

Looks really good. So we are almost ready for the next release. However
I actually like to have a better D-Bus service file. We need to restrict
some of the functions to the console user.

> SDP will be another history, I think we can try develop it after the Carnival :)

The SDP will take more time and is not that easy. Enjoy your Carnival :)

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
