Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 01 Dec 2011 15:47:23 +0100
From: krisztian.kocsis@optimaster.eu
To: Brad Midgley <bmidgley@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: Cracking Sound
In-Reply-To: <CAKLsOOP5Y+iknu8W8n7dKyJMf9DSgr71EGUDJ=JieOWKcj5k7w@mail.gmail.com>
References: <939a364c4487c47a6293b8584613af80@optimaster.eu>
 <CAKLsOOP5Y+iknu8W8n7dKyJMf9DSgr71EGUDJ=JieOWKcj5k7w@mail.gmail.com>
Message-ID: <4a14bf18fa55f35e383e545b1d39f748@optimaster.eu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

It seems that both alsa and bluez correctly detects that I'm using a 
big endian machine.
I'v tried to play a WAV files which was converted to big endian format 
but the resutl was the same.
It seems that the problem is something else. :(

BR,
Krisztian

On Wed, 30 Nov 2011 15:52:19 -0700, Brad Midgley wrote:
> Hi
>
>> When BlueZ is connecting to the device I hear a beep in the headset 
>> but the
>> "stream" is only a cracking, clicking and poping noise, nothing from 
>> the
>> original sound.
>
> the codec has byte order issues. Most everyone runs even embedded
> devices in little endian mode.

