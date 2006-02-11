Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e44ae5e0602111105n6bacb4e8i@mail.gmail.com>
From: Keith Bannister <keith.bannister@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6836_2852948.1139684731007"
Subject: [Bluez-devel] Re: Developing Broadcom driver support
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
Date: Sat, 11 Feb 2006 19:05:31 +0000

------=_Part_6836_2852948.1139684731007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Brad,


>  but it seems that the broadcom was
> erroneously returning a 0 in an mtu field


Thanks for the heads up.

I tried the Broadcom patches didn't seem to work fo me

I applied the patch from here
http://sourceforge.net/mailarchive/message.php?msg_id=3D14450798 and here
http://sourceforge.net/mailarchive/message.php?msg_id=3D14772190

using both and either one at a time. I never got much joy.

(p.s. is there a better way of recompiling than make modules;make
modules_install?)

The patch seems to correctly set the sco field:

[root@mythtv keith]# grep hci_cc_info_param /var/log/messages | grep mtu
Feb 11 16:21:24 localhost kernel: hci_cc_info_param: hci0 mtu: acl 377, sco
16 max_pkt: acl 10, sco 8

But I still don't get any audio, similar to other complaints.

>From hcidump, it looks like for some reason the driver decides not to send
any data.

The headset/dongle where a budget pack from maplin.
Dongle: LM Technologies BTU01D
Headset: LM Technologies BHS02C

That'll teach me for not getting a known brand. Oh well.

Attached is the info I can pull from various sources

If anyone has any other ideas, I'm keen to hear them.

Cheers,

Keith

-------------------------
BTSCO session
btsco v0.41
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
[root@mythtv kernel]# btsco -v 00:0B:0D:66:08:07
btsco v0.41
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
speaker volume: 11 mic volume: 13
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=3D11
Sending up speaker change 11
speaker volume: 11 mic volume: 13
driver is not in use
disconnected SCO channel

-----------------------
hci dump (run after btsco but before aplay)
root@mythtv ~]# /usr/sbin/hcidump -X
HCI sniffer - Bluetooth packet analyzer ver 1.18
device: hci0 snap_len: 1028 filter: 0xffffffff
< ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x0049 len 14 [psm 0]
      0000: 0b ef 15 41 54 2b 56 47  53 3d 31 31 0d 9a        ...AT+VGS=3D1=
1..
< ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x0049 len 14 [psm 0]
      0000: 0b ef 15 41 54 2b 56 47  4d 3d 31 33 0d 9a        ...AT+VGM=3D1=
3..
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
    handle 6 ptype 0x00e0
    Packet type: HV1 HV2 HV3
  0000: 06 00 e0 00                                       ....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 07 04                                       ....
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 02 00                                    .....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 01 00 07 08 66 0d 0b  00 00 01                 .....f.....
> ACL data: handle 6 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 0]
      0000: 09 ff 15 02 41 54 2b 56  47 53 3d 31 31 0d 5c
....AT+VGS=3D11.\
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(d): cid 0x0049 len 10 [psm 0]
      0000: 0b ef 0d 0d 0a 4f 4b 0d  0a 9a                    .....OK...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Teminated Connection
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 01 00 16

------------------------------
I ran aplay as below. I had to Ctrl-C out of it (it never finishe)

[root@mythtv kernel]# aplay -B 1000000 -D plughw:Headset
/usr/share/sounds/KDE_Startup_new.wav
Playing WAVE '/usr/share/sounds/KDE_Startup_new.wav' : Signed 16 bit Little
Endian, Rate 22050 Hz, Stereo
Aborted by signal Interrupt...


