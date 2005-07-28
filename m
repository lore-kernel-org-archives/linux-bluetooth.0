Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: andy thomas <andy@time-domain.co.uk>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Kernel module for PCMCIA/CF Bluetooth cards
 with CSR chipset
In-Reply-To: <200507281340.00164.wolfgang@iksw-muees.de>
Message-ID: <Pine.LNX.4.60.0507281250290.15380@purdy.demon.co.uk>
References: <20050728030527.B34DB12FEB@sc8-sf-spam2.sourceforge.net>
 <Pine.LNX.4.60.0507281157380.15380@purdy.demon.co.uk>
 <200507281340.00164.wolfgang@iksw-muees.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463810559-1835397754-1122552493=:15380"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 28 Jul 2005 13:08:13 +0100 (BST)

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463810559-1835397754-1122552493=:15380
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 28 Jul 2005, Wolfgang M=FCes wrote:

> On Thursday 28 July 2005 13:10, andy thomas wrote:
>>    # hciattach ttyS1 bcsp 19200 flow
>
> ommit the baud rate and the "flow" parameter. It is done automaticly.
> Baud rate is set to 230K. Other won't work.

Ah, I thought I'd try a low baud rate to begin with. But it still times=20
out if I use the 'bcsp' parameter although if I use 'any' then the hci0=20
device is registered:

   # hciattach ttyS1 any
   # hciconfig -a
   hci0:   Type: UART
         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
         DOWN
         RX bytes:2086 acl:0 sco:0 events:6 errors:168
         TX bytes:4 acl:0 sco:0 commands:1 errors:0

but it still won't come up.

   # hciconfig hci0 up
   Can't init device hci0: Connection timed out (110)

Maybe there is something wrong with my hcid.conf? I note that there is no=
=20
BD address defined in the 'hciconfig -a' report above. Or perhaps I need=20
to enable support in the kernel for the 'h4' protocol although I thought
this protocol was no longer recommended for CSR-chipset cards.

Many thanks,

Andy
---1463810559-1835397754-1122552493=:15380--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
