Return-Path: <strikewing16th@hotmail.com>
From: "Anthony Yulo" <strikewing16th@hotmail.com>
To: marcel@holtmann.org, bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] multiple connections on rfcomM?
Date: Fri, 12 Dec 2003 08:23:16 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law11-F23jdb5IBf53a00030f69@hotmail.com>
List-ID: <bluez-devel.lists.sourceforge.net>

Hello..

i'd like to use C++, but are there any classes made already to encapsulate 
bluetooth functions? none yet ryt? i'll have to do classes myself but then 
again i'll still use C to do it...

aniwei, id like to low-level C more.. so its ok..

another question regarding this topic...
This is the set-up:
1st pda initiates connection to the desktop server.. and then remain 
connected for a while.. My Question is would the desktop server still be 
searchable/discoverable by other devices while its
connected to the 1st pda?

I tried to test this setup using WIDCOMM stack and used the API's in it...
First I launched the sample RFCOMM server program and then assigned an 
SCN... and then i connected the 1st pda using device/service discovery 
procedures...

Next I launched a new instance of that RFCOMM server program but this time 
with a different SCN... when a 2nd pda tries to search for the server, it 
doesn't find the server anymore..







>From: Marcel Holtmann <marcel@holtmann.org>
>To: Anthony Yulo <strikewing16th@hotmail.com>
>CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
>Subject: Re: [Bluez-devel] multiple connections on rfcomM?
>Date: Fri, 12 Dec 2003 04:35:06 +0100
>
>Hi Anthony,
>
> > so this project is very easy to do huh!!?!:)
> > how do i multiplex?, do i use fork()? select()? :)
>
>use what you like. I would prefer some kind of event loop, because it
>makes your code simpler, but even forking or poll()/select() is fine.
>
> > hehe... sorry for the silly questions, just a newbie in bluez, in socket
> > programming?
> > my background in c is not very deep.. i'm more familiar with C++.. so
> > sorry..:)
>
>You can use C++ if you like. I don't like C++, so I would never use it.
>
>Regards
>
>Marcel
>
>

_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail
