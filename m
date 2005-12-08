Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7846f1440512081019g4bbf588cta4f4d395b7be0d74@mail.gmail.com>
From: Arthur Chiu <arthurchiu@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] UART bluetooth chip problem
In-Reply-To: <1134020677.3752.61.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11866_16314357.1134065976690"
References: <7846f1440512071711x6c56c8er24edb8e3a8815ab9@mail.gmail.com>
	 <1134020677.3752.61.camel@blade>
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
Date: Thu, 8 Dec 2005 10:19:36 -0800

------=_Part_11866_16314357.1134065976690
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel, thanks for your reply.

Since I can change the setting on the bluetooth chip, I am currently using
UART H4 and baudrate 115200. As for what chip they are using, I suppose the=
y
manufacture their own bluetooh chip?

Thanks,

  Arthur

On 12/7/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Arthur,
>
> > I am currently using a bluetooth chip by bluegiga (www.bluegiga.com),
> > called WRAP THOR 2022-1-B2B.
> > I set the configurations on the chip so that it is running at 115200
> > baud rate. After, I tried doing the following:
> >
> > # hcid
> > # hciattach -s 115200 /dev/ttyS1 any 115200 flow
> > # hciconfig
> > hci0:   Type: UART
> >         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
> >         DOWN INIT RUNNING
> >         RX bytes:0 acl:0 sco:0 events:0 errors:0
> >         TX bytes:4 acl:0 sco:0 commands:1 errors:0
> > # hciconfig hci0 up
> > Can't init device hci0: Connection timed out (145)
> >
> > I checked and error code 145 indeed means Connection timed out on my
> > header files (errno.h).
> > What might be wrong?
>
> first, you should ask you module manufacturer what chip they are using
> and then what transport they use.
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

------=_Part_11866_16314357.1134065976690
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel, thanks for your reply.<br>
<br>
Since I can change the setting on the bluetooth chip, I am currently
using UART H4 and baudrate 115200. As for what chip they are using, I
suppose they manufacture their own bluetooh chip? <br>
<br>
Thanks,<br>
<br>
&nbsp; Arthur<br><br><div><span class=3D"gmail_quote">On 12/7/05, <b class=
=3D"gmail_sendername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holt=
mann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gma=
il_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0=
pt 0pt 0.8ex; padding-left: 1ex;">
Hi Arthur,<br><br>&gt; I am currently using a bluetooth chip by bluegiga (<=
a href=3D"http://www.bluegiga.com">www.bluegiga.com</a>),<br>&gt; called WR=
AP THOR 2022-1-B2B.<br>&gt; I set the configurations on the chip so that it=
 is running at 115200
<br>&gt; baud rate. After, I tried doing the following:<br>&gt;<br>&gt; # h=
cid<br>&gt; # hciattach -s 115200 /dev/ttyS1 any 115200 flow<br>&gt; # hcic=
onfig<br>&gt; hci0:&nbsp;&nbsp; Type: UART<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU:=
 0:0
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOWN INIT RUNNING<=
br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:0 acl:0 sc=
o:0 events:0 errors:0<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; TX bytes:4 acl:0 sco:0 commands:1 errors:0<br>&gt; # hciconfig hci0 up<b=
r>&gt; Can't init device hci0: Connection timed out (145)
<br>&gt;<br>&gt; I checked and error code 145 indeed means Connection timed=
 out on my<br>&gt; header files (errno.h).<br>&gt; What might be wrong?<br>=
<br>first, you should ask you module manufacturer what chip they are using
<br>and then what transport they use.<br><br>Regards<br><br>Marcel<br><br><=
br><br><br>-------------------------------------------------------<br>This =
SF.net email is sponsored by: Splunk Inc. Do you grep through log files
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

------=_Part_11866_16314357.1134065976690--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
