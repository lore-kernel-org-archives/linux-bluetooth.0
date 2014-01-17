Return-Path: <cyrus@holtmann.org>
Message-ID: <8ccf0ad88f16335719c367ed69c90a3e.squirrel@mungewell.org>
Date: Fri, 17 Jan 2014 00:09:35 -0500
Subject: Dualshock4 - 'HIDP: Handshake: Unsupported request' after 'unplug
 virtual cable'.
From: simon@mungewell.org
To: linux-bluetooth@vger.kernel.org
Cc: "Frank Praznik" <frank.praznik@oh.rr.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20140117000935_32370"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

------=_20140117000935_32370
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi all,
Frank and I have been working on a kernel driver for the Dualshock 4 and
we're having problems with the BT connection (USB is OK).

When powered on the DS4 will initiate a connection to the PC once it knows
it's Bdaddr (via pairing), but will power off shortly there after. This
seems to be related to incorrect (??) data sent from Bluez, or if no hid
connection is made within a short window.

On the two systems I have tried:
1) Debian with bluez 4.99, I can 'hidd --connect xxx' to hold the
connection. I get joystick data but can't send data to DS4 to drive
ff/leds. (I am told that 'hidd' is deprated)

2) Fedora LiveCD with bluez 5.13. Connection is immediately terminated by
the controller. HCI log attached.

It appears that the controller is insisting on a encrypted link ('noenc'
and 'noauth' make no difference) and does not like the 'unplug virtual
cable' which is sent (presumably as the link is being brought down to
re-start encrypted).

In the BT HID 1.1 spec (page 48) it says
--
If the HIDVirtualCable SDP attribute is set to TRUE, then a Virtual Cable
is considered to be established after both the HID Control and HID
Interrupt L2CAP channels have been opened.
--

However the Fedora system does not have a copy of the SDP records for the
controller, it never pulled them and I have never managed to make a
connection long enough to read them.

My theory is that the controller is rejecting the 'Unplug Virtual Cable'
command as it shouldn't have been established, but I'm not really sure.



I managed use my Debian system to read SDP records but that barfs on
what's sent.... files also attached.

Does anyone have any suggestions on what I should try next?
Thanks, Simon





------=_20140117000935_32370
Content-Type: application/gzip; name="hcidump_records.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="hcidump_records.txt.gz"

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
dCt1pbiV+nivgFupfttCZ29r4XuWh4XS87eF5quzEzTuCq3mPw3pZ28KiRtKH7QpdKzVX//x6y9v
9q9Lbgz9/L7Qceaf2Rb68K2b8+f17iXrLi0sn7250H3k5sK8337M5sJ820t3e2p74cJC86kNBnFR
e3GD4e0+QfEF44rfe1ddMK4Kfu99jf29d3E8jwXjurIF42S+9742XDCuFReMj4Np8gvGyz9p1sH/
pNma2yOqabcuuD2ywd4eEcfzSLtNZWk3me2RjWHabRTTrmfaPSft8H+uesNup5p2m4Ld7gq724nj
eaTdVWVpN5lud2WYdleKaTdn2sXodlc1djvNeLoqG8yacbLF7nbieB5pt60s7SbT7baGabdVTLsF
0y5Gt9vW2O00024LEMzPjJMddrcTx/NIu11laTeZbrczTLudYtotmXYxut1u6t1uBxDMz4yTAbvb
ieN5pN1QWdpNptsNhmk3KKbdimkXo9sNNXY74PAcCn7fbo/d7cTxPNJuX1naTabb7Q3Tbq+Ydmum
XYxut6+x2wGn3T7LecU42TXQ3U4ezyHtDoPUlXZT6XbnJ6Zs2u0axbTbMO1CdLvzS1Qt3U4xnrIX
AHknc5egu508nkfapcrSbird7vzEFE67pJh2V0y7EN3u/BLFbvfi8MxzXjNOWuxuJ47nkXY/rSzY
aTeZbvchT/Sladcqpt2WaRej27U1djvgtGvLfd9u12F3O3E8j7T7aWXBTrvJdLsPeaIvTbtOMe12
TLsY3a6rsdtpxlMHsOn6zDjpsbudOJ5H2vWVpd1kul1vmHa9YtoNTLsY3a5nt1MNz75gt5tjdztx
PI+0m1eWdpPpdnPDtJsrpt1+Gmn3q+PDPXjpn59U9D9/882XRwV9flTQm/nDo7Tnj3I+ynPJdeHB
nyTWb+/urmeNOOtX1zd/n/3pzebV9f2Pjx+205z5Zw7yNA//j1k7n4uzP0OfP07SZWfv/sfvDu/S
2SfbN7e3h+fx6QQK+rzGgg68ZJlfXqw994viGe/ep784jndqlBclC+wdAnE8jzXTorI102R2CBaG
a6aF3popPcYkAq+Z4u8QLGrcIdDMxwXA1v0z42SJvUMgjueRdsvK0m4yOwRLw7RbKqZdYtrFKJdV
QqOaaZfLoMBphw2NyuN5pB2hUdBuZwiN7hSh0URoNEi3o5KoG54FlcQdtpIoj+eRdlQSQbudoZK4
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
rZzCCgA=
------=_20140117000935_32370
Content-Type: text/plain; name="records.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="records.txt"

