Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Fred Schaettgen <Sch@ttgen.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] how to detect if a device is up.
Cc: wim delvaux <wim.delvaux@adaptiveplanet.com>
References: <200412061608.48387.wim.delvaux@adaptiveplanet.com>
In-Reply-To: <200412061608.48387.wim.delvaux@adaptiveplanet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412061623.29139.Sch@ttgen.net>
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
Date: Mon, 6 Dec 2004 16:23:28 +0100

On Monday 06 December 2004 16:08, wim delvaux wrote:
> suppose you manage a list of 'seen' but not necessarily paired devices.
> How can you figure out if a certain device is UP or not ?
> l2ping apparently not since you need to be paired with that device or else
> you get permission denied

How about an inquiry? You can also use name requests for instance. We use this 
in kdebluetooth for the device discovery service to poll undiscoverable 
devices. But you can't do that frequently and for a lot of devices of course. 
Apart from that, if you get "permission denied" with l2ping, then the device 
*is* reachable, isn't it?

Fred

-- 
Fred Schaettgen
Sch@ttgen.net


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
