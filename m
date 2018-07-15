Return-Path: <jaganath.k.os@gmail.com>
MIME-Version: 1.0
In-Reply-To: <19EAAC1C-2659-4A58-9357-4E88FA1D8712@holtmann.org>
References: <1531301495-14479-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1531301495-14479-4-git-send-email-jaganathx.kanakkassery@intel.com> <19EAAC1C-2659-4A58-9357-4E88FA1D8712@holtmann.org>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Sun, 15 Jul 2018 15:06:03 +0530
Message-ID: <CAJzH+bov-8Ps-vsSFbyqj3-2=1TOSfq0jYuob7xLLpHJOquwRw@mail.gmail.com>
Subject: Re: [PATCH v4 03/13] Bluetooth: Implement Set PHY Confguration command
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


On Sat, Jul 14, 2018 at 10:48 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Jaganath,
>
>> This enables user to set phys which will be used in all subsequent
>> connections. Also host will use the same in LE scanning as well.
>>
>> This patch also implements PHY Changed event which will be
>> triggered whenever default PHYs change.
>>
>> This also adds PHY_CONFIGURATION to mgmt settings which set
>> in the supported settings if controller supports 2/3 slot
>> or 2M/#M in BREDR controller and 2M or CODED in case of LE
>> and set in current settings if any of them is selected
>>
>> @ MGMT Command: Set PHY Configuration (0x0045) plen 4
>>        Selected PHYs: 0x7fff
>>          BR 1M 1SLOT
>>          BR 1M 3SLOT
>>          BR 1M 5SLOT
>>          EDR 2M 1SLOT
>>          EDR 2M 3SLOT
>>          EDR 2M 5SLOT
>>          EDR 3M 1SLOT
>>          EDR 3M 3SLOT
>>          EDR 3M 5SLOT
>>          LE 1M TX
>>          LE 1M RX
>>          LE 2M TX
>>          LE 2M RX
>>          LE CODED TX
>>          LE CODED RX
>> < HCI Command: LE Set Default PHY (0x08|0x0031) plen 3
>>        All PHYs preference: 0x00
>>        TX PHYs preference: 0x07
>>          LE 1M
>>          LE 2M
>>          LE Coded
>>        RX PHYs preference: 0x07
>>          LE 1M
>>          LE 2M
>>          LE Coded
>>> HCI Event: Command Complete (0x0e) plen 4
>>      LE Set Default PHY (0x08|0x0031) ncmd 1
>>        Status: Success (0x00)
>> @ MGMT Event: Command Complete (0x0001) plen 3
>>      Set PHY Configuration (0x0045) plen 0
>>        Status: Success (0x00)
>> @ MGMT Event: PHY Configuration Changed (0x0026) plen 4
>>        Selected PHYs: 0x7fff
>>          BR 1M 1SLOT
>>          BR 1M 3SLOT
>>          BR 1M 5SLOT
>>          EDR 2M 1SLOT
>>          EDR 2M 3SLOT
>>          EDR 2M 5SLOT
>>          EDR 3M 1SLOT
>>          EDR 3M 3SLOT
>>          EDR 3M 5SLOT
>>          LE 1M TX
>>          LE 1M RX
>>          LE 2M TX
>>          LE 2M RX
>>          LE CODED TX
>>          LE CODED RX
>>
>> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
>> ---
>> include/net/bluetooth/hci.h      |   1 +
>> include/net/bluetooth/hci_core.h |   1 +
>> include/net/bluetooth/mgmt.h     |  25 +++++
>> net/bluetooth/hci_core.c         |   4 +
>> net/bluetooth/hci_event.c        |  26 +++++
>> net/bluetooth/hci_sock.c         |   1 +
>> net/bluetooth/mgmt.c             | 221 +++++++++++++++++++++++++++++++++=
++++++
>> 7 files changed, 279 insertions(+)
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index 89bf800..d0f7657 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -214,6 +214,7 @@ enum {
>>       HCI_MGMT_DEV_CLASS_EVENTS,
>>       HCI_MGMT_LOCAL_NAME_EVENTS,
>>       HCI_MGMT_OOB_DATA_EVENTS,
>> +     HCI_MGMT_PHY_CHANGED_EVENTS,
>> };
>
> is this really needed? These flags are used for events that are condition=
al. Meaning they are send or not send depending on what mgmt command a give=
n socket has called. Since PHY configuration is new and has now legacy comm=
ands it deprecates, I really wonder what this if for. So you need to explai=
n that and if it is needed, split this out into a separate patch that expla=
ins it.
>
>>
>> /*
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hc=
i_core.h
>> index a64d13f..ab5d494 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -1544,6 +1544,7 @@ void mgmt_advertising_added(struct sock *sk, struc=
t hci_dev *hdev,
>>                           u8 instance);
>> void mgmt_advertising_removed(struct sock *sk, struct hci_dev *hdev,
>>                             u8 instance);
>> +int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *s=
kip);
>>
>> u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 laten=
cy,
>>                     u16 to_multiplier);
>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
>> index 16dddb1..047e98d 100644
>> --- a/include/net/bluetooth/mgmt.h
>> +++ b/include/net/bluetooth/mgmt.h
>> @@ -101,6 +101,7 @@ struct mgmt_rp_read_index_list {
>> #define MGMT_SETTING_PRIVACY          0x00002000
>> #define MGMT_SETTING_CONFIGURATION    0x00004000
>> #define MGMT_SETTING_STATIC_ADDRESS   0x00008000
>> +#define MGMT_SETTING_PHY_CONFIGURATION  0x00010000
>
> You are already using this in patch 02/13 and that makes this patch serie=
s non-bisectable.
>
>>
>> #define MGMT_OP_READ_INFO             0x0004
>> #define MGMT_READ_INFO_SIZE           0
>> @@ -628,6 +629,25 @@ struct mgmt_rp_get_phy_confguration {
>> #define MGMT_PHY_LE_CODED_TX  0x00002000
>> #define MGMT_PHY_LE_CODED_RX  0x00004000
>>
>> +#define MGMT_PHY_BREDR_MASK (MGMT_PHY_BR_1M_1SLOT | MGMT_PHY_BR_1M_3SLO=
T | \
>> +                             MGMT_PHY_BR_1M_5SLOT | MGMT_PHY_EDR_2M_1SL=
OT | \
>> +                             MGMT_PHY_EDR_2M_3SLOT | MGMT_PHY_EDR_2M_5S=
LOT | \
>> +                             MGMT_PHY_EDR_3M_1SLOT | MGMT_PHY_EDR_3M_3S=
LOT | \
>> +                             MGMT_PHY_EDR_3M_5SLOT)
>> +#define MGMT_PHY_LE_MASK (MGMT_PHY_LE_1M_TX | MGMT_PHY_LE_1M_RX | \
>> +                             MGMT_PHY_LE_2M_TX | MGMT_PHY_LE_2M_RX | \
>> +                             MGMT_PHY_LE_CODED_TX | MGMT_PHY_LE_CODED_R=
X)
>> +#define MGMT_PHY_LE_TX_MASK (MGMT_PHY_LE_1M_TX | MGMT_PHY_LE_2M_TX | \
>> +                          MGMT_PHY_LE_CODED_TX)
>> +#define MGMT_PHY_LE_RX_MASK (MGMT_PHY_LE_1M_RX | MGMT_PHY_LE_2M_RX | \
>> +                          MGMT_PHY_LE_CODED_RX)
>> +
>> +#define MGMT_OP_SET_PHY_CONFIGURATION        0x0045
>> +#define MGMT_SET_PHY_CONFIGURATION_SIZE              4
>> +struct mgmt_cp_set_phy_confguration {
>> +     __le32  selected_phys;
>> +} __packed;
>
> The _SIZE constant is normally below the data structure. Please follow th=
e existing style.
>
>> +
>> #define MGMT_EV_CMD_COMPLETE          0x0001
>> struct mgmt_ev_cmd_complete {
>>       __le16  opcode;
>> @@ -848,3 +868,8 @@ struct mgmt_ev_ext_info_changed {
>>       __le16  eir_len;
>>       __u8    eir[0];
>> } __packed;
>> +
>> +#define MGMT_EV_PHY_CONFIGURATION_CHANGED    0x0026
>> +struct mgmt_ev_phy_configuration_changed {
>> +     __le32  selected_phys;
>> +} __packed;
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 432f89f..0d88dc9 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -1924,7 +1924,11 @@ int hci_dev_cmd(unsigned int cmd, void __user *ar=
g)
>>               break;
>>
>>       case HCISETPTYPE:
>> +             if (hdev->pkt_type =3D=3D ((__u16) dr.dev_opt))
>> +                     break;
>> +
>
> What is the extra () doing here? I doubt that is needed.
>
>>               hdev->pkt_type =3D (__u16) dr.dev_opt;
>> +             mgmt_phy_configuration_changed(hdev, NULL);
>>               break;
>
> Also I would do that as a separate patch with a clear commit message that=
 this is for legacy behavior. But now I see why you might need that PHY cha=
nged event flag.
>
> So lets really do that in a separate patch to clearly point out legacy be=
havior and the change needed for handling it. This includes the events flag=
 etc. One question I have is if we care if the event is send all the time o=
r not.
>
> So for a client this is not conflicting information or duplicated informa=
tion coming along. It just means that someone changed the PHY configuration=
. This can happen via ioctl or mgmt and frankly an observer mgmt client wou=
ldn't be able to tell the difference anyway. So maybe this is just overkill=
 with no purpose.

So you mean we dont need the new flag?

>
> Also we might better make mgmt_phy_configuration_changed capable of check=
ing if an event is needed or not. Meaning it should check by itself if some=
thing changed or not. Don't remember how we did this for other functions. S=
o something to look into.
>
>>
>>       case HCISETACLMTU:
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 6819215..6942315 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -1042,6 +1042,28 @@ static void hci_cc_le_set_random_addr(struct hci_=
dev *hdev, struct sk_buff *skb)
>>       hci_dev_unlock(hdev);
>> }
>>
>> +static void hci_cc_le_set_default_phy(struct hci_dev *hdev, struct sk_b=
uff *skb)
>> +{
>> +     __u8 status =3D *((__u8 *) skb->data);
>> +     struct hci_cp_le_set_default_phy *cp;
>> +
>> +     BT_DBG("%s status 0x%2.2x", hdev->name, status);
>> +
>> +     if (status)
>> +             return;
>> +
>> +     cp =3D hci_sent_cmd_data(hdev, HCI_OP_LE_SET_DEFAULT_PHY);
>> +     if (!cp)
>> +             return;
>> +
>> +     hci_dev_lock(hdev);
>> +
>> +     hdev->le_tx_def_phys =3D cp->tx_phys;
>> +     hdev->le_rx_def_phys =3D cp->rx_phys;
>> +
>> +     hci_dev_unlock(hdev);
>> +}
>> +
>> static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buf=
f *skb)
>> {
>>       __u8 *sent, status =3D *((__u8 *) skb->data);
>> @@ -3163,6 +3185,10 @@ static void hci_cmd_complete_evt(struct hci_dev *=
hdev, struct sk_buff *skb,
>>               hci_cc_le_set_ext_scan_enable(hdev, skb);
>>               break;
>>
>> +     case HCI_OP_LE_SET_DEFAULT_PHY:
>> +             hci_cc_le_set_default_phy(hdev, skb);
>> +             break;
>> +
>>       default:
>>               BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
>>               break;
>> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
>> index 1506e16..476916c 100644
>> --- a/net/bluetooth/hci_sock.c
>> +++ b/net/bluetooth/hci_sock.c
>> @@ -1328,6 +1328,7 @@ static int hci_sock_bind(struct socket *sock, stru=
ct sockaddr *addr,
>>                       hci_sock_set_flag(sk, HCI_MGMT_SETTING_EVENTS);
>>                       hci_sock_set_flag(sk, HCI_MGMT_DEV_CLASS_EVENTS);
>>                       hci_sock_set_flag(sk, HCI_MGMT_LOCAL_NAME_EVENTS);
>> +                     hci_sock_set_flag(sk, HCI_MGMT_PHY_CHANGED_EVENTS)=
;
>>               }
>>               break;
>>       }
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 4a31d4d..1c2ed42 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -737,6 +737,23 @@ static u32 get_configurable_phys(struct hci_dev *hd=
ev)
>>                       ~MGMT_PHY_LE_1M_TX & ~MGMT_PHY_LE_1M_RX);
>> }
>>
>> +static bool phys_configured(struct hci_dev *hdev)
>> +{
>> +     u32 selected_phys =3D get_selected_phys(hdev);
>> +     u32 supported_phys =3D get_supported_phys(hdev);
>> +
>> +     /* If any of BREDR supported PHYs are deselected or
>> +      *  LE PHYs other than 1M are selected
>
> You have extra spaces in the front.
>
>> +      */
>> +     if (((supported_phys & MGMT_PHY_BREDR_MASK) !=3D
>> +              (selected_phys & MGMT_PHY_BREDR_MASK)) ||
>> +             ((selected_phys & MGMT_PHY_LE_MASK) &
>> +               ~(MGMT_PHY_LE_1M_TX | MGMT_PHY_LE_1M_RX)))
>
> This alignment is not okay. Go over the character per line limit here if =
needed.
>
> One question though, why are making an exception for LE_1M here?
>

