Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <465D4072.6030507@rousse.org>
References: <465AF314.5090206@rousse.org>
	<1180411732.21432.119.camel@aeonflux.holtmann.net>
	<465D4072.6030507@rousse.org>
Date: Wed, 30 May 2007 11:36:16 +0200
Message-Id: <1180517776.21432.182.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] dbus api
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Alexander,

> where can I read or look for examples of a service? I'm confued, how can 
> one make a service available with a name and description?

the bluez-utils source code is full of examples.

> What about listing the currently added local service records? It looks 
> like such a method is missing from the API.

And for what do you wanna use that? It is not useful at all.

> If I want to make a rfcomm-based service available on my PC for others, 
> than the right way would be to register a service record with a rfcomm 
> protocol descriptor and than I should bind listening for new connections 
> on rfcomm, right?

Yes.

> What do you mean the RFCOMM API is moved to a service? How can I access 
> it? How can I initiate a new rfcomm connection or listen for an incoming 
> one?

For servers you wanna use the RFCOMM sockets.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
