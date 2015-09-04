Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGQ70evEYOK7Zo_eG-A2vC2oVFAu3-KdjWLv=kqQfhtJ6hAXhg@mail.gmail.com>
References: <CAGQ70euRR__Vv25Z9kvj6EfXyFruU36sYC82RrN8ijg_rdpYUA@mail.gmail.com>
	<CAGQ70evEYOK7Zo_eG-A2vC2oVFAu3-KdjWLv=kqQfhtJ6hAXhg@mail.gmail.com>
Date: Fri, 4 Sep 2015 09:53:58 +0800
Message-ID: <CAGQ70evf=jLEpmzvDoOuu+FNHhkA-VYZ=rsuECNJsvOXUO6o9g@mail.gmail.com>
Subject: Re: SMP Security Request breaks previously working bluetooth mouse
From: Oon-Ee Ng <ngoonee.talk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Also - the bugzilla report to anyone interested -
https://bugzilla.kernel.org/show_bug.cgi?id=104011

On Fri, Sep 4, 2015 at 9:45 AM, Oon-Ee Ng <ngoonee.talk@gmail.com> wrote:
> The report below is still an issue with linux-4.2
>
> On Tue, Sep 1, 2015 at 3:19 PM, Oon-Ee Ng <ngoonee.talk@gmail.com> wrote:
>> I refer (to the best of my knowledge) to the patch submitted in [1].
>>
>> When upgrading from 4.1.5 to 4.1.6 (Arch Linux), my Lenovo N700
>> Bluetooth mouse stops working. Downgrading fixes, hence unlikely to be
>> a hardware issue.
>>
>> When on 4.1.6 (bugged version) dmesg spams this every 3 minutes or so:-
>> Bluetooth: SMP security requested but not available
>>
>> Please advise on additional details which may be required.
>>
>> [2] is my original bug report in my distro's channel, including the
>> above details in a bit more verbose form.
>>
>> [1] - https://lkml.org/lkml/2015/8/14/369
>> [2] - https://bugs.archlinux.org/task/46006
