Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Device class not writeable via dbus
From: Marcus Redeker <marcus@openremote.org>
In-Reply-To: <5181722.aJ0IxrIXHx@uw000953>
Date: Thu, 16 Apr 2015 10:44:10 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <6241C49D-9ECB-47CA-9B40-2DF1846BD031@openremote.org>
References: <16972ECC-114B-4CA0-A2B1-1BE0FB115199@openremote.org> <1815811.8ZlaWYb6CG@leonov> <A1432115-C15B-4A07-BB90-E6A731C20B3B@openremote.org> <5181722.aJ0IxrIXHx@uw000953>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


>>> 
>>> You can configure CoD in main.conf
>>> [General]
>>> Class = 0x000100
>>> 
>>> Note the comment that only major and minor bits are considered. Service bits 
>>> are dynamically configured based on registered services.
>>> 
>>> 
>> True, but  I would like todo that through dbus and not manually and have to restart bluetoothd afterwards.
>> Any chance this can be done in the near future?
>> -Marcus
> Class of Device is rather static configuration as those describe form factor
> and that usually doesn't change.
> 
> Why do you need to change CoD on the fly?
> 
> PS
> Please don't top post on ML.
> -- 
> Best regards, 
> Szymon Janc

For home automation sometimes our home controller acta as a virtual keyboard and some devices need the coresponding major/minor device class or else they don’t show them during discovery.
Another user might wants to use his home controller to control bluetooth LE lights which are coming out more and more.
Or maybe Bluetooth LE (GATT) does not need the device class anymore ?
—Marcus

