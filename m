Return-Path: <cyrus@holtmann.org>
Message-ID: <492BB3F2.3050005@gmail.com>
Date: Tue, 25 Nov 2008 16:14:42 +0800
From: Sam Lin <itrs.lin@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: HBH-PV270 headset get locked
References: <492B7A98.90603@gmail.com>
In-Reply-To: <492B7A98.90603@gmail.com>
Content-Type: text/plain; charset=Big5
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I traced code and found in some case headset is not unlocked well.
for example when something goes wrong in headset_resume_complete(),
client->dev = NULL

so client_cb() will skip headset_unlock()

then headset will be locked forever until restart bluetoothd.

I have no idea what's the lock idea behind, BTW still unclear how the
problem happens to cause this.

Please help to provide idea.

log:

Nov 25 15:55:50 itrs-ubuntu bluetoothd[26202]: Accepted new client
connection on unix socket (fd=22)
Nov 25 15:55:50 itrs-ubuntu bluetoothd[26202]: Audio API: received
BT_GETCAPABILITIES_REQ
Nov 25 15:55:50 itrs-ubuntu bluetoothd[26202]: Audio API: sending
BT_GETCAPABILITIES_RSP
Nov 25 15:55:50 itrs-ubuntu bluetoothd[26202]: Audio API: received
BT_SETCONFIGURATION_REQ
Nov 25 15:55:50 itrs-ubuntu bluetoothd[26202]: config sco - device =
00:1E:DC:AB:6D:3F access_mode = 2
Nov 25 15:55:50 itrs-ubuntu bluetoothd[26202]:
/org/bluez/hci0/dev_00_1E_DC_AB_6D_3F: Connecting to 00:1E:DC:AB:6D:3F
channel 1
Nov 25 15:55:50 itrs-ubuntu bluetoothd[26202]: State changed
/org/bluez/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_DISCONNECTED ->
HEADSET_STATE_CONNECT_IN_PROGRESS
Nov 25 15:56:09 itrs-ubuntu bluetoothd[26202]:
/org/bluez/hci0/dev_00_1E_DC_AB_6D_3F: Connected to 00:1E:DC:AB:6D:3F
Nov 25 15:56:09 itrs-ubuntu bluetoothd[26202]: telephony-dummy: device
0xb8486ba8 connected
Nov 25 15:56:09 itrs-ubuntu bluetoothd[26202]: State changed
/org/bluez/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_CONNECT_IN_PROGRESS
-> HEADSET_STATE_CONNECTED
Nov 25 15:56:09 itrs-ubuntu bluetoothd[26202]: State changed
/org/bluez/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_CONNECTED ->
HEADSET_STATE_PLAY_IN_PROGRESS
Nov 25 15:56:12 itrs-ubuntu bluetoothd[26202]: connect(): Connection
refused (111)
Nov 25 15:56:12 itrs-ubuntu bluetoothd[26202]: headset_lock(before):
hs->lock:0, lock:2, state:3
Nov 25 15:56:12 itrs-ubuntu bluetoothd[26202]: headset_lock: pass lock check
Nov 25 15:56:12 itrs-ubuntu bluetoothd[26202]: headset_lock(after):
hs->lock:2, lock:2, state:3
Nov 25 15:56:12 itrs-ubuntu bluetoothd[26202]: Audio API: sending
BT_SETCONFIGURATION_RSP
Nov 25 15:56:12 itrs-ubuntu bluetoothd[26202]: State changed
/org/bluez/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_PLAY_IN_PROGRESS ->
HEADSET_STATE_CONNECTED
Nov 25 15:56:12 itrs-ubuntu bluetoothd[26202]: Audio API: received
BT_STREAMSTART_REQ
Nov 25 15:56:12 itrs-ubuntu bluetoothd[26202]: Audio API: sending
BT_STREAMSTART_RSP
Nov 25 15:56:12 itrs-ubuntu bluetoothd[26202]: Audio API: sending
BT_STREAMFD_IND
Nov 25 15:56:12 itrs-ubuntu bluetoothd[26202]: unix_sendmsg_fd: Bad file
descriptor(9)
Nov 25 15:56:12 itrs-ubuntu bluetoothd[26202]: resume failed
(headset_resume_complete)
Nov 25 15:56:12 itrs-ubuntu bluetoothd[26202]: Audio API: sending
BT_STREAMSTART_RSP
Nov 25 15:56:12 itrs-ubuntu bluetoothd[26202]: Unix client disconnected
(fd=22), type:1, dev:
Nov 25 15:56:17 itrs-ubuntu bluetoothd[26202]: Received AT+CLIP=1
Nov 25 15:56:17 itrs-ubuntu bluetoothd[26202]: Received AT+CSCS="UTF-8"
Nov 25 15:56:17 itrs-ubuntu bluetoothd[26202]: Badly formated or
unrecognized command: AT+CSCS="UTF-8"
Nov 25 15:56:17 itrs-ubuntu bluetoothd[26202]: Received
AT*SEAM="HBH-PV720",13
Nov 25 15:56:17 itrs-ubuntu bluetoothd[26202]: Badly formated or
unrecognized command: AT*SEAM="HBH-PV720",13
Nov 25 15:56:17 itrs-ubuntu bluetoothd[26202]: Received AT+CLAN?
Nov 25 15:56:17 itrs-ubuntu bluetoothd[26202]: Badly formated or
unrecognized command: AT+CLAN?
Nov 25 15:56:17 itrs-ubuntu bluetoothd[26202]: Received AT*EIPS=2,1
321,48 77%

......


Sam Lin

Sam Lin ´£¨ì:
> Hi All,
>
> I tried Sony Ericsson HBH-PV720 with aplay and found something wrong.
> Log as attachment.
>
> from first try (timestamp in log 11:24:23 - 11:24:31 ) it works fine.
> sound played.
>
> but since 2nd try (timestamp in log 11:25:21 - 11:25:26) SCO packets
> flow but no sound played.
> something outstanding is:
>
> Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: Unable to lock headset
> Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: config failed
>
> then headset works no more, SCO packets keep flow until powerdown headset.
>
> would you please give any hint on this ?
>
> Sam Lin
>
>   

