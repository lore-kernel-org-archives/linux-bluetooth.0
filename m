Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1292954574.14993.37.camel@sealablnx02.qualcomm.com>
References: <1292950724-4918-1-git-send-email-luiz.dentz@gmail.com>
	<1292954574.14993.37.camel@sealablnx02.qualcomm.com>
Date: Wed, 22 Dec 2010 11:05:31 +0200
Message-ID: <AANLkTinViWUu1jWkB+X1b5+mWSJCO7tdkdVbtvgOTuja@mail.gmail.com>
Subject: Re: [PATCH] sbc: detect when bitpool has changed
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Dec 21, 2010 at 8:02 PM, Brian Gix <bgix@codeaurora.org> wrote:
> Hello Luiz,
>
> On Tue, 2010-12-21 at 18:58 +0200, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
>>
>> ---
>>  sbc/sbc.c |    8 +++++---
>>  1 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/sbc/sbc.c b/sbc/sbc.c
>> index a6391ae..b3a7a09 100644
>> --- a/sbc/sbc.c
>> +++ b/sbc/sbc.c
>> @@ -965,7 +965,8 @@ ssize_t sbc_decode(sbc_t *sbc, const void *input, size_t input_len,
>>
>>       framelen = sbc_unpack_frame(input, &priv->frame, input_len);
>>
>> -     if (!priv->init) {
>> +     /* init if no previous frame was encode or bitpool has changed */
>> +     if (!priv->init || priv->frame.bitpool != sbc->bitpool) {
>>               sbc_decoder_init(&priv->dec_state, &priv->frame);
>>               priv->init = 1;
>
> I don't think it is a good idea to reinitialize the SBC decoder if a
> change in bitpool size is detected.
>
> The A2DP and AVDTP specifications do not allow most of the parameters to
> change from one frame to the next (mode, channels, subbands, blocks,
> allocation, frequency) but explicitly DO allow changes in bitpool size
> midstream.  This allows for Variable Bit Rate (VBR) streaming, and adds
> efficiency to the over-the-air link with no quality loss.  Also, the
> space required for decoding does not change just because the bitpool has
> changed, so re-initialization should not be required.
>
> The only things that should be different from one SBC frame to the next
> is the bitpool of course, and the framelen. That said, if a bitpool
> change is detected the only thing within that "IF" block that should be
> updated is:
> sbc->bitpool

You are mostly right, but we should also do priv->frame.length =
framelen to make sure sbc_get_frame_length return it properly.

>
> If any of the other afore mentioned parameters change, the stream should
> be terminated.
>
>>
>> @@ -1035,7 +1036,8 @@ ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
>>       if (written)
>>               *written = 0;
>>
>> -     if (!priv->init) {
>> +     /* init if no previous frame was encode or bitpool has changed */
>> +     if (!priv->init || priv->frame.bitpool != sbc->bitpool) {
>>               priv->frame.frequency = sbc->frequency;
>>               priv->frame.mode = sbc->mode;
>>               priv->frame.channels = sbc->mode == SBC_MODE_MONO ? 1 : 2;
>
> Same basic comment here, although it is perfectly allowable for the
> Encoder to not support VBR. However if the Encoder does change the
> bitpool, then the list of fields that need to be updated are:
> priv->frame.bitpool
> priv->frame.length
>
> But again, the sbc_encoder_init should *not* be re-run.  I would pull
> those two variables out of that IF block, and set them in their own IF
> block either directly before or directly after the !priv->init IF block.
>
>
>> @@ -1120,7 +1122,7 @@ size_t sbc_get_frame_length(sbc_t *sbc)
>>       struct sbc_priv *priv;
>>
>>       priv = sbc->priv;
>> -     if (priv->init)
>> +     if (priv->init && priv->frame.bitpool == sbc->bitpool)
>>               return priv->frame.length;
>>
>>       subbands = sbc->subbands ? 8 : 4;
>
> This is a valid change, because bitpool changes do indeed change the
> frame.length.

Ive sent a v2 patch but will update with a v3 with a proper
description why it is needed.



-- 
Luiz Augusto von Dentz
Computer Engineer