Service Name: Wireless Controller
Service Description: Game Controller
Service Provider: Sony Computer Entertainment
Service RecHandle: 0x10001
Service Class ID List:
  "Human Interface Device" (0x1124)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 17
  "HIDP" (0x0011)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Human Interface Device" (0x1124)
    Version: 0x0100

Service RecHandle: 0x10002
Service Class ID List:
  "PnP Information" (0x1200)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 1
  "SDP" (0x0001)
Profile Descriptor List:
  "PnP Information" (0x1200)
    Version: 0x0103
------=_20140117000935_32370
Content-Type: text/plain; name="records_raw.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="records_raw.txt"

U2VxdWVuY2UKCUF0dHJpYnV0ZSAweDAwMDAgLSBTZXJ2aWNlUmVjb3JkSGFuZGxlCgkJVUlOVDMy
IDB4MDAwMTAwMDEKCUF0dHJpYnV0ZSAweDAwMDEgLSBTZXJ2aWNlQ2xhc3NJRExpc3QKCQlTZXF1
ZW5jZQoJCQlVVUlEMTYgMHgxMTI0IC0gSHVtYW5JbnRlcmZhY2VEZXZpY2VTZXJ2aWNlIChISUQp
CglBdHRyaWJ1dGUgMHgwMDA0IC0gUHJvdG9jb2xEZXNjcmlwdG9yTGlzdAoJCVNlcXVlbmNlCgkJ
CVNlcXVlbmNlCgkJCQlVVUlEMTYgMHgwMTAwIC0gTDJDQVAKCQkJCVVJTlQxNiAweDAwMTEKCQkJ
U2VxdWVuY2UKCQkJCVVVSUQxNiAweDAwMTEgLSBISURQCglBdHRyaWJ1dGUgMHgwMDA2IC0gTGFu
Z3VhZ2VCYXNlQXR0cmlidXRlSURMaXN0CgkJU2VxdWVuY2UKCQkJVUlOVDE2IDB4NjU2ZQoJCQlV
SU5UMTYgMHgwMDZhCgkJCVVJTlQxNiAweDAxMDAKCUF0dHJpYnV0ZSAweDAwMDkgLSBCbHVldG9v
dGhQcm9maWxlRGVzY3JpcHRvckxpc3QKCQlTZXF1ZW5jZQoJCQlTZXF1ZW5jZQoJCQkJVVVJRDE2
IDB4MTEyNCAtIEh1bWFuSW50ZXJmYWNlRGV2aWNlU2VydmljZSAoSElEKQoJCQkJVUlOVDE2IDB4
MDEwMAoJQXR0cmlidXRlIDB4MDAwZCAtIEFkZGl0aW9uYWxQcm90b2NvbERlc2NyaXB0b3JMaXN0
cwoJCVNlcXVlbmNlCgkJCVNlcXVlbmNlCgkJCQlTZXF1ZW5jZQoJCQkJCVVVSUQxNiAweDAxMDAg
LSBMMkNBUAoJCQkJCVVJTlQxNiAweDAwMTMKCQkJCVNlcXVlbmNlCgkJCQkJVVVJRDE2IDB4MDAx
MSAtIEhJRFAKCUF0dHJpYnV0ZSAweDAxMDAKCQlTdHJpbmcgV2lyZWxlc3MgQ29udHJvbGxlcgAK
CUF0dHJpYnV0ZSAweDAxMDEKCQlTdHJpbmcgR2FtZSBDb250cm9sbGVyAAoJQXR0cmlidXRlIDB4
MDEwMgoJCVN0cmluZyBTb255IENvbXB1dGVyIEVudGVydGFpbm1lbnQACglBdHRyaWJ1dGUgMHgw
MjAwCgkJVUlOVDE2IDB4MDEwMAoJQXR0cmlidXRlIDB4MDIwMQoJCVVJTlQxNiAweDAxMTEKCUF0
dHJpYnV0ZSAweDAyMDIKCQlVSU5UOCAweDA4CglBdHRyaWJ1dGUgMHgwMjAzCgkJVUlOVDggMHgw
MAoJQXR0cmlidXRlIDB4MDIwNAoJCUJvb2wgRmFsc2UKCUF0dHJpYnV0ZSAweDAyMDUKCQlCb29s
IFRydWUKCUF0dHJpYnV0ZSAweDAyMDYKCQlTZXF1ZW5jZQoJCQlTZXF1ZW5jZQoJCQkJVUlOVDgg
MHgyMgoJCQkJRGF0YSAwNSAwMSAwOSAwNSBhMSAwMSA4NSAwMSAwOSAzMCAwOSAzMSAwOSAzMiAw
OSAzNSAxNSAwMCAyNiBmZiAwMCA3NSAwOCA5NSAwNCA4MSAwMiAwOSAzOSAxNSAwMCAyNSAwNyA3
NSAwNCA5NSAwMSA4MSA0MiAwNSAwOSAxOSAwMSAyOSAwZSAxNSAwMCAyNSAwMSA3NSAwMSA5NSAw
ZSA4MSAwMiA3NSAwNiA5NSAwMSA4MSAwMSAwNSAwMSAwOSAzMyAwOSAzNCAxNSAwMCAyNiBmZiAw
MCA3NSAwOCA5NSAwMiA4MSAwMiAwNiAwNCBmZiA4NSAwMiAwOSAyNCA5NSAyNCBiMSAwMiA4NSBh
MyAwOSAyNSA5NSAzMCBiMSAwMiA4NSAwNSAwOSAyNiA5NSAyOCBiMSAwMiA4NSAwNiAwOSAyNyA5
NSAzNCBiMSAwMiA4NSAwNyAwOSAyOCA5NSAzMCBiMSAwMiA4NSAwOCAwOSAyOSA5NSAyZiBiMSAw
MiAwNiAwMyBmZiA4NSAwMyAwOSAyMSA5NSAyNiBiMSAwMiA4NSAwNCAwOSAyMiA5NSAyZSBiMSAw
MiA4NSBmMCAwOSA0NyA5NSAzZiBiMSAwMiA4NSBmMSAwOSA0OCA5NSAzZiBiMSAwMiA4NSBmMiAw
OSA0OSA5NSAwZiBiMSAwMiAwNiAwMCBmZiA4NSAxMSAwOSAyMCAxNSAwMCAyNiBmZiAwMCA3NSAw
OCA5NSA0ZCA4MSAwMiAwOSAyMSA5MSAwMiA4NSAxMiAwOSAyMiA5NSA4ZCA4MSAwMiAwOSAyMyA5
MSAwMiA4NSAxMyAwOSAyNCA5NSBjZCA4MSAwMiAwOSAyNSA5MSAwMiA4NSAxNCAwOSAyNiA5NiAw
ZCAwMSA4MSAwMiAwOSAyNyA5MSAwMiA4NSAxNSAwOSAyOCA5NiA0ZCAwMSA4MSAwMiAwOSAyOSA5
MSAwMiA4NSAxNiAwOSAyYSA5NiA4ZCAwMSA4MSAwMiAwOSAyYiA5MSAwMiA4NSAxNyAwOSAyYyA5
NiBjZCAwMSA4MSAwMiAwOSAyZCA5MSAwMiA4NSAxOCAwOSAyZSA5NiAwZCAwMiA4MSAwMiAwOSAy
ZiA5MSAwMiA4NSAxOSAwOSAzMCA5NiAyMiAwMiA4MSAwMiAwOSAzMSA5MSAwMiAwNiA4MCBmZiA4
NSA4MiAwOSAyMiA5NSAzZiBiMSAwMiA4NSA4MyAwOSAyMyBiMSAwMiA4NSA4NCAwOSAyNCBiMSAw
MiA4NSA5MCAwOSAzMCBiMSAwMiA4NSA5MSAwOSAzMSBiMSAwMiA4NSA5MiAwOSAzMiBiMSAwMiA4
NSA5MyAwOSAzMyBiMSAwMiA4NSBhMCAwOSA0MCBiMSAwMiA4NSBhNCAwOSA0NCBiMSAwMiBjMCAw
MApTZXF1ZW5jZQoJQXR0cmlidXRlIDB4MDAwMCAtIFNlcnZpY2VSZWNvcmRIYW5kbGUKCQlVSU5U
MzIgMHgwMDAxMDAwMgoJQXR0cmlidXRlIDB4MDAwMSAtIFNlcnZpY2VDbGFzc0lETGlzdAoJCVNl
cXVlbmNlCgkJCVVVSUQxNiAweDEyMDAgLSBQblBJbmZvcm1hdGlvbgoJQXR0cmlidXRlIDB4MDAw
NCAtIFByb3RvY29sRGVzY3JpcHRvckxpc3QKCQlTZXF1ZW5jZQoJCQlTZXF1ZW5jZQoJCQkJVVVJ
RDE2IDB4MDEwMCAtIEwyQ0FQCgkJCQlVSU5UMTYgMHgwMDAxCgkJCVNlcXVlbmNlCgkJCQlVVUlE
MTYgMHgwMDAxIC0gU0RQCglBdHRyaWJ1dGUgMHgwMDA5IC0gQmx1ZXRvb3RoUHJvZmlsZURlc2Ny
aXB0b3JMaXN0CgkJU2VxdWVuY2UKCQkJU2VxdWVuY2UKCQkJCVVVSUQxNiAweDEyMDAgLSBQblBJ
bmZvcm1hdGlvbgoJCQkJVUlOVDE2IDB4MDEwMwoJQXR0cmlidXRlIDB4MDIwMAoJCVVJTlQxNiAw
eDAxMDMKCUF0dHJpYnV0ZSAweDAyMDEKCQlVSU5UMTYgMHgwNTRjCglBdHRyaWJ1dGUgMHgwMjAy
CgkJVUlOVDE2IDB4MDVjNAoJQXR0cmlidXRlIDB4MDIwMwoJCVVJTlQxNiAweDAxMDAKCUF0dHJp
YnV0ZSAweDAyMDQKCQlCb29sIFRydWUKCUF0dHJpYnV0ZSAweDAyMDUKCQlVSU5UMTYgMHgwMDAy
Cg==
------=_20140117000935_32370
Content-Type: text/plain; name="connect_ds4_fedora_4.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="connect_ds4_fedora_4.txt"

