Return-Path: <cyrus@holtmann.org>
Subject: Re: CVSD Audio Playing on PC
From: Marcel Holtmann <marcel@holtmann.org>
To: Kartikey Parmar <kartikey2781@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <6887eb5d0902092205p7b31b48bud1c0c2d2abd272bd@mail.gmail.com>
References: <6887eb5d0902092205p7b31b48bud1c0c2d2abd272bd@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 10 Feb 2009 16:38:02 +0100
Message-Id: <1234280282.12847.31.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kartikey,

> I m working on a project which will receive CVSD quality audio signals
> from Bluetooth Headset and stores in a read buffer.
> Now after I receive those samples I want to play it on remote PC
> connected to local network running under either Linux or windows.
> I m little confused about CVSD to WAV / mp3 converter which is
> supported on the remote end.
> If there is any idea, kindly tell me.

the CVSD codec is only used over the air. The host stack receive either
PCM, aLaw or muLaw encodings. Mostly it is just plain PCM with 8 kHz
with either 8-bit or 16-bit.

Regards

Marcel


