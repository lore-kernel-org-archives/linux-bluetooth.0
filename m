Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200412040251.25791.wim.delvaux@adaptiveplanet.com>
Subject: [Bluez-users] nonblocking connect : Wrong return code ?
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
Date: Sat, 4 Dec 2004 02:51:25 +0100

when using a nonblocking socket,

when the connect is requested the errno that is returned is 11. (resource 
temporarily unavailable)

Man page says that it should be EINPROGRESS (which is 115).

Man page for connect says :

EINPROGRESS : 

The socket is non-blocking and the connection cannot be completed immediately.  
It is possible to select(2) or poll(2) for completion by selecting

but

EAGAIN :

No more free local ports or insufficient entries in the routing cache


EAGAIN is a proper return code for this situations for read or write but not 
for connect ...


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
