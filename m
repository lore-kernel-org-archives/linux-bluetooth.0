Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 May 2016 11:18:12 +1000
Message-ID: <CAPcThSHowLeD-C=e4z8CJsUC5hHzLyGFaR3QirJNJGK3L+5Fjg@mail.gmail.com>
Subject: How to setup the voice setting and sco-over-pcm parameters properly
 for bcm4356?
From: Qingtao Cao <qingtao.cao.au@gmail.com>
To: linux-bluetooth@vger.kernel.org,
	Qingtao Cao <qingtao.cao.au@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Community,

I had a trouble to set sco-over-pcm properly and couldn't hear sound
properly through a connect bluetooth headset. With sco-over-hci, I
could just hear some noise.

I've got a htc m9 phone with bcm4356 as wifi/bt/fm chipset. Currently
I have enabled the hci0 for it with the the help of brcm_patchram_plus
program which has an "--scopcm" option to setup the hardware pcm
interface and the pcm frame format with the following sub-parameters:

#1 sco_routing
    0 for PCM, 1 for Transport, 2 for Codec and 3 for I2S

#2 pcm_interface_rate
    0 for 128k, 1 for 256k, 2 for 512k, 3 for 1034k, 4 for 2048k

#3 frame_type
    0 for short, 1 for long

#4 sync_mode
    0 for slave, 1 for master

#5 clock_mode
    0 for slave and 1 for master

#6 lsb_first
    0 for false and 1 for true

#7 fill_bits
    the value in decimal for unused bits

#8 fill_method
    0 for 0's, 1 for 1's, 2 for signed and 3 for programmable

#9 fill_num
    the number or bits to be filled

#10 right_justify
    0 for false and 1 for true


Broadcom's libbt-vendor.so implementation for bluedroid set it up as
"0,4,0,0,0,0,0,3,0,0", since the first sco_routing == 0，the pcm data
is routed into the pcm interface instead of through HCI-UART
interface. I have enabled SCORouting = PCM in audio.conf, however, I
can't hear anything at all through my connected bluetooth headset
using the HSP/HFP profiles.

However, if I change the sco_routing byte to 1 and SCORouting = HCI,
that is, to route pcm data from the HCI-UART interface instead of the
hardware pcm interface, I could hear some noise from my connected
bluetooth headset. I also tried with different sample rate but failed
to have them played properly.

BTW, if I use A2DP profile I can play mp3 file well through a bluetooth speaker.

Currently the voice setting for my hci0 is the default value of 0x0060

/ # hciconfig hci0 voice
hci0:    Type: BR/EDR  Bus: UART
    BD Address: 90:E7:C4:F3:F7:09  ACL MTU: 1021:8  SCO MTU: 64:1
    Voice setting: 0x0060 (Default Condition)
    Input Coding: Linear
    Input Data Format: 2's complement
    Input Sample Size: 16 bit
    # of bits padding at MSB: 0
    Air Coding Format: CVSD

So how could I set below options:
#1 above parameters of input coding, input data format, input sample
size etc, and
#2 the sample rate and format settings when recording the audio file
(used by arecord for example), and
#3 the --scopcm option of the brcm_patchram_plus program

in accordance with each other to make both sco-over-hci and sco-over-pcm work?

Last but not least, suppose the to be played .wav file is of a
different sample rate or format settings than what has been set
through the --scopcm option, should the music player or audio server
convert it to the expected format before writing to sco socket?

Many thanks for any comments or advices!

Cheers,
Harry
