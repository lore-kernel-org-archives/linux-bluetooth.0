Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com
References: <1418212008-8594-1-git-send-email-gowtham.ab@samsung.com>
 <1418212008-8594-2-git-send-email-gowtham.ab@samsung.com>
 <CABBYNZJrV1viDu62Ndr2Davv_52tKmByLwNtQqSRUXN0j1mZww@mail.gmail.com>
 <003501d01868$fbab5740$f30205c0$@samsung.com>
In-reply-to: <003501d01868$fbab5740$f30205c0$@samsung.com>
Subject: RE: [PATCH 1/3] monitor/packet: Fix ERROR CODES as per core_v4.2
Date: Wed, 17 Dec 2014 11:55:00 +0530
Message-id: <000001d019c2$3452b610$9cf82230$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Monday, December 15, 2014 6:43 PM
> To: 'Luiz Augusto von Dentz'
> Cc: linux-bluetooth@vger.kernel.org; 'Dmitry Kasatkin'; 'Bharat Panda';
> cpgs@samsung.com
> Subject: RE: [PATCH 1/3] monitor/packet: Fix ERROR CODES as per core_v4.2
> 
> Hi Luiz,
> 
> > -----Original Message-----
> > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> > owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> > Sent: Thursday, December 11, 2014 5:49 PM
> > To: Gowtham Anandha Babu
> > Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; Bharat Panda;
> > cpgs@samsung.com
> > Subject: Re: [PATCH 1/3] monitor/packet: Fix ERROR CODES as per
> > core_v4.2
> >
> > Hi Gowtham,
> >
> > On Wed, Dec 10, 2014 at 1:46 PM, Gowtham Anandha Babu
> > <gowtham.ab@samsung.com> wrote:
> > > Modified the error codes as per core V4.2, Vol 2, Part D.
> > > ---
> > >  monitor/packet.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/monitor/packet.c b/monitor/packet.c index
> > > 885c4b1..87b97ad 100644
> > > --- a/monitor/packet.c
> > > +++ b/monitor/packet.c
> > > @@ -317,9 +317,10 @@ static const struct {
> > >         { 0x1b, "SCO Offset Rejected"                                   },
> > >         { 0x1c, "SCO Interval Rejected"                                 },
> > >         { 0x1d, "SCO Air Mode Rejected"                                 },
> > > -       { 0x1e, "Invalid LMP Parameters"                                },
> > > +       { 0x1e, "Invalid LMP Parameters / Invalid LL Parameters"        },
> > >         { 0x1f, "Unspecified Error"                                     },
> > > -       { 0x20, "Unsupported LMP Parameter Value"                       },
> > > +       { 0x20, "Unsupported LMP Parameter Value / "
> > > +               "Unsupported LL Parameter Value"                        },
> >
> > Perhaps just having LMP/LL instead of duplicating the whole string is
> > a better idea, usually the spec would not change a meaning of an error
> > or is LL LE specific?
> 
> Here LMP refers to LMP PDU, LL refers to LL control PDU.
> I think changing it into LMP/LL is also a good idea.
> But, It's safer to follow the specification.
> What do you think?
> 
> >
> > >         { 0x21, "Role Change Not Allowed"                               },
> > >         { 0x22, "LMP Response Timeout / LL Response Timeout"            },
> > >         { 0x23, "LMP Error Transaction Collision"                       },
> > > @@ -346,7 +347,7 @@ static const struct {
> > >         { 0x38, "Host Busy - Pairing"                                   },
> > >         { 0x39, "Connection Rejected due to No Suitable Channel Found"  },
> > >         { 0x3a, "Controller Busy"                                       },
> > > -       { 0x3b, "Unacceptable Connection Interval"                      },
> > > +       { 0x3b, "Unacceptable Connection Parameters"                    },
> >
> > This as well need a bit more explanation, when this has changed or
> > perhaps we got it wrong to begin with?
> 
> It is mentioned in (Errata ID: 5660).
> https://www.bluetooth.org/errata/errata_view.cfm?errata_id=5660
> (Requires Login).
> 
> Description of that errata:
> The title of 2.56 is "Unacceptable Connection Parameters (0x3B)".
> 
> However, the text begins "The Unacceptable Connection IntervalParameters
> error code" (sic). HCI 7.1.6 (Disconnect Command) refers to "Unacceptable
> Connection Interval error code (0x3B)". Volume 6 has two references to
> "error code 0x3B (Unacceptable Connection Parameters)".
> 
> I propose we change the text of 2.56 and of 7.16 to "Unacceptable
> Connection Parameters".

Please let me know, if you need more details.

> 
> >
> > >         { 0x3c, "Directed Advertising Timeout"                          },
> > >         { 0x3d, "Connection Terminated due to MIC Failure"              },
> > >         { 0x3e, "Connection Failed to be Established"                   },
> > > --
> > > 1.9.1
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > > linux-bluetooth" in the body of a message to
> > > majordomo@vger.kernel.org More majordomo info at
> > > http://vger.kernel.org/majordomo-info.html
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> Regards,
> Gowtham Anandha Babu
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

Regards,
Gowtham Anandha Babu


