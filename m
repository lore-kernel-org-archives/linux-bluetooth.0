Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 01 Dec 2011 11:59:47 +0100
From: krisztian.kocsis@optimaster.eu
To: Brad Midgley <bmidgley@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: Cracking Sound
In-Reply-To: <CAKLsOOP5Y+iknu8W8n7dKyJMf9DSgr71EGUDJ=JieOWKcj5k7w@mail.gmail.com>
References: <939a364c4487c47a6293b8584613af80@optimaster.eu>
 <CAKLsOOP5Y+iknu8W8n7dKyJMf9DSgr71EGUDJ=JieOWKcj5k7w@mail.gmail.com>
Message-ID: <59827824c70104e9ff397af232951b83@optimaster.eu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello!

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

Where can I find this codec? Is it part of alsa plugin or bluez or the 
headset itself?

BR,
Krisztian

