Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46AA3BA3.2080102@gmail.com>
Date: Fri, 27 Jul 2007 11:38:27 -0700
From: Xamindar <junkxamindar@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <d5920d1e0707270800g1ca7d171jae107615f0c19cd1@mail.gmail.com>
In-Reply-To: <d5920d1e0707270800g1ca7d171jae107615f0c19cd1@mail.gmail.com>
Subject: Re: [Bluez-users] no bluetooth devices is detected
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1451157085=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1451157085==
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Try running "hciconfig hci0 reset" and see if you can scan after that.&nbsp;
My dell bluetooth started doing exactly what you describe when I
upgraded my bluez to a more recent version.&nbsp; Too bad, I have to have
this workaround in my local startup script and also in my resume from
hibernation script.&nbsp; But lots of people are starting to have this
problem so hopefully they will fix it soon.<br>
<br>
Hamid MENOUAR wrote:
<blockquote
 cite="mid:d5920d1e0707270800g1ca7d171jae107615f0c19cd1@mail.gmail.com"
 type="cite">Dear bluez users,<br>
  <br>
In order to make my laptop (OS: Fedora Core 2) communicate with some
bluetooth device through an ANYCOM Bluetooth USB Adapter, I have
installed the Bluez packages (bluez-libs bluez-libs bluez-utils
bluez-hcidump bluez-utils-cups).<br>
  <br>
But, when trying to detect nearby active bluetooth devices, using
"hcitool scan" non of the devices are detected, wheras the same
configuration works very well with windows.<br>
  <br>
so, that's what I get on my terminal:<br>
  <br>
  <div style="margin-left: 40px;">&gt;[root@localhost root]# hciconfig<br>
&gt;hci0:&nbsp;&nbsp; Type: USB<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:16:38:CA:56:A8 ACL MTU: 1017:8&nbsp; SCO MTU: 64:1<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:93 acl:0 sco:0 events:12 errors:0<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:296 acl:0 sco:0 commands:12 errors:0<br>
&gt;&nbsp;<br>
&gt;[root@localhost root]# hcitool scan<br>
&gt;Scanning ...<br>
&gt;Inquiry failed: Connection timed out<br>
  </div>
  <br>
One more thing is that, when loading the bluez module it says that the
module is not found<br>
  <br>
  <div style="margin-left: 40px;">&gt;[root@localhost root]# modprobe
bluez<br>
  </div>
  <div style="margin-left: 40px;">&gt;FATAL: Module bluez not found.<br>
  </div>
  <br>
  <br>
It would be very much helpful if someone knows how to solve the problem.<br>
  <br>
Thanks so much in advance,<br>
Menouar<br>
  <br>
  <pre wrap="">
<hr size="4" width="90%">
-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now &gt;&gt;  <a class="moz-txt-link-freetext" href="http://get.splunk.com/">http://get.splunk.com/</a></pre>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Bluez-users mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a>
  </pre>
</blockquote>
<br>
</body>
</html>


--===============1451157085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1451157085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1451157085==--
