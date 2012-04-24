Return-Path: <cyrus@holtmann.org>
Message-ID: <1335287059.16897.398.camel@aeonflux>
Subject: Re: [RFC v3 1/5] Bluetooth: Add address type to struct sockaddr_l2
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 24 Apr 2012 19:04:19 +0200
In-Reply-To: <CACJA=fVKYXZLZ2F3kcPEVEE=DhEoiur_KacOonLDy3vq0xvZpA@mail.gmail.com>
References: <1333646241-12574-1-git-send-email-andre.guedes@openbossa.org>
	 <1333646241-12574-2-git-send-email-andre.guedes@openbossa.org>
	 <1333648179.16897.16.camel@aeonflux>
	 <CACJA=fXwkotOD5kUVEDCGEx31XYkyaMXn72hoTqDMFFOrSQ4+Q@mail.gmail.com>
	 <CACJA=fVKYXZLZ2F3kcPEVEE=DhEoiur_KacOonLDy3vq0xvZpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> > On Thu, Apr 5, 2012 at 2:49 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> >> Hi Andre,
> >>
> >>> This patch adds the address type info to struct sockaddr_l2 so
> >>> user-space can inform the remote device address type required
> >>> to establish LE connections.
> >>>
> >>> Soon, instead of looking the advertising cache up to discover the
> >>> address type, we'll use this address type info to establish LE
> >>> connections.
> >>>
> >>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> >>> ---
> >>>  include/net/bluetooth/l2cap.h |    1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> >>> index f6f0500..d14967e 100644
> >>> --- a/include/net/bluetooth/l2cap.h
> >>> +++ b/include/net/bluetooth/l2cap.h
> >>> @@ -57,6 +57,7 @@ struct sockaddr_l2 {
> >>>       __le16          l2_psm;
> >>>       bdaddr_t        l2_bdaddr;
> >>>       __le16          l2_cid;
> >>> +     __u8            l2_bdaddr_type;
> >>>  };
> >>
> >> so I am trying to come up with a better name for this value. It feels a
> >> little bit too long to me.
> >>
> >> I was considering l2_bdtype, but that is not really semantically correct
> >> here. Or would it be fine? We could do l2_bdatype, but that does not
> >> really make it any better either.
> >
> > Yes, it is a little big to me too. But that was the best name I could
> > find. Other names just don't clearly say what this field means.
> 
> So, do we keep this name?

I honestly have not made up mind. Send a new patch anyway.

Regards

Marcel


