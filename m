Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <dcbc35340702220448l5c296eb8ge2c3214937e41b5d@mail.gmail.com>
Date: Thu, 22 Feb 2007 12:48:55 +0000
From: "=?ISO-8859-1?Q?Paulo_Gon=E7alves?=" <paf.goncalves@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <7FEBB30F0CE41B419B38295024A58EE3A10D46@oxygen.mail.telnet.tunis>
MIME-Version: 1.0
References: <7FEBB30F0CE41B419B38295024A58EE3A10D46@oxygen.mail.telnet.tunis>
Subject: Re: [Bluez-users] RE : modprobe snd-bt-sco
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0792214983=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0792214983==
Content-Type: multipart/alternative;
	boundary="----=_Part_25743_1032388.1172148535520"

------=_Part_25743_1032388.1172148535520
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 2/22/07, Asma Tebessi <asma.tebessi@telnet.com.tn> wrote:
>
> Hi,
>
> where can I do make modules?? I tried to do it under
> /lib/modules/2.6.12-12mdk but I got :



In the same folder you compile your kernel.
Normally in /usr/src/linux


make: *** Pas de r=E8gle pour fabriquer la cible =AB modules_install =BB. A=
rr=EAt
>
>
>
>
> -------- Message d'origine--------
> De: bluez-users-bounces@lists.sourceforge.net de la part de Paulo
> Gon=E7alves
> Date: jeu. 22/02/2007 10:20
> =C0: BlueZ users
> Objet : Re: [Bluez-users] modprobe snd-bt-sco
>
> Hi !
>
> On 2/22/07, Asma Tebessi <asma.tebessi@telnet.com.tn> wrote:
>
> >  Hi all,
> >
> > I've installed the latest versions of bluez 'bluez-utils-3.9,
> > bluez-libs-3.9, bluez-hcidump-1.33 and bluez-firmware-1.2' under
> Mandriva
> > 2006 and I can establish a connection between my pc and my nokia N70. I
> want
> > to have the handsfree option available so I add it with : sdptool add
> > --channel=3D2 HF (the channel for handsfree on N70 is the number 1) and
> the
> > test seems to work since I had an icon on my nokia when I launch :
> >  rfcomm connect /dev/rfcomm0 00:16:4E:D9:20:98 2
> > The connection lasts only few secondes then terminate. So I make :
> rfcomm
> > listen /dev/rfcomm0  2 and try to call the nokia N70 from another phone=
.
> The
> > N7O contact the pc via bluetooth and I enter the PIN in both sides and
> the
> > connection is done but when I hangup the sound doesn't came from the
> pc's
> > headspeaker but from N70's one.
> > I thought I need to install the bluetooth-alsa to make it work. So I do=
,
> I
> > installed btsco-0.5, plugz and sbc and I've got no errors. I followed
> the
> > instructions within this document "
> > http://www.linux.ie/articles/bluetoothheadset.php" but when I made
> > modprobe snd-bt-sco I got :
> >
> > [root@localhost confhandsfree]# modprobe snd-bt-sco
> > FATAL: Module snd-bt-sco not found.
> >
> > I dont understand how to make it work since I got no errors while
> > compiling the btsco and processing the
> > "cd kernel - make - make install - depmod -e - make clean"
> >
>
> try "make modules"
>
> Otherwise, I tried to connect my bluetooth dongle 'belkin' and I got :
> >
> > [root@localhost confhandsfree]# btsco 00:0A:3A:50:27:84   2
> > Error: hwdep next device (hw:0): Operation not permitted
> > Error: control open (hw:1): No such device
> > Error: Can't find device. Bail
> >
> > I hope that you'll help me I need to make this work as soon as possible
> > and I'm lost :(
> >
> > Thanks a lot.
> >
> >
> -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share
> > your
> > opinions on IT & business topics through brief surveys-and earn cash
> >
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> >
> Paulo Gon=E7alves
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>

------=_Part_25743_1032388.1172148535520
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br>
<div><span class=3D"gmail_quote">On 2/22/07, <b class=3D"gmail_sendername">=
Asma Tebessi</b> &lt;<a href=3D"mailto:asma.tebessi@telnet.com.tn">asma.teb=
essi@telnet.com.tn</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi,<br><br>where can I do make m=
odules?? I tried to do it under /lib/modules/2.6.12-12mdk but I got :</bloc=
kquote>

<div>&nbsp;</div>
<div>&nbsp;</div>
<div><font color=3D"#3366ff">In the same folder you compile your kernel.</f=
ont></div>
<div><font color=3D"#3366ff">Normally in /usr/src/linux</font></div>
<div>&nbsp;</div><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">make: *** Pas de r=E8gle pour fa=
briquer la cible =AB modules_install =BB. Arr=EAt<br><br><br><br><br>------=
-- Message d&#39;origine--------
<br>De: <a href=3D"mailto:bluez-users-bounces@lists.sourceforge.net">bluez-=
users-bounces@lists.sourceforge.net</a> de la part de Paulo Gon=E7alves<br>=
Date: jeu. 22/02/2007 10:20<br>=C0: BlueZ users<br>Objet : Re: [Bluez-users=
] modprobe snd-bt-sco
<br><br>Hi !<br><br>On 2/22/07, Asma Tebessi &lt;<a href=3D"mailto:asma.teb=
essi@telnet.com.tn">asma.tebessi@telnet.com.tn</a>&gt; wrote:<br><br>&gt;&n=
bsp;&nbsp;Hi all,<br>&gt;<br>&gt; I&#39;ve installed the latest versions of=
 bluez &#39;
