Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <24a5055d0703020204i146520bdgbabe177dfb56201f@mail.gmail.com>
Date: Fri, 2 Mar 2007 15:34:16 +0530
From: "Rahul Tank" <tank.rahul@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ddea76ce0703020147p24d01969rb76b40b856b4bfe0@mail.gmail.com>
MIME-Version: 1.0
References: <ddea76ce0703020147p24d01969rb76b40b856b4bfe0@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1672705259=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1672705259==
Content-Type: multipart/alternative;
	boundary="----=_Part_40970_4243466.1172829856075"

------=_Part_40970_4243466.1172829856075
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 3/2/07, Meenakshi Seeballack <meena2010@gmail.com> wrote:
>
> I think I need to start from scratch to get the bluetooth folder in
> /usr/inlcude. So I downloaded these libraries:
> bluez-libs-3.9.tar.gz<http://www.bluez.org/redirect.php?url=http%3A%2F%2Fbluez.sf.net%2Fdownload%2Fbluez-libs-3.9.tar.gz>
> bluez-utils-3.9.tar.gz<http://www.bluez.org/redirect.php?url=http%3A%2F%2Fbluez.sf.net%2Fdownload%2Fbluez-utils-3.9.tar.gz>
> bluez-firmware-1.2.tar.gz<http://www.bluez.org/redirect.php?url=http%3A%2F%2Fbluez.sf.net%2Fdownload%2Fbluez-firmware-1.2.tar.gz>
> bluez-hcidump-1.34.tar.gz<http://www.bluez.org/redirect.php?url=http%3A%2F%2Fbluez.sf.net%2Fdownload%2Fbluez-hcidump-1.34.tar.gz>
> bluez-gnome-0.6.tar.gz<http://www.bluez.org/redirect.php?url=http%3A%2F%2Fbluez.sf.net%2Fdownload%2Fbluez-gnome-0.6.tar.gz>
>
> and saved them onto my desktop. I have a folder called bluez on my
> desktop, and I have un-packed the tarballs above.
> I am in the terminal trying to install bluez-utils-3.9 by ./configure and
> I get this error:
> configure: error: Bluetooth library is required
> Please guide me in my next steps as i am a novice to Linux?
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
> Install bluez-libs-3.9 before installing bluez-utils-3.9 . Google is your
friend in case you have such problems :)

------=_Part_40970_4243466.1172829856075
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 3/2/07, <b class="gmail_sendername">Meenakshi Seeballack</b> &lt;<a href="mailto:meena2010@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">meena2010@gmail.com
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
I think I need to start from scratch to get the bluetooth folder in /usr/inlcude. So I downloaded these libraries:<br><a href="http://www.bluez.org/redirect.php?url=http%3A%2F%2Fbluez.sf.net%2Fdownload%2Fbluez-libs-3.9.tar.gz" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">




bluez-libs-3.9.tar.gz</a><br><a href="http://www.bluez.org/redirect.php?url=http%3A%2F%2Fbluez.sf.net%2Fdownload%2Fbluez-utils-3.9.tar.gz" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
bluez-utils-3.9.tar.gz</a><br><a href="http://www.bluez.org/redirect.php?url=http%3A%2F%2Fbluez.sf.net%2Fdownload%2Fbluez-firmware-1.2.tar.gz" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
bluez-firmware-1.2.tar.gz</a><br><a href="http://www.bluez.org/redirect.php?url=http%3A%2F%2Fbluez.sf.net%2Fdownload%2Fbluez-hcidump-1.34.tar.gz" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
bluez-hcidump-1.34.tar.gz</a><br><a href="http://www.bluez.org/redirect.php?url=http%3A%2F%2Fbluez.sf.net%2Fdownload%2Fbluez-gnome-0.6.tar.gz" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
bluez-gnome-0.6.tar.gz</a><br><br>and saved them onto my desktop. I have a folder called bluez on my desktop, and I have un-packed the tarballs above.<br>I am in the terminal trying to install bluez-utils-3.9 by ./configure and I get this error: 
<br><span style="font-weight: bold;">configure: error: Bluetooth library is required</span><br>Please guide me in my next steps as i am a novice to Linux?
<br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">https://lists.sourceforge.net/lists/listinfo/bluez-devel
</a><br><br></blockquote></div>Install bluez-libs-3.9 before installing bluez-utils-3.9 . Google is your friend in case you have such problems :)<br>

------=_Part_40970_4243466.1172829856075--


--===============1672705259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1672705259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1672705259==--
