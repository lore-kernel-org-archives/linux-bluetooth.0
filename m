Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Thomas Heinz <thomasheinz@gmx.net>
To: bluez-users@lists.sourceforge.net
Date: Wed, 1 Aug 2007 23:35:27 +0200
MIME-Version: 1.0
Message-Id: <200708012335.28600.thomasheinz@gmx.net>
Subject: [Bluez-users] l2ping: Permission denied
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi

I am unable to ping my bluetooth device (Logitech Mobile Pro).

Here some information:

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0C:55:FF:8C:E4 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:3476 acl:0 sco:0 events:164 errors:0
        TX bytes:2774 acl:0 sco:0 commands:124 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object Transfer, 
Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 
0x33c
        Manufacturer: Cambridge Silicon Radio (10)

Switching the headset into pairing mode ...
# hcitool scan
Scanning ...
        00:0D:44:5D:1A:9B       Logitech HS05  V02

# hcitool inq
Inquiring ...
        00:0D:44:5D:1A:9B       clock offset: 0x1e85    class: 0x200404

# strace -f l2ping 00:0D:44:5D:1A:9B
[...]
socket(PF_BLUETOOTH, SOCK_RAW, 0)       = 3
bind(3, {sa_family=AF_BLUETOOTH, sa_data="\0\0\0\0\0\0\0\0\0\0\0\0\0\0"}, 
10) = 0
connect(3, {sa_family=AF_BLUETOOTH, 
sa_data="\0\0\233\32]D\r\0\0\0\0\0\0\0"}, 10
) = -1 EACCES (Permission denied)
dup(2)                                  = 4
fcntl64(4, F_GETFL)                     = 0x2 (flags O_RDWR)
fstat64(4, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 4), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0xb7fb4000
_llseek(4, 0, 0xbfce9730, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
write(4, "Can\'t connect: Permission denied"..., 33Can't connect: 
Permission denied
) = 33
close(4)                                = 0
munmap(0xb7fb4000, 4096)                = 0
close(3)                                = 0
exit_group(1)                           = ?
Process 28321 detached

-> connect to bluetooth socket fails.

# hcidump -x
< HCI Command: Create Connection (0x01|0x0005) plen 13
  9B 1A 5D 44 0D 00 18 CC 02 00 00 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
> HCI Event: PIN Code Request (0x16) plen 6
  9B 1A 5D 44 0D 00
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
  9B 1A 5D 44 0D 00
> HCI Event: Command Complete (0x0e) plen 10
  01 0E 04 00 9B 1A 5D 44 0D 00
> HCI Event: Connect Complete (0x03) plen 11
  18 29 00 9B 1A 5D 44 0D 00 01 00

My hcid.conf
options {
        autoinit yes;
        security user;
        pairing multi;
}
device {
        name "BlueZ (%d)";
        class 0x3e0100;
        iscan enable; pscan enable;
        lm accept;
        lp rswitch,hold,sniff,park;
}


Version information: bluez-hcidump-1.37, bluez-libs-3.12, bluez-utils-3.12

Any idea what could be the problem?

Thanks for your help.


Best wishes 

Thomas

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
