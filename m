Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Dec 2011 10:01:36 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 2/3] Bluetooth: Simplify num_comp_pkts_evt function
Message-ID: <20111207080135.GB15379@aemeltch-MOBL1>
References: <1323089704-1005-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1323089704-1005-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1323093094.26198.49.camel@aeonflux>
 <20111205153222.GD23614@aemeltch-MOBL1>
 <1323110749.26198.57.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323110749.26198.57.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Dec 05, 2011 at 07:45:49PM +0100, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > > > Simplify function and remove fourth level of indentation.
> > > > 
> > > > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > > ---
> > > >  net/bluetooth/hci_event.c |   43 +++++++++++++++++++++++++------------------
> > > >  1 files changed, 25 insertions(+), 18 deletions(-)
> > > > 
> > > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > > index 273e1cb..fd7e6b5 100644
> > > > --- a/net/bluetooth/hci_event.c
> > > > +++ b/net/bluetooth/hci_event.c
> > > > @@ -2288,28 +2288,35 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
> > > >  		count  = get_unaligned_le16(ptr++);
> > > 
> > > actually we first need a cleanup of this function. This part is
> > > horrible. It works because of our ptr cast to uint16, but we should
> > > actually use a proper struct here. Maybe an info struct like we use for
> > > inquiry result might be helpful here.
> > 
> > Something like the code below?
> > 
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index e33e468..403974c 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1018,9 +1018,14 @@ struct hci_ev_role_change {
> >  } __packed;
> >  
> >  #define HCI_EV_NUM_COMP_PKTS           0x13
> > +struct hci_comp_pkts_info {
> > +       __le16   handle;
> > +       __le16   count;
> > +} __packed;
> > +
> >  struct hci_ev_num_comp_pkts {
> >         __u8     num_hndl;
> > -       /* variable length part */
> > +       struct hci_comp_pkts_info handles[0];
> >  } __packed;
> >  
> >  #define HCI_EV_MODE_CHANGE             0x14
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 238fb65..079b94f 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -2273,26 +2273,27 @@ static inline void hci_role_change_evt(struct
> > hci_dev *hdev, struct sk_buff *skb
> >  static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct
> > sk_buff *skb)
> >  {
> >         struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
> > -       __le16 *ptr;
> > +       struct hci_comp_pkts_info *info;
> >         int i;
> >  
> >         skb_pull(skb, sizeof(*ev));
> >  
> >         BT_DBG("%s num_hndl %d", hdev->name, ev->num_hndl);
> >  
> > -       if (skb->len < ev->num_hndl * 4) {
> > +       if (skb->len < ev->num_hndl * sizeof(*info)) {
> >                 BT_DBG("%s bad parameters", hdev->name);
> >                 return;
> >         }
> >  
> >         tasklet_disable(&hdev->tx_task);
> >  
> > -       for (i = 0, ptr = (__le16 *) skb->data; i < ev->num_hndl; i++) {
> > +       for (i = 0; i < ev->num_hndl; i++) {
> 
> 		struct hci_comp_pkts_info *info = &ev->handles[i];

I was actually using "info" to eliminate magic size above, otherwise I have
to use long "sizeof(struct hci_comp_pkts_info)". This of course might be
done in a separate trivial patch.

> 
> >                 struct hci_conn *conn;
> >                 __u16  handle, count;
> >  
> > -               handle = get_unaligned_le16(ptr++);
> > -               count  = get_unaligned_le16(ptr++);
> > +               info = &ev->handles[i];
> > +               handle = __le16_to_cpu(info->handle);
> > +               count  = __le16_to_cpu(info->count);
> >  
> >                 conn = hci_conn_hash_lookup_handle(hdev, handle);
> >                 if (!conn)
> 
> And you need to remove the skb_pull above since otherwise you are
> pointing to the wrong memory location.

Sorry, cannot get this. I assign "ev" before skb_pull, this should not be a
problem.

Best regards 
Andrei Emeltchenko 
