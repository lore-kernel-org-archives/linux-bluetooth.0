Return-Path: <cyrus@holtmann.org>
Message-Id: <E13683A3-C5FF-4F4E-AD0F-F639F8369ECD@cam.ac.uk>
From: Simon Hay <sjeh3@cam.ac.uk>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1229712597.879.2.camel@californication>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Connection time behaviour question
Date: Fri, 19 Dec 2008 17:58:52 +0000
References: <B5F305E0-C554-4753-AAB5-71DA06305A1D@cam.ac.uk> <1229712597.879.2.camel@californication>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 19 Dec 2008, at 18:49, Marcel Holtmann wrote:

>
> I don't see any issue here, but the whole concept of connecting to a
> remote device to read its RSSI is broken by design. The RSSI value  
> of an
> already connection is basically useless. What you want is the link
> quality, but even that doesn't really help you since it is vendor
> specific and every company defines it differently.


Thanks for the reply.  I appreciate your point about RSSI vs link  
quality, and understand the issue there, but actually that's  
incidental to the point I'm really trying to understand - reading the  
RSSI is just something to do with the connection before I throw it  
away again.  I'm trying to get to the bottom of what's changed to  
cause the different behaviour in the connection times - why passing in  
a clock offset doesn't seem to make a difference any more, and why we  
see this regular pattern of times going up and up then jumping back  
down again.  Is there anything that was deliberately changed in this  
regard, or is it a side effect of something else?

I really appreciate all your help and patience on this!

Simon
