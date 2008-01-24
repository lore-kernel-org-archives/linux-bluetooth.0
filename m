Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Jan 2008 19:12:54 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <860396.82093.qm@web8411.mail.in.yahoo.com>
Subject: Re: [Bluez-users] Headset half working using Bluez's ALSA plugin
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0755614655=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0755614655==
Content-Type: multipart/alternative; boundary="0-1321680657-1201182174=:82093"

--0-1321680657-1201182174=:82093
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi gabriele,=0Ai have not worked much on BlueZ and alsa but i can see from =
your information that you have not configured your kernel to support alsa. =
have a kernel built with alsa configured.=0Abcoz i checked the file /usr/li=
b/alsa-lib/libasound_module_pcm_bluetooth.so which u are missing=0Abut my k=
ernel has as i hv alsa support. also i confirmed this by checking into anot=
her system which dont hv alsa configured in it. =0ATry and c.=0Abest luck..=
..bye=0A=0APramod=0A=0A----- Original Message ----=0AFrom: Ing. Gabriele Obe=
rhammer <gabriele@naustech.com>=0ATo: BlueZ users <bluez-users@lists.source=
forge.net>=0ASent: Thursday, 24 January, 2008 3:37:16 PM=0ASubject: Re: [Bl=
uez-users] Headset half working using Bluez's ALSA plugin=0A=0AHi, I've suc=
cessful compiled and installed 'utils' and 'libs' from=0A today =0Acvs but =
now its worse then before, now playback doesn't work too :-(=0ANow In the p=
references menu in gnome-applet there are no services =0Alisted, but my hea=
dset pairs correctly.=0AHere's what I've done, please tell ma what's wrong:=
=0A=0A1. checked out latest 'utils' and 'libs' directoryes from cvs=0A2. in=
stalled all needed development headers=0A3. Compiled:=0A    $ cd utils/=0A =
   $ sudo ./bootstrap=0A    $ sudo ./configure --enable-all --prefix=3D/usr=
/local/=0A    $ sudo make=0A=0A    $ cd ../libs/=0A    $ sudo ./bootstrap=
=0A    $ sudo ./configure --prefix=3D/usr/local/=0A    $ sudo make=0A=0A4. =
uninstalled bluez-utils:=0A    $ sudo apt-get remove bluez-utils=0A=0A5. un=
installed libbluetooth2 (forcing needed to solve dependencies):=0A    $ sud=
o dpkg --force-all -r libbluetoot2=0A=0A6. Installed libs and utils:=0A    =
$ cd libs; sudo make install=0A    $ cd utils; sudo make install=0A=0A7. Ed=
ited '/etc/init.d/bluetooth' and modified all paths to pont to =0Acorrect l=
ocations under /usr/local/{bin,sbin}=0A=0A8. rebooted (I know it's not need=
ed but I did it)=0A=0A9. Now headset pairs, 'hcitool dev' correctly shows i=
t but=0A    $ mplayer -ao alsa:device=3Dbluetooth test.mp3=0A    =0A    giv=
es:=0A=0A    ....=0A    [AO_ALSA] alsa-lib: pcm.c:2105:(snd_pcm_open_conf) =
Cannot open=0A shared =0Alibrary /usr/lib/alsa-lib/libasound_module_pcm_blu=
etooth.so=0A    [AO_ALSA] Playback open error: No such file or directory=0A=
    ....=0A=0A=0A10. sadness  ;(=0A=0A=0ACan someone help me or give me som=
e link to documentation about correct=0A =0Aprocedures for cvs building?=0A=
=0A=0ATnx  :-)=0A=0A=0A----------------------------------------------------=
---------------------=0AThis SF.net email is sponsored by: Microsoft=0ADefy=
 all challenges. Microsoft(R) Visual Studio 2008.=0Ahttp://clk.atdmt.com/MR=
T/go/vse0120000070mrt/direct/01/=0A________________________________________=
_______=0ABluez-users mailing list=0ABluez-users@lists.sourceforge.net=0Aht=
tps://lists.sourceforge.net/lists/listinfo/bluez-users=0A=0A=0A=0A=0A=0A=0A=
      Unlimited freedom, unlimited storage. Get it now, on http://help.yaho=
o.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/
--0-1321680657-1201182174=:82093
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;">hi gabriele,<br>i have not worked much on BlueZ and=
 alsa but i can see from your information that you have not configured your=
 kernel to support alsa. have a kernel built with alsa configured.<br>bcoz =
i checked the file /usr/lib/alsa-lib/libasound_module_pcm_bluetooth.so whic=
h u are missing<br>but my kernel has as i hv alsa support. also i confirmed=
 this by checking into another system which dont hv alsa configured in it. =
