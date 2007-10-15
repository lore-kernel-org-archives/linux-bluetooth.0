Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <47136A32.5030409@stuart.es>
Date: Mon, 15 Oct 2007 15:25:06 +0200
From: Stuart Pook <bluez16t@stuart.es>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Plantronics Explorer 350 does not work with bluez 3.20
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

hi

Was anyone had any luck getting a Plantronics Explorer 350 Bluetooth 
headset working with bluez?  I'm using bluez-libs-3.20 & 
bluez-utils-3.20. My Plantronics M2500 Bluetooth headset works so I 
think that I have everything installed correctly. Trying to use the 
Explorer 350 gives me a "get_handles_reply: Unable to get handle array 
from reply" error from hcid.

I'm using an up to date Debian unstable system with bluez 3.20 installed 
in /usr/local/.

The Explorer 350 doesn't work.  When I try arecord & aplay I see

:; arecord -D E350 -f S16_LE  | aplay -D E350 -f S16_LE
ALSA lib pcm_bluetooth.c:1179:(bluetooth_cfg) Error 22 while configuring 
device
arecord: main:545: audio open error: Invalid argument
ALSA lib pcm_bluetooth.c:1179:(bluetooth_cfg) Error 22 while configuring 
device
aplay: main:545: audio open error: Invalid argument

and "hcid -s -x -n -d" says

audio[4593]: Accepted new client connection on unix socket (fd=8)
audio[4593]: Package PKT_TYPE_CFG_REQ:0
audio[4593]: State changed /org/bluez/audio/device2: DISCONNECTED -> 
CONNECTING
hcid[4589]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceHandles()
hcid[4589]: no matching session found. creating a new one
audio[4593]: Accepted new client connection on unix socket (fd=9)
audio[4593]: Package PKT_TYPE_CFG_REQ:0
hcid[4589]: sdp session added to cache
audio[4593]: get_handles_reply: Unable to get handle array from reply
audio[4593]: State changed /org/bluez/audio/device2: CONNECTING -> 
DISCONNECTED
audio[4593]: Unix client disconnected (fd=9)
audio[4593]: Unix client disconnected (fd=8)
hcid[4589]: sdp session timed out. closing

The M2500 works fine (though the "Protocol not available" messages are 
annoying)

:; arecord -D M2500 -f S16_LE | aplay -D M2500 -f S16_LE
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_bluetooth.c:417:(bluetooth_hsp_hw_params) Protocol not 
available (92)
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_bluetooth.c:417:(bluetooth_hsp_hw_params) Protocol not 
available (92)

I followed the instructions in 
http://wiki.bluez.org/wiki/HOWTO/AudioDevices so my ~/.asoundrc contains:

pcm.E350 {
         type bluetooth
         device "00:03:89:xx:xx:xx" # Explorer 350 by Plantronics
}
pcm.M2500 {
         type bluetooth
         device "00:03:89:xx:xx:xx" # M2500 by Plantronics
}

Here is what hcid says when used with my M2500 and then with my Explorer 
350:

