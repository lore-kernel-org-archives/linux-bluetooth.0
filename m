Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BD6D66D8-668E-49DE-9FE9-85FF67F6613A@holtmann.org>
References: <1400764022-26666-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <0ADD0151-224B-418E-94D6-B88CBD760BA8@holtmann.org> <CAF3PWx0Mm5goNNtVtqwM7LxRRskC6+vH8+8NRO1UYB4bB4_AJA@mail.gmail.com>
 <BD6D66D8-668E-49DE-9FE9-85FF67F6613A@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Mon, 26 May 2014 14:59:31 +0200
Message-ID: <CAF3PWx0XGcT+s+2i6wxsZevLpa7oP9uNQ84AsEt0xNYNaf+2xA@mail.gmail.com>
Subject: Re: [RFC] android/hal-audio: Fix wrong memory access
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 26 May 2014 14:48, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andrzej,
>
>>>> downmix_buf is allocated to have buffer size FIXED_BUFFER_SIZE / 2, wh=
en
>>>> we access it as (int16_t *) we shall device index by 2.
>>>> ---
>>>> android/hal-audio.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/android/hal-audio.c b/android/hal-audio.c
>>>> index 7305bb6..96fa5c3 100644
>>>> --- a/android/hal-audio.c
>>>> +++ b/android/hal-audio.c
>>>> @@ -984,7 +984,7 @@ static void downmix_to_mono(struct a2dp_stream_out=
 *out, const uint8_t *buffer,
>>>>      int16_t *output =3D (void *) out->downmix_buf;
>>>>      size_t i;
>>>>
>>>> -     for (i =3D 0; i < bytes / 2; i++) {
>>>> +     for (i =3D 0; i < bytes / (2 * sizeof(int16_t)); i++) {
>>>>              int16_t l =3D le16_to_cpu(get_unaligned(&input[i * 2]));
>>>>              int16_t r =3D le16_to_cpu(get_unaligned(&input[i * 2 + 1]=
));
>>>
>>> I wonder actually what this get_unaligned is doing here? You cast the c=
onst void into const int16_t buffer. Is this really needed? Where is our in=
put and output buffer coming from? Aren=E2=80=99t these aligned anyway? Mea=
ning aren=E2=80=99t they allocated?
>>
>> We have this buffer from AudioFlinger so we don't actually know
>> alignment or if this is pointer to beginning of some internal buffer
>> (it's most probably both, but I don't think we should assume this).
>
> and audio system that does not give you a guarantee here on the alignment=
 is utterly screwed up. Seriously, that is just bad for performance. Especi=
ally bad on ARM CPUs, so I doubt that they have not thought about this.

This is only to be on safe side and in terms of performance it does
not really matter here since this code won't probably be used at all -
who has mono A2DP headset nowadays? But of course we can change this
with proper comment. Actually I use it like this in aptX where samples
are accessed from the same buffer.

BR,
Andrzej
