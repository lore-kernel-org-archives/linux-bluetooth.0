Return-Path: <maxtram95@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ=BoxT2gCXBG8fLPHmMEUnxUtgEhkR8jDT==yrEFyY2w@mail.gmail.com>
References: <1450114061-19629-1-git-send-email-maxtram95@gmail.com> <CABBYNZJ=BoxT2gCXBG8fLPHmMEUnxUtgEhkR8jDT==yrEFyY2w@mail.gmail.com>
From: Maxim Mikityanskiy <maxtram95@gmail.com>
Date: Tue, 15 Dec 2015 19:27:10 +0200
Message-ID: <CAKErNvogWAEOxgQUjUFK2K7A_24e7WN6PCRBqvno7G5=WuUpOg@mail.gmail.com>
Subject: Re: [PATCH] sbc: don't try to initialize sbc parameters if no data
 was decoded
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

2015-12-15 18:51 GMT+02:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> Hi Maxim,
>
> On Mon, Dec 14, 2015 at 3:27 PM,  <maxtram95@gmail.com> wrote:
>> From: Maxim Mikityanskiy <maxtram95@gmail.com>
>>
>> If the first data chunk passed to sbc_decode was not long enough and
>> didn't contain full SBC packet, don't try to initialize codec parameters
>> with random values.
>>
>> Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
>> Cc: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> The patch is for SBC library located at https://git.kernel.org/cgit/bluetooth/sbc.git/
>
> We don't use Signed-off-by in userspace.

OK, I'll consider it.

>>
>>  sbc/sbc.c | 34 ++++++++++++++++++----------------
>>  1 file changed, 18 insertions(+), 16 deletions(-)
>>
>> diff --git a/sbc/sbc.c b/sbc/sbc.c
>> index 606f11c..7da476b 100644
>> --- a/sbc/sbc.c
>> +++ b/sbc/sbc.c
>> @@ -1222,22 +1222,24 @@ SBC_EXPORT ssize_t sbc_decode(sbc_t *sbc, const void *input, size_t input_len,
>>
>>         framelen = priv->unpack_frame(input, &priv->frame, input_len);
>>
>> -       if (!priv->init) {
>> -               sbc_decoder_init(&priv->dec_state, &priv->frame);
>> -               priv->init = true;
>> -
>> -               sbc->frequency = priv->frame.frequency;
>> -               sbc->mode = priv->frame.mode;
>> -               sbc->subbands = priv->frame.subband_mode;
>> -               sbc->blocks = priv->frame.block_mode;
>> -               sbc->allocation = priv->frame.allocation;
>> -               sbc->bitpool = priv->frame.bitpool;
>> -
>> -               priv->frame.codesize = sbc_get_codesize(sbc);
>> -               priv->frame.length = framelen;
>> -       } else if (priv->frame.bitpool != sbc->bitpool) {
>> -               priv->frame.length = framelen;
>> -               sbc->bitpool = priv->frame.bitpool;
>> +       if (framelen >= 0) {
>> +               if (!priv->init) {
>> +                       sbc_decoder_init(&priv->dec_state, &priv->frame);
>> +                       priv->init = true;
>> +
>> +                       sbc->frequency = priv->frame.frequency;
>> +                       sbc->mode = priv->frame.mode;
>> +                       sbc->subbands = priv->frame.subband_mode;
>> +                       sbc->blocks = priv->frame.block_mode;
>> +                       sbc->allocation = priv->frame.allocation;
>> +                       sbc->bitpool = priv->frame.bitpool;
>> +
>> +                       priv->frame.codesize = sbc_get_codesize(sbc);
>> +                       priv->frame.length = framelen;
>> +               } else if (priv->frame.bitpool != sbc->bitpool) {
>> +                       priv->frame.length = framelen;
>> +                       sbc->bitpool = priv->frame.bitpool;
>> +               }
>
> Im fine with the change but I would prefix that you check the framelen
> separately e.g.:
>
> if (framelen < 0) {
>   return framelen;
> }
>
> There is probably no use to continue if unpack_frame has failed.

Actually, we can't just return immediately, because we will lose an
assignment "*written = 0;" that follows this block of code. And
putting that assignment also in "if (framelen < 0)" will lead to code
duplication. We could place that assignment before the check for
framelen, but it will change the behavior when output == NULL (now
*written is not touched if output == NULL).

That's why I put that big "if (framelen >= 0)" around that block of
code; any other options alter the behavior of the function.

>>         }
>>
>>         if (!output)
>> --
>> 2.5.4 (Apple Git-61)
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz
