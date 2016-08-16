Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALe7QMAzxXfPi0tCR04dSKKBR=RUc2dLfT0qG8ckBqxk=VB2ew@mail.gmail.com>
References: <CALe7QMApaeG0orTAXL_s2VWeDnkG1af60Fp5Eu6U5SjhHitMvw@mail.gmail.com>
 <CABBYNZJgssL4rL2-p10wOHuMtMR20aH1aY7RHUNx+EdcUM3qAA@mail.gmail.com>
 <CALe7QMA-kexji4xo_P1usXg5JVE=BrqfxUJALa9Fd1Azv-ejJQ@mail.gmail.com> <CALe7QMAzxXfPi0tCR04dSKKBR=RUc2dLfT0qG8ckBqxk=VB2ew@mail.gmail.com>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Tue, 16 Aug 2016 09:46:30 +0200
Message-ID: <CAAEJBhKRK0sYo+FZNW9jOMX2ewV2He5XmpKptkkHW=bwRhNNww@mail.gmail.com>
Subject: Re: BlueZ5: Unable to re-pair device after unpairing
To: Wilson Perez <wilsonpp@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wilson,

On 15 August 2016 at 15:23, Wilson Perez <wilsonpp@gmail.com> wrote:
> Thank you, Luiz.  I have tested successfully removing the device
> manually and paring afterwards.  Is there a way to allow either by
> configuration or patch subsequent pairing requests of already paired
> devices in a Bluetooth controller?  This condition would take place
> when, say, a phone is paired with a Bluetooth controller, later
> unpaired by the phone's internal capabilities, and finally attempting
> to pair once again with the Bluetooth controller.  Bluez 3.36 allowed
> this capability.

There is " [RFC 0/5] Rebond support" series (from 2 weeks ago) that
tries to address that.
In general it extends Agent API with callback for getting user consent
for device re-pairing.

If you are interested feel free to comment/test on that series.

PS
no top posting please :)

>
> Thank you so much.
>
> Wilson
>
>
>
> On Mon, Aug 15, 2016 at 3:56 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> Hi Wilson,
>>
>> On Mon, Aug 15, 2016 at 5:22 AM, Wilson Perez <wilsonpp@gmail.com> wrote:
>> > I am using BlueZ 5.41 on ARM Linux 4,1,18 and would like to be able to
>> > pair a device that had previously been paired but then unpaired.  How
>> > can this be accomplished?
>>
>> You can do that by removing the device and then pairing again.
>>
>> --
>> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
pozdrawiam
Szymon K. Janc
