Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] USING PAN: PANU(desktop1)
	->NAP(desktop2)->internet
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050203182345.4839.qmail@web26409.mail.ukl.yahoo.com>
References: <20050203182345.4839.qmail@web26409.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1107456281.6823.1.camel@pegasus>
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
Date: Thu, 03 Feb 2005 19:44:41 +0100

Hi,

> machine.
> all is funny. 
> I did 
> #sdptool add NAP
> and I was able to find it and to connect to it.
> but if it's the sdptool which sets the services, what
> does it mean --role NAP in thes line :
> # pand --listen --role NAP

a decent version of pand can set the service entry by itself. I meant
what you see with sdptool if you execute it on your client and request
the services on the master.

> and, other thing, annother computer which is in
> windows XP needs a PIN identifier to connect itself to
> my NAP.
> where I can find this PIN whereas the PANU in linux
> connected successfuly to my NAP without asking for any
> PIN.
> In windows I tried 0000 and and without any number but
> it did't connect.

Look at /etc/bluetooth/pin for incoming connection.

> ps:Marcel you are the best i read a lot of mail by
> you. and sincerly, I admire you.

Thanks.

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
