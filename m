Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Tamer Higazi <tamer23@myrealbox.com>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1116313073.10074.8.camel@linux.site>
Mime-Version: 1.0
Subject: [Bluez-users] problems syncing with bluetooth on multisync: evolution/blueotooth
 plugin
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
Date: Tue, 17 May 2005 08:57:52 +0200

Hi! 
Everytime I want to synchronize with multisync: bluetooth/evolution2
plugins, the cell phone ask me for a password, i type one and receive a
error on the screen: "connection failed". 

I use as operating system SuSE Linux 9.3 Pro

Is it perhaps the configuration?! 


For any help

Thank you 


SuSE Linux 9.3 preconfigures the configuration like this for rfcomm: 

-f /etc/bluetooth/rfcomm.conf bind all

and inside the rfcomm.conf 

#
# RFCOMM configuration file.
#
# $Id: rfcomm.conf,v 1.1 2002/10/07 05:58:18 maxk Exp $
#

rfcomm0 {
        # Automatically bind the device at startup
        bind no;

        # Bluetooth address of the device
        device 11:22:33:44:55:66;

        # RFCOMM channel for the connection
        channel 1;

        # Description of the connection
        comment "Example Bluetooth device";
}

the result by quering the phone: 

Browsing 00:E0:03:65:64:94 ...
Service Name: Hands-Free Audio Gateway
Service RecHandle: 0x10000
Service Class ID List:
  "Handfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Handfree Audio Gateway" (0x111f)
    Version: 0x0101

Service Name: OBEX File Transfer
Service RecHandle: 0x10001
Service Class ID List:
  "OBEX File Transfer" (0x1106)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 10
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "OBEX File Transfer" (0x1106)
    Version: 0x0100

Service Name: SyncMLClient
Service RecHandle: 0x10002
Service Class ID List:
  "Error: This is UUID-128" (0x00000002-0000-1000-8000-0002ee000002)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 11
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Error: This is UUID-128" (0x00000002-0000-1000-8000-0002ee000002)
    Version: 0x0100

Service Name: Nokia OBEX PC Suite Services
Service RecHandle: 0x10003
Service Class ID List:
  "Error: This is UUID-128" (0x00005005-0000-1000-8000-0002ee000001)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 12
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Error: This is UUID-128" (0x00005005-0000-1000-8000-0002ee000001)
    Version: 0x0100

Service Name: OBEX Object Push
Service RecHandle: 0x10004
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 9
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

Service Name: Dial-Up Networking
Service RecHandle: 0x10005
Service Class ID List:
  "Dialup Networking" (0x1103)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100





-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
