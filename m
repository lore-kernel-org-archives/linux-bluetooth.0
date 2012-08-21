Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v5vTZpCYwCMSZjUmGYE65W63rKVH8r5_6Z43reNrPq02w@mail.gmail.com>
References: <CAAHv3KHnRM=7WYgy-teqUZfFYNoGPdkOb0dgf3t4XiuYtoUOOA@mail.gmail.com>
	<CAAHv3KG6NteONyJ1oM9Lakc=iMBGc0OZvpDKB-YTeN7ugjvd2w@mail.gmail.com>
	<CAMOw1v5vTZpCYwCMSZjUmGYE65W63rKVH8r5_6Z43reNrPq02w@mail.gmail.com>
Date: Tue, 21 Aug 2012 17:13:46 +0200
Message-ID: <CAAHv3KF8Vnz+iT0_OviJqUYUrNH=2ygMNH-GAxhc5H=H89euTw@mail.gmail.com>
Subject: Re: Setting up an A2DP server
From: Niklas Claesson <nicke.claesson@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2012/8/20 Lucas De Marchi <lucas.demarchi@profusion.mobi>:
> On Fri, Aug 17, 2012 at 6:50 PM, Niklas Claesson
> <nicke.claesson@gmail.com> wrote:
>> I've actually solved the issue myself by writing an Agent that accepts
>
> You could mark the device as trusted, so you don't have to do this.

I don't know which devices will connect, perhaps I could mark all
nearby devices as trusted. But I don't know how I would do that.

>
>
>> all incoming requests, and another python script that polls 'pacmd
>> list-sources' every 2 seconds for new bluetooth sources. And third and
>
> Why do you need this?

I have to set the bluetooth device as current source in Pulseaudio.

>
>
> Lucas De Marchi

Niklas Claesson
