Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Przemek <aquamala@o2.pl>
To: bluez-users <bluez-users@lists.sourceforge.net>
Message-ID: <20040522121543.GA1546@reynevan>
Reply-To: aquamala@o2.pl
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Subject: [Bluez-users] krfcommd or kernel bug?
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 22 May 2004 14:15:43 +0200

Hi!

I have two machines: first - win2k with CSR USB dongle (BlueTake) and second - linux
with Ericsson's ROK101008 starter kit.
I'm trying to connect to linux bluetooth-serial-port from win2k.
Just after receivig SABM frame I got such info:

May 18 05:08:31 localhost kernel: ------------[ cut here
]------------
May 18 05:08:31 localhost kernel: kernel BUG at
include/linux/module.h:302!
May 18 05:08:31 localhost kernel: invalid operand: 0000 [#1]
May 18 05:08:31 localhost kernel: CPU:    0
May 18 05:08:31 localhost kernel: EIP:    0060:[<c285a913>]    Not
tainted
May 18 05:08:31 localhost kernel: EFLAGS: 00010246
May 18 05:08:31 localhost kernel: EIP is at
rfcomm_session_add+0xb3/0xc0 [rfcomm]
May 18 05:08:31 localhost kernel: eax: 00000000   ebx: c11c0e20
ecx: 00000000   edx: c2862060
May 18 05:08:31 localhost kernel: esi: 00000002   edi: c11c0e4c
ebp: 00000000   esp: c1299f8c
May 18 05:08:31 localhost kernel: ds: 007b   es: 007b   ss: 0068
May 18 05:08:31 localhost kernel: Process krfcommd (pid: 1127,
threadinfo=c1298000 task=c1d20660)
May 18 05:08:31 localhost kernel: Stack: c1fbb340 c283eec0 c1fbb340
c1d614e0 c283eec0 c285c62f c1d614e0 00000002
May 18 05:08:31 localhost kernel:        c1fbb340 04000000 c129ffff
c0116161 c1298000 c2861d70 c1298000 00000000
May 18 05:08:31 localhost kernel:        00000000 00000000 c285c83d
c1299fdc 00000000 00000000 0000007b ffffffff
May 18 05:08:31 localhost kernel: Call Trace:
May 18 05:08:31 localhost kernel:  [<c285c62f>]
rfcomm_worker+0x48f/0x4e0 [rfcomm]
May 18 05:08:31 localhost kernel:  [<c0116161>]
set_user_nice+0x61/0x120
May 18 05:08:31 localhost kernel:  [<c285c83d>] rfcomm_run+0x5d/0x80
[rfcomm]
May 18 05:08:31 localhost kernel:  [<c285c7e0>] rfcomm_run+0x0/0x80
[rfcomm]
May 18 05:08:31 localhost kernel:  [<c0106f81>]
kernel_thread_helper+0x5/0x24
May 18 05:08:32 localhost kernel:
May 18 05:08:32 localhost kernel: Code: 0f 0b 2e 01 37 f7 85 c2 eb
ca 8d 76 00 56 53 8b 5c 24 0c 8b

That is what I'm using:

$uname -a
Linux localhost.localdomain 2.6.2 #16 Tue May 18 02:08:00 CEST 2004
i586 i586 i386 GNU/Linux

$rpm -qa | grep bluez
bluez-utils-2.7-1
bluez-libs-2.7-1
bluez-hcidump-1.8-1

$lsmod
Module                  Size  Used by
rfcomm                 33144  0 
l2cap                  20416  3 rfcomm
hci_uart               15632  0 
bluetooth              40996  3 rfcomm,l2cap,hci_uart
8250                   15456  0 
serial_core            18720  1 8250

$hciattach ttyS0 57600 ericsson flow

#hciconfig hci0 up
#hciconfig -a
# hciconfig -a hci1   
hci1:   Type: UART
        BD Address: 00:80:37:16:30:8B ACL MTU: 672:10  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN 
        RX bytes:394 acl:0 sco:0 events:16 errors:2
        TX bytes:330 acl:0 sco:0 commands:17 errors:0
        Features: 0x07 0xea 0x31 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0xb LMP Ver: 1.1 (0x1) LMP
Subver: 0x300
        Manufacturer: Ericsson Mobile Comunications (0)

hcid and sdpd are running.

If you want me to send a dump from this fatal connection just tell
me.

Best Regards, 
aquamala


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
