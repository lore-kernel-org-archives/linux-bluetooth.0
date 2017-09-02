Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1504352305.2859.10.camel@iki.fi>
Subject: Two guids for Headset HS role?
From: Tanu Kaskinen <tanuk@iki.fi>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sat, 02 Sep 2017 14:38:25 +0300
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PulseAudio currently assumes that HSP HS is identified by guid
00001108-0000-1000-8000-00805f9b34fb, but it seems[1] that the Samsung
HS6000 headset uses guid
00001131-0000-1000-8000-00805f9b34fb for the HSP profile. Does anyone
know why there are two guids for HSP HS. Should PulseAudio just assume
that the two guids mean the same thing?

[1] https://bugs.freedesktop.org/show_bug.cgi?id=93898#c13

-- 
Tanu

https://www.patreon.com/tanuk
