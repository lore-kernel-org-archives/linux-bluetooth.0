Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d5920d1e0707270800g1ca7d171jae107615f0c19cd1@mail.gmail.com>
Date: Fri, 27 Jul 2007 17:00:35 +0200
From: "Hamid MENOUAR" <menouar@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] no bluetooth devices is detected
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0213390880=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0213390880==
Content-Type: multipart/alternative;
	boundary="----=_Part_5376_10400137.1185548435845"

------=_Part_5376_10400137.1185548435845
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear bluez users,

In order to make my laptop (OS: Fedora Core 2) communicate with some
bluetooth device through an ANYCOM Bluetooth USB Adapter, I have installed
the Bluez packages (bluez-libs bluez-libs bluez-utils bluez-hcidump
bluez-utils-cups).

But, when trying to detect nearby active bluetooth devices, using "hcitool
scan" non of the devices are detected, wheras the same configuration works
very well with windows.

so, that's what I get on my terminal:

>[root@localhost root]# hciconfig
>hci0:   Type: USB
>        BD Address: 00:16:38:CA:56:A8 ACL MTU: 1017:8  SCO MTU: 64:1
>        UP RUNNING
>        RX bytes:93 acl:0 sco:0 events:12 errors:0
>        TX bytes:296 acl:0 sco:0 commands:12 errors:0
>
>[root@localhost root]# hcitool scan
>Scanning ...
>Inquiry failed: Connection timed out

One more thing is that, when loading the bluez module it says that the
module is not found

>[root@localhost root]# modprobe bluez
 >FATAL: Module bluez not found.


It would be very much helpful if someone knows how to solve the problem.

Thanks so much in advance,
Menouar

------=_Part_5376_10400137.1185548435845
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear bluez users,<br>
<br>
In order to make my laptop (OS: Fedora Core 2) communicate with some
bluetooth device through an ANYCOM Bluetooth USB Adapter, I have
installed the Bluez packages (bluez-libs bluez-libs bluez-utils
bluez-hcidump bluez-utils-cups).<br>
<br>
But, when trying to detect nearby active bluetooth devices, using
&quot;hcitool scan&quot; non of the devices are detected, wheras the same
configuration works very well with windows.<br>
<br>
so, that&#39;s what I get on my terminal:<br>
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
One more thing is that, when loading the bluez module it says that the module is not found<br>
<br>
<div style="margin-left: 40px;">&gt;[root@localhost root]# modprobe bluez<br>
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

------=_Part_5376_10400137.1185548435845--


--===============0213390880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0213390880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0213390880==--
