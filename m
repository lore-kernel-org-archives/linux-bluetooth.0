Return-Path: <cyrus@holtmann.org>
Message-ID: <50642ED8.3090007@tieto.com>
Date: Thu, 27 Sep 2012 12:47:52 +0200
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 00/14] Thermometer watchers API change + fixes
References: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com> <CAJdJm_N3g2YN32dUo4Af9zBnaVPAcTW5MgF9O-mXz8y_Dt23CQ@mail.gmail.com>
In-Reply-To: <CAJdJm_N3g2YN32dUo4Af9zBnaVPAcTW5MgF9O-mXz8y_Dt23CQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On 09/25/2012 05:21 PM, Anderson Lizardo wrote:
> Hi Andrzej,
>
> On Tue, Sep 25, 2012 at 10:52 AM, Andrzej Kaczmarek
> <andrzej.kaczmarek@tieto.com> wrote:
>> Hi,
>>
>> Here's series of patches to move watchers from per-device to per-adapter
>> interface (basically the same as done for HRP, see other series of patches).
>> This applies to both final and intermediate temperature watchers - once
>> watcher is registered, all connected devices are setup to send measurement
>> notifications and the opposite when last watcher is unregistered.
>>
>> This major change is done in patches 1-6.
>>
>> Patches 7-11 contain some code and documentation refactoring, i.e. to
>> remove duplicated code.
>>
>> Patches 12-14 are trival coding style fixes.
>>
>> Unfortunately, I wasn't able to fully test this code due to lack of proper
>> thermometer device and sample device from CC2540 devkit does not quite
>> work as expected (e.g. I can see CCC is written properly when watcher is
>> registered but remote does not send any indications for unknown reason).
>
> Unfortunately, the thermometer demo app (at least on TI's BLE stack
> v1.1 installation) has several bugs. I haven't tested yet the latest
> release (1.2.1), which version are you using?

1.2 but downloaded 1.2.1 and thermometer demo app didn't change so it 
still does not work.

> Do you have access to PTS? You could test with it as well.

I currently don't have BLE dongle for PTS but will test as soon as I 
have one.

> Maybe we should consider implementing a simple Thermometer role in
> BlueZ for testing purposes. It is a relatively simple profile.

So you mean something like optional org.bluez.ThermometerSensor 
interface on adapter, similar to what is done for reporter role for 
Proximity?

BR,
Andrzej
