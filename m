Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Dominik Blystak <Dominik.Blystak@pro-open.de>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1091009362.2389.16.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] mRouter and sx1
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
Date: Wed, 28 Jul 2004 12:09:22 +0200

Hello all, 


I got a Siemens sx1 phone, which uses some kind of mRouter software
(windows). After browsing through the mailing list archives I tried the
setup described here:
http://mobile.linux.pt/p800

The bluetooth connection works (e.g. p3nfs) but I guess that the sx1
needs another chat file. Thats the output / error I get:

#sdptool browse 
Service Name: Bluetooth Serial Port
Service Description: Bluetooth Serial Port
Service Provider: Symbian Ltd.
Service RecHandle: 0x10026
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100



#rfcomm
rfcomm1: 00:01:E3:2E:91:81 channel 2 clean


(changed /dev/ttyS1 in "/etc/ppp/peers/sx1-local" to /dev/rfcomm1)

#pppd call sx1-local debug nodetach
Connect script failed


As mentioned before I guess that the chat script needs to be modified. I
would like to know how the communication through the serial port in
windows can be dumped, so I could check that chat script.


Thank you
Dominik Blystak



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