bluez-utils-3.9,<br>&gt; bluez-libs-3.9, bluez-hcidump-1.33 and bluez-firmw=
are-1.2&#39; under Mandriva<br>&gt; 2006 and I can establish a connection b=
etween my pc and my nokia N70. I want<br>&gt; to have the handsfree option =
available so I add it with : sdptool add
<br>&gt; --channel=3D2 HF (the channel for handsfree on N70 is the number 1=
) and the<br>&gt; test seems to work since I had an icon on my nokia when I=
 launch :<br>&gt;&nbsp;&nbsp;rfcomm connect /dev/rfcomm0 00:16:4E:D9:20:98 =
2<br>&gt; The connection lasts only few secondes then terminate. So I make =
: rfcomm
<br>&gt; listen /dev/rfcomm0&nbsp;&nbsp;2 and try to call the nokia N70 fro=
m another phone. The<br>&gt; N7O contact the pc via bluetooth and I enter t=
he PIN in both sides and the<br>&gt; connection is done but when I hangup t=
he sound doesn&#39;t came from the pc&#39;s
<br>&gt; headspeaker but from N70&#39;s one.<br>&gt; I thought I need to in=
stall the bluetooth-alsa to make it work. So I do, I<br>&gt; installed btsc=
o-0.5, plugz and sbc and I&#39;ve got no errors. I followed the<br>&gt; ins=
tructions within this document &quot;
<br>&gt; <a href=3D"http://www.linux.ie/articles/bluetoothheadset.php">http=
://www.linux.ie/articles/bluetoothheadset.php</a>&quot; but when I made<br>=
&gt; modprobe snd-bt-sco I got :<br>&gt;<br>&gt; [root@localhost confhandsf=
ree]# modprobe snd-bt-sco
<br>&gt; FATAL: Module snd-bt-sco not found.<br>&gt;<br>&gt; I dont underst=
and how to make it work since I got no errors while<br>&gt; compiling the b=
tsco and processing the<br>&gt; &quot;cd kernel - make - make install - dep=
mod -e - make clean&quot;
<br>&gt;<br><br>try &quot;make modules&quot;<br><br>Otherwise, I tried to c=
onnect my bluetooth dongle &#39;belkin&#39; and I got :<br>&gt;<br>&gt; [ro=
ot@localhost confhandsfree]# btsco 00:0A:3A:50:27:84&nbsp;&nbsp; 2<br>&gt; =
Error: hwdep next device (hw:0): Operation not permitted
<br>&gt; Error: control open (hw:1): No such device<br>&gt; Error: Can&#39;=
t find device. Bail<br>&gt;<br>&gt; I hope that you&#39;ll help me I need t=
o make this work as soon as possible<br>&gt; and I&#39;m lost :(<br>&gt;
<br>&gt; Thanks a lot.<br>&gt;<br>&gt; ------------------------------------=
-------------------------------------<br>&gt; Take Surveys. Earn Cash. Infl=
uence the Future of IT<br>&gt; Join SourceForge.net&#39;s Techsay panel and=
 you&#39;ll get the chance to share
<br>&gt; your<br>&gt; opinions on IT &amp; business topics through brief su=
rveys-and earn cash<br>&gt; <a href=3D"http://www.techsay.com/default.php?p=
age=3Djoin.php&amp;p=3Dsourceforge&amp;CID=3DDEVDEV">http://www.techsay.com=
/default.php?page=3Djoin.php&amp;p=3Dsourceforge&amp;CID=3DDEVDEV
</a><br>&gt; _______________________________________________<br>&gt; Bluez-=
users mailing list<br>&gt; <a href=3D"mailto:Bluez-users@lists.sourceforge.=
net">Bluez-users@lists.sourceforge.net</a><br>&gt; <a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>&gt;<br>&gt=
;<br>Paulo Gon=E7alves<br><br><br>-----------------------------------------=
--------------------------------<br>Take Surveys. Earn Cash. Influence the =
Future of IT
<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance =
to share your<br>opinions on IT &amp; business topics through brief surveys=
-and earn cash<br><a href=3D"http://www.techsay.com/default.php?page=3Djoin=
.php&amp;p=3Dsourceforge&amp;CID=3DDEVDEV">
http://www.techsay.com/default.php?page=3Djoin.php&amp;p=3Dsourceforge&amp;=
CID=3DDEVDEV</a><br>_______________________________________________<br>Blue=
z-users mailing list<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net=
">Bluez-users@lists.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users=
">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br><br><br><=
/blockquote></div><br>

------=_Part_25743_1032388.1172148535520--


--===============0792214983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0792214983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0792214983==--
