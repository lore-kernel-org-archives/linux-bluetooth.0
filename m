Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-user@schaettgen.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco and headsets questions
References: <20050211223950.23217.qmail@web50203.mail.yahoo.com>
In-Reply-To: <20050211223950.23217.qmail@web50203.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502120123.12943.bluez-user@schaettgen.de>
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
Date: Sat, 12 Feb 2005 01:23:12 +0100

On Friday 11 February 2005 23:39, Paul Ionescu wrote:
> I think we need something like inetd is for tcpip.
> There is a kbluetoothd that does this, but it depends on kde.
> I managed to modify a little bit the btsco2 in order to use it with
> kbluetoothd. So now, I can press my connect button on HS and it connects to
> my laptop. But I would prefer a small inetd like daemon, something in core
> bluez (which is not yet written).

IIRC I had a short discussion with Marcel once about something like 
kbluetoothd (before it existed). He didn't seem to like the idea a lot that 
time, but it works pretty well for us now.
It's especially useful if you want users to interactively accept connection. 
Asking the user and managing connection policies is all done by the 
framework, not by the server process, so there is less duplication of code. 
Now that dbus is here, user interaction should also be possible with services 
not running under a regular user account and a hypothetical bluetoothd.
It also more resource friendly and it doesn't matter that much if a bluetooth 
services crashes from time to time. And you don't have to deal with sdp 
registration in you C code and provide a registration file instead. One 
concern was that sdp records are not static, but usually it's only the rfcomm 
(or l2cap) channel which must be dynamic.

But obviously there wasn't that much demand for it. A "bluetoothd" for just 
one or two services looks a bit like overkill. Or how many bluetooth services 
are running on your machine? 

Fred

-- 
Fred Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
