Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60612180843r5faa3f3bwcc8d46e0bea1d31f@mail.gmail.com>
Date: Mon, 18 Dec 2006 08:43:58 -0800
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>, seife@suse.de
In-Reply-To: <20061218090638.GB960@suse.de>
MIME-Version: 1.0
References: <be976db60612172156l60a7124bsc9a02b4d1a68c455@mail.gmail.com>
	<20061218090638.GB960@suse.de>
Subject: Re: [Bluez-users] minicom over /dev/rfcomm0 failed
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1921177131=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1921177131==
Content-Type: multipart/alternative;
	boundary="----=_Part_23860_5245409.1166460238117"

------=_Part_23860_5245409.1166460238117
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Stefan:  Below are the various info that you asked for.  Let me know if
you notice anything I did that is wrong.


linux-fqoe:~ # rfcomm
rfcomm0: 00:80:98:98:A2:28 channel 1 clean
linux-fqoe:~ #
linux-fqoe:~ # id
uid=3D0(root) gid=3D0(root) groups=3D0(root)
linux-fqoe:~ # cat /etc/bluetooth/rfcomm.conf
#
# RFCOMM configuration file.
#

rfcomm0 {
        bind yes;
        device 00:80:98:98:A2:28;
        channel 1;
}
linux-fqoe:~ #
linux-fqoe:~ # ls -l /dev/rfcomm0
crw-rw---- 1 root root 216, 0 Dec 18 08:16 /dev/rfcomm0
linux-fqoe:~ #
linux-fqoe:~ #
linux-fqoe:~ # minicom
LANG/ja
LANG/ko
LANG/ru
minicom: cannot open /dev/rfcomm0: No such file or directory


Mark




On 12/18/06, Stefan Seyfried <seife@suse.de> wrote:
>
> On Sun, Dec 17, 2006 at 09:56:40PM -0800, Mark S. Townsley wrote:
> > Hi:
> > I am trying to use minicom on my SuSE box to receive connections from a=
n
> > external device that connect, via Bluetooth, and handshake with the AT
> > command set.
> > I have /dev/rfcomm0.  I also have entries in /dev/rfcomm0 that binds to
> the
> > BT_ADDR of that external device.
> > However, when I run minicom (with serial device set to /dev/rfcomm0), I
> got
> > back:
> >
> >  minicom: cannot open /dev/rfcomm0: No such file or directory.
> >
> > I do have /dev/rfcomm0 and the permission on it looks correct.
>
> Please show us your /etc/bluetooth/rfcomm.conf, the output of "rfcomm" as
> root, "ls -l /dev/rfcomm0" and "id" as your user.
> --
> Stefan Seyfried
> QA / R&D Team Mobile Devices        |              "Any ideas, John?"
> SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_23860_5245409.1166460238117
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Stefan:&nbsp; Below are the various info that you asked for.&nbsp; Let m=
e know if you notice anything I did that is wrong.<br><br><br>linux-fqoe:~ =
# rfcomm<br>rfcomm0: 00:80:98:98:A2:28 channel 1 clean <br>linux-fqoe:~ # <=
br>linux-fqoe:~ # id
<br>uid=3D0(root) gid=3D0(root) groups=3D0(root)<br>linux-fqoe:~ # cat /etc=
/bluetooth/rfcomm.conf <br>#<br># RFCOMM configuration file.<br>#<br><br>rf=
comm0 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bind yes;<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device 00:80:98:98:A2:28;<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; channel 1;
<br>}<br>linux-fqoe:~ # <br>linux-fqoe:~ # ls -l /dev/rfcomm0 <br>crw-rw---=
- 1 root root 216, 0 Dec 18 08:16 /dev/rfcomm0<br>linux-fqoe:~ # <br>linux-=
fqoe:~ # <br>linux-fqoe:~ # minicom<br>LANG/ja<br>LANG/ko<br>LANG/ru<br>
minicom: cannot open /dev/rfcomm0: No such file or directory<br><br><br>Mar=
k<br><br><br><br><br><div><span class=3D"gmail_quote">On 12/18/06, <b class=
=3D"gmail_sendername">Stefan Seyfried</b> &lt;<a href=3D"mailto:seife@suse.=
de">
seife@suse.de</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">On Sun, Dec 17, 2006 at 09:56:40PM -0800, Mark S. Townsl=
ey wrote:
<br>&gt; Hi:<br>&gt; I am trying to use minicom on my SuSE box to receive c=
onnections from an<br>&gt; external device that connect, via Bluetooth, and=
 handshake with the AT<br>&gt; command set.<br>&gt; I have /dev/rfcomm0.&nb=
sp;&nbsp;I also have entries in /dev/rfcomm0 that binds to the
<br>&gt; BT_ADDR of that external device.<br>&gt; However, when I run minic=
om (with serial device set to /dev/rfcomm0), I got<br>&gt; back:<br>&gt;<br=
>&gt;&nbsp;&nbsp;minicom: cannot open /dev/rfcomm0: No such file or directo=
ry.<br>
&gt;<br>&gt; I do have /dev/rfcomm0 and the permission on it looks correct.=
<br><br>Please show us your /etc/bluetooth/rfcomm.conf, the output of &quot=
;rfcomm&quot; as<br>root, &quot;ls -l /dev/rfcomm0&quot; and &quot;id&quot;=
 as your user.
<br>--<br>Stefan Seyfried<br>QA / R&amp;D Team Mobile Devices&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;Any ideas, John?&quot;<br=
>SUSE LINUX Products GmbH, N=FCrnberg&nbsp;&nbsp;| &quot;Well, surrounding =
them's out.&quot;<br><br>--------------------------------------------------=
-----------------------
<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge=
.net's Techsay panel and you'll get the chance to share your<br>opinions on=
 IT &amp; business topics through brief surveys - and earn cash<br><a href=
=3D"http://www.techsay.com/default.php?page=3Djoin.php&amp;p=3Dsourceforge&=
amp;CID=3DDEVDEV">
http://www.techsay.com/default.php?page=3Djoin.php&amp;p=3Dsourceforge&amp;=
CID=3DDEVDEV</a><br>_______________________________________________<br>Blue=
z-users mailing list<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net=
">Bluez-users@lists.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users=
">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockqu=
ote></div><br>

------=_Part_23860_5245409.1166460238117--


--===============1921177131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1921177131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1921177131==--
