Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 4/9] android/hal-audio: Initialize SBC encoder
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZ+_CXL5EsTt27ERRjCFEZK69HopAJigNusSG6ELGaPwLA@mail.gmail.com>
Date: Fri, 17 Jan 2014 12:24:51 -0800
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <B6424768-844B-4B61-A384-0A97965890B8@holtmann.org>
References: <1389973213-30251-1-git-send-email-andrzej.kaczmarek@tieto.com> <1389973213-30251-5-git-send-email-andrzej.kaczmarek@tieto.com> <D34DEF28-690B-4697-B88F-B224F7583782@holtmann.org> <CAF3PWx3PZuAaJWacG77GSD7PRAaFuXi_o6LMe1zTWMrW1qYKaA@mail.gmail.com> <127C43B2-4418-44A2-9F44-27908E587B11@holtmann.org> <CABBYNZ+_CXL5EsTt27ERRjCFEZK69HopAJigNusSG6ELGaPwLA@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>>>>> ---
>>>>> android/hal-audio.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>> 1 file changed, 72 insertions(+)
>>>>> 
>>>>> diff --git a/android/hal-audio.c b/android/hal-audio.c
>>>>> index f53dba0..e5c646c 100644
>>>>> --- a/android/hal-audio.c
>>>>> +++ b/android/hal-audio.c
>>>>> @@ -32,6 +32,7 @@
>>>>> #include "hal-log.h"
>>>>> #include "hal-msg.h"
>>>>> #include "../profiles/audio/a2dp-codecs.h"
>>>>> +#include <sbc/sbc.h>
>>>>> 
>>>>> static const uint8_t a2dp_src_uuid[] = {
>>>>>             0x00, 0x00, 0x11, 0x0a, 0x00, 0x00, 0x10, 0x00,
>>>>> @@ -53,6 +54,8 @@ struct audio_input_config {
>>>>> 
>>>>> struct sbc_data {
>>>>>     a2dp_sbc_t sbc;
>>>>> +
>>>>> +     sbc_t enc;
>>>>> };
>>>>> 
>>>>> static int sbc_get_presets(struct audio_preset *preset, size_t *len);
>>>>> @@ -184,6 +187,70 @@ static int sbc_get_presets(struct audio_preset *preset, size_t *len)
>>>>>     return i;
>>>>> }
>>>>> 
>>>>> +static void sbc_init_encoder(struct sbc_data *sbc_data)
>>>>> +{
>>>>> +     a2dp_sbc_t *in = &sbc_data->sbc;
>>>>> +     sbc_t *out = &sbc_data->enc;
>>>>> +
>>>>> +     DBG("");
>>>>> +
>>>>> +     sbc_init(out, 0L);
>>>>> +
>>>>> +     switch (in->frequency) {
>>>>> +     case SBC_SAMPLING_FREQ_16000:
>>>>> +             out->frequency = SBC_FREQ_16000;
>>>>> +             break;
>>>>> +     case SBC_SAMPLING_FREQ_32000:
>>>>> +             out->frequency = SBC_FREQ_32000;
>>>>> +             break;
>>>>> +     case SBC_SAMPLING_FREQ_44100:
>>>>> +             out->frequency = SBC_FREQ_44100;
>>>>> +             break;
>>>>> +     case SBC_SAMPLING_FREQ_48000:
>>>>> +             out->frequency = SBC_FREQ_48000;
>>>>> +             break;
>>>>> +     }
>>>>> +
>>>>> +     out->subbands = in->subbands == SBC_SUBBANDS_4 ? SBC_SB_4 : SBC_SB_8;
>>>>> +
>>>>> +     switch (in->channel_mode) {
>>>>> +     case SBC_CHANNEL_MODE_MONO:
>>>>> +             out->mode = SBC_MODE_MONO;
>>>>> +             break;
>>>>> +     case SBC_CHANNEL_MODE_DUAL_CHANNEL:
>>>>> +             out->mode = SBC_MODE_DUAL_CHANNEL;
>>>>> +             break;
>>>>> +     case SBC_CHANNEL_MODE_JOINT_STEREO:
>>>>> +             out->mode = SBC_MODE_JOINT_STEREO;
>>>>> +             break;
>>>>> +     case SBC_CHANNEL_MODE_STEREO:
>>>>> +             out->mode = SBC_MODE_STEREO;
>>>>> +             break;
>>>>> +     }
>>>>> +
>>>>> +     out->endian = SBC_LE;
>>>>> +
>>>>> +     out->bitpool = in->max_bitpool;
>>>>> +
>>>>> +     out->allocation = in->allocation_method == SBC_ALLOCATION_SNR ?
>>>>> +                             SBC_AM_SNR : SBC_AM_LOUDNESS;
>>>>> +
>>>>> +     switch (in->block_length) {
>>>>> +     case SBC_BLOCK_LENGTH_4:
>>>>> +             out->blocks = SBC_BLK_4;
>>>>> +             break;
>>>>> +     case SBC_BLOCK_LENGTH_8:
>>>>> +             out->blocks = SBC_BLK_8;
>>>>> +             break;
>>>>> +     case SBC_BLOCK_LENGTH_12:
>>>>> +             out->blocks = SBC_BLK_12;
>>>>> +             break;
>>>>> +     case SBC_BLOCK_LENGTH_16:
>>>>> +             out->blocks = SBC_BLK_16;
>>>>> +             break;
>>>>> +     }
>>>> 
>>>> aren’t the values all the same? This looks pretty complicated for something that should be dead simple. Does Android really had to duplicate every single definition with the same prefix?
>>> 
>>> Actually symbols for 'in' come from a2dp-codecs.h and 'out' from sbc.h
>>> ;-) And they have different values since A2DP uses shifted-bit values
>>> while sbc.h are just ordinal values so cannot assign them directly.
>> 
>> so this a problem we created by ourselves. Yeah. Seems no cookie for me tonight ;)
>> 
>> We need to start fixing a2dp-codecs.h then and prefix it with A2DP. This current situation is bad. Luiz?
> 
> Looks like it, what about a helper function inside sbc that takes care
> of this conversion?

please send me libsbc patches that I can look at it. I am open for adding this.

Regards

Marcel

