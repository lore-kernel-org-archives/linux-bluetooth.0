Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Handling multiple rfcomm connections
From: Marcel Holtmann <marcel@holtmann.org>
To: "Williams, Richard" <Richard.Williams@VITRONICS.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <A1F0D47583A2D711919F00600819B3A45BDAA3@goofy.vitronics.com>
References: <A1F0D47583A2D711919F00600819B3A45BDAA3@goofy.vitronics.com>
Content-Type: text/plain
Message-Id: <1075562704.2720.16.camel@pegasus>
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
Date: Sat, 31 Jan 2004 16:25:04 +0100

Hi Richard,

> We have a small single board computer (SBC) that will act as a personal
> network server. This SBC has WiFi to get out to the network and
> Bluetooth to connect to various Bluetooth equipped peripheral 
> devices. Some of the peripheral devices are sensors - they only send 
> data to the SBC. Other peripherals both send and receive data. The
> applications send small amounts of data through rfcomm connections.
> Occasionally, there are also non-rfcomm connections - OBEX and SCO 
> are being done simultaneously with the rfcomms.
> 
> Now we're writing the software for the SBC, and we have multiple BT 
> connections to manage. We've thought about a BT daemon that will manage 
> the BT radio and the various rfcomm connections, providing a standard
> socket interface from the BT stack toward the rest of the applications.
> We want to completely isolate the BT hardware from the applications, so 
> the applications designer only needs to know about socket connections and
> need not be concerned with BT.

maybe you should start to use an event loop, like Glib offers you.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
