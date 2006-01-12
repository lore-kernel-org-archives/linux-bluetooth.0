Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <19c2b3920601120859n81b5310y@mail.gmail.com>
From: rangzen <lipare@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Strange things with SE K750i and remote control
In-Reply-To: <1136989658.3825.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1694_2385665.1137085172468"
References: <19c2b3920601110619x37c6e4ck@mail.gmail.com>
	 <1136989658.3825.26.camel@localhost.localdomain>
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
Date: Thu, 12 Jan 2006 17:59:32 +0100

------=_Part_1694_2385665.1137085172468
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

2006/1/11, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi,
>
> > i can upload/download files without any problem using bluetooth.
> >
> > But when i use the remote control fonction, i need to delete the
> > device i want to use before use it if i used it before :/
> >
> > For example :
> > i have no device declared on the phone
> > i choose remote control desktop
> > the phone find my USB key device
> > i choose yes yes yes yes in the menu and i can control my mouse, etc.
> > everything fine
> > i go out in the menu, send a sms, make a call or even nothing
> > i go back to the remote control menu and choose the device found just
> > before
> > the phone write "impossible to connect" and /var/log/daemon add
> > a hcid[pid]: link_key_request sba USB dba MyPhone
> > i go in the device known by the phone, delete the connexion
> > i retry and it works again :/
> >
> > Exactly the same things if i make the connection from the PC
> > only difference is
> > #hidd --connect 00:phonebt:00
> > Can't create HID control channel: Connection refused
> >
> > The phone is configured with "Always accept" from this device
> >
> > I have a Ubuntu 5.10 with
>
> what bluez-utils version is installed on Ubuntu 5.10. I had to include
> some workarounds for the SonyEricsson phones. Maybe you try it with
> --nosdp if this switch is available.
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

I installed the 2.24 : no change.

Exactly like before, even with --nosdp

:/

--
libert=E9 - partage - respect
freedom - share - respect

------=_Part_1694_2385665.1137085172468
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

2006/1/11, Marcel Holtmann &lt;<a href=3D"mailto:marcel@holtmann.org">marce=
l@holtmann.org</a>&gt;:<div><span class=3D"gmail_quote"></span><blockquote =
class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); m=
argin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br><br>&gt; i can upload/download files without any problem using bluet=
ooth.<br>&gt;<br>&gt; But when i use the remote control fonction, i need to=
 delete the<br>&gt; device i want to use before use it if i used it before =
:/
<br>&gt;<br>&gt; For example :<br>&gt; i have no device declared on the pho=
ne<br>&gt; i choose remote control desktop<br>&gt; the phone find my USB ke=
y device<br>&gt; i choose yes yes yes yes in the menu and i can control my =
mouse, etc.
<br>&gt; everything fine<br>&gt; i go out in the menu, send a sms, make a c=
all or even nothing<br>&gt; i go back to the remote control menu and choose=
 the device found just<br>&gt; before<br>&gt; the phone write &quot;impossi=
ble to connect&quot; and /var/log/daemon add
<br>&gt; a hcid[pid]: link_key_request sba USB dba MyPhone<br>&gt; i go in =
the device known by the phone, delete the connexion<br>&gt; i retry and it =
works again :/<br>&gt;<br>&gt; Exactly the same things if i make the connec=
tion from the PC
<br>&gt; only difference is<br>&gt; #hidd --connect 00:phonebt:00<br>&gt; C=
an't create HID control channel: Connection refused<br>&gt;<br>&gt; The pho=
ne is configured with &quot;Always accept&quot; from this device<br>&gt;
<br>&gt; I have a Ubuntu 5.10 with<br><br>what bluez-utils version is insta=
lled on Ubuntu 5.10. I had to include<br>some workarounds for the SonyErics=
son phones. Maybe you try it with<br>--nosdp if this switch is available.
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
e></div><br>I installed the 2.24 : no change.<br>

<br>

Exactly like before, even with --nosdp<br>
<br>
:/<br clear=3D"all"><br>-- <br>libert=E9 - partage - respect<br>freedom - s=
hare - respect

------=_Part_1694_2385665.1137085172468--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
