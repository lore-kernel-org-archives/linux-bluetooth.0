Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 07:53:38 +0200
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 3/6] Bluetooth: Use LE buffers for LE traffic
Message-ID: <20101111055338.GA27346@null>
References: <1288009280-5149-1-git-send-email-ville.tervo@nokia.com>
 <1288009280-5149-4-git-send-email-ville.tervo@nokia.com>
 <AANLkTiktxkQQXH2m2+s-zyfyWh-jUT9rwjU+GPyPWyhS@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTiktxkQQXH2m2+s-zyfyWh-jUT9rwjU+GPyPWyhS@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Nov 10, 2010 at 05:53:02PM +0100, ext Claudio Takahasi wrote:
> Hi Ville,
> 
> On Mon, Oct 25, 2010 at 10:21 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
> > BLuetooth chips may have separate buffers for
> > LE traffic. This patch add support to use LE
> > buffers provided by the chip.
> >
> > Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> > ---
> >  include/net/bluetooth/hci.h      |    1 +
> >  include/net/bluetooth/hci_core.h |    5 +++
> >  net/bluetooth/hci_conn.c         |    5 +++
> >  net/bluetooth/hci_core.c         |   74 +++++++++++++++++++++++++++++++++++--
> >  net/bluetooth/hci_event.c        |   40 +++++++++++++++++++-
> >  5 files changed, 119 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 02055b9..2103731 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -189,6 +189,7 @@ enum {
> >
> >  #define LMP_EV4                0x01
> >  #define LMP_EV5                0x02
> > +#define LMP_LE         0x40
> >
> >  #define LMP_SNIFF_SUBR 0x02
> >  #define LMP_EDR_ESCO_2M        0x20
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index 2b7f94a..e2d857a 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -103,15 +103,19 @@ struct hci_dev {
> >        atomic_t        cmd_cnt;
> >        unsigned int    acl_cnt;
> >        unsigned int    sco_cnt;
> > +       unsigned int    le_cnt;
> >
> >        unsigned int    acl_mtu;
> >        unsigned int    sco_mtu;
> > +       unsigned int    le_mtu;
> >        unsigned int    acl_pkts;
> >        unsigned int    sco_pkts;
> > +       unsigned int    le_pkts;
> >
> >        unsigned long   cmd_last_tx;
> >        unsigned long   acl_last_tx;
> >        unsigned long   sco_last_tx;
> > +       unsigned long   le_last_tx;
> >
> >        struct workqueue_struct *workqueue;
> >
> > @@ -473,6 +477,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
> >  #define lmp_sniffsubr_capable(dev) ((dev)->features[5] & LMP_SNIFF_SUBR)
> >  #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
> >  #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
> > +#define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
> >
> >  /* ----- HCI protocols ----- */
> >  struct hci_proto {
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 0944c0c..ddc2e5e 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -324,6 +324,11 @@ int hci_conn_del(struct hci_conn *conn)
> >
> >                /* Unacked frames */
> >                hdev->acl_cnt += conn->sent;
> > +       } else if (conn->type == LE_LINK) {
> > +               if (hdev->le_pkts)
> > +                       hdev->le_cnt += conn->sent;
> > +               else
> > +                       hdev->acl_cnt += conn->sent;
> >        } else {
> >                struct hci_conn *acl = conn->link;
> >                if (acl) {
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index bc2a052..45c78c2 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -254,6 +254,14 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
> >        hci_send_cmd(hdev, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
> >  }
> >
> > +static void hci_le_init_req(struct hci_dev *hdev, unsigned long opt)
> > +{
> > +       BT_DBG("%s", hdev->name);
> > +
> > +       /* Read LE buffer size */
> > +       hci_send_cmd(hdev, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
> > +}
> > +
> >  static void hci_scan_req(struct hci_dev *hdev, unsigned long opt)
> >  {
> >        __u8 scan = opt;
> > @@ -509,6 +517,10 @@ int hci_dev_open(__u16 dev)
> >                ret = __hci_request(hdev, hci_init_req, 0,
> >                                        msecs_to_jiffies(HCI_INIT_TIMEOUT));
> >
> > +               if (lmp_le_capable(hdev))
> > +                       ret = __hci_request(hdev, hci_le_init_req, 0,
> > +                                       msecs_to_jiffies(HCI_INIT_TIMEOUT));
> > +
> >                clear_bit(HCI_INIT, &hdev->flags);
> >        }
> >
> > @@ -645,7 +657,7 @@ int hci_dev_reset(__u16 dev)
> >                hdev->flush(hdev);
> >
> >        atomic_set(&hdev->cmd_cnt, 1);
> > -       hdev->acl_cnt = 0; hdev->sco_cnt = 0;
> > +       hdev->acl_cnt = 0; hdev->sco_cnt = 0; hdev->le_cnt = 0;
> >
> >        if (!test_bit(HCI_RAW, &hdev->flags))
> >                ret = __hci_request(hdev, hci_reset_req, 0,
> > @@ -1456,8 +1468,25 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int
> >        }
> >
> >        if (conn) {
> > -               int cnt = (type == ACL_LINK ? hdev->acl_cnt : hdev->sco_cnt);
> > -               int q = cnt / num;
> > +               int cnt, q;
> > +
> > +               switch (conn->type) {
> > +               case ACL_LINK:
> > +                       cnt = hdev->acl_cnt;
> > +                       break;
> > +               case SCO_LINK:
> > +               case ESCO_LINK:
> > +                       cnt = hdev->sco_cnt;
> > +                       break;
> > +               case LE_LINK:
> > +                       cnt = hdev->le_mtu ? hdev->le_cnt : hdev->acl_cnt;
> > +                       break;
> > +               default:
> > +                       cnt = 0;
> > +                       BT_ERR("Unknown link type");
> > +               }
> > +
> > +               q = cnt / num;
> >                *quote = q ? q : 1;
> >        } else
> >                *quote = 0;
> > @@ -1556,6 +1585,40 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
> >        }
> >  }
> >
> > +static inline void hci_sched_le(struct hci_dev *hdev)
> > +{
> > +       struct hci_conn *conn;
> > +       struct sk_buff *skb;
> > +       int quote, cnt;
> > +
> > +       BT_DBG("%s", hdev->name);
> > +
> > +       if (!test_bit(HCI_RAW, &hdev->flags)) {
> > +               /* ACL tx timeout must be longer than maximum
> > +                * link supervision timeout (40.9 seconds) */
> > +               if (!hdev->le_cnt &&
> > +                   time_after(jiffies, hdev->le_last_tx + HZ * 45))
> > +                       hci_acl_tx_to(hdev);
> > +       }
> 
> It seems that the ACL tx timeout is causing some problems: BR/EDR and
> LE connections are not working properly on macbooks! Don't ask me why
> on macbooks only! But I double checked. I tested your branch and also
> bluetooth-next + LE patches and both are not working as expected. I
> didn't have time to investigate it, do you have any clue?
> 
> For BR/EDR I am receiving "killing stalled ACL connection" messages
> for all connections.
> 

Yes you are right. I found this also yesterday and I have a patch to fix it
already. I'll clean it up and submit later today.

-- 
Ville
