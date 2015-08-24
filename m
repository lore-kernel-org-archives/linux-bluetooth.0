Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Aug 2015 11:30:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel Lenski <dlenski@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: detecting BLE compatibility of an adapter?
Message-ID: <20150824083059.GA504@t440s.lan>
References: <CAOw_LSH1_BjH28+Kn2vwxTrrF+4WBgXCn3FM27rubmCYximR0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOw_LSH1_BjH28+Kn2vwxTrrF+4WBgXCn3FM27rubmCYximR0Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Sat, Aug 22, 2015, Daniel Lenski wrote:
> Does Bluez provide a way to detect the compatibility of a Bluetooth
> adapter with Bluetooth 4.0/Low Energy?

That would be the mgmt settings bit number 9 (see doc/mgmt-api.txt).
bluetoothd keeps track of this (and enables it automatically if
available) and you should also be able to see it e.g. with "btmgmt
info". The mgmt interface tells you both whether it's supported as well
as whether it's enabled.

Johan
