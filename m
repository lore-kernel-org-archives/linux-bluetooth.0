Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Developing a basic service for BlueTooth enabled
	devices
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060111093621.14949.qmail@web37008.mail.mud.yahoo.com>
References: <20060111093621.14949.qmail@web37008.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1136989762.3825.29.camel@localhost.localdomain>
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
Date: Wed, 11 Jan 2006 15:29:22 +0100

Hi,

> I am trying to develop a simple service application that will run on
> Linux boxes and serve ad hoc BlueTooth clients (mostly phones and
> PDAs) using BlueZ stack. However, I want to eliminate the dev effort
> on the client side as much as possible. There are many varieties of
> platforms on the client side and I am by myself who is working on this
> (at home). 
> 
> My first approach was to develep a web service with Apache for WAP
> enabled  browsers that would run locally on each Linux server boxes
> and serve WAP pages to the local ad-hoc mobile clients in order to
> eliminate the client side development effort. However, it looks like
> for many mobile devices I won't be able to do that. I have Motorola
> RAZR V3 Java enabled phone at home and I could not do this by
> establishing a piconet between my Kubuntu box and RAZR V3. 
> 
> What would be your suggestion? What kind of client/server platform
> would ease the work on the client side ?

I don't see easy way to avoid work on the client side. However the Java
Bluetooth programming is not that big deal (RFCOMM channels only) from
what I heard. I never did it and so I might be wrong.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