LE is supported will mean that LE_!M is supported and also cannot be
configured (deselected).

>> +             return true;
>> +
>> +     return false;
>> +}
>> +
>> static u32 get_supported_settings(struct hci_dev *hdev)
>> {
>>       u32 settings =3D 0;
>> @@ -3332,6 +3349,209 @@ static int get_phy_configuration(struct sock *sk=
, struct hci_dev *hdev,
>>                                &rp, sizeof(rp));
>> }
>>
>> +int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *s=
kip)
>> +{
>> +     struct mgmt_ev_phy_configuration_changed ev;
>> +
>> +     memset(&ev, 0, sizeof(ev));
>> +
>> +     ev.selected_phys =3D cpu_to_le32(get_selected_phys(hdev));
>> +
>> +     return mgmt_limited_event(MGMT_EV_PHY_CONFIGURATION_CHANGED, hdev,=
 &ev,
>> +                               sizeof(ev), HCI_MGMT_PHY_CHANGED_EVENTS,
>> +                               skip);
>> +}
>> +
>> +static void set_default_phy_complete(struct hci_dev *hdev, u8 status,
>> +                                  u16 opcode, struct sk_buff *skb)
>> +{
>> +     struct mgmt_cp_set_phy_confguration *cp;
>> +     struct mgmt_pending_cmd *cmd;
>> +
>> +     BT_DBG("status 0x%02x", status);
>> +
>> +     hci_dev_lock(hdev);
>> +
>> +     cmd =3D pending_find(MGMT_OP_SET_PHY_CONFIGURATION, hdev);
>> +     if (!cmd)
>> +             goto unlock;
>> +
>> +     cp =3D cmd->param;
>> +
>> +     if (status) {
>> +             mgmt_cmd_status(cmd->sk, hdev->id,
>> +                             MGMT_OP_SET_PHY_CONFIGURATION,
>> +                             mgmt_status(status));
>> +     } else {
>> +             mgmt_cmd_complete(cmd->sk, hdev->id,
>> +                               MGMT_OP_SET_PHY_CONFIGURATION, 0,
>> +                               NULL, 0);
>> +
>> +             mgmt_phy_configuration_changed(hdev, cmd->sk);
>> +             new_settings(hdev, cmd->sk);
>
> This new_settings we really need to discuss and document its behavior.

As per our initial discussion, NewSettings will have PHY Configuration bit =
set
if any PHYs other than 1M is selected. I have extended it to BREDR wherein =
it
will be set if any of the PHYs are deselected.

Thanks,
Jaganath
