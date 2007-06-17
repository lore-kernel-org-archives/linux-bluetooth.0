Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <533660.67769.qm@web38512.mail.mud.yahoo.com>
References: <533660.67769.qm@web38512.mail.mud.yahoo.com>
Date: Sun, 17 Jun 2007 09:20:55 +0200
Message-Id: <1182064855.30934.53.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] HCI socket listen
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Robert,

> Can a HCI socket listen for connections like l2cap and rfcomm ?? In my
> case it throws followiing warning and does not listen:
> 
> GLib-WARNING **: giounix.c:400Error while getting flags for FD: Bad
> file descriptor (9)
> 
> In my program I do the following:
> 
> I Open and Bind the HCI socket (using hci_open_dev)and listen for
> connections.

the HCI socket is not working this way. Use L2CAP if you wanna receive
incoming connections and data.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
