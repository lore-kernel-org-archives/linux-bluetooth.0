Return-Path: <cyrus@holtmann.org>
Subject: Re: Connection time behaviour question
From: Marcel Holtmann <marcel@holtmann.org>
To: Simon Hay <sjeh3@cam.ac.uk>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <B5F305E0-C554-4753-AAB5-71DA06305A1D@cam.ac.uk>
References: <B5F305E0-C554-4753-AAB5-71DA06305A1D@cam.ac.uk>
Content-Type: text/plain
Date: Fri, 19 Dec 2008 19:49:57 +0100
Message-Id: <1229712597.879.2.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Simon,

> I have a question about behaviour establishing connections that seems  
> to have changed between different versions of BlueZ, and I'm hoping  
> someone will be good enough to help explain what's going on for me!
> 
> I have a test program that opens an L2CAP connection to a device,  
> reads the RSSI, closes it again, waits a few seconds and repeats the  
> process.  Optionally, it will do clock caching - i.e. read the clock  
> offset when a connection is established and pass this in when making  
> the next connection.  Using version 3.18 the BlueZ libraries, this  
> behaves more or less as I would expect:  if clock caching is not  
> turned on, the connection times are distributed fairly evenly and if  
> it is they are much quicker and fairly constant (e.g. 1300 ms, plus or  
> minus a hundred or so for a particular device).  Using various  
> subsequent versions however (in particular 3.29 and 4.22) we see  
> different behaviour: whether clock caching is turned on or not, the  
> connection times follow a sawtooth pattern, starting very low (about  
> 100 ms), then going up steadily in increments of a couple of hundred  
> ms until they reach a peak (1000-2000) and then fall back to a very  
> low value and the process repeats.  I'm somewhat confused as to why  
> this is happening - I've tried to read through the code changes but  
> without much success.  Can anyone shed any light on this for me?

I don't see any issue here, but the whole concept of connecting to a
remote device to read its RSSI is broken by design. The RSSI value of an
already connection is basically useless. What you want is the link
quality, but even that doesn't really help you since it is vendor
specific and every company defines it differently.

Regards

Marcel


