Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Jun 2008 17:56:51 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: bluez-users@lists.sourceforge.net
Message-ID: <alpine.LNX.1.00.0806021644270.9709@nge2.ngu.pk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1287628786-835492040-1212443812=:9709"
Subject: [Bluez-users] bluez-3.22: hcid segfault
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1287628786-835492040-1212443812=:9709
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 8BIT



I researched the hcid segfault further. It seems to be in libaudio.so. These 
binaries were compiled with no optimization, debug symbols, and --enable-debug 
switch. Most of my libs have their symbols as well.


hcid[10625]: segfault at 10 ip b7c65586 sp bfe39700 error 6 in libaudio.so[b7c5b000+1e000]

Reproduce:

Start dbus, hcid, passkey-agent & auth-agent for device, etc. 
Turn on headset to initiate connection (or depress hs button)
Send data to headset with command similar to 'sox -t mp3 file.mp3 -t alsa pcm.bluetooth
hcid seems to segfault when loading audio plugin libaudio.so to handle the request



hcid[10808]: HFP Service Level Connection established
hcid[10808]: State changed /org/bluez/audio/device0: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
hcid[10808]: connect: Socket operation on non-socket (88)
hcid[10808]: Received AT+BTRH?
hcid[10808]: Badly formated or unrecognized command: AT+BTRH?
hcid[10808]: Received AT+VGS=09
hcid[10808]: Received AT+VGM=15
hcid[10808]: Unix client disconnected (fd=14)
hcid[10808]: State changed /org/bluez/audio/device0: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED
hcid[10808]: link_key_request (sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
hcid[10808]: Got a svc srch attr req
hcid[10808]: Seq type : 53
hcid[10808]: Data size : 5
hcid[10808]: Data type: 0x1a
hcid[10808]: No of elements : 1
hcid[10808]: Bytes scanned: 7
hcid[10808]: Max Attr expected: 38
hcid[10808]: Seq type : 53
hcid[10808]: Data size : 3
hcid[10808]: Data type: 0x09
hcid[10808]: No of elements : 1
hcid[10808]: Continuation State size : 0
hcid[10808]: Entries in attr seq : 1
hcid[10808]: AttrDataType : 9
hcid[10808]: Response count : 1
hcid[10808]: Local PDU size : 19
hcid[10808]: Net PDU size : 21
hcid[10808]: Sending rsp. status 0
hcid[10808]: Bytes Sent : 29
hcid[10808]: Requesting authorization for device 00:1A:45:01:F9:42, UUID 0000111F-0000-1000-8000-00805F9B34FB
hcid[10808]: handle_authorize_request
hcid[10808]: authorize request was forwarded
hcid[10808]: authorize reply
hcid[10808]: successfull reply was sent
hcid[10808]: auth_agent_reply: returning
hcid[10808]: Accepted headset connection from 00:1A:45:01:F9:42 for /org/bluez/audio/device0
hcid[10808]: State changed /org/bluez/audio/device0: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECTED
hcid[10808]: link_key_notify (sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
hcid[10808]: Got a svc srch attr req
hcid[10808]: Seq type : 53
hcid[10808]: Data size : 5
hcid[10808]: Data type: 0x1a
hcid[10808]: No of elements : 1
hcid[10808]: Bytes scanned: 7
hcid[10808]: Max Attr expected: 38
hcid[10808]: Seq type : 53
hcid[10808]: Data size : 3
hcid[10808]: Data type: 0x09
hcid[10808]: No of elements : 1
hcid[10808]: Continuation State size : 0
hcid[10808]: Entries in attr seq : 1
hcid[10808]: AttrDataType : 9
hcid[10808]: Response count : 1
hcid[10808]: Local PDU size : 15
hcid[10808]: Net PDU size : 17
hcid[10808]: Sending rsp. status 0
hcid[10808]: Bytes Sent : 25
hcid[10808]: Received AT+BRSF=26
hcid[10808]: Received AT+CIND=?
hcid[10808]: Received AT+CIND?
hcid[10808]: Received AT+CMER=3, 0, 0, 1
hcid[10808]: Received AT+BTRH?
hcid[10808]: Badly formated or unrecognized command: AT+BTRH?
hcid[10808]: Received AT+VGS=09
hcid[10808]: Received AT+VGM=15
hcid[10808]: Accepted new client connection on unix socket (fd=14)
hcid[10808]: Audio API: received BT_GETCAPABILITIES_REQ
hcid[10808]: Audio API: sending BT_GETCAPABILITIES_RSP
hcid[10808]: Audio API: received BT_SETCONFIGURATION_REQ
hcid[10808]: config sco - device = 00:1A:45:01:F9:42 access_mode = 2
hcid[10808]: connect: Invalid argument (22)

Program received signal SIGSEGV, Segmentation fault.
0xb7cb8586 in headset_request_stream (dev=0x9981ea0, cb=0xb7cb945b <headset_setup_complete>, user_data=0x99840c8)
     at headset.c:1716
1716            hs->pending->target_state = HEADSET_STATE_PLAYING;
(gdb) bt
#0  0xb7cb8586 in headset_request_stream (dev=0x9981ea0, cb=0xb7cb945b <headset_setup_complete>, user_data=0x99840c8)
     at headset.c:1716
#1  0xb7cb9feb in start_config (dev=0x9981ea0, client=0x99840c8) at unix.c:624
#2  0xb7cbaad5 in handle_setconfiguration_req (client=0x99840c8, req=0xbfe8bb18) at unix.c:938
#3  0xb7cbae21 in client_cb (chan=0x997e358, cond=G_IO_IN, data=0x99840c8) at unix.c:1041
#4  0xb7f172cd in ?? () from /usr/lib/libglib-2.0.so.0
#5  0x0997e358 in ?? ()
#6  0x00000001 in ?? ()
#7  0x099840c8 in ?? ()
#8  0xb7f53240 in ?? () from /usr/lib/libglib-2.0.so.0
#9  0xb7f5355c in g_idle_funcs () from /usr/lib/libglib-2.0.so.0
#10 0x0997ca50 in ?? ()
#11 0xbfe8bc38 in ?? ()
#12 0xb7ee9a20 in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
Backtrace stopped: frame did not save the PC
(gdb)

(gdb) info sharedlibrary
>>From        To          Syms Read   Shared Object Library
0xb7f707f0  0xb7f88a8f  Yes         /lib/ld-linux.so.2
0xb7f58ca0  0xb7f59b88  Yes         /usr/lib/libgmodule-2.0.so.0
0xb7f54a60  0xb7f55a68  Yes         /lib/libdl.so.2
0xb7ec9020  0xb7f1a268  Yes         /usr/lib/libglib-2.0.so.0
0xb7e93e50  0xb7eaf424  Yes         /usr/lib/libpcre.so.0
0xb7e82070  0xb7e8dda0  Yes         /usr/lib/libz.so.1
0xb7e53a00  0xb7e79be4  Yes         /usr/lib/libdbus-1.so.3
0xb7e40010  0xb7e4a2c8  Yes         /usr/lib/libbluetooth.so.2
0xb7cf9170  0xb7e04c78  Yes         /lib/libc.so.6
0xb7f64c20  0xb7f6c308  Yes         /usr/lib/bluetooth/plugins/libnetwork.so
0xb7f60270  0xb7f60378  Yes         /usr/lib/bluetooth/plugins/libstorage.so
0xb7cda720  0xb7ce03c8  Yes         /usr/lib/bluetooth/plugins/libserial.so
0xb7ccf3b0  0xb7cd5738  Yes         /usr/lib/bluetooth/plugins/libinput.so
0xb7cb1300  0xb7cc7868  Yes         /usr/lib/bluetooth/plugins/libaudio.so

(gdb) info frame
Stack level 0, frame at 0xbfe8ba80:
  eip = 0xb7cb8586 in headset_request_stream (headset.c:1716); saved eip 0xb7cb9feb
  called by frame at 0xbfe8bab0
  source language c.
  Arglist at 0xbfe8ba78, args: dev=0x9981ea0, cb=0xb7cb945b <headset_setup_complete>, user_data=0x99840c8
  Locals at 0xbfe8ba78, Previous frame's sp is 0xbfe8ba80
  Saved registers:
   ebx at 0xbfe8ba74, ebp at 0xbfe8ba78, eip at 0xbfe8ba7c


---1287628786-835492040-1212443812=:9709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
---1287628786-835492040-1212443812=:9709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

---1287628786-835492040-1212443812=:9709--
