Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <dcbc35340702220120r2f12e820uac4c8ecd8daabd42@mail.gmail.com>
Date: Thu, 22 Feb 2007 09:20:58 +0000
From: "=?ISO-8859-1?Q?Paulo_Gon=E7alves?=" <paf.goncalves@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <7FEBB30F0CE41B419B38295024A58EE3A10D44@oxygen.mail.telnet.tunis>
MIME-Version: 1.0
References: <7FEBB30F0CE41B419B38295024A58EE3A10D44@oxygen.mail.telnet.tunis>
Subject: Re: [Bluez-users] modprobe snd-bt-sco
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1515631361=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1515631361==
Content-Type: multipart/alternative;
	boundary="----=_Part_23376_5166458.1172136058898"

------=_Part_23376_5166458.1172136058898
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi !

On 2/22/07, Asma Tebessi <asma.tebessi@telnet.com.tn> wrote:

>  Hi all,
>
> I've installed the latest versions of bluez 'bluez-utils-3.9,
> bluez-libs-3.9, bluez-hcidump-1.33 and bluez-firmware-1.2' under Mandriva
> 2006 and I can establish a connection between my pc and my nokia N70. I w=
ant
> to have the handsfree option available so I add it with : sdptool add
> --channel=3D2 HF (the channel for handsfree on N70 is the number 1) and t=
he
> test seems to work since I had an icon on my nokia when I launch :
>  rfcomm connect /dev/rfcomm0 00:16:4E:D9:20:98 2
> The connection lasts only few secondes then terminate. So I make : rfcomm
> listen /dev/rfcomm0  2 and try to call the nokia N70 from another phone. =
The
> N7O contact the pc via bluetooth and I enter the PIN in both sides and th=
e
> connection is done but when I hangup the sound doesn't came from the pc's
> headspeaker but from N70's one.
> I thought I need to install the bluetooth-alsa to make it work. So I do, =
I
> installed btsco-0.5, plugz and sbc and I've got no errors. I followed the
> instructions within this document "
> http://www.linux.ie/articles/bluetoothheadset.php" but when I made
> modprobe snd-bt-sco I got :
>
> [root@localhost confhandsfree]# modprobe snd-bt-sco
> FATAL: Module snd-bt-sco not found.
>
> I dont understand how to make it work since I got no errors while
> compiling the btsco and processing the
> "cd kernel - make - make install - depmod -e - make clean"
>

try "make modules"

 Otherwise, I tried to connect my bluetooth dongle 'belkin' and I got :
>
> [root@localhost confhandsfree]# btsco 00:0A:3A:50:27:84   2
> Error: hwdep next device (hw:0): Operation not permitted
> Error: control open (hw:1): No such device
> Error: Can't find device. Bail
>
> I hope that you'll help me I need to make this work as soon as possible
> and I'm lost :(
>
> Thanks a lot.
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
Paulo Gon=E7alves

------=_Part_23376_5166458.1172136058898
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div><font color=3D"#3366ff">Hi !</font></div>
<div><br><span class=3D"gmail_quote">On 2/22/07, <b class=3D"gmail_senderna=
me">Asma Tebessi</b> &lt;<a href=3D"mailto:asma.tebessi@telnet.com.tn">asma=
.tebessi@telnet.com.tn</a>&gt; wrote:</span></div>
<div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<p><font size=3D"2">Hi all,<br><br>I&#39;ve installed the latest versions o=
f bluez &#39;bluez-utils-3.9, bluez-libs-3.9, bluez-hcidump-1.33 and bluez-=
firmware-1.2&#39; under Mandriva 2006 and I can establish a connection betw=
een my pc and my nokia N70. I want to have the handsfree option available s=
o I add it with : sdptool add --channel=3D2 HF (the channel for handsfree o=
n N70 is the number 1) and the test seems to work since I had an icon on my=
 nokia when I launch :
<br>&nbsp;rfcomm connect /dev/rfcomm0 00:16:4E:D9:20:98 2<br>The connection=
 lasts only few secondes then terminate. So I make : rfcomm listen /dev/rfc=
omm0&nbsp; 2 and try to call the nokia N70 from another phone. The N7O cont=
act the pc via bluetooth and I enter the PIN in both sides and the connecti=
on is done but when I hangup the sound doesn&#39;t came from the pc&#39;s h=
eadspeaker but from N70&#39;s one.
<br>I thought I need to install the bluetooth-alsa to make it work. So I do=
, I installed btsco-0.5, plugz and sbc and I&#39;ve got no errors. I follow=
ed the instructions within this document &quot;<a onclick=3D"return top.js.=
OpenExtLink(window,event,this)" href=3D"http://www.linux.ie/articles/blueto=
othheadset.php" target=3D"_blank">
http://www.linux.ie/articles/bluetoothheadset.php</a>&quot; but when I made=
 modprobe snd-bt-sco I got :<br><br>[root@localhost confhandsfree]# modprob=
e snd-bt-sco<br>FATAL: Module snd-bt-sco not found.<br><br>I dont understan=
d how to make it work since I got no errors while compiling the btsco and p=
rocessing the
<br>&quot;cd kernel - make - make install - depmod -e - make clean&quot;</f=
ont></p></div></blockquote>
<div>&nbsp;</div>
<div><font color=3D"#3366ff">try &quot;make modules&quot;</font></div><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<p><font size=3D"2">Otherwise, I tried to connect my bluetooth dongle &#39;=
belkin&#39; and I got :<br><br>[root@localhost confhandsfree]# btsco 00:0A:=
3A:50:27:84&nbsp;&nbsp; 2<br>Error: hwdep next device (hw:0): Operation not=
 permitted
<br>Error: control open (hw:1): No such device<br>Error: Can&#39;t find dev=
ice. Bail<br><br>I hope that you&#39;ll help me I need to make this work as=
 soon as possible and I&#39;m lost :(<br><br>Thanks a lot.</font> </p></div=
>
<br>-----------------------------------------------------------------------=
--<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceFor=
ge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>
opinions on IT &amp; business topics through brief surveys-and earn cash<br=
><a onclick=3D"return top.js.OpenExtLink(window,event,this)" href=3D"http:/=
/www.techsay.com/default.php?page=3Djoin.php&amp;p=3Dsourceforge&amp;CID=3D=
DEVDEV" target=3D"_blank">
http://www.techsay.com/default.php?page=3Djoin.php&amp;p=3Dsourceforge&amp;=
CID=3DDEVDEV</a><br>_______________________________________________<br>Blue=
z-users mailing list<br><a onclick=3D"return top.js.OpenExtLink(window,even=
t,this)" href=3D"mailto:Bluez-users@lists.sourceforge.net">
Bluez-users@lists.sourceforge.net</a><br><a onclick=3D"return top.js.OpenEx=
tLink(window,event,this)" href=3D"https://lists.sourceforge.net/lists/listi=
nfo/bluez-users" target=3D"_blank">https://lists.sourceforge.net/lists/list=
info/bluez-users
</a><br><br></blockquote></div>
<div>&nbsp;</div>
<div><font color=3D"#3366ff">Paulo Gon=E7alves</font></div>
<div><br>&nbsp;</div>

------=_Part_23376_5166458.1172136058898--


--===============1515631361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1515631361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1515631361==--
