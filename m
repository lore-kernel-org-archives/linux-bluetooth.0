Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Thomas Chiverton <thomas.chiverton@bluefinger.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200402111236.34361.thomas.chiverton@bluefinger.com>
Subject: [Bluez-users] Help id'ing USB bluetooth adapter
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
Date: Wed, 11 Feb 2004 12:36:34 +0000

Where do I start trying to figure out what chipset this 'ere adapter is, and 
so if it is supported ?
If it isn't, I might just take a crack at it or post it to someone who can :-)

syslog reports:
Feb 11 12:07:11 charles-compaq kernel: hub.c: new USB device 00:1f.2-1, 
assigned address 9
Feb 11 12:07:11 charles-compaq /sbin/hotplug: no 
runnable /etc/hotplug/bluetooth.agent is installed
Feb 11 12:07:14 charles-compaq /etc/hotplug/usb.agent: Setup hci_usb for USB 
product a12/1/525
Feb 11 12:07:14 charles-compaq kernel: usb-uhci.c: ENXIO 80000980, flags 0, 
urb dfa58700, burb dfa58a00
Feb 11 12:07:14 charles-compaq kernel: usb-uhci.c: ENXIO 80000980, flags 0, 
urb dc7b0300, burb dfa58a00
Feb 11 12:07:14 charles-compaq kernel: usb-uhci.c: ENXIO 80000980, flags 0, 
urb dfa58a00, burb dc7b0300
Feb 11 12:07:14 charles-compaq kernel: usb-uhci.c: ENXIO 80000980, flags 0, 
urb dfa58a00, burb dc7b0300
Feb 11 12:07:14 charles-compaq kernel: usb-uhci.c: ENXIO 80000980, flags 0, 
urb dc7b0300, burb dfa58a00
Feb 11 12:07:14 charles-compaq /etc/hotplug/usb.agent: ... no modules for USB 
product a12/1/525
Feb 11 12:07:14 charles-compaq kernel: usb-uhci.c: ENXIO 80000980, flags 0, 
urb dfa58a00, burb dfa58280
Feb 11 12:07:14 charles-compaq /etc/hotplug/usb.agent: ... no modules for USB 
product a12/1/525

Windows (where, of course, it runs fine :-) reports it as 
"Cambridge Silicon Radio, Firmware Revision 525, HCI 1.1 020D, LMP 1.1 020D"
It is using drivers by WidComm, if that helps.

I understand from the website that CSR are a popular chip set provider, so I'm 
hoping it is supported really :-)

-- 
Tom Chiverton 
Advanced ColdFusion Programmer

Tel: +44(0)1749 834997
email: tom.chiverton@bluefinger.com
BlueFinger Limited
Underwood Business Park
Wookey Hole Road, WELLS. BA5 1AF
Tel: +44 (0)1749 834900
Fax: +44 (0)1749 834901
web: www.bluefinger.com
Company Reg No: 4209395 Registered Office: 2 Temple Back East, Temple
Quay, BRISTOL. BS1 6EG.
*** This E-mail contains confidential information for the addressee
only. If you are not the intended recipient, please notify us
immediately. You should not use, disclose, distribute or copy this
communication if received in error. No binding contract will result from
this e-mail until such time as a written document is signed on behalf of
the company. BlueFinger Limited cannot accept responsibility for the
completeness or accuracy of this message as it has been transmitted over
public networks.***


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
