Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC/PATCH] sbc: new filtering function for 8 band fixed point
 encoding
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: ext Brad Midgley <bmidgley@gmail.com>,
	Jaska Uimonen <jaska.uimonen@nokia.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <200812231245.14493.siarhei.siamashka@nokia.com>
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com>
	 <200812230130.43968.siarhei.siamashka@nokia.com>
	 <1229994015.8047.27.camel@californication>
	 <200812231245.14493.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Tue, 23 Dec 2008 12:48:08 +0100
Message-Id: <1230032888.8047.34.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> > > > We had a talk with Jaska Uimonen here, and now I'm kind of delegated to
> > > > finish the work on this filtering function for SBC encoder (including
> > > > the final addition of ARM assembly optimizations).  He provided me with
> > > > his last variant of code, which contains some more optimizations to
> > > > reduce the number of operations and also loops unrolling. I will add
> > > > his changes to the patch on next iteration.
> > > >
> > > > Now the question is how to best integrate a fixed filtering function to
> > > > git repository? If I just continue adding changes to the patch in order
> > > > to make it a faster, it will be also not so obvious to see how we got
> > > > to these code transformations just from the commit log.
> > >
> > > Next iteration done.  Added support for 4 subbands, number of arithmetic
> > > operations reduced (but without loop unrolling for better code
> > > readability), precision improved for both 16-bit and 32-bit fixed point,
> > > 'neginv' macro is now more portable and faster. The rest is in the code
> > > comments.
> >
> > I don't mind having patches as attachment, but this makes it hard to
> > review and comment on them.
> 
> I thought that as long as the attachments are plain text and 'suggest
> automatic display' property is set, there should not be much problems
> reviewing them.
> 
> I'm sorry for my incompetence in this part, but what do you recommend for
> posting patches? A link to some guide is sufficient.
> 
> Well, it is good to always learn some new things.

the kernel contains good documentation about how to send inline patches.
However as I said, I don't mind that much since I can easily apply them,
but for commenting on patches inline is easier.

> > Especially when it comes to stuff like 
> > coding style (since I have no ideas about the rest).
> >
> > +       t1[0] = t1[1] = t1[2] = t1[3] =
> > +               (FIXED_A)1 << (SBC_PROTO_FIXED4_SCALE-1);
> >
> > Should be like this: (FIXED_A) 1 << (SBC_PROTO_FIXED4_SCALE - 1);
> 
> Do you have a reference to the coding style standard guide? This
> particular
> requirement for casts and a space seems quite unusual and I have never
> seen
> it before.

It is the kernel coding style. Check Greg KH's paper from OLS some years
ago.

> OK, I'll try to fix these. Getting rid of some spaces was done to try fitting 
> some lines into 80 characters (that's also not always achieved yet).

This depends on the code. In normal code you could use continue and
break a lot, but within SBC this might not generate good binaries.

Don't try to omit whitespaces. Just don't.

Regards

Marcel


