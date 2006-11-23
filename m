Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Thu, 23 Nov 2006 15:52:16 +1000
References: <200611231526.09459.denis.kenzior@trolltech.com>
	<1164260134.4847.12.camel@localhost>
In-Reply-To: <1164260134.4847.12.camel@localhost>
MIME-Version: 1.0
Message-Id: <200611231552.16972.denis.kenzior@trolltech.com>
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

On Thursday 23 November 2006 15:35, Marcel Holtmann wrote:
> Hi Denis,
>
> > Have you given any more thought as to how the RFCOMM channels are managed
> > by the DBus Service API?  The same goes for L2CAP.  From what I
> > understand the current implementation depends on clients to know what is
> > available...
>
> yes. That is where the "name" parameter in the XML record is for. You
> can simply override it with your own values. However this must be
> application or service specific.

So hcid will never be responsible for allocating rfcomm channels?  I'm not 
sure that's a good idea, since everybody will implement it themselves (and 
probably get it wrong anyway)

>
> > Will there be a lower-level SDP registration framework for the local
> > device? E.g. to be able to manually register records in binary/XML format
> > without creating a service agent?
>
> It is there at the moment by using the Bluetooth library. However I have
> no idea if it will stay there. I don't see any real use case except for
> debugging and with your enhancement to service-agent.c even that case is
> not really existent anymore.

I see two advantages to doing this.  The main use case would be to deprecate 
some aspects of sdptool and all the hairy code in there that does the 
registration.  Move all of it to XML/Binary files.  The second would be the 
completeness of the DBUS API. 

>
> > Most importantly, do you have plans for local versions of
> >                 array{uint32} GetRemoteServiceHandles(string address,
> > string match)
> >
> > and
> >
> >                 array{byte} GetRemoteServiceRecord(string address, uint32
> > handle)
> >
> > ?
>
> I thought about that multiple times. Every time I convinced myself to
> implement it, I failed to find the use case for it.

Well I can see several useful things you can do:
- If hcid doesn't manage RFCOMM channels, how will an application know 
dynamically what channel is available?  Such an operation will never be 
atomic (another argument for doing it in hcid), but  at least you can do 
selection semi-intelligently.

- I can see a GNOME / KDE app that displays all services running on the local 
device, and use the UUIDs to identify exactly what type of service it is 
(e.g. for icons) without having to rely on Text descriptions from the DBus 
Service API.  

Regards,
-Denis

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
