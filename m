Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Nov 2015 17:10:14 +0530
Message-ID: <CAKafyqo7gpqfMZ2JzUD9f5P-4Tz_ay74zWy3UNLnybWxqGftGA@mail.gmail.com>
Subject: [bluez-android] How can we change the audio sample rate dynamically
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

  I have situation where I need to reset the sample rate depending on
the incoming settings.

How can I do it ?  I have tried below ways.

I found changing a2dp_sbc_t sbc_presets[1] frequency from  44100 to
48000 in hal-audio-sbc.c, will change the device sampling rate, but
only once.

In order to achieve changing sampling rate dynamically, i used the
below methods. Both did not work

a. stream_out->common.set_sample_rate(&stream_out->common)
b. stream_out->common.set_parameters(&stream_out->common","sampling_rate=48000");

Has anyone tried changing audio sample rate dynamically? If so, please
share how it was done?

Advanced Thanks,
Prabhu Chawandi
