Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] how detect bnep disconnection ?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <I8T80S$914236AECE25C0455D98517D1D8A2F3C@libero.it>
References: <I8T80S$914236AECE25C0455D98517D1D8A2F3C@libero.it>
Content-Type: text/plain
Message-Id: <1103191974.28046.47.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 16 Dec 2004 11:12:54 +0100

Hi Andrea,

> i am working on a "pand" based that basically sets up bnep connections.
> For my tests, i use simple usb bluetooth dongles (in particolar, some CSR dongle).
> My question is: how an endpoint (es a PANU) can detect a link lost ? I see
> w4_hup shuld
> handle this, but if i mnually remove the GN dongle, the PANU does't signal nothing.
> can someone help me ??

the bnep0 ethernet device will disappear.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
