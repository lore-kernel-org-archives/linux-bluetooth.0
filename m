Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <536296DB-E012-42F6-8C83-003DA67AB524@holtmann.org>
References: <1399545077-9344-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1399545077-9344-2-git-send-email-lukasz.rymanowski@tieto.com>
	<536296DB-E012-42F6-8C83-003DA67AB524@holtmann.org>
Date: Fri, 9 May 2014 00:26:23 +0200
Message-ID: <CAMudyAtHyQCuj9FEnVXgCsgyxKcNjzFrBMCFojv4RLZ=SbKVPg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] doc: Introduce Start/Stop Connection Monitor
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 8 May 2014 22:33, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Lukasz,
>
>> This patch introduces device method to start and stop connection monitor
>> and two new device properties ConnectionRSSI, ConnectionTXPower and
>> ConnectionTXPowerMax.
>>
>> ConnectionRSSI and ConnectionTXPower  are tracked when monitor is active
>
> lets leave this until we have figure out the kernel API for this. We are still going forth and back on that.

Whatever way we choose to get those data from the kernel, I have
feeling that this API will work with.
Adding those information as properties of device keep consistency with
existing API(similar to RSSI).
I made those properties optional so we don't have to have it now.

The only thing we could think of is if we want to have poll method as
Scott proposed or some kind of Monitor as it is now proposed and
roughly discussed with Szymon and Johan.
Any comment?

Please also keep in mind that the kernel mgmt API will not be present
on many systems for at least 6 month.
>
Ok I understand. Anyway, If there is no major issues with that api, It
would be very helpful if we could fix it.

> Regards
>
> Marcel
>
Thanks and BR
Lukasz
