Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 03/15] sdp: Use helper functions instead of bt_get_unaligned macro
Date: Fri, 31 Aug 2012 13:49:52 +0200
Message-ID: <2567651.ypxvMR3dxG@uw000953>
In-Reply-To: <CAJdJm_NpsHV77wKHd9RkCoVKoYt1RRaOQbLaXt_fCJ9tS3mcwQ@mail.gmail.com>
References: <1346402185-9487-1-git-send-email-szymon.janc@tieto.com> <1346402185-9487-4-git-send-email-szymon.janc@tieto.com> <CAJdJm_NpsHV77wKHd9RkCoVKoYt1RRaOQbLaXt_fCJ9tS3mcwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 31 of August 2012 13:55:08 Anderson Lizardo wrote:
> Hi Szymon,

Hi Anderson,

> 
> On Fri, Aug 31, 2012 at 4:36 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> > This fix number of compilation errors on ARM similar to one below.
> >
> > lib/sdp.c: In function 'sdp_uuid_extract':
> > lib/sdp.c:1019:27: error: cast increases required alignment
> >         of target type [-Werror=cast-align]
> > lib/sdp.c:1019:27: error: cast increases required alignment
> >         of target type [-Werror=cast-align]
> > lib/sdp.c:1026:27: error: cast increases required alignment
> >         of target type [-Werror=cast-align]
> > lib/sdp.c:1026:27: error: cast increases required alignment
> >         of target type [-Werror=cast-align]
> >
> > Change-Id: I587fb99328d7e5b9053af81597bd48b3a4e610ad
> 
> You should remove the "Change-Id" tags from your patches.

Crap. Will remove it in V2 :)

> 
> >         case SDP_INT16:
> > -               d->val.int16 = bt_get_unaligned((int16_t *) value);
> > +               d->val.int16 = bt_get_16(value);
> >                 d->unitSize += sizeof(int16_t);
> >                 break;
> 
> Is this safe? You are assigning a unsigned type (return value from
> bt_get_16()) to a signed one. Same applies for SDP_INT32 and SDP_INT64

Mixing signed and unsigned could introduce some problem when you interpret data (e.g. in
comparison), but here value will be simply assigned.

I could add an explicit cast here (as this might bother some lint-like tools) if you prefer.

> 
> > @@ -1427,7 +1427,7 @@ sdp_record_t *sdp_extract_pdu(const uint8_t *buf, int bufsize, int *scanned)
> >                 }
> >
> >                 dtd = *(uint8_t *) p;
> > -               attr = ntohs(bt_get_unaligned((uint16_t *) (p + n)));
> > +               attr = bt_get_be16((p + n));
> 
> Extra parenthesis can be dropped.

Will fix.

> 
> Regards,
> 

-- 
BR
Szymon Janc
