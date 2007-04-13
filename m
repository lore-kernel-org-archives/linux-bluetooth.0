Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 12 Apr 2007 22:43:03 -0700 (PDT)
From: Mahtab Hossain <mahtab_hossain2002@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <2bf8a3380704121124t70285f8oe2b1678d69648319@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <490566.10171.qm@web50504.mail.re2.yahoo.com>
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
Content-Type: multipart/mixed; boundary="===============2069756262=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2069756262==
Content-Type: multipart/alternative; boundary="0-1490703059-1176442983=:10171"
Content-Transfer-Encoding: 8bit

--0-1490703059-1176442983=:10171
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

JBlueZ is very old and hasn't been taken forward. Last time I checked, Avetana was providing a free JSR-82 on top of BlueZ (much of the code of Avetana were same as JBlueZ). Other JSR-82 implementation are not free as far as I remember.

Thanks
Mahtab

Bruno Cavaler Ghisi <brunogh@gmail.com> wrote: I have installed BlueZ but I do not know which java library I could
use to communicate with it. I have heard about JBlueZ, is it good? Any
other suggestions?

Thanks,
Bruno

2007/4/11, Tushar Paturde :
> Hi Bruno,
> Bluez library give you access to your bluetooth hardware . So if your bluez
> library calls are working and ur jsr82 implementation is using Bluez library
> functions it should work for u.
> As I understand Impronto, Avetana gives complete solution for JSR82
> including native library.
> Impronto internally uses Bluez library only.
>
>
> regards,
> Tushar
>
>
> On 4/11/07, Bruno Cavaler Ghisi 
 wrote:
> >
> > Just explaining better... will I need any other lib in the application
> > classpath to work?
> >
> > Thanks,
> >
> > 2007/4/9, Bruno Cavaler Ghisi 
:
> > > Hi,
> > >
> > > I am developing some stuff using jsr-82 and I would like to try it in
> > > a jse application under Linux.
> > >
> > > I read about the BlueZ protocol stack and I have installed its
> > > packages, however I do not know if I just need to have it in order to
> > > the app work, because I read about other things like Impronto, Avetana
> > > and I got confused... All of these are bluetooth protocol stacks? Will
> > > I need anything else to run my application? Does anybody has any good
> > > link about it?
> > >
> > > Thanks in advance.
> > > Bruno
> > >
> >
> >
> > --
> > Bruno Cavaler Ghisi
> > Graduando de Sistemas de Informação
> > Universidade Federal de Santa Catarina
> >
> >
> -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> > opinions on IT & business topics through brief surveys-and earn cash
> >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
>
>
>
> --
> Tushar Paturde
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>


-- 
Bruno Cavaler Ghisi
Graduando de Sistemas de Informação
Universidade Federal de Santa Catarina

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


       
---------------------------------
It's here! Your new message!
Get new email alerts with the free Yahoo! Toolbar.
--0-1490703059-1176442983=:10171
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

JBlueZ is very old and hasn't been taken forward. Last time I checked, Avetana was providing a free JSR-82 on top of BlueZ (much of the code of Avetana were same as JBlueZ). Other JSR-82 implementation are not free as far as I remember.<br><br>Thanks<br>Mahtab<br><br><b><i>Bruno Cavaler Ghisi &lt;brunogh@gmail.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> I have installed BlueZ but I do not know which java library I could<br>use to communicate with it. I have heard about JBlueZ, is it good? Any<br>other suggestions?<br><br>Thanks,<br>Bruno<br><br>2007/4/11, Tushar Paturde <tusharpaturde@gmail.com>:<br>&gt; Hi Bruno,<br>&gt; Bluez library give you access to your bluetooth hardware . So if your bluez<br>&gt; library calls are working and ur jsr82 implementation is using Bluez library<br>&gt; functions it should work for u.<br>&gt; As I understand Impronto, Avetana gives complete solution
 for JSR82<br>&gt; including native library.<br>&gt; Impronto internally uses Bluez library only.<br>&gt;<br>&gt;<br>&gt; regards,<br>&gt; Tushar<br>&gt;<br>&gt;<br>&gt; On 4/11/07, Bruno Cavaler Ghisi <brunogh@gmail.com> wrote:<br>&gt; &gt;<br>&gt; &gt; Just explaining better... will I need any other lib in the application<br>&gt; &gt; classpath to work?<br>&gt; &gt;<br>&gt; &gt; Thanks,<br>&gt; &gt;<br>&gt; &gt; 2007/4/9, Bruno Cavaler Ghisi <brunogh@gmail.com>:<br>&gt; &gt; &gt; Hi,<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; I am developing some stuff using jsr-82 and I would like to try it in<br>&gt; &gt; &gt; a jse application under Linux.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; I read about the BlueZ protocol stack and I have installed its<br>&gt; &gt; &gt; packages, however I do not know if I just need to have it in order to<br>&gt; &gt; &gt; the app work, because I read about other things like Impronto, Avetana<br>&gt; &gt; &gt; and I got confused... All of these are bluetooth
 protocol stacks? Will<br>&gt; &gt; &gt; I need anything else to run my application? Does anybody has any good<br>&gt; &gt; &gt; link about it?<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Thanks in advance.<br>&gt; &gt; &gt; Bruno<br>&gt; &gt; &gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; --<br>&gt; &gt; Bruno Cavaler Ghisi<br>&gt; &gt; Graduando de Sistemas de Informação<br>&gt; &gt; Universidade Federal de Santa Catarina<br>&gt; &gt;<br>&gt; &gt;<br>&gt; -------------------------------------------------------------------------<br>&gt; &gt; Take Surveys. Earn Cash. Influence the Future of IT<br>&gt; &gt; Join SourceForge.net's Techsay panel and you'll get the chance to share<br>&gt; your<br>&gt; &gt; opinions on IT &amp; business topics through brief surveys-and earn cash<br>&gt; &gt;<br>&gt; http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV<br>&gt; &gt; _______________________________________________<br>&gt; &gt; Bluez-users mailing list<br>&gt; &gt;
 Bluez-users@lists.sourceforge.net<br>&gt; &gt; https://lists.sourceforge.net/lists/listinfo/bluez-users<br>&gt; &gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt; --<br>&gt; Tushar Paturde<br>&gt; -------------------------------------------------------------------------<br>&gt; Take Surveys. Earn Cash. Influence the Future of IT<br>&gt; Join SourceForge.net's Techsay panel and you'll get the chance to share your<br>&gt; opinions on IT &amp; business topics through brief surveys-and earn cash<br>&gt; http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV<br>&gt; _______________________________________________<br>&gt; Bluez-users mailing list<br>&gt; Bluez-users@lists.sourceforge.net<br>&gt; https://lists.sourceforge.net/lists/listinfo/bluez-users<br>&gt;<br>&gt;<br><br><br>-- <br>Bruno Cavaler Ghisi<br>Graduando de Sistemas de Informação<br>Universidade Federal de Santa
 Catarina<br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br>http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV<br>_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></brunogh@gmail.com></brunogh@gmail.com></tusharpaturde@gmail.com></blockquote><br><p>&#32;
      <hr size=1>It's here! Your new message!<br>Get
<a href="http://us.rd.yahoo.com/evt=49938/*http://tools.search.yahoo.com/toolbar/features/mail/"> new email alerts</a> with the free <a href="
http://us.rd.yahoo.com/evt=49938/*http://tools.search.yahoo.com/toolbar/features/mail/">Yahoo! Toolbar.</a>
--0-1490703059-1176442983=:10171--


--===============2069756262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============2069756262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2069756262==--
