Return-Path: <cyrus@holtmann.org>
From: "Heston James - Cold Beans" <heston.james@coldbeans.co.uk>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
References: <486BD582.9050004@aircable.net>
	<1215757212.9744.13.camel@californication>
In-Reply-To: <1215757212.9744.13.camel@californication>
Date: Fri, 11 Jul 2008 09:14:24 +0100
Message-ID: <00de01c8e32e$213a9fb0$63afdf10$@james@coldbeans.co.uk>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] CreateBonding while periodic scanning
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Manuel, good to see you mate.

>> I've sent this patch before, but for some reason I didn't got either a 
>> positive or even negative response.
>> 
>> Problem is like this, when we're doing a periodic scan we should be able 
>> to do bonding, but according to the code we can't, so then something is 
>> wrong, either we can't do periodic scanning, or we need to fix a bug.
> 
> so in general you should be able to create an ACL link when even in
> inquiry phase. So in theory it should stop periodic inquiry and then
> create the ACL link and then continue. We might have hit some chip
> limitations here and this is why it was there. I removed it since it low
> risk. No so many applications use periodic inquiry :)

I've experienced this very same behaviour in the past and was always
concerned that it was me using the mainloop inappropriately, I'm glad to see
other people find the same issue.

When using period inquiry, it would seem that if I perform any other form of
operation, such as an SDP enquiry, or creating an RFCOMM connection it halts
the current 'period' of scanning and it doesn't start again until the start
of the next 'period'.

This does cause a fair amount of frustration as it means if you're sdping
nearby remote device as you find them that you're only ever really dealing
with 1 remote device per scan period which is very inefficient.

I've noticed the exact same behaviour with a standard inquiry scan too, as
soon as attempting to perform one of these other operations whilst scanning
the scan stops and the 'discoverycomplete()' signal is emmited.

Manuel, I'm interested in the patch and will look at applying it to my local
working copy to see how it behaves for me.

Marcel, Are you saying that this issue cannot be resolved by a patch and is
a chip limitation? Is there likely to be any fix for this?

Marcel, for those of us that need a periodic enquiry, would you advocate the
use of our own internal standard inquiry loops that restart a scan when
discoverycomplete() signal is emitted? Or is this likely to crash the bluez
deamon by putting too much strain on it?

Heston


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
