Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7846f1440512191702x574fe75ehefbd06b6210f63c@mail.gmail.com>
From: Arthur Chiu <arthurchiu@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] UART bluetooth chip problem
In-Reply-To: <1135033114.5236.1.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_213_28495757.1135040571764"
References: <7846f1440512071711x6c56c8er24edb8e3a8815ab9@mail.gmail.com>
	 <1134154036.10644.18.camel@blade>
	 <7846f1440512091123p5abce553gff0ef4658bc5ee45@mail.gmail.com>
	 <1134158505.10644.22.camel@blade>
	 <7846f1440512121021s65b57be7g30673fa6090df057@mail.gmail.com>
	 <1134416630.429.4.camel@blade>
	 <7846f1440512121306he45d777q72550620a293eab@mail.gmail.com>
	 <1134422296.429.18.camel@blade>
	 <7846f1440512191354t20d8a079u86a5be319453cc9b@mail.gmail.com>
	 <1135033114.5236.1.camel@localhost>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 19 Dec 2005 17:02:51 -0800

------=_Part_213_28495757.1135040571764
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks Marcel, I'll try to figure out whether the UART is messed up
meanwhile. Will let you know the result ASAP.

Cheers,

  Arthur

On 12/19/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Arthur,
>
> > I have tried using PStool over UART. I have a seperate mini circuit
> > board that connects to the chip via UART and I connect to that circuit
> > board via parallel port. However, I haven't tried the UART on the
> > system that I'm trying to connect to the chip to. I did some
> > investigation by adding printf statements in the hciattach source code
> > and recompiled it. It seems like the initialization stalls when it is
> > trying to read from the UART fd.
> >
> > I used csr as the type. It hangs in the read_hci_event function within
> > the csr function. It seems like UART is working as I can write to the
> > file descriptor opened, but it is not getting any response back from
> > the chip after the (GET_BUILD_ID) command is written to the UART.
> >
> > Would there be some different command I need to send? Or would the
> > chip is not a csr chip? Or being able to write without failing still
> > doesn't show that the UART is working on the system?
>
> I think your UART is not configured correctly. Ask your Bluetooth module
> manufacturer to help you. Or make it work with Windows and PSTool over
> the UART and we can work from there on.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_213_28495757.1135040571764
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks Marcel, I'll try to figure out whether the UART is messed up meanwhi=
le. Will let you know the result ASAP. <br>
<br>
Cheers,<br>
<br>
&nbsp; Arthur<br><br><div><span class=3D"gmail_quote">On 12/19/05, <b class=
=3D"gmail_sendername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holt=
mann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gma=
il_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0=
pt 0pt 0.8ex; padding-left: 1ex;">
Hi Arthur,<br><br>&gt; I have tried using PStool over UART. I have a sepera=
te mini circuit<br>&gt; board that connects to the chip via UART and I conn=
ect to that circuit<br>&gt; board via parallel port. However, I haven't tri=
ed the UART on the
<br>&gt; system that I'm trying to connect to the chip to. I did some<br>&g=
t; investigation by adding printf statements in the hciattach source code<b=
r>&gt; and recompiled it. It seems like the initialization stalls when it i=
s
<br>&gt; trying to read from the UART fd.<br>&gt;<br>&gt; I used csr as the=
 type. It hangs in the read_hci_event function within<br>&gt; the csr funct=
ion. It seems like UART is working as I can write to the<br>&gt; file descr=
iptor opened, but it is not getting any response back from
<br>&gt; the chip after the (GET_BUILD_ID) command is written to the UART.<=
br>&gt;<br>&gt; Would there be some different command I need to send? Or wo=
uld the<br>&gt; chip is not a csr chip? Or being able to write without fail=
ing still
<br>&gt; doesn't show that the UART is working on the system?<br><br>I thin=
k your UART is not configured correctly. Ask your Bluetooth module<br>manuf=
acturer to help you. Or make it work with Windows and PSTool over<br>the UA=
RT and we can work from there on.
<br><br>Regards<br><br>Marcel<br><br><br><br><br>--------------------------=
-----------------------------<br>This SF.net email is sponsored by: Splunk =
Inc. Do you grep through log files<br>for problems?&nbsp;&nbsp;Stop!&nbsp;&=
nbsp;Download the new AJAX search engine that makes
<br>searching your log files as easy as surfing the&nbsp;&nbsp;web.&nbsp;&n=
bsp;DOWNLOAD SPLUNK!<br><a href=3D"http://ads.osdn.com/?ad_id=3D7637&amp;al=
loc_id=3D16865&amp;op=3Dclick">http://ads.osdn.com/?ad_id=3D7637&amp;alloc_=
id=3D16865&amp;op=3Dclick</a><br>
_______________________________________________<br>Bluez-users mailing list=
<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.=
sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/listi=
nfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquot=
e></div><br>

------=_Part_213_28495757.1135040571764--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
