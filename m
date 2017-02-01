Return-Path: <carlo@endlessm.com>
MIME-Version: 1.0
In-Reply-To: <D130D4FB-7AF0-46BF-9BC7-D9050C596E1A@holtmann.org>
References: <20170201171431.9633-1-carlo@caione.org> <D130D4FB-7AF0-46BF-9BC7-D9050C596E1A@holtmann.org>
From: Carlo Caione <carlo@endlessm.com>
Date: Wed, 1 Feb 2017 23:19:19 +0100
Message-ID: <CAL9uMOEvFH-mi23U_9SYDcQ7oXJQMB5cy4TL0VKp6OL7Si1ePg@mail.gmail.com>
Subject: Re: [PATCH] tools/btattach: Add detach option
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Carlo Caione <carlo@caione.org>, Bluez mailing list <linux-bluetooth@vger.kernel.org>,
	Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Feb 1, 2017 at 8:41 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Carl,
>
>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>
> user space does not use signed off by statements.
>
>> ---
>> tools/btattach.c | 10 +++++++++-
>> 1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/btattach.c b/tools/btattach.c
>> index 5adbc8d..f1f115d 100644
>> --- a/tools/btattach.c
>> +++ b/tools/btattach.c
>> @@ -194,6 +194,7 @@ static void usage(void)
>>               "\t-P, --protocol <proto> Specify protocol type\n"
>>               "\t-S, --speed <baudrate> Specify which baudrate to use\n"
>>               "\t-N, --noflowctl        Disable flow control\n"
>> +             "\t-D, --detach           Open device and then fork\n"
>>               "\t-h, --help             Show help options\n=E2=80=9D);
>
> And is this really a good idea. I think that I had removed all the fork c=
alls from the standard tools. Mainly since we fail to maintain the signals =
and more important child signals correctly. So we quickly end up with zombi=
es or orphaned processes. My thinking instead was to leave this to systemd =
to handle.

Interesting. Any pointer how to achieve that?
The problem is that I have btattach called by a systemd unit file to
download the firmware to the bluetooth transceiver. I also have
another systemd unit that must be called strictly after btattach has
done uploading the firmware. Since btattach is hanging on the port
AFAIU there is no way I can tell exactly when it is done uploading the
firmware. That's why I was adding this detach option, to mark the unit
as 'Type=3Dforking' and enforcing the ordering with
'Before=3Dnext.service`.
Anything I am missing?


--=20
Carlo Caione  |  +39.340.80.30.096  |  Endless
