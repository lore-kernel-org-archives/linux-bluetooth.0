Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <E73D9A5BC4A2D711BBC600065BF3595F1C66CF8D@il06exm10>
From: Mandalia Hiren-AHM047 <hirenm@motorola.com>
To: "'bluez-users@lists.sourceforge.net'" <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] BT programming
MIME-Version: 1.0
Content-Type: text/plain
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
Date: Thu, 10 Feb 2005 09:49:32 -0600


> the profiles are implemented in applications. Either you find a
> application that fits your needs or you have to write one. Be more
> specific about what profiles and what roles do you wanna support.

I was assuming that some of the profiles are already implemented and can easily be re-used for your application. If I were to write my own profiles is there any book/reference that can guide me? I'm planning to write applications to build PAN, exchange objects and IM chat...


> Check with "hcidump -X" what's the error code, but as I always say there
> is no need to establish an ACL link by hand. The kernel core will do it
> when one is needed.

Hcidump -x gives me something like..
device: hci0 snap_len: 1028 filter: 0xffffffff

and the process does not exit, unless I suspend it explicitly. 

Hiren



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
