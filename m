Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 29 Oct 2006 16:00:32 +0100
From: =?ISO-8859-1?Q?fabrice_r=E9gnier?= <regnier.fab@free.fr>
In-reply-to: <4544A47A.2040104@free.fr>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-id: <4544C210.90702@free.fr>
MIME-version: 1.0
References: <4540D480.1030203@free.fr> <4541CA6E.4010003@free.fr>
	<4541F314.10408@xmission.com> <4544A47A.2040104@free.fr>
Subject: Re: [Bluez-users] btsco fails: control open (hw:1): No such device
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi all,

I'm still fighting with btsco :(

FR-PORT:~/btsco/kernel# btsco -v 00:03:89:AB:3D:76
btsco v0.42
Error: control open (hw:1): No such device
Error: Can't find device. Bail

How could i debug this ?

I'm nearly sure it's because alsa conf. I even did uninstall/reinstall =

alsa with no success.

Here is my sound file
FR-PORT:/etc/modprobe.d# cat sound
alias snd-card-0 snd-intel8x0
alias snd-card-1 snd_usb_audio
alias snd-card-2 snd_bt_sco

options snd-intel8x0 index=3D0
options snd_usb_audio index=3D1
options snd_bt_sco index=3D2

Do you think i should give up with bluetooth and play again with my old =

headset with cable ?

regards,

f.



fabrice r=E9gnier wrote:
> Hi ;)
> =

> I had a look at
>> https://help.ubuntu.com/community/BluetoothAudio
> What should my .asoundrc look like with btsco stuff ?
> =

> I'm not sure this .asoundrc is ok.
> =

> fabricer@FR-PORT:~$ cat .asoundrc
> pcm.bluetooth {
>         type a2dp
>         bdaddr "00:03:89:AB:3D:76"
> }
> =

> cuz, i don't use a2dp but btsco instead.
> =

> should i write "type btsco" ?
> =

> regards,
> =

> f.
> =

> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> =

> =



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
