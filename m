Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: where can I find patch for 2.6.9?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4203A9C4.7040509@gmx.ch>
References: <c93f2a29050203210522694d38@mail.gmail.com>
	 <ctv818$aa1$1@sea.gmane.org> <1107517953.6921.3.camel@pegasus>
	 <4203A9C4.7040509@gmx.ch>
Content-Type: text/plain
Message-Id: <1107538283.6921.51.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 04 Feb 2005 18:31:23 +0100

Hi Marco,

> So the 2.4.x patches are all up2date and have the same fixes as the most 
> recent 2.6.x one?

not quite right. All 2.4 patches provide the same level of the Bluetooth
subsystem, but this is out of date if you compare it with the stuff that
are in the 2.6 kernel and its patches.

We are developing for 2.6 and I don't have time to do the backporting to
2.4 and actually I see no reason to do this. People should start using
the new stable kernel series or pay someone to backport the stuff if
they wanna stick with an old kernel.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
