Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 31 Mar 2015 18:43:16 +0530
Message-ID: <CAKafyqooRHOCtKbzWdLeDW4Dr3S151+tz-S0S+YBsRhWADVYsQ@mail.gmail.com>
Subject: Crash in android/hal-sco.c
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

  I was trying to do SCO read using haltest but I was getting FPERROR.

So further I went debug coredump


static ssize_t in_read(struct audio_stream_in *stream, void *buffer,
                                                                size_t bytes)
{
        struct sco_stream_in *in = (struct sco_stream_in *) stream;
#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
        size_t frame_size = audio_stream_in_frame_size(&in->stream);
#else
        size_t frame_size = audio_stream_frame_size(&stream->common);
#endif

        size_t frame_num = bytes / frame_size; ===> Floating point error.

        size_t input_frame_num = frame_num;


I am getting channel number as 1  from audio_channel_count_from_in_mask

which is reserved for future hence I am getting zero as return which
leading to the crash

manyThanks,
Prabhu
