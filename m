Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Triona Ryan <triona.ryan@nuigalway.ie>
To: bluez-users@lists.sourceforge.net
Message-id: <01LKRITSDX9I0036OM@beacon.nuigalway.ie>
MIME-version: 1.0
Content-type: text/plain
Subject: [Bluez-users] Can't connect.: Function not implemented
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
Date: Sun, 13 Feb 2005 17:38:31 +0000

Hi all,

I'm new to this mailing list, but have been experimenting with bluetoot
h over linux for a few months now. I've had a look at the archive, and saw an en
try very similar to mine, which was unresolved. I'm hoping there are more recent
 insights to help me!!

I've bluez installed on Fedora Core 2, and until a few w
eeks ago, when I started to try and get rfcomm to work, I could l2ping, pair to 
several devices and connect using hcitool with no problem. Recently however, I c
an no longer l2ping certain modules. I now get 

Can't connect.: Function not im
plemented

As an error. I can still l2ping select devices.

I saw that encrypt a
nd authentication must be commented out in /etc/bluetooth/hcid.conf which I have
 always had. 

Can anyone recognise any problem there?

Thanks very much,
Triona





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
