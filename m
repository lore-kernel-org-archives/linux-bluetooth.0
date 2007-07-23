Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <5a55627a0707231611u2a2b6f7fwe7669464f2db3f75@mail.gmail.com>
Date: Mon, 23 Jul 2007 18:11:17 -0500
From: "Mirza Baig" <ambaig@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] Receiving failed on socket 0.8 error (0/4 bytes)
	errno=0:Success
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0305699982=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0305699982==
Content-Type: multipart/alternative;
	boundary="----=_Part_68926_10691485.1185232277759"

------=_Part_68926_10691485.1185232277759
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Marcel,

I am unable to send music over to Motorola HT 820 stereo headset using A2DP
profile. I am using Bluez 3.7. I have copied the log. Error message says
receiving failed on socket 0.8 error.

Please help.

Regards

Mirza


# uname -a
Linux Linux 2.6.14.7-tiny1 #1 PREEMPT Wed Jul 18 21:22:33 CDT 2007 armv5tel
unk
own


Following is the log:

/wifi # hciconfig -a
hci0: Type: UART
BD Address: 00:50:43:20:6D:D0 ACL MTU: 1021:7 SCO MTU: 240:255
UP RUNNING PSCAN ISCAN
RX bytes:79 acl:0 sco:0 events:8 errors:0
TX bytes:39 acl:0 sco:0 commands:8 errors:0
Features: 0xff 0xed 0x89 0xbe 0x9a 0xe9 0x00 0x00
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV3
Link policy:
Link mode: SLAVE ACCEPT
Name: ''
Class: 0x000000
Service Classes: Unspecified
Device Class: Miscellaneous,
HCI Ver: 2.0 (0x3) HCI Rev: 0x8300 LMP Ver: 2.0 (0x3) LMP Subver: 0x300
Manufacturer: not assigned (72)

/wifi # hciconfig hci0
hci0: Type: UART
BD Address: 00:50:43:20:6D:D0 ACL MTU: 1021:7 SCO MTU: 240:255
UP RUNNING PSCAN ISCAN
RX bytes:359 acl:0 sco:0 events:11 errors:0
TX bytes:51 acl:0 sco:0 commands:11 errors:0

/wifi # ls /dev/input/uinput
/dev/input/uinput
/wifi # adduser messagebus
adduser: messagebus: login already in use
/wifi # dbus-daemon --system
/wifi #
/wifi #
/wifi # hcid
/wifi #
/wifi #
/wifi # hciconfig hci0 piscan
/wifi # hciconfig hci0 voice 0x0060
/wifi # hcitool scan
Scanning ...
00:07:A4:B6:AB:6C Motorola HT820
/wifi # hcitool inq
Inquiring ...
00:07:A4:B6:AB:6C clock offset: 0x0db3 class: 0x240404
/wifi # passkey-agent --default 0000 &
/wifi # hcitool cc 00:07:a4:b6:ab:6c
/wifi #
/wifi #
/wifi # a2dpd 00:07:a4:b6:ab:6c &
a2dpd [Jun 12 2007 20:02:47] starting ...a2dpd addr=00:07:a4:b6:ab:6c
timer=1000
0 us [Jun 12 2007 20:02:47]
setscheduler returns 0 (errno=2:No such file or directory)
main_thread:Accepting incoming tcp stream connection
New connection to bluetooth [44100 hz]
avrcp: Accepting incoming connection
avdtp: Accepting incoming connection

