Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b5c34db00708200911p3fe51e25jab513e4b1ba876d@mail.gmail.com>
Date: Mon, 20 Aug 2007 21:41:00 +0530
From: "umamahesh yelchuru venkata" <umeshyv@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <79be12f70708200908k48717fd4w2baa95824304733c@mail.gmail.com>
MIME-Version: 1.0
References: <79be12f70708200908k48717fd4w2baa95824304733c@mail.gmail.com>
Subject: Re: [Bluez-users] HCI Daemon Unable to get on D-Bus
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0332412921=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0332412921==
Content-Type: multipart/alternative;
	boundary="----=_Part_132148_12420266.1187626260068"

------=_Part_132148_12420266.1187626260068
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Mr.John, Can i get the compilation procedure for bluez libs and utils

Regards
Umesh


On 8/20/07, John Sample <john.m.sample@gmail.com> wrote:
>
> I've been working on getting Bluez up an running on an embedded platform
> and am having some problems getting hcid to run.  I'm using the 2.6.23kernel, but I've also tested on an old
> 2.6.10 kernel and run into the same problem.  I start D-Bus using
> dbus-daemon-1 --system, and it starts ok without any error messages.  I then
> start hcid, but it immediately exits and I get the following in my syslog:
>
> hcid[1021]: Bluetooth HCI daemon
> hcid[1021]: Can't connect to system message bus: Did not receive a reply.
> Possible causes include: the remote application did not send a reply, the
> message bus security policy blocked the reply, the reply timeout expired, or
> the network connection was broken.
> hcid[1021]: Unable to get on D-Bus
> Do I need to modify bluetooth.conf or system.conf in any way to get the
> security policy to allow the connection?  I saw a similar post a while ago
> on this same topic but I couldn't find a resolution anywhere.
>
> Thanks,
>
> --
> John Sample
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>

------=_Part_132148_12420266.1187626260068
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Mr.John, Can i get the compilation procedure for bluez libs and utils</div>
<div>&nbsp;</div>
<div>Regards</div>
<div>Umesh<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 8/20/07, <b class="gmail_sendername">John Sample</b> &lt;<a href="mailto:john.m.sample@gmail.com">john.m.sample@gmail.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>I&#39;ve been working on getting Bluez up an running on an embedded platform and am having some problems getting hcid to run.&nbsp; I&#39;m using the 2.6.23 kernel, but I&#39;ve also tested on an old 2.6.10 kernel and run into the same problem.&nbsp; I start D-Bus using dbus-daemon-1 --system, and it starts ok without any error messages.&nbsp; I then start hcid, but it immediately exits and I get the following in my syslog: 
</div>
<div>&nbsp;</div>
<div>hcid[1021]: Bluetooth HCI daemon<br>hcid[1021]: Can&#39;t connect to system message bus: Did not receive a reply. Possible causes include: the remote application did not send a reply, the message bus security policy blocked the reply, the reply timeout expired, or the network connection was broken. 
<br>hcid[1021]: Unable to get on D-Bus<br clear="all"></div>
<div>Do I need to modify bluetooth.conf or system.conf in any way to get the security policy to allow the connection?&nbsp; I saw a similar post a while ago on this same topic but I couldn&#39;t find a resolution anywhere.&nbsp;</div>

<div>&nbsp;</div>
<div>Thanks,</div>
<div><br>-- <br>John Sample </div><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Splunk Inc.<br>Still grepping through log files to find problems? &nbsp;Stop.
<br>Now Search log events and configuration files using AJAX and a browser.<br>Download your FREE copy of Splunk now &gt;&gt; &nbsp;<a onclick="return top.js.OpenExtLink(window,event,this)" href="http://get.splunk.com/" target="_blank">
http://get.splunk.com/</a><br>_______________________________________________<br>Bluez-users mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net
</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br><br></blockquote>
</div><br>

------=_Part_132148_12420266.1187626260068--


--===============0332412921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0332412921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0332412921==--
