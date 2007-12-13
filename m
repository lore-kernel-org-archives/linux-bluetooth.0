Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 13 Dec 2007 22:08:38 +0000
From: junkmail <junkmail@lone.ath.cx>
To: bluez-users@lists.sourceforge.net
Message-ID: <86bf561b7b05bf3e2ae4fd37897f8800@hyelucene.com>
Subject: [Bluez-users] Problem with pairing.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I have been struggling for a few days trying to get a Motorolla H350 to
pair with my laptop.  I have an IBM thinkpad T41 running Gentoo.  I have
had the device pair with my laptop once.  Using bluez-utils and libs
version 3.22, with kernel 2.6.22.  I have and am able to pair this device
with another laptop and IBM T60 also running Gentoo and the same version of
tools/kernel.  

Here is the info about the controller.

laptop ~ # hciconfig -a hci0 version
hci0:   Type: USB
        BD Address: 00:20:E0:75:C5:B6 ACL MTU: 192:8 SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1 (0x1) LMP Subver:
0x222
        Manufacturer: Cambridge Silicon Radio (10)
laptop ~ # hciconfig -a hci0 revision
hci0:   Type: USB
        BD Address: 00:20:E0:75:C5:B6 ACL MTU: 192:8 SCO MTU: 64:8
        Build 546
        Chip version: BlueCore02-External
        Max key size: 128 bit
        SCO mapping:  HCI

My problem is that I am always getting Connection refused now.  I will past
log output here along with a hcidump output:

Here is the log after starting.
Dec 13 21:59:22 laptop hcid[22211]: Bluetooth HCI daemon
Dec 13 21:59:22 laptop hcid[22211]: Enabling debug information
Dec 13 21:59:22 laptop hcid[22211]: HCI dev 0 registered
Dec 13 21:59:22 laptop hcid[22211]: HCI dev 0 already up
Dec 13 21:59:22 laptop hcid[22211]: Device hci0 has been added
Dec 13 21:59:22 laptop hcid[22211]: Starting security manager 0
Dec 13 21:59:22 laptop hcid[22211]: Device hci0 has been activated
Dec 13 21:59:22 laptop hcid[22211]: Starting SDP server
Dec 13 21:59:22 laptop hcid[22211]: Adding rec : 0x8087de0
Dec 13 21:59:22 laptop hcid[22211]: with handle : 0x1
Dec 13 21:59:22 laptop hcid[22211]: Adding rec : 0x8087f58
Dec 13 21:59:22 laptop hcid[22211]: with handle : 0x0
Dec 13 21:59:22 laptop hcid[22211]: Service classes 0x00
Dec 13 21:59:22 laptop hcid[22211]: Created local server at
unix:abstract=/var/run/dbus-aECABHr2ol,guid=2f2bcafcd43286a5e1d063004761ab3a
Dec 13 21:59:22 laptop hcid[22211]: Registering service object:
ident=audio, name=Audio service (/org/bluez/service_audio)
Dec 13 21:59:22 laptop audio[22217]: Bluetooth Audio daemon
Dec 13 21:59:22 laptop audio[22217]: Parsing /etc/bluetooth/audio.conf
failed: No such file or directory
Dec 13 21:59:22 laptop audio[22217]: Unix socket created: 5
Dec 13 21:59:22 laptop hcid[22211]:
/usr/lib/bluetooth/bluetoothd-service-audio executed with PID 22217
Dec 13 21:59:22 laptop hcid[22211]: Registering service object:
ident=input, name=Input service (/org/bluez/service_input)
Dec 13 21:59:22 laptop input[22218]: Bluetooth Input daemon
Dec 13 21:59:22 laptop input[22218]: Registered input manager
path:/org/bluez/input
Dec 13 21:59:22 laptop hcid[22211]:
/usr/lib/bluetooth/bluetoothd-service-input executed with PID 22218
Dec 13 21:59:22 laptop hcid[22211]: Registering service object:
ident=network, name=Network service (/org/bluez/service_network)
Dec 13 21:59:22 laptop hcid[22211]: Registering service object:
ident=serial, name=Serial service (/org/bluez/service_serial)
Dec 13 21:59:22 laptop hcid[22211]: child 22212 exited
Dec 13 21:59:22 laptop hcid[22211]: child 22213 exited
Dec 13 21:59:22 laptop hcid[22211]: Child PID 22217 got the unique bus name
:1.1
Dec 13 21:59:22 laptop hcid[22211]: name_listener_add(:1.1)
Dec 13 21:59:22 laptop hcid[22211]: /org/bluez:
org.bluez.Database.AddServiceRecord()
Dec 13 21:59:22 laptop hcid[22211]: Couldn't find record for : 0x10000
Dec 13 21:59:22 laptop hcid[22211]: Adding record with handle 0x10000
Dec 13 21:59:22 laptop hcid[22211]: Adding rec : 0x80816d0
Dec 13 21:59:22 laptop hcid[22211]: with handle : 0x10000
Dec 13 21:59:22 laptop hcid[22211]: Service classes 0x00
Dec 13 21:59:22 laptop hcid[22211]: Child PID 22218 got the unique bus name
:1.2
Dec 13 21:59:22 laptop hcid[22211]: name_listener_add(:1.2)
Dec 13 21:59:22 laptop audio[22217]: add_service_record: got record id
0x10000
Dec 13 21:59:22 laptop hcid[22211]: /org/bluez:
org.bluez.Database.AddServiceRecord()
Dec 13 21:59:22 laptop hcid[22211]: Couldn't find record for : 0x10001
Dec 13 21:59:22 laptop hcid[22211]: Adding record with handle 0x10001
Dec 13 21:59:22 laptop hcid[22211]: Adding rec : 0x8081e88
Dec 13 21:59:22 laptop hcid[22211]: with handle : 0x10001
Dec 13 21:59:22 laptop hcid[22211]: Service classes 0x08
Dec 13 21:59:22 laptop audio[22217]: add_service_record: got record id
0x10001
Dec 13 21:59:22 laptop audio[22217]: Registered manager
path:/org/bluez/audio
Dec 13 21:59:22 laptop audio[22217]: Loading device 00:1A:0E:4B:5E:16
(headset )
Dec 13 21:59:22 laptop hcid[22211]: /org/bluez:
org.bluez.Manager.FindAdapter()
Dec 13 21:59:22 laptop audio[22217]: Got path /org/bluez/hci0 for adapter
with address 00:20:E0:75:C5:B6
Dec 13 21:59:22 laptop hcid[22211]: /org/bluez/hci0:
org.bluez.Adapter.GetRemoteName()
Dec 13 21:59:22 laptop audio[22217]: Selecting default device

