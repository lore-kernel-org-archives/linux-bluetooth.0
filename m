Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <5149509b0709030628o477273f5yf2c689ed356e2224@mail.gmail.com>
Date: Mon, 3 Sep 2007 15:28:18 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Baguet?=" <sebastien.baguet@tele2.fr>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] [BUG] crash in pcm_bluetooth.c
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1804822187=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1804822187==
Content-Type: multipart/alternative;
	boundary="----=_Part_9266_9604638.1188826098162"

------=_Part_9266_9604638.1188826098162
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi All,

I have a crash in pcm_bluetooth.c when i try a connection.

Here are the details :
I power on my bt headset (Sony Ericsson HBH970) - The headset opens
the connection...
Then i try to play an audio file -> SEG FAULT

$ gdb --args aplay -Dplug:bluetooth ~/sounds/enya- 44100Hz.wav
GNU gdb 6.6-debian
Copyright (C) 2006 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you ar=
e

welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB. Type "show warranty" for details.
This GDB was configured as "i486-linux-gnu"...
(no debugging symbols found)
Using host libthread_db library "/lib/tls/i686/cmov/libthread_db.so.1".
(gdb) r
Starting program: /usr/bin/aplay -Dplug:bluetooth ~/sounds/enya- 44100Hz.wa=
v
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
[Thread debugging using libthread_db enabled]
[New Thread -1211472192 (LWP 6891)]
(no debugging symbols found)
Lecture en cours WAVE '~/sounds/enya-44100Hz.wav' : Signed 16 bit Little
Endian, Taux 44100 Hz, St=E9r=E9o

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread -1211472192 (LWP 6891)]
0xb7b86196 in bluetooth_a2dp_write (io=3D0x8061940, areas=3D0x805a3e0,
offset=3D0, size=3D128)
at pcm_bluetooth.c:674
674 memcpy(a2dp->buffer + a2dp->count, a2dp-> sbc.data, a2dp->sbc.len);
$

When i launch the player again all is working =3D=3D> So this bug appears
only when the
headset is initiating the connection.

My setup:
* Ubuntu / Kernel 2.6.22-6
* This morning bluez-libs and bluez-utils cvs
* pcm_bluetooth.c version : REL-3_18: 1.64

Does anyone have a clue on this issues ?

Regards,

S. Baguet

------=_Part_9266_9604638.1188826098162
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi All,<br><br>I have a crash in pcm_bluetooth.c when i try a connection.<b=
r><br>Here are the details :<br>I power on my bt headset (Sony Ericsson HBH=
970) - The headset opens<br>the connection...<br>Then i try to play an audi=
o file -&gt; SEG FAULT=20
<br><br>$ gdb --args aplay -Dplug:bluetooth ~/sounds/enya- 44100Hz.wav<br>G=
NU gdb 6.6-debian<br>Copyright (C) 2006 Free Software Foundation, Inc.<br>G=
DB is free software, covered by the GNU General Public License, and you are=
=20
<br>welcome to change it and/or distribute copies of it under certain<br>co=
nditions.<br>Type &quot;show copying&quot; to see the conditions.<br>There =
is absolutely no warranty for GDB. Type &quot;show warranty&quot; for detai=
ls.=20
<br>This GDB was configured as &quot;i486-linux-gnu&quot;...<br>(no debuggi=
ng symbols found)<br>Using host libthread_db library &quot;/lib/tls/i686/cm=
ov/libthread_db.so.1&quot;.<br>(gdb) r<br>Starting program: /usr/bin/aplay =
-Dplug:bluetooth ~/sounds/enya-=20
44100Hz.wav<br>(no debugging symbols found)<br>(no debugging symbols found)=
<br>(no debugging symbols found)<br>(no debugging symbols found)<br>(no deb=
ugging symbols found)<br>(no debugging symbols found)<br>[Thread debugging =
using libthread_db enabled]=20
<br>[New Thread -1211472192 (LWP 6891)]<br>(no debugging symbols found)<br>=
Lecture en cours WAVE &#39;~/sounds/enya-44100Hz.wav&#39; : Signed 16 bit L=
ittle<br>Endian, Taux 44100 Hz, St=E9r=E9o<br><br>Program received signal S=
IGSEGV, Segmentation fault.=20
<br>[Switching to Thread -1211472192 (LWP 6891)]<br>0xb7b86196 in bluetooth=
_a2dp_write (io=3D0x8061940, areas=3D0x805a3e0,<br>offset=3D0, size=3D128)<=
br>at pcm_bluetooth.c:674<br>674 memcpy(a2dp-&gt;buffer + a2dp-&gt;count, a=
2dp-&gt;=20
sbc.data, a2dp-&gt;sbc.len);<br>$<br><br>When i launch the player again all=
 is working =3D=3D&gt; So this bug appears<br>only when the<br>headset is i=
nitiating the connection.<br><br>My setup:<br>* Ubuntu / Kernel 2.6.22-6<br=
>
 * This morning bluez-libs and bluez-utils cvs<br>* pcm_bluetooth.c version=
 : REL-3_18: 1.64<br><br>Does anyone have a clue on this issues ?<br><br>Re=
gards,<br><br>S. Baguet<br><br>

------=_Part_9266_9604638.1188826098162--


--===============1804822187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1804822187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1804822187==--
