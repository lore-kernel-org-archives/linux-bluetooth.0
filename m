Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Feb 2011 10:44:22 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anderson Briglia <anderson.briglia@openbossa.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/5] Bluetooth: Implement advertising report meta event
Message-ID: <20110215134422.GI2597@joana>
References: <4d59a5ff.859ddc0a.46cb.5143@mx.google.com>
 <AANLkTikhs5uwFgeF0BT_5R_=8sM5Z+eQ_y2kxZ_oWj1V@mail.gmail.com>
 <AANLkTikEtO+jF-S9SDziueGh1rDUYhYeATT6_g84++0B@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTikEtO+jF-S9SDziueGh1rDUYhYeATT6_g84++0B@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Briglia,

Top posting is not allowed in this mailing list. Please stop it.

* Anderson Briglia <anderson.briglia@openbossa.org> [2011-02-15 10:10:12 -0300]:

> Thanks for reviewing. I'll add that missing "break", but the other
> tips are not so relevant since we should gain just 2 characters.
> 
> On Mon, Feb 14, 2011 at 7:23 PM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
> >
> > Hi Briglia,
> >
> > On Mon, Feb 14, 2011 at 6:59 PM,  <anderson.briglia@openbossa.org> wrote:
> > > From: Anderson Briglia <anderson.briglia@openbossa.org>
> > >
> > > This patch implements new LE meta event in order to handle advertising
> > > reports.
> > >
> > > Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> > > ---
> > >  include/net/bluetooth/hci.h |   18 ++++++++++++++++++
> > >  net/bluetooth/hci_event.c   |   22 ++++++++++++++++++++++
> > >  2 files changed, 40 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > > index 46438f4..5180555 100644
> > > --- a/include/net/bluetooth/hci.h
> > > +++ b/include/net/bluetooth/hci.h
> > > @@ -980,6 +980,24 @@ struct hci_ev_le_conn_complete {
> > >        __u8     clk_accurancy;
> > >  } __packed;
> > >
> > > +#define ADV_IND                0x00
> > > +#define ADV_DIRECT_IND 0x01
> > > +#define ADV_SCAN_IND   0x02
> > > +#define ADV_NONCONN_IND        0x03
> > > +#define SCAN_RSP       0x04
> > > +
> > > +#define ADDR_DEV_PUBLIC        0x00
> > > +#define ADDR_DEV_RANDOM        0x01
> > > +
> > > +#define HCI_EV_LE_ADVERTISING_REPORT   0x02
> > > +struct hci_ev_le_advertising_info {
> > > +       __u8     evt_type;
> > > +       __u8     bdaddr_type;
> > > +       bdaddr_t bdaddr;
> > > +       __u8     length;
> > > +       __u8     data[0];
> > > +} __packed;
> > > +
> > >  #define HCI_EV_LE_LTK_REQ              0x05
> > >  struct hci_ev_le_ltk_req {
> > >        __le16  handle;
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index 99c75f4..987f5de 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -2498,6 +2498,25 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
> > >        hci_dev_unlock(hdev);
> > >  }
> > >
> > > +static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
> > > +                                               struct sk_buff *skb)
> > > +{
> > > +       struct hci_ev_le_advertising_info *ev;
> > > +       u8 num_reports, i;
> > > +
> > > +       num_reports = (u8) skb->data[0];
> >
> > I think this cast is unnecessary.
> >
> > > +
> > > +       ev = (struct hci_ev_le_advertising_info *) (skb->data + 1);
> >
> > What about a slightly shorter line (well I didn't count the chars):
> >
> > ev = (struct hci_ev_le_advertising_info *) &skb->data[1];

Use (void *) cast here.

> >
> > > +
> > > +       BT_DBG("adv from: %s", batostr(&ev->bdaddr));
> > > +
> > > +       for (i = 1; i < num_reports; i++) {
> > > +               ev = (struct hci_ev_le_advertising_info *)
> > > +                                       (ev->data + ev->length + 1);
> > > +               BT_DBG("adv from: %s", batostr(&ev->bdaddr));
> > > +       }
> >
> > What about (not sure if it is shorter, just a suggestion):
> >
> > ev = (struct hci_ev_le_advertising_info *) &ev->data[ev->length + 1];

Same here.

-- 
Gustavo F. Padovan
http://profusion.mobi
