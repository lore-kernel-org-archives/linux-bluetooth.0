Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Maintain Bluetooth Connections
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <6EF58BF68042DF4AA46A54994117D64F0253E787@mercury.mtctech.com>
References: <6EF58BF68042DF4AA46A54994117D64F0253E787@mercury.mtctech.com>
Content-Type: text/plain
Message-Id: <1108057010.15974.86.camel@pegasus>
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
Date: Thu, 10 Feb 2005 18:36:50 +0100

Hi Richard,

> I have a small, wearable computer, battery powered, of course. The
> X-scale processor is connected to the BT radio through a serial port
> and is the master in a small network of BT devices. All this works
> very well. This is running Linux 2.6 with the latest patches.
> 
> During idle periods, to save power, I want to suspend the main
> microprocessor. The BT radio is powered from a separate circuit. For
> now, before I suspend the micro, I close all the connections, and
> perform a "bluetooth stop". When the micro wakes up, the micro does a
> "bluetooth start" and then reestablishes the connections to the
> peripheral devices. This does work, but it takes some time. I would
> like to have the BT network recover as quickly as possible.
> 
> Is it possible to instruct the BT radio to autonomously maintain the
> established connections, even though the microprocessor has been
> suspended ?  So that when the main processor wakes up, the BT network
> is still there. I don't know how much of the connection "keep alive"
> function is performed by the Bluez stack.

not that I know and there is no keep alive in the BlueZ stack. Actually
we don't support idle disconnect and even not automatic sniff mode. The
latter one is on my todo list.

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
