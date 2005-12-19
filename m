Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <9c68c0a70512182353u6028f3abw@mail.gmail.com>
From: liang liping <lianglip@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1073_15613135.1134978820753"
Subject: [Bluez-users] encrypt problem
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 19 Dec 2005 15:53:40 +0800

------=_Part_1073_15613135.1134978820753
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.
I install bluez on my arm board(super2410). And I want my Nokia 6670 to
connect to my arm-linux with a bluetooth adaptor. Since the gnubox on
Nokia 6670 need encrypt option, my command should have encrypt option:

"dund --encrypt --listen -n"

but there is an error:

"Failed to set link mode. Protocol not available(92)."

If I do not use the "--encrypt" option it works well. The kernel I used is
2.4.18 and
I have used the patch downloaded on www.bluez.org.
Here is my kernel option:

<*> Bluetooth subsystem support
<*> L2CAP protocol support
<  > SCO links support
<*> RFCOMM protocol support
 [*]       RFCOMM TTY support
<*> BNEP protocol support
 [*]       Multicast filter support
 [*]       Protocol filter support
<  > HIDP protocol support


<*> HCI USB driver
 [  ]        SCO (voice) support
<*> HCI UART driver
 [*]         UART (H4) protocol support
 [*]         BCSP protocol support
 [  ]         TRansmit CRC with every BCSP packet
<*> HCI BlueFRITZ! USB driver
<*> HCI VHCI (Virtual HCI device) driver

How can I make the --encrypt option workable?
Thank you!!

------=_Part_1073_15613135.1134978820753
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.<br>
I install bluez on my arm board(super2410). And I want my Nokia 6670 to<br>
connect to my arm-linux with a bluetooth adaptor. Since the gnubox on<br>
Nokia 6670 need encrypt option, my command should have encrypt option:<br>
<br>
&quot;dund --encrypt --listen -n&quot;<br>
<br>
but there is an error:<br>
<br>
&quot;Failed to set link mode. Protocol not available(92).&quot;<br>
<br>
If I do not use the &quot;--encrypt&quot; option it works well. The kernel =
I used is 2.4.18 and <br>
I have used the patch downloaded on <a href=3D"http://www.bluez.org">www.bl=
uez.org</a>.<br>
Here is my kernel option:<br>
<br>
&lt;*&gt; Bluetooth subsystem support<br>
&lt;*&gt; L2CAP protocol support<br>
&lt;&nbsp; &gt; SCO links support<br>
&lt;*&gt; RFCOMM protocol support<br>
&nbsp;[*]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM TTY support<br>
&lt;*&gt; BNEP protocol support<br>
&nbsp;[*]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Multicast filter support<br>
&nbsp;[*]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Protocol filter support<br>
&lt;&nbsp; &gt; HIDP protocol support<br>
<br>
<br>
&lt;*&gt; HCI USB driver<br>
&nbsp;[&nbsp; ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCO (voice) suppo=
rt<br>
&lt;*&gt; HCI UART driver<br>
&nbsp;[*]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UART (H4) protoco=
l support<br>
&nbsp;[*]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BCSP protocol sup=
port<br>
&nbsp;[&nbsp; ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TRansmit CR=
C with every BCSP packet<br>
&lt;*&gt; HCI BlueFRITZ! USB driver<br>
&lt;*&gt; HCI VHCI (Virtual HCI device) driver<br>
<br>
How can I make the --encrypt option workable?<br>
Thank you!!<br>

------=_Part_1073_15613135.1134978820753--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
