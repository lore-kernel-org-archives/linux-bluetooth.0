Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 19 Mar 2012 13:14:42 -0500
Message-ID: <CAB7rCThChsV7nAjw=6SZfFyxi5kYqpHxzUroqdvD_faqTGRzaw@mail.gmail.com>
Subject: pairing issues: PIN code negative reply: Device or resource busy
From: Mike <puffy.taco@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I occasionally have trouble pairing my phone with BlueZ running on an
embedded platform.  The issue I see is the line "PIN code negative
reply: Device or resource busy" in the debug output.  It looks like a
transaction with the agent is still ongoing while another one is
requested, which is apparently not allowed by the code.  I think the
issue is worse when I enable debug output from BlueZ, so I'm guessing
the issue could be timing dependent.  I've pasted both the debug
output as well as a hcidump.

Of note, my phone thinks it is paired with BlueZ, but I've removed the
pairing from BlueZ.  Not sure if this is making the code paths any
different than a clean pairing.

Any thoughts on how to get the agent freed up so I can get the pin
code processed?  The agent in this case only ever returns a static pin
code, so by and large, the separate agent is actually not needed in my
use case.

Thanks,
Mike


bluetoothd[599]: plugins/hciops.c:conn_complete() status 0x00
bluetoothd[599]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[599]: src/adapter.c:adapter_create_device() 00:17:E3:3B:4F:DD
bluetoothd[599]: src/device.c:device_create() Creating device
/org/bluez/599/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[599]: src/device.c:btd_device_ref() 0x2a0a9fb8: ref=1
bluetoothd[599]: src/device.c:device_set_temporary() temporary 1
bluetoothd[599]: plugins/hciops.c:remote_features_information() hci0 status 0
bluetoothd[599]: plugins/hciops.c:remote_name_information() hci0 status 0
bluetoothd[599]: audio/avdtp.c:avdtp_confirm_cb() AVDTP: incoming
connect from 00:17:E3:3B:4F:DD
bluetoothd[599]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[599]: src/device.c:btd_device_ref() 0x2a0a9fb8: ref=2
bluetoothd[599]: audio/device.c:audio_device_register() Registered
interface org.bluez.Audio on path
/org/bluez/599/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[599]: src/device.c:device_probe_drivers() Probing drivers
for 00:17:E3:3B:4F:DD
bluetoothd[599]: audio/manager.c:handle_uuid() server not enabled for
0000110d-0000-1000-8000-00805f9b34fb (0x110d)
bluetoothd[599]: src/agent.c:agent_authorize() authorize request was
sent for /org/bluez/599/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[599]: plugins/hciops.c:link_key_request() hci0 dba 00:17:E3:3B:4F:DD
bluetoothd[599]: plugins/hciops.c:get_auth_info() hci0 dba 00:17:E3:3B:4F:DD
bluetoothd[599]: plugins/hciops.c:link_key_request() kernel auth
requirements = 0x04
bluetoothd[599]: plugins/hciops.c:link_key_request() Matching key not found
bluetoothd[599]: plugins/hciops.c:pin_code_request() hci0 PIN request
for 00:17:E3:3B:4F:DD
bluetoothd[599]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[599]: src/device.c:device_request_authentication()
Requesting agent authentication for 00:17:E3:3B:4F:DD
bluetoothd[599]: Failed requesting authentication
bluetoothd[599]: PIN code negative reply: Device or resource busy
bluetoothd[599]: plugins/hciops.c:auth_complete() hci0 status 24
bluetoothd[599]: plugins/hciops.c:bonding_complete() status 0x18
bluetoothd[599]: src/device.c:device_bonding_complete() bonding (nil)
status 0x18
bluetoothd[599]: audio/avdtp.c:avdtp_connect_cb() AVDTP: connected
signaling channel to 00:17:E3:3B:4F:DD
bluetoothd[599]: audio/avdtp.c:avdtp_connect_cb() AVDTP imtu=672, omtu=0
bluetoothd[599]: audio/avdtp.c:session_cb()
bluetoothd[599]: audio/avdtp.c:connection_lost() Disconnected from
00:17:E3:3B:4F:DD
bluetoothd[599]: audio/avdtp.c:avdtp_unref() 0x2a0aa208: ref=0
bluetoothd[599]: audio/avdtp.c:avdtp_unref() 0x2a0aa208: freeing
session and removing from list
bq27200-battery 1-0055: error reading voltage
bluetoothd[599]: plugins/hciops.c:disconn_complete() handle 1 status 0x00
bluetoothd[599]: src/event.c:btd_event_disconn_complete()
bluetoothd[599]: src/adapter.c:adapter_remove_connection()
bluetoothd[599]: src/adapter.c:adapter_remove_connection() Removing
temporary device /org/bluez/599/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[599]: src/device.c:device_remove() Removing device
/org/bluez/599/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[599]: audio/unix.c:unix_device_removed()
unix_device_removed(0x2a0a9ee0)
bluetoothd[599]: src/device.c:btd_device_unref() 0x2a0a9fb8: ref=1
bluetoothd[599]: src/device.c:btd_device_unref() 0x2a0a9fb8: ref=0
bluetoothd[599]: src/device.c:device_free() 0x2a0a9fb8

> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:17:E3:3B:4F:DD class 0x5a2204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:17:E3:3B:4F:DD role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:17:E3:3B:4F:DD role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:17:E3:3B:4F:DD type ACL encrypt 0x00
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:17:E3:3B:4F:DD mode 1
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 1
    Features: 0xff 0xff 0x2d 0x78 0x18 0x18 0x00 0x80
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 2
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:17:E3:3B:4F:DD mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:17:E3:3B:4F:DD name 'Sparta'
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 1024
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 2
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 1 flags 0x02 dlen 37
    L2CAP(d): cid 0x0040 len 33 [psm 1]
        SDP SSA Req: tid 0x1 len 0x1c
          pat uuid-16 0x110b (AudioSink)
          max 128
          aid(s) 0x0000 (SrvRecHndl) 0x0001 (SrvClassIDList) 0x0002
(SrvRecState) 0x0006 (LangBaseAttrIDList) 0x0009 (BTProfileDescList)
0x0311 (SuppFeatures)
          cont 00
< ACL data: handle 1 flags 0x02 dlen 51
    L2CAP(d): cid 0x0040 len 47 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x2a
          count 39
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10001
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110b (AudioSink) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110d (AdvAudio) uint 0x102 > >
              aid 0x0311 (SuppFeatures)
                 uint 0xf
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 37
    L2CAP(d): cid 0x0040 len 33 [psm 1]
        SDP SSA Req: tid 0x7a5 len 0x1c
          pat uuid-16 0x111e (Handsfree)
          max 128
          aid(s) 0x0000 (SrvRecHndl) 0x0001 (SrvClassIDList) 0x0002
(SrvRecState) 0x0006 (LangBaseAttrIDList) 0x0009 (BTProfileDescList)
0x0311 (SuppFeatures)
          cont 00
< ACL data: handle 1 flags 0x02 dlen 48
    L2CAP(d): cid 0x0040 len 44 [psm 1]
        SDP SSA Rsp: tid 0x7a5 len 0x27
          count 36
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10000
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x111e (Handsfree) uuid-16 0x1203 (Audio) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x111e (Handsfree) uint 0x105 > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 37
    L2CAP(d): cid 0x0040 len 33 [psm 1]
        SDP SSA Req: tid 0x7a7 len 0x1c
          pat uuid-16 0x1108 (Headset)
          max 128
          aid(s) 0x0000 (SrvRecHndl) 0x0001 (SrvClassIDList) 0x0002
(SrvRecState) 0x0006 (LangBaseAttrIDList) 0x0009 (BTProfileDescList)
0x0311 (SuppFeatures)
          cont 00
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x7a7 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 21
    L2CAP(d): cid 0x0040 len 17 [psm 1]
        SDP SA Req: tid 0x7a9 len 0xc
          handle 0x10000
          max 128
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 1 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 1]
        SDP SA Rsp: tid 0x7a9 len 0x16
          count 19
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x7 > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 21
    L2CAP(d): cid 0x0040 len 17 [psm 1]
        SDP SA Req: tid 0x7ab len 0xc
          handle 0x10001
          max 128
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 1 flags 0x02 dlen 35
    L2CAP(d): cid 0x0040 len 31 [psm 1]
        SDP SA Rsp: tid 0x7ab len 0x1a
          count 23
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) uint 0x19 > <
             uuid-16 0x0019 (AVDTP) uint 0x102 > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 405
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0042
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 405
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1013
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0042 result 1 status 1
      Connection pending - Authentication pending
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 1
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:17:E3:3B:4F:DD
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 1013
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:17:E3:3B:4F:DD
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:17:E3:3B:4F:DD
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:17:E3:3B:4F:DD
> ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 14 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 400 max_retrans 0 credits 0
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 14 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 400 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 14 pf 1 ilen 0 fcs 0x6
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:17:E3:3B:4F:DD
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:17:E3:3B:4F:DD
> HCI Event: Auth Complete (0x06) plen 3
    status 0x18 handle 1
    Error: Pairing Not Allowed
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0042 result 3 status 0
      Connection refused - security block
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 14 pf 1 ilen 0 fcs 0x2c
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x13
    Reason: Remote User Terminated Connection
