Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44BB3C0D.8010509@free.fr>
Date: Mon, 17 Jul 2006 09:28:13 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <446CDD43.3050604@free.fr>	<6297d67c0607070157h3c896ee4m90cfcd7f833f8973@mail.gmail.com>
	<6297d67c0607112149p85ad067w10a0e58a7972e332@mail.gmail.com>
In-Reply-To: <6297d67c0607112149p85ad067w10a0e58a7972e332@mail.gmail.com>
Subject: Re: [Bluez-devel] New bluez headset implementation
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Mayank,

You should use headsetd instead of basichspd. This later used to be a
unit test headset server, but it is not functionnal anymore.

Cheers,

Fabien

> Hi Fabien/Brad,
>  
> Any suggestions on the mail below?
>  
> Regards,
> Mayank
> 
>  
> On 7/7/06, *Mayank Batra* <mayankbatra@gmail.com 
> <mailto:mayankbatra@gmail.com>> wrote:
> 
>     Hi Fabien,
>      
>     I was testing this application (basichspd) with two headsets.
>     But it seems that I am able to connect on RFCOMM but there is no SCO
>     connection establishment taking place.
>     On the application side, it says SCO connected but when I see the
>     hcidump logs, there is no SetupSynchronousConnection Command going out.
>      
>     Please suggest what is the problem.
>      
>     hciconfig -a shows:
>      
>     hci0:   Type: UART
>             BD Address: XX:XX:XX:XX:XX:XX ACL MTU: 1021:7  SCO MTU: 64:0
>             UP RUNNING PSCAN ISCAN AUTH ENCRYPT
>             RX bytes:4740 acl:108 sco:0 events:238 errors:0
>             TX bytes:2923 acl:117 sco:0 commands:55 errors:0
>             Features: 0xff 0xeb 0x8d 0xfe 0x9b 0xe9 0x00 0x00
>             Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV3
>             Link policy: RSWITCH HOLD SNIFF PARK
>             Link mode: SLAVE ACCEPT
>             Name: ''
>             Class: 0x000000
>             Service Classes: Unspecified
>             Device Class: Miscellaneous,
>             HCI Ver: n/a (0x3) HCI Rev: 0x402 LMP Ver: n/a (0x3) LMP
>     Subver: 0x520
>      
>     hciconfig hci0 features shows:
>      
>     hci0:   Type: UART
>             BD Address: XX:XX:XX:XX:XX:XX ACL MTU: 1021:7  SCO MTU: 64:0
>             Features: 0xff 0xeb 0x8d 0xfe 0x9b 0xe9 0x00 0x00
>                     <3-slot packets> <5-slot packets> <encryption> <slot
>     offset>
>                     <timing accuracy> <role switch> <hold mode> <sniff
>     mode>
>                     <park state> <RSSI> <SCO link> <HV3 packets> <u-law
>     log>
>                     <A-law log> <CVSD> <power control> <transparent SCO>
>                     <broadcast encrypt> <EDR ACL 2 Mbps> <EDR ACL 3 Mbps>
>                     <enhanced iscan> <interlaced iscan> <interlaced pscan>
>                     <inquiry with RSSI> <extended SCO> <EV4 packets>
>     <EV5 packets>
>                     <AFH cap. slave> <AFH class. slave> <3-slot EDR ACL>
>                     <5-slot EDR ACL> <AFH cap. master> <EDR eSCO 2 Mbps>
>                     <EDR eSCO 3 Mbps> <3-slot EDR eSCO>
>      
> 
>     hciconfig hci0 revision does not print anything about SCO mapping :(
>      
>     The hcidump -X shows:
>      
>     HCI sniffer - Bluetooth packet analyzer ver 1.30
>     device: hci0 snap_len: 1028 filter: 0xffffffff
>     < HCI Command: Create Connection (0x01|0x0005) plen 13
>       0000: d3 52 23 89 03 00 18 cc  00 00 00 00 01           .R#..........
>      > HCI Event: Command Status (0x0f) plen 4
>       0000: 00 01 05 04                                       ....
>      > HCI Event: Connect Complete (0x03) plen 11
>       0000: 00 01 00 d3 52 23 89 03  00 01 00                 ....R#.....
>      > HCI Event: Command Status (0x0f) plen 4
>       0000: 00 02 00 00                                       ....
>     < ACL data: handle 1 flags 0x02 dlen 12
>         L2CAP(s): Connect req: psm 3 scid 0x0040
>     < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>       0000: 01 00 0f 00                                       ....
>      > HCI Event: Command Complete (0x0e) plen 6
>       0000: 02 0d 08 00 01 00                                 ......
>      > HCI Event: Number of Completed Packets (0x13) plen 5
>       0000: 01 01 00 01 00                                    .....
>      > ACL data: handle 1 flags 0x02 dlen 16
>         L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 0 status 0
>           Connection successful
>     < ACL data: handle 1 flags 0x02 dlen 16
>         L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
>           MTU 1024
>      > ACL data: handle 1 flags 0x02 dlen 16
>         L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>           MTU 328
>     < ACL data: handle 1 flags 0x02 dlen 14
>         L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
>           Success
>      > HCI Event: Number of Completed Packets (0x13) plen 5
>       0000: 01 01 00 01 00                                    .....
>      > HCI Event: Number of Completed Packets (0x13) plen 5
>       0000: 01 01 00 01 00                                    .....
>      > ACL data: handle 1 flags 0x02 dlen 14
>         L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>           Success
>     < ACL data: handle 1 flags 0x02 dlen 8
>         L2CAP(d): cid 0x0041 len 4 [psm 3]
>           RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
>      > HCI Event: Number of Completed Packets (0x13) plen 5
>       0000: 01 01 00 01 00                                    .....
>      > ACL data: handle 1 flags 0x02 dlen 8
>         L2CAP(d): cid 0x0040 len 4 [psm 3]
>           RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
>     < ACL data: handle 1 flags 0x02 dlen 18
>         L2CAP(d): cid 0x0041 len 14 [psm 3]
>           RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>           dlci 4 frame_type 0 credit_flow 15 pri 0 ack_timer 0
>           frame_size 323 max_retrans 0 credits 7
>      > HCI Event: Number of Completed Packets (0x13) plen 5
>       0000: 01 01 00 01 00                                    .....
>      > ACL data: handle 1 flags 0x02 dlen 18
>         L2CAP(d): cid 0x0040 len 14 [psm 3]
>           RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
>           dlci 4 frame_type 0 credit_flow 14 pri 0 ack_timer 0
>           frame_size 100 max_retrans 0 credits 3
>     < ACL data: handle 1 flags 0x02 dlen 8
>         L2CAP(d): cid 0x0041 len 4 [psm 3]
>           RFCOMM(s): SABM: cr 1 dlci 4 pf 1 ilen 0 fcs 0x96
>      > HCI Event: Number of Completed Packets (0x13) plen 5
>       0000: 01 01 00 01 00                                    .....
>      > HCI Event: PIN Code Request (0x16) plen 6
>       0000: d3 52 23 89 03 00                                 .R#...
>     < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
>       0000: d3 52 23 89 03 00 04 30  30 30 30 00 00 00 00 00 
>     .R#....0000.....
>       0010: 00 00 00 00 00 00 00                              .......
>      > HCI Event: Command Complete (0x0e) plen 10
>       0000: 02 0d 04 00 d3 52 23 89  03 00                    .....R#...
>      > HCI Event: Link Key Notification (0x18) plen 23
>       0000: d3 52 23 89 03 00 52 71  66 24 06 e6 dd 31 f8 66 
>     .R#...Rqf$...1.f
>       0010: ee cc a2 e5 46 4e 00                              ....FN.
>      > ACL data: handle 1 flags 0x02 dlen 8
>         L2CAP(d): cid 0x0040 len 4 [psm 3]
>           RFCOMM(s): UA: cr 1 dlci 4 pf 1 ilen 0 fcs 0x5d
>     < ACL data: handle 1 flags 0x02 dlen 12
>         L2CAP(d): cid 0x0041 len 8 [psm 3]
>           RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
>           dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 10
>     < ACL data: handle 1 flags 0x02 dlen 9
>         L2CAP(d): cid 0x0041 len 5 [psm 3]
>           RFCOMM(d): UIH: cr 1 dlci 4 pf 1 ilen 0 fcs 0x79 credits 33
>     < ACL data: handle 1 flags 0x02 dlen 12
>         L2CAP(d): cid 0x0041 len 8 [psm 3]
>           RFCOMM(d): UIH: cr 1 dlci 4 pf 0 ilen 4 fcs 0x65
>           0000: 52 49 4e 47                                       RING
>      > HCI Event: Number of Completed Packets (0x13) plen 5
>       0000: 01 01 00 01 00                                    .....
>      > HCI Event: Number of Completed Packets (0x13) plen 5
>       0000: 01 01 00 01 00                                    .....
>      > HCI Event: Number of Completed Packets (0x13) plen 5
>       0000: 01 01 00 01 00                                    .....
>      > ACL data: handle 1 flags 0x02 dlen 12
>         L2CAP(d): cid 0x0040 len 8 [psm 3]
>           RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
>           dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 10
>      > ACL data: handle 1 flags 0x02 dlen 12
>         L2CAP(d): cid 0x0040 len 8 [psm 3]
>           RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
>           dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 10
>     < ACL data: handle 1 flags 0x02 dlen 12
>         L2CAP(d): cid 0x0041 len 8 [psm 3]
>           RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
>           dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 10
>      > ACL data: handle 1 flags 0x02 dlen 9
>         L2CAP(d): cid 0x0040 len 5 [psm 3]
>           RFCOMM(d): UIH: cr 0 dlci 4 pf 1 ilen 0 fcs 0xa3 credits 1
>      > HCI Event: Number of Completed Packets (0x13) plen 5
>       0000: 01 01 00 01 00                                    .....
>      
>      
>     Thanks.
>      
>     Regards,
>     Mayank
>      
> 
>      
>     On 5/19/06, *Fabien Chevalier* < fabchevalier@free.fr
>     <mailto:fabchevalier@free.fr>> wrote:
> 
> 
>         Hello all, i've been spending most of my spare time in the past
>         month writing an alternative implementation to btsco for
>         headsets support.
>         The starting point was me being frustrated not to be able to use my
>         laptop for VoIP because of crappy microphones the manufacturers
>         usually
>         put in. So my goal now is to go wireless with bluetooth. :-)
>         So here i am. The software i wrote is now mature enough to be
>         shared
>         with others.
> 
>         What i'm looking for now is peer review from experienced bluez
>         developpers about it. But that's enough about me, let's talk
>         about the
>         software :-)
> 
>         So What's In ?
> 
>         What is implemented is the AG side of the headset profile. Both
>         Headset
>         initiated connections and access gateway initiated connections are
>         supported. It does not support A2DP, as it is another profile, and
>         moreover people here are already working on the subject :-)
> 
>         The spirit that governed the design was the following:
>           - be able to handle voice over IP applications well (this means
>         keeping buffering at a minimum for a reduced latency)
>           - make it easy to use for open source VoIp apps developpers
>         (the idea
>         is that it should be very easy for the apps to provide some basic
>         support for bluetooth headsets with no change to the application
>         itself)
>           - support 100% of bluetooth headset profile (device
>         connect/disconnect, headset button push)
> 
>         The architecture is the following:
>           - 1 daemon, responsible for doing SDP, handling RFCOMM and SCO
>         channels, parsing AT commands, sending DBUS signals when things
>         happen.
>         The daemon handles application requests (referred to as AG initiated
>         connection in HSP spec) or headset connection requests (referred
>         to as
>         HS initiated connection in HSP spec)
>         The daemon also handles session caching between PCM open/close.
>           - 2 ALSA user space IO plugins (1 control, 1 PCM). Both of them
>         communicate with the daemon using unix sockets. The PCM also has an
>         instance of the SCO socket, so that it can reads/write data
>         directly to it.
> 
>         Compared to btsco, it differs in the following way:
>           - it is 100% userspace. No more kernel module.
>           - all parameters are supplied by the application to the alsa pcm
>         plugin, that will eventually forward them to the daemon. This
>         will make
>         implementation of user friendly MMI much easier (in particular,
>         there
>         is no need to lauch the daemon separately with a predefined BD
>         address.
>         The gui will thus be able to provide bd address).
>           - it handles only one active headset at a time
>           - it supports HS initiated connections as well
>           - codebase cleaner. It should be possible with minimal pain to
>             support handsfree profile.
> 
>         Still to be done :
>           1) more testing
>           2) DBUS signalling to tell the world about connected /
>         disconnected / button pushed events.
>           3) some kind of switching from headset to an alternate sound
>         device
>         in case the headset is unavailable.
>           4) interoperability testing against a variety of devices.
>           5) document the design
>           6) debug kernel sco support (more on that on a separate e-mail)
> 
>         I'm likely to do 3), 5), however 1 and 2 might be better handled
>         by somebody else, and 4 is just everybody's work :-)
> 
>         Where to get the software:
>           Simple! On my hard disk!!   No i'm kidding... but in fact not
>         completely. ;-)
>           I don't wanna start a whole open source project for such a small
>         thing. So for now i will send it by private e-mail to developers
>         interested in giving it a try. Just reply to this e-mail if you are
>         interested.
> 
>         How to play with the software:
>           - use standard aplay/arecord tools (not very funny)
>           - use xmms (a litte more funny :-) )
>           - use ekiga 2.0.1 (top fun!- however you will need to patch it and
>         rebuild it)
> 
> 
>         Fabien
> 
> 
> 
> 
> 
> 
>         -------------------------------------------------------
>         Using Tomcat but need to do more? Need to support web services,
>         security?
>         Get stuff done quickly with pre-integrated technology to make
>         your job easier
>         Download IBM WebSphere Application Server v.1.0.1 based on
>         Apache Geronimo
>         http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>         <http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642>
>         _______________________________________________
>         Bluez-devel mailing list
>         Bluez-devel@lists.sourceforge.net
>         <mailto:Bluez-devel@lists.sourceforge.net>
>         https://lists.sourceforge.net/lists/listinfo/bluez-devel
>         <https://lists.sourceforge.net/lists/listinfo/bluez-devel>
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
