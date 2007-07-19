Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Date: Thu, 19 Jul 2007 16:54:28 -0700
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1m/nGlonD8RCfS7"
Message-Id: <200707191654.29240.jbarnes@virtuousgeek.org>
Subject: [Bluez-users] Trouble with basic a2dp setup
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--Boundary-00=_1m/nGlonD8RCfS7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I recently picked up a Jabra BT620s headset for use with my Treo, and it
works great.  So I figured it would be nice if it worked with my
bluetooth capable Linux laptops as well.  Unfortunately, configuring it
to actually play audio on demand hasn't been as easy as I'd expected.

I followed the instructions at the bluetooth-alsa site, .a2dprc
attached, and .asoundrc looks like this:
	pcm.a2dpd {
	        type a2dpd
	}

hcitool scan shows my device address if its in associate mode, and I can
ping it with l2ping, but when I play audio after starting the a2dpd
daemon, I get a lot of debug output, some of which look like error
messages:

...
A2DPD[16:42:59.501]: init_ipc: Selected IPC: unix, addr=127.0.0.1, 
bcst=127.0.0.255, port=21453
A2DPD[16:42:59.501]: make_daemon_process: a2dpd [Jul 19 2007 14:19:57] 
starting ...
A2DPD[16:42:59.502]: main: (errno=13:Permission denied)a2dpd 
addr=00:13:17:71:44:AA timer=0 us [Jul 19 2007 14:37:05]
A2DPD[16:42:59.503]: a2dpd_signal_init: Getting on DBUS
A2DPD[16:42:59.509]: a2dpd_signal_init: Installing watch
A2DPD[16:42:59.510]: add_dbus_watch: Added watch 0 0x859b838 disabled
A2DPD[16:42:59.510]: add_dbus_watch: Added watch 1 0x859b860 enabled
A2DPD[16:42:59.511]: a2dpd_signal_init: Registering object 
path: /com/access/a2dpd
A2DPD[16:42:59.511]: a2dpd_signal_init: Acquiring service: 
com.access.a2dpd
A2DPD[16:42:59.513]: a2dpd_signal_init: OK
A2DPD[16:42:59.513]: a2dpd_register_sdp: Start
A2DPD[16:42:59.514]: add_avrtg:
A2DPD[16:42:59.516]: add_a2source:
A2DPD[16:42:59.516]: a2dpd_register_sdp: OK
A2DPD[16:42:59.517]: main_loop:
A2DPD[16:42:59.517]: make_server_socket:
A2DPD[16:42:59.518]: a2dp_make_listen_socket: (errno=13:Permission 
denied)Cannot bind socket 6 for psm 25
A2DPD[16:42:59.518]: main_loop: *** Cannot get AVDTP socket, incoming 
AVDTP connections are impossible ***
A2DPD[16:42:59.519]: a2dpd_signal_state: Started 00:13:17:71:44:AA
A2DPD[16:42:59.520]: bta2dpdevicenew:
A2DPD[16:42:59.520]: a2dpd_signal_address_changed: 00:13:17:71:44:AA
A2DPD[16:42:59.521]: a2dpd_signal_set_socket: Signal socket set to 6
A2DPD[16:42:59.524]: a2dpd_signal_state: Disconnected
A2DPD[16:42:59.525]: a2dp_alloc:
A2DPD[16:42:59.525]: a2dp_alloc: (a2dp = 0x859ef88)
...
A2DPD[16:43:08.561]: get_avdtp_psm: Record
A2DPD[16:43:08.561]: get_avdtp_psm: Service Search OK
A2DPD[16:43:08.593]: get_avdtp_psm: Checking non spec audio
A2DPD[16:43:08.593]: a2dp_state_machine: Found psm 25
A2DPD[16:43:08.593]: a2dp_state_machine: State 
AVDTP_STATEX_CTL_CONNECTING
A2DPD[16:43:08.593]: a2dp_state_machine: Socket is 9
A2DPD[16:43:08.593]: a2dp_state_machine: (errno=115:Operation now in 
progress)State AVDTP_STATEX_CTL_CONNECTING_WAIT
A2DPD[16:43:08.597]: stream_client_send_pointer_resp: (errno=32:Broken 
pipe)Error while sending data
A2DPD[16:43:08.597]: disconnect_client:
A2DPD[16:43:08.597]: pollfd_cb_clients: Client 0: Error detected (err=1, 
toc=1, err=0, hup=1)
A2DPD[16:43:08.598]: disconnect_client:
A2DPD[16:43:08.628]: a2dp_state_machine: (errno=111:Connection 
refused)CTL connection failed
A2DPD[16:43:08.628]: a2dp_state_machine: State 
AVDTP_STATEX_DISCONNECTING
A2DPD[16:43:08.678]: a2dp_disconnect:
A2DPD[16:43:08.678]: a2dp_stream_stop: Closing stream socket -1
...