then I start passkey-agent 0000 00:1A:0E:4B:5E:16
then try to use the device with mplayer -ao alsa:device=bluetooth ...
Log output from here:
Dec 13 22:01:05 laptop hcid[22211]: /org/bluez/hci0:
org.bluez.Security.RegisterPasskeyAgent()
Dec 13 22:01:05 laptop hcid[22211]: name_listener_add(:1.3)

Dec 13 22:01:58 laptop audio[22217]: Accepted new client connection on unix
socket (fd=8)
Dec 13 22:01:58 laptop audio[22217]: Package PKT_TYPE_CFG_REQ:0
Dec 13 22:01:58 laptop audio[22217]: State changed
/org/bluez/audio/device0: HEADSET_STATE_DISCONNECTED ->
HEADSET_STATE_CONNECT_IN_PROGRESS
Dec 13 22:01:58 laptop hcid[22211]: /org/bluez/hci0:
org.bluez.Adapter.GetRemoteServiceHandles()
Dec 13 22:01:58 laptop hcid[22211]: no matching session found. creating a
new one
Dec 13 22:01:59 laptop hcid[22211]: sdp session added to cache
Dec 13 22:01:59 laptop hcid[22211]: /org/bluez/hci0:
org.bluez.Adapter.GetRemoteServiceRecord()
Dec 13 22:01:59 laptop hcid[22211]: found matching session, removing from
list
Dec 13 22:01:59 laptop hcid[22211]: sdp session added to cache
Dec 13 22:01:59 laptop audio[22217]: /org/bluez/audio/device0: Connecting
to 00:1A:0E:4B:5E:16 channel 2
Dec 13 22:01:59 laptop hcid[22211]: /org/bluez/hci0:
org.bluez.Adapter.FinishRemoteServiceTransaction()
Dec 13 22:01:59 laptop hcid[22211]: found matching session, removing from
list
Dec 13 22:01:59 laptop hcid[22211]: link_key_request
(sba=00:20:E0:75:C5:B6, dba=00:1A:0E:4B:5E:16)
Dec 13 22:01:59 laptop audio[22217]: connect(): Connection refused (111)
Dec 13 22:01:59 laptop audio[22217]: State changed
/org/bluez/audio/device0: HEADSET_STATE_CONNECT_IN_PROGRESS ->
HEADSET_STATE_DISCONNECTED
Dec 13 22:01:59 laptop audio[22217]: Unix client disconnected (fd=8)
Dec 13 22:02:00 laptop hcid[22211]: Releasing agent :1.3,
/org/bluez/passkey_agent_24107
Dec 13 22:02:00 laptop hcid[22211]: name_listener_remove(:1.3)

