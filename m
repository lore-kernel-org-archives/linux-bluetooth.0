Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <IAMHAF$6F3EDB7D5CA418646EBF9DB16603762A@libero.it>
Subject: Re: [Bluez-users] Piconet problems
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "jers@inwind.it" <jers@inwind.it>
To: "bluez-users" <bluez-users@lists.sourceforge.net>
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
Date: Thu, 20 Jan 2005 16:49:27 +0100

Hi Marcel,

At the moment, my dongles seem to work better. I tried agai=
n 
to create a piconet (1 master,2 slaves) but I got the same problem of=
 the early stage, i.e.,
I can only create the first connection and inter=
face bnep.
Unlike before, now hcidump works and we can see the packets.=0D
=

If you don't mind, I'll write you the run commands and the hcidump outp=
uts.

-------------------
On the master side:

# hciconfig hci0 up=0D
=

< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
> HC=
I Event: Command Complete (0x0e) plen 12
  01 03 10 00 FF FF 0B 00 00 00=
 00 00
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> HCI Event=
: Command Complete (0x0e) plen 11
  01 05 10 00 C0 00 40 08 00 08 00
< =
HCI Command: Read BD ADDR (0x04|0x0009) plen 0
> HCI Event: Command Comp=
lete (0x0e) plen 10
  01 09 10 00 AF 9D 01 E0 08 00
< HCI Command: Set =
Event Filter (0x03|0x0005) plen 1
  00
> HCI Event: Command Complete (0=
x0e) plen 4
  01 05 0C 00
< HCI Command: Write Page Timeout (0x03|0x001=
8) plen 2
  00 80
> HCI Event: Command Complete (0x0e) plen 4
  01 18 =
0C 00
< HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen =
2
  00 7D
> HCI Event: Command Complete (0x0e) plen 4
  01 16 0C 00=0D
=
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
  03
> HCI Event:=
 Command Complete (0x0e) plen 4
  01 1A 0C 00


  # pand --listen --m=
aster --role GN
  (No packets)


---------------------
  On the slav=
e1 side:

  # hciconfig hci0 up

< HCI Command: Read Local Supported =
Features (0x04|0x0003) plen 0
> HCI Event: Command Complete (0x0e) plen =
12
  01 03 10 00 FF FF 0B 00 00 00 00 00
< HCI Command: Read Buffer Siz=
e (0x04|0x0005) plen 0
> HCI Event: Command Complete (0x0e) plen 11
  0=
1 05 10 00 C0 00 40 08 00 08 00
< HCI Command: Read BD ADDR (0x04|0x0009=
) plen 0
> HCI Event: Command Complete (0x0e) plen 10
  01 09 10 00 86 =
9E 01 E0 08 00
< HCI Command: Set Event Filter (0x03|0x0005) plen 1
  0=
0
> HCI Event: Command Complete (0x0e) plen 4
  01 05 0C 00
< HCI Comm=
and: Write Page Timeout (0x03|0x0018) plen 2
  00 80
> HCI Event: Comma=
nd Complete (0x0e) plen 4
  01 18 0C 00
< HCI Command: Write Connection=
 Accept Timeout (0x03|0x0016) plen 2
  00 7D
> HCI Event: Command Compl=
ete (0x0e) plen 4
  01 16 0C 00
< HCI Command: Write Scan Enable (0x03|=
0x001a) plen 1
  03
> HCI Event: Command Complete (0x0e) plen 4
  01 1=
A 0C 00


# hcitool scan
Scanning ...
        00:08:E0:01:9D:AF     =
  BlueZ (0)

< HCI Command: Inquiry (0x01|0x0001) plen 5
  33 8B 9E 08=
 64
> HCI Event: Command Status (0x0f) plen 4
  00 01 01 04
> HCI Even=
t: Inquiry Result (0x02) plen 15
  01 AF 9D 01 E0 08 00 01 00 00 00 00 0=
0 07 0A
> HCI Event: Inquiry Complete (0x01) plen 1
  00
< HCI Command=
: Remote Name Request (0x01|0x0019) plen 10
  AF 9D 01 E0 08 00 02 00 00=
 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 19 04
> HCI Even=
t: Remote Name Req Complete (0x07) plen 255
  00 AF 9D 01 E0 08 00 42 6C=
 75 65 5A 20 28 30 29 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


# pand -c 00:08:E0:01:9=
D:AF

< HCI Command: Create Connection (0x01|0x0005) plen 13
  AF 9D 0=
1 E0 08 00 18 CC 00 00 00 00 01
> HCI Event: Command Status (0x0f) plen =
4
  00 01 05 04
> HCI Event: Connect Complete (0x03) plen 11
  00 2A 0=
