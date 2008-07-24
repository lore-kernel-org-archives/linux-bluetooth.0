Return-Path: <cyrus@holtmann.org>
Message-ID: <50b40ba70807241118y79325efene53bde2612e8c783@mail.gmail.com>
Date: Fri, 25 Jul 2008 02:18:38 +0800
From: "Nick Pelly" <npelly@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20080724T175951-14@post.gmane.org>
MIME-Version: 1.0
References: <loom.20080724T175951-14@post.gmane.org>
Subject: Re: [Bluez-devel] About socket interface
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1926688167=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1926688167==
Content-Type: multipart/alternative;
	boundary="----=_Part_57743_11715789.1216923518642"

------=_Part_57743_11715789.1216923518642
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The HCI event that triggers this is the Connection Request Event 0x04,
probably handled in hci_event.c

2008/7/25 Jui-Hao Chiang <windtracekimo@gmail.com>:

> Hi,
> I have a question about the user socket interface.
> When I run the scotest -d, I know it will basically call sco_sock_accept in
> sco.c
> Inside it, there is a wait queue and try to find a new socket.
> The accept() will be notified when there is a new connection coming from
> another
> client.
> My question is: how the bluez notify the user socket "accept()"? Can anyone
> tell
> me where the event is generated and finally notify user socket accept()?
> Just
> need a keyword.
>
> Hope this time someone can answer me. maybe I am keeping asking stupid
> question
> so that nobody wants to answer it.
>
> Bests
>
>
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's
> challenge
> Build the coolest Linux based applications with Moblin SDK & win great
> prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_57743_11715789.1216923518642
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">The HCI event that triggers this is the Connection Request Event 0x04, probably handled in hci_event.c<br><br><div class="gmail_quote">2008/7/25 Jui-Hao Chiang &lt;<a href="mailto:windtracekimo@gmail.com">windtracekimo@gmail.com</a>&gt;:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br>
I have a question about the user socket interface.<br>
When I run the scotest -d, I know it will basically call sco_sock_accept in sco.c<br>
Inside it, there is a wait queue and try to find a new socket.<br>
The accept() will be notified when there is a new connection coming from another<br>
client.<br>
My question is: how the bluez notify the user socket &quot;accept()&quot;? Can anyone tell<br>
me where the event is generated and finally notify user socket accept()? Just<br>
need a keyword.<br>
<br>
Hope this time someone can answer me. maybe I am keeping asking stupid question<br>
so that nobody wants to answer it.<br>
<br>
Bests<br>
<br>
<br>
-------------------------------------------------------------------------<br>
This SF.Net email is sponsored by the Moblin Your Move Developer&#39;s challenge<br>
Build the coolest Linux based applications with Moblin SDK &amp; win great prizes<br>
Grand prize is a trip for two to an Open Source event anywhere in the world<br>
<a href="http://moblin-contest.org/redirect.php?banner_id=100&amp;url=/" target="_blank">http://moblin-contest.org/redirect.php?banner_id=100&amp;url=/</a><br>
_______________________________________________<br>
Bluez-devel mailing list<br>
<a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>
</blockquote></div><br></div>

------=_Part_57743_11715789.1216923518642--


--===============1926688167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1926688167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1926688167==--
