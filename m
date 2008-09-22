Return-Path: <cyrus@holtmann.org>
Message-ID: <4f9823290809212308h7ba27f0cr7d4e88c67d38b097@mail.gmail.com>
Date: Mon, 22 Sep 2008 08:08:34 +0200
From: "Reto Bachmann" <reto.bachmann@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <89b6ba3a0809190118h1b85dcd7y9fc7dcf89fab09ee@mail.gmail.com>
MIME-Version: 1.0
References: <4f9823290809180242j56115a6es3a77ffa21eabbf0a@mail.gmail.com>
	<1221757910.6782.17.camel@californication>
	<4f9823290809182356x2ad1386bn3de0ebb6ada66789@mail.gmail.com>
	<89b6ba3a0809190118h1b85dcd7y9fc7dcf89fab09ee@mail.gmail.com>
Subject: Re: [Bluez-devel] What happens with bluetooth when connection is
	interrupted
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1272402424056023227=="
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1272402424056023227==
Content-Type: multipart/alternative;
	boundary="----=_Part_9764_21083190.1222063714357"

------=_Part_9764_21083190.1222063714357
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Patryk,

i see the problems and I will change it. I now made some tests and i found
out that the library waits for a specific time until it sends the signal. I
suppose that in this time it tries to repair the connection.

Is it possible to manage this time period with compiling flags or something?

Thanks,
Reto

2008/9/19 Patryk Zawadzki <patrys@pld-linux.org>

> On Fri, Sep 19, 2008 at 8:56 AM, Reto Bachmann <reto.bachmann@gmail.com>
> wrote:
> > So I need to connect the D-Bus signal RemoteDeviceDisconnected to find
> out
> > that I am not connected anymore?
> >
> > Why shouldn't I poll for a status? Is it just because a signal is sent
> > either way or is the status i ask for not the true status?
>
> Because polling is the worst strategy both CPU- and power-wise. It
> causes frequent wakeups that waste power and prevent CPUs from
> entering a deep idle state. They also generate unnecessary traffic for
> the IPC mechanism so if every program decided to poll for something
> once a second, services like DBus would likely get hosed.
>
> --
> Patryk Zawadzki
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

------=_Part_9764_21083190.1222063714357
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi Patryk,<br><br>i see the problems and I will change it. I now made some tests and i found out that the library waits for a specific time until it sends the signal. I suppose that in this time it tries to repair the connection.<br>
<br>Is it possible to manage this time period with compiling flags or something?<br><br>Thanks,<br>Reto<br><br><div class="gmail_quote">2008/9/19 Patryk Zawadzki <span dir="ltr">&lt;<a href="mailto:patrys@pld-linux.org" target="_blank">patrys@pld-linux.org</a>&gt;</span><br>

<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>On Fri, Sep 19, 2008 at 8:56 AM, Reto Bachmann &lt;<a href="mailto:reto.bachmann@gmail.com" target="_blank">reto.bachmann@gmail.com</a>&gt; wrote:<br>


&gt; So I need to connect the D-Bus signal RemoteDeviceDisconnected to find out<br>
&gt; that I am not connected anymore?<br>
&gt;<br>
&gt; Why shouldn&#39;t I poll for a status? Is it just because a signal is sent<br>
&gt; either way or is the status i ask for not the true status?<br>
<br>
</div>Because polling is the worst strategy both CPU- and power-wise. It<br>
causes frequent wakeups that waste power and prevent CPUs from<br>
entering a deep idle state. They also generate unnecessary traffic for<br>
the IPC mechanism so if every program decided to poll for something<br>
once a second, services like DBus would likely get hosed.<br>
<br>
--<br>
<font color="#888888">Patryk Zawadzki<br>
</font><div><div></div><div><br>
-------------------------------------------------------------------------<br>
This SF.Net email is sponsored by the Moblin Your Move Developer&#39;s challenge<br>
Build the coolest Linux based applications with Moblin SDK &amp; win great prizes<br>
Grand prize is a trip for two to an Open Source event anywhere in the world<br>
<a href="http://moblin-contest.org/redirect.php?banner_id=100&amp;url=/" target="_blank">http://moblin-contest.org/redirect.php?banner_id=100&amp;url=/</a><br>
_______________________________________________<br>
Bluez-devel mailing list<br>
<a href="mailto:Bluez-devel@lists.sourceforge.net" target="_blank">Bluez-devel@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>
</div></div></blockquote></div><br></div>

------=_Part_9764_21083190.1222063714357--


--===============1272402424056023227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1272402424056023227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1272402424056023227==--