-----------------------------
kernel debug after during aplay
Feb 11 16:35:17 localhost kernel: snd-bt-sco: playback_open
Feb 11 16:35:17 localhost kernel: snd-bt-sco: prepare ok bps: 16000 size:
16002 count: 4000
Feb 11 16:35:17 localhost kernel: hci_event_packet: hci0 evt 0xf
Feb 11 16:35:17 localhost kernel: hci_cs_link_ctl: hci0 ocf 0x7
Feb 11 16:35:17 localhost kernel: hci_event_packet: hci0 evt 0x13
Feb 11 16:35:17 localhost kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1
Feb 11 16:35:17 localhost kernel: snd-bt-sco: playback_trigger 1
Feb 11 16:35:17 localhost kernel: snd-bt-sco: setting playback to bspcm
Feb 11 16:35:17 localhost kernel: hci_event_packet: hci0 evt 0x3
Feb 11 16:35:17 localhost kernel: hci_conn_complete_evt: hci0
Feb 11 16:35:18 localhost kernel: hci_event_packet: hci0 evt 0x13
Feb 11 16:35:18 localhost kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1
Feb 11 16:35:21 localhost kernel: snd-bt-sco: playback_trigger 0
Feb 11 16:35:21 localhost kernel: snd-bt-sco: setting playback to NULL
Feb 11 16:35:21 localhost kernel: snd-bt-sco: Disposing of previous socket
count 3
Feb 11 16:35:21 localhost kernel: snd-bt-sco: file_count is 2 (expected 3)
Feb 11 16:35:21 localhost kernel: hci_event_packet: hci0 evt 0xf
Feb 11 16:35:21 localhost kernel: hci_cs_link_ctl: hci0 ocf 0x6
Feb 11 16:35:21 localhost kernel: hci_cs_link_ctl: hci0 Command status: ogf
LINK_CTL ocf 6 status 0
Feb 11 16:35:21 localhost kernel: hci_event_packet: hci0 evt 0x5
Feb 11 16:35:21 localhost kernel: hci_disconn_complete_evt: hci0 status 0
Feb 11 16:35:25 localhost kernel: hci_event_packet: hci0 evt 0x13
Feb 11 16:35:25 localhost kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1
Feb 11 16:35:25 localhost kernel: hci_event_packet: hci0 evt 0x13
Feb 11 16:35:25 localhost kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1
Feb 11 16:35:27 localhost kernel: hci_event_packet: hci0 evt 0xf
Feb 11 16:35:27 localhost kernel: hci_cs_link_ctl: hci0 ocf 0x6
Feb 11 16:35:27 localhost kernel: hci_cs_link_ctl: hci0 Command status: ogf
LINK_CTL ocf 6 status 0
Feb 11 16:35:27 localhost kernel: hci_event_packet: hci0 evt 0x5
Feb 11 16:35:27 localhost kernel: hci_disconn_complete_evt: hci0 status 0


--------------------------------
root@mythtv kernel]# /usr/sbin/hciconfig -a
hci0:   Type: USB
        BD Address: 00:0B:0D:63:41:46 ACL MTU: 377:10 SCO MTU: 16:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:2507 acl:79 sco:0 events:123 errors:0
        TX bytes:2014 acl:63 sco:0 commands:42 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'mythtv-0'
        Class: 0x120104
        Service Classes: Networking
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.2 (0x2) HCI Rev: 0x4 LMP Ver: 1.2 (0x2) LMP Subver: 0x30=
9
        Manufacturer: Broadcom Corporation (15)

---------------------------
root@mythtv kernel]# /usr/sbin/hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0B:0D:63:41:46 ACL MTU: 377:10 SCO MTU: 16:8
        Firmware 4.3.009

----------------------------
[root@mythtv kernel]# hcitool info 00:0B:0D:66:08:07
Requesting information ...
        BD Address:  00:0B:0D:66:08:07
        Device Name: HSII-E
        LMP Version: 1.2 (0x2) LMP Subversion: 0x611
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xfe 0x0f 0x00 0x08 0x08 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <hold mode> <sniff mode> <RSSI> <channel quality> <SCO link=
>
                <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
                <paging scheme> <power control> <transparent SCO>
                <AFH cap. slave> <AFH cap. master>

------=_Part_6836_2852948.1139684731007
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Brad,<br><br><div><span class=3D"gmail_quote"></span><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>&nbsp;but it seems that the br=
oadcom was
<br>erroneously returning a 0 in an mtu field</blockquote><div><br>Thanks f=
or the heads up. <br>
<br>
I tried the Broadcom patches didn't seem to work fo me<br>
<br>
I applied the patch from here
<a href=3D"http://sourceforge.net/mailarchive/message.php?msg_id=3D14450798=
" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)=
">http://sourceforge.net/mailarchive/message.php?msg_id=3D14450798</a> and =
here
<a href=3D"http://sourceforge.net/mailarchive/message.php?msg_id=3D14772190=
" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)=
">http://sourceforge.net/mailarchive/message.php?msg_id=3D14772190</a><br>
<br>
using both and either one at a time. I never got much joy.<br>
<br>
(p.s. is there a better way of recompiling than make modules;make modules_i=
nstall?)<br>
<br>
The patch seems to correctly set the sco field:<br>
<br>
[root@mythtv keith]# grep hci_cc_info_param /var/log/messages | grep mtu<br=
>
Feb 11 16:21:24 localhost kernel: hci_cc_info_param: hci0 mtu: acl 377, sco=
 16 max_pkt: acl 10, sco 8<br>
