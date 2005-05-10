Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] page response
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200505101122.58004.viktor.teofanovic@bregenznet.at>
References: <200505101122.58004.viktor.teofanovic@bregenznet.at>
Content-Type: text/plain
Message-Id: <1115717279.8949.203.camel@pegasus>
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
Date: Tue, 10 May 2005 11:27:59 +0200

Hi Teos,

> 1. is it possible by using the HCI layer to response on page requests from
> other bt-devices?

on the HCI layer these are connection requests and not page requests.
The paging stuff happens in the link manager.

> 2. how can I listen for all incoming HCI packets like hcidump is doing it - 
> is there any implemented example for this?

I don't understand this question. What do you mean by incoming HCI
packets? Bluetooth is talking LMP on the air and not HCI.

If you wanna do something like hcidump look at its source code.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
