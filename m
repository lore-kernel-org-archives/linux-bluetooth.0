Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Triona Ryan <triona.ryan@nuigalway.ie>
To: bluez-users@lists.sourceforge.net
Message-id: <01LKSFUD1WC0003PT2@beacon.nuigalway.ie>
MIME-version: 1.0
Content-type: text/plain
Subject: [Bluez-users] Re: Can't connect.: Function not implemented
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
Date: Mon, 14 Feb 2005 09:24:17 +0000

Ok now I can l2ping any module once I hcitool cc it. 

Ok, I think my problem is
 to do with the sdp modules. I know they're supposed to be included in the bluez
-utils package, and when I type sdpd, l2cap appears in lsmod. However, Between l
inux modules, it seems as if sdpd is not present. 

I've been searching google, 
and have seen the same error, always with, "sdpd is not installled" as a solutio
n.  Is there any way I could have unsuitable packages installed?

see the link b
elow
http://lists.freshrpms.net/pipermail/freshrpms-list/2004-September/010850.h
tml

I'm also using fedora core 2.


==============Original message text========
=======
On Sun, 13 Feb 2005 17:38:31 +0000 Triona Ryan wrote:

Hi all,

I'm new 
to this mailing list, but have been experimenting with bluetooth over linux for 
a few months now. I've had a look at the archive, and saw an entry very similar 
to mine, which was unresolved. I'm hoping there are more recent insights to help
 me!!

I've bluez installed on Fedora Core 2, and until a few weeks ago, when I 
started to try and get rfcomm to work, I could l2ping, pair to several devices a
nd connect using hcitool with no problem. Recently however, I can no longer l2pi
ng certain modules. I n
 ow get 

Can't connect.: Function not implemented

As a
n error. I can still l2ping select devices.

I saw that encrypt and authenticati
on must be commented out in /etc/bluetooth/hcid.conf which I have always had. 

Can anyone recognise any problem there?

Thanks very much,
Triona

===========En
d of original message text===========





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