<br>
But I still don't get any audio, similar to other complaints.<br>
<br>
>From hcidump, it looks like for some reason the driver decides not to send =
any data.<br>
<br>
The headset/dongle where a budget pack from maplin.<br>
Dongle: LM Technologies BTU01D<br>
Headset: LM Technologies BHS02C<br>
<br>
That'll teach me for not getting a known brand. Oh well.<br>
<br>
Attached is the info I can pull from various sources<br>
<br>
If anyone has any other ideas, I'm keen to hear them.<br>
<br>
Cheers,<br>
<br>
Keith<br>
<br>
-------------------------<br>
BTSCO session<br>
btsco v0.41<br>
Device is 1:0<br>
Voice setting: 0x0060<br>
RFCOMM channel 1 connected<br>
[root@mythtv kernel]# btsco -v 00:0B:0D:66:08:07<br>
btsco v0.41<br>
Device is 1:0<br>
Voice setting: 0x0060<br>
RFCOMM channel 1 connected<br>
speaker volume: 11 mic volume: 13<br>
i/o needed: connecting sco...<br>
connected SCO channel<br>
Done setting sco fd<br>
recieved AT+VGS=3D11<br>
Sending up speaker change 11<br>
speaker volume: 11 mic volume: 13<br>
driver is not in use<br>
disconnected SCO channel<br>
<br>
-----------------------<br>
hci dump (run after btsco but before aplay)<br>
root@mythtv ~]# /usr/sbin/hcidump -X<br>
HCI sniffer - Bluetooth packet analyzer ver 1.18<br>
device: hci0 snap_len: 1028 filter: 0xffffffff<br>
&lt; ACL data: handle 6 flags 0x02 dlen 18<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 14 [psm 0]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 0b ef 15 41 54 2b 56 47&nbsp; 53
3d 31 31 0d 9a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...AT+VGS=3D11..<b=
r>
&lt; ACL data: handle 6 flags 0x02 dlen 18<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 14 [psm 0]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 0b ef 15 41 54 2b 56 47&nbsp; 4d
3d 31 33 0d 9a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...AT+VGM=3D13..<b=
r>
&lt; HCI Command: Add SCO Connection (0x01|0x0007) plen 4<br>
&nbsp;&nbsp;&nbsp; handle 6 ptype 0x00e0<br>
&nbsp;&nbsp;&nbsp; Packet type: HV1 HV2 HV3<br>&nbsp;
0000: 06 00 e0
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
....<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 0000: 00 01 07
04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
....<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 06 00 02
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.....<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp; 0000: 00 01 00 07 08 66 0d 0b&nbsp; 00 00
01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;
.....f.....<br>
&gt; ACL data: handle 6 flags 0x02 dlen 19<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 15 [psm 0]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 09 ff 15 02 41 54 2b 56&nbsp; 47 53 3d=
 31 31 0d 5c&nbsp;&nbsp;&nbsp;&nbsp; ....AT+VGS=3D11.\<br>
&lt; ACL data: handle 6 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0049 len 10 [psm 0]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 0b ef 0d 0d 0a 4f 4b 0d&nbsp; 0a
9a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.....OK...<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 06 00 01
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.....<br>
&lt; HCI Command: Disconnect (0x01|0x0006) plen 3<br>
&nbsp;&nbsp;&nbsp; handle 1 reason 0x13<br>
&nbsp;&nbsp;&nbsp; Reason: Remote User Teminated Connection<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 0000: 00 01 06
04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
....<br>
&gt; HCI Event: Disconn Complete (0x05) plen 4<br>
&nbsp; 0000: 00 01 00
16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
<br>
------------------------------<br>
I ran aplay as below. I had to Ctrl-C out of it (it never finishe)<br>
<br>
[root@mythtv kernel]# aplay -B 1000000 -D plughw:Headset /usr/share/sounds/=
KDE_Startup_new.wav<br>
Playing WAVE '/usr/share/sounds/KDE_Startup_new.wav' : Signed 16 bit Little=
 Endian, Rate 22050 Hz, Stereo<br>
