Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <56006696.3030200@steev.me.uk>
References: <56006696.3030200@steev.me.uk>
Date: Mon, 21 Sep 2015 16:02:53 -0600
Message-ID: <CAASrBQmWuCvyi6-DNAVvaaV2eFSeEVCy2Sr8QzPyy0Ckt0TQbg@mail.gmail.com>
Subject: Re: BLE: dbus doesn't show GATT characteristics
From: Mark Rages <markrages@gmail.com>
To: Steven Davies <steev@steev.me.uk>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Sep 21, 2015 at 2:20 PM, Steven Davies <steev@steev.me.uk> wrote:
> I'm having a problem using BLE through dbus where the GATT services
> don't appear after a BLE device has been found during a scan. What is
> available through dbus is a Device1 node with the correct address and a
> Name property of the name which was sent in the advertising beacons -
> however that's the only node available in the tree.

Are you running bluetoothd with the experimental (-E) flag?

Regards,
Mark
markrages@gmail
