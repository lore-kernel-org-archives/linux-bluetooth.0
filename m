Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030514093502.0d45fe08@unixmail.qualcomm.com>
Date: Wed, 14 May 2003 09:38:59 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] RFCOMM server problem
In-Reply-To: <1052870730.4609.31.camel@pegasus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 05:05 PM 5/13/2003, Marcel Holtmann wrote:
>Hi Max,
>
>if I set up a RFCOMM server on a 2.4.20-mh7 (plus all new patches) and
>try to connect from another machine which runs 2.4.20-mh6, the
>communications stops after the initial SABM for dlci 0. The server
>didn't send the UA for this dlci. The connection establishment fails
>because of the timeout. If I don't start the server and try to establish
>the connection I see the UA for dlci 0. If I change the direction and
>put the server on the machine with the older kernel all is working fine.
>
>Any idea what is going wrong?
Sounds weird. MSC,RLS,etc changes couldn't affect that. On my machines
everything works as expected. I'll test again.
Make sure you recompiled everything in RFCOMM module. We changed dlc struct 
a bit may be something like rfcomm/sock.c wasn't recompiled and still uses 
old struct. I can't think of anything else at this point.

Max
