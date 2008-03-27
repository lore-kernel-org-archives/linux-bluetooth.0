Return-Path: <cyrus@holtmann.org>
Message-ID: <47EBC684.5030209@access-company.com>
Date: Thu, 27 Mar 2008 17:08:36 +0100
From: Frederic Danis <frederic.danis@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47EA7502.0@access-company.com>	<D1F8014E-5892-4B2A-9219-99670FC1EA60@holtmann.org>	<47EB7AC4.30700@access-company.com>
	<70BC25E2-2162-4792-938B-4FE91F0A6032@holtmann.org>
In-Reply-To: <70BC25E2-2162-4792-938B-4FE91F0A6032@holtmann.org>
Content-Type: multipart/mixed; boundary="------------030701080801020301070200"
Subject: Re: [Bluez-devel] HID certification using PTS
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030701080801020301070200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marcel,

>>>> - currently, when performing a CreateDevice, input service connects
>>>> then
>>>> disconnects from remote device. This makes some tests failed.
>>>> What do you think if this does not disconnect (and create classic
>>>> device
>>>> connection) ?
>>> does using CreateSecureDevice helps? Can you verify with bluez-
>>> utils-3.29 and see if it is still a problem?
>> I tried with CreateSecureDevice and latest 3.29 version but PTS  
>> tests failed.
>> I think this is related to the disconnection in Create*Device process.
>> What do you think if disconnection is removed from this process ? Or  
>> add a new API, something like CreateAndConnectSecureDevice ?
> 
> can you please check the service records of the PTS. Does it set the  
> reconnect value to TRUE. Please check hcidump and see if CreateDevice  
> actually connects the control and interrupt PSM.

If I do not make any mistake it seems to me that reconnect is set to false (see attached record - PTS_HID_record.txt).
Create Device connects control and interrupt PSMs (see PTS_HID_createdevice_dump.txt), but not HID kernel part.

> Does it help if you call CreateDevice() and then Connect() to pass the  
> test.

Yes, for most of the tests. But for one test (TC_EXT_HOS_CON_BV_0201_I) that check if pairing and connection are available, this makes it failed 
(CreateSecureDevice then Connect).

>>>> - when kernel (2.6.22) receives a VIRTUAL_CABLE_UNPLUG from PTS  
>>>> (tests
>>>> TC_HOS_HCR_BV_02_I and TC_HOS_HCR_BV_04_I) it does not close the  
>>>> L2CAP
>>>> channels as PTS waits for.
>>>> I take a look in 2.6.22 sources, and it seems to me this  
>>>> disconnection
>>>> should happen, am I right ?
>>>> Is it fixed in later kernel ?
>>> I recall that there was a fix for this.
>> Do you remember if this has been integrated in kernel ?
>> I take a look to latest kernel (2.6.24) and do not see any change  
>> that seems to be related to this problem.
> 
> Please include the hcidump -X -V output for this case.

See PTS_HID_virtualcableunplug_dump.txt.
I also add some traces in kernel (see PTS_HID_virtualcableunplug_kernel.patch) and attached results (see PTS_HID_virtualcableunplug_kernellog.txt).

Hope this helps

Thanks

Fred

-- 
-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic                   Access Company
Software engineer
Mail : mailto:frederic.danis@access-company.com
-----------------------------------------------

--------------030701080801020301070200
Content-Type: text/plain;
 name="PTS_HID_record.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PTS_HID_record.txt"

~ # sdptool search --bdaddr 00:02:5B:02:2F:F9 --tree HID
Searching for HID on 00:02:5B:02:2F:F9 ...
Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x1004e
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1124 - HumanInterfaceDeviceService (HID)
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
      Channel/Port (Integer) : 0x11
    Data Sequence
      UUID16 : 0x0011 - HIDP
Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
  Data Sequence
    Code ISO639 (Integer) : 0x656e
    Encoding (Integer) : 0x6a
    Base Offset (Integer) : 0x100
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1124 - HumanInterfaceDeviceService (HID)
      Version (Integer) : 0x100
Attribute Identifier : 0xd - AdditionalProtocolDescriptorLists
  Data Sequence
    Data Sequence
      Data Sequence
        UUID16 : 0x0100 - L2CAP
        Integer : 0x13
      Data Sequence
        UUID16 : 0x0011 - HIDP
