Return-Path: <jaganath.k.os@gmail.com>
MIME-Version: 1.0
In-Reply-To: <45DD34F0-0375-4EFB-B354-68EB373A3DE1@holtmann.org>
References: <1531301495-14479-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1531301495-14479-3-git-send-email-jaganathx.kanakkassery@intel.com> <45DD34F0-0375-4EFB-B354-68EB373A3DE1@holtmann.org>
From: Jaganath K <jaganath.k.os@gmail.com>
Date: Sun, 15 Jul 2018 13:26:03 +0530
Message-ID: <CAJzH+brmqSdFSZ+EkvtLc6yMk3C2FsveEnoU0+XcEF4Ks+1gDQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] Bluetooth: Implement Get PHY Configuration mgmt command
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


On Sat, Jul 14, 2018 at 10:30 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jaganath,
>
>> This commands basically retrieve the supported packet types of
>> BREDR and supported PHYs of the controller.
>>
>> BR_1M_1SLOT, LE_1M_TX and LE_1M_RX would be supported by default.
>> Other PHYs are supported based on the local features.
>>
>> @ MGMT Command: Get PHY Configuration (0x0044) plen 0
>> @ MGMT Event: Command Complete (0x0001) plen 15
>>      Get PHY Configuration (0x0044) plen 12
>>        Status: Success (0x00)
>>        Supported PHYs: 0x7fff
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
>>        Configurable PHYs: 0x79fe
>>          BR 1M 3SLOT
>>          BR 1M 5SLOT
>>          EDR 2M 1SLOT
>>          EDR 2M 3SLOT
>>          EDR 2M 5SLOT
>>          EDR 3M 1SLOT
>>          EDR 3M 3SLOT
>>          EDR 3M 5SLOT
>>          LE 2M TX
>>          LE 2M RX
>>          LE CODED TX
>>          LE CODED RX
>>        Selected PHYs: 0x07ff
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
>>
>> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
>> ---
>> include/net/bluetooth/hci.h      |  14 ++++
>> include/net/bluetooth/hci_core.h |   4 ++
>> include/net/bluetooth/mgmt.h     |  24 +++++++
>> net/bluetooth/mgmt.c             | 149 +++++++++++++++++++++++++++++++++++++++
>> 4 files changed, 191 insertions(+)
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index 664fe1e..89bf800 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -291,6 +291,14 @@ enum {
>> #define HCI_DH3               0x0800
>> #define HCI_DH5               0x8000
>>
>> +/* HCI packet types inverted masks */
>> +#define HCI_2DH1     0x0002
>> +#define HCI_3DH1     0x0004
>> +#define HCI_2DH3     0x0100
>> +#define HCI_3DH3     0x0200
>> +#define HCI_2DH5     0x1000
>> +#define HCI_3DH5     0x2000
>> +
>> #define HCI_HV1               0x0020
>> #define HCI_HV2               0x0040
>> #define HCI_HV3               0x0080
>> @@ -354,6 +362,8 @@ enum {
>> #define LMP_PCONTROL  0x04
>> #define LMP_TRANSPARENT       0x08
>>
>> +#define LMP_EDR_2M           0x02
>> +#define LMP_EDR_3M           0x04
>> #define LMP_RSSI_INQ  0x40
>> #define LMP_ESCO      0x80
>>
>> @@ -361,7 +371,9 @@ enum {
>> #define LMP_EV5               0x02
>> #define LMP_NO_BREDR  0x20
>> #define LMP_LE                0x40
>> +#define LMP_EDR_3SLOT        0x80
>>
>> +#define LMP_EDR_5SLOT        0x01
>> #define LMP_SNIFF_SUBR        0x02
>> #define LMP_PAUSE_ENC 0x04
>> #define LMP_EDR_ESCO_2M       0x20
>> @@ -399,6 +411,8 @@ enum {
>> #define HCI_LE_PING                   0x10
>> #define HCI_LE_DATA_LEN_EXT           0x20
>> #define HCI_LE_EXT_SCAN_POLICY                0x80
>> +#define HCI_LE_PHY_2M                        0x01
>> +#define HCI_LE_PHY_CODED             0x08
>> #define HCI_LE_CHAN_SEL_ALG2          0x40
>
> I see why you used _SET in the previous patch. Maybe it is ok to leave it that way.
>
>>
>> /* Connection modes */
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 71f79df..a64d13f 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -1141,6 +1141,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>> #define lmp_inq_tx_pwr_capable(dev) ((dev)->features[0][7] & LMP_INQ_TX_PWR)
>> #define lmp_ext_feat_capable(dev)  ((dev)->features[0][7] & LMP_EXTFEATURES)
>> #define lmp_transp_capable(dev)    ((dev)->features[0][2] & LMP_TRANSPARENT)
>> +#define lmp_edr_2m_capable(dev)    ((dev)->features[0][3] & LMP_EDR_2M)
>> +#define lmp_edr_3m_capable(dev)    ((dev)->features[0][3] & LMP_EDR_3M)
>> +#define lmp_edr_3slot_capable(dev) ((dev)->features[0][4] & LMP_EDR_3SLOT)
>> +#define lmp_edr_5slot_capable(dev) ((dev)->features[0][5] & LMP_EDR_5SLOT)
>
> Lets split the non-mgmt related changes from the mgmt ones into separate patches.
>
>>
>> /* ----- Extended LMP capabilities ----- */
>> #define lmp_csb_master_capable(dev) ((dev)->features[2][0] & LMP_CSB_MASTER)
>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
>> index e7303ee..16dddb1 100644
>> --- a/include/net/bluetooth/mgmt.h
>> +++ b/include/net/bluetooth/mgmt.h
>> @@ -604,6 +604,30 @@ struct mgmt_cp_set_appearance {
>> } __packed;
>> #define MGMT_SET_APPEARANCE_SIZE      2
>>
>> +#define MGMT_OP_GET_PHY_CONFIGURATION        0x0044
>> +#define MGMT_GET_PHY_CONFIGURATION_SIZE              0
>> +struct mgmt_rp_get_phy_confguration {
>> +     __le32  supported_phys;
>> +     __le32  configurable_phys;
>> +     __le32  selected_phys;
>> +} __packed;
>> +
>> +#define MGMT_PHY_BR_1M_1SLOT 0x00000001
>> +#define MGMT_PHY_BR_1M_3SLOT 0x00000002
>> +#define MGMT_PHY_BR_1M_5SLOT 0x00000004
>> +#define MGMT_PHY_EDR_2M_1SLOT        0x00000008
>> +#define MGMT_PHY_EDR_2M_3SLOT        0x00000010
>> +#define MGMT_PHY_EDR_2M_5SLOT        0x00000020
>> +#define MGMT_PHY_EDR_3M_1SLOT        0x00000040
>> +#define MGMT_PHY_EDR_3M_3SLOT        0x00000080
>> +#define MGMT_PHY_EDR_3M_5SLOT        0x00000100
>> +#define MGMT_PHY_LE_1M_TX            0x00000200
>> +#define MGMT_PHY_LE_1M_RX            0x00000400
>> +#define MGMT_PHY_LE_2M_TX            0x00000800
>> +#define MGMT_PHY_LE_2M_RX            0x00001000
>> +#define MGMT_PHY_LE_CODED_TX 0x00002000
>> +#define MGMT_PHY_LE_CODED_RX 0x00004000
>> +
>> #define MGMT_EV_CMD_COMPLETE          0x0001
>> struct mgmt_ev_cmd_complete {
>>       __le16  opcode;
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 8a80d48..4a31d4d 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -617,6 +617,126 @@ static int read_config_info(struct sock *sk, struct hci_dev *hdev,
>>                                &rp, sizeof(rp));
>> }
>>
>> +static u32 get_supported_phys(struct hci_dev *hdev)
>> +{
>> +     u32 supported_phys = 0;
>> +
>> +     if (lmp_bredr_capable(hdev)) {
>> +             supported_phys |= MGMT_PHY_BR_1M_1SLOT;
>> +
>> +             if (hdev->features[0][0] & LMP_3SLOT)
>> +                     supported_phys |= MGMT_PHY_BR_1M_3SLOT;
>> +
>> +             if (hdev->features[0][0] & LMP_5SLOT)
>> +                     supported_phys |= MGMT_PHY_BR_1M_5SLOT;
>> +
>> +             if (lmp_edr_2m_capable(hdev)) {
>> +                     supported_phys |= MGMT_PHY_EDR_2M_1SLOT;
>> +
>> +                     if (lmp_edr_3slot_capable(hdev))
>> +                             supported_phys |= MGMT_PHY_EDR_2M_3SLOT;
>> +
>> +                     if (lmp_edr_5slot_capable(hdev))
>> +                             supported_phys |= MGMT_PHY_EDR_2M_5SLOT;
>> +
>> +                     if (lmp_edr_3m_capable(hdev)) {
>> +                             supported_phys |= MGMT_PHY_EDR_3M_1SLOT;
>> +
>> +                             if (lmp_edr_3slot_capable(hdev))
>> +                                     supported_phys |= MGMT_PHY_EDR_3M_3SLOT;
>> +
>> +                             if (lmp_edr_5slot_capable(hdev))
>> +                                     supported_phys |= MGMT_PHY_EDR_3M_5SLOT;
>> +                     }
>> +             }
>> +     }
>> +
>> +     if (lmp_le_capable(hdev)) {
>> +             supported_phys |= MGMT_PHY_LE_1M_TX;
>> +             supported_phys |= MGMT_PHY_LE_1M_RX;
>> +
>> +             if (hdev->le_features[1] & HCI_LE_PHY_2M) {
>> +                     supported_phys |= MGMT_PHY_LE_2M_TX;
>> +                     supported_phys |= MGMT_PHY_LE_2M_RX;
>> +             }
>
> Extra empty line here.
>
>> +             if (hdev->le_features[1] & HCI_LE_PHY_CODED) {
>> +                     supported_phys |= MGMT_PHY_LE_CODED_TX;
>> +                     supported_phys |= MGMT_PHY_LE_CODED_RX;
>> +             }
>> +     }
>> +
>> +     return supported_phys;
>> +}
>> +
>> +static u32 get_selected_phys(struct hci_dev *hdev)
>> +{
>> +     u32 selected_phys = 0;
>> +
>> +     if (lmp_bredr_capable(hdev)) {
>> +             selected_phys |= MGMT_PHY_BR_1M_1SLOT;
>> +
>> +             if (hdev->pkt_type & (HCI_DM3 | HCI_DH3))
>> +                     selected_phys |= MGMT_PHY_BR_1M_3SLOT;
>> +
>> +             if (hdev->pkt_type & (HCI_DM5 | HCI_DH5))
>> +                     selected_phys |= MGMT_PHY_BR_1M_5SLOT;
>> +
>> +             if (lmp_edr_2m_capable(hdev)) {
>> +                     if (!(hdev->pkt_type & HCI_2DH1))
>> +                             selected_phys |= MGMT_PHY_EDR_2M_1SLOT;
>> +
>> +                     if (lmp_edr_3slot_capable(hdev) &&
>> +                             !(hdev->pkt_type & HCI_2DH3))
>
> these need to align according to the netdev coding style.
>
>> +                             selected_phys |= MGMT_PHY_EDR_2M_3SLOT;
>> +
>> +                     if (lmp_edr_5slot_capable(hdev) &&
>> +                             !(hdev->pkt_type & HCI_2DH5))
>> +                             selected_phys |= MGMT_PHY_EDR_2M_5SLOT;
>> +
>> +                     if (lmp_edr_3m_capable(hdev)) {
>> +                             if (!(hdev->pkt_type & HCI_3DH1))
>> +                                     selected_phys |= MGMT_PHY_EDR_3M_1SLOT;
>> +
>> +                             if (lmp_edr_3slot_capable(hdev) &&
>> +                                     !(hdev->pkt_type & HCI_3DH3))
>> +                                     selected_phys |= MGMT_PHY_EDR_3M_3SLOT;
>> +
>> +                             if (lmp_edr_5slot_capable(hdev) &&
>> +                                     !(hdev->pkt_type & HCI_3DH5))
>> +                                     selected_phys |= MGMT_PHY_EDR_3M_5SLOT;
>> +                     }
>> +             }
>> +     }
>> +
>> +     if (lmp_le_capable(hdev)) {
>> +             if (hdev->le_tx_def_phys & HCI_LE_SET_PHY_1M)
>> +                     selected_phys |= MGMT_PHY_LE_1M_TX;
>> +
>> +             if (hdev->le_rx_def_phys & HCI_LE_SET_PHY_1M)
>> +                     selected_phys |= MGMT_PHY_LE_1M_RX;
>> +
>> +             if (hdev->le_tx_def_phys & HCI_LE_SET_PHY_2M)
>> +                     selected_phys |= MGMT_PHY_LE_2M_TX;
>> +
>> +             if (hdev->le_rx_def_phys & HCI_LE_SET_PHY_2M)
>> +                     selected_phys |= MGMT_PHY_LE_2M_RX;
>> +
>> +             if (hdev->le_tx_def_phys & HCI_LE_SET_PHY_CODED)
>> +                     selected_phys |= MGMT_PHY_LE_CODED_TX;
>> +
>> +             if (hdev->le_rx_def_phys & HCI_LE_SET_PHY_CODED)
>> +                     selected_phys |= MGMT_PHY_LE_CODED_RX;
>> +     }
>> +
>> +     return selected_phys;
>> +}
>> +
>> +static u32 get_configurable_phys(struct hci_dev *hdev)
>> +{
>> +     return (get_supported_phys(hdev) & ~MGMT_PHY_BR_1M_1SLOT &
>> +                     ~MGMT_PHY_LE_1M_TX & ~MGMT_PHY_LE_1M_RX);
>
> Here the alignment needs to be also corrected.
>
>> +}
>> +
>> static u32 get_supported_settings(struct hci_dev *hdev)
>> {
>>       u32 settings = 0;
>> @@ -654,6 +774,10 @@ static u32 get_supported_settings(struct hci_dev *hdev)
>>           hdev->set_bdaddr)
>>               settings |= MGMT_SETTING_CONFIGURATION;
>>
>> +     if (get_supported_phys(hdev) & ~(MGMT_PHY_BR_1M_1SLOT | MGMT_PHY_LE_1M_TX |
>> +                                     MGMT_PHY_LE_1M_RX))
>
> Same here.
>
>> +             settings |= MGMT_SETTING_PHY_CONFIGURATION;
>> +
>
> Frankly I think that PHY configuration can be unconditionally be listed as supported here. Even on a 4.0 or just a 1.2 device we should hint that PHY configuration is possible.

If a controller supports only BR 1M 1 SLOT and / or only LE 1M then
PHY configuration should not be
set (which is what the check is doing).

>
>>       return settings;
>> }
>>
>> @@ -722,6 +846,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
>>                       settings |= MGMT_SETTING_STATIC_ADDRESS;
>>       }
>>
>> +     if (phys_configured(hdev))
>> +             settings |= MGMT_SETTING_PHY_CONFIGURATION;
>> +
>
> What is this conditional doing? You need to add a comment here explaining when we set configuration flag in current settings and when not.

This checks whether any PHY is deselected in BREDR or selected in LE.
Will add comment.

So basically it will be set in supported settings if any PHYs other
than the basic PHYs is supported
and will set in current settings if any PHYs are configured
(deselected in BREDR or selected in LE).

Thanks,
Jaganath
