Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 May 2011 15:43:52 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 02/12] Bluetooth: LE advertising cache
Message-ID: <20110517184351.GE3138@joana>
References: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
 <1304701521-26459-3-git-send-email-andre.guedes@openbossa.org>
 <20110513193326.GB5403@joana>
 <BANLkTikDg2B0-=TyLAg4AriupRZEsr9OqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BANLkTikDg2B0-=TyLAg4AriupRZEsr9OqA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Andre Guedes <andre.guedes@openbossa.org> [2011-05-17 15:22:31 -0300]:

> Hi Gustavo,
> 
> On Fri, May 13, 2011 at 4:33 PM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
> > Hi Andre,
> >
> > * Andre Guedes <andre.guedes@openbossa.org> [2011-05-06 14:05:11 -0300]:
> >
> >> This patch implements the LE advertising cache. It stores sensitive
> >> information (bdaddr and bdaddr_type so far) gathered from LE
> >> advertising report events.
> >>
> >> Only advertising entries from connectables devices are added to the
> >> cache.
> >>
> >> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> >> ---
> >>  include/net/bluetooth/hci_core.h |   13 +++++++
> >>  net/bluetooth/hci_core.c         |   74 ++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 87 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> >> index 14cc324..65135f8 100644
> >> --- a/include/net/bluetooth/hci_core.h
> >> +++ b/include/net/bluetooth/hci_core.h
> >> @@ -89,6 +89,12 @@ struct oob_data {
> >>       u8 randomizer[16];
> >>  };
> >>
> >> +struct adv_entry {
> >> +     struct list_head list;
> >> +     bdaddr_t bdaddr;
> >> +     u8 bdaddr_type;
> >> +};
> >> +
> >>  #define NUM_REASSEMBLY 4
> >>  struct hci_dev {
> >>       struct list_head list;
> >> @@ -181,6 +187,8 @@ struct hci_dev {
> >>
> >>       struct list_head        remote_oob_data;
> >>
> >> +     struct list_head        adv_entries;
> >> +
> >>       struct hci_dev_stats    stat;
> >>
> >>       struct sk_buff_head     driver_init;
> >> @@ -526,6 +534,11 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
> >>                                                               u8 *randomizer);
> >>  int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr);
> >>
> >> +int hci_adv_entries_clear(struct hci_dev *hdev);
> >> +struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr);
> >> +int hci_add_adv_entry(struct hci_dev *hdev,
> >> +                                     struct hci_ev_le_advertising_info *ev);
> >
> > Rename this to hci_adv_add_entry()
> >
> 
> 'adv_entry' is the element of the list. So, to follow the standard IMO
> we should keep the name hci_add_adv_entry(). See others functions
> like hci_add_link_key() and hci_add_remote_oob_data().

Fair enough. Keep it hci_add_adv_entry()

-- 
Gustavo F. Padovan
http://profusion.mobi
