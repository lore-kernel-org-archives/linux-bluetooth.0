Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] tcp/ip with bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de46576041107213335071d47@mail.gmail.com>
References: <2de46576041107213335071d47@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1099913078.6896.83.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 08 Nov 2004 12:24:38 +0100

Hi Manjunath,

> i have a tcp/ip client-server program (i.e) the server is listening
> and the client sends information.....right now I am communicating over
> the wired network. I want them to communicate over bluetooth.
> Is this done by enabling ppp over rfcomm?? if yes, then what am i
> suppossed to install???? some rfcomm package..
> What about using the bluez-pan package???

you can establish a TCP/IP connection with the PAN profile or LAN access
using PPP, but you can also change your program to use the RFCOMM socket
instead of the TCP socket.

Use the latest kernel and the latest bluez-libs and bluez-utils and
everything will be there.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
