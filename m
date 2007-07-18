Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <469DCBD6.7040005@mojo-working.com>
Date: Wed, 18 Jul 2007 01:14:14 -0700
From: Art Rothstein <holtmann@mojo-working.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] RFCOMM DISC dlci=0 missing after server closesocket?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Our RFCOMM application conducts a brief session to validate the application on a 
partner device, then terminates the session and gives the user an option to 
reconnect to the partner application.  When the local application uses the 
Microsoft stack or Toshiba stack on a WinXP, and the remote application uses 
BlueZ, the user-driven connect fails if issued less than 60 secs before the 
first session is disconnected.

This appears to be a flaw in the BlueZ implementation, but I am no expert on the 
subject.  Is my analysis correct?  If it is, can someone suggest a workaround?

The RFCOMM specification from Bluetooth 1.1 says

<< The device closing the last connection (DLC) on a particular session is 
responsible for closing the multiplexer by closing the corresponding L2CAP channel.

Closing the multiplexer by first sending a DISC command on DLCI 0 is optional, 
but it is mandatory to respond correctly to a DISC (with UA response).  >>

I posted a test case, with source code, executables, console output, and an 
hcidump trace, at http://65.104.11.121/MissingDisconnect/.  The BlueZ server 
application accepts an RFCOMM connection, closes the socket 15 seconds later, 
then recycles to accept another connection.  The client application, written for 
the Microsoft Win32 stack, discovers the target service, connects to it, waits 
for the disconnection, sleeps 5 seconds, then recycles for one more pass.

In response to a socket close, the server application sends an RFCOMM DISC for 
dlci=2 (23:13:50.182534 in the trace).  Following receipt of the client's RFCOMM 
UA, other servers send RFCOMM DISC for dlci=0.  Not so BlueZ.  It does 
essentially nothing.  For clients using BlueZ or a Win32 Broadcom stack, the 
client stack compensates for this deficiency.  For Win32 clients using the 
Microsoft or Toshiba stack, the client waits 60 seconds after the RFCOMM DISC 
dlci=2 for an L2CAP disconnect before sending one of its own (23:14:49.948835).

For a Win32 Microsoft client, this 60 second delay blocks the client's 
subsequent connect() request.  For a Win32 Toshiba client, the delay causes the 
connect() request to fail.


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
