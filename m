Return-Path: <akmr2000@yahoo.com>
Message-ID: <20030820195027.49462.qmail@web10203.mail.yahoo.com>
Date: Wed, 20 Aug 2003 12:50:27 -0700 (PDT)
From: Aarti Kumar <akmr2000@yahoo.com>
Subject: Re: [Bluez-devel] avdtp over l2cap
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1061397856.10680.100.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Hi,
So you suggest that i can have the implementation of
audio video tranport protocol in the userspace itself.
This means that i dont need to have socket ineterface
for audio video distribution protocol , instead i will
have the program which will be using l2cap sockets and
forming a connection between two devices.

What i think is audio video tranfer protocol should be
implemented as module (like bnep, rfcomm and sco) and
regisered in bluetooth stack. The profile development
or the application using this will be in userspace
(like pand and sdp).

Thats it for now.
Thanks,
Aarti.
--- Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
wrote:
> Hi Aarti,
> 
> > I am trying place avdtp layer over l2cap layer
> with
> > the existing bluez stack.
> > I have just come up with basic socket
> implementation
> > for avdtp. 
> > I am not sure whether existing l2cap layer
> supports
> > avdp, and whether i need to make any changes to
> it. As
> > far as i could understand all the layers above
> l2cap
> > have there psm set, and l2cap layer is not aware
> of
> > these values. 
> > I understand the BTPROTO has been defined for
> > l2cap,rfcomm,bnep, sco from 0-4 and while
> registering
> > it checks for the value less than 5, so if need to
> > register avdtp as BTPROTO_AVDTP 5 , i have to
> modify
> > the condition.
> > What else do i need to do , so that i can send and
> > receive messages through avdtp sockets ? 
> > Also I am not sure about the Socket Option level
> > (SOL_AVDTP) value for AVDTP ?
> > I quite new to this kernel programming stuff , so
> > pardon me if my question is too naive .
> 
> some time ago I also looked at the AVDTP and you
> don't need to write a
> kernel module for it. It can be done in userspace
> like SDP, OBEX, HCRP
> etc.
> 
> Regards
> 
> Marcel
> 
> 


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
