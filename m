Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110429175625.GA29649@jh-x301>
References: <1304030070-6575-1-git-send-email-claudio.takahasi@openbossa.org>
	<1304030070-6575-2-git-send-email-claudio.takahasi@openbossa.org>
	<BANLkTimm=CVbBrLEPWf8Q0BgvtMmZaxNBg@mail.gmail.com>
	<BANLkTin=vjdpnB3v9-AfXwPjvGV+F1wP4Q@mail.gmail.com>
	<20110429175625.GA29649@jh-x301>
Date: Fri, 29 Apr 2011 18:02:42 -0300
Message-ID: <BANLkTins2aazbKKYWzqx8fAfCyFvDH5xgA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Remove wrong checking for legacy devices
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

So please ignore this patch.

On Fri, Apr 29, 2011 at 2:56 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Fri, Apr 29, 2011, Claudio Takahasi wrote:
>> > On Fri, Apr 29, 2011 at 1:34 AM, Claudio Takahasi
>> > <claudio.takahasi@openbossa.org> wrote:
>> >> Infer that the found device is a legacy device based on the presence
>> >> of its name in the storage is wrong.
>> >> ---
>> >>  src/event.c |    2 --
>> >>  1 files changed, 0 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/src/event.c b/src/event.c
>> >> index 5373e33..b873000 100644
>> >> --- a/src/event.c
>> >> +++ b/src/event.c
>> >> @@ -481,8 +481,6 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
>> >>
>> >>        if (data)
>> >>                legacy = FALSE;
>> >> -       else if (name == NULL)
>> >> -               legacy = TRUE;
>> >>        else if (read_remote_features(local, peer, NULL, features) == 0) {
>> >>                if (features[0] & 0x01)
>> >>                        legacy = FALSE;
>> >> --
>> >
>> > That was some use of it, but I can't remember now, maybe some broken
>> > stack which has feature bits broken or we do actually infer if we ever
>> > connect to the device before trying to read its features from the
>> > storage.
>> >
>> >
>> > --
>> > Luiz Augusto von Dentz
>> > Computer Engineer
>> >
>>
>> I found the commit that introduced this code, but it is still not clear to me:
>> 989c60c0b9c96edf1fbdf80356abf05bac336673
>
> I think the logic has gone like this: we get the remote features as a
> side effect of a successful remote name request, so by checking for the
> name first we don't do an unnecessary file-system lookup.

I got the idea, I will keep the same approach in the discovery cleanup patches.

So, if I understood correctly, in the case that it is the first the
device is seen(name is unknown) and EIR data is not sent the
legacy=TRUE will be emitted.
In the first connection, the remote features will be retrieved
"automatically" by the kernel and user space will set "legacy"
variable based on the features bits. The updated legacy value will be
emitted only in the next discovery session.

BR,
Claudio

>
>> BTW: why this information needs to be exposed through the DeviceFound() signal?
>> It is not used internally in the adapter.c source.
>
> It's useful for pairing UIs. If a device is expected to produce legacy
> pairing when calling CreatePairedDevice the UI can ask the user for the
> PIN *before* calling CreatePairedDevice and thereby eliminate the risk of
> user response timeout locally.
>
> Johan
>
