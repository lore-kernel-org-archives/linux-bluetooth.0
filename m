Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKk=RZERiZfD02mtW7sZg2G+R1cOHBfT9BU8CETHJcPyw@mail.gmail.com>
References: <1448622711-17562-1-git-send-email-lukasz.rymanowski@codecoup.pl>
	<1448622711-17562-2-git-send-email-lukasz.rymanowski@codecoup.pl>
	<CABBYNZKk=RZERiZfD02mtW7sZg2G+R1cOHBfT9BU8CETHJcPyw@mail.gmail.com>
Date: Thu, 3 Dec 2015 22:08:02 +0100
Message-ID: <CAExxLLDo44eLdFnM_mmbdiWoPK-Y16K48W=79gSCLT0K5p2i6w@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] unit/test-gatt: Fix long write testcases
From: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Dec 3, 2015 at 10:27 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Łukasz,
>
> On Fri, Nov 27, 2015 at 1:11 PM, Łukasz Rymanowski
> <lukasz.rymanowski@codecoup.pl> wrote:
> > Idea of long write is that each part of data is continuation
> > of previous one. There shall be not gaps in the offsets between.
> >
> > If there are gaps in offset then we have reliable write rather than
> > long write
>
> The patch looks fine what I did not understand is what different it
> makes if it is a reliable write or a long write, to me all long writes
> are in fact reliable write since it does use prepare + execute, the
> fact that only one handle is written doesn't change anything.
>

These testes are for Long write and there is a difference between Long Write and
Reliable Write even those two use prepare/execute writes. This can be
found in the
BT Spec Chapter 3 Part G, 4.9.4  and 4.9.5

Basically those procedure belongs to GATT and our gatt server should
understand that.

If we are going to not expose prepare/execute wirtes to application,
then this is GATT server which should
recognize procedure and prepare data to be written to application.
i.e. for long write do aggregation of all
prepare writes, we can not just write part of data as this would cause
some unexpected behavior.

We also need this change, because following patches will start to test
for characteristic extended properties
descriptor and do not allow reliable write on characteristics which
does not have property for this.
Note that for Long Write we don't need this descriptor property, so
these test cases would fail then.

Also, note that there is Long Write procedure for descriptors but
there is no Reliable Write procedure for
descriptors, so we definitely cannot treat long and prepare as the same one.


> > ---
> >  unit/test-gatt.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> > index 326a32c..70b6de5 100644
> > --- a/unit/test-gatt.c
> > +++ b/unit/test-gatt.c
> > @@ -3852,8 +3852,8 @@ int main(int argc, char *argv[])
> >                         raw_pdu(0x17, 0x03, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff,
> >                                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> >                                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff),
> > -                       raw_pdu(0x16, 0x03, 0x00, 0x3f, 0x00, 0xff),
> > -                       raw_pdu(0x17, 0x03, 0x00, 0x3f, 0x00, 0xff),
> > +                       raw_pdu(0x16, 0x03, 0x00, 0x12, 0x00, 0xff),
> > +                       raw_pdu(0x17, 0x03, 0x00, 0x12, 0x00, 0xff),
> >                         raw_pdu(0x18, 0x01),
> >                         raw_pdu(0x19));
> >
> > @@ -3866,8 +3866,8 @@ int main(int argc, char *argv[])
> >                         raw_pdu(0x17, 0x82, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff,
> >                                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> >                                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff),
> > -                       raw_pdu(0x16, 0x82, 0x00, 0x3f, 0x00, 0xff),
> > -                       raw_pdu(0x17, 0x82, 0x00, 0x3f, 0x00, 0xff),
> > +                       raw_pdu(0x16, 0x82, 0x00, 0x12, 0x00, 0xff),
> > +                       raw_pdu(0x17, 0x82, 0x00, 0x12, 0x00, 0xff),
> >                         raw_pdu(0x18, 0x01),
> >                         raw_pdu(0x19));
> >
> > @@ -4374,8 +4374,8 @@ int main(int argc, char *argv[])
> >                         raw_pdu(0x17, 0x04, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff,
> >                                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> >                                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff),
> > -                       raw_pdu(0x16, 0x04, 0x00, 0x3f, 0x00, 0xff),
> > -                       raw_pdu(0x17, 0x04, 0x00, 0x3f, 0x00, 0xff),
> > +                       raw_pdu(0x16, 0x04, 0x00, 0x12, 0x00, 0xff),
> > +                       raw_pdu(0x17, 0x04, 0x00, 0x12, 0x00, 0xff),
> >                         raw_pdu(0x18, 0x01),
> >                         raw_pdu(0x19));
> >
> > @@ -4388,8 +4388,8 @@ int main(int argc, char *argv[])
> >                         raw_pdu(0x17, 0x83, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff,
> >                                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> >                                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff),
> > -                       raw_pdu(0x16, 0x83, 0x00, 0x3f, 0x00, 0xff),
> > -                       raw_pdu(0x17, 0x83, 0x00, 0x3f, 0x00, 0xff),
> > +                       raw_pdu(0x16, 0x83, 0x00, 0x12, 0x00, 0xff),
> > +                       raw_pdu(0x17, 0x83, 0x00, 0x12, 0x00, 0xff),
> >                         raw_pdu(0x18, 0x01),
> >                         raw_pdu(0x19));
> >
> > --
> > 2.5.0
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz




-- 
BR / Pozdrawiam
Łukasz
