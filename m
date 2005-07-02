Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <c93f2a29050702074045ad46dd@mail.gmail.com>
From: Embedded System <embed.sys@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1346_15761985.1120315257914"
Subject: [Bluez-users] HCID problem? (Help)
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
Date: Sat, 2 Jul 2005 14:40:57 +0000

------=_Part_1346_15761985.1120315257914
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi, all

HCI command do not complete after "inquiure request" completed succesfully.

I run "hcitool inq" & "hcidum", the output is as following:

HCIDump - HCI packet analyzer ver 1.16
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
33 8B 9E 08 00
> HCI Event: Command Status (0x0f) plen 4
00 01 01 04
> HCI Event: Inquiry Result (0x02) plen 15
01 91 DC AC EE 02 00 01 00 00 04 22 50 C5 57
> HCI Event: Inquiry Complete (0x01) plen 1
00

(based on the packet dump, the inquery is succesful, and hcid should=20
complete), but hcitool output is:
Inquiring ...
Inquiry failed.: Connection timed out

Is it a HCID problem? How can I fix it? I thought it will also cause packet=
=20
lost & program hang.

Regards,
Andy

------=_Part_1346_15761985.1120315257914
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi, all<br>
<br>
HCI command do not complete after &quot;inquiure request&quot; completed su=
ccesfully.<br>
<br>
I run &quot;hcitool inq&quot; &amp; &quot;hcidum&quot;, the output is as fo=
llowing:<br>
<br>
HCIDump - HCI packet analyzer ver 1.16<br>
device: hci0 snap_len: 1028 filter: 0xffffffff<br>
&lt; HCI Command: Inquiry (0x01|0x0001) plen 5<br>
&nbsp; 33 8B 9E 08 00<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 00 01 01 04<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp; 01 91 DC AC EE 02 00 01 00 00 04 22 50 C5 57<br>
&gt; HCI Event: Inquiry Complete (0x01) plen 1<br>
&nbsp; 00<br>
<br>
(based on the packet dump, the inquery is succesful, and hcid should comple=
te), but hcitool output is:<br>
Inquiring ...<br>

Inquiry failed.: Connection timed out<br>
<br>
Is it a HCID problem? How can I fix it? I thought it will also cause packet=
 lost &amp; program hang.<br>
<br>
Regards,<br>
Andy<br>

------=_Part_1346_15761985.1120315257914--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
