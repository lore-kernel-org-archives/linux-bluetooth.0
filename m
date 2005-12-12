Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7846f1440512121306he45d777q72550620a293eab@mail.gmail.com>
From: Arthur Chiu <arthurchiu@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] UART bluetooth chip problem
In-Reply-To: <1134416630.429.4.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_445_6715135.1134421598288"
References: <7846f1440512071711x6c56c8er24edb8e3a8815ab9@mail.gmail.com>
	 <1134074044.17592.13.camel@blade>
	 <7846f1440512081510w4ffff8cdoe25ae369e677144@mail.gmail.com>
	 <1134087822.17592.44.camel@blade>
	 <7846f1440512090946n58fbf3e8gfecd3ebeb270bf58@mail.gmail.com>
	 <1134154036.10644.18.camel@blade>
	 <7846f1440512091123p5abce553gff0ef4658bc5ee45@mail.gmail.com>
	 <1134158505.10644.22.camel@blade>
	 <7846f1440512121021s65b57be7g30673fa6090df057@mail.gmail.com>
	 <1134416630.429.4.camel@blade>
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
Date: Mon, 12 Dec 2005 13:06:38 -0800

------=_Part_445_6715135.1134421598288
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

I tried the using the BCSP as the protocol and set the
PSKEY_UART_CONFIG_BCSP value as 0806, however, when I tried to attach the
chip again, using:

hciattach -s 115200 /dev/ttyS1 bcsp 115200 noflow

I get BCSP initialization error. I tried using flow too but that doesn't
help. Finally, I used "any" for the type again and the hciattach worked.
However when i run hciconfig hci0 up i get another connection timed out. :(

I have absolutely no idea what might be wrong... :( Hope you have some
clues.

Thanks,

  Arthur


On 12/12/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Arthur,
>
> > After the weekend I finally get a reply to the email that I sent
> > asking for pskeys.txt.
> >
> > "Unfortunately not. But I have pskeys.html instead. :) I hope that
> > will do.
> > Please do not pay attention to the default values mentioned in the
> > file, some
> > of them may vary in out modules."
> >
> > I'm not sure whether I can attach files to this mailing list. So I
> > send the pskeys.html file to your personal email (marcel@holtmann.org)
> > seperately, hope that's fine. Once again, thanks a lot for your help.
>
> the pskeys.txt and pskeys.html contain the same information. I prefer a
> text file, instead of a HTML file. Everybody who uses a decent OS knows
> the reason for that ;)
>
> However I think that you need to configure PSKEY_UART_CONFIG_H4 if you
> wanna use H4 as transport. The problem actually are the values that
> differ from the default. The one thing that the bccmd is missing is
> support for SPI as transport otherwise it would read the non-default
> values and we would see what they did with their modules. The PSTool can
> actually do the same, but don't ask me how. I never did that before.
>
> Maybe using BCSP as transport will work much better, because they didn't
> fucked up its configuration.
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

------=_Part_445_6715135.1134421598288
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
I tried the using the BCSP as the protocol and set the
PSKEY_UART_CONFIG_BCSP value as 0806, however, when I tried to attach
the chip again, using:<br>
<br>
hciattach -s 115200 /dev/ttyS1 bcsp 115200 noflow<br>
<br>
I get BCSP initialization error. I tried using flow too but that
doesn't help. Finally, I used &quot;any&quot; for the type again and the
hciattach worked. However when i run hciconfig hci0 up i get another
connection timed out. :(<br>
<br>
I have absolutely no idea what might be wrong... :( Hope you have some clue=
s. <br>
<br>
Thanks,<br>
<br>
&nbsp; Arthur<br>
<br><br><div><span class=3D"gmail_quote">On 12/12/05, <b class=3D"gmail_sen=
dername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">mar=
cel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" sty=
le=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex;=
 padding-left: 1ex;">
Hi Arthur,<br><br>&gt; After the weekend I finally get a reply to the email=
 that I sent<br>&gt; asking for pskeys.txt.<br>&gt;<br>&gt; &quot;Unfortuna=
tely not. But I have pskeys.html instead. :) I hope that<br>&gt; will do.
<br>&gt; Please do not pay attention to the default values mentioned in the=
<br>&gt; file, some<br>&gt; of them may vary in out modules.&quot;<br>&gt;<=
br>&gt; I'm not sure whether I can attach files to this mailing list. So I
<br>&gt; send the pskeys.html file to your personal email (<a href=3D"mailt=
o:marcel@holtmann.org">marcel@holtmann.org</a>)<br>&gt; seperately, hope th=
at's fine. Once again, thanks a lot for your help.<br><br>the pskeys.txt an=
d=20
pskeys.html contain the same information. I prefer a<br>text file, instead =
of a HTML file. Everybody who uses a decent OS knows<br>the reason for that=
 ;)<br><br>However I think that you need to configure PSKEY_UART_CONFIG_H4 =
if you
<br>wanna use H4 as transport. The problem actually are the values that<br>=
differ from the default. The one thing that the bccmd is missing is<br>supp=
ort for SPI as transport otherwise it would read the non-default<br>values =
and we would see what they did with their modules. The PSTool can
<br>actually do the same, but don't ask me how. I never did that before.<br=
><br>Maybe using BCSP as transport will work much better, because they didn=
't<br>fucked up its configuration.<br><br>Regards<br><br>Marcel<br><br>
<br><br><br>-------------------------------------------------------<br>This=
 SF.net email is sponsored by: Splunk Inc. Do you grep through log files<br=
>for problems?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX search eng=
ine that makes<br>
searching your log files as easy as surfing the&nbsp;&nbsp;web.&nbsp;&nbsp;=
DOWNLOAD SPLUNK!<br><a href=3D"http://ads.osdn.com/?ad_id=3D7637&amp;alloc_=
id=3D16865&amp;op=3Dclick">http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=
=3D16865&amp;op=3Dclick</a><br>____________________________________________=
___
<br>Bluez-users mailing list<br><a href=3D"mailto:Bluez-users@lists.sourcef=
orge.net">Bluez-users@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/=
lists/listinfo/bluez-users
</a><br></blockquote></div><br>

------=_Part_445_6715135.1134421598288--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
