Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5bab330d0602080353h64f42106y661cb4faf8cdcea8@mail.gmail.com>
From: Nigel Sim <nigel.sim@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] GBlueZConf Prototype
In-Reply-To: <e1effdeb0602060950y29834100ge178776b1dbdf665@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_133_12762690.1139399580009"
References: <e1effdeb0602060950y29834100ge178776b1dbdf665@mail.gmail.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 8 Feb 2006 21:53:00 +1000

------=_Part_133_12762690.1139399580009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Just a quick comment. Maybe you should put a libnotify version requirement
in configuration.in. GBlueZConf won't compile with libnotify 0.3.0, but doe=
s
with 0.3.2, so maybe >=3D 0.3.2.

Nigel.

On 2/7/06, Claudio Takahasi <cktakahasi@gmail.com> wrote:
>
> Hi Marcel,
>
> Here is a new GBlueZConf version.
> http://www.cin.ufpe.br/~ckt/gbluezconf/gbluezconf-00.08.tar.gz
>
>
> It's required the set/get scan mode patch.
>
> Main changes/bug fixes:
> - Fixed dbus.h header file. Now it's belongs to "include/" directory
> while "dbus.h" doesn't belongs to BlueZ utils.
> - Fixed incomming pairing failure. The app was blocking for incomming
> authentication requests
> - Set/Get local name
> - Set/Get scan mode
> - Code cleanup: removed win atribute from private window(pair,
> configuration and search) data
>
> Regards,
> Claudio.
>
> --
> ---------------------------------------------------------
> Claudio Takahasi
> Instituto Nokia de Tecnologia - INdT
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmdlnk&kid=103432&bid#0486&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_133_12762690.1139399580009
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Just a quick comment. Maybe you should put a libnotify version requirement =
in <a href=3D"http://configuration.in">configuration.in</a>. GBlueZConf won=
't compile with libnotify 0.3.0, but does with 0.3.2, so maybe &gt;=3D 0.3.=
2
.<br><br>Nigel.<br><br><div><span class=3D"gmail_quote">On 2/7/06, <b class=
=3D"gmail_sendername">Claudio Takahasi</b> &lt;<a href=3D"mailto:cktakahasi=
@gmail.com">cktakahasi@gmail.com</a>&gt; wrote:</span><blockquote class=3D"=
gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0p=
t 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Marcel,<br><br>Here is a new GBlueZConf version.<br><a href=3D"http://ww=
w.cin.ufpe.br/~ckt/gbluezconf/gbluezconf-00.08.tar.gz">http://www.cin.ufpe.=
br/~ckt/gbluezconf/gbluezconf-00.08.tar.gz</a><br><br><br>It's required the=
 set/get scan mode patch.
<br><br>Main changes/bug fixes:<br>- Fixed dbus.h header file. Now it's bel=
ongs to &quot;include/&quot; directory<br>while &quot;dbus.h&quot; doesn't =
belongs to BlueZ utils.<br>- Fixed incomming pairing failure. The app was b=
locking for incomming
<br>authentication requests<br>- Set/Get local name<br>- Set/Get scan mode<=
br>- Code cleanup: removed win atribute from private window(pair,<br>config=
uration and search) data<br><br>Regards,<br>Claudio.<br><br>--<br>---------=
------------------------------------------------
<br>Claudio Takahasi<br>Instituto Nokia de Tecnologia - INdT<br><br><br>---=
----------------------------------------------------<br>This SF.net email i=
s sponsored by: Splunk Inc. Do you grep through log files<br>for problems?&=
nbsp;&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX search engine that makes
<br>searching your log files as easy as surfing the&nbsp;&nbsp;web.&nbsp;&n=
bsp;DOWNLOAD SPLUNK!<br><a href=3D"http://sel.as-us.falkag.net/sel?cmdlnk&a=
mp;kid=103432&amp;bid#0486&amp;dat=121642">http://sel.as-us.falkag.net/sel?=
cmdlnk&amp;kid=103432&amp;bid#0486&amp;dat=121642
</a><br>_______________________________________________<br>Bluez-devel mail=
ing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-deve=
l@lists.sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lis=
ts/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquot=
e></div><br>

------=_Part_133_12762690.1139399580009--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
