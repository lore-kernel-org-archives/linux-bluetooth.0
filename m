Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <8de6c3e20708240759ya2e1619yfdcf55413a5d3d07@mail.gmail.com>
Date: Fri, 24 Aug 2007 07:59:36 -0700
From: "Jeffrey Cuenco" <jcuenco@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1187957780.15402.152.camel@violet>
MIME-Version: 1.0
References: <8de6c3e20708220924g3a8db7a5paa153e99b5d829ea@mail.gmail.com>
	<1187957780.15402.152.camel@violet>
Subject: Re: [Bluez-users] hci_read_remote_name() simultaneously on multiple
	dongles question
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0932052125=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0932052125==
Content-Type: multipart/alternative;
	boundary="----=_Part_82280_23312594.1187967576385"

------=_Part_82280_23312594.1187967576385
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel,

I understand that you just pointed out that it was a design mistake to be
able to access HCI
functions directly (even I avoided it for a time assuming they were
'locked-out' due to my experience
with other API's, however, the only function that I use is
hci_read_remote_name_with_clock_offset.
so that I can use the clock offsets, and they seemed to lead to a
performance increase in the
reply-time of name replies.  Thanks for the point-out though.  If the other
method works fine then I see
no need to post a patch as what I'm doing is a little bit more custom than
the average usage as
we're using them as part of a research project.

Regarding the dbus-based API:

Are you referring to the hci_remote_name() function instead?  Also, another
problem that I seem
to be encountering has nothing to do with the name resolution, but rather
that after a time the hcid
will start to accumulate CPU time.  Looking at just the TIME and COMMAND
fields of a 'ps aux' call,

0:41 /usr/bin/dbus-daemon --system
2:26 /usr/sbin/hcid

I noticed that whenever my program had super-high CPU time in the
double-digits (e.g. 47:21), that
the hcid usually had high CPU time as well, and it seems the dbus-daemon's
CPU time accumulates
as well.

I was wondering what could cause this to happen?  Sometimes the CPU time
accumulates so fast that after
barely 4 hours of use (we're using it as a 4-dongle scanner with 1 inquiring
and 3 name-querying dongles as
part of a research project at UCSD) the dongles stop doing anything
altogether and freeze, and the only way I
can get them to respond quickly again is to kill my program, and sometimes,
to restart hcid as well. In this case,
dbus-daemon also sometimes accumulates in CPU usage.  The only thing that my
program does HCI-wise
is continuously inquire on 1 dongle (reset list flag set), continuously
name-query on each other dongle from a queue
filled by the results of the 1st (it resets the dongle if a
hci_read_remote_name_with_clock_offset() call fails).

Again thanks in advance, but any suggestions and/or recommendations
regarding this issue would be
much-appreciated


On 8/24/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
>
> feel free to post a patch, but honestly this is broken for quite some
> time now. The kernel and the new D-Bus based API have no problems with
> it and that should be the main way to retrieve remote names. So I am not
> really keen to fix this since direct HCI access for userspace apps was a
> design mistake.
>
>

-- 
-Jeff

------=_Part_82280_23312594.1187967576385
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel,<br><br>I understand that you just pointed out that it was a design mistake to be able to access HCI<br>functions directly (even I avoided it for a time assuming they were &#39;locked-out&#39; due to my experience<br>
with other API&#39;s, however, the only function that I use is hci_read_remote_name_with_clock_offset.<br>so that I can use the clock offsets, and they seemed to lead to a performance increase in the <br>reply-time of name replies.&nbsp; Thanks for the point-out though.&nbsp; If the other method works fine then I see
<br>no need to post a patch as what I&#39;m doing is a little bit more custom than the average usage as<br>we&#39;re using them as part of a research project.<br><br>Regarding the dbus-based API:<br><br>Are you referring to the hci_remote_name() function instead?&nbsp; Also, another problem that I seem
<br>to be encountering has nothing to do with the name resolution, but rather that after a time the hcid<br>will start to accumulate CPU time.&nbsp; Looking at just the TIME and COMMAND fields of a &#39;ps aux&#39; call,<br><br>
0:41 /usr/bin/dbus-daemon --system<br>2:26 /usr/sbin/hcid<br><br>I noticed that whenever my program had super-high CPU time in the double-digits (e.g. 47:21), that<br>the hcid usually had high CPU time as well, and it seems the dbus-daemon&#39;s CPU time accumulates
<br>as well.<br><br>I was wondering what could cause this to happen?&nbsp; Sometimes the CPU time accumulates so fast that after<br>barely 4 hours of use (we&#39;re using it as a 4-dongle scanner with 1 inquiring and 3 name-querying dongles as
<br>part of a research project at UCSD) the dongles stop doing anything altogether and freeze, and the only way I<br>can get them to respond quickly again is to kill my program, and sometimes, to restart hcid as well. In this case,
<br>dbus-daemon also sometimes accumulates in CPU usage.&nbsp; The only thing that my program does HCI-wise <br>is continuously inquire on 1 dongle (reset list flag set), continuously name-query on each other dongle from a queue
<br>filled by the results of the 1st (it resets the dongle if a hci_read_remote_name_with_clock_offset() call fails).<br><br>Again thanks in advance, but any suggestions and/or recommendations regarding this issue would be
<br>much-appreciated<br><br><br><div><span class="gmail_quote">On 8/24/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>feel free to post a patch, but honestly this is broken for quite some<br>time now. The kernel and the new D-Bus based API have no problems with<br>it and that should be the main way to retrieve remote names. So I am not
<br>really keen to fix this since direct HCI access for userspace apps was a<br>design mistake.<br><br></blockquote></div><br clear="all"><br>-- <br>-Jeff

------=_Part_82280_23312594.1187967576385--


--===============0932052125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0932052125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0932052125==--
