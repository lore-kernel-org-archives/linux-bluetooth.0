Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Getting remote device address & name using obex
	commands
From: Marcel Holtmann <marcel@holtmann.org>
To: jan d tux <janice@asti.dost.gov.ph>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1075194444.945.39.camel@Asgard>
References: <1075194444.945.39.camel@Asgard>
Content-Type: text/plain
Message-Id: <1075212081.12766.6.camel@pegasus>
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
Date: Tue, 27 Jan 2004 15:01:21 +0100

Hi Jan,

> Is there an obex command that I can use to get the bluetooth address and
> name of a remote device? It is possible with hci commands but I would
> like to use obex commands if it is possible.

there is not OBEX command for this.

> What Im trying to do is run the obexserver (from frasunek) and get the
> sender's address and name. 

If you know the socket descriptor you can simply get the local and the
remote address for that connection. Getting the name is a HCI command.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
