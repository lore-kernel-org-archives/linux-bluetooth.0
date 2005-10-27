Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [D-BUS PATCH] Authentication
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0510251203i7cb20240ua03a7f9aff38917d@mail.gmail.com>
References: <e1effdeb0510201045w5ebf17afh87897564184ce9f9@mail.gmail.com>
	 <1129986496.11428.36.camel@blade>
	 <e1effdeb0510240606l1998f61dhc2fe813c48b1e6db@mail.gmail.com>
	 <1130159970.19317.28.camel@blade>
	 <e1effdeb0510251203i7cb20240ua03a7f9aff38917d@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1130373447.32634.8.camel@blade>
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
Date: Thu, 27 Oct 2005 02:37:27 +0200

Hi Claudio,

> Here are the patches to send the authentication result, please DON'T
> commit it. Probably
> it will conflict with the latest Eduardo's patch.
> 
> Which approach do you preffer?
> 1. Send a  signal
> 2. Send a method return (peer message)

I think that a signal to inform the applications that a connection is
now authenticated (and also encrypted) is a good idea.

Eduardos patches are now in the CVS. So you can re-create yours.

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
