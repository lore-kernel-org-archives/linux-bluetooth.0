Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <24a5055d0703020528v548ee1ceh6a50697e1bc9b16@mail.gmail.com>
Date: Fri, 2 Mar 2007 18:58:56 +0530
From: "Rahul Tank" <tank.rahul@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20070302T112427-678@post.gmane.org>
MIME-Version: 1.0
References: <ddea76ce0703020147p24d01969rb76b40b856b4bfe0@mail.gmail.com>
	<24a5055d0703020204i146520bdgbabe177dfb56201f@mail.gmail.com>
	<loom.20070302T112427-678@post.gmane.org>
Subject: Re: [Bluez-devel] HELP configure: error: Bluetooth library is
	required
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0494739739=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0494739739==
Content-Type: multipart/alternative;
	boundary="----=_Part_630_15163678.1172842136822"

------=_Part_630_15163678.1172842136822
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 3/2/07, Meena Seeballack <meena2010@gmail.com> wrote:
>
> Rahul Tank <tank.rahul <at> gmail.com> writes:
>
> >
> >
> >
> > On 3/2/07, Meenakshi Seeballack <meena2010 <at> gmail.com
> > > wrote:
> > I think I need to start from scratch to get the bluetooth folder in
> /usr/inlcude. So I downloaded these libraries:
> >
> >
> >
> >
> > bluez-libs-3.9.tar.gz
> > bluez-utils-3.9.tar.gz
> > bluez-firmware-1.2.tar.gz
> > bluez-hcidump-1.34.tar.gz
> > bluez-gnome-0.6.tar.gzand saved them onto my desktop. I have a folder
> called
> bluez on my desktop, and I have un-packed the tarballs above.I am in the
> terminal trying to install bluez-utils-3.9 by ./configure and I get this
> error:
> > configure: error: Bluetooth library is requiredPlease guide me in my
> next
> steps as i am a novice to Linux?
> >
> -------------------------------------------------------------------------Take
> Surveys. Earn Cash. Influence the Future of ITJoin SourceForge.net's
> Techsay
> panel and you'll get the chance to share your
> > opinions on IT & business topics through brief surveys-and earn cash
> >
> >
>
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV_______________________________________________Bluez-devel
> mailing list
> >
> > Bluez-devel <at>
> lists.sourceforge
> .nethttps://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
> >
> > Install bluez-libs-3.9 before installing bluez-utils-3.9 . Google is
> your
> friend in case you have such problems :)
> >
> >
> >
> -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> > opinions on IT & business topics through brief surveys-and earn cash
> >
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> >
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel <at> lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
> ----------------------------------------------------
> I have installed bluez-libs, bluez-firmware-1.2 and
> bluez-gnome-0.6 without any
> problem.
> When I then try to install bluez-utils
> or bluez-hcidump-1.34, I get the same error:
> checking for BLUEZ... no
> configure: error: Bluetooth library is required
> Please help!!!
>
>
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

 if bluez-libs is installed, check that the PKG_CONFIG_PATH has the path
where bluez.pc is present.

 regards,
   rahul

------=_Part_630_15163678.1172842136822
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 3/2/07, <b class="gmail_sendername">Meena Seeballack</b> &lt;<a href="mailto:meena2010@gmail.com">meena2010@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Rahul Tank &lt;tank.rahul &lt;at&gt; <a href="http://gmail.com">gmail.com</a>&gt; writes:<br><br>&gt;<br>&gt;<br>&gt;<br>&gt; On 3/2/07, Meenakshi Seeballack &lt;meena2010 &lt;at&gt; <a href="http://gmail.com">gmail.com</a>
<br>&gt; &gt; wrote:<br>&gt; I think I need to start from scratch to get the bluetooth folder in<br>/usr/inlcude. So I downloaded these libraries:<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt; bluez-libs-3.9.tar.gz<br>&gt; bluez-utils-3.9.tar.gz
<br>&gt; bluez-firmware-1.2.tar.gz<br>&gt; bluez-hcidump-1.34.tar.gz<br>&gt; bluez-gnome-0.6.tar.gzand saved them onto my desktop. I have a folder called<br>bluez on my desktop, and I have un-packed the tarballs above.I am in the
<br>terminal trying to install bluez-utils-3.9 by ./configure and I get this error:<br>&gt; configure: error: Bluetooth library is requiredPlease guide me in my next<br>steps as i am a novice to Linux?<br>&gt; -------------------------------------------------------------------------Take
<br>Surveys. Earn Cash. Influence the Future of ITJoin SourceForge.net&#39;s Techsay<br>panel and you&#39;ll get the chance to share your<br>&gt; opinions on IT &amp; business topics through brief surveys-and earn cash<br>
&gt;<br>&gt;<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV_______________________________________________Bluez-devel">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV_______________________________________________Bluez-devel
</a><br>mailing list<br>&gt;<br>&gt; Bluez-devel &lt;at&gt;<br>lists.sourceforge.nethttps://lists.sourceforge.net/lists/listinfo/bluez-devel<br>&gt;<br>&gt;<br>&gt; Install bluez-libs-3.9 before installing bluez-utils-3.9
 . Google is your<br>friend in case you have such problems :)<br>&gt;<br>&gt;<br>&gt; -------------------------------------------------------------------------<br>&gt; Take Surveys. Earn Cash. Influence the Future of IT<br>
&gt; Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>&gt; opinions on IT &amp; business topics through brief surveys-and earn cash<br>&gt; <a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>&gt;<br>&gt; _______________________________________________<br>&gt; Bluez-devel mailing list<br>&gt; Bluez-devel &lt;at&gt; <a href="http://lists.sourceforge.net">
lists.sourceforge.net</a><br>&gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>&gt;<br>----------------------------------------------------
<br>I have installed bluez-libs, bluez-firmware-1.2 and<br>bluez-gnome-0.6 without any<br>problem.<br>When I then try to install bluez-utils<br>or bluez-hcidump-1.34, I get the same error:<br>checking for BLUEZ... no<br>configure: error: Bluetooth library is required
<br>Please help!!!<br><br><br><br><br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br>&nbsp;if bluez-libs is installed, check that the PKG_CONFIG_PATH has the path where bluez.pc is present.<br><br>&nbsp;regards,<br>&nbsp;&nbsp; rahul <br><br>

------=_Part_630_15163678.1172842136822--


--===============0494739739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0494739739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0494739739==--
