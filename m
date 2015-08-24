Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: detecting BLE compatibility of an adapter?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAOw_LSH=yftdH7wNAfjOcDdq=76DsxwY544eZRXv0AxRTTaO7g@mail.gmail.com>
Date: Mon, 24 Aug 2015 11:09:45 -0700
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <65E45719-1EA7-4EE0-A77D-5CFBD4A424F5@holtmann.org>
References: <CAOw_LSH1_BjH28+Kn2vwxTrrF+4WBgXCn3FM27rubmCYximR0Q@mail.gmail.com> <20150824083059.GA504@t440s.lan> <CAOw_LSH=yftdH7wNAfjOcDdq=76DsxwY544eZRXv0AxRTTaO7g@mail.gmail.com>
To: Daniel Lenski <dlenski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

>>> Does Bluez provide a way to detect the compatibility of a Bluetooth
>>> adapter with Bluetooth 4.0/Low Energy?
>> 
>> That would be the mgmt settings bit number 9 (see doc/mgmt-api.txt).
>> bluetoothd keeps track of this (and enables it automatically if
>> available) and you should also be able to see it e.g. with "btmgmt
>> info". The mgmt interface tells you both whether it's supported as well
>> as whether it's enabled.
>> 
> 
> Thank you!
> 
> In the meantime, I found another way to do it, using
> hci_read_local_features() and checking for the appropriate bit from
> lmp_features_map, specifically features[4]&0x40.
> 
> Is there any reason I should prefer one approach over the other?

raw HCI access is a bad idea. Do not do that. The btmgmt info command is what gives you most information.

Index list with 1 item
hci0:	Primary controller
	addr 98:58:8A:xx:xx:xx version 6 manufacturer 15 class 0x000000
	supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr hs le advertising secure-conn debug-keys privacy configuration static-addr 
	current settings: powered bondable ssp br/edr le secure-conn 
	name BlueZ
	short name 
hci0:	Configuration options
	supported options: public-address 
	missing options:

It will easily tell you if LE is supported and also if it has been enabled.

The raw features are exposed via /sys/kernel/debug/bluetooth/hci0/features file. However that is not a stable API. That is for manual debugging.

Regards

Marcel

