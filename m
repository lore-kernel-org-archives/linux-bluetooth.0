Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Local Position Profile for Bluez
From: Marcel Holtmann <marcel@holtmann.org>
To: Casimiro Serrano Caballero <casimiro@telecos-malaga.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41644DA5.5020704@telecos-malaga.com>
References: <41644DA5.5020704@telecos-malaga.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1097095151.7325.6.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 06 Oct 2004 22:39:12 +0200

Hi Casimiro,

> My name is Casimiro Serrano, an Telecommunications student from the=20
> University of Malaga (Spain).
> First of all, i would like to congratulate the development team, for=20
> this great job. It has been very useful for me and now i want to=20
> contribute with the project with the following:
>=20
> I am preparing my final project based on the bluez stack, and an=20
> implementation of the LPP (Local Positioning Profile) is needed. The=20
> Profile is now a draft (v. 0.95) adopted by the Oficial Bluetooth=20
> membership site (www.bluetooth.org). So, i want to contribute to the=20
> bluez stack with an implementation of the profile, and create a single=20
> instalable module for Linux, following the requeriments of the official=
=20
> profile and according to the actual structure of the stack.
>=20
> But before start with my work, and if my desinterested work is well=20
> received, i need to know if there is an standard way to work in a=20
> profile in your team. I have read the "coding style". =BFany rules to=20
> write the documentation of the project while i advance? =BFany rules ab=
out=20
> the IDE? i will just use Kdevelop.

use whatever editor you want, but write you program in C, follow our
coding style and use autoconf/automake. Don't think about writing a
kernel module, because most stuff can be done very easy in user space
and it is hard to convince me that you need some parts running inside
the kernel. Actually that is all and so go ahead and write your code.
Good luck with your project. If you have any specific questions, ask
them on the mailing list.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
