Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: BLE Advertise and Scan at the same time?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANzaTi7NSBf8iuTC41jBA=732PCZUYkzw_ZTywGM-xNQt68qbw@mail.gmail.com>
Date: Mon, 22 Jun 2015 12:22:10 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <670FEC00-5331-47B5-8434-7642D67779DC@holtmann.org>
References: <CANzaTi7NSBf8iuTC41jBA=732PCZUYkzw_ZTywGM-xNQt68qbw@mail.gmail.com>
To: dogan yazar <doganyazar@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dogan,

> Is it possible to advertise (leadv) and scan (scan on) using the same
> ble adaper?
> The moment that I enable scanning (scan on) with bluetoothctl, leadv
> is disabled.

that depends on the Bluetooth chip you are using. Inside the kernel we currently play it safe and disable one when we start the other. It will be however re-enabled when the scan finished. You need to use btmgmt and not hcitool. Using hcitool messes with raw HCI packets. The kernel logic will always overwrite these as it sees fit.

To allow simultaneous states, someone would have to work on that and figure out which chips support what. Once that is done, there is no problem in lifting some of the restrictions we imposed.

> The reason I want is to have a GATT client and server at the same time.

Actually that has never been a problem. You can have a GATT client and server at the same time and most likely you do already anyway. The question you are asking is if you can be in central and peripheral role at the same time.

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
