Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple bluetooth keyboard fun...
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: patbert@patbert.com,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200408081121.24065.cijoml@volny.cz>
References: <4115A5E3.8000107@patbert.com>
	 <200408081121.24065.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1091959987.2773.9.camel@pegasus>
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
Date: Sun, 08 Aug 2004 12:13:07 +0200

Hi Michal,

> > My hcid.conf file...
> >
> > # HCI daemon configuration file.
> > # $Id: hcid.conf,v 1.4 2004/04/29 20:14:21 holtmann Exp $
> >
> > options {
> >          autoinit yes;
> >          security user;
> auto
> >          pairing multi;
> >          pin_helper /usr/bin/bluepin;
> > }
> >
> > device {
> >          name "BlueZ (%d)";
> >          class 0x100;
> >          iscan enable; pscan enable;
> >          lm accept;
> lm accept,master;

don't suggest the master option, because this is only needed in very
special cases. The hidd program can request the role switch by itself.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
