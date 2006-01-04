Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1136374748.13931.17.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Some fun with Apple devices
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
Date: Wed, 04 Jan 2006 12:39:08 +0100

Hi,

I booted my Mac mini up with MacOS X (for the first time) and found some
funny things inside the Bluetooth stack from Apple. It seems that every
MacOS X identifies itself with a hidden record and they ask for it on
every discover. The record of my machine looks like this:

Sequence
        Attribute 0x0000 - ServiceRecordHandle
                UINT32 0x00020000
        Attribute 0x0100
                String Apple Macintosh Attributes
        Attribute 0x0780
                UUID128 f0722e20-0f8b-4e90-8cc2-1b46f5f2efe2
        Attribute 0x0781
                String Macmini
        Attribute 0x0782
                String PowerMac10,1
        Attribute 0x0783
                UINT32 0x00000000
        Attribute 0x0784
                String 1.6.6f22
        Attribute 0x0785
                UINT32 0x00000002
        Attribute 0x0786
                UUID16 0x1234

Using the latest CVS you will get this information with

	sdptool search --bdaddr 00:0D:93:xx:xx:xx --raw apple

If you don't wanna install the CVS you might replace the string "apple"
with "0x1234" and you get the same information about this record. I am
really interested how other MacOS X machines look like.

I also played a little bit with iSync and my Symbian phones. If you
wanna sync these phones they first send an application to the phone that
emulates somekind of iSync protocol. This idea is actually not bad and
it seems they can reliable identify the phone type. For my Nokia 6600
and N-Gage it showed the right picture.

This new application on the phone is installing a Bluetooth service with
the following record:

Sequence
        Attribute 0x0000 - ServiceRecordHandle
                UINT32 0x00010010
        Attribute 0x0001 - ServiceClassIDList
                Sequence
                        UUID16 0x1101 - SerialPort
                        UUID16 0x2112 - AppleAgent
        Attribute 0x0002 - ServiceRecordState
                UINT32 0x0000000a
        Attribute 0x0004 - ProtocolDescriptorList
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                        Sequence
                                UUID16 0x0003 - RFCOMM
                                UINT8 0x04
        Attribute 0x0005 - BrowseGroupList
                Sequence
                        UUID16 0x1002 - PublicBrowseGroup
        Attribute 0x0006 - LanguageBaseAttributeIDList
                Sequence
                        UINT16 0x656e
                        UINT16 0x006a
                        UINT16 0x0100
        Attribute 0x0007 - ServiceInfoTimeToLive
                UINT32 0x000004b0
        Attribute 0x0008 - ServiceAvailability
                UINT8 0xff
        Attribute 0x0009 - BluetoothProfileDescriptorList
                Sequence
                        Sequence
                                UUID16 0x2112 - AppleAgent
                                UINT16 0x0100
                        Sequence
                                UUID16 0x1101 - SerialPort
                                UINT16 0x0100
        Attribute 0x0100
                String AppleAgent
        Attribute 0x0101
                String Bluetooth acceptor
        Attribute 0x0102
                String Apple Computer Ltd.

It is basically a serial port based RFCOMM service. However it uses the
UUID 0x2112 and thus can be easily identified with this command.

	sdptool search --bdaddr 00:0E:6D:xx:xx:xx --raw 0x2112

The record handle and RFCOMM channel vary from phone to phone, but the
rest seems to be the same. In this case it is my N-Gage and it uses
RFCOMM channel 4 for the iSync protocol. Connecting to this channel
shows the following in hcidump:

> ACL data: handle 42 flags 0x01 dlen 13
    L2CAP(d): cid 0x0040 len 137 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 131 fcs 0x9c credits 4
      0000: 43 68 61 6e 6e 65 6c 49  44 3a 20 54 49 4d 45 3a  ChannelID: TIME:
      0010: 20 31 32 3a 32 39 3a 33  2e 32 31 38 37 35 30 20   12:29:3.218750
      0020: 31 37 31 33 33 36 36 38  34 0a 43 6f 6e 74 65 6e  171336684.Conten
      0030: 74 4c 65 6e 67 74 68 3a  20 33 0a 44 6f 6d 61 69  tLength: 3.Domai
      0040: 6e 3a 20 49 50 48 5f 41  47 45 4e 54 0a 49 6e 66  n: IPH_AGENT.Inf
      0050: 6f 3a 20 49 50 48 5f 41  47 45 4e 54 5f 56 45 52  o: IPH_AGENT_VER
      0060: 53 49 4f 4e 0a 43 6f 64  65 3a 20 30 0a 4d 65 73  SION.Code: 0.Mes
      0070: 73 61 67 65 54 79 70 65  3a 20 49 6e 66 6f 0a 0a  sageType: Info..
      0080: 31 34 32                                          142

This means that the service on the phones initiates the protocol. Seems
like another way to sync Symbian based phones under Linux. Nobody really
uses the crappy mRouter stuff.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
