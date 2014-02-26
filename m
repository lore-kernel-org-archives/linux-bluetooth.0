Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 15/17] Bluetooth: Add le_auto_conn file on debugfs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393362104-12175-16-git-send-email-andre.guedes@openbossa.org>
Date: Tue, 25 Feb 2014 22:41:19 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <13751D39-57A3-4B04-9E1F-7BC4BE2DF4A7@holtmann.org>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org> <1393362104-12175-16-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds to debugfs the le_auto_conn file. This file will be
> used to test LE auto connection infrastructure.
> 
> To add a new auto connection address we write on le_auto_conn file
> following the format <address> <address type> <auto_connect>.
> 
> The <address type> values are:
>  * 0 for public address
>  * 1 for random address
> 
> The <auto_connect> values are (for more details see struct hci_
> conn_params):
>  * 0 for disabled
>  * 1 for always
>  * 2 for link loss
> 
> So for instance, if you want the kernel autonomously establishes
> connections with device AA:BB:CC:DD:EE:FF (public address) every
> time the device enters in connectable mode (starts advertising),
> you should run the command:
> $ echo "AA:BB:CC:DD:EE:FF 0 1" > /sys/kernel/debug/bluetooth/hci0/le_auto_conn
> 
> To get the list of connection parameters configured in kernel, read
> the le_auto_conn file:
> $ cat /sys/kernel/debug/bluetooth/hci0/le_auto_conn
> 
> Finally, to clear the connection parameters list, write an empty
> string:
> $ echo "" > /sys/kernel/debug/bluetooth/hci0/le_auto_conn
> 
> This file is created only if LE is enabled.

I wonder if this should be prefixed with a command. For example like this:

	“add <address> <address_type> [auto_connect]”
	“del <address> <address_type>”
	“clr”

Regards

Marcel

