Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40193837.1070605@jbc-computer.de>
From: Jan Bandouch <news.jan@jbc-computer.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] sockets connect before accept()
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 29 Jan 2004 17:43:35 +0100

Hello,
I'm developing a Bluetooth Client/Server application with the client 
being a Palm Handheld and the Server being a linux PC using BlueZ 
(Debian Kernel 2.4.22, libbluetooth1-dev version 2.5-1).

My client programm (PalmOS) does the following:
1) Establish an Acl Link to the server (address and channel is hardcoded)
2) Create and Connect an RfComm socket to the server (address/channel 
still hardcoded)

The connection does get established all right.
The funny thing is, that on the server side all I did was to create a 
RfComm socket, bind that socket to BDADDR_ANY and channel 10, and 
listen. Thats all. No accept(..) call, no select(..) etc.
I can do a select(..), but I never get told of any connection requests.
I believe that is because my connection request was already handled 
before calling select(..).
But why or by whom? I'm new to socket programming, but as far as I know 
this is not the way it's supposed to work, or is it? And BlueZ 
programming should work similar to socket programming, or not?
And how am I supposed to get a socket handler for the data socket 
without calling accept(..)?

Some more info:
The rfcomm-module is not in use, before I start my server programm.
After the client establishes the connection, "cat 
/proc/bluetooth/rfcomm" shows the following information:

dlc EF:30:04:72:02:00 94:A1:10:E0:07:00 1 20 127 40 1
sk  EF:30:04:72:02:00 94:A1:10:E0:07:00 1 10
sk  00:00:00:00:00:00 00:00:00:00:00:00 4 10

the last line is my listening socket, the first two seem to be the 
connection "initiated" by the Palm. Any infos on how to read the above 
information? what does "dlc" stand for, and the numbers on the right?

Any help appreciated. At first I thought that some other process accepts 
the connection, but the connection gets only established after listening 
on my socket.

Thanks,

Jan



By the way, any documentation, links regarding BlueZ programming are 
welcome! I know the site of Marcel Holtmann, but there's only one 
article dealing with programming, and it's seems I could use some more :-)








-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
