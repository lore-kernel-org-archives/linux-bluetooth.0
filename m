Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4E2B3.C7842AFE"
Message-ID: <A1F0D47583A2D711919F00600819B3A45BDE4E@goofy.vitronics.com>
From: "Williams, Richard" <Richard.Williams@VITRONICS.com>
To: "Bluez-Devel (E-mail)" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Question about role switch
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
Date: Wed, 15 Dec 2004 09:38:44 -0500

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4E2B3.C7842AFE
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Marcel,

I have three systems:
1. an Intel X-scale single board computer, Linux 2-4-20 with latest =
bluez patches
2. a desktop PC, Linux 2.4.20 with latest bluez patches.
3. Windows 2000 PC

I have the bluez stack running on system 1, and I'm able to scan it, =
connect to it and run higher level protocols such as obex and pan. As I =
add more features to system 1, I find that some other commands from =
system 2 no longer work. For example, I start pand running on system 1 =
as the master, I am unable to do an hcitool info from system 2 towards =
system 1. I'm suspecting that after I start pand --master, system 1 is =
not performing the role switch from master to slave ????

But look at later in the dump, the Windows system is able to connect =
just fine.

Any ideas ??

As usual, thank you for your help.

Best Regards,

Rich Williams

-------------------------------------------------------------------------=
-------------------
Here's the hcidump's from system 1, as I add each new protocol:


[System 1]$ps
  PID  Uid     VmSize Stat Command
    1 root       1136 S    init [3]
    2 root            S    [keventd]
    3 root            S    [ksoftirqd_CPU0]
    4 root            S    [kswapd]
    5 root            S    [bdflush]
    6 root            S    [kupdated]
    7 root            S    [mtdblockd]
    8 root            S    [khubd]
   64 root       1428 S    syslogd -m 0
  107 bin        1220 S    portmap
  134 root            S    [krfcommd]
  138 root       1072 S    hciattach /dev/ttyS2 csr 115200 noflow
  160 root       1152 S    inetd
  166 root       1324 S    /sbin/getty 38400 tty1
  167 root       1560 S    -bash
  173 root       1256 S    /sbin/cardmgr -f
  179 root       1244 S    /flash/bin/button -p 178
  183 root       1504 R    ps
[System 1]$hcid

>>>>>>>I then do an hcitool info 00:A0:96:08:E7:86 from system 2 and=20
>>>>>>>this works OK:=20
[System 1]$hcidump
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Disconn Complete (0x05) plen 4
     =20

>>>>>>>On system 1, I start sdpd, then do an hcitool info =
00:A0:96:08:E7:86=20
>>>>>>>from system 2 and this works OK:                                  =
                                                         =20
[System 1]$sdpd
[System 1]$hcidump
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Disconn Complete (0x05) plen 4
           =20

                                                                         =
           =20
>>>>>>>On system 1, I start opd, then do an hcitool info =
00:A0:96:08:E7:86=20
>>>>>>>from system 2 and this works OK:=20
                                                                         =
                 =20
[System 1]$opd --daemonize --sdp --channel 10 --path /mnt/cf/images
[System 1]$hcidump
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Disconn Complete (0x05) plen 4
                                      =20


                                                         =20
>>>>>>>On system 1, I start pand, then do an hcitool info =
00:A0:96:08:E7:86=20
>>>>>>>from system 2 and this always fails: =20
                                                                         =
                =20
[System 1]$pand --listen --master --role NAP
[System 1]$hcidump
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
                                                                         =
                       =20
                                                                         =
   $
[System 1]$

>>>>>>> Windows dump <<<<<<<<<
>>>>>>>>From system 3 - the Windows system, I use the Bluetooth Wizard to =
examine
>>>>>>>system 1, and this works OK. Of course, I don't have access to =
what's =20
>>>>>>>actually going on inside the Windows system=20

