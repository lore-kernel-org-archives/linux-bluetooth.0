Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOVXEJ+CLxgr-eZ-98U_U=JFCCu6eiVnuv=R_VwewiOE=PXsmg@mail.gmail.com>
References: <1534771920-4437-1-git-send-email-sathish.narasimman@intel.com>
 <1534771920-4437-2-git-send-email-sathish.narasimman@intel.com>
 <CABBYNZ+zQhj_vUpkggkMcF9y5zvgdh9h9gj3qunbRVUx9akzuQ@mail.gmail.com> <CAOVXEJ+CLxgr-eZ-98U_U=JFCCu6eiVnuv=R_VwewiOE=PXsmg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 21 Aug 2018 11:12:23 +0300
Message-ID: <CABBYNZ+M9suggQOa5dWrWS9SU5=qDijMXymVK44d=2Pu-FV1zg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: hci_event: handle msbc audio over USB Endpoints
To: Sathish Narasimman <nsathish41@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sathish,

On Tue, Aug 21, 2018 at 8:58 AM, Sathish Narasimman
<nsathish41@gmail.com> wrote:
> Hi Luiz,
>
> On Mon, Aug 20, 2018 at 9:35 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> Hi Sathish,
>>
>> On Mon, Aug 20, 2018 at 4:32 PM, Sathish Narasimman
>> <nsathish41@gmail.com> wrote:
>> > For msbc encoded audio stream over usb transport, btusb driver
>> > to be set to alternate settings 6 as per BT core spec 5.0. This
>> > done from  hci_sync_conn_complete_evt. The type of air mode is known
>> > during this event. For this reason the btusb is to be notifed
>> > about the TRANSPARENT air mode and the ALT setting 6 is selected.
>> > The changes are made considering some discussion over the similar
>> > patch submitted earlier from Kuba Pawlak(link below)
>> > https://www.spinics.net/lists/linux-bluetooth/msg64577.html
>> >
>> > Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
>> > ---
>> >  drivers/bluetooth/btusb.c   | 95
>> > +++++++++++++++++++++++++--------------------
>> >  include/net/bluetooth/hci.h |  1 +
>> >  net/bluetooth/hci_event.c   |  5 +++
>> >  3 files changed, 59 insertions(+), 42 deletions(-)
>> >
>> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> > index cd2e5cf..ae924b6 100644
>> > --- a/drivers/bluetooth/btusb.c
>> > +++ b/drivers/bluetooth/btusb.c
>> > @@ -1390,18 +1390,6 @@ static int btusb_send_frame(struct hci_dev *hdev,
>> > struct sk_buff *skb)
>> >         return -EILSEQ;
>> >  }
>> >
>> > -static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
>> > -{
>> > -       struct btusb_data *data = hci_get_drvdata(hdev);
>> > -
>> > -       BT_DBG("%s evt %d", hdev->name, evt);
>> > -
>> > -       if (hci_conn_num(hdev, SCO_LINK) != data->sco_num) {
>> > -               data->sco_num = hci_conn_num(hdev, SCO_LINK);
>> > -               schedule_work(&data->work);
>> > -       }
>> > -}
>> > -
>> >  static inline int __set_isoc_interface(struct hci_dev *hdev, int
>> > altsetting)
>> >  {
>> >         struct btusb_data *data = hci_get_drvdata(hdev);
>> > @@ -1445,6 +1433,58 @@ static inline int __set_isoc_interface(struct
>> > hci_dev *hdev, int altsetting)
>> >         return 0;
>> >  }
>> >
>> > +static void bt_switch_alt_setting(struct hci_dev *hdev, int new_alts)
>> > +{
>> > +       struct btusb_data *data = hci_get_drvdata(hdev);
>> > +
>> > +       if (data->isoc_altsetting != new_alts) {
>> > +               unsigned long flags;
>> > +
>> > +               clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
>> > +               usb_kill_anchored_urbs(&data->isoc_anchor);
>> > +
>> > +               /* When isochronous alternate setting needs to be
>> > +                * changed, because SCO connection has been added
>> > +                * or removed, a packet fragment may be left in the
>> > +                * reassembling state. This could lead to wrongly
>> > +                * assembled fragments.
>> > +                *
>> > +                * Clear outstanding fragment when selecting a new
>> > +                * alternate setting.
>> > +                */
>> > +               spin_lock_irqsave(&data->rxlock, flags);
>> > +               kfree_skb(data->sco_skb);
>> > +               data->sco_skb = NULL;
>> > +               spin_unlock_irqrestore(&data->rxlock, flags);
>> > +
>> > +               if (__set_isoc_interface(hdev, new_alts) < 0)
>> > +                       return;
>> > +       }
>> > +       if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
>> > +               if (btusb_submit_isoc_urb(hdev, GFP_KERNEL) < 0)
>> > +                       clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
>> > +               else
>> > +                       btusb_submit_isoc_urb(hdev, GFP_KERNEL);
>> > +       }
>> > +}
>> > +
>> > +static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
>> > +{
>> > +       struct btusb_data *data = hci_get_drvdata(hdev);
>> > +
>> > +       BT_DBG("%s evt %d", hdev->name, evt);
>> > +
>> > +       if (hci_conn_num(hdev, SCO_LINK) != data->sco_num) {
>> > +               data->sco_num = hci_conn_num(hdev, SCO_LINK);
>> > +               schedule_work(&data->work);
>> > +       }
>> > +
>> > +       if (evt == HCI_NOTIFY_AIR_MODE_TRANSP) {
>> > +               /* Alt setting 6 is for msbc encoded audio channel */
>> > +               bt_switch_alt_setting(hdev, 6);
>>
>> Have you checked that this works on older controllers? I suppose those
>> don't have alt_set 6.
>
> I took the reference from the core spec 5, Vol 4, Part B, Table 2.1
> For USB transport the ALT setting 6 should be used for one msbc voice
> channel.
> Yes, for the controllers that does not support ALT setting 6. this patch
> will not work.

It _must_ keep working with controller that don't support such
setting, there is no option on that, so there should be a way to just
read what supported alt settings that are supported and fallback if 6
is not supported.

> Also, I failed to submit a small part of the patch to maintain 7.5ms HCI
> packet intervel in ALT 6 setting i will submitt the next set with that
> patch.
> Table 2.1: USB Primary firmware interface and endpoint settings
>>
>> > +       }
>> > +}
>> > +
>> >  static void btusb_work(struct work_struct *work)
>> >  {
>> >         struct btusb_data *data = container_of(work, struct btusb_data,
>> > work);
>> > @@ -1472,36 +1512,7 @@ static void btusb_work(struct work_struct *work)
>> >                         new_alts = data->sco_num;
>> >                 }
>> >
>> > -               if (data->isoc_altsetting != new_alts) {
>> > -                       unsigned long flags;
>> > -
>> > -                       clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
>> > -                       usb_kill_anchored_urbs(&data->isoc_anchor);
>> > -
>> > -                       /* When isochronous alternate setting needs to
>> > be
>> > -                        * changed, because SCO connection has been
>> > added
>> > -                        * or removed, a packet fragment may be left in
>> > the
>> > -                        * reassembling state. This could lead to
>> > wrongly
>> > -                        * assembled fragments.
>> > -                        *
>> > -                        * Clear outstanding fragment when selecting a
>> > new
>> > -                        * alternate setting.
>> > -                        */
>> > -                       spin_lock_irqsave(&data->rxlock, flags);
>> > -                       kfree_skb(data->sco_skb);
>> > -                       data->sco_skb = NULL;
>> > -                       spin_unlock_irqrestore(&data->rxlock, flags);
>> > -
>> > -                       if (__set_isoc_interface(hdev, new_alts) < 0)
>> > -                               return;
>> > -               }
>> > -
>> > -               if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags))
>> > {
>> > -                       if (btusb_submit_isoc_urb(hdev, GFP_KERNEL) < 0)
>> > -                               clear_bit(BTUSB_ISOC_RUNNING,
>> > &data->flags);
>> > -                       else
>> > -                               btusb_submit_isoc_urb(hdev, GFP_KERNEL);
>> > -               }
>> > +               bt_switch_alt_setting(hdev, new_alts);
>> >         } else {
>> >                 clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
>> >                 usb_kill_anchored_urbs(&data->isoc_anchor);
>> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> > index cdd9f1f..3498c6b 100644
>> > --- a/include/net/bluetooth/hci.h
>> > +++ b/include/net/bluetooth/hci.h
>> > @@ -52,6 +52,7 @@
>> >  #define HCI_NOTIFY_CONN_ADD            1
>> >  #define HCI_NOTIFY_CONN_DEL            2
>> >  #define HCI_NOTIFY_VOICE_SETTING       3
>> > +#define HCI_NOTIFY_AIR_MODE_TRANSP     4
>> >
>> >  /* HCI bus types */
>> >  #define HCI_VIRTUAL    0
>> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> > index f12555f..8ef5220 100644
>> > --- a/net/bluetooth/hci_event.c
>> > +++ b/net/bluetooth/hci_event.c
>> > @@ -4100,6 +4100,11 @@ static void hci_sync_conn_complete_evt(struct
>> > hci_dev *hdev,
>> >                 break;
>> >         }
>> >
>> > +       if (ev->air_mode == SCO_AIRMODE_TRANSP) {
>> > +               if (hdev->notify)
>> > +                       hdev->notify(hdev, HCI_NOTIFY_AIR_MODE_TRANSP);
>> > +       }
>> > +
>> >         hci_connect_cfm(conn, ev->status);
>> >         if (ev->status)
>> >                 hci_conn_del(conn);
>> > --
>> > 2.7.4
>> >
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
>
>
> Thanks,
> Sathish N



-- 
Luiz Augusto von Dentz
