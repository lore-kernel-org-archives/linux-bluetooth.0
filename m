Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] scanning possible, but no l2ping?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41FB066B.3080904@coriand.com>
References: <41FB0236.3030600@coriand.com>
	 <1106969620.10580.23.camel@pegasus>  <41FB066B.3080904@coriand.com>
Content-Type: text/plain
Message-Id: <1106970655.10735.2.camel@pegasus>
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
Date: Sat, 29 Jan 2005 04:50:55 +0100

Hi Franz,

> Securty Mode 3 is not safty, isn't it ;) My problem is, I need a f***
> connection between Watch and computer for a special live-demo in a
> closed lab.

the security mode 3 is not more safe than security mode 2.

> And the next problem is that pairing doesn't work with the watch, so I
> turned everything off. So all I need is just a connection to send tcp
> packages - I don't care about the secury.

You must switch "auth" and "encrypt" off on _both_ sides. If one device
is in security mode 3 than the other must follow. This is how security
mode 1 is definied in the specification.

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
