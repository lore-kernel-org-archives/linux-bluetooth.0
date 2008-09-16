Return-Path: <cyrus@holtmann.org>
Message-ID: <35c90d960809160956g186fc668p7970c4f6a4d4bf70@mail.gmail.com>
Date: Tue, 16 Sep 2008 09:56:00 -0700
From: "Nick Pelly" <npelly@google.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <f21e7dc80809131154s7d0b7e99t23201743f65e1f50@mail.gmail.com>
MIME-Version: 1.0
References: <f21e7dc80809131026g15f66f3eq81980dc507607065@mail.gmail.com>
	<1221330440.6695.53.camel@californication>
	<f21e7dc80809131132udb89654hf2b76149b4b03203@mail.gmail.com>
	<1221331676.6695.55.camel@californication>
	<f21e7dc80809131154s7d0b7e99t23201743f65e1f50@mail.gmail.com>
Subject: Re: [Bluez-devel] A2DP over DBUS
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1722932545=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1722932545==
Content-Type: multipart/alternative;
	boundary="----=_Part_16142_2422857.1221584160202"

------=_Part_16142_2422857.1221584160202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Sep 13, 2008 at 11:54 AM, Choi Sonim <choisonim@gmail.com> wrote:

> Hi Marcel,
>
> On Sat, Sep 13, 2008 at 9:47 PM, Marcel Holtmann <marcel@holtmann.org>
> wrote:
> >> Can you please explain briefly what's the underlying method that the
> >> plugin uses to send the data to bluez then ? does it directly uses
> >> sockets and sends it to the kernel ?
> >
> > direct SCO or L2CAP sockets to have a low latency and to avoid copying
> > data around.
>
> That's interesting. What about platforms like Android that are only
> Java (If I am not wrong) ?


Android is definitely not pure Java, although third party apps for Android
are recommended to use the Java API's.

The built in Android profiles currently open sockets with the kernel in C
code.

Can they connect directly to those sockets
> from Java applications ?


In Android v1.0 we will not have stable Java API's to use Bluetooth :(

In the near future we intend to expose RFCOMM, L2CAP and SCO (control only)
via a Java Socket-like API for third party app development.


> Thank you a lot
> Choi
>
> >
> > Regards
> >
> > Marcel
> >
> >
> >
> > -------------------------------------------------------------------------
> > This SF.Net email is sponsored by the Moblin Your Move Developer's
> challenge
> > Build the coolest Linux based applications with Moblin SDK & win great
> prizes
> > Grand prize is a trip for two to an Open Source event anywhere in the
> world
> > http://moblin-contest.org/redirect.php?banner_id=100&url=/
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
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

------=_Part_16142_2422857.1221584160202
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><br><br><div class="gmail_quote">On Sat, Sep 13, 2008 at 11:54 AM, Choi Sonim <span dir="ltr">&lt;<a href="mailto:choisonim@gmail.com">choisonim@gmail.com</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Marcel,<br>
<div class="Ih2E3d"><br>
On Sat, Sep 13, 2008 at 9:47 PM, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:<br>
&gt;&gt; Can you please explain briefly what&#39;s the underlying method that the<br>
&gt;&gt; plugin uses to send the data to bluez then ? does it directly uses<br>
&gt;&gt; sockets and sends it to the kernel ?<br>
&gt;<br>
&gt; direct SCO or L2CAP sockets to have a low latency and to avoid copying<br>
&gt; data around.<br>
<br>
</div>That&#39;s interesting. What about platforms like Android that are only<br>
Java (If I am not wrong) ?</blockquote><div><br>Android is definitely not pure Java, although third party apps for Android are recommended to use the Java API&#39;s.<br><br>The built in Android profiles currently open sockets with the kernel in C code.<br>
<br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"> Can they connect directly to those sockets<br>
from Java applications ?</blockquote><div><br>In Android v1.0 we will not have stable Java API&#39;s to use Bluetooth :(<br><br>In the near future we intend to expose RFCOMM, L2CAP and SCO (control only) via a Java Socket-like API for third party app development.<br>
<br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
Thank you a lot<br>
<font color="#888888">Choi<br>
</font><div><div></div><div class="Wj3C7c"><br>
&gt;<br>
&gt; Regards<br>
&gt;<br>
&gt; Marcel<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; -------------------------------------------------------------------------<br>
&gt; This SF.Net email is sponsored by the Moblin Your Move Developer&#39;s challenge<br>
&gt; Build the coolest Linux based applications with Moblin SDK &amp; win great prizes<br>
&gt; Grand prize is a trip for two to an Open Source event anywhere in the world<br>
&gt; <a href="http://moblin-contest.org/redirect.php?banner_id=100&amp;url=/" target="_blank">http://moblin-contest.org/redirect.php?banner_id=100&amp;url=/</a><br>
&gt; _______________________________________________<br>
&gt; Bluez-devel mailing list<br>
&gt; <a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>
&gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>
&gt;<br>
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
</div></div></blockquote></div><br></div>

------=_Part_16142_2422857.1221584160202--


--===============1722932545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1722932545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1722932545==--
