Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Missing data in ACL packets from CSR chip
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000501c3f257$c4649af0$1a01010a@baked>
References: <000501c3f257$c4649af0$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1076694277.2671.184.camel@pegasus>
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
Date: Fri, 13 Feb 2004 18:44:37 +0100

Hi Daryl,

> It looks like a UART problem to me too, but it's probably not on my side
> because both the sniffer and the host saw the same error.

is it reproduceable when you use a Casira?

> I would like to try BCSP. Are there tools available to put the module in
> BCSP mode?

The pskey tool can do this, but at your own risc. Otherwise you must
write it by yourself, because I don't provide any source code that is
able to modify the PS.

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
