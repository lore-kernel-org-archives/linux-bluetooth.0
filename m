Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 22 Aug 2006 18:15:32 +0200
From: The Peach <smartart@tiscali.it>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060822181532.6fea4851@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] rfcomm hell
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

Hi all, this is my first time posting to this ml.

Since yesterday I've got a problem with bluetooth and in particular with rfcomm connection to a bluetooth interface: I hope this mailing list is ok for this to be posted.

Objective: connect to the mobile (a nokia 6680) and to the GPS reciver
The system runs a gentoo patched kernel version 2.6.17-r4 with bluez-libs 2.25 and bluez-utils 2.25-r1

The bluetooth dongle works well (in my opinion):
# hcitool scan
Scanning ...
        00:12:62:A8:12:FE       Miditree

# l2ping 00:12:62:A8:12:FE
Ping: 00:12:62:A8:12:FE from 00:0A:3A:63:21:B7 (data size 44) ...
0 bytes from 00:12:62:A8:12:FE id 0 time 121.81ms
0 bytes from 00:12:62:A8:12:FE id 1 time 12.15ms
0 bytes from 00:12:62:A8:12:FE id 2 time 13.08ms
3 sent, 3 received, 0% loss

but:
# rfcomm bind 0 00:12:62:A8:12:FE
# rfcomm show all
rfcomm0: 00:12:62:A8:12:FE channel 1 clean
# rfcomm connect 0 00:12:62:A8:12:FE
Can't create RFCOMM TTY: Address already in use
# rfcomm release all
# rfcomm connect 1 00:12:62:A8:12:FE
Can't open RFCOMM device: No such file or directory

some configuration files:

	/etc/conf.d/bluetooth
[code]
HCID_ENABLE=true
HCID_CONFIG="/etc/bluetooth/hcid.conf"
SDPD_ENABLE=true
HIDD_ENABLE=false
HIDD_OPTIONS=""
HID2HCI_ENABLE=false
RFCOMM_ENABLE=true
RFCOMM_CONFIG="/etc/bluetooth/rfcomm.conf"
DUND_ENABLE=false
DUND_OPTIONS="--listen --persist"
PAND_ENABLE=false
PAND_OPTIONS="--listen --role NAP"
[/code]

	/etc/bluetooth/hcid.conf
[code]
options {
        autoinit yes;
        security auto;
        pairing multi;
        pin_helper /usr/bin/bluepin;
}
device {
        name "%h (%d)";
        class 0x3e0100;
        iscan enable; pscan enable;
        lm accept;
        lp rswitch,hold,sniff,park;
        #auth enable;
        #encrypt enable;
}
[/code]

I've tried also to mknod the device but there's nothing to do. when I launch rfcomm it will be deleted and it ends with a "No such file or directory".

Any hint??? This thing is driving me mad!!!

-- 
Matteo 'Peach' Pescarin

ICQ UIN = 71110111
Jabber ID = smartart@unstable.nl
Web Site = http://www.smartart.it
GeCHI = http://www.gechi.it

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
