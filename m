Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLKqW9aFcuA4aQ7DzHUmTSDL2qKq5a=nsTpXVpD2T9OiA@mail.gmail.com>
References: <1397053018-4610-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1397053018-4610-7-git-send-email-andrzej.kaczmarek@tieto.com>
 <CABBYNZ+NMFt7sDEU2TPTyBdcCmmmZyNwptAYmXggZLvTFiVE-A@mail.gmail.com> <CABBYNZLKqW9aFcuA4aQ7DzHUmTSDL2qKq5a=nsTpXVpD2T9OiA@mail.gmail.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Wed, 16 Apr 2014 11:58:14 +0200
Message-ID: <CAF3PWx21hYuT4RcHqHXiuo7MxbdwVbgcdD2d-DmxcmZMgYTPqA@mail.gmail.com>
Subject: Re: [PATCH 6/7] android/hal-audio: Add support to control audio quality
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 11 April 2014 09:59, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Andrzej,
>
> On Thu, Apr 10, 2014 at 11:25 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Andrzej,
>>
>> On Wed, Apr 9, 2014 at 5:16 PM, Andrzej Kaczmarek
>> <andrzej.kaczmarek@tieto.com> wrote:
>>> This patch adds new codec abstraction call which can be used to adjust
>>> audio quality while playing. As for now we can either decrease quality
>>> or restore default one.
>>>
>>> It's up to actual codec capabilities and implementation how this can be
>>> handled. In case of SBC bitpool is decreased by fixed amount (5) until
>>> min allowable value is reached (33) - the same values are used in
>>> PulseAudio.
>>> ---
>>>  android/hal-audio.c | 81 ++++++++++++++++++++++++++++++++++++++++++-----------
>>>  1 file changed, 65 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/android/hal-audio.c b/android/hal-audio.c
>>> index e58be2b..2db927c 100644
>>> --- a/android/hal-audio.c
>>> +++ b/android/hal-audio.c
>>> @@ -47,6 +47,9 @@
>>>
>>>  #define MAX_DELAY      100000 /* 100ms */
>>>
>>> +#define SBC_QUALITY_MIN_BITPOOL        33
>>> +#define SBC_QUALITY_STEP       5
>>> +
>>>  static const uint8_t a2dp_src_uuid[] = {
>>>                 0x00, 0x00, 0x11, 0x0a, 0x00, 0x00, 0x10, 0x00,
>>>                 0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb };
>>> @@ -128,6 +131,8 @@ struct sbc_data {
>>>
>>>         sbc_t enc;
>>>
>>> +       uint16_t payload_len;
>>> +
>>>         size_t in_frame_len;
>>>         size_t in_buf_size;
>>>
>>> @@ -189,6 +194,10 @@ static size_t sbc_get_mediapacket_duration(void *codec_data);
>>>  static ssize_t sbc_encode_mediapacket(void *codec_data, const uint8_t *buffer,
>>>                                         size_t len, struct media_packet *mp,
>>>                                         size_t mp_data_len, size_t *written);
>>> +static bool sbc_quality_ctrl(void *codec_data, uint8_t op);
>>> +
>>> +#define QUALITY_CTRL_DEFAULT   0x00
>>> +#define QUALITY_CTRL_DECREASE  0x01
>>
>> Lets call it QOS_POLICY_*
>>
>>>  struct audio_codec {
>>>         uint8_t type;
>>> @@ -205,6 +214,7 @@ struct audio_codec {
>>>         ssize_t (*encode_mediapacket) (void *codec_data, const uint8_t *buffer,
>>>                                         size_t len, struct media_packet *mp,
>>>                                         size_t mp_data_len, size_t *written);
>>> +       bool (*quality_ctrl) (void *codec_data, uint8_t op);
>>
>> I prefer to use update_qos
>>
>>>  };
>>>
>>>  static const struct audio_codec audio_codecs[] = {
>>> @@ -219,6 +229,7 @@ static const struct audio_codec audio_codecs[] = {
>>>                 .get_buffer_size = sbc_get_buffer_size,
>>>                 .get_mediapacket_duration = sbc_get_mediapacket_duration,
>>>                 .encode_mediapacket = sbc_encode_mediapacket,
>>> +               .quality_ctrl = sbc_quality_ctrl,
>>
>> sbc_update_qos
>>
>>>         }
>>>  };
>>>
>>> @@ -412,14 +423,33 @@ static void sbc_init_encoder(struct sbc_data *sbc_data)
>>>                         in->min_bitpool, in->max_bitpool);
>>>  }
>>>
>>> -static int sbc_codec_init(struct audio_preset *preset, uint16_t payload_len,
>>> -                                                       void **codec_data)
>>> +static void sbc_codec_calculate(struct sbc_data *sbc_data)
>>>  {
>>> -       struct sbc_data *sbc_data;
>>>         size_t in_frame_len;
>>>         size_t out_frame_len;
>>>         size_t num_frames;
>>>
>>> +       in_frame_len = sbc_get_codesize(&sbc_data->enc);
>>> +       out_frame_len = sbc_get_frame_length(&sbc_data->enc);
>>> +       num_frames = sbc_data->payload_len / out_frame_len;
>>> +
>>> +       sbc_data->in_frame_len = in_frame_len;
>>> +       sbc_data->in_buf_size = num_frames * in_frame_len;
>>> +
>>> +       sbc_data->out_frame_len = out_frame_len;
>>> +
>>> +       sbc_data->frame_duration = sbc_get_frame_duration(&sbc_data->enc);
>>> +       sbc_data->frames_per_packet = num_frames;
>>> +
>>> +       DBG("in_frame_len=%zu out_frame_len=%zu frames_per_packet=%zu",
>>> +                               in_frame_len, out_frame_len, num_frames);
>>> +}
>>
>> Looks like you remembered to update the frame size, however how about
>> the latency? Does it gets updated automagically?
>>
>>> +static int sbc_codec_init(struct audio_preset *preset, uint16_t payload_len,
>>> +                                                       void **codec_data)
>>> +{
>>> +       struct sbc_data *sbc_data;
>>> +
>>>         if (preset->len != sizeof(a2dp_sbc_t)) {
>>>                 error("SBC: preset size mismatch");
>>>                 return AUDIO_STATUS_FAILED;
>>> @@ -433,20 +463,9 @@ static int sbc_codec_init(struct audio_preset *preset, uint16_t payload_len,
>>>
>>>         sbc_init_encoder(sbc_data);
>>>
>>> -       in_frame_len = sbc_get_codesize(&sbc_data->enc);
>>> -       out_frame_len = sbc_get_frame_length(&sbc_data->enc);
>>> -       num_frames = payload_len / out_frame_len;
>>> -
>>> -       sbc_data->in_frame_len = in_frame_len;
>>> -       sbc_data->in_buf_size = num_frames * in_frame_len;
>>> -
>>> -       sbc_data->out_frame_len = out_frame_len;
>>> -
>>> -       sbc_data->frame_duration = sbc_get_frame_duration(&sbc_data->enc);
>>> -       sbc_data->frames_per_packet = num_frames;
>>> +       sbc_data->payload_len = payload_len;
>>>
>>> -       DBG("in_frame_len=%zu out_frame_len=%zu frames_per_packet=%zu",
>>> -                               in_frame_len, out_frame_len, num_frames);
>>> +       sbc_codec_calculate(sbc_data);
>>>
>>>         *codec_data = sbc_data;
>>>
>>> @@ -541,6 +560,36 @@ static ssize_t sbc_encode_mediapacket(void *codec_data, const uint8_t *buffer,
>>>         return consumed;
>>>  }
>>>
>>> +static bool sbc_quality_ctrl(void *codec_data, uint8_t op)
>>> +{
>>> +       struct sbc_data *sbc_data = (struct sbc_data *) codec_data;
>>> +       uint8_t curr_bitpool = sbc_data->enc.bitpool;
>>> +       uint8_t new_bitpool = curr_bitpool;
>>> +
>>> +       switch (op) {
>>> +       case QUALITY_CTRL_DEFAULT:
>>> +               new_bitpool = sbc_data->sbc.max_bitpool;
>>> +               break;
>>> +
>>> +       case QUALITY_CTRL_DECREASE:
>>> +               new_bitpool = curr_bitpool - SBC_QUALITY_STEP;
>>> +               if (new_bitpool < SBC_QUALITY_MIN_BITPOOL)
>>> +                       new_bitpool = SBC_QUALITY_MIN_BITPOOL;
>>> +               break;
>>> +       }
>
> One detail is missing here, if max_bitpool is bellow the
> SBC_QUALITY_MIN_BITPOOL you should do nothing otherwise we might send
> frames using a bitpool outside of the negotiated range.

I changed this to try to decrease bitpool only if we're above
SBC_QUALITY_MIN_BITPOOL so if we are already below, we won't touch
bitpool.

BR,
Andrzej
