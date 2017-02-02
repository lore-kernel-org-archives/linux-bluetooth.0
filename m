Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] tools/btattach: Add detach option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAL9uMOEvFH-mi23U_9SYDcQ7oXJQMB5cy4TL0VKp6OL7Si1ePg@mail.gmail.com>
Date: Thu, 2 Feb 2017 04:25:46 +0100
Cc: Carlo Caione <carlo@caione.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Message-Id: <02A0165B-9058-4663-9809-E7DA030E0878@holtmann.org>
References: <20170201171431.9633-1-carlo@caione.org>
 <D130D4FB-7AF0-46BF-9BC7-D9050C596E1A@holtmann.org>
 <CAL9uMOEvFH-mi23U_9SYDcQ7oXJQMB5cy4TL0VKp6OL7Si1ePg@mail.gmail.com>
To: Carlo Caione <carlo@endlessm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Carlo,

>>> ---
>>> tools/btattach.c | 10 +++++++++-
>>> 1 file changed, 9 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/tools/btattach.c b/tools/btattach.c
>>> index 5adbc8d..f1f115d 100644
>>> --- a/tools/btattach.c
>>> +++ b/tools/btattach.c
>>> @@ -194,6 +194,7 @@ static void usage(void)
>>>              "\t-P, --protocol <proto> Specify protocol type\n"
>>>              "\t-S, --speed <baudrate> Specify which baudrate to use\n"
>>>              "\t-N, --noflowctl        Disable flow control\n"
>>> +             "\t-D, --detach           Open device and then fork\n"
>>>              "\t-h, --help             Show help options\n”);
>> 
>> And is this really a good idea. I think that I had removed all the fork calls from the standard tools. Mainly since we fail to maintain the signals and more important child signals correctly. So we quickly end up with zombies or orphaned processes. My thinking instead was to leave this to systemd to handle.
> 
> Interesting. Any pointer how to achieve that?
> The problem is that I have btattach called by a systemd unit file to
> download the firmware to the bluetooth transceiver. I also have
> another systemd unit that must be called strictly after btattach has
> done uploading the firmware. Since btattach is hanging on the port
> AFAIU there is no way I can tell exactly when it is done uploading the
> firmware. That's why I was adding this detach option, to mark the unit
> as 'Type=forking' and enforcing the ordering with
> 'Before=next.service`.
> Anything I am missing?

why do you need to know when the firmware uploading has completed? What hardware is this?

Regards

Marcel

