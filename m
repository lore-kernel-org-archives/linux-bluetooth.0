Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <D34DEF28-690B-4697-B88F-B224F7583782@holtmann.org>
References: <1389973213-30251-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1389973213-30251-5-git-send-email-andrzej.kaczmarek@tieto.com> <D34DEF28-690B-4697-B88F-B224F7583782@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Fri, 17 Jan 2014 20:26:20 +0100
Message-ID: <CAF3PWx3PZuAaJWacG77GSD7PRAaFuXi_o6LMe1zTWMrW1qYKaA@mail.gmail.com>
Subject: Re: [PATCH 4/9] android/hal-audio: Initialize SBC encoder
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 17 January 2014 19:24, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andrzej,
>
>> ---
>> android/hal-audio.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>> 1 file changed, 72 insertions(+)
>>
>> diff --git a/android/hal-audio.c b/android/hal-audio.c
>> index f53dba0..e5c646c 100644
>> --- a/android/hal-audio.c
>> +++ b/android/hal-audio.c
>> @@ -32,6 +32,7 @@
>> #include "hal-log.h"
>> #include "hal-msg.h"
>> #include "../profiles/audio/a2dp-codecs.h"
>> +#include <sbc/sbc.h>
>>
>> static const uint8_t a2dp_src_uuid[] =3D {
>>               0x00, 0x00, 0x11, 0x0a, 0x00, 0x00, 0x10, 0x00,
>> @@ -53,6 +54,8 @@ struct audio_input_config {
>>
>> struct sbc_data {
>>       a2dp_sbc_t sbc;
>> +
>> +     sbc_t enc;
>> };
>>
>> static int sbc_get_presets(struct audio_preset *preset, size_t *len);
>> @@ -184,6 +187,70 @@ static int sbc_get_presets(struct audio_preset *pre=
set, size_t *len)
>>       return i;
>> }
>>
>> +static void sbc_init_encoder(struct sbc_data *sbc_data)
>> +{
>> +     a2dp_sbc_t *in =3D &sbc_data->sbc;
>> +     sbc_t *out =3D &sbc_data->enc;
>> +
>> +     DBG("");
>> +
>> +     sbc_init(out, 0L);
>> +
>> +     switch (in->frequency) {
>> +     case SBC_SAMPLING_FREQ_16000:
>> +             out->frequency =3D SBC_FREQ_16000;
>> +             break;
>> +     case SBC_SAMPLING_FREQ_32000:
>> +             out->frequency =3D SBC_FREQ_32000;
>> +             break;
>> +     case SBC_SAMPLING_FREQ_44100:
>> +             out->frequency =3D SBC_FREQ_44100;
>> +             break;
>> +     case SBC_SAMPLING_FREQ_48000:
>> +             out->frequency =3D SBC_FREQ_48000;
>> +             break;
>> +     }
>> +
>> +     out->subbands =3D in->subbands =3D=3D SBC_SUBBANDS_4 ? SBC_SB_4 : =
SBC_SB_8;
>> +
>> +     switch (in->channel_mode) {
>> +     case SBC_CHANNEL_MODE_MONO:
>> +             out->mode =3D SBC_MODE_MONO;
>> +             break;
>> +     case SBC_CHANNEL_MODE_DUAL_CHANNEL:
>> +             out->mode =3D SBC_MODE_DUAL_CHANNEL;
>> +             break;
>> +     case SBC_CHANNEL_MODE_JOINT_STEREO:
>> +             out->mode =3D SBC_MODE_JOINT_STEREO;
>> +             break;
>> +     case SBC_CHANNEL_MODE_STEREO:
>> +             out->mode =3D SBC_MODE_STEREO;
>> +             break;
>> +     }
>> +
>> +     out->endian =3D SBC_LE;
>> +
>> +     out->bitpool =3D in->max_bitpool;
>> +
>> +     out->allocation =3D in->allocation_method =3D=3D SBC_ALLOCATION_SN=
R ?
>> +                             SBC_AM_SNR : SBC_AM_LOUDNESS;
>> +
>> +     switch (in->block_length) {
>> +     case SBC_BLOCK_LENGTH_4:
>> +             out->blocks =3D SBC_BLK_4;
>> +             break;
>> +     case SBC_BLOCK_LENGTH_8:
>> +             out->blocks =3D SBC_BLK_8;
>> +             break;
>> +     case SBC_BLOCK_LENGTH_12:
>> +             out->blocks =3D SBC_BLK_12;
>> +             break;
>> +     case SBC_BLOCK_LENGTH_16:
>> +             out->blocks =3D SBC_BLK_16;
>> +             break;
>> +     }
>
> aren=92t the values all the same? This looks pretty complicated for somet=
hing that should be dead simple. Does Android really had to duplicate every=
 single definition with the same prefix?

Actually symbols for 'in' come from a2dp-codecs.h and 'out' from sbc.h
;-) And they have different values since A2DP uses shifted-bit values
while sbc.h are just ordinal values so cannot assign them directly.


BR,
Andrzej
