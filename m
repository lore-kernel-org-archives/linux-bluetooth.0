Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH BlueZ] core: retry connect_dbus() several times
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140228073113.GA3771@adam-laptop>
Date: Thu, 27 Feb 2014 23:40:16 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8CBFABF2-2409-43DD-B870-7519901FE686@holtmann.org>
References: <1393571362-27898-1-git-send-email-adam8157@gmail.com> <04802ECE-6B8D-4DF4-BFFD-EABBD42BD30F@holtmann.org> <20140228073113.GA3771@adam-laptop>
To: Adam Lee <adam8157@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

>>> Sometimes the hardware, especially which needs firmware patching, is not
>>> yet ready when connect_dbus().
>> 
>> this makes no sense. Connecting to D-Bus has nothing to do with
>> firmware patching. What are you exactly fixing here?
> 
> connect_dbus() fails sometimes with Intel 7260 bluetooth, sleeping 0.5s
> before executing bluetoothd workarounds it. I assume the firmware
> patching slows down hardware initialization then fails to connect.
> 
> Any other possibility? I'm not a D-Bus guru :)

it has nothing to do with D-Bus. You need to find the root cause.

Regards

Marcel

