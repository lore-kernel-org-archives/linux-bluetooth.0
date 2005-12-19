Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7846f1440512191354t20d8a079u86a5be319453cc9b@mail.gmail.com>
From: Arthur Chiu <arthurchiu@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] UART bluetooth chip problem
In-Reply-To: <1134422296.429.18.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_9669_32010289.1135029250402"
References: <7846f1440512071711x6c56c8er24edb8e3a8815ab9@mail.gmail.com>
	 <1134087822.17592.44.camel@blade>
	 <7846f1440512090946n58fbf3e8gfecd3ebeb270bf58@mail.gmail.com>
	 <1134154036.10644.18.camel@blade>
	 <7846f1440512091123p5abce553gff0ef4658bc5ee45@mail.gmail.com>
	 <1134158505.10644.22.camel@blade>
	 <7846f1440512121021s65b57be7g30673fa6090df057@mail.gmail.com>
	 <1134416630.429.4.camel@blade>
	 <7846f1440512121306he45d777q72550620a293eab@mail.gmail.com>
	 <1134422296.429.18.camel@blade>
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
Date: Mon, 19 Dec 2005 13:54:10 -0800

------=_Part_9669_32010289.1135029250402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel, sorry for the late reply. I was busy working on something else
for the past week.

I have tried using PStool over UART. I have a seperate mini circuit board
that connects to the chip via UART and I connect to that circuit board via
parallel port. However, I haven't tried the UART on the system that I'm
trying to connect to the chip to. I did some investigation by adding printf
statements in the hciattach source code and recompiled it. It seems like th=
e
initialization stalls when it is trying to read from the UART fd.

I used csr as the type. It hangs in the read_hci_event function within the
csr function. It seems like UART is working as I can write to the file
descriptor opened, but it is not getting any response back from the chip
after the (GET_BUILD_ID) command is written to the UART.

Would there be some different command I need to send? Or would the chip is
not a csr chip? Or being able to write without failing still doesn't show
that the UART is working on the system?

Thanks a lot,

  Arthur


On 12/12/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Arthur,
>
> > I tried the using the BCSP as the protocol and set the
> > PSKEY_UART_CONFIG_BCSP value as 0806, however, when I tried to attach
> > the chip again, using:
> >
> > hciattach -s 115200 /dev/ttyS1 bcsp 115200 noflow
> >
> > I get BCSP initialization error. I tried using flow too but that
> > doesn't help. Finally, I used "any" for the type again and the
> > hciattach worked. However when i run hciconfig hci0 up i get another
> > connection timed out. :(
> >
> > I have absolutely no idea what might be wrong... :( Hope you have some
> > clues.
>
> I have no clue, because I don't know the settings of this module. The
> any identifier is too stupid to detect a working UART, but the csr and
> bcsp identifiers will do this. Maybe your UART is broken. Can you use
> PSTool over the UART?
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

------=_Part_9669_32010289.1135029250402
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel, sorry for the late reply. I was busy working on something else f=
or the past week. <br>
<br>
I have tried using PStool over UART. I have a seperate mini circuit
board that connects to the chip via UART and I connect to that circuit
board via parallel port. However, I haven't tried the UART on the
system that I'm trying to connect to the chip to. I did some
investigation by adding printf statements in the hciattach source code
and recompiled it. It seems like the initialization stalls when it is
trying to read from the UART fd. <br>
<br>
I used csr as the type. It hangs in the read_hci_event function within
the csr function. It seems like UART is working as I can write to the
file descriptor opened, but it is not getting any response back from
the chip after the (GET_BUILD_ID) command is written to the UART. <br>
<br>
Would there be some different command I need to send? Or would the chip
is not a csr chip? Or being able to write without failing still doesn't
show that the UART is working on the system? <br>
<br>
Thanks a lot,<br>
<br>
&nbsp; Arthur<br>
<br><br><div><span class=3D"gmail_quote">On 12/12/05, <b class=3D"gmail_sen=
dername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">mar=
cel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" sty=
le=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex;=
 padding-left: 1ex;">
Hi Arthur,<br><br>&gt; I tried the using the BCSP as the protocol and set t=
he<br>&gt; PSKEY_UART_CONFIG_BCSP value as 0806, however, when I tried to a=
ttach<br>&gt; the chip again, using:<br>&gt;<br>&gt; hciattach -s 115200 /d=
ev/ttyS1 bcsp 115200 noflow
<br>&gt;<br>&gt; I get BCSP initialization error. I tried using flow too bu=
t that<br>&gt; doesn't help. Finally, I used &quot;any&quot; for the type a=
gain and the<br>&gt; hciattach worked. However when i run hciconfig hci0 up=
 i get another
<br>&gt; connection timed out. :(<br>&gt;<br>&gt; I have absolutely no idea=
 what might be wrong... :( Hope you have some<br>&gt; clues.<br><br>I have =
no clue, because I don't know the settings of this module. The<br>any ident=
ifier is too stupid to detect a working UART, but the csr and
<br>bcsp identifiers will do this. Maybe your UART is broken. Can you use<b=
r>PSTool over the UART?<br><br>Regards<br><br>Marcel<br><br><br><br><br>---=
----------------------------------------------------<br>This SF.net email i=
s sponsored by: Splunk Inc. Do you grep through log files
<br>for problems?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX search =
engine that makes<br>searching your log files as easy as surfing the&nbsp;&=
nbsp;web.&nbsp;&nbsp;DOWNLOAD SPLUNK!<br><a href=3D"http://ads.osdn.com/?ad=
_id=3D7637&amp;alloc_id=3D16865&amp;op=3Dclick">
http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;op=3Dclick</a><b=
r>_______________________________________________<br>Bluez-users mailing li=
st<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users@list=
s.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users=
">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockqu=
ote></div><br>

------=_Part_9669_32010289.1135029250402--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