Attribute Identifier : 0x100
  Data : 42 6c 75 65 74 6f 6f 74 68 20 53 49 47 20 4b 65 79 62 6f 61 72 64 00
Attribute Identifier : 0x101
  Data : 42 6c 75 65 74 6f 6f 74 68 20 4b 65 79 62 6f 61 72 64 00
Attribute Identifier : 0x102
  Data : 42 6c 75 65 74 6f 6f 74 68 20 53 49 47 00
Attribute Identifier : 0x200 - DeviceReleaseNum
  Integer : 0x100
Attribute Identifier : 0x201 - ParserVersion
  Integer : 0x111
Attribute Identifier : 0x202 - DeviceSubclass
  Integer : 0x40
Attribute Identifier : 0x203 - CountryCode
  Integer : 0x21
Attribute Identifier : 0x204 - VirtualCable
  Integer : 0x1
Attribute Identifier : 0x205 - ReconnectInitiate
  Integer : 0x0
Attribute Identifier : 0x206 - DescriptorList
  Data Sequence
    Data Sequence
      Integer : 0x22
      Data : 05 01 09 06 a1 01 85 01 05 07 19 e0 29 e7 15 00 25 01 75 01 95 08 81 02 95 01 75 08 81 01 95 05 75 01 05 08 19 01 29 05 91 02 95 01 75 03 91 01 95 06 75 08 15 00 25 65 05 07 19 00 29 65 81 00 c0 05 0c 09 01 a1 01 85 02 19 00 29 ff 15 00 25 ff 75 08 95 01 81 00 c0 00
Attribute Identifier : 0x207 - LangIDBaseList
  Data Sequence
    Data Sequence
      Integer : 0x409
      Integer : 0x100
Attribute Identifier : 0x208 - SDPDisable
  Integer : 0x0
Attribute Identifier : 0x209 - BatteryPower
  Integer : 0x1
Attribute Identifier : 0x20a - RemoteWakeup
  Integer : 0x1
Attribute Identifier : 0x20b - ProfileVersion
  Integer : 0x100
Attribute Identifier : 0x20c - SupervisionTimeout
  Integer : 0x1f40
Attribute Identifier : 0x20d - NormallyConnectable
  Integer : 0x0
Attribute Identifier : 0x20e - BootDevice
  Integer : 0x1

~ #

--------------030701080801020301070200
Content-Type: text/plain;
 name="PTS_HID_createdevice_dump.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PTS_HID_createdevice_dump.txt"

~ # hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:02:5B:02:2F:F9 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:02:5B:02:2F:F9 type ACL encrypt 0x00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 42
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:02:5B:02:2F:F9 mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 42 policy 0x07
    Link policy: RSWITCH HOLD SNIFF 
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 42
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:02:5B:02:2F:F9 mode 2 clkoffset 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 42
    Features: 0xff 0xff 0x8f 0x7e 0x98 0x19 0x00 0x80
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 672 
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:02:5B:02:2F:F9 name 'PTS-HID-FDANIS1'
< ACL data: handle 42 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1200 (PNPInfo)
          max 64
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 1]
        SDP SS Rsp: tid 0x0 len 0x9
          count 1
          handle 0x10051
          cont 00
< ACL data: handle 42 flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 1]
        SDP SA Req: tid 0x1 len 0xe
          handle 0x10051
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 96
    L2CAP(d): cid 0x0040 len 92 [psm 1]
        SDP SA Rsp: tid 0x1 len 0x57
          count 84
          aid 0x0000 (SrvRecHndl)
             uint 0x10051
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x1200 (PNPInfo) >
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) uint 0x1 > <
             uuid-16 0x0001 (SDP) > >
          aid 0x0009 (BTProfileDescList)
             < < uuid-16 0x1200 (PNPInfo) uint 0x100 > >
          aid 0x0200 (VersionNumList)
             uint 0x100
          aid 0x0201 (SrvDBState)
             uint 0x3f
          aid 0x0202 (unknown)
             uint 0x1
          aid 0x0203 (unknown)
             uint 0x203
          aid 0x0204 (unknown)
             bool 0x1
          aid 0x0205 (unknown)
             uint 0x1
          cont 00