0 AF 9D 01 E0 08 00 01 00
< ACL data: handle 0x002a flags 0x02 dlen 12=0D
=
    L2CAP(s): Connect req: psm 15 scid 0x0040
> HCI Event: Number of Com=
pleted Packets (0x13) plen 5
  01 2A 00 01 00
> HCI Event: Page Scan Re=
petition Mode Change (0x20) plen 7
  AF 9D 01 E0 08 00 01
> HCI Event: =
Max Slots Change (0x1b) plen 3
  2A 00 05
> ACL data: handle 0x002a fla=
gs 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 resul=
t 0 status 0
< ACL data: handle 0x002a flags 0x02 dlen 16
    L2CAP(s):=
 Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1691
> HCI Event: =
Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: =
handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 f=
lags 0x0000 result 0 clen 0
> ACL data: handle 0x002a flags 0x02 dlen 16=

    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1691=

< ACL data: handle 0x002a flags 0x02 dlen 14
    L2CAP(s): Config rsp:=
 scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x002a flag=
s 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 15]
      BNEP: Cont=
rol(0x01|0)
        Setup Req(0x01) size 0x02 dst 0x1116(NAP) src 0x1115=
(PANU)
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 0=
0 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A =
00 01 00
> ACL data: handle 0x002a flags 0x02 dlen 8
    L2CAP(d): cid =
0x0040 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Setup Rsp(0x0=
2) res 0x0000


# ifconfig bnep0 10.0.0.2

 ACL data: handle 0x002a =
flags 0x02 dlen 20
    L2CAP(d): cid 0x0040 len 16 [psm 15]
      BNEP:=
 Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x000c
         =
 ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
< ACL data: handle 0x002a flags 0=
x02 dlen 32
    L2CAP(d): cid 0x0040 len 28 [psm 15]
      BNEP: Contro=
l(0x01|0)
        Filter MultAddr Set(0x05) len 0x0018
          ff:ff:=
ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
          01:00:5e:00:00:01 - 01:00:5e:0=
0:00:01
< ACL data: handle 0x002a flags 0x02 dlen 32
    L2CAP(d): cid =
0x0040 len 28 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultA=
ddr Set(0x05) len 0x0018
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff=

          01:00:5e:00:00:01 - 01:00:5e:00:00:01
> HCI Event: Number of=
 Completed Packets (0x13) plen 5
  01 2A 00 01 00
> HCI Event: Number o=
f Completed Packets (0x13) plen 5
  01 2A 00 01 00
> HCI Event: Number =
of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle =
0x002a flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 15]
      =
BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> AC=
L data: handle 0x002a flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [=
psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) r=
es 0x0000
> ACL data: handle 0x002a flags 0x02 dlen 8
    L2CAP(d): cid=
 0x0040 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultA=
ddr Rsp(0x06) res 0x0000


-------------------
On the slave2 side:=0D
=

# hciconfig hci0 up

< HCI Command: Read Local Supported Features (0x=
04|0x0003) plen 0
> HCI Event: Command Complete (0x0e) plen 12
  01 03 =
10 00 FF FF 0B 00 00 00 00 00
< HCI Command: Read Buffer Size (0x04|0x00=
05) plen 0
> HCI Event: Command Complete (0x0e) plen 11
  01 05 10 00 C=
0 00 40 08 00 08 00
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0
> =
HCI Event: Command Complete (0x0e) plen 10
  01 09 10 00 C2 99 01 E0 08 =
00
< HCI Command: Set Event Filter (0x03|0x0005) plen 1
  00
> HCI Eve=
nt: Command Complete (0x0e) plen 4
  01 05 0C 00
< HCI Command: Write P=
age Timeout (0x03|0x0018) plen 2
  00 80
> HCI Event: Command Complete =
(0x0e) plen 4
  01 18 0C 00
< HCI Command: Write Connection Accept Time=
out (0x03|0x0016) plen 2
  00 7D
> HCI Event: Command Complete (0x0e) p=
len 4
  01 16 0C 00
< HCI Command: Write Scan Enable (0x03|0x001a) plen=
 1
  03
> HCI Event: Command Complete (0x0e) plen 4
  01 1A 0C 00
=0D
=

 # hcitool scan
Scanning ...
        00:08:E0:01:9D:AF       n/a
   =
     00:08:E0:01:9E:86       n/a


< HCI Command: Inquiry (0x01|0x0001=
) plen 5
  33 8B 9E 08 64
> HCI Event: Command Status (0x0f) plen 4
  =
00 01 01 04
> HCI Event: Inquiry Result (0x02) plen 15
  01 86 9E 01 E0=
 08 00 01 00 00 00 00 00 B2 6A
