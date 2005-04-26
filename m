Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] How to NOT initialize newly attached Bluetooth
	dongles
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050425014245.12337.qmail@web20926.mail.yahoo.com>
References: <20050425014245.12337.qmail@web20926.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1114515461.10706.213.camel@pegasus>
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
Date: Tue, 26 Apr 2005 13:37:41 +0200

Hi Arch,

> I have been using hcid in handling initialization of my Bluetooth
> dongle.
>  
> I have this issue with regards to me not wanting to initialize newly
> attached Bluetooth dongles.
> Here is the scenario:
> 1. I let hcid initialize my attached Bluetooth dongle.
> 2. Then I configure the dongle to be in the OFF state/mode (hciconfig
> hci0 down).
> 3. When I detach the dongle and re-attach it, it comes back to UP and
> Running mode.
>  
> Since I put the dongle in OFF mode, I would like to keep this mode
> when I detach and re-attach the dongle.
>  
> My question then is how will I make it not being automatically
> initialized by hcid.
> I have been trying to play with the hcid configuration file but to no
> avail.

the hcid is not storing the current mode of a device. The only thing you
can do right now is to disable the autoinit feature completely and do
everything by yourself.

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
