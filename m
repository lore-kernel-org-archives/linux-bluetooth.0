Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY117-W37C6A8E0F3928E79441D6EC0640@phx.gbl>
From: "" <semiyd@hotmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Tue, 11 Dec 2007 02:57:16 +0000
In-Reply-To: <2d5a2c100712100522v553270a0o3eafede56bb3566b@mail.gmail.com>
References: <BAY117-W2635D88EDFC550AA345DFAC06B0@phx.gbl>
	<2d5a2c100712100522v553270a0o3eafede56bb3566b@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] bluez 3.23 "cannot
	open	libasound_module_pcm_bluetooth.so" issue on A2DP
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


Hi :
     I have to say i made a mistake in my former statement ;-) . Sorry for =
the inconvience...

     The situation is like this :
    =

     1.the prefix of bluez and alsa are both /bluetooth.
     2. Im using an embeded system which is running on NFS from my host com=
puter.   And "/bluetooth" is on my host computer and is the installation di=
rectory after i cross-compiled packeges like bluez/alsa.  The NFS on the ho=
st computer is actually "/work/rootfs" . So everytime i "make install " the=
 stuff into /bluetooth , i also have to copy things in /bluetooth into /wor=
k/rootfs so that my embeded system could use it as NFS.
     3. From my embeded system's point of view: After it mounted on NFS pro=
vided by the host computer,  the libasound_module_pcm_bluetooth.so is actua=
lly right there in /lib/alsa-lib.  And binaries like aplay is in /bin. I al=
so created a directory of /bluetooth and put some links into it .  Like thi=
s:

/bluetooth $ ls -l
lrwxrwxrwx 1 root root 4 Nov 12 2007 etc -> /etc
lrwxrwxrwx 1 root root 4 Nov 12 2007 lib -> /lib
lrwxrwxrwx 1 root root 6 Nov 12 2007 share -> /share
lrwxrwxrwx 1 root root 4 Nov 12 2007 usr -> /usr
lrwxrwxrwx 1 root root 4 Nov 12 2007 var -> /var

The reason im doing this is applications like aplay tends to search its plu=
gin libararies like libasound_module_pcm_bluetooth.so in /bluetooth/lib/als=
a-lib..

This method work fine before 3.23...
In 3.23, aplay turns out to say:
"Cannot open shared library /bluetooth//lib/alsa-lib/libasound_module_pcm_b=
luetooth.so"

Actually , maybe there's another clue.  If I replaced libasound_module_pcm_=
bluetooth.so with libraries of an older version like 3.22 in the same direc=
tory ,  the aplay no longer reports a "Cannot open shared library" error wh=
en i use aplay -D bluetooth. Although A2DP still can't work cause the versi=
on of the plugin lib is not right.


Anyway, sorry for any misunderstanding i caused. =

Could someone tell me what should i do now?



Thanks


semiyd

     =



> Date: Mon, 10 Dec 2007 10:22:01 -0300
> From: luiz.dentz@gmail.com
> To: bluez-users@lists.sourceforge.net
> Subject: Re: [Bluez-users] bluez 3.23 "cannot open libasound_module_pcm_b=
luetooth.so" issue on A2DP
>
> On Dec 10, 2007 12:03 AM,  wrote:
>>
>> Hi all:
>>
>> I just upgraded my bluez from 3.22 to 3.23.
>> My ./configure param is like this:
>> bluez-libs-3.23:
>> ./configure --host=3Darm-linux --prefix=3D/bluetooth
>> bluez-utils-3.23:
>> ./configure --host=3Darm-linux --prefix=3D/bluetooth/ --enable-test --en=
able-usb --enable-input --enable-serial --enable-initscripts --enable-bccmd=
 --enable-cups --disable-pcmia --enable-alsa --enable-audio --enable-shared=
 PKG_CONFIG=3Dpkg-config --enable-obex --enable-avctrl --enable-network --e=
nable-debug
>>
>> A2DP works fine on 3.22.But I got the following error when i tried to pl=
ay a2dp using "aplay -D bluetooth" in the 3.23:
>>
>> / $ aplay -D bluetooth /tmp/1.wav
>> ALSA lib pcm.c:2106:(snd_pcm_open_conf) Cannot open shared library /blue=
tooth//lib/alsa-lib/libasound_module_pcm_bluetooth.so
>> aplay: main:546: audio open error: No such file or directory
>>
>>
>> BTW, my "libasound_module_pcm_bluetooth.so" is always in /bluetooth/lib/=
alsa-lib , not /lib/alsa-lib . Because my '--prefix' is /bluetooth.
>>
>> Is there anything wrong in my param of ./configure ? Or something else i=
s causing the issue?
>
> Installing in /bluetooth/lib/alsa-lib will not going to work, the same
> applies to gstreamer plugin it must be installed in the prefix that
> the application will load its plugins. You can either install the alsa
> and gstreamer binaries in /bluetooth or change your prefix.
>
>
> --
> Luiz Augusto von Dentz
> Engenheiro de Computa=E7=E3o
>
> -------------------------------------------------------------------------
> SF.Net email is sponsored by:
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

_________________________________________________________________
Invite your mail contacts to join your friends list with Windows Live Space=
s. It's easy!
http://spaces.live.com/spacesapi.aspx?wx_action=3Dcreate&wx_url=3D/friends.=
aspx&mkt=3Den-us
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
