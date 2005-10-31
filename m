Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [D-BUS PATCH] Authentication
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <3013cac80510310653s14dd0fceu7241b89137208262@mail.gmail.com>
References: <e1effdeb0510201045w5ebf17afh87897564184ce9f9@mail.gmail.com>
	 <1129986496.11428.36.camel@blade>
	 <e1effdeb0510240606l1998f61dhc2fe813c48b1e6db@mail.gmail.com>
	 <1130159970.19317.28.camel@blade>
	 <e1effdeb0510251203i7cb20240ua03a7f9aff38917d@mail.gmail.com>
	 <1130373447.32634.8.camel@blade>
	 <e1effdeb0510270733q23c9cf01u9b3a597d1adbe258@mail.gmail.com>
	 <1130424788.5163.15.camel@localhost.localdomain>
	 <e1effdeb0510270933q4cc1e108of143a86d46c8b750@mail.gmail.com>
	 <1130433108.16380.0.camel@localhost.localdomain>
	 <3013cac80510310653s14dd0fceu7241b89137208262@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1130773368.570.2.camel@blade>
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
Date: Mon, 31 Oct 2005 16:42:48 +0100

Hi Eduardo,

> here is the patch for /org/bluez/Device. It adds the function
> DeviceList that returns the list of registered devices in the machine.
> For each device I'm returning (device name, addr, type, up/down, and
> an array of capability). I've also splitted some functions that was
> used in conjuction with  /org/bluez/Manager. I've also included a
> python client for test.

the patch is in the CVS now, but I had to do housekeeping of the coding
style again. Especially the whitespaces. So please use an editor that
visualizes the whitespaces and tabs for you. This really helps to keep
the code clean.

I like the idea with the test program. I think we need a lot more
command line based test programs to verify the D-Bus interface. After
another walk-through the code, I realized that nobody actually bothered
about big endian system. So we need some regression tests.

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
