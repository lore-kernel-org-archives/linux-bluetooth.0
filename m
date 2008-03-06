Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Mar 2008 23:16:55 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: bluez-users@lists.sourceforge.net
Message-ID: <alpine.LNX.1.00.0803052312120.7716@nge2.ngu.pk>
MIME-Version: 1.0
Subject: [Bluez-users] Headset not working, 2.6.24.x style
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





Today I tried to upgrade from the 2.6.23.x series kernels to the 2.6.24.x, and
found that while nothing has changed but the kernel, bluetooth headsets have
stopped working. bluez 3.27 (also noted on bluez 3.25)

Ex:



Authorization request for device 00:1A:45:01:F9:42

hcitool con

Connections:
         > ACL 00:1A:45:01:F9:42 handle 11 state 1 lm MASTER AUTH ENCRYPT SECURE

sox -t mp3 ./sample.mp3 -t alsa pcm.bluetooth

(light on the dongle flashes wildly for about 4 minutes then ...)

ALSA lib pcm_bluetooth.c:460:(bluetooth_hsp_hw_params) BT_SETCONFIGURATION failed : Input/output error(5)
sox stio: Failed writing pcm.bluetooth: cannot set parameters


The connection list is also very strange, I've never seen it like this before. The first
row is new, and never appeared under 2.6.23.x (when bluetooth worked).

hcitool con

Connections:
         < eSCO 00:1A:45:01:F9:42 handle 0 state 8 lm SLAVE
         > ACL 00:1A:45:01:F9:42 handle 11 state 1 lm MASTER AUTH ENCRYPT SECURE


(light on the dongle flashes wildly, endlessly, forever)

The data looks like so:

> SCO data: handle 1 flags 0x00 dlen 24
     . . D . . . + . W . @ . [ . Q . Y . p .
     { . } .
> SCO data: handle 1 flags 0x00 dlen 24
     0 . # . ! . = . J . . . > . f . % . < .
     E . L .
> SCO data: handle 1 flags 0x00 dlen 24
     | . D . , . 6 . O . L . K . R . K . X .
     g . N .
> SCO data: handle 1 flags 0x00 dlen 24
     ? . G . J . . . z . . . $ . . . [ . z .
     F . K .
> SCO data: handle 1 flags 0x00 dlen 24
     ' . * . \ . k . Z . [ . U . @ . 4 . . .
     . . < .
> SCO data: handle 1 flags 0x00 dlen 24
     + . [ . F . . . C . F . T . Y . 2 . G .
     C . 3 .
> SCO data: handle 1 flags 0x00 dlen 24
     A . Z . . . . . r . g . L . o . . . ] .
     N . * .
> SCO data: handle 1 flags 0x00 dlen 24
     H . . . I . S . \ . U . ` . + . . . ? .
     < . : .
> SCO data: handle 1 flags 0x00 dlen 24



yet nothing on the headset.




Removing the force_scofix results in (note SCO MTU):

hci0:   Type: USB
         BD Address: 00:0A:3A:7C:5C:74 ACL MTU: 1017:8 SCO MTU: 64:0
         UP RUNNING PSCAN ISCAN
         RX bytes:462575 acl:65 sco:8935 events:212 errors:0
         TX bytes:2232 acl:59 sco:0 commands:101 errors:0
         Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: '[vdrl] / BT Device 0'
         Class: 0x020108
         Service Classes: Networking
         Device Class: Computer, Server
         HCI Ver: 2.0 (0x3) HCI Rev: 0x4107 LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
         Manufacturer: Broadcom Corporation (15)


Setting force_scofix results in (note SCO MTU):

hci0:   Type: USB
         BD Address: 00:0A:3A:7C:5C:74 ACL MTU: 1017:8 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:1999 acl:29 sco:0 events:57 errors:0
         TX bytes:1063 acl:30 sco:0 commands:32 errors:0
         Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: '[vdrl] / BT Device 0'
         Class: 0x020108
         Service Classes: Networking
         Device Class: Computer, Server
         HCI Ver: 2.0 (0x3) HCI Rev: 0x4107 LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
         Manufacturer: Broadcom Corporation (15)



Neither produces sound on the headset. I have to pull the dongle to get it to stop flashing.
The worst part is nothing has changed but the kernel version, 2.6.23.16 -> 2.6.24.3, so
I have no idea how to debug this. I tried, about a month ago, to jump to the 2.6.24.x
series, and had the same trouble with an earlier 2.6.24.x, but since there was other
areas of the system that were affected by it, I reverted back to 2.6.23.x and forgot
about it. I will have to move to 2.6.24.x sometime, as the 2.6.23.x branch will end.

Is anyone else having trouble under 2.6.24.x when everything used to work fine before?



There is an hcidump for this, but nothing looks to be abnormal.

https://atr2.ath.cx/~jayjwa/download/headset.log.gz

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
