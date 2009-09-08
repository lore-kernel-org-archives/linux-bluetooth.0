Return-Path: <cyrus@holtmann.org>
Message-ID: <4AA6C556.9050804@charter.net>
Date: Tue, 08 Sep 2009 16:57:58 -0400
From: Peter Hurley <phurley@charter.net>
MIME-Version: 1.0
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Fix for audio stream XCASE connect:connect failures
Content-Type: multipart/mixed;
 boundary="------------040500020902030809010804"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040500020902030809010804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

For several days now, I've been exploring what I felt was a race 
condition in audio/avdtp.c (many thanks to Johan for some helpful 
guidance).  The behavior I was observing was that AVDTP connections were 
erroring out when the headset device (Motorola S9) was powering on. The 
following is a typical error log of was I was observing:

Sep  4 07:30:05 dev-wkstn bluetoothd[2713]: State changed 
/org/bluez/2713/hci0/dev_00_0D_FD_1E_99_30: 
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: avdtp_ref(0x7fd0c11c9f50): 
ref=2
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: avdtp_ref(0x7fd0c11c9f50): 
ref=3
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: avdtp_unref(0x7fd0c11c9f50): 
ref=2
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: Received AT+CKPD=200
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: telephony-dummy: got key 
press request for 200
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: AVDTP: incoming connect from 
00:0D:FD:1E:99:30
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: AVDTP: connected signaling 
channel to 00:0D:FD:1E:99:30
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: AVDTP imtu=672, omtu=895
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: send: Transport endpoint is 
not connected (107)
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: session_cb
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: Received DISCOVER_CMD
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: send: Transport endpoint is 
not connected (107)
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: Unable to handle command. 
Disconnecting
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: Disconnected from 
00:0D:FD:1E:99:30
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: avdtp_unref(0x7fd0c11c9f50): 
ref=1
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: connect:connect XCASE detected
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: avdtp_unref(0x7fd0c11c9f50): 
ref=0
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: avdtp_unref(0x7fd0c11c9f50): 
freeing session and removing from list
Sep  4 07:30:09 dev-wkstn bluetoothd[2713]: Stream setup failed, after 
XCASE connect:connect

Note the "Transport endpoint is not connected (107)" errors.  Until I 
more fully understood the architecture, I did not understand that those 
errors were related to the "connect:connect XCASE detected" and "Stream 
setup failed, after XCASE connect:connect" messages.  Now that I do 
understand, I thought I'd share what I learned and a suggested patch to 
resolve the problem.  (I'm sure I'm rediscovering what others already 
know but I could find no reference to it in the mail archive).

The short version of the problem is that it is possible for a device to 
initiate an l2cap channel for the avdtp 'signalling' channel even though 
a host-initiated avdtp connection is already pending with that device.  
In the hcidump capture below, the first packet is the Connect initiated 
from the host side.  The 4th packet shows the device initiating it's own 
connection (even though it has already acknowledged a pending 
'signalling' channel connection from the host).  (Per the AVDTP spec, 
the 'signalling' channel is simply the 1st avdtp channel created when 
none exist.)

2009-09-04 22:32:09.000236 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0041
2009-09-04 22:32:09.018962 > HCI Event: Number of Completed Packets 
(0x13) plen 5
    handle 11 packets 2
2009-09-04 22:32:09.024959 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x005d scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
2009-09-04 22:32:09.226945 > ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x005e
2009-09-04 22:32:09.227002 < ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x005e result 1 status 2
      Connection pending - Authorization pending
2009-09-04 22:32:09.282939 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x005d scid 0x0041 result 0 status 0
      Connection successful
2009-09-04 22:32:09.282980 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x005d flags 0x00 clen 0
2009-09-04 22:32:09.292932 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 895
2009-09-04 22:32:09.292976 < ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x005d flags 0x00 result 0 clen 4
      MTU 895
2009-09-04 22:32:09.293932 > HCI Event: Number of Completed Packets 
(0x13) plen 5
    handle 11 packets 2
2009-09-04 22:32:09.338933 > ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
2009-09-04 22:32:09.387923 > ACL data: handle 11 flags 0x02 dlen 6
    L2CAP(d): cid 0x0041 len 2 [psm 25]
      AVDTP(s): Discover cmd: transaction 2