/wifi # aplay tada.wav
DEBUG: _snd_pcm_a2dpd_open: (errno=0:Success)name default mode 0
DEBUG: a2dp_alloc: (errno=0:Success)Init
DEBUG: a2dp_alloc: (errno=0:Success)OK
main_thread: Accepted 8
PCM thread 0.8 started
main_thread:Accepting incoming tcp stream connection
Playing WAVE 'tada.wav ' : Signed 16 bit Little Endian, Rate 22050 Hz,
Stereo
Warning: rate is not accurate (requested = 22050Hz, got = 44100Hz)
please, try the plug plugin (-Dplug:default)
DEBUG: a2dp_params: (errno=0:Success)a2dp 0x28b78
DEBUG: a2dp_params: (errno=0:Success)format S16_LE rate 44100 channels 2
DEBUG: a2dp_params: (errno=0:Success)frame_bytes 4 period_bytes 8192
period_size
2048 buffer_size 4096
DEBUG: a2dp_prepare: (errno=0:Success)a2dp 0x28b78
DEBUG: a2dp_new: 00:07:a4:b6:ab:6c, 44100
DEBUG: detect_a2dp: Found A2DP Sink
DEBUG: connect_stream: Found A2DP Sink at the destination (psm_cmd=25)
DEBUG: connect_stream: Sent the Stream End Point Discovery Command
DEBUG: a2dp_handle_avdtp_message: Read non command packet
(msgtype=2,signal=1)
DEBUG: connect_stream: Got a Stream End Point Discovery (4 bytes) Response
(msgt
ype=2,pkttype=0,lbl=0,sig=1,rfa=0)
02010408
DEBUG: connect_stream: received 1 capabilities
DEBUG: process_seid: Got capabilities response:
servcap_cap=1, servcap_len=0,
cap_type=7, length=6, media_type=0, codec=0
DEBUG: a2dp_drain: (errno=0:Success)a2dp 0x28b78
[1] Receiving failed on socket 0.8 error (0/4 bytes) errno=0:Success
Client thread 0.8 ending: error
DEBUG: a2dp_free: (errno=0:Success)Finishing
DEBUG: a2dp_free: (errno=0:Success)OK
/wifi # DEBUG: process_seid: Got Set Configurations Response (2
bytes:msgtype=2,
pkttype=0,lbl=2,sig=3,rfa=0)
DEBUG: connect_stream: Sent stream start(seid=1)
DEBUG: connect_stream: Got start stream confirm
DEBUG: listen_thread: Listen thread running [control_sk=9]
avrcp: socket 10: Connection from 6C:AB:B6:A4:07:00, mtu=672
avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672
avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672
avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672
avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672
avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672
avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672
avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672
avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672
avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672
avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672
avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672
avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672
avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672

------=_Part_68926_10691485.1185232277759
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hello Marcel,</div>
<div>&nbsp;</div>
<div>I am&nbsp;unable to send music over to Motorola&nbsp;HT 820 stereo headset&nbsp;using A2DP profile.&nbsp;I am using Bluez 3.7. I have copied the log. Error message says receiving failed on socket 0.8 error.</div>
<div>&nbsp;</div>
<div>Please help.</div>
<div>&nbsp;</div>
<div>Regards</div>
<div>&nbsp;</div>
<div>Mirza</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div># uname -a<br>Linux Linux 2.6.14.7-tiny1 #1 PREEMPT Wed Jul 18 21:22:33 CDT 2007 armv5tel unk<br>own</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Following is the log:</div>
<div><font size="2">
<p>/wifi # hciconfig -a<br>hci0: Type: UART<br>BD Address: 00:50:43:20:6D:D0 ACL MTU: 1021:7 SCO MTU: 240:255<br>UP RUNNING PSCAN ISCAN<br>RX bytes:79 acl:0 sco:0 events:8 errors:0<br>TX bytes:39 acl:0 sco:0 commands:8 errors:0 
<br>Features: 0xff 0xed 0x89 0xbe 0x9a 0xe9 0x00 0x00<br>Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV3<br>Link policy:<br>Link mode: SLAVE ACCEPT<br>Name: &#39;&#39;<br>Class: 0x000000<br>Service Classes: Unspecified<br>Device Class: Miscellaneous, 
<br>HCI Ver: 2.0 (0x3) HCI Rev: 0x8300 LMP Ver: 2.0 (0x3) LMP Subver: 0x300<br>Manufacturer: not assigned (72)<br><br>/wifi # hciconfig hci0<br>hci0: Type: UART<br>BD Address: 00:50:43:20:6D:D0 ACL MTU: 1021:7 SCO MTU: 240:255 
<br>UP RUNNING PSCAN ISCAN<br>RX bytes:359 acl:0 sco:0 events:11 errors:0<br>TX bytes:51 acl:0 sco:0 commands:11 errors:0<br><br>/wifi # ls /dev/input/uinput<br>/dev/input/uinput<br>/wifi # adduser messagebus<br>adduser: messagebus: login already in use 
<br>/wifi # dbus-daemon --system<br>/wifi #<br>/wifi #<br>/wifi # hcid<br>/wifi #<br>/wifi #<br>/wifi # hciconfig hci0 piscan<br>/wifi # hciconfig hci0 voice 0x0060<br>/wifi # hcitool scan<br>Scanning ...<br>00:07:A4:B6:AB:6C Motorola HT820 
<br>/wifi # hcitool inq<br>Inquiring ...<br>00:07:A4:B6:AB:6C clock offset: 0x0db3 class: 0x240404<br>/wifi # passkey-agent --default 0000 &amp;<br>/wifi # hcitool cc 00:07:a4:b6:ab:6c<br>/wifi #<br>/wifi #<br>/wifi # a2dpd 00:07:a4:b6:ab:6c &amp; 
<br>a2dpd [Jun 12 2007 20:02:47] starting ...a2dpd addr=00:07:a4:b6:ab:6c timer=1000<br>0 us [Jun 12 2007 20:02:47]<br>setscheduler returns 0 (errno=2:No such file or directory)<br>main_thread:Accepting incoming tcp stream connection 
<br>New connection to bluetooth [44100 hz]<br>avrcp: Accepting incoming connection<br>avdtp: Accepting incoming connection<br><br>/wifi # aplay tada.wav<br>DEBUG: _snd_pcm_a2dpd_open: (errno=0:Success)name default mode 0<br>
DEBUG: a2dp_alloc: (errno=0:Success)Init<br>DEBUG: a2dp_alloc: (errno=0:Success)OK<br>main_thread: Accepted 8<br>PCM thread 0.8 started<br>main_thread:Accepting incoming tcp stream connection<br>Playing WAVE &#39;tada.wav
 &#39; : Signed 16 bit Little Endian, Rate 22050 Hz, Stereo<br>Warning: rate is not accurate (requested = 22050Hz, got = 44100Hz)<br>please, try the plug plugin (-Dplug:default)<br>DEBUG: a2dp_params: (errno=0:Success)a2dp 0x28b78 
