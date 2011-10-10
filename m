Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 10 Oct 2011 12:40:20 +0200
Message-ID: <CABax29VLUHg_jePnhHz_6WHYCZBHoir5TBLuauK+Ktfg9-8Xjw@mail.gmail.com>
Subject: A2DP quality (bluetooth-alsa)
From: "qduaty@gmail.com" <qduaty@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi people,

I found that I cannot set A2DP bitpool to anything more than 53 in my
~/.asoundrc file. The bluetooth driver reports an error and keeps
reporting it (becomes useless) until it is restarted.

Bitpool values as high as 128 are possible on Windows Mobile devices
(including mine), which means they are possible in A2DP. Such a high
value is necessary for some genres of current music, which are highly
compressed (the problem was once discussed in one of Xiph Foundation's
articles). SBC is unable to encode such material properly if it
doesn't have enough bandwidth.

I don't understand Bluetooth. So I'm asking you for an advice:
1. Is it actually possible to set SBC bitpool in linux' A2DP to more than 53?
2. If it is, can I ask for a short success story in order to reproduce it?
2. If not, where should I start (in bluez source code) in order to fix
this problem?


Regards

--
Sebastian
