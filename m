Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40F3BD15.30908@fel.cvut.cz>
From: Jan Sykora <Jan.Sykora@fel.cvut.cz>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
CC: jan.sykora@fel.cvut.cz
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Unknown HCI packet type / 3CRWB6096B
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
Date: Tue, 13 Jul 2004 12:44:37 +0200

Hello

Could anybody please give me some hints what is wrong.

I am able to establish kppp session to siemens s55 mobile and the 
connection works OK, however after a while I get messages in 
/var/log/messages

Jul 12 23:59:26 merlin kernel: h4_check_data_len: Data length is too large
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 00
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 6e
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 20
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 63
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 6c
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 61
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 73
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 73
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 3d
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 22
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 63
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 61
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 73
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 22
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 3e
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 31
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 32
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 2e
Jul 12 23:59:26 merlin kernel: l2cap_recv_acldata: Unexpected start 
frame (len 9)
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 45
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 00
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 05
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type dc
Jul 12 23:59:26 merlin kernel: h4_check_data_len: Data length is too large
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 11
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 00
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 5d
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 40
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 00
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 74
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 06
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 37
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 7d
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 33
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 50
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type bc
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type a2
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type c3
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type ac
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 18
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 27
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type f4
Jul 12 23:59:26 merlin kernel: h4_recv: Unknown HCI packet type 00
Jul 12 23:59:26 merlin kernel: l2cap_recv_acldata: Fragment is too large 
(len 17, expect 16)
Jul 12 23:59:26 merlin kernel: l2cap_recv_acldata: Unexpected 
continuation frame (len 17)
Jul 12 23:59:26 merlin last message repeated 8 times
Jul 12 23:59:26 merlin kernel: l2cap_recv_acldata: Unexpected 
continuation frame (len 15)
Jul 12 23:59:31 merlin kernel: h4_check_data_len: Data length is too large
.......


I have the following setup:

redhat EL3.0 linux
3com pc card 3CRWB6096B (version 3!!!)
bluez-libs-2.8-1.i386.rpm  bluez-utils-2.8-1.i386.rpm

hciattach /dev/ttyS17 csr 115200
/etc/bluetooth/rfcomm.conf
rfcomm0 {
        # Automatically bind the device at startup
        bind yes;
        # Bluetooth address of the device
        device 00:01:E3:15:0B:0C;
        # RFCOMM channel for the connection
        channel 1;
        # Description of the connection
        comment "merlin BT";
}
hcid.conf:
options {
        autoinit yes;
        security auto;
        pairing multi;
        pin_helper /bin/bluepin;
}
device {
        name "merlin";
        class 0x100;
        # Default packet type
        #pkt_type DH1,DM1,HV1;
        iscan enable; pscan enable;
        lm accept;
       lp rswitch,hold,sniff,park;
}

------

thank you

Jan Sykora

Jan.Sykora@fel.cvut.cz





-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
