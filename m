Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez-utils 2.9
From: Marcel Holtmann <marcel@holtmann.org>
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040802184344.GA3303@aragorn.home.lxtec.de>
References: <20040801225614.GB22083@aragorn.home.lxtec.de>
	 <1091411747.4279.7.camel@pegasus>
	 <20040802184344.GA3303@aragorn.home.lxtec.de>
Content-Type: text/plain
Message-Id: <1091475366.4259.13.camel@pegasus>
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
Date: Mon, 02 Aug 2004 21:36:06 +0200

Hi Elimar,

> > > why does hid2hci doesn't compile in bluez-utils 2.9?
> > > 
> > > Both --enable-hid2hci nor --enable-all built the binary hid2hci.
> > > 
> > > Tried the same on 2.8 where it works!
> > 
> > you need the USB library now to build hid2hci.
> 
> Which USB library?

take a look at libusb.sf.net. The lsusb program depends on this library
and you should find it in any distribution, but you may have to select
also its development package.

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
