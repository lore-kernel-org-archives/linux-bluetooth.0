Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Configuring HCId for logging everything
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050331163323.btemcytgys0c0kkg@webmail.tugraz.at>
References: <20050331163323.btemcytgys0c0kkg@webmail.tugraz.at>
Content-Type: text/plain
Message-Id: <1112554624.8263.11.camel@pegasus>
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
Date: Sun, 03 Apr 2005 20:57:03 +0200

Hi Hans Juergen,

> How can I configuring hcid, so that it would log everything (i.e. 
> logging every attempt of another bluetooth-device establishing a 
> connection)?
> 
> I've changed my Bluetooth-Class to class 0x200404; so that my Nokia 
> 6230 would try to connect to the PC (Fedora Core 3), because it only 
> can connect to a headset.
> 
> This connection cannot - of course - be established because there is no 
> service behind, I just want to see that there is an attempt, but 
> nothing is written into /var/log/messages (only things like HCI dev 0 
> or shutting down), or is there another log file? (neither dmesg is 
> printing something useful)

use hcidump for these kind of things.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
