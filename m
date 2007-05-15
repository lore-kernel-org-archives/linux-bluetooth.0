Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <566410.37979.qm@web43132.mail.sp1.yahoo.com>
References: <566410.37979.qm@web43132.mail.sp1.yahoo.com>
Date: Tue, 15 May 2007 17:59:55 +0200
Message-Id: <1179244795.10069.28.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Packet type
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

Hi Marco,

>  I wrote a program to create a bluetooth connection using
> hci_create_connection  and the devices get connected but how do I send
> and recieve packets using this connections. My aim is to test the
> communication link between the devices using different packet
> types(DM1,DM3,DM5...)
> 
> Can someone please give me a hint on how this can be done. I have been
> struggling a lot as I am new to Bluez and C programming.

don't do that. Use a L2CAP socket.

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
