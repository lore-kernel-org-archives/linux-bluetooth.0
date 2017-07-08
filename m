Return-Path: <ian@mnementh.co.uk>
Subject: Re: [PATCH 2/3] bluetooth: Nokia: Use new
 hci_uart_unregister_device() function.
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, ohad@bencohen.org
References: <20170708142949.13496-1-ian@mnementh.co.uk>
 <20170708142949.13496-3-ian@mnementh.co.uk>
 <20170708145213.c2ido62qit2lctmq@earth>
From: Ian Molton <ian@mnementh.co.uk>
Message-ID: <b4b70b04-677c-18ca-03af-4b7f46fd031b@mnementh.co.uk>
Date: Sat, 8 Jul 2017 15:58:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170708145213.c2ido62qit2lctmq@earth>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/07/17 15:52, Sebastian Reichel wrote:
> I think "hu->proto->close(hu)" should also be moved into the
> helper function. Also I suggest to use hci_uart instead of hci_dev
> as parameter for hci_uart_unregister_device, which matches the
> related hci_uart_register_device.

Ha, it is. Thats what I get for posting an untested patch for review :)

Will fix, and move the ->close() call into the helper.

Thanks for the review, patch to follow.

-Ian