Passkey-agent exists saying this:
Passkey service has been released

Output from hcidump:

laptop services # hcidump -X
HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 16 5e 4b 0e 1a 00 18 cc  02 00 00 00 01           .^K..........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 29 00 16 5e 4b 0e 1a  00 01 00                 .)..^K.....
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
  0000: 29 00                                             ).
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 1b 04                                       ....
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 29 00 0f 00                                       )...
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: 16 5e 4b 0e 1a 00 01                              .^K....
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 29 00                                 ....).
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  0000: 16 5e 4b 0e 1a 00 02 00  00 00                    .^K.......
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 19 04                                       ....
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0105 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0105 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0105 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Read Remote Supported Features (0x0b) plen 11
  0000: 00 29 00 fc fe 0f 80 0b  e8 00 00                 .).........
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48 
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0105 flags 0x00 result 0 clen 4
      Success
      MTU 48 
< ACL data: handle 41 flags 0x02 dlen 17
    L2CAP(d): cid 0x0105 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1108 (Headset)
          max 64
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 1]
        SDP SS Rsp: tid 0x0 len 0x9
          count 1
          handle 0x10002
          cont 00
< ACL data: handle 41 flags 0x02 dlen 23
    L2CAP(d): cid 0x0105 len 19 [psm 1]
        SDP SA Req: tid 0x1 len 0xe
          handle 0x10002
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Remote Name Req Complete (0x07) plen 255
  0000: 00 16 5e 4b 0e 1a 00 4d  6f 74 6f 72 6f 6c 61 20  ..^K...Motorola 
  0010: 48 33 35 30 00 00 00 00  00 00 00 00 00 00 00 00  H350............
  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00     ...............
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 27
> ACL data: handle 41 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SA Rsp: tid 0x1 len 0x2b
          count 38
          cont 02 00 2D
< ACL data: handle 41 flags 0x02 dlen 25
    L2CAP(d): cid 0x0105 len 21 [psm 1]
        SDP SA Req: tid 0x2 len 0x10
          handle 0x10002
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 2D
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 27
> ACL data: handle 41 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SA Rsp: tid 0x2 len 0x2b
          count 38
          cont 02 00 07
< ACL data: handle 41 flags 0x02 dlen 25
    L2CAP(d): cid 0x0105 len 21 [psm 1]
        SDP SA Req: tid 0x3 len 0x10
          handle 0x10002
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 07
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SA Rsp: tid 0x3 len 0xa
          count 7
          aid 0x0000 (SrvRecHndl)
             uint 0x10002
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) >
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x2 > >
          aid 0x0006 (LangBaseAttrIDList)
             < uint 0x656e uint 0x6a uint 0x100 >
          aid 0x0009 (BTProfileDescList)
             < < uuid-16 0x1108 (Headset) uint 0x100 > >
          aid 0x0100 (SrvName)
             str "Headset"
          aid 0x0302 (unknown)
             bool 0x1
          cont 00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0105 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0106 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0105 scid 0x0040
> HCI Event: Link Key Request (0x17) plen 6
  0000: 16 5e 4b 0e 1a 00                                 .^K...
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 16 5e 4b 0e 1a 00 6e 27  10 8e ed c9 2f 3a 63 9e  .^K...n'..../:c.
  0010: 91 fa 39 5a f9 80                                 ..9Z..
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 16 5e 4b 0e  1a 00                    .....^K...
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 3 status 0
      Connection refused - security block
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 29 00 13     

So the two things I noticed is, one from the HCIdump "Connection refused -
security block"  not sure why but I would assume that the device thinks
I've sent an invalid passkey?   On the other computer that I use it uses
the same commands but works.
The other thing I notice is on startup
Dec 13 21:59:22 laptop audio[22217]: Loading device 00:1A:0E:4B:5E:16
(headset )
No matter if the device is on or not this message always shows up. I have
yet been unable to find where it's storing/caching this information so I
can clear it.  It seems odd to me.


Any direction would be greatly appreciated.

Thank you for your time.

-Rance




-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
