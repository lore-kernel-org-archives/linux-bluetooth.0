Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DBUS service support - Initial library
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05042813004f4609a6@mail.gmail.com>
References: <e1effdeb05042813004f4609a6@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1114768038.8836.42.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 29 Apr 2005 11:47:18 +0200

Hi Claudio,

> I wrote the skeleton of the library. Please verify if I 
> am following the BlueZ principles. 
> At the moment, the code is not fully integrated 
> with BlueZ daemons and applications. Some functions 
> shall be changed due function outputs: the result 
> should be returned instead of displayed on the 
> screen.
> 
> It is only a initial draft. The idea is provide a 
> library to user mode application controls bluetooth 
> connections. Please validate my suggestions before 
> I start coding and verify if this library can be 
> useful for BlueZ community. I know that some features
> of this library are provided by "pand", but I need
> control connections from a user mode application 
> or DBUS application.

don't move anything around the utils directories. It is easier to do
that later on when it is clear what to do. If you need some stuff that
is not in the Bluetooth library duplicate the code for now.

Since this is all about pand. Extend it with your functionality and put
everything in the pand directory. I don't see any need for another
library especially when you start talking about D-Bus integration.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