[System 1]$hcidump
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Role Change (0x12) plen 8
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0048
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0048 result 0 status 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 17
> ACL data: handle 0x0028 flags 0x01 dlen 3
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 8
    MTU 1612 FlushTO 65535
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0048 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0048 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1002 (PubBrwsGrp)
          max 0x14
          cont 00
< ACL data: handle 0x0028 flags 0x02 dlen 30
    L2CAP(d): cid 0x0048 len 26 [psm 1]
        SDP SS Rsp: tid 0x0 len 0x15
          tot 0x4 cur 0x4 hndl 0x0 0x200c3c8 0x200cbc0 0x200ed30
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5

>>>>>>etc. etc.
[System 1]$
[System 1]$                                                              =
                                  =20
[System 1]$hciconfig -a
hci0:   Type: UART
        BD Address: 00:A0:96:08:E7:86 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:1142 acl:20 sco:0 events:80 errors:0
        TX bytes:1268 acl:19 sco:0 commands:28 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver: =
0x175
        Manufacturer: Cambridge Silicon Radio (10)
                                                                         =
                       =20
[System 1]$ps
  PID  Uid     VmSize Stat Command
    1 root       1136 S    init [3]
    2 root            S    [keventd]
    3 root            S    [ksoftirqd_CPU0]
    4 root            S    [kswapd]
    5 root            S    [bdflush]
    6 root            S    [kupdated]
    7 root            S    [mtdblockd]
    8 root            S    [khubd]
   64 root       1428 S    syslogd -m 0
  107 bin        1220 S    portmap
  134 root            S    [krfcommd]
  138 root       1072 S    hciattach /dev/ttyS2 csr 115200 noflow
  160 root       1152 S    inetd
  166 root       1324 S    /sbin/getty 38400 tty1
  167 root       1564 S    -bash
  173 root       1256 S    /sbin/cardmgr -f
  179 root       1244 S    /flash/bin/button -p 178
  185 root       1204 S    hcid: processing events
  190 root       1240 S    sdpd
  195 root       1308 S    opd: waiting for incomming OBEX connections =
on chann
  198 root       1240 S    /sbin/pand --listen --master --role NAP
  202 root       1504 R    ps
[System 1]$






>>>>>>>Here's the commands from system 2:
>>>>>>> I just started hcid on system 1
[System 2]# hcitool info 00:A0:96:08:E7:86
Requesting information ...
        BD Address:  00:A0:96:08:E7:86
        Device Name: BlueZ (0)
        LMP Version: 1.1 (0x1) LMP Subversion: 0x175
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot =
offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 =
packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging =
scheme>
                <power control> <transparent SCO>


>>>>>>> I just started sdpd on system 1
[System 2]# hcitool info 00:A0:96:08:E7:86
Requesting information ...
        BD Address:  00:A0:96:08:E7:86
        Device Name: BlueZ (0)
        LMP Version: 1.1 (0x1) LMP Subversion: 0x175
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot =
offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 =
packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging =
scheme>
                <power control> <transparent SCO>


>>>>>>> I just started opd on system 1
[System 2]# hcitool info 00:A0:96:08:E7:86
Requesting information ...
        BD Address:  00:A0:96:08:E7:86
        Device Name: BlueZ (0)
        LMP Version: 1.1 (0x1) LMP Subversion: 0x175
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot =
offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 =
packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging =
scheme>
                <power control> <transparent SCO>
[System 2]#=20


>>>>>>> I just started pand --master on system 1
[System 2]# hcitool info 00:A0:96:08:E7:86
Requesting information ...
Can't create connection: Input/output error
[System 2]#=20
[System 2]#=20









Richard B. Williams
Vitronics, Inc.
An MTC Technologies Company
3 Corbett Way
Eatontown, NJ 07724-2262
732-389-0244 x29
Richard.Williams@vitronics.com


