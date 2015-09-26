Return-Path: <cyrus@holtmann.org>
Subject: Re: Unable to connect to device after connected_callback() has run
References: <5606F366.3040207@steev.me.uk>
 <CAD0=r8zVkFUQC7Xw3i5MG-oees0tScSJz=5Toao=rSNo4xckrA@mail.gmail.com>
 <5606F9C4.2060307@steev.me.uk>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
From: Steven Davies <linux-bluetooth-list@steev.me.uk>
Message-ID: <5607004C.7020002@steev.me.uk>
Date: Sat, 26 Sep 2015 21:30:04 +0100
MIME-Version: 1.0
In-Reply-To: <5606F9C4.2060307@steev.me.uk>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

>>> Following on from my problems with GATT discovery, I now have another
>>> issue: I have a Python program which waits for the Connected=True
>>> PropertiesChanged callback from dbus, then sends a WriteValue to a
>>> GattCharacteristic1 interface.
>>>
>>> The issue is that immediately after the Connected=True message comes
>>> back, a WriteValue fails with "DBusException: org.bluez.Error.Failed:
>>> Not connected". However, calling the WriteValue a few seconds later
>>> executes correctly.
>>
>> I had same issue, and I sent patches to fix it around 2 weeks ago.
>> Which version of  bluetoothd are you using ?
>> Can you retry when running from repository master ?
> 
> Apologies for clicking send too soon on the last message. I can see you
> and Luiz created patches for this so I'll pull the latest from master
> and try. Currently I'm using the 5.34 release. I'll report back once
> I've done that.

Yep - worked as described. With the latest from bluez master I don't see
any issues. Roll on 5.35!

Regards
Steven Davies
