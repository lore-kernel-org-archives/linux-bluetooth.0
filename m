Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: 2.6.2 errors with DBT-120 (B2)
From: Marcel Holtmann <marcel@holtmann.org>
To: "Todd E. Johnson" <tejohnson@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <402E2E29.7040207@yahoo.com>
References: <402E2E29.7040207@yahoo.com>
Content-Type: text/plain
Message-Id: <1076769794.14758.2.camel@pegasus>
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
Date: Sat, 14 Feb 2004 15:43:14 +0100

Hi Todd,

> Bummer on the SCO support.  I am looking forward to using it in an 
> embedded linux based telematics system for vehicle hands free 
> functionality.

this depends on whats your design. Do you use SCO over PCM or SCO over
HCI? If your embedded device includes a PCM codec you can route the SCO
traffic of the Bluetooth chip over PCM and you don't need the SCO audio
support for the HCI USB driver.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