<br>Try and c.<br>best luck...bye<br><br>Pramod<br><br><div style=3D"font-f=
amily: times new roman,new york,times,serif; font-size: 12pt;">----- Origin=
al Message ----<br>From: Ing. Gabriele Oberhammer &lt;gabriele@naustech.com=
&gt;<br>To: BlueZ users &lt;bluez-users@lists.sourceforge.net&gt;<br>Sent:
 Thursday, 24 January, 2008 3:37:16 PM<br>Subject: Re: [Bluez-users] Headse=
t half working using Bluez's ALSA plugin<br><br>Hi, I've successful compile=
d and installed 'utils' and 'libs' from=0A today <br>cvs but now its worse =
then before, now playback doesn't work too :-(<br>Now In the preferences me=
nu in gnome-applet there are no services <br>listed, but my headset pairs c=
orrectly.<br>Here's what I've done, please tell ma what's wrong:<br><br>1. =
checked out latest 'utils' and 'libs' directoryes from cvs<br>2. installed =
all needed development headers<br>3. Compiled:<br>&nbsp;&nbsp;&nbsp; $ cd u=
tils/<br>&nbsp;&nbsp;&nbsp; $ sudo ./bootstrap<br>&nbsp;&nbsp;&nbsp; $ sudo=
 ./configure --enable-all --prefix=3D/usr/local/<br>&nbsp;&nbsp;&nbsp; $ su=
do make<br><br>&nbsp;&nbsp;&nbsp; $ cd ../libs/<br>&nbsp;&nbsp;&nbsp; $ sud=
o ./bootstrap<br>&nbsp;&nbsp;&nbsp; $ sudo ./configure --prefix=3D/usr/loca=
l/<br>&nbsp;&nbsp;&nbsp; $ sudo make<br><br>4. uninstalled bluez-utils:<br>=
&nbsp;&nbsp;&nbsp; $ sudo apt-get remove bluez-utils<br><br>5. uninstalled =
libbluetooth2 (forcing needed to solve dependencies):<br>&nbsp;&nbsp;&nbsp;=
 $ sudo dpkg --force-all -r
 libbluetoot2<br><br>6. Installed libs and utils:<br>&nbsp;&nbsp;&nbsp; $ c=
d libs; sudo make install<br>&nbsp;&nbsp;&nbsp; $ cd utils; sudo make insta=
ll<br><br>7. Edited '/etc/init.d/bluetooth' and modified all paths to pont =
to <br>correct locations under /usr/local/{bin,sbin}<br><br>8. rebooted (I =
know it's not needed but I did it)<br><br>9. Now headset pairs, 'hcitool de=
v' correctly shows it but<br>&nbsp;&nbsp;&nbsp; $ mplayer -ao alsa:device=
=3Dbluetooth test.mp3<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; gives:<b=
r><br>&nbsp;&nbsp;&nbsp; ....<br>&nbsp;&nbsp;&nbsp; [AO_ALSA] alsa-lib: pcm=
..c:2105:(snd_pcm_open_conf) Cannot open=0A shared <br>library /usr/lib/alsa=
-lib/libasound_module_pcm_bluetooth.so<br>&nbsp;&nbsp;&nbsp; [AO_ALSA] Play=
back open error: No such file or directory<br>&nbsp;&nbsp;&nbsp; ....<br><b=
r><br>10. sadness&nbsp; ;(<br><br><br>Can someone help me or give me some l=
ink to documentation about correct=0A <br>procedures for cvs building?<br><=
br><br>Tnx&nbsp; :-)<br><br><br>-------------------------------------------=
------------------------------<br>This SF.net email is sponsored by: Micros=
oft<br>Defy all challenges. Microsoft(R) Visual Studio 2008.<br><a href=3D"=
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target=3D"_blank">=
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>____________=
___________________________________<br>Bluez-users mailing list<br><a ymail=
to=3D"mailto:Bluez-users@lists.sourceforge.net" href=3D"mailto:Bluez-users@=
lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href=3D"=
https://lists.sourceforge.net/lists/listinfo/bluez-users" target=3D"_blank"=
>https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></div><br>=
</div></div><br>=0A=0A=0A      <!--4--><hr size=3D1></hr> Forgot the famous=
 last words? Access your message archive online. <a href=3D"http://in.rd.ya=
hoo.com/tagline_webmessenger_4/*http://in.messenger.yahoo.com/webmessengerp=
romo.php">Click here.</a></body></html>
--0-1321680657-1201182174=:82093--



--===============0755614655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0755614655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0755614655==--
