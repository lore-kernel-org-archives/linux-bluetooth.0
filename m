Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Juha Kuikka <juha.kuikka@gmail.com>
Date: Tue, 7 Mar 2017 14:41:03 -0800
Message-ID: <CAKvrXUrUGtWuOyS0NEajGX8fbJB8xSRCNMCUufu4nXBYje9LyA@mail.gmail.com>
Subject: mSBC codec issue on a headset
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am implementing HFP support including mSBC. I am using the SBC-1.3 [1] codec.

Two headsets I am currently using are:
Jabra Halo Smart
LG HBS-750

My problem is that the Jabra headset starts adding noise to the audio
output after a period, while the LG headset works a-ok for prolonged
periods of time.

My test is about 13s long wave file that is being looped. On Jabra the
noise always starts at about 25s (could be right at the edge of the
loop, hard to tell) and never goes away.

Obviously if I use sbcenc/dec with the audio, it works normally.

I have minimized my test so the only unknowns for me are the codec and
the headset.

Any ideas on what to try? I can provide any logs required.

Thanks,
 - Juha

[1] http://www.kernel.org/pub/linux/bluetooth/sbc-1.3.tar.xz