: root@kooka; /usr/local/sbin/hcid -s -x -n -d
hcid[16785]: Bluetooth HCI daemon
hcid[16785]: Enabling debug information
hcid[16785]: HCI dev 0 registered
hcid[16785]: HCI dev 0 already up
hcid[16785]: Device hci0 has been added
hcid[16785]: Starting security manager 0
hcid[16785]: Device hci0 has been activated
hcid[16785]: Starting SDP server
hcid[16785]: Adding rec : 0x8083db8
hcid[16785]: with handle : 0x1
hcid[16785]: Adding rec : 0x8083f40
hcid[16785]: with handle : 0x0
hcid[16785]: Service classes 0x00
hcid[16785]: Created local server at 
unix:abstract=/var/run/dbus-ofgyCOZHOY,guid=e7f2dda9fe61f46c6dbbe300471368ae
hcid[16785]: Registering service object: ident=audio, name=Audio service 
(/org/bluez/service_audio)
audio[16788]: Bluetooth Audio daemon
audio[16788]: Config options: DisableHFP=true, SCORouting=HCI, SourceCount=2
hcid[16785]: /usr/local/lib/bluetooth/bluetoothd-service-audio executed 
with PID 16788
hcid[16785]: child 16786 exited
hcid[16785]: child 16787 exited
hcid[16785]: /org/bluez: org.bluez.Security.RegisterDefaultPasskeyAgent()
hcid[16785]: name_listener_add(:1.6)
hcid[16785]: Default passkey agent (:1.6, /org/bluez/passkey) registered
hcid[16785]: Child PID 16788 got the unique bus name :1.58
hcid[16785]: name_listener_add(:1.58)
hcid[16785]: /org/bluez: 
org.bluez.Security.RegisterDefaultAuthorizationAgent()
hcid[16785]: Default authorization agent (:1.6, /org/bluez/auth) registered
audio[16788]: Unix socket created: 5
hcid[16785]: /org/bluez: org.bluez.Database.AddServiceRecord()
hcid[16785]: Couldn't find record for : 0x10000
hcid[16785]: Adding record with handle 0x10000
hcid[16785]: Adding rec : 0x8085838
hcid[16785]: with handle : 0x10000
hcid[16785]: Service classes 0x00
audio[16788]: add_service_record: got record id 0x10000
hcid[16785]: /org/bluez: org.bluez.Database.AddServiceRecord()
hcid[16785]: Couldn't find record for : 0x10001
hcid[16785]: Adding record with handle 0x10001
hcid[16785]: Adding rec : 0x8084c38
hcid[16785]: with handle : 0x10001
hcid[16785]: Service classes 0x08
audio[16788]: add_service_record: got record id 0x10001
audio[16788]: Registered manager path:/org/bluez/audio
audio[16788]: Loading device 00:03:89:DC:FC:EC (headset )
hcid[16785]: /org/bluez: org.bluez.Manager.FindAdapter()
audio[16788]: Got path /org/bluez/hci0 for adapter with address 
00:0C:41:xx:xx:xx
audio[16788]: Selecting default device
audio[16788]: Loading device 00:03:89:B7:F8:D3 (headset )
hcid[16785]: /org/bluez: org.bluez.Manager.FindAdapter()
audio[16788]: Got path /org/bluez/hci0 for adapter with address 
00:0C:41:xx:xx:xx
audio[16788]: Loading device 00:03:89:FE:E6:19 (headset )
hcid[16785]: /org/bluez: org.bluez.Manager.FindAdapter()
audio[16788]: Got path /org/bluez/hci0 for adapter with address 
00:0C:41:xx:xx:xx
audio[16788]: Accepted new client connection on unix socket (fd=8)
audio[16788]: Accepted new client connection on unix socket (fd=9)
audio[16788]: Package PKT_TYPE_CFG_REQ:0
audio[16788]: State changed /org/bluez/audio/device1: DISCONNECTED -> 
CONNECTING
audio[16788]: Package PKT_TYPE_CFG_REQ:0
hcid[16785]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceHandles()
hcid[16785]: no matching session found. creating a new one
hcid[16785]: link_key_request (sba=00:0C:41:xx:xx:xx, dba=00:03:89:xx:xx:xx)
hcid[16785]: sdp session added to cache
hcid[16785]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceRecord()
hcid[16785]: found matching session, removing from list
hcid[16785]: sdp session added to cache
audio[16788]: /org/bluez/audio/device1: Connecting to 00:03:89:xx:xx:xx 
channel 1
hcid[16785]: /org/bluez/hci0: 
org.bluez.Adapter.FinishRemoteServiceTransaction()
hcid[16785]: found matching session, removing from list
audio[16788]: State changed /org/bluez/audio/device1: CONNECTING -> 
CONNECTED
audio[16788]: /org/bluez/audio/device1: Connected to 00:03:89:xx:xx:xx
audio[16788]: State changed /org/bluez/audio/device1: CONNECTED -> 
STREAM_STARTING
audio[16788]: SCO socket opened for headset /org/bluez/audio/device1
audio[16788]: SCO fd=11
audio[16788]: fd=11, fd_opt=1, pkt_len=48, sample_size=2, rate=8000
audio[16788]: 30 bytes sent
audio[16788]: 1 bytes sent
audio[16788]: fd=11, fd_opt=0, pkt_len=48, sample_size=2, rate=8000
audio[16788]: 30 bytes sent
audio[16788]: 1 bytes sent
audio[16788]: State changed /org/bluez/audio/device1: STREAM_STARTING -> 
STREAMING
Received: AT+VGS=07
audio[16788]: Unix client disconnected (fd=8)
audio[16788]: Unix client disconnected (fd=9)
audio[16788]: State changed /org/bluez/audio/device1: STREAMING -> 
DISCONNECTED
audio[16788]: Accepted new client connection on unix socket (fd=8)
audio[16788]: Package PKT_TYPE_CFG_REQ:0
audio[16788]: State changed /org/bluez/audio/device2: DISCONNECTED -> 
CONNECTING
hcid[16785]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceHandles()
hcid[16785]: no matching session found. creating a new one
audio[16788]: Accepted new client connection on unix socket (fd=9)
audio[16788]: Package PKT_TYPE_CFG_REQ:0
hcid[16785]: sdp session added to cache
audio[16788]: get_handles_reply: Unable to get handle array from reply
audio[16788]: State changed /org/bluez/audio/device2: CONNECTING -> 
DISCONNECTED
audio[16788]: Unix client disconnected (fd=9)
audio[16788]: Unix client disconnected (fd=8)
hcid[16785]: sdp session timed out. closing

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
