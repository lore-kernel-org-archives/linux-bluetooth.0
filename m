Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Service Record Problem
From: Marcel Holtmann <marcel@holtmann.org>
To: franz keuner <franz_keuner@gmx.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <16619.1079606404@www34.gmx.net>
References: <16619.1079606404@www34.gmx.net>
Content-Type: text/plain
Message-Id: <1079619908.3301.35.camel@pegasus>
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
Date: Thu, 18 Mar 2004 15:25:09 +0100

Hi Franz,

> thanks for your help with my last problem.
> 
> now i have a problem with service registration. i register a service using
> the Java Bluetooth APIs. it creates a service record with an uuid of length
> 128. that seems to be predetermined.
> 
> if i search for services on the device i can't find that specific service.
> but if i scan for SP services i receive the following message:
>   ...
>   Service Name: Service Name
> Service RecHandle: 0x1000a
> Service Class ID List:
>   "Error: This is uuid128" (0xabcd0000-1000-8000-0080-5f9b34fb0000)
>   "Serial Port" (0x1101)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 5
> Language Base Attr List:
>   code_ISO639: 0x656e
>   encoding:    0x6a
>   base_offset: 0x100
> Profile Descriptor List:
>   "Serial Port" (0x1101)
> ..
> 
> if i use a pda (pocket pc) with bluetooth support and search for services i
> find the service without a problem.
> 
> so my question is: what can i do to find that service using bluez and the
> "normal" sdptool search browse command?

the problem is not the UUID128, it is that your record is not in the
public browse group and so you have to search for the service. Look at
the --help information from sdptool.

	sdptool search --bdaddr <bdaddr> SP

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
