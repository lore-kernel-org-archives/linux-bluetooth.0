Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY117-W2635D88EDFC550AA345DFAC06B0@phx.gbl>
From: "" <semiyd@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Mon, 10 Dec 2007 03:03:19 +0000
MIME-Version: 1.0
Subject: [Bluez-users] bluez 3.23 "cannot open
 libasound_module_pcm_bluetooth.so" issue on A2DP
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Hi all:

        I just upgraded my bluez from 3.22 to 3.23.
        My ./configure param is like this:
bluez-libs-3.23:
./configure --host=3Darm-linux --prefix=3D/bluetooth
bluez-utils-3.23:
./configure --host=3Darm-linux --prefix=3D/bluetooth/ --enable-test --enabl=
e-usb --enable-input --enable-serial --enable-initscripts --enable-bccmd --=
enable-cups --disable-pcmia --enable-alsa --enable-audio --enable-shared PK=
G_CONFIG=3Dpkg-config --enable-obex --enable-avctrl --enable-network --enab=
le-debug

        A2DP works fine on 3.22.But I got the following error when i tried =
to play a2dp using "aplay -D bluetooth" in the 3.23:
        =

/ $ aplay -D bluetooth /tmp/1.wav
     ALSA lib pcm.c:2106:(snd_pcm_open_conf) Cannot open shared library /bl=
uetooth//lib/alsa-lib/libasound_module_pcm_bluetooth.so
aplay: main:546: audio open error: No such file or directory


BTW, my "libasound_module_pcm_bluetooth.so" is always in /bluetooth/lib/als=
a-lib , not /lib/alsa-lib . Because my '--prefix' is /bluetooth.

Is there anything wrong in my param of ./configure ?  Or something else is =
causing the issue?





Thanks



semiyd

_________________________________________________________________
Connect to the next generation of MSN Messenger=A0
http://imagine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&sourc=
e=3Dwlmailtagline
-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