< ACL data: handle 42 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 1]
        SDP SS Req: tid 0x2 len 0x8
          pat uuid-16 0x1124 (HID)
          max 64
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 1]
        SDP SS Rsp: tid 0x2 len 0x9
          count 1
          handle 0x10050
          cont 00
< ACL data: handle 42 flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 1]
        SDP SA Req: tid 0x3 len 0xe
          handle 0x10050
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 345
    L2CAP(d): cid 0x0040 len 341 [psm 1]
        SDP SA Rsp: tid 0x3 len 0x150
          count 333
          aid 0x0000 (SrvRecHndl)
             uint 0x10050
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x1124 (HID) >
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) uint 0x11 > <
             uuid-16 0x0011 (HIDP) > >
          aid 0x0006 (LangBaseAttrIDList)
             < uint 0x656e uint 0x6a uint 0x100 >
          aid 0x0009 (BTProfileDescList)
             < < uuid-16 0x1124 (HID) uint 0x100 > >
          aid 0x000d (IconURL)
             < < < uuid-16 0x0100 (L2CAP) uint 0x13 > < uuid-16 0x0011 (HIDP) > > >
          aid 0x0100 (SrvName)
             str "Bluetooth SIG Keyboard"
          aid 0x0101 (SrvDesc)
             str "Bluetooth Keyboard"
          aid 0x0102 (ProviderName)
             str "Bluetooth SIG"
          aid 0x0200 (VersionNumList)
             uint 0x100
          aid 0x0201 (SrvDBState)
             uint 0x111
          aid 0x0202 (unknown)
             uint 0x40
          aid 0x0203 (unknown)
             uint 0x21
          aid 0x0204 (unknown)
             bool 0x1
          aid 0x0205 (unknown)
             bool 0x0
          aid 0x0206 (unknown)
             < < uint 0x22 str 05 01 09 06 a1 01 85 01 05 07 19 e0 29 e7 15 00 25 01 75 01 95 08 81 02 95 01 75 08 81 01 95 05 75 01 05 08 19 01 29 05 91 02 95 01 75 03 91 01 95 06 75 08 15 00 25 65 05 07 19 00 29 65 81 00 c0 05 0c 09 01 a1 01 85 02 19 00 29 ff 15 00 25 ff 75 08 95 01 81 00 c0 > >
          aid 0x0207 (unknown)
             < < uint 0x409 uint 0x100 > >
          aid 0x0208 (unknown)
             bool 0x0
          aid 0x0209 (unknown)
             bool 0x1
          aid 0x020a (unknown)
             bool 0x1
          aid 0x020b (unknown)
             uint 0x100
          aid 0x020c (unknown)
             uint 0x1f40
          aid 0x020d (unknown)
             bool 0x0
          aid 0x020e (unknown)
             bool 0x1
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:02:5B:02:2F:F9
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:02:5B:02:2F:F9 key F238D72A0FA33949871334ED9FFED141
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:02:5B:02:2F:F9
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 42 encrypt 0x01
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 672 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      Success
      MTU 672 
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0040
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0041
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x15
    Reason: Remote Device Terminated Connection due to Power Off



--------------030701080801020301070200
Content-Type: text/plain;
 name="PTS_HID_virtualcableunplug_dump.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PTS_HID_virtualcableunplug_dump.txt"

~ # hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:02:5B:02:2F:F9 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:02:5B:02:2F:F9 type ACL encrypt 0x00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0040
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:02:5B:02:2F:F9 mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 42 policy 0x07
    Link policy: RSWITCH HOLD SNIFF 
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 42
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:02:5B:02:2F:F9 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 42
    Features: 0xff 0xff 0x8f 0x7e 0x98 0x19 0x00 0x80
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:02:5B:02:2F:F9 name 'PTS-HID-FDANIS1'
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:02:5B:02:2F:F9
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:02:5B:02:2F:F9 key F238D72A0FA33949871334ED9FFED141
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:02:5B:02:2F:F9
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 42 encrypt 0x01
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 672 
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      Success
      MTU 672 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 19]
      HIDP: Data: Output report
      0000: 01 00 22 00 00 00 00 00  00                       .."......
< ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 19]
      HIDP: Data: Output report
      0000: 02 00                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1




