Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40C73731.50702@ticino.com>
From: Zack <zack@ticino.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Connection problem
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
Date: Wed, 09 Jun 2004 12:13:37 -0400

Hi,
I have problems using hcitool cc.
All the previous steps (hcid, hciattach, hciconfig and hcitool inq) work 
well but when i try to use hcitool cc i get a: Can't create connection: 
Connection timed out.
Any ideas?

Output:

root@nenna:~# hcid

root@nenna:~# hciattach ttyS0 ericsson 57600 flow

root@nenna:~# hciconfig -a
hci0:   Type: UART
        BD Address: 11:11:11:50:11:12 ACL MTU: 672:10  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:90 acl:0 sco:0 events:11 errors:0
        TX bytes:298 acl:0 sco:0 commands:10 errors:0
        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DH1 HV1
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Bluez: nenna-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0xb LMP Ver: 1.1 (0x1) LMP Subver: 0x300
        Manufacturer: Ericsson Technology Licensing (0)

root@nenna:~# hcitool inq
Inquiring ...
        11:11:11:50:11:11       clock offset: 0x0c9d    class: 0x000100

root@nenna:~# hcitool cc --role=m 11:11:11:50:11:11
Can't create connection: Connection timed out
root@nenna:~# hcitool cc --role=m 11:11:11:50:11:11
Can't create connection: Input/output error

root@nenna:~# cat /etc/bluetooth/hcid.conf
#
# HCI daemon configuration file.
#
# $Id: hcid.conf,v 1.3 2002/07/18 18:12:46 maxk Exp $
#

# HCId options
options {
        # Automatically initialize new devices
        autoinit yes;

        # Security Manager mode
        #   none - Security manager disabled
        #   auto - Use local PIN for incoming connections
        #   user - Always ask user for a PIN
        #
        security auto;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired devices
        #   once  - Pair once and deny successive attempts
        pairing multi;

        # PIN helper
        pin_helper /usr/bin/bluez-pin;
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "Bluez: %h-%d";

        # Local device class
        class 0x100;

        # Default packet type
        #pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        iscan enable; pscan enable;

        # Default link mode
        #   none   - no specific policy
        #   accept - always accept incoming connections
        #   master - become master on incoming connections,
        #            deny role switch on outgoing connections
        #
        #lm accept,master;
        #
        lm accept;

        # Default link policy
        #   none    - no specific policy
        #   rswitch - allow role switch
        #   hold    - allow hold mode
        #   sniff   - allow sniff mode
        #   park    - allow park mode
        #
        #lp hold,sniff;
        #
        lp hold,sniff,park;

        # Authentication and Encryption
        #auth enable;
        #encrypt enable;
}

root@nenna:~# cat /etc/modules.conf
.....
### update-modules: start processing /etc/modutils/bluez
# BlueZ modules
alias net-pf-31 bluez
alias bt-proto-0 l2cap
alias bt-proto-2 sco
alias bt-proto-3 rfcomm
alias bt-proto-4 bnep
alias bt-proto-5 cmtp
alias tty-ldisc-15 hci_uart
alias char-major-10-250 hci_vhci

### update-modules: end processing /etc/modutils/bluez
......

root@nenna:~# lsmod
Module                  Size  Used by    Not tainted
rfcomm                 30816   0  (autoclean)
l2cap                  17452   1  (autoclean) [rfcomm]
hci_uart               11308   2  (autoclean)
bluez                  31044   3  (autoclean) [rfcomm l2cap hci_uart]
ntfs                   50944   0  (unused)
autofs4                 8756   1
af_packet              13544   0
nls_iso8859-1           2844   0  (unused)
nls_cp437               4348   0  (unused)
agpgart                42660   0  (unused)
trident                29236   1
ac97_codec             11884   0  [trident]
soundcore               3428   2  [trident]
pcigame                 1448   0  [trident]
gameport                1388   0  [pcigame]
natsemi                17344   1
crc32                   2816   0  [natsemi]
orinoco_pci             3300   0
orinoco                35920   0  [orinoco_pci]
hermes                  5056   0  [orinoco_pci orinoco]
serial                 52068   1
mousedev                3832   1
hid                    22372   0  (unused)
input                   3168   0  [mousedev hid]
sbp2                   16588   0  (unused)
usb-storage            61952   0  (unused)
ataraid                 6404   0  (unused)
ohci1394               22888   0  (unused)
ieee1394              183300   0  [sbp2 ohci1394]
usb-ohci               18088   0  (unused)
usbcore                57824   1  [hid usb-storage usb-ohci]
ds                      6536   1
yenta_socket            9504   1
pcmcia_core            39840   0  [ds yenta_socket]
thermal                 6532   0  (unused)
processor               8976   0  [thermal]
fan                     1568   0  (unused)
button                  2508   0  (unused)
battery                 5888   0  (unused)
ac                      1792   0  (unused)
ide-cd                 28704   0
ide-scsi                9040   0
rtc                     7004   0  (autoclean)
ext3                   64452   1  (autoclean)
jbd                    46516   1  (autoclean) [ext3]



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
