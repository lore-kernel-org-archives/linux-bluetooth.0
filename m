Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Broadcast A2DP
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050523121022.83208.qmail@web8307.mail.in.yahoo.com>
References: <20050523121022.83208.qmail@web8307.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1116850978.30044.72.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 23 May 2005 14:22:58 +0200

Hi Mayank,

> > > Is it possible to develop an application, that
> > will
> > > broadcast a2dp stream to more than 1 sink?
> > 
> > it will be possible.
> > 
> > > What I want to know is that whether sufficient
> > > bandwidth will be there or not?
> > 
> > I think it is not and besides this you might get
> > into problems if you
> > create a scatternet. Most headphones I have seen
> > require to be a master
> > of a piconet. Thus means that the source will create
> > a scatternet and
> > the link manager must use hold mode to switch
> > between both piconets. In
> > all my tests this was not working very good.
> 
> Consider the simple case, when the headphones will not
> want to become the master of the piconet, so, there
> will be only a single piconet with the a2dp source as
> the master. Thus no scatternet.
> (IVT's BlueSoleil, for instance, does not require to
> be master)
> 
> Now, my question is, whether I can send a broadcast
> packet on the L2CAP layer. If yes, then how?
> 
> Or will I have to send packets one after the other to
> all the sinks. If this is the case then I'm afraid
> that we'll face shortage of bandwidth, cause after sbc
> encoding, bit rates are no less than 210 kbps, which
> means that no more than 3 sinks can be supported (for
> a bandwidth of 723 kbps).

I think you have to do it this way. If you get into bandwidth problems,
then use more dongles.

> Also, I read somewhere that at L2CAP level, we can
> form groups similar to IGMP. Is that true? or rather,
> is it there in Bluez?

You mean the L2CAP connection less channel. We have basic support for
it, but not really the group management part. However what you need for
real broadcast is broadcast support on the HCI level. Otherwise the
kernel have to emulate the broadcast for you and this is the same as
above.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
