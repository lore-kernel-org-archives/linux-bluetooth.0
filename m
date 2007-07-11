Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: George Hansel <ghansel@MIT.EDU>
To: bluez-devel@lists.sourceforge.net
Date: Wed, 11 Jul 2007 14:30:00 -0400
Message-Id: <1184178600.6062.27.camel@Epimenides>
Mime-Version: 1.0
Subject: [Bluez-devel] Handling simultaneous SCO connections: Does BlueZ
	have multiple	SCO buffers?
Reply-To: ghansel@MIT.EDU,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1460016687=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1460016687==
Content-Type: multipart/alternative; boundary="=-Lxbf2ZPEp+xf+Yz5GzMr"


--=-Lxbf2ZPEp+xf+Yz5GzMr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I'm working on a project which is trying to handle multiple SCO
connections and data transfer (from cell phones) simultaneously, whether
that involves using multiple Bluetooth adapters on a single computer
(one SCO connection per adapter) or multiple connections per adapter (up
to the maximum of 3).

I have a process which handles the initial RFCOMM setup, the AT commands
involved in having the computer pretend to be a Hands-Free Device, and
accepts an SCO connection once the phone initiates. It's written in
Python using the PyBlueZ module. Multiple processes are launched in
order to handle multiple connections, and I've so far been able to
establish multiple RFCOMM connections on a single and on multiple
adapters.

The problem arises when I try to start multiple SCO connections (by
pressing buttons on the cell phone, so as to send DTMF tones over the
connection). I am not able to establish multiple simultaneous SCO
connections, and not only that, but the SCO data is directed to a
different process every time the SCO connection resets (due to 3 seconds
of silence - this is a feature of the Hands-Free Profile). This makes it
seem as though there is only one SCO buffer somewhere in the stack, and
any waiting process just reads from it, assuming that it's the proper
data. 

My question: Is it true that BlueZ has only one buffer for SCO data? If
this is true, where in the BlueZ stack is this single implementation (in
the kernel drivers? in the bluez-libs? in the bluez-utils?)? I'd have no
reservations about trying to implement a second (or third, as the
protocol truly demands) one. Lastly, if this is not a BlueZ problem at
all, but rather a hardware or PyBlueZ issue, just let me know.

Thanks for any consideration,
George

--=-Lxbf2ZPEp+xf+Yz5GzMr
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.14.1">
</HEAD>
<BODY>
I'm working on a project which is trying to handle multiple SCO connections and data transfer (from cell phones) simultaneously, whether that involves using multiple Bluetooth adapters on a single computer (one SCO connection per adapter) or multiple connections per adapter (up to the maximum of 3).<BR>
<BR>
I have a process which handles the initial RFCOMM setup, the AT commands involved in having the computer pretend to be a Hands-Free Device, and accepts an SCO connection once the phone initiates. It's written in Python using the PyBlueZ module. Multiple processes are launched in order to handle multiple connections, and I've so far been able to establish multiple RFCOMM connections on a single and on multiple adapters.<BR>
<BR>
The problem arises when I try to start multiple SCO connections (by pressing buttons on the cell phone, so as to send DTMF tones over the connection). I am not able to establish multiple simultaneous SCO connections, and not only that, but the SCO data is directed to a different process every time the SCO connection resets (due to 3 seconds of silence - this is a feature of the Hands-Free Profile). This makes it seem as though there is only one SCO buffer somewhere in the stack, and any waiting process just reads from it, assuming that it's the proper data. <BR>
<BR>
My question: Is it true that BlueZ has only one buffer for SCO data? If this is true, where in the BlueZ stack is this single implementation (in the kernel drivers? in the bluez-libs? in the bluez-utils?)? I'd have no reservations about trying to implement a second (or third, as the protocol truly demands) one. Lastly, if this is not a BlueZ problem at all, but rather a hardware or PyBlueZ issue, just let me know.<BR>
<BR>
Thanks for any consideration,<BR>
George
</BODY>
</HTML>

--=-Lxbf2ZPEp+xf+Yz5GzMr--



--===============1460016687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1460016687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1460016687==--
