Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: "Bluez-Devel (E-mail)" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Question about role switch
In-Reply-To: <A1F0D47583A2D711919F00600819B3A45BDE4E@goofy.vitronics.com>
Message-ID: <Pine.LNX.4.33.0412151538050.2124-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 15 Dec 2004 15:41:31 +0100 (CET)


Hi Richard,

what Baseband Hardware are you using on your systems ? What Firmware
Version in case you are using CSR baseband ? Newer CSR Firmware supports
limited scatternet (1 Master even if Slave in a Pico Net), older firmware
doesn't support this. So if the Hardware on your Windows PC supports
limitted Scatternet and the other hardware does not, this may exlain what
you observe.

Ciao,

Peter


On Wed, 15 Dec 2004, Williams, Richard wrote:

> Hello Marcel,
>
> I have three systems:
> 1. an Intel X-scale single board computer, Linux 2-4-20 with latest bluez patches
> 2. a desktop PC, Linux 2.4.20 with latest bluez patches.
> 3. Windows 2000 PC
>
> I have the bluez stack running on system 1, and I'm able to scan it, connect to it and run higher level protocols such as obex and pan. As I add more features to system 1, I find that some other commands from system 2 no longer work. For example, I start pand running on system 1 as the master, I am unable to do an hcitool info from system 2 towards system 1. I'm suspecting that after I start pand --master, system 1 is not performing the role switch from master to slave ????
>
> But look at later in the dump, the Windows system is able to connect just fine.
>
> Any ideas ??
>
> As usual, thank you for your help.
>
> Best Regards,
>
> Rich Williams
>
> --------------------------------------------------------------------------------------------
> Here's the hcidump's from system 1, as I add each new protocol:
>
>
> [System 1]$ps
>   PID  Uid     VmSize Stat Command
>     1 root       1136 S    init [3]
>     2 root            S    [keventd]
>     3 root            S    [ksoftirqd_CPU0]
>     4 root            S    [kswapd]
>     5 root            S    [bdflush]
>     6 root            S    [kupdated]
>     7 root            S    [mtdblockd]
>     8 root            S    [khubd]
>    64 root       1428 S    syslogd -m 0
>   107 bin        1220 S    portmap
>   134 root            S    [krfcommd]
>   138 root       1072 S    hciattach /dev/ttyS2 csr 115200 noflow
>   160 root       1152 S    inetd
>   166 root       1324 S    /sbin/getty 38400 tty1
>   167 root       1560 S    -bash
>   173 root       1256 S    /sbin/cardmgr -f
>   179 root       1244 S    /flash/bin/button -p 178
>   183 root       1504 R    ps
> [System 1]$hcid
>
> >>>>>>>I then do an hcitool info 00:A0:96:08:E7:86 from system 2 and
> >>>>>>>this works OK:
> [System 1]$hcidump
> HCIDump - HCI packet analyzer ver 1.11
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request (0x04) plen 10
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Connect Complete (0x03) plen 11
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> > HCI Event: Command Complete (0x0e) plen 6
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Connection Packet Type Changed (0x1d) plen 5
> > HCI Event: Max Slots Change (0x1b) plen 3
> > HCI Event: Disconn Complete (0x05) plen 4
>
>
> >>>>>>>On system 1, I start sdpd, then do an hcitool info 00:A0:96:08:E7:86
> >>>>>>>from system 2 and this works OK:
> [System 1]$sdpd
> [System 1]$hcidump
> HCIDump - HCI packet analyzer ver 1.11
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request (0x04) plen 10
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Connect Complete (0x03) plen 11
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> > HCI Event: Command Complete (0x0e) plen 6
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Connection Packet Type Changed (0x1d) plen 5
> > HCI Event: Max Slots Change (0x1b) plen 3
> > HCI Event: Disconn Complete (0x05) plen 4
>
>
>
> >>>>>>>On system 1, I start opd, then do an hcitool info 00:A0:96:08:E7:86
> >>>>>>>from system 2 and this works OK:
>
> [System 1]$opd --daemonize --sdp --channel 10 --path /mnt/cf/images
> [System 1]$hcidump
> HCIDump - HCI packet analyzer ver 1.11
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request (0x04) plen 10
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Connect Complete (0x03) plen 11
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> > HCI Event: Command Complete (0x0e) plen 6
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Connection Packet Type Changed (0x1d) plen 5
> > HCI Event: Max Slots Change (0x1b) plen 3
> > HCI Event: Disconn Complete (0x05) plen 4
>
>
>
>
> >>>>>>>On system 1, I start pand, then do an hcitool info 00:A0:96:08:E7:86
> >>>>>>>from system 2 and this always fails:
>
> [System 1]$pand --listen --master --role NAP
> [System 1]$hcidump
> HCIDump - HCI packet analyzer ver 1.11
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request (0x04) plen 10
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Connect Complete (0x03) plen 11
>
>                                                                             $
> [System 1]$
>
> >>>>>>> Windows dump <<<<<<<<<
> >>>>>>>From system 3 - the Windows system, I use the Bluetooth Wizard to examine
> >>>>>>>system 1, and this works OK. Of course, I don't have access to what's
> >>>>>>>actually going on inside the Windows system
>
> [System 1]$hcidump
> HCIDump - HCI packet analyzer ver 1.11
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request (0x04) plen 10
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Role Change (0x12) plen 8
> > HCI Event: Connect Complete (0x03) plen 11
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> > HCI Event: Command Complete (0x0e) plen 6
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> > HCI Event: Max Slots Change (0x1b) plen 3
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Connection Packet Type Changed (0x1d) plen 5
> > ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0048
> < ACL data: handle 0x0028 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0048 result 0 status 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x0028 flags 0x02 dlen 17
> > ACL data: handle 0x0028 flags 0x01 dlen 3
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 8
>     MTU 1612 FlushTO 65535
> < ACL data: handle 0x0028 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0048 flags 0x0000 result 0 clen 0
> < ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0048 flags 0x0000 clen 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > HCI Event: Number of Completed Packets (0x13) plen 5
> > ACL data: handle 0x0028 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> > ACL data: handle 0x0028 flags 0x02 dlen 17
>     L2CAP(d): cid 0x0040 len 13 [psm 1]
>         SDP SS Req: tid 0x0 len 0x8
>           pat uuid-16 0x1002 (PubBrwsGrp)
>           max 0x14
>           cont 00
> < ACL data: handle 0x0028 flags 0x02 dlen 30
>     L2CAP(d): cid 0x0048 len 26 [psm 1]
>         SDP SS Rsp: tid 0x0 len 0x15
>           tot 0x4 cur 0x4 hndl 0x0 0x200c3c8 0x200cbc0 0x200ed30
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>
> >>>>>>etc. etc.
> [System 1]$
> [System 1]$
> [System 1]$hciconfig -a
> hci0:   Type: UART
>         BD Address: 00:A0:96:08:E7:86 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:1142 acl:20 sco:0 events:80 errors:0
>         TX bytes:1268 acl:19 sco:0 commands:28 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver: 0x175
>         Manufacturer: Cambridge Silicon Radio (10)
>
> [System 1]$ps
>   PID  Uid     VmSize Stat Command
>     1 root       1136 S    init [3]
>     2 root            S    [keventd]
>     3 root            S    [ksoftirqd_CPU0]
>     4 root            S    [kswapd]
>     5 root            S    [bdflush]
>     6 root            S    [kupdated]
>     7 root            S    [mtdblockd]
>     8 root            S    [khubd]
>    64 root       1428 S    syslogd -m 0
>   107 bin        1220 S    portmap
>   134 root            S    [krfcommd]
>   138 root       1072 S    hciattach /dev/ttyS2 csr 115200 noflow
>   160 root       1152 S    inetd
>   166 root       1324 S    /sbin/getty 38400 tty1
>   167 root       1564 S    -bash
>   173 root       1256 S    /sbin/cardmgr -f
>   179 root       1244 S    /flash/bin/button -p 178
>   185 root       1204 S    hcid: processing events
>   190 root       1240 S    sdpd
>   195 root       1308 S    opd: waiting for incomming OBEX connections on chann
>   198 root       1240 S    /sbin/pand --listen --master --role NAP
>   202 root       1504 R    ps
> [System 1]$
>
>
>
>
>
>
> >>>>>>>Here's the commands from system 2:
> >>>>>>> I just started hcid on system 1
> [System 2]# hcitool info 00:A0:96:08:E7:86
> Requesting information ...
>         BD Address:  00:A0:96:08:E7:86
>         Device Name: BlueZ (0)
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x175
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff mode>
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
>                 <power control> <transparent SCO>
>
>
> >>>>>>> I just started sdpd on system 1
> [System 2]# hcitool info 00:A0:96:08:E7:86
> Requesting information ...
>         BD Address:  00:A0:96:08:E7:86
>         Device Name: BlueZ (0)
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x175
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff mode>
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
>                 <power control> <transparent SCO>
>
>
> >>>>>>> I just started opd on system 1
> [System 2]# hcitool info 00:A0:96:08:E7:86
> Requesting information ...
>         BD Address:  00:A0:96:08:E7:86
>         Device Name: BlueZ (0)
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x175
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff mode>
>                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
>                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
>                 <power control> <transparent SCO>
> [System 2]#
>
>
> >>>>>>> I just started pand --master on system 1
> [System 2]# hcitool info 00:A0:96:08:E7:86
> Requesting information ...
> Can't create connection: Input/output error
> [System 2]#
> [System 2]#
>
>
>
>
>
>
>
>
>
> Richard B. Williams
> Vitronics, Inc.
> An MTC Technologies Company
> 3 Corbett Way
> Eatontown, NJ 07724-2262
> 732-389-0244 x29
> Richard.Williams@vitronics.com
>
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
