Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com
References: <1414733423-18958-1-git-send-email-gowtham.ab@samsung.com>
 <CABBYNZLQKeEvVokzC1fFF3ccpsOXgfOEsukZ00Vqn1tgTkcPfA@mail.gmail.com>
In-reply-to: <CABBYNZLQKeEvVokzC1fFF3ccpsOXgfOEsukZ00Vqn1tgTkcPfA@mail.gmail.com>
Subject: RE: [PATCH] tools/sdptool: Add MAP supported features for MNS
Date: Wed, 05 Nov 2014 11:26:19 +0530
Message-id: <000601cff8bd$3dc8c930$b95a5b90$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Tuesday, November 04, 2014 5:54 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; Bharat Panda;
> cpgs@samsung.com
> Subject: Re: [PATCH] tools/sdptool: Add MAP supported features for MNS
> 
> Hi,
> 
> On Fri, Oct 31, 2014 at 7:30 AM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> > Add MapSupportedFeatures into MNS
> > attribute names.
> > ---
> >  tools/sdptool.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/sdptool.c b/tools/sdptool.c index f2d3068..88a52bb
> > 100644
> > --- a/tools/sdptool.c
> > +++ b/tools/sdptool.c
> > @@ -239,6 +239,11 @@ static struct attrib_def mas_attrib_names[] = {
> >         { 0x0317, "MapSupportedFeatures", NULL, 0 },  };
> >
> > +/* Name of the various MNS attributes. See BT assigned numbers */
> > +static struct attrib_def mns_attrib_names[] = {
> > +       { 0x0317, "MapSupportedFeatures", NULL, 0 }, };
> > +
> >  /* Same for the UUIDs. See BT assigned numbers */  static struct
> > uuid_def uuid16_names[] = {
> >         /* -- Protocols -- */
> > @@ -327,7 +332,8 @@ static struct uuid_def uuid16_names[] = {
> >         { 0x1131, "Headset (HSP)", NULL, 0 },
> >         { 0x1132, "Message Access (MAP) - MAS",
> >                 mas_attrib_names, N_ELEMENTS(mas_attrib_names) },
> > -       { 0x1133, "Message Access (MAP) - MNS", NULL, 0 },
> > +       { 0x1133, "Message Access (MAP) - MNS",
> > +               mns_attrib_names, N_ELEMENTS(mns_attrib_names) },
> >         { 0x1134, "Message Access (MAP)", NULL, 0 },
> >         /* ... */
> >         { 0x1200, "PnPInformation",
> > --
> > 1.9.1
> 
> Could you please add to the patch description the MNS record output?
> 
> 
> --
> Luiz Augusto von Dentz

I have added the MNS record output and submitted v1 for the same. 

Regards,
Gowtham

