Return-Path: <cyrus@holtmann.org>
Message-ID: <1347154710.26623.3.camel@maxim-laptop>
Subject: Re: Setting up an A2DP server
From: Maxim Levitsky <maximlevitsky@gmail.com>
To: Niklas Claesson <nicke.claesson@gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Date: Sun, 09 Sep 2012 04:38:30 +0300
In-Reply-To: <CAAHv3KF8Vnz+iT0_OviJqUYUrNH=2ygMNH-GAxhc5H=H89euTw@mail.gmail.com>
References: <CAAHv3KHnRM=7WYgy-teqUZfFYNoGPdkOb0dgf3t4XiuYtoUOOA@mail.gmail.com>
	 <CAAHv3KG6NteONyJ1oM9Lakc=iMBGc0OZvpDKB-YTeN7ugjvd2w@mail.gmail.com>
	 <CAMOw1v5vTZpCYwCMSZjUmGYE65W63rKVH8r5_6Z43reNrPq02w@mail.gmail.com>
	 <CAAHv3KF8Vnz+iT0_OviJqUYUrNH=2ygMNH-GAxhc5H=H89euTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2012-08-21 at 17:13 +0200, Niklas Claesson wrote: 
> 2012/8/20 Lucas De Marchi <lucas.demarchi@profusion.mobi>:
> > On Fri, Aug 17, 2012 at 6:50 PM, Niklas Claesson
> > <nicke.claesson@gmail.com> wrote:
> >> I've actually solved the issue myself by writing an Agent that accepts
> >
> > You could mark the device as trusted, so you don't have to do this.
> 
> I don't know which devices will connect, perhaps I could mark all
> nearby devices as trusted. But I don't know how I would do that.
> 
> >
> >
> >> all incoming requests, and another python script that polls 'pacmd
> >> list-sources' every 2 seconds for new bluetooth sources. And third and
> >
> > Why do you need this?
> 
> I have to set the bluetooth device as current source in Pulseaudio

I am also affected by this exact issue.
I also want to make my system be a 'A2DP' headset.
I managed to do so, but only when I initiate the connection from the
system, and using awkward dbus command.
When however I try to connect to it from my tablet nothing happens.

Any pointers will be welcome.

Best regards,
Maxim Levitsky

