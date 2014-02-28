Return-Path: <cyrus@holtmann.org>
Subject: a2dp codec selection
Date: Fri, 28 Feb 2014 11:45:21 -0500
From: tropp@Safe-mail.net
To: linux-bluetooth@vger.kernel.org
Message-Id: <N1-WsLSYP_bQh@Safe-mail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi, 
i am using a2dp to connect my bluetooth headphones to my pc. the headphones are supporting the mandatory sbc codec and additionally the aac and aptX codecs. the following defines in profiles/audio/a2dp-codecs.h let me assume that at least sbc, mp3, aac and atrac are supported audio codecs by bluez: 
 
#define A2DP_CODEC_SBC         0x00 
#define A2DP_CODEC_MPEG12    0x01 
#define A2DP_CODEC_MPEG24    0x02 
#define A2DP_CODEC_ATRAC      0x03 
#define A2DP_CODEC_VENDOR    0xFF 
 
i want to use the aac codec for the best audio quality. therefore i added the following lines to my /etc/bluetooth/audio.conf 
 
[A2DP] 
SBCSources=0 
MPEG24Sources=1
 
is there any possibility to check which codec is currently used if a a2dp link is established? i want to confirm that aac is really used, or if i am using sbc, which bitrate is selected.

i am using ubuntu 12.10.

regards, tropp
