Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Changing transmit power level of bluetootht
	device - how to?
From: Marcel Holtmann <marcel@holtmann.org>
To: filipe_abrantes <filipe_abrantes@netcabo.pt>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5CD2BD8F1F23A943BAEBE96AB20C24980549DD3A@VS1.hdi.tvcabo>
References: <5CD2BD8F1F23A943BAEBE96AB20C24980549DD3A@VS1.hdi.tvcabo>
Content-Type: text/plain
Message-Id: <1077297968.2714.1.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 20 Feb 2004 18:26:08 +0100

Hi Filipe,

> I'm new to this mailing list, so im not so sure if this is the right place to post this, anyway, my question is - is there any way (c function?) to change the level of power of transmission of a bluetooth device?

no, because this is a job of the Bluetooth chip. The host stack can only
read the actual transmit power level of a connection.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
