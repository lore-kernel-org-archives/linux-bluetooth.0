Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Some questions
From: Marcel Holtmann <marcel@holtmann.org>
To: Dirk Vornheder <DVornheder@t-online.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200406152223.33329.dvornheder@t-online.de>
References: <1BYJR5-1Xq5q40@cmpmail07.bbul.t-online.de>
	 <1086863592.1607.47.camel@pegasus>
	 <200406152223.33329.dvornheder@t-online.de>
Content-Type: text/plain
Message-Id: <1087339136.13792.96.camel@pegasus>
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
Date: Wed, 16 Jun 2004 00:38:56 +0200

Hi Dirk,

> > The CUPS printing backend for Bluetooth will help you out here.
> >
> 
> After compile and install i try to print via spp and hcrp.

It is already part of the bluez-utils-2.7.

> A connection to printer adpater is coming up but nothing is printed.
> 
> Here are some lines from my /etc/bluetooth/printers.conf:
> 
> default {
>         # Bluetooth address of the device
>         device 00:02:72:44:CF:9F;
> 
>         # Bluetooth printing protocol
>         protocol serial;
>         
>         # RFCOMM channel for the connection
>         channel 1;
> 
>         # Description of the connection
>         comment "HP-Deskjet 960C";
> 
> The entires in  cups are:
> 
> bluetooth://00027244CF9F/spp

I prefer only using the URI and you don't need to add spp or hcrp,
because the backend with use HCRP if found and only fall back to RFCOMM
printing in the other case.

Use "hcidump -x" to check what is happening.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
