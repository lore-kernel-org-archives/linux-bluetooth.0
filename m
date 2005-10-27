Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [D-BUS PATCH] Authentication
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0510270733q23c9cf01u9b3a597d1adbe258@mail.gmail.com>
References: <e1effdeb0510201045w5ebf17afh87897564184ce9f9@mail.gmail.com>
	 <1129986496.11428.36.camel@blade>
	 <e1effdeb0510240606l1998f61dhc2fe813c48b1e6db@mail.gmail.com>
	 <1130159970.19317.28.camel@blade>
	 <e1effdeb0510251203i7cb20240ua03a7f9aff38917d@mail.gmail.com>
	 <1130373447.32634.8.camel@blade>
	 <e1effdeb0510270733q23c9cf01u9b3a597d1adbe258@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1130424788.5163.15.camel@localhost.localdomain>
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
Date: Thu, 27 Oct 2005 16:53:08 +0200

Hi Claudio,

> Here are the patches based on the lastest BlueZ CVS. I am sending both
> approaches.
> Using signals is more clear in hcid side, however the clients will
> have to add flags to indicate that there is a authentication pending.
> Another problem is the error, using signals will not be possible send
> D-Bus error messages, therefore client will have to translate the
> status to a success or errors result.

we need the signal anyway, because a second application might be request
the authentication and if your first application displays different
icons for authenticated or unauthenticated connection then it should be
told that this connection is now authenticated. The same applies for the
encryption.

> PS: This is the message content for both approachs:
> * Signal approach
>   >>> D-Bus AuthenticationComplete signal
>   - String: peer bt address
>   - Byte: status
>   - Uint16: handle

We don't need the handle and the address. Use the address only, because
connection handles should be only used in hcid and the kernel.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
