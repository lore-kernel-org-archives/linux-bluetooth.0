Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Frederic Dalleau <frederic.dalleau@access-company.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200707191654.29240.jbarnes@virtuousgeek.org>
References: <200707191654.29240.jbarnes@virtuousgeek.org>
Date: Fri, 20 Jul 2007 10:13:27 +0200
Message-Id: <1184919207.880.5.camel@ubuntu.mpl.access-company.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Trouble with basic a2dp setup
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

Are you paired?
Put your headset discoverable and retry.
The pincode dialog should appear, if not, make sure you have
bluez-gnome.

Frederic


On Thu, 2007-07-19 at 16:54 -0700, Jesse Barnes wrote:
> I recently picked up a Jabra BT620s headset for use with my Treo, and it
> works great.  So I figured it would be nice if it worked with my
> bluetooth capable Linux laptops as well.  Unfortunately, configuring it
> to actually play audio on demand hasn't been as easy as I'd expected.
> 
> I followed the instructions at the bluetooth-alsa site, .a2dprc
> attached, and .asoundrc looks like this:
> 	pcm.a2dpd {
> 	        type a2dpd
> 	}
> 
> hcitool scan shows my device address if its in associate mode, and I can
> ping it with l2ping, but when I play audio after starting the a2dpd
> daemon, I get a lot of debug output, some of which look like error
> messages:
> 
> ...
> A2DPD[16:42:59.501]: init_ipc: Selected IPC: unix, addr=127.0.0.1, 
> bcst=127.0.0.255, port=21453
> A2DPD[16:42:59.501]: make_daemon_process: a2dpd [Jul 19 2007 14:19:57] 
> starting ...
> A2DPD[16:42:59.502]: main: (errno=13:Permission denied)a2dpd 
> addr=00:13:17:71:44:AA timer=0 us [Jul 19 2007 14:37:05]
> A2DPD[16:42:59.503]: a2dpd_signal_init: Getting on DBUS
> A2DPD[16:42:59.509]: a2dpd_signal_init: Installing watch
> A2DPD[16:42:59.510]: add_dbus_watch: Added watch 0 0x859b838 disabled
> A2DPD[16:42:59.510]: add_dbus_watch: Added watch 1 0x859b860 enabled
> A2DPD[16:42:59.511]: a2dpd_signal_init: Registering object 
> path: /com/access/a2dpd
> A2DPD[16:42:59.511]: a2dpd_signal_init: Acquiring service: 
> com.access.a2dpd
> A2DPD[16:42:59.513]: a2dpd_signal_init: OK
> A2DPD[16:42:59.513]: a2dpd_register_sdp: Start
> A2DPD[16:42:59.514]: add_avrtg:
> A2DPD[16:42:59.516]: add_a2source:
> A2DPD[16:42:59.516]: a2dpd_register_sdp: OK
> A2DPD[16:42:59.517]: main_loop:
> A2DPD[16:42:59.517]: make_server_socket:
> A2DPD[16:42:59.518]: a2dp_make_listen_socket: (errno=13:Permission 
> denied)Cannot bind socket 6 for psm 25
> A2DPD[16:42:59.518]: main_loop: *** Cannot get AVDTP socket, incoming 
> AVDTP connections are impossible ***
> A2DPD[16:42:59.519]: a2dpd_signal_state: Started 00:13:17:71:44:AA
> A2DPD[16:42:59.520]: bta2dpdevicenew:
> A2DPD[16:42:59.520]: a2dpd_signal_address_changed: 00:13:17:71:44:AA
> A2DPD[16:42:59.521]: a2dpd_signal_set_socket: Signal socket set to 6
> A2DPD[16:42:59.524]: a2dpd_signal_state: Disconnected
> A2DPD[16:42:59.525]: a2dp_alloc:
> A2DPD[16:42:59.525]: a2dp_alloc: (a2dp = 0x859ef88)
> ...
> A2DPD[16:43:08.561]: get_avdtp_psm: Record
> A2DPD[16:43:08.561]: get_avdtp_psm: Service Search OK
> A2DPD[16:43:08.593]: get_avdtp_psm: Checking non spec audio
> A2DPD[16:43:08.593]: a2dp_state_machine: Found psm 25
> A2DPD[16:43:08.593]: a2dp_state_machine: State 
> AVDTP_STATEX_CTL_CONNECTING
> A2DPD[16:43:08.593]: a2dp_state_machine: Socket is 9
> A2DPD[16:43:08.593]: a2dp_state_machine: (errno=115:Operation now in 
> progress)State AVDTP_STATEX_CTL_CONNECTING_WAIT
> A2DPD[16:43:08.597]: stream_client_send_pointer_resp: (errno=32:Broken 
> pipe)Error while sending data
> A2DPD[16:43:08.597]: disconnect_client:
> A2DPD[16:43:08.597]: pollfd_cb_clients: Client 0: Error detected (err=1, 
> toc=1, err=0, hup=1)
> A2DPD[16:43:08.598]: disconnect_client:
> A2DPD[16:43:08.628]: a2dp_state_machine: (errno=111:Connection 
> refused)CTL connection failed
> A2DPD[16:43:08.628]: a2dp_state_machine: State 
> AVDTP_STATEX_DISCONNECTING
> A2DPD[16:43:08.678]: a2dp_disconnect:
> A2DPD[16:43:08.678]: a2dp_stream_stop: Closing stream socket -1
> ...
> 
> I'm running the a2dpd daemon as a normal user, as recommended...
> 
> Hopefully there's something simple I'm missing here... maybe one day
> this stuff will come standard with Fedora installations and I won't have
> to do any configuration.
> 
> Thanks,
> Jesse
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________ Bluez-users mailing list Bluez-users@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
