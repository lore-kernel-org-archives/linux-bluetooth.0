Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45582F42.5070008@free.fr>
Date: Mon, 13 Nov 2006 09:39:30 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <20061113023929.GA8765@dominikbrodowski.de>
In-Reply-To: <20061113023929.GA8765@dominikbrodowski.de>
Subject: Re: [Bluez-devel] SCO packet for unknown connection handle
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Dominik,

It looks like current headsetd CVS is broken.
The issue is due to a regression introduced after a change of return 
code in recent   Linux kernels (EAGAIN --> EINPROGRESS).

There has been a patch floating around in the list recently that fixes this.

Brad, would you mind updating cvs with this patch ?

Cheers,

Fabien

diff -urN btsco/alsa-plugins/headsetd/sdp.c 
btsco-chmo/alsa-plugins/headsetd/sdp.c
--- btsco/alsa-plugins/headsetd/sdp.c	2006-10-26 18:21:40.000000000 +0200
+++ btsco-chmo/alsa-plugins/headsetd/sdp.c	2006-11-08 16:53:41.000000000 
+0100
@@ -145,7 +145,7 @@
  			if(fcntl(session->sock, F_SETFL, O_NONBLOCK) < 0) {
  				goto fail;
  			}
-			if ( (connect(session->sock, (struct sockaddr *) &sa, sizeof(sa)) == 
0) || (errno == EAGAIN) )
+			if ( (connect(session->sock, (struct sockaddr *) &sa, sizeof(sa)) == 
0) || (errno == EAGAIN) || (errno == EINPROGRESS) )
  				return session;
  		}
  	}
diff -urN btsco/alsa-plugins/headsetd/states.c 
btsco-chmo/alsa-plugins/headsetd/states.c
--- btsco/alsa-plugins/headsetd/states.c	2006-10-26 18:21:40.000000000 +0200
+++ btsco-chmo/alsa-plugins/headsetd/states.c	2006-11-08 
17:15:15.000000000 +0100
@@ -154,7 +154,7 @@
  	bacpy(&addr.rc_bdaddr, dst);
  	addr.rc_channel = channel;

-	if ((connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) && (errno 
!= EAGAIN) ) {
+	if ((connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) && (errno 
!= EAGAIN) && (errno != EINPROGRESS)) {
  		close(s);
  		return -1;
  	}
@@ -180,7 +180,7 @@
  	memset(&addr, 0, sizeof(addr));
  	addr.sco_family = AF_BLUETOOTH;
  	bacpy(&addr.sco_bdaddr, dst);
-	if ((connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) && (errno 
!= EAGAIN)) {
+	if ((connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) && (errno 
!= EAGAIN) && (errno != EINPROGRESS)) {
  		close(s);
  		return -1;
  	}



> Hi!
> 
> I'm trying to get this dongle
> 
> hci0:	Type: USB
> 	BD Address: <hidden> ACL MTU: 120:20 SCO MTU: 0:0
> 	UP RUNNING PSCAN ISCAN 
> 	RX bytes:393 acl:0 sco:0 events:18 errors:0
> 	TX bytes:322 acl:0 sco:0 commands:18 errors:0
> 	Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
> 	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
> 	Link policy: RSWITCH HOLD SNIFF PARK 
> 	Link mode: SLAVE ACCEPT 
> 	Name: 'BlueZ (0)'
> 	Class: 0x3e0100
> 	Service Classes: Networking, Rendering, Capturing
> 	Device Class: Computer, Uncategorized
> 	HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x757
> 	Manufacturer: Silicon Wave (11)
> 
> to work using the bt sco alsa-plugin.
> 
> As the SCO MUT is reported to be 0:0 at first, I re-set it to 64:8 using
> 
> # hciconfig hci0 scomtu 64:8
> 
> Running
> 
> # /usr/bin/headsetd -n
> 
> looks promising, though playing sound using "aplay -D pcm.headset" does not
> work:
> 
> headsetd[8300]: Bluetooth headset daemon version 0.42
> headsetd[8300]: Incoming RFCOMM hs connection from <address> accepted
> Headset connected
> headsetd[8300]: Changing state: Idle-->Connected
> headsetd[8300]: Changing state: Connected-->Ready
> headsetd[8300]: unable to open bluetooth SCO socket
> headsetd[8300]: Changing state: Ready-->Connected
> Received from HS: AT+VGS=10
> 
> asound reports:
> DEBUG: _snd_pcm_sco_open: Starting pcm_sco plugin.
> DEBUG: _snd_pcm_sco_open: Open mode is for Playback.
> aplay: main:550: audio open error: Operation now in progress
> 
> The kernel is Linus' latest 2.6.19-rc5, and it reports
> 
> [ 1845.813000] Bluetooth: RFCOMM socket layer initialized
> [ 1845.814000] Bluetooth: RFCOMM TTY layer initialized
> [ 1845.814000] Bluetooth: RFCOMM ver 1.8
> ... possible recursive locking warning snipped ...
> [ 1898.408000] hci_scodata_packet: hci0 SCO packet for unknown connection handle 256
> 
> Running hciconfig afterwards has only these changes:
> -	RX bytes:9824 acl:19 sco:167 events:57 errors:0
> -	TX bytes:719 acl:17 sco:0 commands:29 errors:0
> +	RX bytes:5044 acl:18 sco:9 events:92 errors:0
> +	TX bytes:827 acl:17 sco:0 commands:65 errors:0
> 
> so no SCO TX... quite some time later the following appears in dmesg:
> 
> [ 2033.376000] hci_cmd_task: hci0 command tx timeout
> 
> Any ideas?
> 
> Thanks,
> 	Dominik
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
