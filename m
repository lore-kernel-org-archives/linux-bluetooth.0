Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41AE5F72.6030201@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] general rfcomm questions
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
Date: Thu, 02 Dec 2004 01:18:58 +0100

Hello

i now tried and read quite a few things about rfcomm and multiple 
connections... but still don't really know what i was searching for...
maybee someone here can help me (hopefully).

i have one device that needs to parallely serve a service to multiple 
clients via rfcomm.
- is it possible that the service runns on multiple rfcommchannels, one 
for each clients? what's the limit?
- or is the solution to wait for connections, and on a incoming 
connection close it to connect to that device (having the local service 
waiting for new connections)...
- does a inquiry block the whole device? i noticed that if a connection 
between my device and a client is etablished, i'm unable to run "hcitool 
scan"...

i'd really appreciate if someone had the time to share it's knowledge...

kind regards
Marco Trudel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
