Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm error message?
From: Marcel Holtmann <marcel@holtmann.org>
To: Anthony Yulo <strikewing16th@hotmail.com>
Cc: bluez devel <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Law11-OE68ZvRETrSel0000e9e5@hotmail.com>
References: <Law11-OE68ZvRETrSel0000e9e5@hotmail.com>
Content-Type: text/plain
Message-Id: <1074606565.7088.17.camel@pegasus>
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
Date: Tue, 20 Jan 2004 14:49:25 +0100

Hi Anthony,

first, can you please send text only emails. There is no reason to send
HTML emails to a mailing list and I tend to delete emails with a blue
background without reading them. Thanks.

> i tried using the rfcomm program to test for connections between
> cellphone and linux pc...
>  
> anton@maverick home]rfcomm -i hci0 listen 2
> Waiting for connection on channel 1
> 
> ...when i try to connect the smartphone the program returns and
> outputs the error message:
>  
> "can't create RFCOMM TTY: Operation not supported"
>  
> whats wrong with this? do i have to set some configuration files?

your kernel is compiled without RFCOMM TTY support. Set the kernel
option CONFIG_BLUEZ_RFCOMM_TTY.

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
