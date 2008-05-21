Return-Path: <cyrus@holtmann.org>
Message-ID: <4328a52e0805210809q2241117fx5d71a1f9bfb70b5@mail.gmail.com>
Date: Thu, 22 May 2008 01:09:17 +1000
From: "Artem Skvira" <artem.skvira@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1211380409.13248.65.camel@californication>
MIME-Version: 1.0
References: <4328a52e0805210458w1438f361ub1eb28976e4a3efa@mail.gmail.com>
	<1211380409.13248.65.camel@californication>
Subject: Re: [Bluez-users] Bluetooth-properties "Out of memory"
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0690849494=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0690849494==
Content-Type: multipart/alternative;
	boundary="----=_Part_2783_6035002.1211382558246"

------=_Part_2783_6035002.1211382558246
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

Thanks for your reply. I tried to download latest bluez from the website and
build it,
but it gives me an error message (when ./configure):

gconf >= 2.16 is required

I do have gconf2 installed though.

Cheers

On Thu, May 22, 2008 at 12:33 AM, Marcel Holtmann <marcel@holtmann.org>
wrote:

> Hi Artem,
>
> > I'm having issues with bluetooth-properties (the one which is in
> > Ubuntu 8.04)
> > When I ran bleutooth-config and try to add a device it crashes
> > displaying this message:
> >
> > "process 10105: arguments to dbus_message_new_method_call() were
> > incorrect, assertion "_dbus_check_is_valid_path (path)" failed in file
> > dbus-message.c line 1074.
> > This is normally a bug in some application using the D-Bus library.
> >
> > ** ERROR **: Out of memory
> > aborting...
> > Aborted"
>
> this really doesn't help me. Can you try to use the latest bluez-gnome
> and see if that issues still exists.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_2783_6035002.1211382558246
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,<br><br>Thanks for your reply. I tried to download latest bluez from the website and build it,<br>but it gives me an error message (when ./configure):<br><br>
			
				gconf &gt;= 2.16 is required<br><br>I do have gconf2 installed though.<br><br>Cheers<br><br><div class="gmail_quote">On Thu, May 22, 2008 at 12:33 AM, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Artem,<br>
<div class="Ih2E3d"><br>
&gt; I&#39;m having issues with bluetooth-properties (the one which is in<br>
&gt; Ubuntu 8.04)<br>
&gt; When I ran bleutooth-config and try to add a device it crashes<br>
&gt; displaying this message:<br>
&gt;<br>
&gt; &quot;process 10105: arguments to dbus_message_new_method_call() were<br>
&gt; incorrect, assertion &quot;_dbus_check_is_valid_path (path)&quot; failed in file<br>
&gt; dbus-message.c line 1074.<br>
&gt; This is normally a bug in some application using the D-Bus library.<br>
&gt;<br>
&gt; ** ERROR **: Out of memory<br>
&gt; aborting...<br>
&gt; Aborted&quot;<br>
<br>
</div>this really doesn&#39;t help me. Can you try to use the latest bluez-gnome<br>
and see if that issues still exists.<br>
<br>
Regards<br>
<br>
Marcel<br>
<br>
<br>
<br>
-------------------------------------------------------------------------<br>
This SF.net email is sponsored by: Microsoft<br>
Defy all challenges. Microsoft(R) Visual Studio 2008.<br>
<a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>
_______________________________________________<br>
Bluez-users mailing list<br>
<a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
</blockquote></div><br>

------=_Part_2783_6035002.1211382558246--


--===============0690849494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0690849494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0690849494==--
