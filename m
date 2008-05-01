Return-Path: <cyrus@holtmann.org>
Message-ID: <a7bd466f0804301755p6c739806m134be4b3fa753c58@mail.gmail.com>
Date: Wed, 30 Apr 2008 17:55:52 -0700
From: "biranchi rout" <bn.rout@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] How to use BondingCreated() !
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0578092936=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0578092936==
Content-Type: multipart/alternative;
	boundary="----=_Part_4827_23695197.1209603352765"

------=_Part_4827_23695197.1209603352765
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

All,
     I am new to Bluez and dbus.I am trying to get the pairing status of a
device.
     I think I can use the Signals from the Dbus daemon when a pairing is
done using
BondingCreated().
  But I am not sure how to connect to a dbus daemon and how to pass the
BondingCreated() method to the daemon to get the status.

   If anyone has used BondingCreated() to find out the pairing status,
please let
me know abou it.

Thanks,
Biranchi

On Mon, Apr 28, 2008 at 9:57 AM, Fabrice M=E9nard <menard.fabrice@orange.fr=
>
wrote:

> On Sunday 20 April 2008 22:54:07 simone malacarne wrote:
> > I have a logitech dinovo bluetooth mouse and keyboard on a Ubuntu 64bit
> > box.
> >
> >   I can pair both easily using the tray applet, and they both work
> >   flawlessly initially.
> >   However, after some time of inactivity (Not using one mouse for some
> >   time, Going away from the System, etc) the connection is lost and
> >   won't be re-established, even after moving the mouse constantly.
> >   In bluetooth manager i can see the both devices are still listed like
> >  connected.
> >
> >   To make them work again i have to manual disconnect them. After that =
i
> >   can move the mouse and click the kbd and they reconnect immediatly.
> >
> See
> http://article.gmane.org/gmane.linux.bluez.user/12988/match=3Ddinovo+last
> Maybe your answer is there.
>
> Regards,
> --
> M=E9nard Fabrice
> menard.fabrice@orange.fr
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by the 2008 JavaOne(SM) Conference
> Don't miss this year's exciting event. There's still time to save $100.
> Use priority code J8TL2D2.
>
> http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/ja=
vaone
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_4827_23695197.1209603352765
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>All,</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; I am&nbsp;new to Bluez and dbus.I am trying t=
o get&nbsp;the pairing status of a device.</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp; I think I can use the Signals from the Dbus d=
aemon when a pairing is done using</div>
<div>BondingCreated().</div>
<div>&nbsp; But I am not sure how to connect to a dbus daemon and how to pa=
ss the</div>
<div>BondingCreated() method to the daemon to get the status.</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp; If anyone has used BondingCreated() to find out the pairi=
ng status, please let </div>
<div>me know abou it. </div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Biranchi<br><br></div>
<div class=3D"gmail_quote">On Mon, Apr 28, 2008 at 9:57 AM, Fabrice M=E9nar=
d &lt;<a href=3D"mailto:menard.fabrice@orange.fr">menard.fabrice@orange.fr<=
/a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Sunday 20 April 2008 22:54:07=
 simone malacarne wrote:<br>&gt; I have a logitech dinovo bluetooth mouse a=
nd keyboard on a Ubuntu 64bit<br>
&gt; box.<br>&gt;<br>&gt; &nbsp; I can pair both easily using the tray appl=
et, and they both work<br>&gt; &nbsp; flawlessly initially.<br>&gt; &nbsp; =
However, after some time of inactivity (Not using one mouse for some<br>&gt=
; &nbsp; time, Going away from the System, etc) the connection is lost and<=
br>
&gt; &nbsp; won&#39;t be re-established, even after moving the mouse consta=
ntly.<br>&gt; &nbsp; In bluetooth manager i can see the both devices are st=
ill listed like<br>&gt; &nbsp;connected.<br>&gt;<br>&gt; &nbsp; To make the=
m work again i have to manual disconnect them. After that i<br>
&gt; &nbsp; can move the mouse and click the kbd and they reconnect immedia=
tly.<br>&gt;<br>See <a href=3D"http://article.gmane.org/gmane.linux.bluez.u=
ser/12988/match=3Ddinovo+last" target=3D"_blank">http://article.gmane.org/g=
mane.linux.bluez.user/12988/match=3Ddinovo+last</a><br>
Maybe your answer is there.<br><br>Regards,<br>--<br>M=E9nard Fabrice<br><a=
 href=3D"mailto:menard.fabrice@orange.fr">menard.fabrice@orange.fr</a><br><=
br><br><br>----------------------------------------------------------------=
---------<br>
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference<br>Don&#3=
9;t miss this year&#39;s exciting event. There&#39;s still time to save $10=
0.<br>Use priority code J8TL2D2.<br><a href=3D"http://ad.doubleclick.net/cl=
k;198757673;13503038;p?http://java.sun.com/javaone" target=3D"_blank">http:=
//ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone</=
a><br>
_______________________________________________<br>Bluez-users mailing list=
<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.=
sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/listi=
nfo/bluez-users" target=3D"_blank">https://lists.sourceforge.net/lists/list=
info/bluez-users</a><br>
</blockquote></div><br>

------=_Part_4827_23695197.1209603352765--


--===============0578092936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============0578092936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0578092936==--
