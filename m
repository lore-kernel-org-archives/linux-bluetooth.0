Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Victor Shcherbatyuk <victor@win.tue.nl>
To: bluez-devel@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0501242148470.14852-100000@antilope>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-devel] bluetooth socket + rfcomm tty
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
Date: Mon, 24 Jan 2005 22:13:12 +0100 (MET)

Dear All,
 
Could not find it through the archives... 
I create a bluetooth socket and then create TTY (/dev/rfcomm0) based on it (like it is done in dund from bluez-utils). 
Is it still allowed to use the descriptor of the open socket to send/receive data through the channel? 
Cause when I send data to the _socket_ it looks like it is sent (like 
ATD1234 command to the phone, I see the phone starting to dial, though it 
stops half way for no reason), but when I'm trying to read from the socket 
select() returns that there is data to be read, but then read() blocks.

Thanks.

Kind regards,
       Victor.

P.S. Is there any way to check if read() is non-blocking (like ioctl() 
FIONREAD)?



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
