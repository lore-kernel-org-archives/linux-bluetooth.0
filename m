Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Serial Port
From: Marcel Holtmann <marcel@holtmann.org>
To: Neil Fenemor <Neil@OnDrugs.co.nz>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1088044859.3703.55.camel@localhost.localdomain>
References: <1088044859.3703.55.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1088068518.4296.31.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 24 Jun 2004 11:15:18 +0200

Hi Neil,

> how do I fake my laptop as being a serial port? As thats what my phone
> needs to be able to see for a its Active Sync to work, and in turn,
> its synce/multisync...

aren't there are any SynCE + BlueZ howtos? However the easiest way is to
use something like this:

	sdptool add --channel=12 sp
	rfcomm listen 0 12

If I remeber correct the ActiveSync over Bluetooth means PPP over RFCOMM
so you should better use dund instead of rfcomm.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
