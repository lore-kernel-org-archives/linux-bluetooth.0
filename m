Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42F0BB9C.4010202@infomatrix.com>
From: Ben Tullis <ben.tullis@infomatrix.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] rfcomm connection for DUN is flaky
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
Date: Wed, 03 Aug 2005 13:42:04 +0100

Hi all.

I am having a problem with rfcomm for dial-up networking.
The hardware is:

Bluetooth hci_usb internal on Sony Vaio T2XP
Bluetooth on Nokia 6680

The software is:

Debian 3.1 + packages from unstable
bluez-hcidump 1.23-1
bluez-utils 2.18-1
bluez-pin 0.25-1
gnome-bluetooth 0.5.1-1 (from debian.usefulinc.com/gnome ./)
libbluetooth1 2.18-1

kernel 2.6.12.3 + bluetooth modules

hciconfig reports:

> hci0:   Type: USB
>         BD Address: 00:01:4A:26:9C:04 ACL MTU: 192:8 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:157 acl:0 sco:0 events:21 errors:0
>         TX bytes:593 acl:0 sco:0 commands:21 errors:0

I have set up rfcomm channels for OBEX and DUN like this

> rfcomm0 {
>         bind yes;
>         device 00:12:62:AA:29:95;
>         channel 12;
>         comment "Nokia OBEX PC Suite Services";
>         }
> rfcomm1 {
>         bind yes;
>         device 00:12:62:AA:29:95;
>         channel 10;
>         comment "OBEX file transfer";
>         }
> rfcomm2 {
>         bind yes;
>         device 00:12:62:AA:29:95;
>         channel 9;
>         comment "OBEX file push";
>         }
> rfcomm3 {
>         bind yes;
>         device 00:12:62:AA:29:95;
>         channel 1;
>         comment "Dial-up Networking";
>         bind yes;
> }

Starting the bluez-utils services and then running rfcomm shows this:

> rfcomm0: 00:12:62:AA:29:95 channel 12 clean
> rfcomm1: 00:12:62:AA:29:95 channel 10 clean
> rfcomm2: 00:12:62:AA:29:95 channel 9 clean
> rfcomm3: 00:12:62:AA:29:95 channel 1 clean

I have a ppp connection which looks like:

> /etc/ppp/peers/orange:
> debug
> nodetach
> noauth
> lcp-echo-failure 0
> connect "/usr/sbin/chat -v -f /etc/chatscripts/orange"
> debug
> /dev/rfcomm3 115200
> defaultroute
> usepeerdns
> noipdefault
> local
> crtscts
> novj
> nobsdcomp
> nopcomp
> noaccomp

The corresponding chatscript looks like this:

> TIMEOUT 20
> ECHO    ON
> ABORT   '\nBUSY\r'
> ABORT   '\nERROR\r'
> ABORT    '\nNO ANSWER\r'
> ABORT    '\nNO CARRIER\r'
> ABORT    '\nNO DIALTONE\r'
> ABORT    '\nRINGING\r\n\r\nRINGING\r'
> ''       \rAT
> TIMEOUT  12
> OK       ATE0
> OK       'AT+cgdcont=1,"IP","orangeinternet"'
> OK       ATD*99***1#

The problem is this:
When I start the connection, most of the time it gets through the 
chatscript and starts sending LCP negotiation.
Then it stops receiving messages from the phone.

like this:

>  pon orange
> AT
> OK
> ATE0
> OK
>
> OK
> Serial connection established.
> using channel 11
> Using interface ppp0
> Connect: ppp0 <--> /dev/rfcomm3
> sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x204d2d31>]
> sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x204d2d31>]
> sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x204d2d31>]
> sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x204d2d31>]
> sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x204d2d31>]
> sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x204d2d31>]
> sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x204d2d31>]
> sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x204d2d31>]
> sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x204d2d31>]
> sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0x204d2d31>]
> Terminating on signal 2       ### Pressed ctrl-C here
> sent [LCP TermReq id=0x2 "User request"]
> sent [LCP TermReq id=0x3 "User request"]
> Connection terminated.
> Receive serial link is not 8-bit clean:
> Problem: all had bit 7 set to 0
> Modem hangup

The the corresponding rfcomm channel is closed:
runing rfcomm again shows:

> rfcomm0: 00:12:62:AA:29:95 channel 12 clean
> rfcomm1: 00:12:62:AA:29:95 channel 10 clean
> rfcomm2: 00:12:62:AA:29:95 channel 9 clean
> rfcomm3: 00:12:62:AA:29:95 channel 1 closed

It will never connect again to this channel unless I restart the rfcomm 
process and/or remove the rfcomm module and start again.

However the OBEX services continue working seamlessly, so I think that 
the pairing must be OK.

Can anyone suggest anything to try?

I see from the news on bluez.org that the latest kernel: patch 
2.6.12-mh2 includes improvements for rfcomm, DCD detection and remote 
port negotiation. Should this patch be applied to a pristine 2.6.12 
kernel source (before the 2.6.12.3 update patch) or is this already 
included in the kernel.org source?

Many thanks in advance.

Ben Tullis


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
