Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 2 Feb 2007 10:31:51 -0500 (EST)
From: Bob Dony <rdony@uoguelph.ca>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.64.0702020941290.16632@muskoka.eos.uoguelph.ca>
MIME-Version: 1.0
Subject: [Bluez-users] A2DP (Bluetooth ALSA) - almost there
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi folks,

Please excuse the request for a bit of help here from a newbie (to Bluez 
that is...)

I think I have everything installed according to the websites (see below). 
My problem is that I can't seem to get any sound through my HP BT-headset. 
I've used both
# sox bell.au -t alsa a2dpd
and xmms with the Alsa plug-in Audio device to a2dpd
and they play without complaint.  While I'm playing, the headset blue LED 
switches to slow flashing, indicating a successful connection (I had 
paired earlier & set the PIN).  My output of a2dpd while I'm playing
in xmms is:

A2DPD[784.525]: main_loop: New client 16
A2DPD[784.525]: main_loop: Got index 0
A2DPD[784.525]: poll_incoming_clients_sockets: PLAYBACK thread client_index=0, socket=16, id=0 started (44100 Hz, 2 channels, 16 bits)
A2DPD[784.526]: a2dp_state_connect: State AVDTP_STATEX_SDP_CONNECTING
A2DPD[784.526]: a2dpd_signal_state: Connecting 00:0D:44:2A:39:45
A2DPD[784.527]: a2dp_state_machine: Role is INITIATOR
A2DPD[784.527]: a2dp_state_machine: State AVDTP_STATEX_SDP_CONNECTING_WAIT
A2DPD[784.923]: a2dp_state_machine: SDP connection terminated
A2DPD[784.947]: get_avdtp_psm: Parsing results
A2DPD[784.947]: get_avdtp_psm: Record
A2DPD[784.947]: get_avdtp_psm: Service Search OK
A2DPD[784.976]: get_avdtp_psm: Checking non spec audio
A2DPD[784.977]: a2dp_state_machine: Found psm 25
A2DPD[784.977]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING
A2DPD[784.977]: a2dp_state_machine: Socket is 17
A2DPD[784.977]: a2dp_state_machine: State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[784.979]: a2dp_handler: Sound stream dry
A2DPD[785.051]: a2dp_state_machine: State AVDTP_STATE_IDLE
A2DPD[785.054]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING
A2DPD[785.057]: a2dp_state_machine: State AVDTP_STATEX_DISCOVERING_RESP
A2DPD[785.071]: a2dp_handler: Sound stream dry
A2DPD[785.100]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_DISCOVER)
A2DPD[785.100]: a2dp_state_machine: AVDTP_DISCOVER success
A2DPD[785.100]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES
A2DPD[785.103]: a2dp_state_machine: Getting capabilities for SEID=1
A2DPD[785.103]: a2dp_state_machine: State AVDTP_STATEX_GETTING_CAPABILITIES_RESP
A2DPD[785.129]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_GET_CAPABILITIES)
A2DPD[785.129]: a2dp_state_machine: AVDTP_GET_CAPABILITIES success for seid 1
A2DPD[785.129]: a2dp_state_machine: servcap_cap=1, servcap_len=0,
A2DPD[785.129]: a2dp_state_machine: cap_type=7, length=6
A2DPD[785.129]: a2dp_state_machine: media_type=0, codec=0
A2DPD[785.129]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION
A2DPD[785.132]: a2dp_state_machine: State AVDTP_STATEX_SETTING_CONFIGURATION_RESP
A2DPD[785.164]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_SET_CONFIGURATION)
A2DPD[785.164]: a2dp_state_machine: AVDTP_SET_CONFIGURATION success
A2DPD[785.164]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING
A2DPD[785.167]: a2dp_state_machine: State AVDTP_STATEX_STREAM_OPENING_RESP
A2DPD[785.167]: a2dp_handler: Sound stream dry
A2DPD[785.196]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_OPEN)
A2DPD[785.196]: a2dp_state_machine: AVDTP_OPEN success
A2DPD[785.196]: a2dp_state_machine: State AVDTP_STATE_CONFIGURED
A2DPD[785.199]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING
A2DPD[785.202]: a2dp_state_machine: Socket is 18
A2DPD[785.202]: a2dp_state_machine: State AVDTP_STATEX_STREAM_CONNECTING_WAIT
A2DPD[785.243]: a2dp_state_machine: Stream connected
A2DPD[785.243]: a2dp_state_machine: State AVDTP_STATE_OPEN_START_STREAMING
A2DPD[785.246]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING
A2DPD[785.248]: a2dpd_signal_state: Connected 00:0D:44:2A:39:45
A2DPD[785.248]: a2dp_state_machine: State AVDTP_STATEX_STREAM_STARTING_WAIT
A2DPD[785.263]: a2dp_handler: Sound stream dry
A2DPD[785.275]: a2dp_handle_avdtp_message: Read non command packet (msgtype=MESSAGE_TYPE_ACCEPT,signal=AVDTP_START)
A2DPD[785.275]: a2dp_state_machine: AVDTP_START success
A2DPD[785.275]: a2dp_state_machine: State AVDTP_STATE_STREAMING
A2DPD[785.280]: avrcp_listener: socket 19: Connection from 45:39:2A:44:0D:00, mtu=672
A2DPD[785.359]: a2dp_handler: Sound stream dry
A2DPD[785.455]: a2dp_handler: Sound stream dry
A2DPD[785.550]: a2dp_handler: Sound stream dry
A2DPD[785.646]: a2dp_handler: Sound stream dry
A2DPD[785.742]: a2dp_handler: Sound stream dry
A2DPD[785.838]: a2dp_handler: Sound stream dry
A2DPD[785.934]: a2dp_handler: Sound stream dry
A2DPD[786.029]: a2dp_handler: Sound stream dry
A2DPD[786.125]: a2dp_handler: Sound stream dry
...


My particulars:

Fedora Core 6

gnome-bluetooth-libs-0.7.0-11.fc6
bluez-hcidump-1.32-1
bluez-utils-3.7-2
bluez-libs-3.7-1
bluez-utils-cups-3.7-2
gnome-bluetooth-0.7.0-11.fc6

Bluetooth ALSA packages (libsbc & plugz) downloaded and built according to:
http://bluetooth-alsa.sourceforge.net/build.html

# hcitool info 00:0D:44:2A:39:45
Requesting information ...
         BD Address:  00:0D:44:2A:39:45
         Device Name: BT-Headphones
         LMP Version: 1.2 (0x2) LMP Subversion: 0x3d
         Manufacturer: Zeevo, Inc. (18)
         Features: 0xff 0x07 0x04 0x78 0x18 0x18 0x00 0x00
                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
                 <timing accuracy> <role switch> <hold mode> <sniff mode>
                 <park state> <RSSI> <channel quality> <power control>
                 <enhanced iscan> <interlaced iscan> <interlaced pscan>
                 <inquiry with RSSI> <AFH cap. slave> <AFH class. slave>
                 <AFH cap. master> <AFH class. master>

The bottom of my .a2dprc:
# Your bluetooth headset address
address=00:0D:44:2A:39:45

# Address of your alsa output (default : plughw:0,0) you have to know what to do
alsaoutput=

And my .asoundrc:
pcm.a2dpd {
     type a2dpd
}


Any other info needed?

Any pointers would be appreciated.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
