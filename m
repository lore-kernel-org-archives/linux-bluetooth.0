Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <e1effdeb05032805225cf1b8dd@mail.gmail.com>
References: <e1effdeb05032805225cf1b8dd@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1112016560.9016.32.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: [Bluez-users] PANU service search
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 28 Mar 2005 15:29:20 +0200

Hi Claudio,

> The sdptool doesn't provide search for PANU service. Is there plans
> for implement this?

you can do it by "sdptool search --bdaddr <bdaddr> 0x1115".

> A PANU device can be started with the following command:
> pand --listen --role PANU
> 
> This scenario can be usefull when there are a lot of servers and a 
> client device works as a GN connecting these servers. eg: UPnP applications.

The pand client can search for PANU by itself and I don't see any real
use for it. However send in a patch for it.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