> ACL data: handle 42 flags 0x02 dlen 5
    L2CAP(d): cid 0x0040 len 1 [psm 17]
      HIDP: Control: Virtual cable unplug




> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x15
    Reason: Remote Device Terminated Connection due to Power Off




--------------030701080801020301070200
Content-Type: text/x-patch;
 name="PTS_HID_virtualcableunplug_kernel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="PTS_HID_virtualcableunplug_kernel.patch"

==== linux-2.6.22/net/bluetooth/hidp/core.c - linux/net/bluetooth/hidp/core.c ====
@@ -46,10 +46,10 @@
 
 #include "hidp.h"
 
-#ifndef CONFIG_BT_HIDP_DEBUG
-#undef  BT_DBG
-#define BT_DBG(D...)
-#endif
+//#ifndef CONFIG_BT_HIDP_DEBUG
+//#undef  BT_DBG
+//#define BT_DBG(D...)
+//#endif
 
 #define VERSION "1.2"
 
@@ -246,7 +246,7 @@
 {
        struct sk_buff *skb;
 
-       BT_DBG("session %p hid %p data %p size %d", session, device, data, size);
+       BT_DBG("session %p data %p size %d", session, data, size);
 
        if (!(skb = alloc_skb(size + 1, GFP_ATOMIC))) {
                BT_ERR("Can't allocate memory for new frame");
@@ -379,6 +379,7 @@
 
                /* Kill session thread */
                atomic_inc(&session->terminate);
+               hidp_schedule(session);
                break;
 
        case HIDP_CTRL_HARD_RESET:
@@ -571,8 +572,11 @@
 
                hidp_process_transmit(session);
 
+               BT_DBG("session %p - loop before schedule", session);
                schedule();
+               BT_DBG("session %p - loop after schedule", session);
        }
+       BT_DBG("session %p - loop exit", session);
        set_current_state(TASK_RUNNING);
        remove_wait_queue(intr_sk->sk_sleep, &intr_wait);
        remove_wait_queue(ctrl_sk->sk_sleep, &ctrl_wait);
@@ -582,27 +586,38 @@
        hidp_del_timer(session);
 
        if (session->input) {
+               BT_DBG("session %p - input_unregister_device", session);
                input_unregister_device(session->input);
                session->input = NULL;
        }
 
        if (session->hid) {
-               if (session->hid->claimed & HID_CLAIMED_INPUT)
+               BT_DBG("session %p - hid", session);
+               if (session->hid->claimed & HID_CLAIMED_INPUT) {
+                       BT_DBG("session %p - hidinput_disconnect", session);
                        hidinput_disconnect(session->hid);
+               }
+               BT_DBG("session %p - before hid_free_device", session);
                hid_free_device(session->hid);
+               BT_DBG("session %p - after hid_free_device", session);
        }
 
+       BT_DBG("session %p - fput ", session);
        fput(session->intr_sock->file);
 
+       BT_DBG("session %p - %d", session, ctrl_sk->sk_state);
        wait_event_timeout(*(ctrl_sk->sk_sleep),
                (ctrl_sk->sk_state == BT_CLOSED), msecs_to_jiffies(500));
+       BT_DBG("session %p - %d", session, ctrl_sk->sk_state);
 
        fput(session->ctrl_sock->file);
 
+       BT_DBG("session %p - __hidp_unlink_session", session);
        __hidp_unlink_session(session);
 
        up_write(&hidp_session_sem);
 
+       BT_DBG("session %p - exit", session);
        kfree(session);
        return 0;
 }


--------------030701080801020301070200
Content-Type: text/plain;
 name="PTS_HID_virtualcableunplug_kernellog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="PTS_HID_virtualcableunplug_kernellog.txt"

