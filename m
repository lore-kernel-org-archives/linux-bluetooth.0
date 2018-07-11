Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 11 Jul 2018 13:04:06 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: bluez: A2DP backchannel
Message-ID: <20180711110406.hkcqfjkmxsqq5xqk@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

Some vendor A2DP bluetooth codecs like FastStream or aptX Low Latency
supports backchannel. Which means that they are bi-directional and in
A2DP they supports not only (music) playback, but also receiving
backchannel (microphone) voice.

How to establish this bi-directional A2DP transfer with backchannel via
bluez daemon?

-- 
Pali Rohár
pali.rohar@gmail.com
