Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Gentoo compile error: `HANDSFREE_SVCLASS_ID'
	undeclared (first use in this function)
From: Marcel Holtmann <marcel@holtmann.org>
To: Sven Ehret <sven.ehret@gmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3eef79ed04100219111bcee37d@mail.gmail.com>
References: <3eef79ed04100219111bcee37d@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1096833441.20349.0.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 03 Oct 2004 21:57:21 +0200

Hi Sven,

> I am unable to compile any version of bluez-utils I could get my hand o=
n.
>=20
> Using Gentoo, compiling portage-versions 2.7, 2.10, 2.10-r1 and newest
> version from sf.net breaks with:
>=20
>      [some lines]
> sdptool.c: In Funktion =BBadd_handsfree=AB:
> sdptool.c:1130: error: `HANDSFREE_SVCLASS_ID' undeclared (first use in
> this function)

read the ChangeLog file for the bluez-libs requirement.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