~ # dbus-send --system --type=method_call --print-reply --dest=":1.1" /org/bluez/input/keyboard1 org.bluez.input.Device.Connect
hidp_sock_create: sock 0a71c360
hidp_sock_ioctl: cmd 800448d3 arg bf740668
__hidp_get_session: 
hidp_sock_release: sock 0a71c360 sk 0a6a2000
l2cap_sock_create: sock 0a71c360
l2cap_sock_init: sk 0a6a2000
l2cap_sock_bind: sk 0a6a2000, 84:F3:01:5B:02:00 0
l2cap_sock_connect: sk 0a6a2000
l2cap_do_connect: 84:F3:01:5B:02:00 -> F9:2F:02:5B:02:00 psm 0x11
l2cap_conn_add: hcon 0a6a2200 conn 09de28a0
__l2cap_chan_add: conn 09de28a0, psm 0x11, dcid 0x0000
l2cap_sock_set_timer: sk 0a6a2000 state 5 timeout 4000
l2cap_connect_cfm: hcon 0a6a2200 bdaddr F9:2F:02:5B:02:00 status 0
l2cap_conn_ready: conn 09de28a0
l2cap_build_cmd: conn 09de28a0, code 0x02, ident 0x01, len 4
l2cap_send_cmd: code 0x02
l2cap_encrypt_cfm: conn 09de28a0
l2cap_recv_acldata: conn 09de28a0 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn 09de28a0
l2cap_sig_channel: code 0x03 len 8 id 0x01
l2cap_connect_rsp: dcid 0x0040 scid 0x0040 result 0x00 status 0x00
l2cap_build_conf_req: sk 0a6a2000
l2cap_build_cmd: conn 09de28a0, code 0x04, ident 0x02, len 4
l2cap_send_cmd: code 0x04
l2cap_recv_acldata: conn 09de28a0 len 14 flags 0x2
l2cap_recv_frame: len 10, cid 0x0001
l2cap_raw_recv: conn 09de28a0
l2cap_sig_channel: code 0x05 len 6 id 0x02
l2cap_config_rsp: scid 0x0040 flags 0x00 result 0x00
l2cap_recv_acldata: conn 09de28a0 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn 09de28a0
l2cap_sig_channel: code 0x04 len 4 id 0xde
l2cap_config_req: dcid 0x0040 flags 0x00
l2cap_parse_conf_req: sk 0a6a2000
l2cap_add_conf_opt: type 0x01 len 2 val 0x2a0
l2cap_build_cmd: conn 09de28a0, code 0x05, ident 0xde, len 10
l2cap_send_cmd: code 0x05
l2cap_chan_ready: sk 0a6a2000, parent 00000000
l2cap_sock_clear_timer: sock 0a6a2000 state 1
l2cap_sock_create: sock 0a71c4c0
l2cap_sock_init: sk 09529a00
l2cap_sock_bind: sk 09529a00, 84:F3:01:5B:02:00 0
l2cap_sock_connect: sk 09529a00
l2cap_do_connect: 84:F3:01:5B:02:00 -> F9:2F:02:5B:02:00 psm 0x13
__l2cap_chan_add: conn 09de28a0, psm 0x13, dcid 0x0000
l2cap_sock_set_timer: sk 09529a00 state 5 timeout 4000
l2cap_build_cmd: conn 09de28a0, code 0x02, ident 0x03, len 4
l2cap_send_cmd: code 0x02
l2cap_recv_acldata: conn 09de28a0 len 16 flags 0x2
l2cap_recv_frame: len 12, cid 0x0001
l2cap_raw_recv: conn 09de28a0
l2cap_sig_channel: code 0x03 len 8 id 0x03
l2cap_connect_rsp: dcid 0x0041 scid 0x0041 result 0x00 status 0x00
l2cap_build_conf_req: sk 09529a00
l2cap_build_cmd: conn 09de28a0, code 0x04, ident 0x04, len 4
l2cap_send_cmd: code 0x04
l2cap_recv_acldata: conn 09de28a0 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn 09de28a0
l2cap_sig_channel: code 0x04 len 4 id 0xdf
l2cap_config_req: dcid 0x0041 flags 0x00
l2cap_parse_conf_req: sk 09529a00
l2cap_add_conf_opt: type 0x01 len 2 val 0x2a0
l2cap_build_cmd: conn 09de28a0, code 0x05, ident 0xdf, len 10
l2cap_send_cmd: code 0x05
l2cap_recv_acldata: conn 09de28a0 len 14 flags 0x2
l2cap_recv_frame: len 10, cid 0x0001
l2cap_raw_recv: conn 09de28a0
l2cap_sig_channel: code 0x05 len 6 id 0x04
l2cap_config_rsp: scid 0x0041 flags 0x00 result 0x00
l2cap_chan_ready: sk 09529a00, parent 00000000
l2cap_sock_clear_timer: sock 09529a00 state 1
hidp_sock_create: sock 0a71c620
hidp_sock_ioctl: cmd 400448c8 arg bf740774
hidp_add_connection: 
hidp_add_connection: rd_data 0805b548 rd_size 89
__hidp_get_session: 
hidp_add_connection: ctrl mtu 672 intr mtu 672
hidp_queue_report: session 0aff43e0 data 0840fce8 size 9
hidp_queue_report: session 0aff43e0 data 0840fce8 size 2
input: PTS-HID-FDANIS1 as /class/input/input2
hidp_sock_release: sock 0a71c620 sk 0a6a2600
method return sender=:1.1 -> dest=:1.19
hidp_session: session 0aff43e0
hidp_process_transmit: session 0aff43e0
hidp_send_frame: sock 0a71c4c0 data 089f2360 len 10
l2cap_sock_sendmsg: sock 0a71c4c0, sk 09529a00
l2cap_do_send: sk 09529a00 len 10
hidp_send_frame: sock 0a71c4c0 data 089f2960 len 3
l2cap_sock_sendmsg: sock 0a71c4c0, sk 09529a00
l2cap_do_send: sk 09529a00 len 3
hidp_session: session 0aff43e0 - loop before schedule
hidp_session: session 0aff43e0 - loop after schedule
hidp_process_transmit: session 0aff43e0
hidp_session: session 0aff43e0 - loop before schedule

