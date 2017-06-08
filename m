Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH BlueZ 00/31] monitor: Bluetooth 5 HCI commands support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
Date: Thu, 8 Jun 2017 10:47:23 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8EDFD00A-7CE8-4822-B739-6F6754F8461A@holtmann.org>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
To: =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

> this set adds support for decoding Bluetooth 5 commands as listed below.
> 
> Michał Narajowski (31):
>  monitor: Add LE Enhanced Receiver Test decoding
>  monitor: Add LE Enhanced Transmitter Test decoding

these two should be one patch.

>  monitor: Add LE Set Advertising Set Random Address decoding
>  monitor: Add LE Set Extended Advertising Parameters decoding
>  monitor: Add LE Set Extended Advertising Data decoding
>  monitor: Add LE Set Extended Scan Response Data decoding
>  monitor: Add LE Set Extended Advertising Enable decoding
>  monitor: Add LE Read Maximum Advertising Data Length decoding
>  monitor: Add LE Read Number of Supported Advertising Sets decoding
>  monitor: Add LE Remove Advertising Set decoding
>  monitor: Add LE Clear Advertising Sets decoding

Move these all into one patch.

>  monitor: Add LE Set Periodic Advertising Parameters decoding
>  monitor: Add LE Set Periodic Advertising Data decoding
>  monitor: Add LE Set Periodic Advertising Enable decoding

And make these 3 one patch.

>  monitor: Add LE Set Extended Scan Parameters decoding
>  monitor: Add LE Set Extended Scan Enable decoding
>  monitor: Add LE Extended Create Connection decoding

These 3 can also go into one patch.

>  monitor: Add LE Periodic Advertising Create Sync decoding
>  monitor: Add LE Periodic Advertising Create Sync Cancel decoding
>  monitor: Add LE Periodic Advertising Terminate Sync decoding
>  monitor: Add LE Add Device To Periodic Advertiser List decoding
>  monitor: Add LE Remove Device From Periodic Advertiser List decoding
>  monitor: Add LE Clear Periodic Advertiser List decoding
>  monitor: Add LE Read Periodic Advertiser List Size decoding

And these can go into one patch as well.

>  monitor: Add LE Read Transmit Power decoding
>  monitor: Add LE Read RF Path Compensation decoding
>  monitor: Add LE Write RF Path Compensation decoding

Put these 3 into one patch.

>  monitor: Add LE Set Privacy Mode decoding

Keep this separate.

>  monitor: Add LE Extended Advertising Report Event decoding
>  monitor: Add LE Advertising Set Terminated Event decoding
>  monitor: Add LE Scan Request Received Event decoding

And feed the events into the appropriate block. for their commands.

Regards

Marcel

