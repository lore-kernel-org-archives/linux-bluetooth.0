Return-Path: <cyrus@holtmann.org>
Subject: Re: using hci0 interface without DEVUP
From: Marcel Holtmann <marcel@holtmann.org>
To: pavan_savoy@ti.com
Cc: linux-bluetooth@vger.kernel.org, kobile@ti.com,
	pavan savoy <pavan_savoy@yahoo.co.in>
In-Reply-To: <250863.34433.qm@web94911.mail.in2.yahoo.com>
References: <250863.34433.qm@web94911.mail.in2.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Jul 2010 09:55:04 -0300
Message-ID: <1278420904.2789.41.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

> In certain cases, as in using VS commads to communicate with different cores on the combo chips (say, BT, FM, GPS) - we would have to use the hci0 interface without it being UP.
> 
> As in the hci0 interface still needs to be invisible (via dbus/bluetoothd) to the system but to be available to be use.
> 
> Is there a way we can do this while registering with the hci ?
> say a flag in the struct hci_dev to be by default during registration HCI_DEV_DOWN to be default state ?

it is a pretty simple fact that the HCI device has to up. Otherwise it
is not going to work. Same with an Ethernet interface. That is the
proper state for such interfaces.

What you want is to set RAW mode on the HCI device before bringing it
up. Then bluetoothd will actually ignore it.

However I am not sure what you are really trying to achieve here since
every device will be brought up automatically by bluetoothd. And so you
are already to late to the game at that point.

Regards

Marcel


