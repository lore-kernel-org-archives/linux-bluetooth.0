Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS PATCH] GetServiceClasses
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0602231329r446c015bh172515b7eebec548@mail.gmail.com>
References: <e1effdeb0602231250q18912898td65b1ff0edf278@mail.gmail.com>
	 <1140729493.24721.69.camel@localhost>
	 <e1effdeb0602231329r446c015bh172515b7eebec548@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1140748782.24721.87.camel@localhost>
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
Date: Fri, 24 Feb 2006 03:39:42 +0100

Hi Claudio,

> > the patch has been applied. So what have been left?
> 
> - GetFeatures

this returns an empty list for now.

> - PinCodeLength

It has been implemented, but it definitely needs more testing. I choose
an extension of the link keys file.

> - EncryptionKeySize

The basic functionality is there, but no backend for the different chips
has been implemented.

> - MinorClassChanged

Done.

> - dbus-test update

I did a small update for my own testing.

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
