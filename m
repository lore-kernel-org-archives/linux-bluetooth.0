Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040202045646.51663.qmail@web40406.mail.yahoo.com>
From: beichuang <beichuang@yahoo.com>
Reply-To: beichuang@yahoo.com
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Problem with OBEX Object Push Service Description
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
Date: Sun, 1 Feb 2004 20:56:46 -0800 (PST)

Hello, 

I want to make an OBEX Object Push server and wish
this server can be discovered by other BT devices.

Before I do that, I used the command to add a OBEX
service as the command line:

#sdptool -add --channel=5 OPUSH

However, I cannot discover this service from other
devices (my iPAQ 5550) although the device can be
found.

I have then tested to send a vcard to my desktop from
iPAQ. It sopped after the prompt "connected with
BlueZ(0)" 

I have also compared the SDP information with any
other OPUSH server on Windows 2000, which works with
my iPAQ.
But it seems the information is the same.

Here below is the SDP details for the OBEX push server

Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x804d130
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1105 - OBEXObjectPush
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
    Data Sequence
      UUID16 : 0x0003 - RFCOMM
      Channel/Port (Integer) : 0x3
    Data Sequence
      UUID16 : 0x0008 - OBEX
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup (SDP)
Attribute Identifier : 0x9 -
BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1105 - OBEXObjectPush
      Version (Integer) : 0x100
Attribute Identifier : 0x100
  Text : "OBEX Object Push"
Attribute Identifier : 0x303
  Data Sequence
    Integer : 0x1
    Integer : 0x2
    Integer : 0x3
    Integer : 0x4
    Integer : 0x5
    Integer : 0x6


Anyone can find the reason why it is not interoperable
with my iPAQ? I can just not find any error with the
comparison with another working OBEX server.

Thanks and regards

/B.C.



__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free web site building tool. Try it!
http://webhosting.yahoo.com/ps/sb/


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
