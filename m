Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] CLASS OF DEVICE AND L2CAP INCOMING CONNECTION
	REQUESTS
From: Marcel Holtmann <marcel@holtmann.org>
To: Dan ABITBOL <d.abitbol@bloophone.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <006c01c39e27$f3d324c0$0900a8c0@Silicium>
References: <006c01c39e27$f3d324c0$0900a8c0@Silicium>
Content-Type: text/plain
Message-Id: <1067438006.24041.272.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 29 Oct 2003 15:33:18 +0100

Hi Dan,

first of all, start sending emails without background images and don't
write the subject complete in upper cases. Some spam filter can kick you
away and I tend to delete such mails without reading it ;)

> 1/  get the class of device of the remote device when I accept an l2cap incoming connection request...

I already thought of this. First we should add a class of device field
to the kernel structure hci_conn. The HCI core layer must fill in the
correct values on HCI connection request events.

> 2/  and/or  make a filter to allow l2cap incoming connections requests only from devices that have a specific class of device .

I don't have any real thought about this. Any comments from other
people?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
