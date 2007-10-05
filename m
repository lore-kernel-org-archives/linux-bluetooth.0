Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d5d240eb0710050640p1d9454f3peb935cbcbb6052bf@mail.gmail.com>
Date: Fri, 5 Oct 2007 19:10:32 +0530
From: "rohit puri" <rohitpuri.rohit@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1191589377.10698.168.camel@violet>
MIME-Version: 1.0
References: <d5d240eb0710050552h25d923a0hd1de3c0cec71aeb7@mail.gmail.com>
	<1191589377.10698.168.camel@violet>
Subject: Re: [Bluez-users] DBus error <dbus/dbus-arch-deps.h> is missing
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0236426732=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0236426732==
Content-Type: multipart/alternative;
	boundary="----=_Part_35283_5556504.1191591632882"

------=_Part_35283_5556504.1191591632882
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

Thanks very much for your assistance but still some errors are there
even I have changed the include path to -1

'DBusConnection' undeclared (first use in this function)
dbus2.c:10: error: (Each undeclared identifier is reported only once
dbus2.c:10: error: for each function it appears in.)
dbus2.c:10: error: 'connection' undeclared (first use in this function)
dbus2.c:12: error: 'DBusMessage' undeclared (first use in this function)
dbus2.c:12: error: 'message' undeclared (first use in this function)
dbus2.c:12: error: 'reply' undeclared (first use in this function)
dbus2.c:16: error: 'DBUS_BUS_SYSTEM' undeclared (first use in this function)
dbus2.c:22: error: 'DBUS_TYPE_STRING' undeclared (first use in this
function)
dbus2.c:22: error: 'DBUS_TYPE_INVALID' undeclared (first use in this
function)

Regards,
Rohit
On 10/5/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Rohit,
>
> > whenever I am compiling my program of
> > dbus for interprocess communication .i am getting following error .I
> > have downloaded a latest version of dbus 1.1.2
> >
> >
> > Here I am writing the program and all the errors I am facing
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <dbus-1.0/dbus/dbus.h>
>
> you includes are not complete. You can't use the "dbus-1.0" prefix, you
> have to change the include path (-I).
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_35283_5556504.1191591632882
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel, <br><br>Thanks very much for your assistance but still some errors are there<br>even I have changed the include path to -1<span style="font-size: larger;"></span><br><br>'DBusConnection' undeclared (first use in this function)
<br>dbus2.c:10: error: (Each undeclared identifier is reported only once<br>dbus2.c:10: error: for each function it appears in.)<br>dbus2.c:10: error: 'connection' undeclared (first use in this function)<br>dbus2.c:12: error: 'DBusMessage' undeclared (first use in this function)
<br>dbus2.c:12: error: 'message' undeclared (first use in this function)<br>dbus2.c:12: error: 'reply' undeclared (first use in this function)<br>dbus2.c:16: error: 'DBUS_BUS_SYSTEM' undeclared (first use in this function)
<br>dbus2.c:22: error: 'DBUS_TYPE_STRING' undeclared (first use in this function)<br>dbus2.c:22: error: 'DBUS_TYPE_INVALID' undeclared (first use in this function)<br><br>Regards,<br>Rohit<br><div><span class="gmail_quote">
On 10/5/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Rohit,<br><br>&gt; whenever I am compiling my program of<br>&gt; dbus for interprocess communication .i am getting following error .I<br>&gt; have downloaded a latest version of dbus 1.1.2<br>&gt;<br>&gt;<br>&gt; Here I am writing the program and all the errors I am facing
<br>&gt; #include &lt;stdio.h&gt;<br>&gt; #include &lt;stdlib.h&gt;<br>&gt; #include &lt;dbus-1.0/dbus/dbus.h&gt;<br><br>you includes are not complete. You can&#39;t use the &quot;dbus-1.0&quot; prefix, you<br>have to change the include path (-I).
<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Splunk Inc.<br>Still grepping through log files to find problems?&nbsp;&nbsp;Stop.
<br>Now Search log events and configuration files using AJAX and a browser.<br>Download your FREE copy of Splunk now &gt;&gt; <a href="http://get.splunk.com/">http://get.splunk.com/</a><br>_______________________________________________
<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br></blockquote></div><br>

------=_Part_35283_5556504.1191591632882--


--===============0236426732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0236426732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0236426732==--
