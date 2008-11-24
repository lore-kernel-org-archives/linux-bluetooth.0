Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <44A822C0-C143-4F39-BA74-FC414EC613DD@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: David Merrill <dmerrill@media.mit.edu>
In-Reply-To: <f86d2a880811040903i3ee0a5e7tdf9b52775108dab0@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: how to: Inquiry with RSSI?
Date: Mon, 24 Nov 2008 04:00:13 +0100
References: <f86d2a880811040903i3ee0a5e7tdf9b52775108dab0@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> First, thanks to the developers for creating Bluez - it's so nice to
> have such a useful, open-source Bluetooth option.
>
> I am writing with a question: how can I do an inquiry scan with RSSI,
> and read out the RSSI values? (without making a connection to devices)
> When I run "hciconfig hci0 inqmode" I get the following:
>
> Inquiry mode: Inquiry with RSSI
>
> ..so I think the adapter supports this, and is in the correct
> configuration - but when I run "hcitool scan", I only get the HW
> address and name of local adapters - no RSSI. Is there some flag, or
> option that I need to pass to hcitool in order to get RSSI as well?

run hcidump to see that you get the right events. Also just use the D- 
Bus interface of bluetoothd since that gives you the RSSI values.

Regards

Marcel

