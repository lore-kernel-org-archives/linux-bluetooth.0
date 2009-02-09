Return-Path: <cyrus@holtmann.org>
Subject: Re: Turn off the bluetooth headset during audio playback via a2dp.
From: Marcel Holtmann <marcel@holtmann.org>
To: =?UTF-8?Q?=E5=8D=9E=E7=A3=8A?= <mykofzone@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <a172fe730902090351m6245a9f8uc39c2776752bcd9f@mail.gmail.com>
References: <a172fe730902090351m6245a9f8uc39c2776752bcd9f@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 09 Feb 2009 13:29:39 +0100
Message-Id: <1234182579.4705.6.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

>      If a2dp channel was disconnected during the audio playback , i
> wanted to swtich the path to audiocard.
> But after a2dp channel disconnect , "aplay" or "helix" would be hold
> and can not exit normally. (I want to close the bluetooth device ,then
> open a new audiocard device.)
> How to fix this issue and is there other method to switch between
> bluetooth headset and audiocard dynamically during audio playback via
> a2dp?

you should use an audio server like PulseAudio for this. ALSA is not
really designed for these use cases.

Regards

Marcel


