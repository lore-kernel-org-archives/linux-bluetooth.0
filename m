Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: pand connection to XP SP2 fails
From: Erwin Authried <eauth@softsys.co.at>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1103110592.2143.218.camel@pegasus>
References: <1103024795.4097.65.camel@justakiss>
	 <1103024932.2143.156.camel@pegasus> <1103025459.4095.68.camel@justakiss>
	 <cpmnro$2p5$1@sea.gmane.org>  <1103036073.4095.101.camel@justakiss>
	 <1103107355.2143.185.camel@pegasus>  <1103110263.4099.109.camel@justakiss>
	 <1103110592.2143.218.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-b/KpLNILNoJkaHdtwc7O"
Message-Id: <1103112978.4099.112.camel@justakiss>
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
Date: Wed, 15 Dec 2004 13:16:18 +0100


--=-b/KpLNILNoJkaHdtwc7O
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Mit, den 15.12.2004 schrieb Marcel Holtmann um 12:36:
> Hi Erwin,
> 
> > yes, this works fine (with pand --service PANU ...).
> 
> please do a "sdptool browse|search ..." with the --tree option. May we
> can get the service from the SDP record and use a good default. Does a
> simple "pand --connect ..." without any extra options work for you?
> 
> Regards
> 
> Marcel

this is the output of "sdptool browse --tree <adr>" from XP home/SP2.

Regards,
Erwin


--=-b/KpLNILNoJkaHdtwc7O
Content-Disposition: attachment; filename=browse.txt
Content-Type: text/plain; name=browse.txt; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Browsing 00:0C:76:48:5D:4D ...
Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x0
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1000 - ServiceDiscoveryServerServiceClassID (SDP)
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
      Channel/Port (Integer) : 0x1
    Data Sequence
      UUID16 : 0x0001 - SDP (Service Discovery Protocol)
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup (SDP)
Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
  Data Sequence
    Code ISO639 (Integer) : 0x656e
    Encoding (Integer) : 0x6a
    Base Offset (Integer) : 0x100
Attribute Identifier : 0x100
  Data : 53 65 72 76 69 63 65 20 44 69 73 63 6f 76 65 72 79 00
Attribute Identifier : 0x101
  Data : 50 75 62 6c 69 73 68 65 73 20 73 65 72 76 69 63 65 73 20 74 6f 20 72 65 6d 6f 74 65 20 64 65 76 69 63 65 73 00
Attribute Identifier : 0x102
  Data : 4d 69 63 72 6f 73 6f 66 74 00
Attribute Identifier : 0x200 - VersionNumberList
  Data Sequence
    Integer : 0x100
Attribute Identifier : 0x201 - ServiceDatabaseState
  Integer : 0x1

Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10000
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1115 - PANU (PAN/BNEP)
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
      Channel/Port (Integer) : 0xf
    Data Sequence
      UUID16 : 0x000f - BNEP (PAN/BNEP)
      Channel/Port (Integer) : 0x100
      Data Sequence
      Broken dataseq link
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup (SDP)
Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
  Data Sequence
    Code ISO639 (Integer) : 0x6465
    Encoding (Integer) : 0x3f7
    Base Offset (Integer) : 0x100
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1115 - PANU (PAN/BNEP)
      Version (Integer) : 0x100
Attribute Identifier : 0x100
  Data : 50 00 65 00 72 00 73 00 f6 00 6e 00 6c 00 69 00 63 00 68 00 65 00 72 00 20 00 41 00 64 00 2d 00 68 00 6f 00 63 00 2d 00 42 00 65 00 6e 00 75 00 74 00 7a 00 65 00 72 00 64 00 69 00 65 00 6e 00 73 00 74 00
Attribute Identifier : 0x101
  Data : 50 00 65 00 72 00 73 00 f6 00 6e 00 6c 00 69 00 63 00 68 00 65 00 72 00 20 00 41 00 64 00 2d 00 68 00 6f 00 63 00 2d 00 42 00 65 00 6e 00 75 00 74 00 7a 00 65 00 72 00 64 00 69 00 65 00 6e 00 73 00 74 00
Attribute Identifier : 0x30a - SecurityDescription
  Integer : 0x0


--=-b/KpLNILNoJkaHdtwc7O--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
