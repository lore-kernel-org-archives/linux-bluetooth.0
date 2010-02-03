Return-Path: <cyrus@holtmann.org>
Message-ID: <18126.60718.qm@web52604.mail.re2.yahoo.com>
References: <272603.59641.qm@web52603.mail.re2.yahoo.com>  <1265156906.31341.106.camel@localhost.localdomain>  <90704.85857.qm@web52601.mail.re2.yahoo.com> <1265209673.31341.116.camel@localhost.localdomain>
Date: Wed, 3 Feb 2010 08:02:18 -0800 (PST)
From: Ed Tsang <netdesign_98@yahoo.com>
Subject: Re: double Connect req: psm 1 scid 0x0040 ?
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1265209673.31341.116.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,=0A=0A>> It is a ubutunu distribution. 2.6.31-17-generic.=0A>can you=
 test with a 2.6.33-rc6 vanilla kernel. I really thing this got=0A>fixed an=
d you might see a side effect or bad patch here.=0A=0AI think you are absol=
ute right. This look like the Bluetooth:L2CAP... patch that Liejun is worki=
ng on.=0AI am just too new to linux, need to learn how to compile and insta=
ll the kernel first.=0AIf it does not work out on 2.6.33, then I will come =
back with more info.=0AIn the mean time: hcidump -X -V  (hope a bit more in=
fo to confirm the same issue).=0A------------------------------------------=
---------------------=0A> HCI Event: Connect Complete (0x03) plen 11=0A    =
status 0x00 handle 42 bdaddr 00:1C:CC:23:8F:68 type ACL encrypt 0x00=0A< HC=
I Command: Read Remote Supported Features (0x01|0x001b) plen 2=0A    handle=
 42=0A> HCI Event: Command Status (0x0f) plen 4=0A    Read Remote Supported=
 Features (0x01|0x001b) status 0x00 ncmd 0=0A> HCI Event: Page Scan Repetit=
ion Mode Change (0x20) plen 7=0A    bdaddr 00:1C:CC:23:8F:68 mode 1=0A> HCI=
 Event: Max Slots Change (0x1b) plen 3=0A    handle 42 slots 5=0A> HCI Even=
t: Command Status (0x0f) plen 4=0A    Unknown (0x00|0x0000) status 0x00 ncm=
d 1=0A> HCI Event: Read Remote Supported Features (0x0b) plen 11=0A    stat=
us 0x00 handle 42=0A    Features: 0xbf 0xfe 0x8f 0xfe 0x98 0x19 0x00 0x80=
=0A< ACL data: handle 42 flags 0x02 dlen 10=0A    L2CAP(s): Info req: type =
2                          (***)=0A> HCI Event: Encrypt Change (0x08) plen =
4     (***)=0A    status 0x00 handle 42 encrypt 0x01=0A< ACL data: handle 4=
2 flags 0x02 dlen 12=0A    L2CAP(s): Connect req: psm 1 scid 0x0040     (**=
**)=0A> HCI Event: Number of Completed Packets (0x13) plen 5=0A    handle 4=
2 packets 1=0A> HCI Event: Number of Completed Packets (0x13) plen 5=0A    =
handle 42 packets 1=0A> ACL data: handle 42 flags 0x02 dlen 12=0A    L2CAP(=
s): Info rsp: type 2 result 1=0A      Not supported=0A< ACL data: handle 42=
 flags 0x02 dlen 12=0A    L2CAP(s): Connect req: psm 1 scid 0x0040   (****)=
=0A> ACL data: handle 42 flags 0x02 dlen 16=0A    L2CAP(s): Connect rsp: dc=
id 0x0040 scid 0x0040 result 0 status 0=0A      Connection successful      =
                         (****)=0A< ACL data: handle 42 flags 0x02 dlen 12=
=0A    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0=0A> ACL data: ha=
ndle 42 flags 0x02 dlen 16=0A    L2CAP(s): Config req: dcid 0x0040 flags 0x=
00 clen 4=0A      MTU 1024=0A< ACL data: handle 42 flags 0x02 dlen 18=0A   =
 L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4=0A      MTU 1=
024=0A> HCI Event: Number of Completed Packets (0x13) plen 5=0A    handle 4=
2 packets 1=0A> HCI Event: Number of Completed Packets (0x13) plen 5=0A    =
handle 42 packets 1=0A> HCI Event: Number of Completed Packets (0x13) plen =
5=0A    handle 42 packets 1=0A> ACL data: handle 42 flags 0x02 dlen 16=0A  =
  L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 4 status 0=0A      =
Connection refused - no resources available        (***)=0A> ACL data: hand=
le 42 flags 0x02 dlen 14=0A    L2CAP(s): Config rsp: scid 0x0040 flags 0x00=
 result 0 clen 0=0A      Success=0A< HCI Command: Remote Name Request (0x01=
|0x0019) plen 10=0A    bdaddr 00:1C:CC:23:8F:68 mode 2 clkoffset 0x0000=0A>=
 HCI Event: Command Status (0x0f) plen 4=0A    Remote Name Request (0x01|0x=
0019) status 0x00 ncmd 1=0A> HCI Event: Remote Name Req Complete (0x07) ple=
n 255=0A    status 0x00 bdaddr 00:1C:CC:23:8F:68 name 'bb 8300e'=0A< HCI Co=
mmand: Disconnect (0x01|0x0006) plen 3=0A    handle 42 reason 0x13=0A    Re=
ason: Remote User Terminated Connection=0A---------------------------------=
-----------------------------=0ARegards, Ed=0A=0A=0A      _________________=
_________________________________________________=0AThe new Internet Explor=
er=AE 8 - Faster, safer, easier.  Optimized for Yahoo!  Get it Now for Free=
! at http://downloads.yahoo.com/ca/internetexplorer/
