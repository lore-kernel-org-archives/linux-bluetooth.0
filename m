Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] how to get bluetooth to emulate comport?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050301033641.87972.qmail@web50707.mail.yahoo.com>
References: <20050301033641.87972.qmail@web50707.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1109665822.17256.124.camel@pegasus>
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
Date: Tue, 01 Mar 2005 09:30:22 +0100

Hi John,

> hciconfig hci0 up
> 
> works
> 
> 
> rfcomm connect 0 08:00:37:0f:84:35
> Can't connect RFCOMM socket: Connection refused
> 
> I told my lg pm-325 to be visible, and waiting for
> pairing.
> what's the deal?

run "hcidump -X -V" as root and I think you will see a PIN code request
that is never answered. Start hcid.

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
