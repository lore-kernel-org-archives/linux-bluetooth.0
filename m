Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] USB drivers & architecture
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <008c01c50a35$c68c11e0$0100a8c0@hppav>
References: <008c01c50a35$c68c11e0$0100a8c0@hppav>
Content-Type: text/plain
Message-Id: <1107465892.6911.3.camel@pegasus>
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
Date: Thu, 03 Feb 2005 22:24:52 +0100

Hi Oliver,

> I am new in the list and I hope I am not making a rethorical
> question, 
>  
> I am looking at the linux source code and the architecture of BlueZ on
> the website.
>  
> I can see that in the folder /net/bluetooth/* there is the
> implementation of the layers HCI and L2CAP
>  
> Inside there is some foldwers like /bnep /rfcoom /hidp... which are
> layers on the top of L2CAP
>  
> The blueZ libs bring us the API to acces these last layers.... 
>  
> At this point if I am wong, I beg for a correction.

everything is fine so far.
 
> So my question is, where are the sources for the physical layers?
> Where can I the drivers for the USB dongles etc?

Look at drivers/bluetooth/ for the host transport drivers.
 
> What is exactily what I found in /drivers/usb/classa/bluetty ?

It is an old driver that converts a Bluetooth H:2 dongle into a
Bluetooth serial device with H:4 protocol.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
