Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4841807.9Mv5T1jXya@leonov>
References: <CAKafyqooRHOCtKbzWdLeDW4Dr3S151+tz-S0S+YBsRhWADVYsQ@mail.gmail.com>
	<4841807.9Mv5T1jXya@leonov>
Date: Wed, 1 Apr 2015 09:13:21 +0530
Message-ID: <CAKafyqpLLHDeah3yqwMwy4JERfVMOk7RefEv-iqTdiQYpVBj7A@mail.gmail.com>
Subject: Re: Crash in android/hal-sco.c
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

  Thank you for the patch. I am getting channel number as 1 for input
stream and 2 for output stream, but in the code I am seeing channel
Zero is valid, comment says for compatibility.

Any ways I can force the channel to be Zero in my case ??

manyThanks,
Prabhu

On Tue, Mar 31, 2015 at 8:36 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi,
>
> On Tuesday 31 of March 2015 18:43:16 Prabhu Chawandi wrote:
>> Hi,
>>
>>   I was trying to do SCO read using haltest but I was getting FPERROR.
>>
>> So further I went debug coredump
>>
>>
>> static ssize_t in_read(struct audio_stream_in *stream, void *buffer,
>>                                                                 size_t
>> bytes) {
>>         struct sco_stream_in *in = (struct sco_stream_in *) stream;
>> #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
>>         size_t frame_size = audio_stream_in_frame_size(&in->stream);
>> #else
>>         size_t frame_size = audio_stream_frame_size(&stream->common);
>> #endif
>>
>>         size_t frame_num = bytes / frame_size; ===> Floating point error.
>>
>>         size_t input_frame_num = frame_num;
>>
>>
>> I am getting channel number as 1  from audio_channel_count_from_in_mask
>>
>> which is reserved for future hence I am getting zero as return which
>> leading to the crash
>
> Thanks for reporting.
> I've just send a patch "android/hal-sco: Fix divide by zero". This should fix
> the crash so please test.
>
> --
> BR
> Szymon Janc
