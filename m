Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200611231526.09459.denis.kenzior@trolltech.com>
References: <200611231526.09459.denis.kenzior@trolltech.com>
Date: Thu, 23 Nov 2006 06:35:34 +0100
Message-Id: <1164260134.4847.12.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] DBus SDP API
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Denis,

> Have you given any more thought as to how the RFCOMM channels are managed by 
> the DBus Service API?  The same goes for L2CAP.  From what I understand the 
> current implementation depends on clients to know what is available...

yes. That is where the "name" parameter in the XML record is for. You
can simply override it with your own values. However this must be
application or service specific.

> Will there be a lower-level SDP registration framework for the local device?  
> E.g. to be able to manually register records in binary/XML format without 
> creating a service agent?

It is there at the moment by using the Bluetooth library. However I have
no idea if it will stay there. I don't see any real use case except for
debugging and with your enhancement to service-agent.c even that case is
not really existent anymore.

> Most importantly, do you have plans for local versions of
>                 array{uint32} GetRemoteServiceHandles(string address, string 
> match)
> 
> and
> 
>                 array{byte} GetRemoteServiceRecord(string address, uint32 
> handle)
> 
> ?

I thought about that multiple times. Every time I convinced myself to
implement it, I failed to find the use case for it.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
