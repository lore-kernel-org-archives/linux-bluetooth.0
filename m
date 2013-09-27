Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: Problems with too many connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAOJw-HaHLZsbgCGi_e1ZspAf_16gKQuC6N7JM+5boWxQHCXWFQ@mail.gmail.com>
Date: Fri, 27 Sep 2013 03:53:00 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A43EED3E-8B1F-4C4C-B7A9-26065DE55928@holtmann.org>
References: <CAOJw-HaHLZsbgCGi_e1ZspAf_16gKQuC6N7JM+5boWxQHCXWFQ@mail.gmail.com>
To: Markus Roppelt <markus.roppelt@peus-testing.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Markus,

> I want to write an application which repeats the following procedure
> for several (100+) bluetooth (low energy) devices:
> 
> 1. connect
> 2. read register values
> 3. disconnect
> 
> Therefore I modified the source code from /attrib/interactive.c.  For
> testing purposes I am only looping  over one device. See attached
> source code.
> 
> The code works fine. It connects, reads the values and disconnects.
> However, after 1020 repetitions, the following error occurs:
> (process:10205): GLib-WARNING **: poll(2) failed due to: Invalid argument.
> 
> I think the problem has to do with some sockets / file descriptors not
> being closed properly.
> 
> Can someone help me to get this fixed?

have you considered trying to write this from scratch and not basing this off existing code.

And yes, this will be most likely an issues with GSource handling of the attribute IO channel, but since you hacked the code is extremely hard to debug. It was never designed for what you are doing.

Regards

Marcel

