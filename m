Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040223213658.GA1453@encephalon.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: klaus@encephalon.dk (Klaus Holst)
Subject: [Bluez-users] dund never activates pppd
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
Date: Mon, 23 Feb 2004 22:36:58 +0100

I have just installed bluez with partial success. I am using a belkin usb adaptor
and linux 2.4.25 with the latest bluez installed. The adaptor is recognized and 
I am able to connect a Pocket PC (WM2003) to the linux-machine using "Network Access Service". 
However pppd is never started and I am not able to transmit any packets from the PPC.

[syslog message when 'hotplugging' the device]:
Feb 23 18:51:13 mini kernel: usb.c: USB disconnect on device 00:10.0-2 address 3
Feb 23 18:51:15 mini kernel: hub.c: new USB device 00:10.0-2, assigned address 4
Feb 23 18:51:15 mini kernel: usb.c: USB device 4 (vend/prod 0xa5c/0x2033) is not claimed by any active driver.
Feb 23 18:51:19 mini bluefw[5776]: Loading firmware to usb device 0a5c:2033
Feb 23 18:51:19 mini bluefw[5776]: FW loaded

Then I run
/usr/bin/pand --listen --role NAP
/usr/bin/dund --listen --msdun call dun

Starting pand,dund etc:
Feb 23 18:51:28 mini hcid[5972]: HCI daemon ver 2.4 started
Feb 23 18:51:28 mini hcid[5972]: Starting security manager 0
Feb 23 18:51:28 mini bluetooth: hcid startup succeeded
Feb 23 18:51:28 mini sdpd[5978]: sdpd v1.5 started
Feb 23 18:51:28 mini bluetooth: sdpd startup succeeded
Feb 23 18:51:34 mini pand[5986]: PAN daemon ver 1.1
Feb 23 18:51:34 mini pan: pand startup succeeded
Feb 23 18:51:34 mini dund[5990]: DUN daemon ver 1.1
Feb 23 18:51:34 mini pan: dund startup succeeded
Feb 23 18:52:13 mini hcid[5972]: link_key_request (sba=00:03:C9:2E:6C:F6, dba=00:04:3E:A2:2D:C9)
Feb 23 18:52:16 mini pand[5997]: New connection from 00:04:3E:A2:2D:C9 bnep0

And pppd is never started as I suppose it should?



My current setup:
-----------------------------------------------
/etc/ppp/peers/dun:
115200
192.168.1.240:192.168.1.241
local
ms-dns 192.168.1.1
noauth
debug
passive
silent


-----------------------------------------------
/etc/bluetooth/rfcomm:
rfcomm0 {
        bind yes;
        device 00:04:3E:A2:2D:C9;
        channel 1;
        comment "PPC DEVICE";
}

-----------------------------------------------
/etc/bluetooth/hcid.conf:
options {
        autoinit yes;
        security auto;
        pairing multi;
        pin_helper /bin/bluepin;
}

device {
        name "MINI (linux)";
        class 0x100;
        iscan enable; pscan enable;
        lm accept,master;
        lp hold,sniff,park;
        auth enable;
        encrypt enable;
}
-----------------------------------------------



Best regards
Klaus Holst


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
