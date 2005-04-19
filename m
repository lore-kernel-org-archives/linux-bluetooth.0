Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth dongle fails to dial in via AVM AP-X
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <E1DNs9Q-00043x-00@mrelayng.kundenserver.de>
References: <E1DNs9Q-00043x-00@mrelayng.kundenserver.de>
Content-Type: text/plain
Message-Id: <1113915398.16233.179.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 19 Apr 2005 14:56:38 +0200

Hi Jens-Uwe,

> On my Fujitsu Siemens Lifebook running Debian Sarge, i cant suceed to dial 
> and connect with my "AVM APX ISDN Bluetooth Modem" via bluetooth-dongle 
> (Mitsumi).
> So far, I have kernel, hcid, pin and pinhelper set up and running. The dongle 
> is running and i can perform a "hcitool scan" to list up the AP-X.
> "rfcomm connect 0" succeeds. But when i try to dial in with pon or wvdial, 
> there is some problem with pppd or rfcomm to connect.
> The Mitsumi-Dongle seems to work.
> 
> lifebook:/home/jens# tail -f /var/log/messages
> Apr 18 14:32:12 localhost kernel: Bluetooth: Core ver 2.6
> Apr 18 14:32:12 localhost kernel: NET: Registered protocol family 31
> Apr 18 14:32:12 localhost kernel: Bluetooth: HCI device and connection 
> manager initialized
> Apr 18 14:32:12 localhost kernel: Bluetooth: HCI socket layer initialized
> Apr 18 14:32:12 localhost kernel: Bluetooth: L2CAP ver 2.3
> Apr 18 14:32:12 localhost kernel: Bluetooth: L2CAP socket layer initialized
> Apr 18 14:32:13 localhost Xprt_64: No matching visual for __GLcontextMode 
> with visual class = 0 (32775), nplanes = 8
> Apr 18 14:32:13 localhost kernel: Bluetooth: RFCOMM ver 1.3
> Apr 18 14:32:13 localhost kernel: Bluetooth: RFCOMM socket layer initialized
> Apr 18 14:32:13 localhost kernel: Bluetooth: RFCOMM TTY layer initialized
> Apr 18 14:34:21 localhost kernel: usb 1-1: new full speed USB device using 
> address 3
> Apr 18 14:34:25 localhost usb.agent[2532]:      hci_usb: loaded successfully
> Apr 18 14:34:25 localhost usb.agent[2551]:      hci_usb: loaded successfully
> Apr 18 14:34:25 localhost kernel: Bluetooth: HCI USB driver ver 2.7
> Apr 18 14:34:25 localhost kernel: usbcore: registered new driver hci_usb
> Apr 18 14:34:26 localhost usb.agent[2541]:      hci_usb: loaded successfully
> 
> 
> lifebook:/home/jens# rfcomm connect 0
> Connected /dev/rfcomm0 to 00:04:0E:86:A6:D7 on channel 1
> Press CTRL-C for hangup
> 
> pon fails!
> 
> Apr 17 14:38:19 localhost pppd[2733]: pppd 2.4.2 started by root, uid 0
> Apr 17 14:38:20 localhost chat[2734]: abort on (BUSY)
> Apr 17 14:38:20 localhost chat[2734]: abort on (NO CARRIApr 17 14:38:20 
> localhost chat[2734]: abort on (VOICE)
> Apr 17 14:38:20 localhost chat[2734]: abort on (NO DIALTONE)
> Apr 17 14:38:20 localhost chat[2734]: abort on (NO DIAL TONE)
> Apr 17 14:38:20 localhost chat[2734]: abort on (NO ANSWER)
> Apr 17 14:38:20 localhost chat[2734]: abort on (DELAYED)
> Apr 17 14:38:20 localhost chat[2734]: send (ATZ^M)
> Apr 17 14:38:20 localhost chat[2734]: expect (OK)
> Apr 17 14:38:20 localhost chat[2734]: ATZ^M^M
> Apr 17 14:38:20 localhost chat[2734]: OK
> Apr 17 14:38:20 localhost chat[2734]:  -- got it 
> Apr 17 14:38:20 localhost chat[2734]: send (ATDT019102345^M)
> Apr 17 14:38:21 localhost chat[2734]: expect (CONNECT)
> Apr 17 14:38:21 localhost chat[2734]: ^M
> Apr 17 14:38:23 localhost chat[2734]: ATDT019102345^M^M
> Apr 17 14:38:23 localhost chat[2734]: CONNECT
> Apr 17 14:38:23 localhost chat[2734]:  -- got it 
> Apr 17 14:38:23 localhost chat[2734]: send (\d)
> Apr 17 14:38:24 localhost pppd[2733]: Serial connection established.
> Apr 17 14:38:24 localhost pppd[2733]: Using interface ppp0
> Apr 17 14:38:24 localhost pppd[2733]: Connect: ppp0 <--> /dev/rfcomm0
> Apr 17 14:38:55 localhost pppd[2733]: LCP: timeout sending Config-Requests 
> Apr 17 14:38:55 localhost pppd[2733]: Connection terminated.
> 
> wvdial fails !
> 
> lifebook:/etc/bluetooth# wvdial
> --> WvDial: Internet dialer version 1.54.0
> --> Cannot open /dev/rfcomm0: Cannot get information for serial port.
> --> Cannot open /dev/rfcomm0: Cannot get information for serial port.
> --> Cannot open /dev/rfcomm0: Cannot get information for serial port.
> 
> Apr 17 14:38:56 localhost pppd[2733]: Exit.
> 
> Seems to be that i forgot to install / set up something?!

I never really got the dialup via RFCOMM working correctly with the AVM
products. You need to tweak the PPP options for it. However all of their
devices support CIP and so you better user CAPI over Bluetooth for your
dialin.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
