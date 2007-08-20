Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <79be12f70708200908k48717fd4w2baa95824304733c@mail.gmail.com>
Date: Mon, 20 Aug 2007 10:08:33 -0600
From: "John Sample" <john.m.sample@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] HCI Daemon Unable to get on D-Bus
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1224172864=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1224172864==
Content-Type: multipart/alternative;
	boundary="----=_Part_75330_32159728.1187626113574"

------=_Part_75330_32159728.1187626113574
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've been working on getting Bluez up an running on an embedded platform and
am having some problems getting hcid to run.  I'm using the 2.6.23 kernel,
but I've also tested on an old 2.6.10 kernel and run into the same problem.
I start D-Bus using dbus-daemon-1 --system, and it starts ok without any
error messages.  I then start hcid, but it immediately exits and I get the
following in my syslog:

hcid[1021]: Bluetooth HCI daemon
hcid[1021]: Can't connect to system message bus: Did not receive a reply.
Possible causes include: the remote application did not send a reply, the
message bus security policy blocked the reply, the reply timeout expired, or
the network connection was broken.
hcid[1021]: Unable to get on D-Bus
Do I need to modify bluetooth.conf or system.conf in any way to get the
security policy to allow the connection?  I saw a similar post a while ago
on this same topic but I couldn't find a resolution anywhere.

Thanks,

-- 
John Sample

------=_Part_75330_32159728.1187626113574
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I&#39;ve been working on getting Bluez up an running on an embedded platform and am having some problems getting hcid to run.&nbsp; I&#39;m using the 2.6.23 kernel, but I&#39;ve also tested on an old 2.6.10 kernel and run into the same problem.&nbsp; I start D-Bus using dbus-daemon-1 --system, and it starts ok without any error messages.&nbsp; I then start hcid, but it immediately exits and I get the following in my syslog:
</div>
<div>&nbsp;</div>
<div>hcid[1021]: Bluetooth HCI daemon<br>hcid[1021]: Can&#39;t connect to system message bus: Did not receive a reply. Possible causes include: the remote application did not send a reply, the message bus security policy blocked the reply, the reply timeout expired, or the network connection was broken.
<br>hcid[1021]: Unable to get on D-Bus<br clear="all"></div>
<div>Do I need to modify bluetooth.conf or system.conf in any way to get the security policy to allow the connection?&nbsp; I saw a similar post a while ago on this same topic but I couldn&#39;t find a resolution anywhere.&nbsp;</div>

<div>&nbsp;</div>
<div>Thanks,</div>
<div><br>-- <br>John Sample </div>

------=_Part_75330_32159728.1187626113574--


--===============1224172864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1224172864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1224172864==--
