Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030612102711.0b283180@unixmail.qualcomm.com>
Date: Thu, 12 Jun 2003 11:08:10 -0700
To: "Daryl Van Vorst" <daryl@wideray.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification Testing
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001b01c32634$d3cd5530$1a01010a@baked>
References: <5.1.0.14.2.20030519141834.0951b330@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 03:51 PM 5/29/2003, Daryl Van Vorst wrote:
>Max,
>
>Here's where we're at with this one:  We either need to pass this test, or
>issue an erratum. Issuing an erratum is going to be a very time-consuming
>task and we can't be certain of the outcome.
>
>About the only scenario we could come up with where this makes any sense at
>all is if the remote device wants to send data larger than the default MTU
>of 672, and the local application doesn't specifically tell the stack that
>it can handle a larger MTU before calling connect().  Is it in our interest
>to handle this?
If an application does not explicitly tell us that it supports larger MTU
then it does not support it. As simple as that :).
We don't play "guess what MTU I support" games ;-). 

>Is it possible to give the app control during the CONFIG state so that it
>can do the negotiation with the remote side? Am I correct in assuming that
>as it is now the app only gets control once we enter the OPEN state?
See, the L2CAP spec defines this ""very nice"" :) API with a bunch of callbacks 
which propagate config requests to the application. This means that every
single L2CAP application (even a simple one) has to have exact same code to 
handle L2CAP configuration. We don't do that. If app supports MTU other than 
default it explicitly sets it with setsockopt() and we send that MTU in the 
very first config request.

>Perhaps we could put in a "hack" (if we're going to call it that) which
>allows us to pass the test. We could, at the same time, write up an errata
>requesting that this test be optional or changed so that we would pass the
>test without the "hack". Once the erratum is accepted, we could remove the
>hack.
>
>Is there any chance that you could make this change?  Or, if not, could you
>help me determine where in the code to do it? 
Sure we can make a hack. Once we agree on how should we handle it I'll make 
the change. But if the hack affects general case we're not going to put it 
into official kernel.

>The behaviour that would make it pass is as follows:
>
>1. We send a config request.
>2. We get a config response rejecting our request which contains the
>tester's desired values.
>3. We re-send the config request with those values (the tester will accept
>this request).
>4. At this point if the config request is not accepted we can close the link
>like we would normally.
>
>Maybe we could add a setsockopt() l2cap option like LM_FLEXIBLEINMTU to turn
>on this behaviour (not sure if making it optional will pass - I'll check).
If we don't make it optional then it will certainly affect general case because 
we cannot accept whatever the other side sends us.

>Apparently, in step 3 above, if we send a config request with no options it
>will also pass the test. How silly is that? (specially considering that's
>what we send by default in the first place!)
I'm pretty sure that it's just because they use some dumb tester implementation.
It doesn't make sense to resend the same config request.

Comments ?

Max
  


 
