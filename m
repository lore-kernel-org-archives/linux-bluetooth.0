Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 25 Apr 2007 18:48:06 +0300
From: Mikko Tuumanen <mijutu@utu.fi>
To: bluez-users@lists.sourceforge.net
Message-id: <20070425154806.GG7988@sorvankyla.yok.utu.fi>
MIME-version: 1.0
Subject: [Bluez-users] More than two incoming rfcomm connections?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello.

I just wrote this little program to serve gps data to
several cellular phones:

http://users.utu.fi/mijutu/src/gpsBtHub/

I wrote it because typical bluetooth gps devices will
only accept one connection at a time.

First I register an sdp service:
sdptool add --handle=0x003 --channel=1 SP

And then run this program that will 
connect to a gpsd (http://gpsd.berlios.de/) and
socket, bind, listen and accept 
incoming connections to rfcommchannel 1. 
After each successful accept, a new thread is
created for the client and accept is attempted again.

The program works fine except I can only connect two
clients at a time.

For example I can connect one "bluetooth serial chat"
and one phone and when I try to connect another kbtserialchat,
I get "Connection error (112)."

When the 3rd client tries to connect, the accept on
server doesn't return.

What's happening here? I could guess that
that this method is creating a new piconet for
each incoming connection and this Cambridge Silicon Radio
bluetooth dongle can only be slave in two.
Am I close to the truth here?

If I do a role switch with hcitool for each client connection,
I can connect at least five clients. I didn't try more,
because I ran out of bluetooth devices.

And finally my problem was solved by changing
"lm accept" to "lm master" in /etc/bluetooth/hcid.conf
But since I already wrote this message, I'll send it anyway. :-)

What is the meaning of the handle that is given to sdptool?

Would it be possible to do the role switch without root privileges in my
program if I didn't want to "lm master" in hcid.conf ?


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
