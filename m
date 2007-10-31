Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 31 Oct 2007 13:45:12 -0400
From: billy leung <vientito1@pppoe.ca>
To: bluez-users@lists.sourceforge.net
Message-Id: <20071031134512.45b2d41a.vientito1@pppoe.ca>
Mime-Version: 1.0
Subject: [Bluez-users] here's the log i retrieve for Error 22
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

HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:F2:30:25 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr 00:13:17:F2:30:25 type ACL encrypt 0x00
< ACL data: handle 12 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 12 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 12
    Features: 0xff 0xff 0x8b 0x78 0x18 0x18 0x00 0x80
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 12
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:13:17:F2:30:25 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x00b8 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x00b8 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x00b8 flags 0x00 clen 0
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:13:17:F2:30:25 name 'Nokia BH-600'
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x00b8 flags 0x00 result 0 clen 4
      Success
      MTU 48
< ACL data: handle 12 flags 0x02 dlen 17
    L2CAP(d): cid 0x00b8 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1108 (Headset)
          max 64
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 4
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SS Rsp: tid 0x0 len 0x5
          count 0
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x00b8 scid 0x0040
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x00b8 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 12 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 12 reason 0x16
    Reason: Connection Terminated by Local Host


----------------------------------------------------------------------------------

syslog shows this:

 Bluetooth Audio daemon
Oct 31 13:38:06 billy audio[15847]: /etc/bluetooth/audio.conf: /etc/bluetooth/audio.conf: key Enable not found
Oct 31 13:38:06 billy audio[15847]: /etc/bluetooth/audio.conf: /etc/bluetooth/audio.conf: key Disable not found
Oct 31 13:38:06 billy audio[15847]: /etc/bluetooth/audio.conf: /etc/bluetooth/audio.conf: group A2DP not found
Oct 31 13:38:06 billy audio[15847]: Config options: DisableHFP=true, SCORouting=PCM, SourceCount=1
Oct 31 13:38:06 billy audio[15847]: Unix socket created: 5
Oct 31 13:38:06 billy audio[15847]: add_service_record: got record id 0x10000
Oct 31 13:38:06 billy audio[15847]: add_service_record: got record id 0x10001
Oct 31 13:38:06 billy audio[15847]: Registered manager path:/org/bluez/audio
Oct 31 13:38:06 billy audio[15847]: Loading device 00:13:17:F2:30:25 (headset )
Oct 31 13:38:06 billy audio[15847]: Got path /org/bluez/hci0 for adapter with address 00:02:72:02:3F:9E
Oct 31 13:38:06 billy audio[15847]: Selecting default device
Oct 31 13:38:06 billy audio[15847]: Setting 00:13:17:F2:30:25 as default device
Oct 31 13:39:08 billy audio[15847]: Accepted new client connection on unix socket (fd=8)
Oct 31 13:39:08 billy audio[15847]: Package PKT_TYPE_CFG_REQ:0
Oct 31 13:39:08 billy audio[15847]: State changed /org/bluez/audio/device0: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
Oct 31 13:39:11 billy audio[15847]: get_handles_reply: Unable to get handle array from reply
Oct 31 13:39:11 billy audio[15847]: State changed /org/bluez/audio/device0: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
Oct 31 13:39:11 billy audio[15847]: Unix client disconnected (fd=8)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