~ # 
~ # ----- HID is connected -----
~ # 
~ # 
l2cap_recv_acldata: conn 09de28a0 len 5 flags 0x2
l2cap_recv_frame: len 1, cid 0x0040
l2cap_data_channel: sk 0a6a2000, len 1
hidp_session: session 0aff43e0 - loop after schedule
hidp_recv_ctrl_frame: session 0aff43e0 skb 087efd40 len 1
hidp_process_hid_control: session 0aff43e0 param 0x05
hidp_process_transmit: session 0aff43e0
hidp_session: session 0aff43e0 - loop before schedule
hidp_session: session 0aff43e0 - loop after schedule
hidp_session: session 0aff43e0 - loop exit
hidp_session: session 0aff43e0 - hid
hidp_session: session 0aff43e0 - hidinput_disconnect
hidp_session: session 0aff43e0 - before hid_free_device
hidp_session: session 0aff43e0 - after hid_free_device
hidp_session: session 0aff43e0 - fput 
hidp_session: session 0aff43e0 - 1
hidp_session: session 0aff43e0 - 1
hidp_session: session 0aff43e0 - __hidp_unlink_session
hidp_session: session 0aff43e0 - exit

~ # 
~ # ----- L2CAP is still connected -----
~ # 
l2cap_disconn_ind: hcon 0a6a2200 reason 21
l2cap_conn_del: hcon 0a6a2200 conn 09de28a0, err 104
l2cap_sock_clear_timer: sock 09529a00 state 1
l2cap_chan_del: sk 09529a00, conn 09de28a0, err 104
l2cap_sock_clear_timer: sock 0a6a2000 state 1
l2cap_chan_del: sk 0a6a2000, conn 09de28a0, err 104
l2cap_sock_release: sock 0a71c360, sk 0a6a2000
l2cap_sock_shutdown: sock 0a71c360, sk 0a6a2000
l2cap_sock_clear_timer: sock 0a6a2000 state 9
__l2cap_sock_close: sk 0a6a2000 state 9 socket 0a71c360
l2cap_sock_kill: sk 0a6a2000 state 9
l2cap_sock_destruct: sk 0a6a2000
l2cap_sock_release: sock 0a71c4c0, sk 09529a00
l2cap_sock_shutdown: sock 0a71c4c0, sk 09529a00
l2cap_sock_clear_timer: sock 09529a00 state 9
__l2cap_sock_close: sk 09529a00 state 9 socket 0a71c4c0
l2cap_sock_kill: sk 09529a00 state 9
l2cap_sock_destruct: sk 09529a00




--------------030701080801020301070200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--------------030701080801020301070200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------030701080801020301070200--
