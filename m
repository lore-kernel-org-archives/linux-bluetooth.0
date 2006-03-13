Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <fe0a97c20603130215w55225c60t866d2af40ae086f2@mail.gmail.com>
From: "Sowmya Gattupalli" <sowmya.gattupalli@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Connecting to a headset
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5385_20257320.1142244946655"
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
Date: Mon, 13 Mar 2006 15:45:46 +0530

------=_Part_5385_20257320.1142244946655
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Brad...
I have been going through the archives of this mailing list regarding the
SCO audio support by Marcel and Max in 2002 discussing the demerits in the
hci_usb driver to support SCO... (
http://sourceforge.net/mailarchive/message.php?msg_id=3D2651899)
Is the problem discussed rectified??
My question is
1) Does the hci_usb.o module support SCO???
2) Iam planning to set up 2 USB dongles (CSR) for headset and Audio gateway
each...
Can I use scotest to send voice?? will I face problems??

Iam yet to write the code

Soumya



>
> Sowmya
>
> > Iam a novice in linux and bluetooth....
> > I have a very specific question regarding the headset and audio
> profile....
> > Why is it that ALSA and Bluetooth can connect to a headset???
> > I mean what ALSA can do which others can't do?
> >
> > Can't it be on a lil lower kernel of 2.4.20 or something... or with
> > downloaded ALSA libraries ... why only with an "integrated"  kernel wit=
h
> > ALSA???? ( i,e a newer kernel.... )
>
> Get the bluez cvs project and have a look at utils/test/scotest.c
>
> You can write your app to do all the audio transfers itself and you
> won't have to patch or upgrade the kernel.
>
> Of course you're mostly on your own :) so good luck.
>
> Brad
>
>
>
>
>

------=_Part_5385_20257320.1142244946655
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Brad... <br>I have been going through the archives of this mailing list =
regarding the SCO audio support by Marcel and Max in 2002 discussing the de=
merits in the hci_usb driver to support SCO... (<a href=3D"http://sourcefor=
ge.net/mailarchive/message.php?msg_id=3D2651899">
http://sourceforge.net/mailarchive/message.php?msg_id=3D2651899</a>)<br>Is =
the problem discussed rectified??<br>My question is <br>1) Does the hci_usb=
.o module support SCO??? <br>2) Iam planning to set up 2 USB dongles (CSR) =
for headset and Audio gateway each...=20
<br>Can I use scotest to send voice?? will I face problems??<br><br>Iam yet=
 to write the code<br><br>Soumya<br><br><div><span class=3D"gmail_quote"><b=
r></span><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br><br>Sowmya<br><br>&gt; Iam a novice in linux and bluetooth....<br>&gt; =
I have a very specific question regarding the headset and audio profile....=
<br>&gt; Why is it that ALSA and Bluetooth can connect to a headset???<br>
&gt; I mean what ALSA can do which others can't do?<br>&gt;<br>&gt; Can't i=
t be on a lil lower kernel of 2.4.20 or something... or with<br>&gt; downlo=
aded ALSA libraries ... why only with an &quot;integrated&quot;&nbsp;&nbsp;=
kernel with
<br>&gt; ALSA???? ( i,e a newer kernel.... )<br><br>Get the bluez cvs proje=
ct and have a look at utils/test/scotest.c<br><br>You can write your app to=
 do all the audio transfers itself and you<br>won't have to patch or upgrad=
e the kernel.
<br><br>Of course you're mostly on your own :) so good luck.<br><br>Brad<br=
><br><br><br><br></blockquote></div><br>

------=_Part_5385_20257320.1142244946655--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
