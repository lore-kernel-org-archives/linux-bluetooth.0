Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4434.195.146.105.162.1166011822.squirrel@mserv.smecno.net>
Date: Wed, 13 Dec 2006 13:10:22 +0100 (CET)
From: "Jan SVETLIK" <bluez-users-mailing-list@svetlik.net>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-users] bluez and billionton pcbtc1
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello all. A have too problem with PCMCIA Billiongton PCBTC1.

root@r51:# cardctl insert

Dec 10 09:34:45 localhost kernel: pccard: PCMCIA card inserted into slot 0
Dec 10 09:34:45 localhost kernel: pcmcia: registering new device pcmcia0.0
Dec 10 09:34:45 localhost cardmgr[4761]: socket 0: Serial or Modem
Dec 10 09:34:45 localhost kernel: ttyS2: detected caps 00000700 should be
00000100
Dec 10 09:34:45 localhost kernel: 0.0: ttyS2 at I/O 0x3100 (irq = 3) is a
16C950/954
Dec 10 09:34:46 localhost cardmgr[4761]: executing: './serial start ttyS2 2>&1'
Dec 10 09:34:46 localhost cardmgr[4761]: + udev active, devices will be
created in /dev/.static/dev/



root@r51:# cardctl info
PRODID_1="BT-PCMCIA"
PRODID_2="Card"
PRODID_3=""
PRODID_4=""
MANFID=0279,950b
FUNCID=2



root@r51:# dump_cis
Socket 0:
  dev_info
    NULL 0ns, 512b
  manfid 0x0279, 0x950b
  funcid serial_port [post]
  serial_interface
    uart 16550 [space/mark/odd/even] [5/6/7/8] [1/1.5/2]
  vers_1 7.1, "BT-PCMCIA", "Card", "", ""
  config base 0x00f8 mask 0x000f last_index 0x04
  cftable_entry 0x01 [default]
    [rdybsy]
    Vcc Vnom 3300mV
    io 0x03f8-0x0407 [lines=8] [8bit] [range]
    irq mask 0xffff [level] [shared]
  cftable_entry 0x02
    io 0x0000-0x7fff [lines=15] [8bit]



root@r51:# setserial /dev/ttyS2 baud_base 921600 (i tried 115200 and 6550 too)



root@r51:#  hciattach -l
any       0x0000,0x0000
ericsson  0x0000,0x0000
digi      0x0000,0x0000
texas     0x0000,0x0000
bcsp      0x0000,0x0000
xircom    0x0105,0x080a
csr       0x0000,0x0000
bboxes    0x0160,0x0002
swave     0x0000,0x0000
st        0x0000,0x0000
stlc2500  0x0000,0x0000
picocard  0x025e,0x1000
inventel  0x0000,0x0000
comone    0xffff,0x0101
tdk       0x0105,0x4254
socket    0x0104,0x0096
3com      0x0101,0x0041
bt2000c   0x022d,0x2000
zoom      0x0279,0x950b
sitecom   0x0279,0x950b
billionton0x0279,0x950b
bcm2035   0x0a5c,0x2035



root@r51:# hciattach ttyS2 billionton 115200  (i tried 115200 and 6550 too)
BCSP initialization timed out



root@r51:# hciattach ttyS2 bcsp 115200  (i tried 115200 and 6550 too)
BCSP initialization timed out



root@r51:# hciattach ttyS2 any 115200 (is OK, but dmesg :
Dec 10 09:46:02 localhost kernel: hci_cmd_task: hci0 command tx timeout)



root@r51:# hciconfig (after hciattach ttyS2 any 115200)
hci0:   Type: UART
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0



root@r51:/etc/pcmcia# hciconfig hci0 up
Can't init device hci0: Connection timed out (110)



root@r51:# /etc/init.d/bluetooth start
Starting bluetooth: hcid sdpd sdp_options rfcomm.

Dec 10 09:51:15 localhost hcid[7057]: Bluetooth HCI daemon
Dec 10 09:51:15 localhost hcid[7057]: Register path:/org/bluez fallback:1
Dec 10 09:51:15 localhost sdpd[7059]: Bluetooth SDP daemon



Bluetooth not running - what I do badly?

Thanks.
SJ


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