Since the kernel l2cap driver has limited knowledge of avdtp protocol, 
it continues to handle the l2cap channel configuration ultimately 
resulting in 2 'signalling' channels being created (behavior which is 
outside the AVDTP spec).  This situation also confuses the software 
state machine in audio/avdtp.c because it does not account for 2 
signalling channels (nor should it).

Possible solutions to this situation (perhaps not exhaustive) include:
1)  Reject incoming avdtp connection attempt from device when outgoing 
connection request is pending.
2)  Give priority to device-initiated connection, killing outgoing 
connection request.
3)  Move knowledge of avdtp into l2cap kernel driver (or make separate 
avdtp kernel driver).
4)  Lengthen timer setup in device.c to give devices more time to 
initiate an avdtp connection.

I discarded option 4 as not solving the problem, but simply avoiding 
it.  Option 3 seems like taking an architectural step backwards (not to 
mention how significant the effort would be).  Initially, I tried option 
2 by state-checking and parameter-testing avdtp_connect_cb().  I had 
this working to a certain extent but ultimately option 1 proved to be a 
much cleaner implementation.

Patch for option 1 is attached.  Here's an excerpt from the daemon.log 
when this patch works (note the 'connect already in progress' message).

Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: AVDTP: incoming connect from 
00:0D:FD:1E:99:30
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: avdtp_confirm_cb: connect 
already in progress (XCASE connect:connect)
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: AVDTP: connected signaling 
channel to 00:0D:FD:1E:99:30
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: AVDTP imtu=672, omtu=895
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: AVCTP Connecting
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: session_cb
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: DISCOVER request succeeded
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: seid 1 type 1 media 0 in use 0
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: seid 2 type 1 media 0 in use 0
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: session_cb
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: GET_CAPABILITIES request 
succeeded
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: seid 1 type 1 media 0
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: session_cb
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: GET_CAPABILITIES request 
succeeded
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: seid 2 type 1 media 0
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: Discovery complete
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: a2dp_config: selected SEP 
0x7f89d7a8d190
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: avdtp_ref(0x7f89d7a86c30): ref=3
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: setup_ref(0x7f89d7a94a40): ref=1
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: 
avdtp_set_configuration(0x7f89d7a86c30): int_seid=1, acp_seid=1
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: session_cb
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: SET_CONFIGURATION request 
succeeded
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: Source 0x7f89d7a8d190: 
Set_Configuration_Cfm
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: stream state changed: IDLE 
-> CONFIGURED
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: session_cb
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: OPEN request succeeded
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: AVCTP: connected to 
00:0D:FD:1E:99:30
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: Can't open input device: No 
such file or directory (2)
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: AVRCP: failed to init uinput 
for 00:0D:FD:1E:99:30
Sep  8 15:25:03 dev-wkstn bluetoothd[2676]: AVCTP Connected
Sep  8 15:25:04 dev-wkstn bluetoothd[2676]: AVDTP: connected transport 
channel to 00:0D:FD:1E:99:30
Sep  8 15:25:04 dev-wkstn bluetoothd[2676]: Source 0x7f89d7a8d190: Open_Cfm
Sep  8 15:25:04 dev-wkstn bluetoothd[2676]: setup_ref(0x7f89d7a94a40): ref=2
Sep  8 15:25:04 dev-wkstn bluetoothd[2676]: Stream successfully created

Comments?

Regards,
Peter Hurley

Also, I have prepared a more extensive source code analysis which is 
more complicated if anyone would prefer that.

--------------040500020902030809010804
Content-Type: text/x-patch;
 name="xcase.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xcase.diff"

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 131ff4f..d97aff2 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -2119,6 +2119,16 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 	if (!session)
 		goto drop;
 
+	// This state (ie, session is already *connecting*) happens when the device
+	//  initiates a connect (really a config'd L2CAP channel) even though
+	//  there is a connect we initiated in progress.  In sink.c & source.c,
+	//  this state is referred to as XCASE connect:connect.
+	// Abort the device's channel in favor of our own.
+	if (session->state == AVDTP_SESSION_STATE_CONNECTING) {
+		debug("avdtp_confirm_cb: connect already in progress (XCASE connect:connect)");
+		goto drop;
+	}
+
 	if (session->pending_open && session->pending_open->open_acp) {
 		if (!bt_io_accept(chan, avdtp_connect_cb, session, NULL, NULL))
 			goto drop;

--------------040500020902030809010804--