------_=_NextPart_001_01C4E2B3.C7842AFE
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6249.1">
<TITLE>Question about role switch</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hello Marcel,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I have three systems:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">1. an Intel X-scale single board =
computer, Linux 2-4-20 with latest bluez patches</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">2. a desktop PC, Linux 2.4.20 with =
latest bluez patches.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">3. Windows 2000 PC</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I have the bluez stack running on =
system 1, and I'm able to scan it, connect to it and run higher level =
protocols such as obex and pan. As I add more features to system 1, I =
find that some other commands from system 2 no longer work. For example, =
I start pand running on system 1 as the master, I am unable to do an =
hcitool info from system 2 towards system 1. I'm suspecting that after I =
start pand --master, system 1 is not performing the role switch from =
master to slave ????</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">But look at later in the dump, the =
Windows system is able to connect just fine.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Any ideas ??</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">As usual, thank you for your =
help.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Best Regards,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Rich Williams</FONT>
</P>

<P><FONT SIZE=3D2 =
FACE=3D"Arial">----------------------------------------------------------=
----------------------------------</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Here's the hcidump's from system 1, as =
I add each new protocol:</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Courier New">[System 1]$ps</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; PID&nbsp; =
Uid&nbsp;&nbsp;&nbsp;&nbsp; VmSize Stat Command</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; 1 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1136 S&nbsp;&nbsp;&nbsp; init =
[3]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; 2 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp; [keventd]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; 3 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp; [ksoftirqd_CPU0]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; 4 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp; [kswapd]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; 5 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp; [bdflush]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; 6 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp; [kupdated]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; 7 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp; [mtdblockd]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; 8 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp; [khubd]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; 64 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1428 S&nbsp;&nbsp;&nbsp; =
syslogd -m 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 107 =
bin&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1220 S&nbsp;&nbsp;&nbsp; =
portmap</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 134 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp; [krfcommd]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 138 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1072 S&nbsp;&nbsp;&nbsp; =
hciattach /dev/ttyS2 csr 115200 noflow</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 160 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1152 S&nbsp;&nbsp;&nbsp; =
inetd</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 166 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1324 S&nbsp;&nbsp;&nbsp; =
/sbin/getty 38400 tty1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 167 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1560 S&nbsp;&nbsp;&nbsp; =
-bash</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 173 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1256 S&nbsp;&nbsp;&nbsp; =
/sbin/cardmgr -f</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 179 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1244 S&nbsp;&nbsp;&nbsp; =
/flash/bin/button -p 178</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 183 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1504 R&nbsp;&nbsp;&nbsp; =
ps</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 1]$hcid</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">&gt;&gt;&gt;&gt;&gt;&gt;&gt;I =
then do an hcitool info 00:A0:96:08:E7:86 from system 2 and </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt;&gt;&gt;&gt;&gt;&gt;&gt;this =
works OK: </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 1]$hcidump</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HCIDump - HCI packet analyzer =
ver 1.11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">device: hci0 snap_len: 1028 =
filter: 0xffffffff</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Connect Request =
(0x04) plen 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; HCI Command: Accept =
Connection Request (0x01|0x0009) plen 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Command Status =
(0x0f) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Connect Complete =
(0x03) plen 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; HCI Command: Write Link =
Policy Settings (0x02|0x000d) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Page Scan =
Repetition Mode Change (0x20) plen 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Command Complete =
(0x0e) plen 6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; HCI Command: Change =
Connection Packet Type (0x01|0x000f) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Command Status =
(0x0f) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Connection =
Packet Type Changed (0x1d) plen 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Max Slots Change =
(0x1b) plen 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Disconn Complete =
(0x05) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">&gt;&gt;&gt;&gt;&gt;&gt;&gt;On =
system 1, I start sdpd, then do an hcitool info 00:A0:96:08:E7:86 =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt;&gt;&gt;&gt;&gt;&gt;&gt;from =
system 2 and this works =
OK:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">[System 1]$sdpd</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 1]$hcidump</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HCIDump - HCI packet analyzer =
ver 1.11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">device: hci0 snap_len: 1028 =
filter: 0xffffffff</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Connect Request =
(0x04) plen 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; HCI Command: Accept =
Connection Request (0x01|0x0009) plen 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Command Status =
(0x0f) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Connect Complete =
(0x03) plen 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; HCI Command: Write Link =
Policy Settings (0x02|0x000d) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Page Scan =
Repetition Mode Change (0x20) plen 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Command Complete =
(0x0e) plen 6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; HCI Command: Change =
Connection Packet Type (0x01|0x000f) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Command Status =
(0x0f) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Connection =
Packet Type Changed (0x1d) plen 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Max Slots Change =
(0x1b) plen 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Disconn Complete =
(0x05) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt;&gt;&gt;&gt;&gt;&gt;&gt;On =
system 1, I start opd, then do an hcitool info 00:A0:96:08:E7:86 </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt;&gt;&gt;&gt;&gt;&gt;&gt;from =
system 2 and this works OK: </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 1]$opd --daemonize --sdp =
--channel 10 --path /mnt/cf/images</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 1]$hcidump</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HCIDump - HCI packet analyzer =
ver 1.11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">device: hci0 snap_len: 1028 =
filter: 0xffffffff</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Connect Request =
(0x04) plen 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; HCI Command: Accept =
Connection Request (0x01|0x0009) plen 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Command Status =
(0x0f) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Connect Complete =
(0x03) plen 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; HCI Command: Write Link =
Policy Settings (0x02|0x000d) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Page Scan =
Repetition Mode Change (0x20) plen 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Command Complete =
(0x0e) plen 6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; HCI Command: Change =
Connection Packet Type (0x01|0x000f) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Command Status =
(0x0f) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Connection =
Packet Type Changed (0x1d) plen 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Max Slots Change =
(0x1b) plen 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Disconn Complete =
(0x05) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; </FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt;&gt;&gt;&gt;&gt;&gt;&gt;On =
system 1, I start pand, then do an hcitool info 00:A0:96:08:E7:86 =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt;&gt;&gt;&gt;&gt;&gt;&gt;from =
system 2 and this always fails:&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 1]$pand --listen =
--master --role NAP</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 1]$hcidump</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HCIDump - HCI packet analyzer =
ver 1.11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">device: hci0 snap_len: 1028 =
filter: 0xffffffff</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Connect Request =
(0x04) plen 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; HCI Command: Accept =
Connection Request (0x01|0x0009) plen 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Command Status =
(0x0f) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Connect Complete =
(0x03) plen 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; $</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 1]$</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">&gt;&gt;&gt;&gt;&gt;&gt;&gt; =
Windows dump &lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt;&gt;&gt;&gt;&gt;&gt;&gt;From =
system 3 - the Windows system, I use the Bluetooth Wizard to =
examine</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;&gt;&gt;&gt;&gt;&gt;system 1, and this works OK. Of course, =
I don't have access to what's&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;&gt;&gt;&gt;&gt;&gt;actually going on inside the Windows =
system </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">[System 1]$hcidump</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">HCIDump - HCI packet analyzer =
ver 1.11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">device: hci0 snap_len: 1028 =
filter: 0xffffffff</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Connect Request =
(0x04) plen 10</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; HCI Command: Accept =
Connection Request (0x01|0x0009) plen 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Command Status =
(0x0f) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Role Change =
(0x12) plen 8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Connect Complete =
(0x03) plen 11</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; HCI Command: Write Link =
Policy Settings (0x02|0x000d) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Page Scan =
Repetition Mode Change (0x20) plen 7</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Command Complete =
(0x0e) plen 6</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; HCI Command: Change =
Connection Packet Type (0x01|0x000f) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Max Slots Change =
(0x1b) plen 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Command Status =
(0x0f) plen 4</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Connection =
Packet Type Changed (0x1d) plen 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; ACL data: handle 0x0028 =
flags 0x02 dlen 12</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; L2CAP(s): =
Connect req: psm 1 scid 0x0048</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; ACL data: handle 0x0028 =
flags 0x02 dlen 16</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; L2CAP(s): =
Connect rsp: dcid 0x0040 scid 0x0048 result 0 status 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Number of =
Completed Packets (0x13) plen 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; ACL data: handle 0x0028 =
flags 0x02 dlen 17</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; ACL data: handle 0x0028 =
flags 0x01 dlen 3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; L2CAP(s): =
Config req: dcid 0x0040 flags 0x0000 clen 8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; MTU 1612 =
FlushTO 65535</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; ACL data: handle 0x0028 =
flags 0x02 dlen 14</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; L2CAP(s): =
Config rsp: scid 0x0048 flags 0x0000 result 0 clen 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; ACL data: handle 0x0028 =
flags 0x02 dlen 12</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; L2CAP(s): =
Config req: dcid 0x0048 flags 0x0000 clen 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Number of =
Completed Packets (0x13) plen 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Number of =
Completed Packets (0x13) plen 5</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; ACL data: handle 0x0028 =
flags 0x02 dlen 14</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; L2CAP(s): =
Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; ACL data: handle 0x0028 =
flags 0x02 dlen 17</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; L2CAP(d): cid =
0x0040 len 13 [psm 1]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Req: tid 0x0 len =
0x8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-16 =
0x1002 (PubBrwsGrp)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max =
0x14</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&lt; ACL data: handle 0x0028 =
flags 0x02 dlen 30</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; L2CAP(d): cid =
0x0048 len 26 [psm 1]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SS Rsp: tid 0x0 len =
0x15</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tot 0x4 cur =
0x4 hndl 0x0 0x200c3c8 0x200cbc0 0x200ed30</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont =
00</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt; HCI Event: Number of =
Completed Packets (0x13) plen 5</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">&gt;&gt;&gt;&gt;&gt;&gt;etc. =
etc.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 1]$</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System =
1]$&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 1]$hciconfig -a</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">hci0:&nbsp;&nbsp; Type: =
UART</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: =
00:A0:96:08:E7:86 ACL MTU: 192:8&nbsp; SCO MTU: 64:8</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN =
ISCAN</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:1142 acl:20 =
sco:0 events:80 errors:0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:1268 acl:19 =
sco:0 commands:28 errors:0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f =
0x00 0x00 0x00 0x00 0x00</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 =
DH1 DH3 DH5 HV1 HV2 HV3</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH =
HOLD SNIFF PARK</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE =
ACCEPT</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'BlueZ (0)'</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x000100</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: =
Unspecified</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, =
Uncategorized</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI =
Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver: 0x175</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge =
Silicon Radio (10)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 1]$ps</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; PID&nbsp; =
Uid&nbsp;&nbsp;&nbsp;&nbsp; VmSize Stat Command</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; 1 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1136 S&nbsp;&nbsp;&nbsp; init =
[3]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; 2 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp; [keventd]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; 3 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp; [ksoftirqd_CPU0]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; 4 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp; [kswapd]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; 5 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp; [bdflush]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; 6 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp; [kupdated]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; 7 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp; [mtdblockd]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; 8 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp; [khubd]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; 64 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1428 S&nbsp;&nbsp;&nbsp; =
syslogd -m 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 107 =
bin&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1220 S&nbsp;&nbsp;&nbsp; =
portmap</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 134 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
S&nbsp;&nbsp;&nbsp; [krfcommd]</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 138 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1072 S&nbsp;&nbsp;&nbsp; =
hciattach /dev/ttyS2 csr 115200 noflow</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 160 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1152 S&nbsp;&nbsp;&nbsp; =
inetd</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 166 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1324 S&nbsp;&nbsp;&nbsp; =
/sbin/getty 38400 tty1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 167 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1564 S&nbsp;&nbsp;&nbsp; =
-bash</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 173 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1256 S&nbsp;&nbsp;&nbsp; =
/sbin/cardmgr -f</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 179 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1244 S&nbsp;&nbsp;&nbsp; =
/flash/bin/button -p 178</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 185 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1204 S&nbsp;&nbsp;&nbsp; hcid: =
processing events</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 190 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1240 S&nbsp;&nbsp;&nbsp; =
sdpd</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 195 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1308 S&nbsp;&nbsp;&nbsp; opd: =
waiting for incomming OBEX connections on chann</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 198 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1240 S&nbsp;&nbsp;&nbsp; =
/sbin/pand --listen --master --role NAP</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; 202 =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1504 R&nbsp;&nbsp;&nbsp; =
ps</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 1]$</FONT>
</P>
<BR>
<BR>
<BR>
<BR>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Courier =
New">&gt;&gt;&gt;&gt;&gt;&gt;&gt;Here's the commands from system =
2:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&gt;&gt;&gt;&gt;&gt;&gt;&gt; I =
just started hcid on system 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 2]# hcitool info =
00:A0:96:08:E7:86</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Requesting information =
...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; =
00:A0:96:08:E7:86</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Name: BlueZ =
(0)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 1.1 (0x1) =
LMP Subversion: 0x175</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge =
Silicon Radio (10)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f =
0x00 0x00 0x00 0x00 0x00</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot packets&gt; =
&lt;encryption&gt; &lt;slot offset&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &lt;timing accuracy&gt; &lt;role switch&gt; =
&lt;hold mode&gt; &lt;sniff mode&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &lt;park state&gt; &lt;RSSI&gt; &lt;channel =
quality&gt; &lt;SCO link&gt; &lt;HV2 packets&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law =
log&gt; &lt;CVSD&gt; &lt;paging scheme&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &lt;power control&gt; &lt;transparent =
SCO&gt;</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Courier New">&gt;&gt;&gt;&gt;&gt;&gt;&gt; I =
just started sdpd on system 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 2]# hcitool info =
00:A0:96:08:E7:86</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Requesting information =
...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; =
00:A0:96:08:E7:86</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Name: BlueZ =
(0)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 1.1 (0x1) =
LMP Subversion: 0x175</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge =
Silicon Radio (10)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f =
0x00 0x00 0x00 0x00 0x00</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot packets&gt; =
&lt;encryption&gt; &lt;slot offset&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &lt;timing accuracy&gt; &lt;role switch&gt; =
&lt;hold mode&gt; &lt;sniff mode&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &lt;park state&gt; &lt;RSSI&gt; &lt;channel =
quality&gt; &lt;SCO link&gt; &lt;HV2 packets&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law =
log&gt; &lt;CVSD&gt; &lt;paging scheme&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &lt;power control&gt; &lt;transparent =
SCO&gt;</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Courier New">&gt;&gt;&gt;&gt;&gt;&gt;&gt; I =
just started opd on system 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 2]# hcitool info =
00:A0:96:08:E7:86</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Requesting information =
...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; =
00:A0:96:08:E7:86</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Name: BlueZ =
(0)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 1.1 (0x1) =
LMP Subversion: 0x175</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge =
Silicon Radio (10)</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f =
0x00 0x00 0x00 0x00 0x00</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot packets&gt; =
&lt;encryption&gt; &lt;slot offset&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &lt;timing accuracy&gt; &lt;role switch&gt; =
&lt;hold mode&gt; &lt;sniff mode&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &lt;park state&gt; &lt;RSSI&gt; &lt;channel =
quality&gt; &lt;SCO link&gt; &lt;HV2 packets&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law =
log&gt; &lt;CVSD&gt; &lt;paging scheme&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &lt;power control&gt; &lt;transparent =
SCO&gt;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 2]# </FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Courier New">&gt;&gt;&gt;&gt;&gt;&gt;&gt; I =
just started pand --master on system 1</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 2]# hcitool info =
00:A0:96:08:E7:86</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Requesting information =
...</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Can't create connection: =
Input/output error</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 2]# </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">[System 2]# </FONT>
</P>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Richard B. Williams</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Vitronics, Inc.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">An MTC Technologies Company</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">3 Corbett Way</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Eatontown, NJ 07724-2262</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">732-389-0244 x29</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Richard.Williams@vitronics.com</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C4E2B3.C7842AFE--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