I'm running the a2dpd daemon as a normal user, as recommended...

Hopefully there's something simple I'm missing here... maybe one day
this stuff will come standard with Fedora installations and I won't have
to do any configuration.

Thanks,
Jesse

--Boundary-00=_1m/nGlonD8RCfS7
Content-Type: text/plain;
  charset="us-ascii";
  name=".a2dprc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=".a2dprc"

[a2dpd]
#
# Rate
# use 32000 if your headset seems to not support 44100 (HP/Logitech works well at 44100, Sonorix at 32000)
# However, 44100 is mandatory
# If using SCO, then 8000hz is the value needed.
# if the plugin do not give the 8000hz stream, then the conversion will be done by the daemon
# Until we use a real resample library, we won't get a good quality, this is prototype software.
#
rate=44100
#rate=32000

# buggy if I remember well
#channels=2

#
# plugin-rate default is the rate used between the plugin and the daemon
# if this value is not 0 then alsa will convert all stream to the specified rate and then send it to the daemon
# if this value is 0, then alsa will do no conversion at all, the daemon will do it's own resampling.
# This "features" is disabled because of the crappy quality of the daemon resampler
# For example, to test a2dpd resampling from 32000 to 44100 use plugin-rate=32000 and rate=44100
#plugin-rate=32000

# Allows to specify the sbc bitpool, this can help reducing bandwith
# 8 Allows to run on a 115200 bauds with corresponding quality ;)
# 64 needs USB or 921600 bauds
# Recommended value from Bluetooth spec. is 53
sbcbitpool=32

# flags that will later be combinable
# 1: display bandwith each seconds.
# 3: current state
flags=0

# Recommended
enablereversestereo=1

# Automatically connect to selected headset if a stream if started
# not recommended if running on battery ;)
enableautoconnect=1

# Automatically disconnect after a timeout (seconds)
timeout=20

#
# AVRCP Commands to run
# If these entries are emptied, then some keyboard entry will be sent to /dev/uinput
#
#cmdplay=xmms --play
#cmdpause=xmms --pause
#cmdprev=xmms --rew
#cmdnext=xmms --fwd
#cmdnew=xmms --play
#cmdstop=xmms --stop
cmdplay=dcop amarok player play
cmdpause=dcop amarok player pause
cmdprev=dcop amarok player prev
cmdnext=dcop amarok player next
cmdnew=dcop amarok player play
cmdstop=dcop amarok player stop

# Put to 0 to ignore AVRCP (if your computer freezes when commands are received)
enableavrcp=0

#
# Audio routing
#
# If set to 1 (at a2dp startup only) a2dp will reread configuration file
# for audio routing changes each second
enablerereadconfig=1

# Display debug traces or not
enabledebug=1

# Redirect stdout to this file
#logfile=/dev/null

# Poll stdin for control commands ('c'onnect/'s'tart/'p'ause/'d'isconnect/'a'utoconnect)
# Use a2dpd_ctl instead
enablestdin=0

# 0 => Bluetooth A2DP Sink
# 1 => Alsa
enableredirectalsa=0

# Your bluetooth headset address
address=00:13:17:71:44:AA

# Address of your alsa output (default : plughw:0,0) you have to know what to do
alsaoutput=plughw:2,0

--Boundary-00=_1m/nGlonD8RCfS7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--Boundary-00=_1m/nGlonD8RCfS7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--Boundary-00=_1m/nGlonD8RCfS7--