> HCI Event: Inquiry Result (0x02) plen 1=
5
  01 AF 9D 01 E0 08 00 01 00 00 00 00 00 BA 74
> HCI Event: Inquiry C=
omplete (0x01) plen 1
  00
< HCI Command: Remote Name Request (0x01|0x0=
019) plen 10
  AF 9D 01 E0 08 00 02 00 00 00
> HCI Event: Command Statu=
s (0x0f) plen 4
  00 01 19 04
> HCI Event: Remote Name Req Complete (0x=
07) plen 255
  04 AF 9D 01 E0 08 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0=
0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10=0D
=
  86 9E 01 E0 08 00 02 00 00 00
> HCI Event: Command Status (0x0f) plen =
4
  00 01 19 04
> HCI Event: Remote Name Req Complete (0x07) plen 255=0D
=
  04 86 9E 01 E0 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00=
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 =
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0D
=


# pand -c 00:08:E0:01:9D:AF

< HCI Command: Create Connection (0x01=
|0x0005) plen 13
  AF 9D 01 E0 08 00 18 CC 00 00 00 00 01
> HCI Event: =
Command Status (0x0f) plen 4
  00 01 05 04
> HCI Event: Connect Complet=
e (0x03) plen 11
  04 00 00 AF 9D 01 E0 08 00 01 00


# ifconfig bnep=
0 10.0.0.3
SIOCSIFADDR: No such device
bnep0: unknown interface: No suc=
h device



----------------------

I note the difference between p=
ackets sent after pand command in slave1 and slave2 but I don't know why.=

Have you any idea?
Thanks again for your patience.
Jers



> Hi J=
ers,
> 
> > I thank you for your time but, I'm sorry,  I can't display =
any packet. 
> >  
> > I changed my dongles. Their firmware is HCI 16.1=
4: 
> >  
> > hci0:   Type: USB 
> >         BD Address: 00:08:E0:01:9=
E:86 ACL MTU: 192:8 SCO MTU: 64:8 
> >         UP RUNNING PSCAN ISCAN =0D
=
> >         RX bytes:2508 acl:0 sco:0 events:60 errors:0 
> >         TX=
 bytes:465 acl:0 sco:0 commands:47 errors:0 
> >         Features: 0xff =
0xff 0x0b 0x00 0x00 0x00 0x00 0x00 
> >         Packet type: DM1 DM3 DM5=
 DH1 DH3 DH5 HV1 HV2 HV3 
> >         Link policy: RSWITCH HOLD SNIFF PA=
RK 
> >         Link mode: SLAVE ACCEPT 
> >         Name: 'pcB' 
> > =
        Class: 0x000000 
> >         Service Classes: Unspecified 
> > =
        Device Class: Miscellaneous, 
> >         HCI Ver: 1.1 (0x1) HCI=
 Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c 
> >         Manufactur=
er: Cambridge Silicon Radio (10) 
> >  
> > I installed linux again (Ma=
ndrake 9.1, kernel 2.4.21) and the upgrated BlueZ packages in accordance =
with readme 
> > files of each packages. I tried to create a simple conn=
ection. 
> >  
> > On the master side, I run: 
> >  
> > modprobe bne=
p 
> > modprobe l2cap 
> > hciconfig hci0 up 
> > pand --listen --role=
 GN 
> >  
> > On the slave side, I run; 
> >  
> > modprobe bnep =0D
=
> > modprobe l2cap 
> > hciconfig hci0 up 
> > pand -c <master_addr> =0D
=
> >  
> > At first, "hcidump -x" dispayed packets sent by the pand comma=
nd. Trying several times, it showed L2CAP and in 
> > only one case I sh=
owed BNEP. However, no connection was create. 
> > Then, maybe after a r=
eboot or a logout, hcidump shows again that pand does not send any packet=
,. 
> > I can't obtain again the same situation and I don't realize why.=

> 
> show us the hcidump output and leave it to us to interpret it. An=
d btw
> what about using a 2.6.10 kernel? I can't tell you anything abou=
t any
> vendor kernel.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -=
------------------------------------------------------
> This SF.Net ema=
il is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open=
 source databases. Create drag-&-drop reports. Save time
> by over 75%! =
Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a F=
REE copy at http://www.intelliview.com/go/osdn_nl
> ____________________=
___________________________
> Bluez-users mailing list
> Bluez-users@li=
sts.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez=
-users
> =0A=0A=0A=0A___________________________________________________=
_________=0A6X velocizzare la tua navigazione a 56k? 6X Web Accelerator d=
i Libero!=0AScaricalo su INTERNET GRATIS 6X http://www.libero.it=0A



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
