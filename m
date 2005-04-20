Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050420102807.86485.qmail@web41305.mail.yahoo.com>
From: Alex Dubov <oakad@yahoo.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1001570062-1113992887=:85811"
Subject: [Bluez-devel] Strange problem with sdp and Motorola E398
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 20 Apr 2005 03:28:07 -0700 (PDT)

--0-1001570062-1113992887=:85811
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hello everybody.
I have a Motorola E398 bt enabled device (with 7
languages pack installed). The problem is as
following: attribute 0x100 (service description) bears
encoding 'ar' (and it is really in arabic). There is
also a 7-entry internationalization table for each
service (with attributes 0xd800, 0xd803, etc for other
languages, including 'en'). Yet all my attempts to dig
these strings out with sdp_data_get were in vain. Fred
Schaettgen, whom I asked for help (as I saw a problem
in his kbluetoothd problem first), advised me to go to
this list for help.
I would like to attach a short sdptool dump to this
message, for illustration.
I've tried my chances with hcidump - it seems like
attributes 0xd800 and such are never fetched or not present.


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 
--0-1001570062-1113992887=:85811
Content-Type: text/plain; name="sdpdump1.txt"
Content-Description: sdpdump1.txt
Content-Disposition: inline; filename="sdpdump1.txt"

Browsing 00:0A:28:59:8C:6F ...
Service RecHandle: 0x0
Service Class ID List:
  "SDP Server" (0x1000)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "SDP" (0x0001)
Profile Descriptor List:
  "SDP Server" (0x1000)
    Version: 0x0100

Service Name: منفذ اتصا
Service Description: منفذ اتصا
Service Provider: Motorola
Service RecHandle: 0x10001
Service Class ID List:
  "Dialup Networking" (0x1103)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Language Base Attr List:
  code_ISO639: 0x6172
  encoding:    0x6a
  base_offset: 0x100
  code_ISO639: 0x6865
  encoding:    0x6a
  base_offset: 0xd800
  code_ISO639: 0x7275
  encoding:    0x6a
  base_offset: 0xd803
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0xd806
  code_ISO639: 0x6672
  encoding:    0x6a
  base_offset: 0xd809
  code_ISO639: 0x6573
  encoding:    0x6a
  base_offset: 0xd80c
  code_ISO639: 0x7472
  encoding:    0x6a
  base_offset: 0xd80f
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100


--0-1001570062-1113992887=:85811--


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
