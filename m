Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-user@schaettgen.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] managing pairing
References: <200412030025.02336.wim.delvaux@adaptiveplanet.com>
In-Reply-To: <200412030025.02336.wim.delvaux@adaptiveplanet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412050159.55909.bluez-user@schaettgen.de>
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
Date: Sun, 5 Dec 2004 01:59:55 +0100

On Friday 03 December 2004 00:25, wim delvaux wrote:
> another question.  I suppose the link_key file can contain link keys to
> multiple remove BT devices (e.g a USB BT dongle and a BT Phone)
>
> I also presume that each link_key is associated to the bdaddress of the
> remote device it relates to.
>
> 1. can the link_key file be browsed to find all the devices a link_key
> exists for
>
> 2. can one 'remove' one such record from the link_key file and assume that
> the pairing will retry once removed (much like removing the link_key file
> completely)

Just for the record and for the KDE users out there: 
The KDE Bluetooth Framework just got it's own link key management tool a few 
minutes ago, so you can see and remove any paired device without using a hex 
editor or deleting the whole link key file now. I just wonder why no one 
seemed to miss something like that the whole time.

regards
Fred

-- 
Fred Schaettgen
bluez-user@schaettgen.de


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
