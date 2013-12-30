Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK5rRnRnrvDCx7w9zsrG4wZyf8GpGBhLq57fi_o_kNVxA@mail.gmail.com>
References: <1388398647-25420-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1388398647-25420-6-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZKQiGs-nmGRV=rM5Ue=ezk3nETNPtuEqtF2jt7KO-=PNQ@mail.gmail.com>
	<CAMudyAuUDd0DVC+42Xh72-MTr8at46Agbma1e-XPm2grWHb75w@mail.gmail.com>
	<CABBYNZK5rRnRnrvDCx7w9zsrG4wZyf8GpGBhLq57fi_o_kNVxA@mail.gmail.com>
Date: Mon, 30 Dec 2013 13:37:31 +0100
Message-ID: <CAMudyAsGXQ3cPjv_5R5cFrM=asYr8ZZH2YmLdOh95mEiz0oc8w@mail.gmail.com>
Subject: Re: [RFC 5/6] android/audio: Add wrapper struct for audio structures
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 30 December 2013 13:04, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Lukasz,
>
> On Mon, Dec 30, 2013 at 1:33 PM, Lukasz Rymanowski
> <lukasz.rymanowski@tieto.com> wrote:
>> Hi Luiz,
>>
>> On 30 December 2013 12:27, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>> Hi Lukasz,
>>>
>>> On Mon, Dec 30, 2013 at 12:17 PM, Lukasz Rymanowski
>>> <lukasz.rymanowski@tieto.com> wrote:
>>>> This patch add wrapping struct for audio_hw_dev and audio_stream_out.
>>>> We will need this to keep some more addition info related to a2dp stream
>>>> and also hal IPC later on
>>>>
>>>> ---
>>>>  android/Makefile.am |  1 +
>>>>  android/hal-audio.c | 97 +++++++++++++++++++++++++++++------------------------
>>>>  2 files changed, 55 insertions(+), 43 deletions(-)
>>>>
>>>> diff --git a/android/Makefile.am b/android/Makefile.am
>>>> index dec81ce..eaf39bd 100644
>>>> --- a/android/Makefile.am
>>>> +++ b/android/Makefile.am
>>>> @@ -104,6 +104,7 @@ android_android_tester_LDFLAGS = -pthread
>>>>  noinst_LTLIBRARIES += android/libaudio-internal.la
>>>>
>>>>  android_libaudio_internal_la_SOURCES = android/hal-audio.c \
>>>> +                                       android/hal-audio.h \
>>>>                                         android/hardware/audio.h \
>>>>                                         android/hardware/audio_effect.h \
>>>>                                         android/hardware/hardware.h \
>>>> diff --git a/android/hal-audio.c b/android/hal-audio.c
>>>> index 7f4a3f2..011a699 100644
>>>> --- a/android/hal-audio.c
>>>> +++ b/android/hal-audio.c
>>>> @@ -25,6 +25,15 @@
>>>>
>>>>  #include "hal-log.h"
>>>>
>>>> +struct a2dp_audio_dev {
>>>> +       struct audio_hw_device dev;
>>>> +       struct a2dp_stream_out *stream_out;
>>>> +};
>>>> +
>>>> +struct a2dp_stream_out {
>>>> +       struct audio_stream_out stream;
>>>> +};
>>>> +
>>>>  static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
>>>>                                                                 size_t bytes)
>>>>  {
>>>> @@ -230,32 +239,34 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
>>>>                                         struct audio_stream_out **stream_out)
>>>>
>>>>  {
>>>> -       struct audio_stream_out *out;
>>>> +       struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *)dev;
>>>> +       struct a2dp_stream_out *a2dp_out;
>>>>
>>>> -       out = calloc(1, sizeof(struct audio_stream_out));
>>>> -       if (!out)
>>>> +       a2dp_out = calloc(1, sizeof(struct a2dp_stream_out));
>>>> +       if (!a2dp_out)
>>>>                 return -ENOMEM;
>>>>
>>>>         DBG("");
>>>>
>>>> -       out->common.get_sample_rate = out_get_sample_rate;
>>>> -       out->common.set_sample_rate = out_set_sample_rate;
>>>> -       out->common.get_buffer_size = out_get_buffer_size;
>>>> -       out->common.get_channels = out_get_channels;
>>>> -       out->common.get_format = out_get_format;
>>>> -       out->common.set_format = out_set_format;
>>>> -       out->common.standby = out_standby;
>>>> -       out->common.dump = out_dump;
>>>> -       out->common.set_parameters = out_set_parameters;
>>>> -       out->common.get_parameters = out_get_parameters;
>>>> -       out->common.add_audio_effect = out_add_audio_effect;
>>>> -       out->common.remove_audio_effect = out_remove_audio_effect;
>>>> -       out->get_latency = out_get_latency;
>>>> -       out->set_volume = out_set_volume;
>>>> -       out->write = out_write;
>>>> -       out->get_render_position = out_get_render_position;
>>>> +       a2dp_out->stream.common.get_sample_rate = out_get_sample_rate;
>>>> +       a2dp_out->stream.common.set_sample_rate = out_set_sample_rate;
>>>> +       a2dp_out->stream.common.get_buffer_size = out_get_buffer_size;
>>>> +       a2dp_out->stream.common.get_channels = out_get_channels;
>>>> +       a2dp_out->stream.common.get_format = out_get_format;
>>>> +       a2dp_out->stream.common.set_format = out_set_format;
>>>> +       a2dp_out->stream.common.standby = out_standby;
>>>> +       a2dp_out->stream.common.dump = out_dump;
>>>> +       a2dp_out->stream.common.set_parameters = out_set_parameters;
>>>> +       a2dp_out->stream.common.get_parameters = out_get_parameters;
>>>> +       a2dp_out->stream.common.add_audio_effect = out_add_audio_effect;
>>>> +       a2dp_out->stream.common.remove_audio_effect = out_remove_audio_effect;
>>>> +       a2dp_out->stream.get_latency = out_get_latency;
>>>> +       a2dp_out->stream.set_volume = out_set_volume;
>>>> +       a2dp_out->stream.write = out_write;
>>>> +       a2dp_out->stream.get_render_position = out_get_render_position;
>>>>
>>>> -       *stream_out = out;
>>>> +       *stream_out = &a2dp_out->stream;
>>>> +       a2dp_dev->stream_out = a2dp_out;
>>>>
>>>>         return 0;
>>>>  }
>>>> @@ -381,7 +392,7 @@ static int audio_close(hw_device_t *device)
>>>>  static int audio_open(const hw_module_t *module, const char *name,
>>>>                                                         hw_device_t **device)
>>>>  {
>>>> -       struct audio_hw_device *audio;
>>>> +       struct a2dp_audio_dev *a2dp_dev;
>>>>
>>>>         DBG("");
>>>>
>>>> @@ -391,30 +402,30 @@ static int audio_open(const hw_module_t *module, const char *name,
>>>>                 return -EINVAL;
>>>>         }
>>>>
>>>> -       audio = calloc(1, sizeof(struct audio_hw_device));
>>>> -       if (!audio)
>>>> +       a2dp_dev = calloc(1, sizeof(struct a2dp_audio_dev));
>>>> +       if (!a2dp_dev)
>>>>                 return -ENOMEM;
>>>>
>>>> -       audio->common.version = AUDIO_DEVICE_API_VERSION_CURRENT;
>>>> -       audio->common.module = (struct hw_module_t *) module;
>>>> -       audio->common.close = audio_close;
>>>> -
>>>> -       audio->init_check = audio_init_check;
>>>> -       audio->set_voice_volume = audio_set_voice_volume;
>>>> -       audio->set_master_volume = audio_set_master_volume;
>>>> -       audio->set_mode = audio_set_mode;
>>>> -       audio->set_mic_mute = audio_set_mic_mute;
>>>> -       audio->get_mic_mute = audio_get_mic_mute;
>>>> -       audio->set_parameters = audio_set_parameters;
>>>> -       audio->get_parameters = audio_get_parameters;
>>>> -       audio->get_input_buffer_size = audio_get_input_buffer_size;
>>>> -       audio->open_output_stream = audio_open_output_stream;
>>>> -       audio->close_output_stream = audio_close_output_stream;
>>>> -       audio->open_input_stream = audio_open_input_stream;
>>>> -       audio->close_input_stream = audio_close_input_stream;
>>>> -       audio->dump = audio_dump;
>>>> -
>>>> -       *device = &audio->common;
>>>> +       a2dp_dev->dev.common.version = AUDIO_DEVICE_API_VERSION_CURRENT;
>>>> +       a2dp_dev->dev.common.module = (struct hw_module_t *) module;
>>>> +       a2dp_dev->dev.common.close = audio_close;
>>>> +
>>>> +       a2dp_dev->dev.init_check = audio_init_check;
>>>> +       a2dp_dev->dev.set_voice_volume = audio_set_voice_volume;
>>>> +       a2dp_dev->dev.set_master_volume = audio_set_master_volume;
>>>> +       a2dp_dev->dev.set_mode = audio_set_mode;
>>>> +       a2dp_dev->dev.set_mic_mute = audio_set_mic_mute;
>>>> +       a2dp_dev->dev.get_mic_mute = audio_get_mic_mute;
>>>> +       a2dp_dev->dev.set_parameters = audio_set_parameters;
>>>> +       a2dp_dev->dev.get_parameters = audio_get_parameters;
>>>> +       a2dp_dev->dev.get_input_buffer_size = audio_get_input_buffer_size;
>>>> +       a2dp_dev->dev.open_output_stream = audio_open_output_stream;
>>>> +       a2dp_dev->dev.close_output_stream = audio_close_output_stream;
>>>> +       a2dp_dev->dev.open_input_stream = audio_open_input_stream;
>>>> +       a2dp_dev->dev.close_input_stream = audio_close_input_stream;
>>>> +       a2dp_dev->dev.dump = audio_dump;
>>>> +
>>>> +       *device = &a2dp_dev->dev.common;
>>>>
>>>>         return 0;
>>>>  }
>>>> --
>>>> 1.8.4
>>>
>>> How is this supposed to be accessed, are you planning on adding a
>>> global variable?
>>>
>>>
>> Have a look on audio_open_output_stream(). This is actually how they did so
>> far and it is fine for me.
>> I want to avoid globals here.
>
> I can see that you allocate a different struct for a2dp_dev and
> a2dp_out, but then you return a member of the struct back to HAL but
> after that you wont access these structs anymore and the HAL only uses
> the members that you return so you probably gonna need to lookup for
> these structs to access any auxiliary data that we might want to add,
> also these structs never seems to be freed which I suppose can
> generate memory leaks.
>
>
You right I missed free of a2dp_out
It will be done in  audio_close_output_stream(). Access to that will
be similar as to a2dp_dev() in audio_close()

> --
> Luiz Augusto von Dentz
