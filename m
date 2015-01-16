Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: Customize advertising transmit power
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAB0gXHqazvF9nxvjgXb5+26H++AjV42vtJiE5FuB-GjvhstsGA@mail.gmail.com>
Date: Fri, 16 Jan 2015 08:59:00 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <08A832C2-C34F-4CC0-9A84-1773BA9E4FFC@holtmann.org>
References: <CAB0gXHqazvF9nxvjgXb5+26H++AjV42vtJiE5FuB-GjvhstsGA@mail.gmail.com>
To: Alessandro Montanari <alemonty88@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alessandro,

> I am using BlueZ to advertise iBeacons and I would like to change the
> advertising transmit power in order to reduce the range of
> discoverability of the beacon (e.g. 1-2 meters).
> Is there a way to set this parameter?

there is no standard HCI command for this. You would need to go and ask your chip manufacturer for a vendor specific one.

Regards

Marcel

