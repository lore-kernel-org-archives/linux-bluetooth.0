Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Qualification testing.
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <002501c4d73d$2cd35200$1a01010a@baked>
References: <002501c4d73d$2cd35200$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1101883367.18840.31.camel@pegasus>
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
Date: Wed, 01 Dec 2004 07:42:46 +0100

Hi Daryl,

> Another round of qualification testing has begun. The results so far seem
> much less painful this time. :)
> 
> So far there is one definite failure. There are a couple others which are
> being debated. All of these have appeared because the tests have changed
> slightly since (or weren't required) the last time we tested.

lets go ahead and fix them all.

> Test COS/CFD/BV-12 fails because the IUT does not send result=3 in an l2cap
> config response upon reception of an unknown option. Apparently we didn't
> have to do this test last time. And it's clear in the code why it fails:
> l2cap.c: /* FIXME: Reject unknown option */
> 
> I noticed in the spec that the response must contain the offending options:
> 
> "On an unknown option failure (Result=0x0003), the option types not
> understood
> by the recipient of the Request must be included in the Response.
> Note that hints (defined in Section 6 on page 297), those options in the
> Request that are skipped if not understood, must not be included in the
> Response and must not be the sole cause for rejecting the Request."
> 
> I've been staring at the code pondering how to fix this cleanly. I've
> attached an attempt at fixing it. The fix is not quite complete because I
> believe it has a buffer overflow vulnerability. It is not fully tested
> either. But I figured it was best to run it by you before going too far
> because more than likely you'll want to change something. ;)

to be honest, I am already aware of this problem. I ran into it when I
first started to look at the support for L2CAP retransmission and flow
control. Our current way of handling the configuration must be changed
to deal better with L2CAP 1.2 devices and their features. It is not that
easy to change and my time was too limited for it. However I am open for
any ideas and I am sorry to say that, but your patch looks like a dirty
hack.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
