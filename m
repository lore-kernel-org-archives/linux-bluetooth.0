Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0708010345u73c7482esff100f76b20646fc@mail.gmail.com>
Date: Wed, 1 Aug 2007 16:15:07 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <d5920d1e0708010151h1610b190vb7618b71686cba05@mail.gmail.com>
MIME-Version: 1.0
References: <d5920d1e0708010151h1610b190vb7618b71686cba05@mail.gmail.com>
Subject: Re: [Bluez-users] Module bluez not found
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2097893771=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2097893771==
Content-Type: multipart/alternative;
	boundary="----=_Part_40460_21985871.1185965107471"

------=_Part_40460_21985871.1185965107471
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

u should try
modprobe hci_usb
modprobe rfcomm

then run
hciconfig hci0 up (only one dongle attached)

then
hcitool scan (if near by devices are scanned succesfully then part of
bluetooth system is working fine)

now for sending and recieving files you should try searching in mail
archive.....

regards
siddhant


On 8/1/07, Hamid MENOUAR <menouar@gmail.com> wrote:
>
> Dear all,
>
> In order to use Bluez to connect some bluetooth device on my computer,
> I have installed on my Linux FC2 the four following packages
> (bluez-libs, bluez-utils, bluez-firmware, bluez-hcidump).
>
> And, when trying to load the Bluez module manually by doing "modprobe
> bluez" it says "FATAL: Module bluez not found."
>
> Could anyone help me to explain and solve this?
>
> Thank you in advance,
> Menouar
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

------=_Part_40460_21985871.1185965107471
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

u should try <br>modprobe hci_usb<br>modprobe rfcomm<br><br>then run<br>hciconfig hci0 up (only one dongle attached)<br><br>then <br>hcitool scan (if near by devices are scanned succesfully then part of bluetooth system is working fine)
<br><br>now for sending and recieving files you should try searching in mail archive.....<br><br>regards<br>siddhant<br>&nbsp;<br><br><div><span class="gmail_quote">On 8/1/07, <b class="gmail_sendername">Hamid MENOUAR</b> &lt;
<a href="mailto:menouar@gmail.com">menouar@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Dear all,<br><br>In order to use Bluez to connect some bluetooth device on my computer,
<br>I have installed on my Linux FC2 the four following packages<br>(bluez-libs, bluez-utils, bluez-firmware, bluez-hcidump).<br><br>And, when trying to load the Bluez module manually by doing &quot;modprobe<br>bluez&quot; it says &quot;FATAL: Module bluez not found.&quot;
<br><br>Could anyone help me to explain and solve this?<br><br>Thank you in advance,<br>Menouar<br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Splunk Inc.
<br>Still grepping through log files to find problems?&nbsp;&nbsp;Stop.<br>Now Search log events and configuration files using AJAX and a browser.<br>Download your FREE copy of Splunk now &gt;&gt;&nbsp;&nbsp;<a href="http://get.splunk.com/">
http://get.splunk.com/</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_40460_21985871.1185965107471--


--===============2097893771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============2097893771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2097893771==--
