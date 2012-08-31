Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2567651.ypxvMR3dxG@uw000953>
References: <1346402185-9487-1-git-send-email-szymon.janc@tieto.com>
	<1346402185-9487-4-git-send-email-szymon.janc@tieto.com>
	<CAJdJm_NpsHV77wKHd9RkCoVKoYt1RRaOQbLaXt_fCJ9tS3mcwQ@mail.gmail.com>
	<2567651.ypxvMR3dxG@uw000953>
Date: Fri, 31 Aug 2012 08:12:13 -0400
Message-ID: <CAJdJm_N_qkhnPAZp459MJVSou2HR66r4OtBcz=cgM4xyUi+zPg@mail.gmail.com>
Subject: Re: [RFC 03/15] sdp: Use helper functions instead of bt_get_unaligned macro
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Aug 31, 2012 at 7:49 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> >         case SDP_INT16:
>> > -               d->val.int16 = bt_get_unaligned((int16_t *) value);
>> > +               d->val.int16 = bt_get_16(value);
>> >                 d->unitSize += sizeof(int16_t);
>> >                 break;
>>
>> Is this safe? You are assigning a unsigned type (return value from
>> bt_get_16()) to a signed one. Same applies for SDP_INT32 and SDP_INT64
>
> Mixing signed and unsigned could introduce some problem when you interpret data (e.g. in
> comparison), but here value will be simply assigned.
>
> I could add an explicit cast here (as this might bother some lint-like tools) if you prefer.

I don't think it is necessary (I was just confirming if it was safe
and intentional), so I'll leave to those who will apply your patches
:)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
