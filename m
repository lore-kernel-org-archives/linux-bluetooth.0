Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60705092103r60702f19hbbafe4c5534777b4@mail.gmail.com>
Date: Wed, 9 May 2007 21:03:18 -0700
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <7D2A6046-AC66-4992-9875-28101C52FA20@gmail.com>
MIME-Version: 1.0
References: <4641DA61.8040709@tao-group.com>
	<1178722356.8628.96.camel@aeonflux.holtmann.net>
	<4641E662.6080303@tao-group.com>
	<1178724426.8628.102.camel@aeonflux.holtmann.net>
	<4641EA96.7070204@tao-group.com>
	<1178726532.8628.107.camel@aeonflux.holtmann.net>
	<be976db60705090927n71d22c0an5116c8a1323ed3a3@mail.gmail.com>
	<7D2A6046-AC66-4992-9875-28101C52FA20@gmail.com>
Subject: Re: [Bluez-users] API documentation?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0454446355=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0454446355==
Content-Type: multipart/alternative;
	boundary="----=_Part_77608_15292257.1178769798534"

------=_Part_77608_15292257.1178769798534
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Johan:

If you have a DBUS client that is working making use of some Bluez-DBUS API,
can I take a look at it as example?

I am using C and just to confirm, I also went to the Python-Bluez binding
making use of the DBUS API.  And I got the same error message.

If it is a config issue, I would like to know what I should be putting into
my dbus.conf and hcid.conf?
Thanks


On 5/9/07, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>
> Hi Mark,
>
> On May 9, 2007, at 19:27, Mark S. Townsley wrote:
> > I am trying to follow your advice and use the D-BUS API instead of
> > the low-level HCI API.
> > However, no matter which D-BUS method I issued, I got back this error:
> >
> >    The name org.bluez was not provided by any .service files
> >
> > I tried to search online but could not find any answer.  I searched
> > the archive, nothing comes up.   Can you provide your expertise on
> > this one?  What are these .service files?  How can I make one for
> > org.bluez?
>
> I'm kind of surprised you haven't figured this out already. All you
> need is a running hcid process, and you need to use the system bus
> (it's not clear from your description whether you used the session or
> the system bus). hcid provides the D-Bus well known name org.bluez on
> the system bus. Because your D-Bus client doesn't find org.bluez
> (i.e. hcid is not running) it tries to see if it is activatable but
> does not find any .service file which would describe how to activate
> it (because hcid is not meant to be activated by D-Bus, but should
> e.g. be run from an init script).
>
> Johan
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_77608_15292257.1178769798534
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Johan:<br><br>If you have a DBUS client that is working making use of some Bluez-DBUS API, can I take a look at it as example?<br><br>I am using C and just to confirm, I also went to the Python-Bluez binding making use of the DBUS API.&nbsp; And I got the same error message.
<br><br>If it is a config issue, I would like to know what I should be putting into my dbus.conf and hcid.conf?&nbsp; <br>Thanks<br><br><br><div><span class="gmail_quote">On 5/9/07, <b class="gmail_sendername">Johan Hedberg</b>
 &lt;<a href="mailto:johan.hedberg@gmail.com">johan.hedberg@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Mark,
<br><br>On May 9, 2007, at 19:27, Mark S. Townsley wrote:<br>&gt; I am trying to follow your advice and use the D-BUS API instead of<br>&gt; the low-level HCI API.<br>&gt; However, no matter which D-BUS method I issued, I got back this error:
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;The name org.bluez was not provided by any .service files<br>&gt;<br>&gt; I tried to search online but could not find any answer.&nbsp;&nbsp;I searched<br>&gt; the archive, nothing comes up.&nbsp;&nbsp; Can you provide your expertise on
<br>&gt; this one?&nbsp;&nbsp;What are these .service files?&nbsp;&nbsp;How can I make one for<br>&gt; org.bluez?<br><br>I&#39;m kind of surprised you haven&#39;t figured this out already. All you<br>need is a running hcid process, and you need to use the system bus
<br>(it&#39;s not clear from your description whether you used the session or<br>the system bus). hcid provides the D-Bus well known name org.bluez on<br>the system bus. Because your D-Bus client doesn&#39;t find org.bluez
<br>(i.e. hcid is not running) it tries to see if it is activatable but<br>does not find any .service file which would describe how to activate<br>it (because hcid is not meant to be activated by D-Bus, but should<br>e.g. be run from an init script).
<br><br>Johan<br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.
<br><a href="http://sourceforge.net/powerbar/db2/">http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">
Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_77608_15292257.1178769798534--


--===============0454446355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0454446355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0454446355==--
