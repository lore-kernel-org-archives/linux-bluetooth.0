Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050902102514.73330.qmail@web35310.mail.mud.yahoo.com>
From: Swathi Mathur80 <swathi_mathur80@yahoo.com>
Subject: Re: [Bluez-users] source code for bluez
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1125056087.25535.11.camel@pegasus>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-561001498-1125656713=:72506"
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
Date: Fri, 2 Sep 2005 03:25:13 -0700 (PDT)

--0-561001498-1125656713=:72506
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello,
As per your suggestions i downloaded 2.4.x kernel patch which is supposed to have the Bluez on it.  But i am not able to find the bluez code. 
1. Which folder has the bluez ?
2. Do i still need the packages from the www.bluez.org to write my applications program or just the patch is enough to write my applications. 
The second question was not answered in my previous queries. Could any one be kind enough to answer my queries. as i don't have any experience on working on the linux OS.
Thanks & Warm Regards,
Swathi

Marcel Holtmann <marcel@holtmann.org> wrote:
Hi Swathi,

> I want to port bluez protocol stack onto the T-Engine ( which has a
> T-Kernel as the operating System). T-Kernel usb host protocol does not
> support isochronous data transfer. 

what the f* is T-Engine and T-Kernel?

The USB isoc transfer are only needed for the SCO channel in the USB
host transport protocol.

> Where can i find the whole bluez protocol stack ? the *.c files.
> For minimal functionality is it sufficient to have the bluez-libs and
> bluez-utils package as this is being mentioned in the
> http://www.bluez.org/download.html website.

Maybe you should look at www.kernel.org ;)

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-561001498-1125656713=:72506
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hello,</DIV>
<DIV>As per your suggestions i&nbsp;downloaded 2.4.x kernel patch which is supposed to have the Bluez on it. &nbsp;But i am not able to find the bluez code. </DIV>
<DIV>1. Which folder has the bluez ?</DIV>
<DIV>2. Do i still need the packages from the <A href="http://www.bluez.org">www.bluez.org</A> to write my applications program or just the patch is enough to write my applications. </DIV>
<DIV>The second question was not answered in my previous queries. Could any one be kind enough to answer my queries. as i don't have any experience on working on the linux OS.</DIV>
<DIV>Thanks &amp; Warm Regards,</DIV>
<DIV>Swathi</DIV>
<DIV><BR><B><I>Marcel Holtmann &lt;marcel@holtmann.org&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi Swathi,<BR><BR>&gt; I want to port bluez protocol stack onto the T-Engine ( which has a<BR>&gt; T-Kernel as the operating System). T-Kernel usb host protocol does not<BR>&gt; support isochronous data transfer. <BR><BR>what the f* is T-Engine and T-Kernel?<BR><BR>The USB isoc transfer are only needed for the SCO channel in the USB<BR>host transport protocol.<BR><BR>&gt; Where can i find the whole bluez protocol stack ? the *.c files.<BR>&gt; For minimal functionality is it sufficient to have the bluez-libs and<BR>&gt; bluez-utils package as this is being mentioned in the<BR>&gt; http://www.bluez.org/download.html website.<BR><BR>Maybe you should look at www.kernel.org ;)<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR><BR>-------------------------------------------------------<BR>SF.Net email is Sponsored by the Better Software Conference &amp; EXPO<BR>September 19-22, 2005 * Sa
 n
 Francisco, CA * Development Lifecycle Practices<BR>Agile &amp; Plan-Driven Development * Managing Projects &amp; Teams * Testing &amp; QA<BR>Security * Process Improvement &amp; Measurement * http://www.sqe.com/bsce5sf<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-561001498-1125656713=:72506--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
