Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <IBM910$CED64CB0C8FF7D70248FA04EBE79E3C3@uol.com.br>
Subject: Re: [Bluez-devel] cross compiling bluez-utils
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="_=__=_XaM3_.1107905076.2A.541147.42.5780.52.42.007.1458344283"
From: "omap" <omap@uol.com.br>
To: "bluez-devel" <bluez-devel@lists.sourceforge.net>
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
Date: Tue,  8 Feb 2005 21:24:36 -0200


--_=__=_XaM3_.1107905076.2A.541147.42.5780.52.42.007.1458344283
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

> 

Hey,


I used a crosscompiling environment called scratchbox and I used the same=
 commands as i was compiling in normal situation.

bluez-libs
./configure --prefix=3D/usr
make
make install

bluez-utils
./configure --prefix=3D/usr --enable-test
make
make install

obs: inside de scratchbox environment

Hi,
> 
> > I crosscompiled bluez-libs, bluez-utils and even hciemu for ARM platf=
orm 
> > and they work fine. I am preparing a little how-to for those insteres=
ted 
> > on doing the same thing.
> 
> They work perfectly here, too. Thanks for the hint! I just found it a l=
ittle inconvenient to find the /etc/bluetooth/ directory in my ARM gcc di=
rectory. To be more specific:
> 
> The compiler, libs, include, ... directories reside under /usr/arm/arm-=
linux. That is set with 'prefix'. The executables then go to something li=
ke /home/mm/arm/ramdisk/mnt by setting 'exec_prefix' accordingly. I thoug=
ht it to be funny to see /etc/bluetooth/ in the ramdisk rather than in th=
e compiler area.
> 
> Martin
> __________________________________________________________
> Mit WEB.DE FreePhone mit hoechster Qualitaet ab 0 Ct./Min.
> weltweit telefonieren! http://freephone.web.de/?mc=3D021201
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting=

> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel=0A =0A________=
__________________________________________________________________=0AAcab=
e com aquelas janelinhas que pulam na sua tela.=0AAntiPop-up UOL - =C9 gr=
=E1tis!=0Ahttp://antipopup.uol.com.br/=0A

--_=__=_XaM3_.1107905076.2A.541147.42.5780.52.42.007.1458344283
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<DIV>&gt; </DIV>
<DIV>&nbsp;</DIV>
<DIV>Hey,</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>I used a crosscompiling environment called scratchbox and I used the=
 same commands as i was compiling in normal situation.</DIV>
<DIV>&nbsp;</DIV>
<DIV>bluez-libs</DIV>
<DIV>./configure --prefix=3D/usr</DIV>
<DIV>make</DIV>
<DIV>make install</DIV>
<DIV>&nbsp;</DIV>
<DIV>bluez-utils</DIV>
<DIV>./configure --prefix=3D/usr --enable-test</DIV>
<DIV>make</DIV>
<DIV>make install</DIV>
<DIV>&nbsp;</DIV>
<DIV>obs: inside de scratchbox environment</DIV>
<DIV>&nbsp;</DIV>
<DIV>Hi,</DIV>
<DIV>&gt; </DIV>
<DIV>&gt; &gt; I crosscompiled bluez-libs, bluez-utils and even hciemu fo=
r ARM platform </DIV>
<DIV>&gt; &gt; and they work fine. I am preparing a little how-to for tho=
se insterested </DIV>
<DIV>&gt; &gt; on doing the same thing.</DIV>
<DIV>&gt; </DIV>
<DIV>&gt; They work perfectly here, too. Thanks for the hint! I just foun=
d it a little inconvenient to find the /etc/bluetooth/ directory in my AR=
M gcc directory. To be more specific:</DIV>
<DIV>&gt; </DIV>
<DIV>&gt; The compiler, libs, include, ... directories reside under /usr/=
arm/arm-linux. That is set with 'prefix'. The executables then go to some=
thing like /home/mm/arm/ramdisk/mnt by setting 'exec_prefix' accordingly.=
 I thought it to be funny to see /etc/bluetooth/ in the ramdisk rather th=
an in the compiler area.</DIV>
<DIV>&gt; </DIV>
<DIV>&gt; Martin</DIV>
<DIV>&gt; __________________________________________________________</DIV=
>
<DIV>&gt; Mit WEB.DE FreePhone mit hoechster Qualitaet ab 0 Ct./Min.</DIV=
>
<DIV>&gt; weltweit telefonieren! http://freephone.web.de/?mc=3D021201</DI=
V>
<DIV>&gt; </DIV>
<DIV>&gt; </DIV>
<DIV>&gt; </DIV>
<DIV>&gt; -------------------------------------------------------</DIV>
<DIV>&gt; This SF.Net email is sponsored by: IntelliVIEW -- Interactive R=
eporting</DIV>
<DIV>&gt; Tool for open source databases. Create drag-&amp;-drop reports.=
 Save time</DIV>
<DIV>&gt; by over 75%! Publish reports on the web. Export to DOC, XLS, RT=
F, etc.</DIV>
<DIV>&gt; Download a FREE copy at http://www.intelliview.com/go/osdn_nl</=
DIV>
<DIV>&gt; _______________________________________________</DIV>
<DIV>&gt; Bluez-devel mailing list</DIV>
<DIV>&gt; Bluez-devel@lists.sourceforge.net</DIV>
<DIV>&gt; https://lists.sourceforge.net/lists/listinfo/bluez-devel</DIV>

--_=__=_XaM3_.1107905076.2A.541147.42.5780.52.42.007.1458344283--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
