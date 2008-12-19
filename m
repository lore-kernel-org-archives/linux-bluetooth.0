Return-Path: <cyrus@holtmann.org>
Subject: Re: Connection time behaviour question
From: Marcel Holtmann <marcel@holtmann.org>
To: Simon Hay <sjeh3@cam.ac.uk>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <E13683A3-C5FF-4F4E-AD0F-F639F8369ECD@cam.ac.uk>
References: <B5F305E0-C554-4753-AAB5-71DA06305A1D@cam.ac.uk>
	 <1229712597.879.2.camel@californication>
	 <E13683A3-C5FF-4F4E-AD0F-F639F8369ECD@cam.ac.uk>
Content-Type: text/plain
Date: Fri, 19 Dec 2008 20:06:12 +0100
Message-Id: <1229713572.879.15.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Simon,

> > I don't see any issue here, but the whole concept of connecting to a
> > remote device to read its RSSI is broken by design. The RSSI value  
> > of an
> > already connection is basically useless. What you want is the link
> > quality, but even that doesn't really help you since it is vendor
> > specific and every company defines it differently.
> 
> 
> Thanks for the reply.  I appreciate your point about RSSI vs link  
> quality, and understand the issue there, but actually that's  
> incidental to the point I'm really trying to understand - reading the  
> RSSI is just something to do with the connection before I throw it  
> away again.  I'm trying to get to the bottom of what's changed to  
> cause the different behaviour in the connection times - why passing in  
> a clock offset doesn't seem to make a difference any more, and why we  
> see this regular pattern of times going up and up then jumping back  
> down again.  Is there anything that was deliberately changed in this  
> regard, or is it a side effect of something else?

you can't pass in the clock offset except you use the low-level HCI
Create Connection command. And that is not guaranteed to work as
expected at all. The kernel has full control over these information and
you should not mess with it. However when reading the clock offset of a
remote connection the kernel will store that clock offset and reuse
during the next connection attempt. You have to create proper L2CAP
connections and not just fake them via HCI Create Connection.

Regards

Marcel


