Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <454B37A5.5000307@evision.de>
Date: Fri, 03 Nov 2006 13:35:49 +0100
From: Tobias Wolf <tobias.wolf@evision.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Bluetooth-Alsa: headsetd
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

Hello,

i want to connect Bluetooth-Headsets to my Linux-Workstation for
Voip-Telephony with Ekiga.

So far i have used the btsco2 Userspace-Program with the kernel module
snd_bt_sco.

This is the Hardware, i've been working with:

BT-Dongle: Hama

hciconfig -a
hci0:   Type: USB
        BD Address: 00:10:60:D0:96:1A ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:808 acl:0 sco:0 events:29 errors:0
        TX bytes:460 acl:0 sco:0 commands:28 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'toa8-0'
        Class: 0x100100
        Service Classes:
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x460 LMP Ver: 1.1 (0x1) LMP Subver:
0x460
        Manufacturer: Cambridge Silicon Radio (10)


hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:10:60:D0:96:1A ACL MTU: 192:8 SCO MTU: 64:8
        HCI 17.11
        Chip version: BlueCore02
        Max key size: 128 bit
        SCO mapping:  HCI

BT-Headset: Logitech Mobile Pro

With the kernel module and btsco2 i have succesfully connected the
headset with Ekiga and was able to make a phone call. Quality was pretty
good, although it happens from time to time the the called person hears
and awfully loud noise for a second or so. No fun in the long run.

So i took a look at http://bluetooth-alsa.sourceforge.net/ and saw that
Brad Midgley has done some updating on the doku since i visited the page
last time.

I read through the instructions on
https://help.ubuntu.com/community/BluetoothAudio. Specially the section
about "Configure SCO (aka mono, aka voice) Driver" and the "preferred
method" without any kernel module impressed me much.

But here starts my misery :S

1) I have compiled and installed project according to the instructions
found in btsco/alsa-plugins/BUILD. I think the alsa-libs were installed.

2) I have created the .asoundrc file:
# ALSA library configuration file

pcm.headset {
        @args [BDADDR TIMEOUT MAX_PERIODS]

        # The Bluetooth device address for target headset, used for
Audio Gateway (PC) initiated connections
        # Please note that this value is ignored when the connection is
Headset initiated
        @args.BDADDR {
                type string
                #default "00:13:17:30:B2:55" # Put your HS address here
                default "00:0D:44:5C:86:BA" # Logitech HS05  V02
        }

        # This value represents how long we will try to reach the
headset, until we give up.
        # Value is in milliseconds
        @args.TIMEOUT {
                type integer
                default 6000
        }

        # This is the size of the buffer used to queue Voice packets.
Value must be between
        # 2 and 334 (~ 1 second). Default value is 2 buffers, which
works well most of the
        # time, and has the advantage of giving us an ultra low delay
        @args.MAX_PERIODS {
                type integer
                default 334
        }

        type        sco
        bdaddr      $BDADDR
        timeout     $TIMEOUT
        max_periods $MAX_PERIODS
}

ctl.headset {
        type sco
}

pcm.a2dpd {
        type a2dpd
}

# Include settings that are under the control of asoundconf(1).
# (To disable these settings, comment out this line.)
</home/tobias/.asoundrc.asoundconf>

3) Now, the instructions tell me to change the device of, eg xmms to
headset, but the device never shows up (even after an reboot). So i
wanted to test with aplay:

aplay -B 1000000 -Dplug:pcm.headset /usr/share/sounds/alsa/Noise.wav

or

aplay -B 1000000 -D headset /usr/share/sounds/alsa/Noise.wav

With this result:

DEBUG: _snd_pcm_sco_open: Starting pcm_sco plugin.
DEBUG: _snd_pcm_sco_open: Open mode is for Playback.
aplay: main:544: Cannot open Audio Device: Permission denied

/var/log/daemon.log shows the following:
Nov  3 13:23:30 toa8 headsetd[14268]: Configuration phase ended: target
bdaddr is 00:0D:44:5C:86:BA, timeout is 6000 ms
Nov  3 13:23:30 toa8 headsetd[14268]: Changing state: Idle-->Paging
Nov  3 13:23:31 toa8 hcid[3371]: link_key_request
(sba=00:10:60:D0:96:1A, dba=00:0D:44:5C:86:BA)
Nov  3 13:23:31 toa8 headsetd[14268]: unable to connect L2CAP socket to
headset: Permission denied
Nov  3 13:23:31 toa8 headsetd[14268]: Changing state: Paging-->Idle


Has anyone a clue why i cant connect to L2CAP socket and what i have to
enable this ?

Furthermore, does anyone know if there exist the possibility to actually
 take an incoming come by pressing a button on the headset. In my setup
i have to be a my workstation and click on a button on my Softfon to
take a call.

Any help is greatly appreciated ;)

Have a nice Week-End,

Tobias Wolf

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
