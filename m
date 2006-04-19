Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <c6a2f99a0604181925x1b61f8fer9b44102b3df4da7b@mail.gmail.com>
From: "Eric Munson" <ebmunson@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Programming in C with Bluetooth Sockets
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
Date: Tue, 18 Apr 2006 19:25:54 -0700

I am attempting to move data across a bluetooth connection using
RFCOMM sockets in C.

I am able to establish the connection and I can successfully send and
receive the first four bytes of the message.  The sending program
reports a complete success and the receiving program only reads the
first four characters.

I have tried several things to make this work, first was to send the
message size initially and then break the message up into pieces no
bigger than 4 bytes and send them individually.  The sending program
again reports a complete success and the receiving program gets the
correct message size and only the first four bytes of the message.

The next step I tried was to have each side close the socket after
each transmission and open a new socket for each data chunk.  This led
to the same results as before.

I am at a loss about what I am doing wrong after searching the web for
information on bluetooth socket programming.  Has Anyone seen this
sort of problem before and if so what did you do to fix it?  Thanks
for your help.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
