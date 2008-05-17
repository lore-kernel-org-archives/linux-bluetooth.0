Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0805171138r278aad56i9d1af3dfea5ca7c0@mail.gmail.com>
Date: Sat, 17 May 2008 20:38:10 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <75FB41F6-49E1-4CEE-8A7F-87DCF21645F5@holtmann.org>
MIME-Version: 1.0
References: <3e9cdced0805170741i202cfe62kef18ca9a0c2e30c@mail.gmail.com>
	<75FB41F6-49E1-4CEE-8A7F-87DCF21645F5@holtmann.org>
Subject: Re: [Bluez-users] using bluez dbus interface exposed from hcid with
	plain c code
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0433697796=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0433697796==
Content-Type: multipart/alternative;
	boundary="----=_Part_3415_24339239.1211049490326"

------=_Part_3415_24339239.1211049490326
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

is there anywhere a HowTo / Tutorial how to use the low-level C API of bluez
through dbus?

I've found a Tutorial for using the low-level C API of dbus here
(unfortunately just a ver basic Tut.)
http://dbus.freedesktop.org/doc/dbus/libdbus-tutorial.html

But I didn't find anything about the characteristics of the Adapter
Interface of bluez (hcid) if its used from low-level API.
E.g. the method names which I have to pass the method
dbus_message_new_method_call() ...

thanks,
Fritz

On Sat, May 17, 2008 at 4:47 PM, Marcel Holtmann <marcel@holtmann.org>
wrote:

> Hi Fritz,
>
> > since I don't have resources for Glib or another abstraction layer
> > on my Embedded Linux I can only use plain C for communication with
> > bluez through dbus.
> > But so far I've only find howto's with GLib or Qt etc.
> > Are there any documents that describe my case (plain c
> > communication) ?
> >
> > For general understanding of the bluez architecture and tools, a
> > statement and a question:
> >
> > hcid is the daemon which exposes different Interfaces through dbus,
> > e.g. the Interface "Adapter".
> > Another Application can access bluez functionalities through dbus by
> > using the Interfaces exposed from hcid. (hopefully also by using
> > plain C).
> >
> > E.g.: You want to develop an application "example-app" which should
> > list available local buetooth devices, remote devices and its
> > services.
> > In this case it is enough to start hcid and use its Interface
> > "Adapter" from "example-app" ?
> >
> > The other tools like, hcitool, hciconfig etc. are not necessary,
> > they are own applications, right.
> > In order to use bluez features from another application (through
> > dbus) the only tool/util needed is hcid?
> > And this is configured by hcid.conf?
>
> if you use bluez-utils-3.31 or any later release, the only thing you
> need is hcid. It will do everything for you. The only exception is if
> your adapter is connected via an UART and using hci_uart driver, then
> you also need hciattach, but that is it.
>
> And of course you can write a client application using D-Bus low-level
> (libdbus) only. It is a little bit more work than using high level
> languages, but it is possible. I still have plans to provide a D-Bus
> only replacement for hciconfig, hcitool etc.
>
> Regards
>
> Marcel
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



-- 
Regards,
--Codefritz

------=_Part_3415_24339239.1211049490326
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,<br><br>is there anywhere a HowTo / Tutorial how to use the low-level C API of bluez through dbus?<br><br>I&#39;ve found a Tutorial for using the low-level C API of dbus here (unfortunately just a ver basic Tut.)<br>
<a href="http://dbus.freedesktop.org/doc/dbus/libdbus-tutorial.html" target="_blank">http://dbus.freedesktop.org/doc/dbus/libdbus-tutorial.html</a><br>
<br>But I didn&#39;t find anything about the characteristics of the Adapter Interface of bluez (hcid) if its used from low-level API.<br>E.g. the method names which I have to pass the method dbus_message_new_method_call() ...<br>
<br>thanks,<br>Fritz<br><br><div class="gmail_quote">On Sat, May 17, 2008 at 4:47 PM, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org" target="_blank">marcel@holtmann.org</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Fritz,<br>
<div><div></div><div><br>
&gt; since I don&#39;t have resources for Glib or another abstraction layer<br>
&gt; on my Embedded Linux I can only use plain C for communication with<br>
&gt; bluez through dbus.<br>
&gt; But so far I&#39;ve only find howto&#39;s with GLib or Qt etc.<br>
&gt; Are there any documents that describe my case (plain c<br>
&gt; communication) ?<br>
&gt;<br>
&gt; For general understanding of the bluez architecture and tools, a<br>
&gt; statement and a question:<br>
&gt;<br>
&gt; hcid is the daemon which exposes different Interfaces through dbus,<br>
&gt; e.g. the Interface &quot;Adapter&quot;.<br>
&gt; Another Application can access bluez functionalities through dbus by<br>
&gt; using the Interfaces exposed from hcid. (hopefully also by using<br>
&gt; plain C).<br>
&gt;<br>
&gt; E.g.: You want to develop an application &quot;example-app&quot; which should<br>
&gt; list available local buetooth devices, remote devices and its<br>
&gt; services.<br>
&gt; In this case it is enough to start hcid and use its Interface<br>
&gt; &quot;Adapter&quot; from &quot;example-app&quot; ?<br>
&gt;<br>
&gt; The other tools like, hcitool, hciconfig etc. are not necessary,<br>
&gt; they are own applications, right.<br>
&gt; In order to use bluez features from another application (through<br>
&gt; dbus) the only tool/util needed is hcid?<br>
&gt; And this is configured by hcid.conf?<br>
<br>
</div></div>if you use bluez-utils-3.31 or any later release, the only thing you<br>
need is hcid. It will do everything for you. The only exception is if<br>
your adapter is connected via an UART and using hci_uart driver, then<br>
you also need hciattach, but that is it.<br>
<br>
And of course you can write a client application using D-Bus low-level<br>
(libdbus) only. It is a little bit more work than using high level<br>
languages, but it is possible. I still have plans to provide a D-Bus<br>
only replacement for hciconfig, hcitool etc.<br>
<br>
Regards<br>
<br>
Marcel<br>
<br>
<br>
-------------------------------------------------------------------------<br>
This SF.net email is sponsored by: Microsoft<br>
Defy all challenges. Microsoft(R) Visual Studio 2008.<br>
<a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>
_______________________________________________<br>
Bluez-users mailing list<br>
<a href="mailto:Bluez-users@lists.sourceforge.net" target="_blank">Bluez-users@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
</blockquote></div><br><br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br>

------=_Part_3415_24339239.1211049490326--


--===============0433697796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0433697796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0433697796==--
