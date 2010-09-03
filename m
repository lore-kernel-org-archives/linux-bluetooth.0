Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4C804F5B.3010108@aircable.net>
References: <1283436253-9850-1-git-send-email-luiz.dentz@gmail.com>
	<4C804F5B.3010108@aircable.net>
Date: Fri, 3 Sep 2010 10:18:46 +0300
Message-ID: <AANLkTi=gHZVsfLbg2E4ZLCDZFqf0mGU7BC8pCfPAw4DT@mail.gmail.com>
Subject: Re: [PATCH] Make sure discovery don't interfere with bonding
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Manuel Naranjo <manuel@aircable.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Manuel,

On Fri, Sep 3, 2010 at 4:28 AM, Manuel Naranjo <manuel@aircable.net> wrote:
>  Luiz,
>>
>> In situation where the user application keep a discovery session while
>> bonding with a device it may cause a delay, or even timeout, due to the
>> number of the inquiry responses that the controller has to process.
>>
>> Since the discovery can be shared between many applications it may not be
>> possible to simple require to each application to stop their discovery
>> before trying to pair with a device, so to fix this bluetoothd now
>> suspends the discovery while bonding, resuming when completed.
>
> Stupid question but... Any way this is related to my seg faults during sdp
> resolving problems? I haven't tried to fix it in a while, so far I'm ok with
> a stupid cron rule which revives bluetoothd if it crashes, but I would
> prefer a better solution.

I don't think it fixes your problem, but you better check if
bluetoothd is still crashing as before, apparently nobody else is
having the same problem so it is quite tricky to resolve it.

Regards,

-- 
Luiz Augusto von Dentz
Computer Engineer
