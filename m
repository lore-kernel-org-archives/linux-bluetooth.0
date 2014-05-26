Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC] android/hal-audio: Fix wrong memory access
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAF3PWx0Mm5goNNtVtqwM7LxRRskC6+vH8+8NRO1UYB4bB4_AJA@mail.gmail.com>
Date: Mon, 26 May 2014 14:48:27 +0200
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <BD6D66D8-668E-49DE-9FE9-85FF67F6613A@holtmann.org>
References: <1400764022-26666-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <0ADD0151-224B-418E-94D6-B88CBD760BA8@holtmann.org> <CAF3PWx0Mm5goNNtVtqwM7LxRRskC6+vH8+8NRO1UYB4bB4_AJA@mail.gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

>>> downmix_buf is allocated to have buffer size FIXED_BUFFER_SIZE / 2, when
>>> we access it as (int16_t *) we shall device index by 2.
>>> ---
>>> android/hal-audio.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>> 
>>> diff --git a/android/hal-audio.c b/android/hal-audio.c
>>> index 7305bb6..96fa5c3 100644
>>> --- a/android/hal-audio.c
>>> +++ b/android/hal-audio.c
>>> @@ -984,7 +984,7 @@ static void downmix_to_mono(struct a2dp_stream_out *out, const uint8_t *buffer,
>>>      int16_t *output = (void *) out->downmix_buf;
>>>      size_t i;
>>> 
>>> -     for (i = 0; i < bytes / 2; i++) {
>>> +     for (i = 0; i < bytes / (2 * sizeof(int16_t)); i++) {
>>>              int16_t l = le16_to_cpu(get_unaligned(&input[i * 2]));
>>>              int16_t r = le16_to_cpu(get_unaligned(&input[i * 2 + 1]));
>> 
>> I wonder actually what this get_unaligned is doing here? You cast the const void into const int16_t buffer. Is this really needed? Where is our input and output buffer coming from? Aren’t these aligned anyway? Meaning aren’t they allocated?
> 
> We have this buffer from AudioFlinger so we don't actually know
> alignment or if this is pointer to beginning of some internal buffer
> (it's most probably both, but I don't think we should assume this).

and audio system that does not give you a guarantee here on the alignment is utterly screwed up. Seriously, that is just bad for performance. Especially bad on ARM CPUs, so I doubt that they have not thought about this.

Regards

Marcel

