Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60612181006p70bc77ceq1c0bb7c113c9d3d8@mail.gmail.com>
Date: Mon, 18 Dec 2006 10:06:09 -0800
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "Stefan Seyfried" <seife@suse.de>
In-Reply-To: <20061218173426.GC13541@suse.de>
MIME-Version: 1.0
References: <be976db60612172156l60a7124bsc9a02b4d1a68c455@mail.gmail.com>
	<20061218090638.GB960@suse.de>
	<be976db60612180843r5faa3f3bwcc8d46e0bea1d31f@mail.gmail.com>
	<20061218173426.GC13541@suse.de>
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
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
Content-Type: multipart/mixed; boundary="===============1930625202=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1930625202==
Content-Type: multipart/alternative;
	boundary="----=_Part_26197_24484050.1166465169847"

------=_Part_26197_24484050.1166465169847
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Yes, that is the correct BT addr of the BT module that is trying to connect
to my SuSE box.
And I am running SuSE 10.1

thanks


On 12/18/06, Stefan Seyfried <seife@suse.de> wrote:
>
> On Mon, Dec 18, 2006 at 08:43:58AM -0800, Mark S. Townsley wrote:
> > Hi Stefan:  Below are the various info that you asked for.  Let me know
> if
> > you notice anything I did that is wrong.
> >
> >
> > linux-fqoe:~ # rfcomm
> > rfcomm0: 00:80:98:98:A2:28 channel 1 clean
> > linux-fqoe:~ #
> > linux-fqoe:~ # id
> > uid=3D0(root) gid=3D0(root) groups=3D0(root)
> > linux-fqoe:~ # cat /etc/bluetooth/rfcomm.conf
> > #
> > # RFCOMM configuration file.
> > #
> >
> > rfcomm0 {
> >        bind yes;
> >        device 00:80:98:98:A2:28;
>
> is this the correct BDADDR?
> Did you already pair the devices?
>
> What SUSE version are you using?
>
> >        channel 1;
> > }
> > linux-fqoe:~ #
> > linux-fqoe:~ # ls -l /dev/rfcomm0
> > crw-rw---- 1 root root 216, 0 Dec 18 08:16 /dev/rfcomm0
> > linux-fqoe:~ #
> > linux-fqoe:~ #
> > linux-fqoe:~ # minicom
> > LANG/ja
> > LANG/ko
> > LANG/ru
> > minicom: cannot open /dev/rfcomm0: No such file or directory
>
> This works for me, i only get "No such file or directory if i enter the
> wrong
> BDADDR in the rfcomm.conf file or if i wait too long during the "do you
> want
> to allow device foobar to access the internet via the phone" dialog with
> confirming (on the phone).
> --
> Stefan Seyfried                  \ "I didn't want to write for pay. I
> QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
> SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Cohe=
n
>

------=_Part_26197_24484050.1166465169847
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>Yes, that is the correct BT addr of the BT module that is trying to con=
nect to my SuSE box.<br>And I am running SuSE 10.1<br><br>thanks<br><br><br=
><div><span class=3D"gmail_quote">On 12/18/06, <b class=3D"gmail_sendername=
">
Stefan Seyfried</b> &lt;<a href=3D"mailto:seife@suse.de">seife@suse.de</a>&=
gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-left: 1p=
x solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">=
On Mon, Dec 18, 2006 at 08:43:58AM -0800, Mark S. Townsley wrote:
<br>&gt; Hi Stefan:&nbsp;&nbsp;Below are the various info that you asked fo=
r.&nbsp;&nbsp;Let me know if<br>&gt; you notice anything I did that is wron=
g.<br>&gt;<br>&gt;<br>&gt; linux-fqoe:~ # rfcomm<br>&gt; rfcomm0: 00:80:98:=
98:A2:28 channel 1 clean
<br>&gt; linux-fqoe:~ #<br>&gt; linux-fqoe:~ # id<br>&gt; uid=3D0(root) gid=
=3D0(root) groups=3D0(root)<br>&gt; linux-fqoe:~ # cat /etc/bluetooth/rfcom=
m.conf<br>&gt; #<br>&gt; # RFCOMM configuration file.<br>&gt; #<br>&gt;<br>=
&gt; rfcomm0 {
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bind yes;<br>&gt;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;device 00:80:98:98:A2:28;<br>=
<br>is this the correct BDADDR?<br>Did you already pair the devices?<br><br=
>What SUSE version are you using?<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;channel 1;<br>&gt; }<br>
&gt; linux-fqoe:~ #<br>&gt; linux-fqoe:~ # ls -l /dev/rfcomm0<br>&gt; crw-r=
w---- 1 root root 216, 0 Dec 18 08:16 /dev/rfcomm0<br>&gt; linux-fqoe:~ #<b=
r>&gt; linux-fqoe:~ #<br>&gt; linux-fqoe:~ # minicom<br>&gt; LANG/ja<br>
&gt; LANG/ko<br>&gt; LANG/ru<br>&gt; minicom: cannot open /dev/rfcomm0: No =
such file or directory<br><br>This works for me, i only get &quot;No such f=
ile or directory if i enter the wrong<br>BDADDR in the rfcomm.conf file or =
if i wait too long during the &quot;do you want
<br>to allow device foobar to access the internet via the phone&quot; dialo=
g with<br>confirming (on the phone).<br>--<br>Stefan Seyfried&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;\ &quot;I didn't want to write for pay. I<br>QA / R&amp;=
D Team Mobile Devices&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\ wanted to be pai=
d for what I write.&quot;
<br>SUSE LINUX Products GmbH, N=FCrnberg \&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;-- Leonard Cohen<br></blockquote></div><br>

------=_Part_26197_24484050.1166465169847--


--===============1930625202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1930625202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1930625202==--
