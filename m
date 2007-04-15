Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 15 Apr 2007 02:57:29 -0700
From: Brandon Philips <brandon@ifup.org>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070415095728.GA6212@ifup.org>
MIME-Version: 1.0
Subject: [Bluez-devel] Unable to set number of SCO buffers : please upgrade
	your Kernel !
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

Hello-

I am running 2.6.21-rc6 with sco-flowcontrol-v4.2.diff applied and I am
getting the following error when trying to use my Platronics 640
headset.  The computer is a Thinkpad x60s running Debian unstable.

Any suggestions?  I am willing to test patches, etc.

Cheers,

	Brandon

philips@plankton:~$ aplay -D headset /usr/share/sounds/ekiga/busytone.wav
Playing WAVE '/usr/share/sounds/ekiga/busytone.wav' : Signed 16 bit
Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_sco.c:273:(sco_headset_hw_params) Unable to set number of
SCO buffers : please upgrade your Kernel !
aplay: set_params:965: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 3000
PERIOD_SIZE: 24
PERIOD_BYTES: 48
PERIODS: 167
BUFFER_TIME: 501000
BUFFER_SIZE: 4008
BUFFER_BYTES: 8016
TICK_TIME: [0 0]

philips@plankton:~$ headsetd -n
headsetd[6326]: Bluetooth headset daemon version 0.5
headsetd[6326]: Configuration phase ended: target bdaddr is
00:03:89:59:DE:F9, timeout is 6000 ms
headsetd[6326]: Changing state: Idle-->Paging
headsetd[6326]: Changing state: Paging-->Connecting
headsetd[6326]: Changing state: Connecting-->Ready
headsetd[6326]: Changing state: Ready-->Opening
headsetd[6326]: SCO channel opened handle=0x0001 mtu=64
headsetd[6326]: Changing state: Opening-->Streaming
headsetd[6326]: Appli closed socket
headsetd[6326]: Changing state: Streaming-->Zombie
headsetd[6326]: Nobody uses SCO channel anymore, closing it.
headsetd[6326]: Changing state: Zombie-->Connected

Relevant dmesg output:
hci_scodata_packet: hci0 SCO packet for unknown connection handle 1

~/.asoundrc
pcm.headset {
        @args [BDADDR TIMEOUT]

        # The Bluetooth device address for target headset, used for
        # Audio Gateway (PC) initiated connections
        # Please note that this value is ignored when the connection is
        # Headset initiated
        @args.BDADDR {
                type string
                default 00:03:89:59:XX:XX  # XX:XX for privacy
        }

        # This value represents how long we will try to reach the
        # headset, until we give up.
        # Value is in milliseconds
        @args.TIMEOUT {
                type integer
                default 6000
        }

        type        sco
        bdaddr      $BDADDR
        timeout     $TIMEOUT
}

ctl.headset {
        type sco
}


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
