Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm error message?
From: Marcel Holtmann <marcel@holtmann.org>
To: Anthony Yulo <strikewing16th@hotmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Law11-F41C9IHzQL9P30004988b@hotmail.com>
References: <Law11-F41C9IHzQL9P30004988b@hotmail.com>
Content-Type: text/plain
Message-Id: <1074689125.7088.71.camel@pegasus>
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
Date: Wed, 21 Jan 2004 13:45:25 +0100

Hi Anthony,

> well, im just testing with the rfcomm program to see if i can connect to the 
> linux box with a smartphone.. i didn't read the source of rfcomm that much, 
> so im asking if i can still make a bluetooth program thru RFCOMM, without 
> the TTY support?..

yes you can, but in that case you have to start with RFCOMM socket
programming. Look at rctest for an example.

> how do i set the kernel options CONFIG_BLUEZ_RFCOMM_TTY? The only way i know 
> how to set it is thru recompiling the kernel.. i.e. "make xconfig"... other 
> ways to do it?

The best way is to recompile and install the whole kernel, but
recompiling the RFCOMM module should also be enough.

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
