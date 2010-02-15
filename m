Return-Path: <cyrus@holtmann.org>
Subject: Re: API broken in bluez 4.61
From: Marcel Holtmann <marcel@holtmann.org>
To: Baptiste Mille-Mathias <baptiste.millemathias@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <920101ab1002150454t31c94b2bh4b1825b4d8ed0db9@mail.gmail.com>
References: <920101ab1002150454t31c94b2bh4b1825b4d8ed0db9@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Feb 2010 11:23:24 -0800
Message-ID: <1266261804.8849.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Baptiste,

> While packaging latest release of bluez, I seen the API compatibility
> was broken.
> hci_read_inquiry_transmit_power_level was removed and thus would have
> required to bump the soname.

I fixed it already and will make another release soon.

Regards

Marcel


