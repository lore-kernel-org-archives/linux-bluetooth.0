Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <2d5a2c100712100522v553270a0o3eafede56bb3566b@mail.gmail.com>
Date: Mon, 10 Dec 2007 10:22:01 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY117-W2635D88EDFC550AA345DFAC06B0@phx.gbl>
MIME-Version: 1.0
References: <BAY117-W2635D88EDFC550AA345DFAC06B0@phx.gbl>
Subject: Re: [Bluez-users] bluez 3.23 "cannot open
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

On Dec 10, 2007 12:03 AM,  <semiyd@hotmail.com> wrote:
>
> Hi all:
>
>         I just upgraded my bluez from 3.22 to 3.23.
>         My ./configure param is like this:
> bluez-libs-3.23:
> ./configure --host=3Darm-linux --prefix=3D/bluetooth
> bluez-utils-3.23:
> ./configure --host=3Darm-linux --prefix=3D/bluetooth/ --enable-test --ena=
ble-usb --enable-input --enable-serial --enable-initscripts --enable-bccmd =
--enable-cups --disable-pcmia --enable-alsa --enable-audio --enable-shared =
PKG_CONFIG=3Dpkg-config --enable-obex --enable-avctrl --enable-network --en=
able-debug
>
>         A2DP works fine on 3.22.But I got the following error when i trie=
d to play a2dp using "aplay -D bluetooth" in the 3.23:
>
> / $ aplay -D bluetooth /tmp/1.wav
>      ALSA lib pcm.c:2106:(snd_pcm_open_conf) Cannot open shared library /=
bluetooth//lib/alsa-lib/libasound_module_pcm_bluetooth.so
> aplay: main:546: audio open error: No such file or directory
>
>
> BTW, my "libasound_module_pcm_bluetooth.so" is always in /bluetooth/lib/a=
lsa-lib , not /lib/alsa-lib . Because my '--prefix' is /bluetooth.
>
> Is there anything wrong in my param of ./configure ?  Or something else i=
s causing the issue?

Installing in /bluetooth/lib/alsa-lib will not going to work, the same
applies to gstreamer plugin it must be installed in the prefix that
the application will load its plugins. You can either install the alsa
and gstreamer binaries in /bluetooth or change your prefix.


-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

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
