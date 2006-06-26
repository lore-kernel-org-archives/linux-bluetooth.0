Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <564d96fb0606191038m42f48295w784bf0062ae184a3@mail.gmail.com>
References: <564d96fb0606060325q834360bqe4e9d41cbb28a16f@mail.gmail.com>
	<564d96fb0606071459i7367f84fkb7ee645941f84279@mail.gmail.com>
	<1149718288.22472.71.camel@localhost>
	<564d96fb0606081007p3fb8ea42v5926c80eb1cc9657@mail.gmail.com>
	<1149884042.3985.6.camel@aeonflux.holtmann.net>
	<1150099297.2589.15.camel@aeonflux.holtmann.net>
	<564d96fb0606120452m4e4ced33x66ca63fd675ad3@mail.gmail.com>
	<1150715237.4277.17.camel@localhost>
	<564d96fb0606190513r4c59cd28v9bd23a9a45e55e8b@mail.gmail.com>
	<564d96fb0606190517w50ef4027p258030f7593ebd6a@mail.gmail.com>
	<564d96fb0606191038m42f48295w784bf0062ae184a3@mail.gmail.com>
Date: Mon, 26 Jun 2006 14:49:44 +0200
Message-Id: <1151326184.7694.22.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bug in sdp_gen_pd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Rafael,

> A patch is attached. It creates the following invariant when handling strings:
> 
> d->unitSize == strlen(d->val.str) + sizeof(uint8_t)
> 
> Different parts of the code had different "opinions".

the patch is in the CVE nos and it makes it better, but I am still not
fully happy. When creating strings in SDP you don't need to include the
terminating NUL character, because every string is prefixed with a
length.

# sdptool add sp
Serial Port service registered

# sdptool browse local
Browsing FF:FF:FF:00:00:00 ...
Service Name: Serial Port
Service Description: COM Port
Service RecHandle: 0x10000
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Serial Port" (0x1101)
    Version: 0x0100

# sdptool browse --tree local
Browsing FF:FF:FF:00:00:00 ...
Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10000
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1101 - SerialPort
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
    Data Sequence
      UUID16 : 0x0003 - RFCOMM
      Channel/Port (Integer) : 0x1
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup
Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
  Data Sequence
    Code ISO639 (Integer) : 0x656e
    Encoding (Integer) : 0x6a
    Base Offset (Integer) : 0x100
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1101 - SerialPort
      Version (Integer) : 0x100
Attribute Identifier : 0x100
  Data : 53 65 72 69 61 6c 20 50 6f 72 74 00
Attribute Identifier : 0x101
  Data : 43 4f 4d 20 50 6f 72 74 00

# sdptool browse --raw local
Sequence
        Attribute 0x0000 - ServiceRecordHandle
                UINT32 0x00010000
        Attribute 0x0001 - ServiceClassIDList
                Sequence
                        UUID16 0x1101 - SerialPort
        Attribute 0x0004 - ProtocolDescriptorList
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                        Sequence
                                UUID16 0x0003 - RFCOMM
                                UINT8 0x01
        Attribute 0x0005 - BrowseGroupList
                Sequence
                        UUID16 0x1002 - PublicBrowseGroup
        Attribute 0x0006 - LanguageBaseAttributeIDList
                Sequence
                        UINT16 0x656e
                        UINT16 0x006a
                        UINT16 0x0100
        Attribute 0x0009 - BluetoothProfileDescriptorList
                Sequence
                        Sequence
                                UUID16 0x1101 - SerialPort
                                UINT16 0x0100
        Attribute 0x0100
                String Serial Port
        Attribute 0x0101
                String COM Port

As you see, the --tree option is too dumb to detect that it is a string.
This has been left there on purpose to find stupid SDP records that
include a NUL character at the end.

Please try to fix this, too.

Regards

Marcel



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
