Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: andy thomas <andy@time-domain.co.uk>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050728030527.B34DB12FEB@sc8-sf-spam2.sourceforge.net>
Message-ID: <Pine.LNX.4.60.0507281157380.15380@purdy.demon.co.uk>
References: <20050728030527.B34DB12FEB@sc8-sf-spam2.sourceforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bluez-users] Re: Kernel module for PCMCIA/CF Bluetooth cards with CSR chipset
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
Date: Thu, 28 Jul 2005 12:10:54 +0100 (BST)

On Wed, 27 Jul 2005 wolfgang@iksw-muees.de write:

> To: bluez-users@lists.sourceforge.net
> Subject: Re: [Bluez-users] Kernel module for PCMCIA/CF Bluetooth cards with CSR chipset
> Date: Wed, 27 Jul 2005 20:54:48 +0200
> Reply-To: bluez-users@lists.sourceforge.net
>
> On Wednesday 27 July 2005 19:11, andy thomas wrote:
>> One thing puzzles me - back in March this year, Erwin Authried wrote
>> in this mailing list that PCMCIA/CF UARTs are register-compatible
>> emulations of a standard UART (see original mail below). Does this
>> mean that I could be using just the serial_cs.o kernel module for the
>> Socket CF+ card?
>
> Yes. I do it on my Zaurus.

Success! This seems to work - serial_cs is loaded as soon as I insert the 
Socket Bluetooth card and setserial reports that it is now on ttyS1

   # setserial /dev/ttyS1
   /dev/ttyS1, UART: 16950/954, Port: 0x02f8, IRQ: 3

I now load the bluez, l2cap, hci_uart kernel modules and start the HCI 
daemon, hcid - no errors are reported in either the messages or syslog 
logs. Then I try to attach the UART at /dev/ttyS1 with hciattach 
using the bcsp protocol that is supported by the CSR chipset but it times 
out:

   # hciattach ttyS1 bcsp 19200 flow
   BCSP initialization timed out

hciattach seems to ignore the -t <timeout> parameter - if I set it to 240 
second, it still times out after 10 seconds. Now, if I instead attach the 
UART using 'any' instead of 'bcsp', then it does indeed attach:

   # hciattach -t240 ttyS1 any 19200 flow
   # hciconfig -a
   hci0:   Type: UART
         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
         DOWN
         RX bytes:236 acl:0 sco:0 events:0 errors:236
         TX bytes:4 acl:0 sco:0 commands:1 errors:0

but the interface won't come up:

   # hciconfig hci0 up
   Can't init device hci0: Connection timed out (110)

and there are a lot of error messages in the syslog about the h4 
protocol:

   Jul 28 12:06:54 latitude kernel: h4_recv: Unknown HCI packet type 60
   Jul 28 12:06:54 latitude kernel: h4_recv: Unknown HCI packet type 28


What am I doing wrong? Also, is there any way to detach the UART if it has 
been attached, without rebooting the laptop?

Andy


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
