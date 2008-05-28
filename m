Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 May 2008 05:21:36 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: bluez-users@lists.sourceforge.net
Message-ID: <alpine.LNX.1.00.0805280355410.22621@nge2.ngu.pk>
MIME-Version: 1.0
Subject: [Bluez-users] bluez-utils-3.32: something broke?
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


Where to start? To put it simply, it used to work, now it doesn't. ;)
I upgraded to 3.32 and everything went haywire. Audio stopped working, plus 
I'm seeing alot of weird error messages.

This used to work playing on my bt headset:

sox -t ogg file.ogg -t alsa pcm.bluetooth

Now:

ALSA lib pcm_bluetooth.c:1505:(audioservice_recv) Error receiving data from
audio service: Success(0)
ALSA lib pcm_bluetooth.c:1521:(audioservice_expect) Bogus message
BT_SETCONFIGURATION_REQ received while BT_SETCONFIGURATION_RSP was expected
sox soxio: Can't open output file `pcm.bluetooth': cannot set parameters

hcid segfaulted on the first test. The bluetooth USB dongle "hangs", flashing 
endlessly. The sco counts stay at zero.


2008-05-28T03:50:07.678634-04:00 vdrl hcid[3348]: Bluetooth HCI daemon
2008-05-28T03:50:07.686778-04:00 vdrl hcid[3348]: Parsing
/etc/bluetooth/main.conf failed: No such file or directory

main.conf? Never saw that before. What are the service-*.xml files for? Where 
to install?

2008-05-28T03:50:07.686794-04:00 vdrl hcid[3348]: HCI dev 0 
registered
2008-05-28T03:50:07.688100-04:00 vdrl hcid[3348]: HCI dev 0 already up
2008-05-28T03:50:07.688730-04:00 vdrl hcid[3348]: Device hci0 has been added
2008-05-28T03:50:07.690768-04:00 vdrl hcid[3348]: Starting security manager
0
2008-05-28T03:50:07.729056-04:00 vdrl hcid[3348]: Device hci0 has been
activated
2008-05-28T03:50:07.729095-04:00 vdrl hcid[3348]: Starting SDP server
2008-05-28T03:50:07.729107-04:00 vdrl hcid[3348]: Can't create GN bridge
2008-05-28T03:50:07.729117-04:00 vdrl hcid[3348]: Registered manager
path:/org/bluez/network
2008-05-28T03:50:07.729129-04:00 vdrl hcid[3348]: Registered server
path:/org/bluez/network/nap
2008-05-28T03:50:07.729139-04:00 vdrl hcid[3348]: Registered server
path:/org/bluez/network/gn
2008-05-28T03:50:07.729150-04:00 vdrl hcid[3348]: Registered server
path:/org/bluez/network/panu
2008-05-28T03:50:07.729202-04:00 vdrl hcid[3348]: Registered manager
path:/org/bluez/serial
2008-05-28T03:50:07.729213-04:00 vdrl hcid[3348]: Registered input manager
path:/org/bluez/input
2008-05-28T03:50:07.730615-04:00 vdrl hcid[3348]: Unix socket created: 18
2008-05-28T03:50:07.739750-04:00 vdrl hcid[3348]: Registered manager
path:/org/bluez/audio
2008-05-28T03:50:07.739785-04:00 vdrl hcid[3348]: 
Loading device 00:1A:45:01:F9:42 (headset )
2008-05-28T03:50:07.739796-04:00 vdrl hcid[3348]: Setting 00:1A:45:01:F9:42
as default device
2008-05-28T03:50:07.739807-04:00 vdrl hcid[3348]: Starting experimental
netlink support

^^^^^^^^^^^^  I thought this could be the trouble, so I hid it and built 
again. Same results.


2008-05-28T03:50:07.739818-04:00 vdrl hcid[3348]: Failed to find Bluetooth
netlink family
2008-05-28T03:50:07.739829-04:00 vdrl hcid[3348]: Can't init plugin
/usr/lib/bluetooth/plugins/libnetlink.so

It does exist and I installed this particular "netlink' lib (there's about 4: 
rtnetlink, nfnetlink, iproute2's libnetlink, and this libnl-1).

2008-05-28T03:50:12.747879-04:00 vdrl hcid[3348]: Default authorization
/agent (:1.10, /org/bluez/auth_agent_3352) registered
2008-05-28T03:50:34.813665-04:00 vdrl hcid[3348]: Default passkey agent
/(:1.11, /org/bluez/passkey_agent_3355) registered
2008-05-28T03:51:00.171619-04:00 vdrl hcid[3348]: Audio API: received
/BT_GETCAPABILITIES_REQ
2008-05-28T03:51:00.171649-04:00 vdrl hcid[3348]: Audio API: sending
/BT_GETCAPABILITIES_RSP
2008-05-28T03:51:00.173225-04:00 vdrl hcid[3348]: Audio API: received
/BT_SETCONFIGURATION_REQ
2008-05-28T03:51:00.173300-04:00 vdrl hcid[3348]: config sco - device =
/00:1A:45:01:F9:42 access_mode = 2
2008-05-28T03:51:03.900979-04:00 vdrl hcid[3348]: link_key_request
/(sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
2008-05-28T03:51:06.571723-04:00 vdrl hcid[3348]: connect: Socket operation
/on non-socket (88)
2008-05-28T03:51:07.762096-04:00 vdrl hcid[3348]: Badly formated or
/unrecognized command: AT+BTRH?

Very similar to the errors I got before patching the kernel to support SCO.


2008-05-28T03:51:58.718581-04:00 vdrl hcid[3348]: Audio API: received
/BT_GETCAPABILITIES_REQ
2008-05-28T03:51:58.718607-04:00 vdrl hcid[3348]: Audio API: sending
/BT_GETCAPABILITIES_RSP
2008-05-28T03:51:58.720113-04:00 vdrl hcid[3348]: Audio API: received
/BT_SETCONFIGURATION_REQ
2008-05-28T03:51:58.720155-04:00 vdrl hcid[3348]: config sco - device =
/00:1A:45:01:F9:42 access_mode = 2
2008-05-28T03:52:02.251505-04:00 vdrl hcid[3348]: link_key_request
/(sba=00:0A:3A:7C:5C:74, dba=00:1A:45:01:F9:42)
2008-05-28T03:52:04.914254-04:00 vdrl hcid[3348]: connect: Invalid argument
/(22)
2008-05-28T03:52:06.341660-04:00 vdrl hcid[3348]: Badly formated or
/unrecognized command: AT+BTRH?

As nothing I tried worked, I put back bluez-utils-3.31 and the problems 
disappeared. bluez-libs-3.32 appears OK, but bluez-utils-3.32 has some serious 
issues.
2.6.25.3 w/sco patch built with gcc-4.3.0, x86.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
