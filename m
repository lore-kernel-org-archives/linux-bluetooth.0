Return-Path: <daryl@wideray.com>
Date: Thu, 08 May 2003 15:06:13 -0700
From: Daryl Van Vorst <daryl@wideray.com>
Subject: RE: [Bluez-devel] Qualification Testing
In-reply-to: <000801c3158d$497da950$5796fea9@baked>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Errors-to: daryl@wideray.com
Message-id: <001301c315ae$0a6415d0$5796fea9@baked>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

Here's Cetecom's response:

"Yes, that's the way it should be.

SABM (DLCI0)
UA
SABM (DLCIn)
UA
MSC exchange (IUT initiated)
MSC exchange (Tester inititated)
Send data"

-Daryl.

> > >         5.) Once an RFCOMM channel is established, the IUT must
> > > exchange MSC's (modem status commands) before sending data. 
> > That is,
> > > it must send an MSC, wait for a response, wait for the
> > sender's MSC,
> > > and respond to it before sending data. Our device sent an
> > MSC and then
> > > immediately started sending data when we used rctest. This
> > applies to
> > > many test cases.
> > 
> > We send the MSC after the UA. But we also go into
> > BT_CONNECTED state and in this state you can also start 
> > sending data. We should maybe go from BT_CONNECT -> BT_CONFIG 
> > and only switch to BT_CONNECTED after the successful 
> exchange of MSC.
> 
> That sounds good to me. Not sure about the UA though... I'll 
> check on it.
