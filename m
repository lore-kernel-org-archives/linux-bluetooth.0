Return-Path: <cyrus@holtmann.org>
Message-ID: <aed4d4a30805041328t712b2296ja78d1e8352354fd4@mail.gmail.com>
Date: Sun, 4 May 2008 23:28:34 +0300
From: "Panayiotis Modestou" <panicosm@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20080503T183003-377@post.gmane.org>
MIME-Version: 1.0
References: <loom.20080503T183003-377@post.gmane.org>
Subject: Re: [Bluez-users] Restart input service
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1443066773=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1443066773==
Content-Type: multipart/alternative;
	boundary="----=_Part_12297_4528719.1209932914473"

------=_Part_12297_4528719.1209932914473
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, I think this is what you are looking for

~$ dbus-send --system --type=method_call --print-reply  --dest=org.bluez
/org/bluez/service_input org.bluez.Service.Stop
method return sender=:1.10 -> dest=:1.84 reply_serial=2

and
~$ dbus-send --system --type=method_call --print-reply  --dest=org.bluez
/org/bluez/service_input org.bluez.Service.Start
method return sender=:1.10 -> dest=:1.87 reply_serial=2

Regards
Panicos

On Sat, May 3, 2008 at 9:35 PM, Dick <dm@chello.nl> wrote:

> Hi,
>
> I still have trouble reconnecting my Logitech Dinovo input devices after
> some
> time when they are disconnected (to safe some power?).
>
> Most of the time this can be corrected by disabling (Status stopped)
> "Input
> service" from the bluetooth-properties application and reenable "Input
> service"
> (Status running).
>
> How can I do this by calling DBUS commands? I'd like to have a script or
> shortcut around to save some time...
>
> Thanks in advance,
> Dick
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by the 2008 JavaOne(SM) Conference
> Don't miss this year's exciting event. There's still time to save $100.
> Use priority code J8TL2D2.
>
> http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_12297_4528719.1209932914473
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, I think this is what you are looking for<br><br>~$ dbus-send --system --type=method_call --print-reply&nbsp; --dest=org.bluez /org/bluez/service_input org.bluez.Service.Stop<br>method return sender=:1.10 -&gt; dest=:1.84 reply_serial=2<br>
<br>and <br>~$ dbus-send --system --type=method_call --print-reply&nbsp; --dest=org.bluez /org/bluez/service_input org.bluez.Service.Start<br>method return sender=:1.10 -&gt; dest=:1.87 reply_serial=2<br><br>Regards<br>Panicos<br>
<br><div class="gmail_quote">On Sat, May 3, 2008 at 9:35 PM, Dick &lt;<a href="mailto:dm@chello.nl">dm@chello.nl</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br>
<br>
I still have trouble reconnecting my Logitech Dinovo input devices after some<br>
time when they are disconnected (to safe some power?).<br>
<br>
Most of the time this can be corrected by disabling (Status stopped) &quot;Input<br>
service&quot; from the bluetooth-properties application and reenable &quot;Input service&quot;<br>
(Status running).<br>
<br>
How can I do this by calling DBUS commands? I&#39;d like to have a script or<br>
shortcut around to save some time...<br>
<br>
Thanks in advance,<br>
Dick<br>
<br>
<br>
-------------------------------------------------------------------------<br>
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference<br>
Don&#39;t miss this year&#39;s exciting event. There&#39;s still time to save $100.<br>
Use priority code J8TL2D2.<br>
<a href="http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone" target="_blank">http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone</a><br>
_______________________________________________<br>
Bluez-users mailing list<br>
<a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
</blockquote></div><br>

------=_Part_12297_4528719.1209932914473--


--===============1443066773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============1443066773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1443066773==--
