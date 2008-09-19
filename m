Return-Path: <cyrus@holtmann.org>
Message-ID: <4f9823290809182356x2ad1386bn3de0ebb6ada66789@mail.gmail.com>
Date: Fri, 19 Sep 2008 08:56:05 +0200
From: "Reto Bachmann" <reto.bachmann@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1221757910.6782.17.camel@californication>
MIME-Version: 1.0
References: <4f9823290809180242j56115a6es3a77ffa21eabbf0a@mail.gmail.com>
	<1221757910.6782.17.camel@californication>
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
Content-Type: multipart/mixed; boundary="===============1725842046=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1725842046==
Content-Type: multipart/alternative;
	boundary="----=_Part_14452_13239505.1221807365904"

------=_Part_14452_13239505.1221807365904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,


whatever you do don't poll for a status. You will get a D-Bus signal if
> you are connected or paired etc. Check how bluez-gnome is doing it.


So I need to connect the D-Bus signal RemoteDeviceDisconnected to find out
that I am not connected anymore?

Why shouldn't I poll for a status? Is it just because a signal is sent
either way or is the status i ask for not the true status?

Regards,

Reto


>
>
> Regards
>
> Marcel
>
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

------=_Part_14452_13239505.1221807365904
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><div class="Wj3C7c">Hi Marcel,<br><br><br>
</div><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">whatever you do don&#39;t poll for a status. You will get a D-Bus signal if<br>

you are connected or paired etc. Check how bluez-gnome is doing it.</blockquote><div><br>So I need to connect the D-Bus signal RemoteDeviceDisconnected to find out that I am not connected anymore?<br><br>Why shouldn&#39;t I poll for a status? Is it just because a signal is sent either way or is the status i ask for not the true status?<br>
<br>Regards,<br><br>Reto <br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
Regards<br>
<font color="#888888"><br>
Marcel<br>
</font><div><div></div><div class="Wj3C7c"><br>
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
</div></div></blockquote></div><br></div>

------=_Part_14452_13239505.1221807365904--


--===============1725842046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1725842046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1725842046==--
