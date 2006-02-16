Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <bd72c4b0602151628v14d53ae7vab573412bb56d6c@mail.gmail.com>
From: Gareth Bradley <gareth.bradley.nz@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_12046_11861357.1140049701223"
Subject: [Bluez-devel] Slow connect time for devices
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
Date: Wed, 15 Feb 2006 12:28:21 -1200

------=_Part_12046_11861357.1140049701223
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello. I'm working on a project on a Intel XScale processor, connecting to
bluetooth heart rate monitors and headsets. Connections currently have 7
attempts to work, though leaving a debug flag on (which slows the handshake
down) gets a near-instant connection. I would like to get the connections
normal without slowing down the BT device after the connection is made.

Any normal connection, regardless of whether there's an authorization
segment, will fail (errors 104 & 110 - 'Connection timed out' and
'Connection reset by peer') 7 times before connecting. It'll usually
alternate between the two errors, and the 7 is fairly constant.

I have found that I can get the total connection time by reducing these two
variables down to 2 seconds each. It still takes seven attempts. Once the
first device is connected, any others will either be instant or have one
timeout/reset.

(rfcomm.h)
#define RFCOMM_CONN_TIMEOUT (HZ * 2)
#define RFCOMM_DISC_TIMEOUT (HZ * 2)

I later found that enabling a debug flag will give me instant connections
(how I assume things should be), because it is slowing down the process. Th=
e
flag is HCI_CORE_DEBUG in bluetooth.h, which affects the fines hci_core.c,
hci_conn.c and hci_event.c. I have isolated it to the hci_core.c file that
needs to be slowed down.

I can't, however, leave the prints on or a loop to slow it down or sleep, a=
s
the SCO voice connection becomes unusable with them on once it is connected=
.

Can someone please suggest an approach to targeting and slowing down the
handshake and the not the resulting connection?

gjb.

------=_Part_12046_11861357.1140049701223
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello. I'm working on a project on a Intel XScale processor, connecting
to bluetooth heart rate monitors and headsets. Connections currently
have 7 attempts to work, though leaving a debug flag on (which slows
the handshake down) gets a near-instant connection. I would like to get
the connections normal without slowing down the BT device after the
connection is made.<br>
<br>
Any normal connection, regardless of whether there's an authorization
segment, will fail (errors 104 &amp; 110 - 'Connection timed out' and
'Connection reset by peer') 7 times before connecting. It'll usually
alternate between the two errors, and the 7 is fairly constant.<br>
<br>
I have found that I can get the total connection time by reducing these
two variables down to 2 seconds each. It still takes seven attempts.
Once the first device is connected, any others will either be instant
or have one timeout/reset.<br>
<br>
(rfcomm.h)<br>
#define RFCOMM_CONN_TIMEOUT (HZ * 2)<br>
#define RFCOMM_DISC_TIMEOUT (HZ * 2)<br>
<br>
I later found that enabling a debug flag will give me instant
connections (how I assume things should be), because it is slowing down
the process. The flag is HCI_CORE_DEBUG in bluetooth.h, which affects
the fines hci_core.c, hci_conn.c and hci_event.c. I have isolated it to
the hci_core.c file that needs to be slowed down.<br>
<br>
I can't, however, leave the prints on or a loop to slow it down or
sleep, as the SCO voice connection becomes unusable with them on once
it is connected.<br>
<br>
Can someone please suggest an approach to targeting and slowing down the ha=
ndshake and the not the resulting connection?<br>
<br>
gjb.<br>

------=_Part_12046_11861357.1140049701223--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
