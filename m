Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BlueZ on CSR ?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050224231044.13234.qmail@web51608.mail.yahoo.com>
References: <20050224231044.13234.qmail@web51608.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1109340985.5908.1.camel@notepaq>
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
Date: Fri, 25 Feb 2005 15:16:25 +0100

Hi Parsanna,

> I am doing a project at Bournemouth University, UK. I am using Gennum
> corporations GR2320 bluetooth modules.  These modules have BlueCore
> HCI software stack embedded onto the module.
>  
> I have installed BlueZ on linux (mandrake 10.0 official). My host PC
> is a laptop - HP NX9005. But i am not able to connect to the module
> via the RS232 interface (UART)..... Is it because blueZ does not yet
> support CSR?
>  
> Please can any one answer my query, coz i am very desperate to
> demonstrate bluetooth connection between two bluetooth devices using
> the GR2320 Bluetooth module

the CSR chips are fully supported on the UART with H:4 and BCSP as host
transport protocol. I don't see your problem and unless you don't give
more information nobody will be able to help you.

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
