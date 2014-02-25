Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [RFC v11 06/15] Bluetooth: Introduce LE auto connection infrastructure
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CACJA=fW-A8GbT55_W43Xk50bu5nzwkPjxDB7fuMBKf0h=mmD7Q@mail.gmail.com>
Date: Tue, 25 Feb 2014 09:43:08 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <E89B584B-C292-4D4E-A92E-1F19A0CE0AD9@holtmann.org>
References: <1393281061-14320-1-git-send-email-andre.guedes@openbossa.org> <1393281061-14320-7-git-send-email-andre.guedes@openbossa.org> <20140225042337.GA27803@localhost.P-661HNU-F1> <CACJA=fW-A8GbT55_W43Xk50bu5nzwkPjxDB7fuMBKf0h=mmD7Q@mail.gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

>>> +             if (hci_update_random_address(&req, false, &own_addr_type))
>>> +                     return;
>> 
>> Don't we want require_privacy = true here?
> 
> require_privacy = true enables non-resolvable address. Since this is a
> passive scanning (no SCAN_REQ is sent), I don't think this is
> required.

that is correct, it is not strictly speaking needed. However I would prefer we set this to true anyway and add a proper comment for it like we do with the other places.

Regards

Marcel

