Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Announce : BlueZ-based implemantation of JSR82
From: Marcel Holtmann <marcel@holtmann.org>
To: Julien Campana <juliencampana@yahoo.fr>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   ed.kay@appliancestudio.com, JavaBluetooth@Chris-Lorenz.com
In-Reply-To: <1085393268.892.40.camel@fischer>
References: <1085393268.892.40.camel@fischer>
Content-Type: text/plain
Message-Id: <1085487245.9779.89.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 25 May 2004 14:14:05 +0200

Hi Julien,

> We have developped a JSR-82 implementation for Linux, which is based on
> BlueZ and which is compatible with most USB-Dongle's.
> 
> We've used parts of JavaBluetooth.org's works and parts of JBluez's
> stuff.
> The native C-Code of the project is entirely based on the BlueZ project
> and I would like to thanks Marcel Holtmann for his answers to my
> questions, which were all helpfull.

you are welcome.

> We've decided to make the Linux version OpenSource. 
> 
> The JSR-82 specification is not yet fully implemented but the major part
> of the work (let say 95%) is done.

I would never use Java for Bluetooth programming, but it seems that some
companies wants this, especially mobile phone manufacturers. So I think
we should build up a clean implementation of the JSR-82 standard that
uses BlueZ as underlying Bluetooth stack. Clean means for me that we
should concentrate on BlueZ and try to interface BlueZ<->JSR-82 as best
as possible. Give me some comments if there is really interest in doing
this.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