<br>DEBUG: a2dp_params: (errno=0:Success)format S16_LE rate 44100 channels 2<br>DEBUG: a2dp_params: (errno=0:Success)frame_bytes 4 period_bytes 8192 period_size<br>2048 buffer_size 4096<br>DEBUG: a2dp_prepare: (errno=0:Success)a2dp 0x28b78 
<br>DEBUG: a2dp_new: 00:07:a4:b6:ab:6c, 44100<br>DEBUG: detect_a2dp: Found A2DP Sink<br>DEBUG: connect_stream: Found A2DP Sink at the destination (psm_cmd=25)<br>DEBUG: connect_stream: Sent the Stream End Point Discovery Command 
<br>DEBUG: a2dp_handle_avdtp_message: Read non command packet (msgtype=2,signal=1)<br>DEBUG: connect_stream: Got a Stream End Point Discovery (4 bytes) Response (msgt<br>ype=2,pkttype=0,lbl=0,sig=1,rfa=0)<br>02010408<br>DEBUG: connect_stream: received 1 capabilities 
<br>DEBUG: process_seid: Got capabilities response:<br>servcap_cap=1, servcap_len=0,<br>cap_type=7, length=6, media_type=0, codec=0<br>DEBUG: a2dp_drain: (errno=0:Success)a2dp 0x28b78<br>[1] Receiving failed on socket 0.8
 error (0/4 bytes) errno=0:Success<br>Client thread 0.8 ending: error<br>DEBUG: a2dp_free: (errno=0:Success)Finishing<br>DEBUG: a2dp_free: (errno=0:Success)OK<br>/wifi # DEBUG: process_seid: Got Set Configurations Response (2 bytes:msgtype=2, 
<br>pkttype=0,lbl=2,sig=3,rfa=0)<br>DEBUG: connect_stream: Sent stream start(seid=1)<br>DEBUG: connect_stream: Got start stream confirm<br>DEBUG: listen_thread: Listen thread running [control_sk=9]<br>avrcp: socket 10: Connection from 6C:AB:B6:A4:07:00, mtu=672 
<br>avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672<br>avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672<br>avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672<br>avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672 
<br>avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672<br>avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672<br>avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672<br>avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672 
<br>avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672<br>avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672<br>avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672<br>avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672 
<br>avrcp: socket 10: Reading from 6C:AB:B6:A4:07:00, mtu=672<br></p></font></div>

------=_Part_68926_10691485.1185232277759--


--===============0305699982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0305699982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0305699982==--
