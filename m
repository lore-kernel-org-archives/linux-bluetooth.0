Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051030220020.16175.qmail@web54104.mail.yahoo.com>
From: Martin Gerken <m_gerken@yahoo.com>
Subject: Ant:  Re: [Bluez-users] ISSC-stick not working when plugged-in at boot-time
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1130676365.5396.71.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Sun, 30 Oct 2005 23:00:20 +0100 (CET)


--- Marcel Holtmann <marcel@holtmann.org> schrieb:

> > I have Debian Sarge 2.6.8-2-386 and bluez-utils
> 2.15-1.1
> > and a cheapo-BT-stick with this chip:
> > ID 1131:1001 Integrated System Solution Corp.
> > 
> > When it is plugged-in at boot-time it does not work. I
> have
> > to manually re-plug it, then everything is fine.
> > 
> > Booting with stick plugged-in results in LSMOD:
> > Module                  Size  Used by
> > uhci_hcd               29328  0
> > usbcore               104164  3 uhci_hcd
> > rfcomm                 34460  4
> > l2cap                  23172  5 rfcomm
> > bluetooth              44036  4 rfcomm,l2cap
> > 
> > and LSUSB:
> > Bus 002 Device 001: ID 0000:0000
> > Bus 001 Device 001: ID 0000:0000
> > 
> > 
> > After plug-out and plug-in of stick (then it works)
> gives
> > LSMOD:
> > Module                  Size  Used by
> > hci_usb                12928  2
> > uhci_hcd               29328  0
> > usbcore               104164  4 hci_usb,uhci_hcd
> > rfcomm                 34460  4
> > l2cap                  23172  5 rfcomm
> > bluetooth              44036  7 hci_usb,rfcomm,l2cap
> > 
> > and LSUSB:
> > Bus 002 Device 001: ID 0000:0000
> > Bus 001 Device 005: ID 1131:1001 Integrated System
> Solution
> > Corp.
> > Bus 001 Device 001: ID 0000:0000
> > 
> > How can I solve this problem?
> 
> install a 2.6.14 kernel and the latest bluez-utils.

It seems more like a USB-related problem. Installung the
latest BLUEZ did not help. It could be an ACPI-problem...
"dmesg" says
usb 1-2: new full speed USB device using address 2
usb 1-2: device not accepting address 2, error -71

Martin


	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
