Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Qualification Testing
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Daryl Van Vorst <daryl@wideray.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1052545687.10456.235.camel@localhost.localdomain>
References: <000c01c313f5$b57ae030$1a01010a@baked>
	<000c01c313f5$b57ae030$1a01010a@baked>
	<5.1.0.14.2.20030508171149.01c082c0@unixmail.qualcomm.com>
	<1052442873.1069.35.camel@pegasus.local>
	<1052545687.10456.235.camel@localhost.localdomain>
Message-Id: <1052584255.1133.13.camel@pegasus.local>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 10 May 2003 18:30:48 +0200
Content-Type: text/plain

Hi Max,

> > > >>         5.) Once an RFCOMM channel is established, the IUT must exchange
> > > >> MSC's (modem status commands) before sending data. That is, it must send an
> > > >> MSC, wait for a response, wait for the sender's MSC, and respond to it
> > > >> before sending data. Our device sent an MSC and then immediately started
> > > >> sending data when we used rctest. This applies to many test cases.
> > > >
> > > >We send the MSC after the UA. But we also go into BT_CONNECTED state and
> > > >in this state you can also start sending data. We should maybe go from
> > > >BT_CONNECT -> BT_CONFIG and only switch to BT_CONNECTED after the
> > > >successful exchange of MSC.
> > > I remember thinking about that. But they way I interpreted spec was that we
> > > don't have to wait for MSC response. 
> > > This should be easy to fix.
> > 
> > I leave this up to you to fix.
> > 
> > > btw When CFC is not enabled we will have to wait for MSC from the other side. Notice that we set
> > > THROTTLED flag in that case. Which is cleared by the MSC or more credits.
> > > So I guess we can just always set that flag and clear it when we get MSC which will fix the MSC 
> > > test case without messing with the state machine.
> > 
> > Sounds reasonable to me.
> 
> Ok. I've fixed that (and pushed changes to BK). My idea about 
> with TX_THROTTLED flag didn't work. Well, it worked but only in 
> one direction :). Changing state machine would've been fairly big
> change and could've affected compatibility.
> So I added a simple logic to track MSC exchange state. Works beautifully

I like to see this logic in the state machine, but I agree with with you
that it is not the right time for changing it. Your patch works also
fine for me and I have a new 2.4.20 with all patches up and running.

Daryl, so it is now up to you to do your tests with Cetecom again and
see what we pass and what we fail. The RFCOMM layer should now perform
perfect, but the L2CAP config stuff will still fail. You can use
2.4.18-mh4 and apply these 5 patches from the bt-2.4 repository to it:

ChangeSet@1.1162, 2003-05-09 21:11:49-07:00
  [Bluetooth] RFCOMM must wait for MSC exchange to complete before sending the data.

ChangeSet@1.1161, 2003-05-09 16:41:45-07:00
  [Bluetooth] Detect and log error condition when first L2CAP fragment is too long.

ChangeSet@1.1160, 2003-05-09 11:55:22-07:00
  [Bluetooth] L2CAP config req/rsp handling fixes. 

ChangeSet@1.1126.3.2, 2003-05-09 03:22:06+02:00
  [Bluetooth] Handle priority bits in parameter negotiation

ChangeSet@1.1126.3.1, 2003-05-09 02:07:07+02:00
  [Bluetooth] Send the correct values in RPN response

Max, please go ahead and forward them to Marcelo and Linus. If you have
some extra time, please update my repositories with the new stuff.

I will make some new -mh patches on monday or tuesday.

Regards

Marcel




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
