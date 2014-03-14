Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_Pb4z66BNEJmOgPSOm88VSYq4UNSaNkxv2=iRUebPFYgA@mail.gmail.com>
References: <1394597040-4483-1-git-send-email-armansito@chromium.org>
	<CAJdJm_Pb4z66BNEJmOgPSOm88VSYq4UNSaNkxv2=iRUebPFYgA@mail.gmail.com>
Date: Fri, 14 Mar 2014 10:48:21 -0700
Message-ID: <CAHrH25Tbee73ibjMUSL61EzMm_ArLE9TBbjzAsr16LX8EKFZjg@mail.gmail.com>
Subject: Re: [RFC BlueZ 0/2] Initial D-Bus GATT client API implementation.
From: Arman Uguray <armansito@chromium.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

>> I'm working on the GATT client API and I have an initial implementation that
>> exposes basic GATT service and characteristic objects via D-Bus. Before I go
>> any further in the implementation, I wanted to get some feedback on whether or
>> not I've been taking the right approach so far. Also, since this is the first
>> time I'm contributing to BlueZ, there might be some general style/convention
>> issues that I would like to get corrected sooner than later :)
>
> First of all, sorry about the delay on reviewing your patches. Claudio
> and myself have been busy on our patches related to GATT server API
> which is taking most of our time available for BlueZ tasks.

Not a problem at all.

>>   6. The first patch introduces a change to the way device_browse_primary gets
>>   called in device.c:att_connect_cb; the existing code doesn't do primary
>>   service discovery unless (as far as I understand) the connect request came
>>   over D-Bus, so an auto-connect won't discover remote GATT services, for
>>   example. I made a change here, not because I intended to change that code
>>   path, but because I was curious why it was done the way it is.
>
> I will comment inline on the other two messages, but this last point
> is not clear to me. What do you mean by "auto-connect"? What are the
> exact steps to reproduce this?

So, it appears to me that if bluez finds a device and caches it (I've
connected to it once) and I power off the adapter and then back on, it
will try to connect to it automatically, unless I have explicitly
disconnected from the device. In this case bluez doesn't rediscover
the services on the device, as it already caches all the UUIDs. I will
make further comments on the patch itself.
