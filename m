Return-Path: <cyrus@holtmann.org>
Message-ID: <50698235.10804@tieto.com>
Date: Mon, 1 Oct 2012 13:44:53 +0200
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 00/14] Thermometer watchers API change + fixes
References: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com> <CAJdJm_N3g2YN32dUo4Af9zBnaVPAcTW5MgF9O-mXz8y_Dt23CQ@mail.gmail.com> <50642ED8.3090007@tieto.com> <CAJdJm_NLz-rd1w59pBDP_QMWKVcZ3-N0FMNqy1UCisBzZL-VNQ@mail.gmail.com>
In-Reply-To: <CAJdJm_NLz-rd1w59pBDP_QMWKVcZ3-N0FMNqy1UCisBzZL-VNQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On 09/27/2012 02:03 PM, Anderson Lizardo wrote:
> Hi Andrzej,
>
> On Thu, Sep 27, 2012 at 6:47 AM, Andrzej Kaczmarek
> <andrzej.kaczmarek@tieto.com> wrote:
>>> Maybe we should consider implementing a simple Thermometer role in
>>> BlueZ for testing purposes. It is a relatively simple profile.
>>
>>
>> So you mean something like optional org.bluez.ThermometerSensor interface on
>> adapter, similar to what is done for reporter role for Proximity?
>
> Yes. There has been some interest on the past on the mailing list from
> people willing to implement this role on BlueZ (although I have not
> heard anymore from them), so it would become not just a test plugin,
> but have an API that allows for BlueZ to expose some external
> thermometer measurements over LE. But for now a "dummy" thermometer
> which sends dummy measurements in various formats should be enough
> (probably enabled only with --enable-test so it is not installed in
> production).
>
> Do you have interest/time for working on something like this?

I could take a look on this in spare time, sure.

By "dummy" thermometer you mean separate plugin (dummythermometer or 
sth) which, once enabled, will register service in GATT and send dummy 
measurements when configured by remote? Or perhaps develop it inside 
thermometer profile (implemented as described above) so it can be 
changed into full blown thermometer role with API etc. later?

> BTW, I definitely plan to test both your HRP implementation and the
> HTP changes, but currently I'm working in other things... I'll let you
> know once I have these tested (probably with patches if I find any
> issues).

I should have BLE PTS dongle this week so will test both implementations 
as well in case you won't manage to do this until then.

BR,
Andrzej
