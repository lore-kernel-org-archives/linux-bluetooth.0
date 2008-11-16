Return-Path: <cyrus@holtmann.org>
Message-ID: <5a14e9b50811151841i3d84eae3i6c11068cfad1ac01@mail.gmail.com>
Date: Sun, 16 Nov 2008 03:41:27 +0100
From: "XazZ XazZ" <xazz.xazz@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Problem with bluez and a bluetooth headset
In-Reply-To: <5a14e9b50811111229l2addf4aega6e1107320a83026@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <5a14e9b50811111229l2addf4aega6e1107320a83026@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

good evening again

I got one step further after deleting my whole bluetooth-configuration
and setting everything bluetooth-related up from scratch :)

I got audio output on my headset working.
Audio input (recording) is sadly still not possible

bluetootd says the following when trying to record audio:
a2dp_source_cfg: no available SEP found
config failed

skype and arecord say the following as soon as I try to record audio:
ALSA lib pcm_bluetooth.c:712:(bluetooth_a2dp_hw_params)
BT_SETCONFIGURATION failed : Input/output error(5)

You can get the full bluetoothd log here: http://nopaste.ch/64aa1a77e7813e4.html

I also noticed that I can neither play nor record something when I set
profile "voice" in ~/.asoundrc
When I set it to profile "hifi" audio playback works fine.

Thanks for any help in advance
