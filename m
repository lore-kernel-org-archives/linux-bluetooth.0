Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b621074b0704102122t9a942c6v7ee44d03ea342d33@mail.gmail.com>
Date: Wed, 11 Apr 2007 09:52:31 +0530
From: "Tushar Paturde" <tusharpaturde@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <2bf8a3380704101510q7bdbe0ep7fd39473a5dae73@mail.gmail.com>
MIME-Version: 1.0
References: <2bf8a3380704091001j59941c4fia4aaf4c6d8a0d5be@mail.gmail.com>
	<2bf8a3380704101510q7bdbe0ep7fd39473a5dae73@mail.gmail.com>
Subject: Re: [Bluez-users] Doubts related to BlueZ and JSR-82
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0296962307=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0296962307==
Content-Type: multipart/alternative;
	boundary="----=_Part_2626_28607734.1176265351564"

------=_Part_2626_28607734.1176265351564
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Bruno,
Bluez library give you access to your bluetooth hardware . So if your bluez
library calls are working and ur jsr82 implementation is using Bluez librar=
y
functions it should work for u.
As I understand Impronto, Avetana gives complete solution for JSR82
including native library.
Impronto internally uses Bluez library only.


regards,
Tushar

On 4/11/07, Bruno Cavaler Ghisi <brunogh@gmail.com> wrote:
>
> Just explaining better... will I need any other lib in the application
> classpath to work?
>
> Thanks,
>
> 2007/4/9, Bruno Cavaler Ghisi <brunogh@gmail.com>:
> > Hi,
> >
> > I am developing some stuff using jsr-82 and I would like to try it in
> > a jse application under Linux.
> >
> > I read about the BlueZ protocol stack and I have installed its
> > packages, however I do not know if I just need to have it in order to
> > the app work, because I read about other things like Impronto, Avetana
> > and I got confused... All of these are bluetooth protocol stacks? Will
> > I need anything else to run my application? Does anybody has any good
> > link about it?
> >
> > Thanks in advance.
> > Bruno
> >
>
>
> --
> Bruno Cavaler Ghisi
> Graduando de Sistemas de Informa=E7=E3o
> Universidade Federal de Santa Catarina
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



--=20
Tushar Paturde

------=_Part_2626_28607734.1176265351564
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Bruno,<br>Bluez library give you access to your bluetooth hardware . So =
if your bluez library calls are working and ur jsr82 implementation is usin=
g Bluez library functions it should work for u.<br>As I understand Impronto=
, Avetana gives complete solution for JSR82 including native library.&nbsp;=
=20
<br>Impronto internally uses Bluez library only.<br><br><br>regards,<br>Tus=
har<br><br><div><span class=3D"gmail_quote">On 4/11/07, <b class=3D"gmail_s=
endername">Bruno Cavaler Ghisi</b> &lt;<a href=3D"mailto:brunogh@gmail.com"=
>brunogh@gmail.com
</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;">Just explaining better... will I need any other lib in the application
<br>classpath to work?<br><br>Thanks,<br><br>2007/4/9, Bruno Cavaler Ghisi =
&lt;<a href=3D"mailto:brunogh@gmail.com">brunogh@gmail.com</a>&gt;:<br>&gt;=
 Hi,<br>&gt;<br>&gt; I am developing some stuff using jsr-82 and I would li=
ke to try it in
<br>&gt; a jse application under Linux.<br>&gt;<br>&gt; I read about the Bl=
ueZ protocol stack and I have installed its<br>&gt; packages, however I do =
not know if I just need to have it in order to<br>&gt; the app work, becaus=
e I read about other things like Impronto, Avetana
<br>&gt; and I got confused... All of these are bluetooth protocol stacks? =
Will<br>&gt; I need anything else to run my application? Does anybody has a=
ny good<br>&gt; link about it?<br>&gt;<br>&gt; Thanks in advance.<br>&gt; B=
runo
<br>&gt;<br><br><br>--<br>Bruno Cavaler Ghisi<br>Graduando de Sistemas de I=
nforma=E7=E3o<br>Universidade Federal de Santa Catarina<br><br>------------=
-------------------------------------------------------------<br>Take Surve=
ys. Earn Cash. Influence the Future of IT
<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance =
to share your<br>opinions on IT &amp; business topics through brief surveys=
-and earn cash<br><a href=3D"http://www.techsay.com/default.php?page=3Djoin=
.php&amp;p=3Dsourceforge&amp;CID=3DDEVDEV">
http://www.techsay.com/default.php?page=3Djoin.php&amp;p=3Dsourceforge&amp;=
CID=3DDEVDEV</a><br>_______________________________________________<br>Blue=
z-users mailing list<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net=
">Bluez-users@lists.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users=
">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockqu=
ote></div><br><br clear=3D"all"><br>-- <br>Tushar Paturde

------=_Part_2626_28607734.1176265351564--


--===============0296962307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0296962307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0296962307==--
