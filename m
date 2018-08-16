Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: ValdikSS <iam@valdikss.org.ru>
Subject: [Question] Bluetooth SBC codec bitpool/bitrate limitations
Message-ID: <a7c1bf51-751c-880a-56b9-c730d2f0ca7f@valdikss.org.ru>
Date: Thu, 16 Aug 2018 19:10:56 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello. I'm researching A2DP lately and I don't know anybody who deeply understands Bluetooth and Bluetooth codecs, hope you don't mind my questions.

A lot of people on the internet complain about SBC audio quality. Not all headphones negotiate high bitpool values, which usually leads to more or less distorted high frequencies.

Almost all of the time in my tests with laptop, smartphones and different headphones, SBC was negotiated with the following parameters: 8 subbands, 16 blocks, 53 max bitpool value. These parameters give 328 kbit/s bitrate for 44.1 kHz, 345 kbit/s for 48 kHz. While these parameters produce pretty decent audio, you can clearly see 17 kHz cutoff due to lack of free quantization bytes for higher frequencies. The majority of headsets have 53 max bitpool value.

I'm confused of bitpool. After reading A2DP specification, SBC RTP incapsulation RFC and some other documents, I still can't understand why it was decided to use bitpool and not bitrate in the codec parameters negotiation process. It doesn't describe maximum bitrate constraints and limits maximum possible audio quality because it's not bound to other codec parameters, which have a lot of influence on the bitrate. You can almost double the bitrate by using dual_channel instead of stereo/joint stereo, or set 4 subbands for stereo, with the same max bitpool value, and get higher audio quality/bitrate.

By patching pulseaudio, I was able to use 4 subbands dual_channel SBC with my headphones with 730+ kbit/s overall bitrate, much higher compared to stock 328 kbit/s for 44.1 kHz 51 max bitpool value from the specification. Audio is full bandwidth now, and not cut off at 17 kHz, and I'm still not exceeding maximum bitpool value supported by the headphones (Overdrive RealForce D1, CSR chipset).


Interesting that android bluetooth stack (bluedroid) operates with bitrate. It has bitpool constraints (max 53) and bitrate constraints (max 328, even for 48 kHz), and it won't use e.g. bitpool 53 with 48 kHz (as pulseaudio do on my headphones), but would downgrade it to 51 to fit it into 328 kbit/s. With a patched Android Bluetooth stack, I was able to use 660 kbit/s SBC audio on an old Android phone with Bluetooth 2.1 without any problems.


A2DP v1.2 specification states the following:

>The decoder of the SNK shall support all possible bitpool values that do not result in excess of the maximum bit rate. This profile limits the available maximum bit rate to 320kb/s for mono, and 512kb/s for two-channel modes.

Current version of the specification does not have this statement, but contains the following:

>A SNK device may support bitpools larger than the High Quality value in Table 4.7, but shall be required to demonstrate the ability to acceptably render the resulting media.

As far as I understand, A2DP v1.2 compatible decoders should support bitrates up to 512 kbit, and the following profile is valid for them: DUAL_CHANNEL, 8 subbands, 16 blocks, 43 max bitpool, which results in 507 kbit/s bitrate.

The majority of the headphones set bitpool max to 53, but there are some with 80 or even 250 values. For example:
Beats Solo³: bitpool: 2..250
JBL Everest Elite 750NC: bitpool 10..80


To me it feels that bitpool should be an internal variable. Is it a specification design fault that bitpool value is not bound to other codec parameters and only defined as a global value, or am I missing something? Do you have an idea why all current bluetooth stacks prefer, for example, joint stereo and not dual_channel with twice the bitrate? Would it be safe to switch current implementations to use dual_channel with bitrate limit of 512 kbit/s?

Thanks.
