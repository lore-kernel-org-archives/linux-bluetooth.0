Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] nonblocking connect : Wrong return code ?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412040251.25791.wim.delvaux@adaptiveplanet.com>
References: <200412040251.25791.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1102135551.8479.34.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 04 Dec 2004 05:45:51 +0100

Hi Wim,

> when using a nonblocking socket,
> 
> when the connect is requested the errno that is returned is 11. (resource 
> temporarily unavailable)
> 
> Man page says that it should be EINPROGRESS (which is 115).
> 
> Man page for connect says :
> 
> EINPROGRESS : 
> 
> The socket is non-blocking and the connection cannot be completed immediately.  
> It is possible to select(2) or poll(2) for completion by selecting
> 
> but
> 
> EAGAIN :
> 
> No more free local ports or insufficient entries in the routing cache
> 
> 
> EAGAIN is a proper return code for this situations for read or write but not 
> for connect ...

we had this questions a long time ago and I never got a final answer
from anyone what is the right way to do. However the change must be done
in bt_sock_wait_state() and you must check rfcomm/sock.c, l2cap.c and
sco.c if it is still working as expected. Feel free to send in a patch
for it.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
