Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJzH+bpD0WqNC8WJpNcQ-6+8Rv60MNM54GQkWNg2r0qXvroNMg@mail.gmail.com>
References: <1508324716-3041-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1508324716-3041-2-git-send-email-jaganathx.kanakkassery@intel.com>
 <CABBYNZLDn-K+oB7wNHJDB8svfsVwyk-VcAyNYMVqUZa2Q_fZqA@mail.gmail.com> <CAJzH+bpD0WqNC8WJpNcQ-6+8Rv60MNM54GQkWNg2r0qXvroNMg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Oct 2017 15:04:57 +0300
Message-ID: <CABBYNZLsGe+iXScst-N1EQPN1UAn9RewNSPghSD4PO5bhu+L4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Implement extended LE Connection
To: Jaganath K <jaganath.k.os@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Mon, Oct 23, 2017 at 2:52 PM, Jaganath K <jaganath.k.os@gmail.com> wrote:
> Hi Luiz,
>
> On Mon, Oct 23, 2017 at 5:08 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Jaganath,
>>
>> On Wed, Oct 18, 2017 at 2:05 PM, Jaganath Kanakkassery
>> <jaganath.k.os@gmail.com> wrote:
>>> This implements extended LE craete connection and enhanced
>>> LE conn complete event if the controller supports.
>>>
>>> For now it is as good as legacy LE connection and event as
>>> no new features in the extended connection is handled.
>>>
>>> < HCI Command: LE Extended Create Connection (0x08|0x0043) plen 26
>>>         Filter policy: White list is not used (0x00)
>>>         Own address type: Public (0x00)
>>>         Peer address type: Random (0x01)
>>>         Peer address: DB:7E:2E:1D:85:E8 (Static)
>>>         Initiating PHYs: 0x01
>>>         Entry 0: LE 1M
>>>           Scan interval: 60.000 msec (0x0060)
>>>           Scan window: 60.000 msec (0x0060)
>>>           Min connection interval: 50.00 msec (0x0028)
>>>           Max connection interval: 70.00 msec (0x0038)
>>>           Connection latency: 0 (0x0000)
>>>           Supervision timeout: 420 msec (0x002a)
>>>           Min connection length: 0.000 msec (0x0000)
>>>           Max connection length: 0.000 msec (0x0000)
>>>> HCI Event: Command Status (0x0f) plen 4
>>>       LE Extended Create Connection (0x08|0x0043) ncmd 2
>>>         Status: Success (0x00)
>>>> HCI Event: LE Meta Event (0x3e) plen 31
>>>       LE Enhanced Connection Complete (0x0a)
>>>         Status: Success (0x00)
>>>         Handle: 3585
>>>         Role: Master (0x00)
>>>         Peer address type: Random (0x01)
>>>         Peer address: DB:7E:2E:1D:85:E8 (Static)
>>>         Local resolvable private address: 00:00:00:00:00:00 (Non-Resolvable)
>>>         Peer resolvable private address: 00:00:00:00:00:00 (Non-Resolvable)
>>>         Connection interval: 67.50 msec (0x0036)
>>>         Connection latency: 0 (0x0000)
>>>         Supervision timeout: 420 msec (0x002a)
>>>         Master clock accuracy: 0x00
>>> @ MGMT Event: Device Connected (0x000b) plen 40
>>>         LE Address: DB:7E:2E:1D:85:E8 (Static)
>>>         Flags: 0x00000000
>>>         Data length: 27
>>>         Name (complete): Designer Mouse
>>>         Appearance: Mouse (0x03c2)
>>>         Flags: 0x05
>>>           LE Limited Discoverable Mode
>>>           BR/EDR Not Supported
>>>         16-bit Service UUIDs (complete): 1 entry
>>>           Human Interface Device (0x1812)
>>>
>>> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
>>> ---
>>>  include/net/bluetooth/hci.h | 36 ++++++++++++++++++++++
>>>  net/bluetooth/hci_conn.c    | 73 ++++++++++++++++++++++++++++++++++-----------
>>>  net/bluetooth/hci_core.c    |  6 ++++
>>>  net/bluetooth/hci_event.c   | 47 +++++++++++++++++++++++++++++
>>>  4 files changed, 144 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>> index a4ab295..416b935 100644
>>> --- a/include/net/bluetooth/hci.h
>>> +++ b/include/net/bluetooth/hci.h
>>> @@ -1530,6 +1530,27 @@ struct hci_cp_le_set_ext_scan_enable {
>>>         __le16  period;
>>>  } __packed;
>>>
>>> +#define HCI_OP_LE_EXT_CREATE_CONN    0x2043
>>> +struct hci_cp_le_ext_create_conn {
>>> +       __u8      filter_policy;
>>> +       __u8      own_addr_type;
>>> +       __u8      peer_addr_type;
>>> +       bdaddr_t  peer_addr;
>>> +       __u8      phys;
>>> +       __u8      data[0];
>>> +} __packed;
>>> +
>>> +struct hci_cp_le_ext_conn_param {
>>> +       __le16 scan_interval;
>>> +       __le16 scan_window;
>>> +       __le16 conn_interval_min;
>>> +       __le16 conn_interval_max;
>>> +       __le16 conn_latency;
>>> +       __le16 supervision_timeout;
>>> +       __le16 min_ce_len;
>>> +       __le16 max_ce_len;
>>> +} __packed;
>>> +
>>>  /* ---- HCI Events ---- */
>>>  #define HCI_EV_INQUIRY_COMPLETE                0x01
>>>
>>> @@ -2007,6 +2028,21 @@ struct hci_ev_le_ext_adv_report {
>>>         __u8     data[0];
>>>  } __packed;
>>>
>>> +#define HCI_EV_LE_ENHANCED_CONN_COMPLETE    0x0a
>>> +struct hci_ev_le_enh_conn_complete {
>>> +       __u8      status;
>>> +       __le16    handle;
>>> +       __u8      role;
>>> +       __u8      bdaddr_type;
>>> +       bdaddr_t  bdaddr;
>>> +       bdaddr_t  local_rpa;
>>> +       bdaddr_t  peer_rpa;
>>> +       __le16    interval;
>>> +       __le16    latency;
>>> +       __le16    supervision_timeout;
>>> +       __u8      clk_accurancy;
>>> +} __packed;
>>> +
>>>  /* Internal events generated by Bluetooth stack */
>>>  #define HCI_EV_STACK_INTERNAL  0xfd
>>>  struct hci_ev_stack_internal {
>>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>>> index dc59eae..3538b69 100644
>>> --- a/net/bluetooth/hci_conn.c
>>> +++ b/net/bluetooth/hci_conn.c
>>> @@ -751,7 +751,6 @@ static bool conn_use_rpa(struct hci_conn *conn)
>>>  static void hci_req_add_le_create_conn(struct hci_request *req,
>>>                                        struct hci_conn *conn)
>>>  {
>>> -       struct hci_cp_le_create_conn cp;
>>>         struct hci_dev *hdev = conn->hdev;
>>>         u8 own_addr_type;
>>>
>>> @@ -762,25 +761,63 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
>>>                                       &own_addr_type))
>>>                 return;
>>>
>>> -       memset(&cp, 0, sizeof(cp));
>>> +       /* Use extended conn if supported */
>>> +       if (hdev->commands[37] & 0x80) {
>>> +               struct hci_cp_le_ext_create_conn *cp;
>>> +               struct hci_cp_le_ext_conn_param *p;
>>> +               /* As of now only LE 1M is supported */
>>> +               u8 data[sizeof(*cp) + sizeof(*p) * 1];
>>
>> Is there any point in using extended version if we can only do
>> 1Mbit/s, is there any practical difference? Is there any reason we are
>> not trying 2 Mbit/s phy as well?
>>
>
> The idea is to first implement the extended version with no functionality
> change (ie with PHY as 1M). We are planning to expose kernel
> interface so that user can select the PHY for the connection. We can add
> other PHYs accordingly during the implementation of the interfaces.

There is nothing here suggesting what sort of interface we will use
for switching between 1-2 MBit/s, usually, for BR/EDR we choose the
best possible (or let the controller do so) we will continue with the
same logic the phy policy will reside in the kernel anyway. Are there
any reasons why we cannot request 2MBit/s?

>>> -       /* Set window to be the same value as the interval to enable
>>> -        * continuous scanning.
>>> -        */
>>> -       cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
>>> -       cp.scan_window = cp.scan_interval;
>>> +               cp = (void *) data;
>>> +               p = (void *) cp->data;
>>>
>>> -       bacpy(&cp.peer_addr, &conn->dst);
>>> -       cp.peer_addr_type = conn->dst_type;
>>> -       cp.own_address_type = own_addr_type;
>>> -       cp.conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
>>> -       cp.conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
>>> -       cp.conn_latency = cpu_to_le16(conn->le_conn_latency);
>>> -       cp.supervision_timeout = cpu_to_le16(conn->le_supv_timeout);
>>> -       cp.min_ce_len = cpu_to_le16(0x0000);
>>> -       cp.max_ce_len = cpu_to_le16(0x0000);
>>> -
>>> -       hci_req_add(req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
>>> +               memset(cp, 0, sizeof(*cp));
>>> +
>>> +               bacpy(&cp->peer_addr, &conn->dst);
>>> +               cp->peer_addr_type = conn->dst_type;
>>> +               cp->own_addr_type = own_addr_type;
>>> +               cp->phys = LE_PHY_1M;
>>> +
>>> +               memset(p, 0, sizeof(*p));
>>> +
>>> +               /* Set window to be the same value as the interval to enable
>>> +                * continuous scanning.
>>> +                */
>>> +
>>> +               p->scan_interval = cpu_to_le16(hdev->le_scan_interval);
>>> +               p->scan_window = p->scan_interval;
>>> +               p->conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
>>> +               p->conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
>>> +               p->conn_latency = cpu_to_le16(conn->le_conn_latency);
>>> +               p->supervision_timeout = cpu_to_le16(conn->le_supv_timeout);
>>> +               p->min_ce_len = cpu_to_le16(0x0000);
>>> +               p->max_ce_len = cpu_to_le16(0x0000);
>>> +
>>> +               hci_req_add(req, HCI_OP_LE_EXT_CREATE_CONN, sizeof(data), data);
>>> +
>>> +       } else {
>>> +               struct hci_cp_le_create_conn cp;
>>> +
>>> +               memset(&cp, 0, sizeof(cp));
>>> +
>>> +               /* Set window to be the same value as the interval to enable
>>> +                * continuous scanning.
>>> +                */
>>> +               cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
>>> +               cp.scan_window = cp.scan_interval;
>>> +
>>> +               bacpy(&cp.peer_addr, &conn->dst);
>>> +               cp.peer_addr_type = conn->dst_type;
>>> +               cp.own_address_type = own_addr_type;
>>> +               cp.conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
>>> +               cp.conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
>>> +               cp.conn_latency = cpu_to_le16(conn->le_conn_latency);
>>> +               cp.supervision_timeout = cpu_to_le16(conn->le_supv_timeout);
>>> +               cp.min_ce_len = cpu_to_le16(0x0000);
>>> +               cp.max_ce_len = cpu_to_le16(0x0000);
>>> +
>>> +               hci_req_add(req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
>>> +       }
>>>
>>>         conn->state = BT_CONNECT;
>>>         clear_bit(HCI_CONN_SCANNING, &conn->flags);
>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>> index eb5999a..a5a47ee 100644
>>> --- a/net/bluetooth/hci_core.c
>>> +++ b/net/bluetooth/hci_core.c
>>> @@ -711,6 +711,12 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
>>>                 if (hdev->commands[37] & 0x20 && hdev->commands[37] & 0x40)
>>>                         events[1] |= 0x10;      /* LE Extended adv report */
>>>
>>> +               /* If the controller supports the LE Extended connection
>>> +                *  enable the corresponding event.
>>> +                */
>>> +               if (hdev->commands[37] & 0x80)
>>> +                       events[1] |= 0x02;      /* LE Enhanced conn complete */
>>> +
>>>                 hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
>>>                             events);
>>>
>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>> index de7b3c3..5d0517b 100644
>>> --- a/net/bluetooth/hci_event.c
>>> +++ b/net/bluetooth/hci_event.c
>>> @@ -2003,6 +2003,31 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, u8 status)
>>>         hci_dev_unlock(hdev);
>>>  }
>>>
>>> +static void hci_cs_le_ext_create_conn(struct hci_dev *hdev, u8 status)
>>> +{
>>> +       struct hci_cp_le_ext_create_conn *cp;
>>> +
>>> +       BT_DBG("%s status 0x%2.2x", hdev->name, status);
>>> +
>>> +       /* All connection failure handling is taken care of by the
>>> +        * hci_le_conn_failed function which is triggered by the HCI
>>> +        * request completion callbacks used for connecting.
>>> +        */
>>> +       if (status)
>>> +               return;
>>> +
>>> +       cp = hci_sent_cmd_data(hdev, HCI_OP_LE_EXT_CREATE_CONN);
>>> +       if (!cp)
>>> +               return;
>>> +
>>> +       hci_dev_lock(hdev);
>>> +
>>> +       cs_le_create_conn(hdev, &cp->peer_addr, cp->peer_addr_type,
>>> +                         cp->own_addr_type, cp->filter_policy);
>>> +
>>> +       hci_dev_unlock(hdev);
>>> +}
>>> +
>>>  static void hci_cs_le_read_remote_features(struct hci_dev *hdev, u8 status)
>>>  {
>>>         struct hci_cp_le_read_remote_features *cp;
>>> @@ -3198,6 +3223,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
>>>                 hci_cs_le_start_enc(hdev, ev->status);
>>>                 break;
>>>
>>> +       case HCI_OP_LE_EXT_CREATE_CONN:
>>> +               hci_cs_le_ext_create_conn(hdev, ev->status);
>>> +               break;
>>> +
>>>         default:
>>>                 BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
>>>                 break;
>>> @@ -4696,6 +4725,20 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
>>>                              le16_to_cpu(ev->supervision_timeout));
>>>  }
>>>
>>> +static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
>>> +                                        struct sk_buff *skb)
>>> +{
>>> +       struct hci_ev_le_enh_conn_complete *ev = (void *) skb->data;
>>> +
>>> +       BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
>>> +
>>> +       le_conn_complete_evt(hdev, ev->status, &ev->bdaddr, ev->bdaddr_type,
>>> +                            ev->role, le16_to_cpu(ev->handle),
>>> +                            le16_to_cpu(ev->interval),
>>> +                            le16_to_cpu(ev->latency),
>>> +                            le16_to_cpu(ev->supervision_timeout));
>>> +}
>>> +
>>>  static void hci_le_conn_update_complete_evt(struct hci_dev *hdev,
>>>                                             struct sk_buff *skb)
>>>  {
>>> @@ -5305,6 +5348,10 @@ static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
>>>                 hci_le_ext_adv_report_evt(hdev, skb);
>>>                 break;
>>>
>>> +       case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
>>> +               hci_le_enh_conn_complete_evt(hdev, skb);
>>> +               break;
>>> +
>>>         default:
>>>                 break;
>>>         }
>>> --
>>> 2.7.4
>
> Thanks,
> Jaganath



-- 
Luiz Augusto von Dentz
