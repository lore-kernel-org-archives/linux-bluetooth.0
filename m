Return-Path: <vladimer@legend.me.uiuc.edu>
Date: Fri, 14 May 2004 12:50:24 -0500 (CDT)
From: Vladimeros Vladimerou <vladimer@legend.me.uiuc.edu>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] l2cap and multiple connections
In-Reply-To: <1084556506.25099.197.camel@pegasus>
Message-ID: <Pine.LNX.4.44.0405141244120.5838-100000@elegy.mie.uiuc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

Thanks Marcel, but...

> Hi Vlad,
> 
> >  I'm trying to achieve multiple l2cap channels/connections (1 master to 5
> > slaves). I'm wondering if anyone knows the method off-hand, so that I
> > won't have to look into library and kernel source. I was naively
> > trying to bind several sockets to the same address, after issuing a
> > "setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));" but
> > even if this call returns "Success", the next bind() returns
> > "Address already in use". How is this conventionally done?
> > Do I have to step down to HCI?
> 
> you should step down to a book for socket programming. Which actually
> means bind() once and accept() often ;)

  I know this is how it's normally done, but since
I was using HCI before, and connections had to be initiated by the
"master", I thought the method I mentioned was the way to use.

  So, from what your saying, I should listen() and accept() at the 
bluetooth "master"? Is there an implicit role-change command
happening somewhere, cause if I accept at the "master", otherwise,
that would mean that the connection is initiated by the "slave", which
is not as the bluetooth spec, right? How does it work?

> >  I'm also wondering if l2cap is the fastest way to send a custom 64-byte
> > message to 5 clients (real-time application). Has anyone used SCO for
> > such a purpose?
> 
> SCO is for audio data only. How often must I repeat this. Maybe eSCO is
> able to serve the real-time need, but I am not really sure about it.

"eSCO"? Never heard about that. Thanks, I'll look into that.

> 
> Regards
> 
> Marcel
> 
> 

Thanks a lot for the quick reply,
 
 -Vlad
