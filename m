Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] H4 loss of synchronization recovery
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.33.0504061449280.13712-100000@horus.imag.fr>
References: <Pine.GSO.4.33.0504061449280.13712-100000@horus.imag.fr>
Content-Type: text/plain
Message-Id: <1112794116.9047.33.camel@pegasus>
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
Date: Wed, 06 Apr 2005 15:28:36 +0200

Hi Catalin,

> Attached you have the updated patch for recovering from
> H4 synchronization loss (sending the reset command after a
> hardware error event and reseting stack state).
> 
> Here's a summary of the changes:
>   - the procedure is only perfomed when the underlying transport
> is HCI_UART
>   - the counters are reset not by a command, but from the hdev struct
>   - the "scan enable", "authentication enable", "encrypt mode" variables
> are restored to their previous values from hdev->flags
>   - if there was an ongoing inquiry, it has been killed by the reset, so
> the HCI_INQUIRY flag is cleared
>   - I added an hci_req_cancel
> 
> I have tested the patch with the buggy BT module in the iPaq h5550 and it
> works as expected.

please change some things for me to clean this patch.

1. The "{" after the function name must be at the next line.

2. Name the reset function hci_reset_dev().

It is not H:4 specific, even if you only call it in that case. And since
the parameter is hci_dev it should not start with hci_dev_*. In this
case you would expect a device id.

3. There is no need to preset "auth" and "encrypt".

4. For "auth" and "encrypt" use constructs like this:

	auth = test_bit(HCI_AUTH, &hdev->flags) ? AUTH_ENABLED : AUTH_DISABLED

To decrease the stack size, you can also use the same variable for
"auth", "encrypt" and "scan".


And what do we do if the transport if BCSP? In this case the type is
also HCI_UART.

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
