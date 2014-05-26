Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <0ADD0151-224B-418E-94D6-B88CBD760BA8@holtmann.org>
References: <1400764022-26666-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <0ADD0151-224B-418E-94D6-B88CBD760BA8@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Mon, 26 May 2014 14:36:13 +0200
Message-ID: <CAF3PWx0Mm5goNNtVtqwM7LxRRskC6+vH8+8NRO1UYB4bB4_AJA@mail.gmail.com>
Subject: Re: [RFC] android/hal-audio: Fix wrong memory access
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 22 May 2014 16:21, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andrei,
>
>> downmix_buf is allocated to have buffer size FIXED_BUFFER_SIZE / 2, when
>> we access it as (int16_t *) we shall device index by 2.
>> ---
>> android/hal-audio.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/android/hal-audio.c b/android/hal-audio.c
>> index 7305bb6..96fa5c3 100644
>> --- a/android/hal-audio.c
>> +++ b/android/hal-audio.c
>> @@ -984,7 +984,7 @@ static void downmix_to_mono(struct a2dp_stream_out *=
out, const uint8_t *buffer,
>>       int16_t *output =3D (void *) out->downmix_buf;
>>       size_t i;
>>
>> -     for (i =3D 0; i < bytes / 2; i++) {
>> +     for (i =3D 0; i < bytes / (2 * sizeof(int16_t)); i++) {
>>               int16_t l =3D le16_to_cpu(get_unaligned(&input[i * 2]));
>>               int16_t r =3D le16_to_cpu(get_unaligned(&input[i * 2 + 1])=
);
>
> I wonder actually what this get_unaligned is doing here? You cast the con=
st void into const int16_t buffer. Is this really needed? Where is our inpu=
t and output buffer coming from? Aren=E2=80=99t these aligned anyway? Meani=
ng aren=E2=80=99t they allocated?

We have this buffer from AudioFlinger so we don't actually know
alignment or if this is pointer to beginning of some internal buffer
(it's most probably both, but I don't think we should assume this).

> I also wonder why we are not doing the unaligned access directly on the v=
oid buffer and do proper offset calculation into the stream. Instead of cas=
ting it to an int16 array.

Only to have buffer indexed by samples rather than by bytes.

BR,
Andrzej
