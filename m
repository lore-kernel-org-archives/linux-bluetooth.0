Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <008601c474ae$20a3e540$0301a8c0@zazoumobile>
From: "Xavier GARREAU" <x.garreau@prim-time.fr>
To: <bluez-devel@lists.sourceforge.net>
References: <17ca74760407280608573db26d@mail.gmail.com>
Subject: Re: [Bluez-devel] callback for L2CAP disconnection
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 28 Jul 2004 16:21:02 +0200

Carmine Pirro wrote:
> The following is what i have to do:
> a device A is connected to a device B.
> When device A disconnects, a process on device B has to print the
> device A bluetooth address on the screen with a appropriate message.
> 
> Thank you, Carmine.

Why don't you use select or poll as in any other socket based application ?
You can also filter HCI disconnection events by using raw hci sockets ...

BR,
--
Xavier Garreau <xavier@xgarreau.org>
http://www.xgarreau.org


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
