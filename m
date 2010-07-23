Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100720093732.GA3210@jh-x301>
References: <AANLkTimYuaveU7To6oLdtDLlxXIky1KU7QHMTD47Mwwh@mail.gmail.com>
	<20100720093732.GA3210@jh-x301>
Date: Fri, 23 Jul 2010 10:03:25 +0800
Message-ID: <AANLkTikYDIOyiXLTst3R3K-TC81pMFfvtbPpmRwJqVan@mail.gmail.com>
Subject: Re: Virtual cable unplug not supported in BlueZ?
From: Liang Bao <tim.bao@gmail.com>
To: Liang Bao <tim.bao@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adapter.RemoveDevice() also removes the pair information according to
the document doc/adapter-api.txt. However, unplug a virtual cable in
HID spec doesn't mean unpair. Anyway, let me check the source once
again. Thanks.

2010/7/20 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi,
>
> On Tue, Jul 20, 2010, Liang Bao wrote:
>> I have a question on "Virtual Cable Unplug" in current BlueZ version.
>>
>> Currently BlueZ doesn't expose a D-Bus method in input/device.c for
>> virtually unplug cable which is a mandatory requirement to pass
>> TC_HOS_HCR_BV_03_I. Actually the support in kernel is already there.
>> Can anyone give some insight to why this is not exposed at the DBUS
>> API level like Connect/Disconnect/GetProperties? Can I think the
>> reason behind this design is we only need one of "Disconnect" and
>> "VirtualUnplug" to allow user to disconnect?
>
> AFAIK the unplug should be sent when you do Adapter.RemoveDevice()
>
> Johan
>
