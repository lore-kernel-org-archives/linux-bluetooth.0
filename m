Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluez coding style again
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <200901201849.00079.siarhei.siamashka@nokia.com>
References: <200901171943.45370.siarhei.siamashka@nokia.com>
	 <1232291292.5095.9.camel@californication>
	 <200901201849.00079.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Wed, 21 Jan 2009 12:21:22 +0100
Message-Id: <1232536882.26470.3.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> > > > --- a/sbc/sbc_tables.h
> > > > +++ b/sbc/sbc_tables.h
> > > > @@ -161,30 +161,30 @@ static const int32_t synmatrix8[16][8] = {
> > > >         ((FIXED_A) 1 << (sizeof(FIXED_T) * CHAR_BIT - 1)) + 0.5)
> > > >  #define F(x) F_PROTO4(x)
> > > >  static const FIXED_T _sbc_proto_fixed4[40] = {
> > > > -        F(0.00000000E+00),  F(5.36548976E-04),
> > > > +       F(0.00000000E+00),  F(5.36548976E-04),
> > > >         -F(1.49188357E-03),  F(2.73370904E-03),
> > > > -        F(3.83720193E-03),  F(3.89205149E-03),
> > > > -        F(1.86581691E-03),  F(3.06012286E-03),
> > > > +       F(3.83720193E-03),  F(3.89205149E-03),
> > > > +       F(1.86581691E-03),  F(3.06012286E-03),
> > >
> > > With this latest commit, the vertical alignment of elements in tables
> > > gets messed up and it becomes harder to see any kind of symmetry in the
> > > tables. If the spaces are strictly forbidden, I would probably prefer
> > > replacing them with '+' character.
> >
> > that would be fine with me.
> >
> > > Anyway, with this requirement also in effect, it makes harder to use the
> > > standard 'checkpatch.pl' from linux distribution as you have to watch for
> > > a lot more stuff which can get through.
> > >
> > > Adding --strict option to 'checkpatch.pl' only also reports something
> > > like:
> > >
> > > CHECK: multiple assignments should be avoided
> > > #623: FILE: sbc/sbc_primitives.c:381:
> > > +       x[159] = x[31] = pcm[0 + 2];
> > >
> > > CHECK: architecture specific defines should be avoided
> > > #475: FILE: sbc/sbc_primitives_mmx.h:31:
> > > +#if defined(__GNUC__) && (defined(__i386__) || defined(__amd64__)) && \
> > >
> > >
> > > I have learned the following extra bluez coding style requirements over
> > > the standard linux coding style up to now:
> > > 1. Space is required for cast operation, ex. '(int) x'
> > > 2. Indentation between '#' and 'define' is forbidden
> > > 3. Any kind of leading spaces are forbidden
> > >
> > > Have I missed something else?
> > >
> > > Anyway, does it make sense to introduce a modified variant of
> > > 'checkpatch.pl'? Or probably somebody has done it already, but did not
> > > care to share with everyone else? :)
> >
> > Not sure about checkpatch.pl, but the BlueZ coding style is mainly
> > enforced by Johan and me. In some cases you have to break, but that
> > should only happen if there is no other choice. 99% of the time you just
> > can simplify your code. However I happily admit that with codec work
> > this might not always be true.
> 
> OK, I see. Thanks for the explanation.
> 
> Script 'checkpatch.pl' from the linux kernel is quite convenient because it
> detects most of the coding style problems automatically and saves some
> of the time when preparing a patch.
> 
> I'm just desperately trying to do everything in a right way, but still happen
> to violate one rule or another occasionally :)

don't worry. Sometimes we have to bend the rules. The highest priority
is readability and make patch management simple for us ;)

Regards

Marcel


