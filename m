Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: giochi <giochi@telvia.it>
To: bluez-users@lists.sourceforge.net
Message-Id: <20040422233858.1bb6a766@bizio.slackware-italia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] rfcomm problem
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
Date: Thu, 22 Apr 2004 23:38:58 +0200

Hello,

this is my first experience with bluetooth. I've followed this link http://www.linuxquestions.org/questions/showthread.php?s=&postid=841157#post
and many others for setup it.
Alls work fine till the rfcomm initialization:

root@bizio:~# rfcomm bind 0 00:0A:28:B1:9C:6E 8
Wrong number of parameters.
root@bizio:~# rfcomm bind 0 00:0A:28:B1:9C:6E 9
Wrong number of parameters.
root@bizio:~# rfcomm bind 0                    
Device USSP not registered: No such device

root@bizio:~# hcitool inq
Inquiring ...
        00:0A:28:B1:9C:6E       clock offset: 0x3ea0    class: 0x000100
root@bizio:~# hcitool scann
Scanning ...
        00:0A:28:B1:9C:6E       Motorola Phone

root@bizio:~# sdptool browse 00:0A:28:B1:9C:6E
Browsing 00:0A:28:B1:9C:6E ...
Service RecHandle: 0x0
Service Class ID List:
  "SDP Server" (0x1000)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "SDP" (0x0001)
Profile Descriptor List:
  "" (0x1000)
    Version: 0x0100

...
Service Name: OBEX Object Push
Service Description: OBEX Object Push
Service Provider: Motorola
Service RecHandle: 0x10008
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 8
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
  code_ISO639: 0x6672
  encoding:    0x6a
  base_offset: 0xd800
  code_ISO639: 0x6465
  encoding:    0x6a
  base_offset: 0xd803
  code_ISO639: 0x6974
  encoding:    0x6a
  base_offset: 0xd806
  code_ISO639: 0x6573
  encoding:    0x6a
  base_offset: 0xd809
  code_ISO639: 0x6e6c
  encoding:    0x6a
  base_offset: 0xd80c
  code_ISO639: 0x7472
  encoding:    0x6a
  base_offset: 0xd80f
  code_ISO639: 0x7074Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

Service Name: OBEX file transfer
Service Description: OBEX file transfer
Service Provider: Motorola
Service RecHandle: 0x10009
Service Class ID List:
  "OBEX File Transfer" (0x1106)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 9
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
  code_ISO639: 0x6672
  encoding:    0x6a
  base_offset: 0xd800
  code_ISO639: 0x6465
  encoding:    0x6a
  base_offset: 0xd803
  code_ISO639: 0x6974
  encoding:    0x6a
  base_offset: 0xd806
  code_ISO639: 0x6573
  encoding:    0x6a
  base_offset: 0xd809
  code_ISO639: 0x6e6c
  encoding:    0x6a
  base_offset: 0xd80c
  code_ISO639: 0x7472
  encoding:    0x6a
  base_offset: 0xd812
  encoding:    0x6a
  base_offset: 0xd80f
  code_ISO639: 0x7074
  encoding:    0x6a
  base_offset: 0xd812
Profile Descriptor List:
  "OBEX File Transfer" (0x1106)
    Version: 0x0100

So, as appears 8 and 9 channels are designed for OBEX.
When I found these channels I type:
sdptool add --channel=9 OPUSH
sdptool add --channel=8 OPUSH

Here's my /etc/bluetooth/rfcomm.conf

#
# RFCOMM configuration file.
#
# $Id: rfcomm.conf,v 1.1 2002/10/07 05:58:18 maxk Exp $
#
#
rfcomm0 {
        # Automatically bind the device at startup
        bind no;

        # Bluetooth address of the device
        device 00:0A:28:B1:9C:6E;

        # RFCOMM channel for the connection
        channel 8;

        # Description of the connection
        comment "ObexBT";
} 

I use a sitecom usb dongle and motorola v525
Any help would be appreciated.
Br,
Fab


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
