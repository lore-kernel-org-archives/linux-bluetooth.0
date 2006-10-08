Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3f5a9ba20610072313w41cb4aa1qf0b5a21a7199f737@mail.gmail.com>
Date: Sun, 8 Oct 2006 14:13:04 +0800
From: "Mingfan.Lu" <lucharse@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1159972670.1601.25.camel@localhost>
MIME-Version: 1.0
References: <3f5a9ba20609291930r5b4e4c97g8b33901666fef491@mail.gmail.com>
	<3f5a9ba20610020946v10c99300pee5cc04f3f2597e6@mail.gmail.com>
	<1159972670.1601.25.camel@localhost>
Subject: Re: [Bluez-devel] About the kernel 2.6.18
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0244492958=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0244492958==
Content-Type: multipart/alternative;
	boundary="----=_Part_155737_3998685.1160287984156"

------=_Part_155737_3998685.1160287984156
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
  I have rebuilt the 2.6.17, the speed is good. so, I don't know why
2.6.18makes the RFCOMM socket communication slower.
Who can have a try to compare the speed using different kernel ?
Need your nice help. :)


2006/10/4, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi,
>
> >
> >    My oepnsuse 10.1 with the default kernel 2.6.16.13-4.
> >    When 2.6.18-mh3 released, I rebuilt and updated the kernel to
> > 2.6.18 and then patched it.
> >    When Holtman released the patch for handling multiple l2cap
> > connections, I patched the new kernel .
> >    But at last, I found that the speed of  the OBEX pushing and other
> > Rfcomm socket communications is slower than the original kernel.
> >    Then I rebuilt the 2.6.18 without the 2.6.18-mh3 and the patch for
> > handling multiple l2cap connections, I found it is still slower.
> >    So I think the patch is not the reason.
> >    But what makes the bluetooth communication slower? The new kernel
> > version 2.6.18?
>
> if the 2.6.18 kernel is slower, then it must be something else. You
> might wanna test with a 2.6.17 kernel.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



-- 
With respects,
   Mingfan.Lu

------=_Part_155737_3998685.1160287984156
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp; I have rebuilt the 2.6.17, the speed is good. so, I don't know why 2.6.18 makes the RFCOMM socket communication slower.</div>
<div>Who can have a try to compare the speed using different kernel ?</div>
<div>Need your nice help. :)<br><br>&nbsp;</div>
<div><span class="gmail_quote">2006/10/4, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi,<br><br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;My oepnsuse 10.1 with the default kernel 2.6.16.13-4.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;When 2.6.18-mh3
 released, I rebuilt and updated the kernel to<br>&gt; 2.6.18 and then patched it.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;When Holtman released the patch for handling multiple l2cap<br>&gt; connections, I patched the new kernel .<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;But at last, I found that the speed of&nbsp;&nbsp;the OBEX pushing and other
<br>&gt; Rfcomm socket communications is slower than the original kernel.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;Then I rebuilt the 2.6.18 without the 2.6.18-mh3 and the patch for<br>&gt; handling multiple l2cap connections, I found it is still slower.
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;So I think the patch is not the reason.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;But what makes the bluetooth communication slower? The new kernel<br>&gt; version 2.6.18?<br><br>if the 2.6.18 kernel is slower, then it must be something else. You
<br>might wanna test with a 2.6.17 kernel.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join 
SourceForge.net's Techsay panel and you'll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys -- and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br><br clear="all"><br>-- <br>With respects,<br>&nbsp;&nbsp; Mingfan.Lu 

------=_Part_155737_3998685.1160287984156--


--===============0244492958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0244492958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0244492958==--
