Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0511261733t774abbf9s2711cbd784533a18@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] cellphone as microphone/webcam?
In-Reply-To: <43890A1D.2060407@ketil.froyn.name>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_39363_8442967.1133055180663"
References: <43890A1D.2060407@ketil.froyn.name>
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
Date: Sat, 26 Nov 2005 20:33:00 -0500

------=_Part_39363_8442967.1133055180663
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Unlikely.  You'll probably need to find a development kit for the phone (if
it exists) that exposes controls for the microphone/camera and bluetooth.
Then you'd need to write a bluez program to interface with the control
program on the phone.  If the phone supports j2me, jsr-82, and whatever jsr
for the microphone/camera, that's a good place to start looking.

-albert

On 11/26/05, Ketil Froyn <lists@ketil.froyn.name> wrote:
>
> Hi,
>
> I have a Sony Ericsson Z800i cellphone, and I am wondering if it is
> possible to use any of the devices on it from my computer over
> bluetooth. I'm not expecting any answers on specifics of my cellphone
> here (though if someone were to know something that would be useful),
> but rather any pointers to documentation on how this can be done with
> the bluez utilities.
>
> Specifically, I would like to try to use the cellphone as a microphone
> and webcam, so that I could store the audio/video on my computer. I'm
> not sure this is even possible...
>
> Cheers,
> Ketil
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

------=_Part_39363_8442967.1133055180663
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Unlikely.&nbsp; You'll probably need to find a development kit for the
phone (if it exists) that exposes controls for the microphone/camera
and bluetooth.&nbsp; Then you'd need to write a bluez program to
interface with the control program on the phone.&nbsp; If the phone
supports j2me, jsr-82, and whatever jsr for the microphone/camera,
that's a good place to start looking.<br>
<br>
-albert<br><br><div><span class=3D"gmail_quote">On 11/26/05, <b class=3D"gm=
ail_sendername">Ketil Froyn</b> &lt;<a href=3D"mailto:lists@ketil.froyn.nam=
e">lists@ketil.froyn.name</a>&gt; wrote:</span><blockquote class=3D"gmail_q=
uote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0=
pt 0.8ex; padding-left: 1ex;">
Hi,<br><br>I have a Sony Ericsson Z800i cellphone, and I am wondering if it=
 is<br>possible to use any of the devices on it from my computer over<br>bl=
uetooth. I'm not expecting any answers on specifics of my cellphone<br>
here (though if someone were to know something that would be useful),<br>bu=
t rather any pointers to documentation on how this can be done with<br>the =
bluez utilities.<br><br>Specifically, I would like to try to use the cellph=
one as a microphone
<br>and webcam, so that I could store the audio/video on my computer. I'm<b=
r>not sure this is even possible...<br><br>Cheers,<br>Ketil<br><br><br>----=
---------------------------------------------------<br>This SF.net email is=
 sponsored by: Splunk Inc. Do you grep through log files
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

------=_Part_39363_8442967.1133055180663--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
