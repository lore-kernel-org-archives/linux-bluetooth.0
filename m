Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: Bluez coding style again
Date: Thu, 22 Jan 2009 17:59:37 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
References: <200901171943.45370.siarhei.siamashka@nokia.com> <200901201849.00079.siarhei.siamashka@nokia.com> <1232536882.26470.3.camel@californication>
In-Reply-To: <1232536882.26470.3.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200901221759.37087.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 21 January 2009 13:21:22 ext Marcel Holtmann wrote:
> Hi Siarhei,
>
> > > > > --- a/sbc/sbc_tables.h
> > > > > +++ b/sbc/sbc_tables.h
> > > > > @@ -161,30 +161,30 @@ static const int32_t synmatrix8[16][8] = {
> > > > >         ((FIXED_A) 1 << (sizeof(FIXED_T) * CHAR_BIT - 1)) + 0.5)
> > > > >  #define F(x) F_PROTO4(x)
> > > > >  static const FIXED_T _sbc_proto_fixed4[40] = {
> > > > > -        F(0.00000000E+00),  F(5.36548976E-04),
> > > > > +       F(0.00000000E+00),  F(5.36548976E-04),
> > > > >         -F(1.49188357E-03),  F(2.73370904E-03),
> > > > > -        F(3.83720193E-03),  F(3.89205149E-03),
> > > > > -        F(1.86581691E-03),  F(3.06012286E-03),
> > > > > +       F(3.83720193E-03),  F(3.89205149E-03),
> > > > > +       F(1.86581691E-03),  F(3.06012286E-03),
> > > >
> > > > With this latest commit, the vertical alignment of elements in tables
> > > > gets messed up and it becomes harder to see any kind of symmetry in
> > > > the tables. If the spaces are strictly forbidden, I would probably
> > > > prefer replacing them with '+' character.
> > >
> > > that would be fine with me.

Well, I tried that with the last patch (constants tweaks for audio quality
improvement), but 'checkpatch.pl' tool does not like it very much (it wants
a space between '+' operator and 'F').

[...]

> > I'm just desperately trying to do everything in a right way, but still
> > happen to violate one rule or another occasionally :)
>
> don't worry. Sometimes we have to bend the rules. The highest priority
> is readability and make patch management simple for us ;)

I just returned some spaces as they improve vertical alignment and
readability:

+	 F(2.73370904E-03 * C0),  F(5.36548976E-04 * C0),
+	-F(1.49188357E-03 * C1),  F(0.00000000E+00 * C1),
+	 F(3.83720193E-03 * C2),  F(1.09137620E-02 * C2),
+	 F(3.89205149E-03 * C3),  F(3.06012286E-03 * C3),

I hope this should be ok.

-- 
Best regards,
Siarhei Siamashka
