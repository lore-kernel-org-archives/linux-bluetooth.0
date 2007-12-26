Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY117-W147DA2514E5F1F2BED1095C05B0@phx.gbl>
From: "" <semiyd@hotmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Wed, 26 Dec 2007 05:41:46 +0000
In-Reply-To: <BAY117-W37C6A8E0F3928E79441D6EC0640@phx.gbl>
References: <BAY117-W2635D88EDFC550AA345DFAC06B0@phx.gbl>
	<2d5a2c100712100522v553270a0o3eafede56bb3566b@mail.gmail.com>
	<BAY117-W37C6A8E0F3928E79441D6EC0640@phx.gbl>
MIME-Version: 1.0
Subject: Re: [Bluez-users] bluez 3.23
	"cannot	open	libasound_module_pcm_bluetooth.so" issue on A2DP
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


Problem solved.

from bluez 3.23 on ,  librt.so  is required .


But there's no related error information when i used "aplay -D bluetooth".

So i used strace and found why this "cannot open libasound_module_pcm_bluet=
ooth.so" error happened.






> From: semiyd@hotmail.com
> To: bluez-users@lists.sourceforge.net
> Date: Tue, 11 Dec 2007 02:57:16 +0000
> Subject: Re: [Bluez-users] bluez 3.23 "cannot open libasound_module_pcm_b=
luetooth.so" issue on A2DP
>
>
> Hi :
> I have to say i made a mistake in my former statement ;-) . Sorry for the=
 inconvience...
>
> The situation is like this :
>
> 1.the prefix of bluez and alsa are both /bluetooth.
> 2. Im using an embeded system which is running on NFS from my host comput=
er. And "/bluetooth" is on my host computer and is the installation directo=
ry after i cross-compiled packeges like bluez/alsa. The NFS on the host com=
puter is actually "/work/rootfs" . So everytime i "make install " the stuff=
 into /bluetooth , i also have to copy things in /bluetooth into /work/root=
fs so that my embeded system could use it as NFS.
> 3. From my embeded system's point of view: After it mounted on NFS provid=
ed by the host computer, the libasound_module_pcm_bluetooth.so is actually =
right there in /lib/alsa-lib. And binaries like aplay is in /bin. I also cr=
eated a directory of /bluetooth and put some links into it . Like this:
>
> /bluetooth $ ls -l
> lrwxrwxrwx 1 root root 4 Nov 12 2007 etc -> /etc
> lrwxrwxrwx 1 root root 4 Nov 12 2007 lib -> /lib
> lrwxrwxrwx 1 root root 6 Nov 12 2007 share -> /share
> lrwxrwxrwx 1 root root 4 Nov 12 2007 usr -> /usr
> lrwxrwxrwx 1 root root 4 Nov 12 2007 var -> /var
>
> The reason im doing this is applications like aplay tends to search its p=
lugin libararies like libasound_module_pcm_bluetooth.so in /bluetooth/lib/a=
lsa-lib..
>
> This method work fine before 3.23...
> In 3.23, aplay turns out to say:
> "Cannot open shared library /bluetooth//lib/alsa-lib/libasound_module_pcm=
_bluetooth.so"
>
> Actually , maybe there's another clue. If I replaced libasound_module_pcm=
_bluetooth.so with libraries of an older version like 3.22 in the same dire=
ctory , the aplay no longer reports a "Cannot open shared library" error wh=
en i use aplay -D bluetooth. Although A2DP still can't work cause the versi=
on of the plugin lib is not right.
>
>
> Anyway, sorry for any misunderstanding i caused.
> Could someone tell me what should i do now?
>
>
>
> Thanks
>
>
> semiyd
>
>
>
>
>> Date: Mon, 10 Dec 2007 10:22:01 -0300
>> From: luiz.dentz@gmail.com
>> To: bluez-users@lists.sourceforge.net
>> Subject: Re: [Bluez-users] bluez 3.23 "cannot open libasound_module_pcm_=
bluetooth.so" issue on A2DP
>>
>> On Dec 10, 2007 12:03 AM, wrote:
>>>
>>> Hi all:
>>>
>>> I just upgraded my bluez from 3.22 to 3.23.
>>> My ./configure param is like this:
>>> bluez-libs-3.23:
>>> ./configure --host=3Darm-linux --prefix=3D/bluetooth
>>> bluez-utils-3.23:
>>> ./configure --host=3Darm-linux --prefix=3D/bluetooth/ --enable-test --e=
nable-usb --enable-input --enable-serial --enable-initscripts --enable-bccm=
d --enable-cups --disable-pcmia --enable-alsa --enable-audio --enable-share=
d PKG_CONFIG=3Dpkg-config --enable-obex --enable-avctrl --enable-network --=
enable-debug
>>>
>>> A2DP works fine on 3.22.But I got the following error when i tried to p=
lay a2dp using "aplay -D bluetooth" in the 3.23:
>>>
>>> / $ aplay -D bluetooth /tmp/1.wav
>>> ALSA lib pcm.c:2106:(snd_pcm_open_conf) Cannot open shared library /blu=
etooth//lib/alsa-lib/libasound_module_pcm_bluetooth.so
>>> aplay: main:546: audio open error: No such file or directory
>>>
>>>
>>> BTW, my "libasound_module_pcm_bluetooth.so" is always in /bluetooth/lib=
/alsa-lib , not /lib/alsa-lib . Because my '--prefix' is /bluetooth.
>>>
>>> Is there anything wrong in my param of ./configure ? Or something else =
is causing the issue?
>>
>> Installing in /bluetooth/lib/alsa-lib will not going to work, the same
>> applies to gstreamer plugin it must be installed in the prefix that
>> the application will load its plugins. You can either install the alsa
>> and gstreamer binaries in /bluetooth or change your prefix.
>>
>>
>> --
>> Luiz Augusto von Dentz
>> Engenheiro de Computa=E7=E3o
>>
>> -------------------------------------------------------------------------
>> SF.Net email is sponsored by:
>> Check out the new SourceForge.net Marketplace.
>> It's the best place to buy or sell services for
>> just about anything Open Source.
>> http://sourceforge.net/services/buy/index.php
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
> _________________________________________________________________
> Invite your mail contacts to join your friends list with Windows Live Spa=
ces. It's easy!
> http://spaces.live.com/spacesapi.aspx?wx_action=3Dcreate&wx_url=3D/friend=
s.aspx&mkt=3Den-us
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
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
