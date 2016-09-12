Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Option to disable filtering of duplicate LE ADV
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160910131522.GA27849@t440s.P-661HNU-F1>
Date: Mon, 12 Sep 2016 08:47:19 +0200
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Brennan Ashton <brn@deako.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <608EEAD3-684A-4120-8694-B1777891447E@holtmann.org>
References: <1473451216.28342.4.camel@deako.com> <CABBYNZLwu-PG+Vwrzx4-tPufvre7tjgZxJmgk=VaSCi3qttAjA@mail.gmail.com> <20160910131522.GA27849@t440s.P-661HNU-F1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>> Right now in all of the le_scan functions filter_dup is set to
>>> LE_SCAN_FILTER_DUP_ENABLE.  This is not always desired with beacons as
>>> the content may change.  I can force this by sending the HCI commands
>>> to enable scanning without this filter, but then the mgmt api (and
>>> DBUS) cannot be used for scanning.
>>> 
>>> I was wondering if people had thoughts on making this configurable?
>> 
>> Check out the SetDiscoveryFilter:
>> 
>> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/adapter-api.txt
>> 
>> When that is used it will not enable duplicated filter and in fact is
>> the only way to discover beacons which don't have discoverable flags
>> sets e.g. broadcaster.
> 
> Actually Brennan is right that none of these methods disable duplicate
> filtering. All of the places in the kernel that set the LE scan
> parameters explicitly enable duplicate filtering. I suppose we should
> seriously consider extending the mgmt API to allow performing LE scan
> without the duplicate filtering. Right now the only way to do that is
> through raw HCI access.

however when a driver sets the strict duplicate filtering quirk, then scanning will be restarted and thus new advertising data can be found.

Regards

Marcel

