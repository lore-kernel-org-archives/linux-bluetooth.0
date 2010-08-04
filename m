Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Don't send RFC for Basic Mode if only it is
 supported
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: Ville Tervo <ville.tervo@nokia.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <20100731224144.GA29039@vigoh>
References: <4C5020D7.7080005@nokia.com>
	 <1280426444-20469-1-git-send-email-gustavo@padovan.org>
	 <4C52CFDC.9070907@nokia.com>  <20100731224144.GA29039@vigoh>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 03 Aug 2010 18:56:31 -0700
Message-ID: <1280886991.12579.98.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

> > On 07/29/2010 09:00 PM, ext Gustavo F. Padovan wrote:
> > >From: Gustavo F. Padovan<padovan@profusion.mobi>
> > >
> > >If the remote side doesn't support Enhanced Retransmission Mode neither
> > >Streaming Mode, we shall not send the RFC option.
> > >Some devices that only supports Basic Mode do not understanding the RFC
> > >option. This patch fix the regression found with that devices.
> > 
> > 
> > Yes this is better. After some research i found out that quite many
> > old devices are not handling properly unknown options.
> 
> Nice, we can put this upstream, do you agree?
> 
> > 
> > However I found another regression. And this kind of patch is needed
> > also. Otherwise the info rsp code is reading feat_mask from failed
> > response (and does invalid memory access).
> > 
> > 
> > diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> > index 0f34e12..1e174a4 100644
> > --- a/net/bluetooth/l2cap.c
> > +++ b/net/bluetooth/l2cap.c
> > @@ -3348,6 +3348,13 @@ static inline int
> > l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
> > 
> >         del_timer(&conn->info_timer);
> > 
> > +       if (result != L2CAP_IR_SUCCESS) {
> > +               conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
> > +               conn->info_ident = 0;
> > +               l2cap_conn_start(conn);
> > +               return 0;
> > +       }
> > +
> >         if (type == L2CAP_IT_FEAT_MASK) {
> >                 conn->feat_mask = get_unaligned_le32(rsp->data);
> > 
> 
> Ack. Send a proper GIT patch then we can push this fix. 

am I getting this proper patch or not?

Regards

Marcel