HCI sniffer - Bluetooth packet analyzer ver 5.12
device: hci0 snap_len: 1500 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 1C:66:6D:07:C3:E0 class 0x002508 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 1C:66:6D:07:C3:E0 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 1C:66:6D:07:C3:E0 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 1C:66:6D:07:C3:E0 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 41
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 1C:66:6D:07:C3:E0 mode 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 41
    Features: 0xff 0xfe 0x0d 0xfe 0x98 0x7f 0x79 0x87
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 1C:66:6D:07:C3:E0 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 672 
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672 
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-16 0x0100 (L2CAP)
          max 2048
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 41 flags 0x02 dlen 192
< ACL data: handle 41 flags 0x01 dlen 192
< ACL data: handle 41 flags 0x01 dlen 93
    L2CAP(d): cid 0x0040 len 473 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x1d4
          count 465
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10001
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1800 >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x1f > <
                 uuid-16 0x0007 uint 0x1 uint 0x8 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x000a (DocURL)
                 url "http://www.bluez.org/"
              aid 0x000b (ClientExeURL)
                 url "http://www.bluez.org/"
              aid 0x000c (IconURL)
                 url "http://www.bluez.org/"
              aid 0x0100 (SrvName)
                 str "Generic Access Profile"
              aid 0x0102 (ProviderName)
                 str "BlueZ"
          record #1
              aid 0x0000 (SrvRecHndl)
                 uint 0x10002
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1801 >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x1f > <
                 uuid-16 0x0007 uint 0x10 uint 0x10 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0100 (SrvName)
                 str "Generic Attribute Profile"
              aid 0x0102 (ProviderName)
                 str "BlueZ"
          record #2
              aid 0x0000 (SrvRecHndl)
                 uint 0x10003
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110e (AVRemote) uuid-16 0x110f (AVRemCt) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                 uuid-16 0x0017 (AVCTP) uint 0x103 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110e (AVRemote) uint 0x105 > >
              aid 0x000d (AdditionalProtocolDescLists)
                 < < < uuid-16 0x0100 (L2CAP) uint 0x1b > < uuid-16 0x0017 (AVCTP) uint 0x103 > > >
              aid 0x0100 (SrvName)
                 str "AVRCP CT"
              aid 0x0311 (SuppFeatures)
                 uint 0x4f
          record #3
              aid 0x0000 (SrvRecHndl)
                 uint 0x10004
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110c (AVRemTarget) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                 uuid-16 0x0017 (AVCTP) uint 0x103 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110e (AVRemote) uint 0x104 > >
              aid 0x000d (AdditionalProtocolDescLists)
                 < < < uuid-16 0x0100 (L2CAP) uint 0x1b > < uuid-16 0x0017 (AVCTP) uint 0x103 > > >
              aid 0x0100 (SrvName)
                 str "AVRCP TG"
              aid 0x0311 (SuppFeatures)
                 uint 0x5f
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 2
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 1C:66:6D:07:C3:E0 name 'Wireless Controller'
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 1C:66:6D:07:C3:E0
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 1C:66:6D:07:C3:E0 key DCD82F85FA8F56D21A7AFBF7B227F7E9
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 1C:66:6D:07:C3:E0
> HCI Event: Encrypt Change (0x08) plen 4	<=============================
    status 0x00 handle 41 encrypt 0x01
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0041
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 672 
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 672 
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 41 flags 0x02 dlen 5
    L2CAP(d): cid 0x0041 len 1 [psm 17]
      HIDP: Control: Virtual cable unplug		<======================
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0042
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 1 status 2
      Connection pending - Authorization pending	<======================
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 3 status 0
      Connection refused - security block		<=====================
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 5
    L2CAP(d): cid 0x0040 len 1 [psm 17]			<====================
      HIDP: Handshake: Unsupported request
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x13
    Reason: Remote User Terminated Connection		<====================
------=_20140117000935_32370
Content-Type: application/octet-stream; name="info"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="info"

W0dlbmVyYWxdCk5hbWU9CkNsYXNzPTB4MDAyNTA4ClN1cHBvcnRlZFRlY2hub2xvZ2llcz1CUi9F
RFIKVHJ1c3RlZD1mYWxzZQpCbG9ja2VkPWZhbHNlCgpbTGlua0tleV0KS2V5PTB4RENEODJGODVG
QThGNTZEMjFBN0FGQkY3QjIyN0Y3RTkKVHlwZT0wClBJTkxlbmd0aD00Cg==
------=_20140117000935_32370--


