Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <45bf5ff80510140328me0ad427k4c1a8269cc97dccb@mail.gmail.com>
From: Artur Almeida <fidalgo.a@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_20956_15281870.1129285738529"
Subject: [Bluez-devel] =?ISO-8859-1?Q?Cant=B4t_connect_RFCOMM_socket:_Device_or_resource_busy?=
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 14 Oct 2005 11:28:58 +0100

------=_Part_20956_15281870.1129285738529
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dear All

 Im having this problem of getting this error message when i try to run the
following command:

rfcomm -i hci1 connect 1 00:13:FD:BB:22:3F 9

Can't connect RFCOMM socket: Device or resource busy

This happens everytime im downloading a file, i stop the bluetooth on my
cell phone then i reconnect and try to send the same file. Is there a
solution to handle this problem without reseting the hci1 ?

Even if i try to restart the bluetooth daemon the error persists, only
reseting my machine im able to connect again using the rfcomm command. Im
using debian sarge with the bluez packages.

 The output from from hcidump when i try to perform this operation is:

 HCI sniffer - Bluetooth packet analyzer ver 1.17
device: hci1 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
0000: 3f 22 bb fd 13 00 18 cc 02 00 00 00 01 ?"...........
> HCI Event: Command Status (0x0f) plen 4
Create Connection (0x01|0x0005) status 0x0c ncmd 1
Error: Command Disallowed
< HCI Command: Create Connection (0x01|0x0005) plen 13
0000: 3f 22 bb fd 13 00 18 cc 02 00 00 00 01 ?"...........
> HCI Event: Command Status (0x0f) plen 4
Create Connection (0x01|0x0005) status 0x0c ncmd 1
Error: Command Disallowed
< HCI Command: Create Connection (0x01|0x0005) plen 13
0000: 3f 22 bb fd 13 00 18 cc 02 00 00 00 01 ?"...........
> HCI Event: Command Status (0x0f) plen 4
Create Connection (0x01|0x0005) status 0x0c ncmd 1
Error: Command Disallowed
< HCI Command: Create Connection (0x01|0x0005) plen 13
0000: 3f 22 bb fd 13 00 18 cc 02 00 00 00 01 ?"...........
> HCI Event: Command Status (0x0f) plen 4
Create Connection (0x01|0x0005) status 0x0c ncmd 1
Error: Command Disallowed

Can anyone help?

Regards

------=_Part_20956_15281870.1129285738529
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<p>Dear All</p>
<p>&nbsp;</p>
<p>Im having this problem of getting this error message when i try to run t=
he following command: </p>
<dir><font size=3D"2">
<p>rfcomm -i hci1 connect 1 00:13:FD:BB:22:3F 9</p></font></dir>
<p>Can't connect RFCOMM socket: Device or resource busy</p>
<p>This happens everytime im downloading a file, i stop the bluetooth on my=
 cell phone then i reconnect and try to send the same file. Is there a solu=
tion to handle this problem without reseting the hci1 ?</p>
<p>Even if i try to restart the bluetooth daemon the error persists, only r=
eseting my machine im able to connect again using the rfcomm command. Im us=
ing debian sarge with the bluez packages. </p>
<p>&nbsp;</p>
<p>The output from from hcidump when i try to perform this operation is:</p=
>
<p>&nbsp;</p>
<p>HCI sniffer - Bluetooth packet analyzer ver 1.17<br>device: hci1 snap_le=
n: 1028 filter: 0xffffffff<br>&lt; HCI Command: Create Connection (0x01|0x0=
005) plen 13<br>0000: 3f 22 bb fd 13 00 18 cc 02 00 00 00 01 ?&quot;.......=
....=20
<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>Create Connection (0x01=
|0x0005) status 0x0c ncmd 1<br>Error: Command Disallowed<br>&lt; HCI Comman=
d: Create Connection (0x01|0x0005) plen 13<br>0000: 3f 22 bb fd 13 00 18 cc=
 02 00 00 00 01 ?&quot;...........=20
<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>Create Connection (0x01=
|0x0005) status 0x0c ncmd 1<br>Error: Command Disallowed<br>&lt; HCI Comman=
d: Create Connection (0x01|0x0005) plen 13<br>0000: 3f 22 bb fd 13 00 18 cc=
 02 00 00 00 01 ?&quot;...........=20
<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>Create Connection (0x01=
|0x0005) status 0x0c ncmd 1<br>Error: Command Disallowed<br>&lt; HCI Comman=
d: Create Connection (0x01|0x0005) plen 13<br>0000: 3f 22 bb fd 13 00 18 cc=
 02 00 00 00 01 ?&quot;...........=20
<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>Create Connection (0x01=
|0x0005) status 0x0c ncmd 1<br>Error: Command Disallowed</p>
<p>Can anyone help?</p>
<p>Regards</p>

------=_Part_20956_15281870.1129285738529--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
