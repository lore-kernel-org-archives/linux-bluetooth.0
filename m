Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <96f168100512050712v3bf2566ct43a172ca4e06277@mail.gmail.com>
From: Steve Winston <spwinston@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] audio transfer from an pc and an headset (one way communication)
In-Reply-To: <20051205113634.GA5487@acs.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_24905_2223723.1133795549216"
References: <20051205082921.35263.qmail@web36113.mail.mud.yahoo.com>
	 <20051205113634.GA5487@acs.uni-duesseldorf.de>
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
Date: Mon, 5 Dec 2005 09:12:29 -0600

------=_Part_24905_2223723.1133795549216
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I believe that if this is what you want to do; you *can* just write a
program to send audio down the link to any qualified device (including your
headset).  Bluetooth's API is very similar to plain old TCP/IP network
programing so this isn't a very cumbersome task.  If you wish to set up the
headset as a device and send audio to it, you should probably look into
doing the ALSA method described at http://bluetooth-alsa.sourceforge.net.
After you have it all setup, just mute the mic and you'll achieve the one
directional results your asking for.

On 12/5/05, Andreas Beck <becka-bzus@bedatec.de> wrote:
>
> Swathi Mathur80 <swathi_mathur80@yahoo.com> wrote:
> > I want to do an audio transfer from an PC to an
> > headset and not from an headset to an PC.
>
> Direction doesn't quite matter, as it is a bidirectional link.
>
> > I think i don't need the ALSA module as i don't intend to play
> > the audio file on my PC.
>
> Wrong. You need it, as the headset gets mapped as an audio device
> on the PC.
>
> > Can someone tell me what all the modules needed to be installed
>
> Read the bluetooth-alsa pages at http://bluetooth-alsa.sourceforge.net/
>
>
> CU, Andy
>
> --
> =3D Andreas Beck                    |  Email :  <becka-sig@bedatec.de>
> =3D
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

------=_Part_24905_2223723.1133795549216
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I believe that if this is what you want to do; you *can* just write a
program to send audio down the link to any qualified device (including
your headset).&nbsp; Bluetooth's API is very similar to plain old
TCP/IP network programing so this isn't a very cumbersome task.&nbsp;
If you wish to set up the headset as a device and send audio to it, you
should probably look into doing the ALSA method described at
<a href=3D"http://bluetooth-alsa.sourceforge.net">http://bluetooth-alsa.sou=
rceforge.net</a>.&nbsp; After you have it all
setup, just mute the mic and you'll achieve the one directional results
your asking for.<br><br><div><span class=3D"gmail_quote">On 12/5/05, <b cla=
ss=3D"gmail_sendername">Andreas Beck</b> &lt;<a href=3D"mailto:becka-bzus@b=
edatec.de">becka-bzus@bedatec.de</a>&gt; wrote:</span><blockquote class=3D"=
gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0p=
t 0pt 0pt 0.8ex; padding-left: 1ex;">
Swathi Mathur80 &lt;<a href=3D"mailto:swathi_mathur80@yahoo.com">swathi_mat=
hur80@yahoo.com</a>&gt; wrote:<br>&gt; I want to do an audio transfer from =
an PC to an<br>&gt; headset and not from an headset to an PC.<br><br>Direct=
ion doesn't quite matter, as it is a bidirectional link.
<br><br>&gt; I think i don't need the ALSA module as i don't intend to play=
<br>&gt; the audio file on my PC.<br><br>Wrong. You need it, as the headset=
 gets mapped as an audio device<br>on the PC.<br><br>&gt; Can someone tell =
me what all the modules needed to be installed
<br><br>Read the bluetooth-alsa pages at <a href=3D"http://bluetooth-alsa.s=
ourceforge.net/">http://bluetooth-alsa.sourceforge.net/</a><br><br><br>CU, =
Andy<br><br>--<br>=3D
Andreas
Beck&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;Email
:&nbsp;&nbsp;&lt;<a href=3D"mailto:becka-sig@bedatec.de">becka-sig@bedatec.=
de</a>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D<br><br><br>-------------------------------------------------------<br>T=
his SF.net email is sponsored by: Splunk Inc. Do you grep through log files=
<br>for problems?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX search =
engine that makes
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

------=_Part_24905_2223723.1133795549216--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