Aborted by signal Interrupt...<br>
<br>
<br>
-----------------------------<br>
kernel debug after during aplay<br>
Feb 11 16:35:17 localhost kernel: snd-bt-sco: playback_open<br>
Feb 11 16:35:17 localhost kernel: snd-bt-sco: prepare ok bps: 16000 size: 1=
6002 count: 4000<br>
Feb 11 16:35:17 localhost kernel: hci_event_packet: hci0 evt 0xf<br>
Feb 11 16:35:17 localhost kernel: hci_cs_link_ctl: hci0 ocf 0x7<br>
Feb 11 16:35:17 localhost kernel: hci_event_packet: hci0 evt 0x13<br>
Feb 11 16:35:17 localhost kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1<br=
>
Feb 11 16:35:17 localhost kernel: snd-bt-sco: playback_trigger 1<br>
Feb 11 16:35:17 localhost kernel: snd-bt-sco: setting playback to bspcm<br>
Feb 11 16:35:17 localhost kernel: hci_event_packet: hci0 evt 0x3<br>
Feb 11 16:35:17 localhost kernel: hci_conn_complete_evt: hci0<br>
Feb 11 16:35:18 localhost kernel: hci_event_packet: hci0 evt 0x13<br>
Feb 11 16:35:18 localhost kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1<br=
>
Feb 11 16:35:21 localhost kernel: snd-bt-sco: playback_trigger 0<br>
Feb 11 16:35:21 localhost kernel: snd-bt-sco: setting playback to NULL<br>
Feb 11 16:35:21 localhost kernel: snd-bt-sco: Disposing of previous socket =
count 3<br>
Feb 11 16:35:21 localhost kernel: snd-bt-sco: file_count is 2 (expected 3)<=
br>
Feb 11 16:35:21 localhost kernel: hci_event_packet: hci0 evt 0xf<br>
Feb 11 16:35:21 localhost kernel: hci_cs_link_ctl: hci0 ocf 0x6<br>
Feb 11 16:35:21 localhost kernel: hci_cs_link_ctl: hci0 Command status: ogf=
 LINK_CTL ocf 6 status 0<br>
Feb 11 16:35:21 localhost kernel: hci_event_packet: hci0 evt 0x5<br>
Feb 11 16:35:21 localhost kernel: hci_disconn_complete_evt: hci0 status 0<b=
r>
Feb 11 16:35:25 localhost kernel: hci_event_packet: hci0 evt 0x13<br>
Feb 11 16:35:25 localhost kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1<br=
>
Feb 11 16:35:25 localhost kernel: hci_event_packet: hci0 evt 0x13<br>
Feb 11 16:35:25 localhost kernel: hci_num_comp_pkts_evt: hci0 num_hndl 1<br=
>
Feb 11 16:35:27 localhost kernel: hci_event_packet: hci0 evt 0xf<br>
Feb 11 16:35:27 localhost kernel: hci_cs_link_ctl: hci0 ocf 0x6<br>
Feb 11 16:35:27 localhost kernel: hci_cs_link_ctl: hci0 Command status: ogf=
 LINK_CTL ocf 6 status 0<br>
Feb 11 16:35:27 localhost kernel: hci_event_packet: hci0 evt 0x5<br>
Feb 11 16:35:27 localhost kernel: hci_disconn_complete_evt: hci0 status 0<b=
r>
<br>
<br>
--------------------------------<br>
root@mythtv kernel]# /usr/sbin/hciconfig -a<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:0B:0D:63:41:46 AC=
L MTU: 377:10 SCO MTU: 16:8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN AUTH ENCR=
YPT<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:2507 acl:79 sco:0 event=
s:123 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:2014 acl:63 sco:0 comma=
nds:42 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xfe 0x0d 0x38 0x=
08 0x08 0x00 0x00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3=
 DH5 HV1 HV2 HV3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF =
PARK<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'mythtv-0'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x120104<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Networking<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Desktop =
workstation<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.2 (0x2) HCI Rev: 0x4 =
LMP Ver: 1.2 (0x2) LMP Subver: 0x309<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Broadcom Corporati=
on (15)<br>
<br>
---------------------------<br>
root@mythtv kernel]# /usr/sbin/hciconfig hci0 revision<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:0B:0D:63:41:46 AC=
L MTU: 377:10 SCO MTU: 16:8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Firmware 4.3.009<br>
<br>
----------------------------<br>
[root@mythtv kernel]# hcitool info 00:0B:0D:66:08:07<br>
Requesting information ...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; 00:0B:0D:66:08=
:07<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Name: HSII-E<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 1.2 (0x2) LMP Subve=
rsion: 0x611<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon =
Radio (10)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xfc 0xfe 0x0f 0x00 0x=
08 0x08 0x00 0x00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;encryption&gt; &lt;slot offset&gt; &lt;timing accuracy&gt; &lt;role
switch&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;hold mode&gt; &lt;sniff mode&gt; &lt;RSSI&gt; &lt;channel
quality&gt; &lt;SCO link&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;HV2 packets&gt; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law
log&gt; &lt;CVSD&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;paging scheme&gt; &lt;power control&gt; &lt;transparent SCO&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;AFH cap. slave&gt; &lt;AFH cap. master&gt;<br>
<br>
<br>
&nbsp;</div><br></div>


------=_Part_6836_2852948.1139684731007--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
