Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e98637f4050921062814aa7282@mail.gmail.com>
From: Artem Bizyukov <bizyukov@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e98637f405092102346d904d4a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e98637f4050920082942759d50@mail.gmail.com>
	 <1127231935.5168.86.camel@localhost.localdomain>
	 <e98637f405092102346d904d4a@mail.gmail.com>
Subject: [Bluez-devel] Fwd: Re[2]: It may be a bug in hcidump
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
Date: Wed, 21 Sep 2005 17:28:44 +0400

---------- Forwarded message ----------
From: Artem Bizyukov <bizyukov@gmail.com>
Date: 21.09.2005 13:34
Subject: Re: Re[2]: It may be a bug in hcidump
To: Marcel Holtmann <marcel@holtmann.org>


2005/9/20, Marcel Holtmann <marcel@holtmann.org>:
> Hi Artem,
>
> > I`m save dump with -w option.  hcidump fail only with -V option. I`m
> > tested this tool on the same system but use glibc-2.3.2. The result is
> > the same.
>
> the problem is easy, because it is not a valid HCI frame and hcidump is
> not doing any robustness checks.
>
> < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 4
>   0000: 29 00 00 00                                       )...
>
> A PIN code reply must include the BD_ADDR and not the connection handle.
> Install bluez-utils-2.21 (or from CVS) and try again.
>
> Regards
>
> Marcel
>
>
>

Hello Marcel
I used the latest utils and libs. And those dump i record with:

OMAP5912OSK:~# hcitool
hcitool - HCI Tool ver 2.21


MAP5912OSK:~# hcidump --help
HCI sniffer - Bluetooth packet analyzer ver 1.25


I`m thin this bug is not critical. In my previous post "L2CAP channel"
i describe my main problem. I cant connect to my board through L2CAP
channel.


> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 1
      Connection pending - Authentication pending
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
  0000: 29 00 01                                          )..
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 13 04                                       ....
> HCI Event: Encrypt Change (0x08) plen 4
  0000: 00 29 00 01                                       .)..
< HCI Command: Change Connection Link Key (0x01|0x0015) plen 2
  0000: 29 00                                             ).
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5

Kernel answer  "Connection pending". But i ned that kernel enswer
"Connection successful" without "Connection pending". I am write
application that must communicate with already exist big  PC
application, and i can`t change it. How i must open socket, or  set it
parametrs, for succesful connect with a PC application?


Regards.
Bizyukov Artem.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
