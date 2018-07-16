Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v4 05/13] Bluetooth: Handle extended ADV PDU types
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJzH+bqBaraAHGCSzMhY6sHgTLKfx=9i0T3S7vZgckeTGi7xnw@mail.gmail.com>
Date: Mon, 16 Jul 2018 15:09:41 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <3668EF79-8D9F-4538-B3F7-8FBB08D86171@holtmann.org>
References: <1531301495-14479-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1531301495-14479-6-git-send-email-jaganathx.kanakkassery@intel.com>
 <FA5EB638-DC05-4F96-9234-A732E3FA1F3E@holtmann.org>
 <CAJzH+bqBaraAHGCSzMhY6sHgTLKfx=9i0T3S7vZgckeTGi7xnw@mail.gmail.com>
To: Jaganath K <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

>>> This patch defines the extended ADV types and handle it in ADV report.
>>> 
>>> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
>>> ---
>>> include/net/bluetooth/hci.h |  8 ++++++++
>>> net/bluetooth/hci_event.c   | 49 +++++++++++++++++++++++++++++++--------------
>>> 2 files changed, 42 insertions(+), 15 deletions(-)
>>> 
>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>> index 3584632..fcd1d57 100644
>>> --- a/include/net/bluetooth/hci.h
>>> +++ b/include/net/bluetooth/hci.h
>>> @@ -1977,6 +1977,14 @@ struct hci_ev_le_conn_complete {
>>> #define LE_LEGACY_SCAN_RSP_ADV                0x001b
>>> #define LE_LEGACY_SCAN_RSP_ADV_SCAN   0x001a
>>> 
>>> +/* Extended Advertising event types */
>>> +#define LE_EXT_ADV_NON_CONN_IND              0x0000
>>> +#define LE_EXT_ADV_CONN_IND          0x0001
>>> +#define LE_EXT_ADV_SCAN_IND          0x0002
>>> +#define LE_EXT_ADV_DIRECT_IND                0x0004
>>> +#define LE_EXT_ADV_SCAN_RSP          0x0008
>>> +#define LE_EXT_ADV_LEGACY_PDU                0x0010
>>> +
>>> #define ADDR_LE_DEV_PUBLIC    0x00
>>> #define ADDR_LE_DEV_RANDOM    0x01
>>> 
>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>> index 6942315..027abe6 100644
>>> --- a/net/bluetooth/hci_event.c
>>> +++ b/net/bluetooth/hci_event.c
>>> @@ -5137,20 +5137,39 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>>>      hci_dev_unlock(hdev);
>>> }
>>> 
>>> -static u8 convert_legacy_evt_type(u16 evt_type)
>>> -{
>>> -     switch (evt_type) {
>>> -     case LE_LEGACY_ADV_IND:
>>> -             return LE_ADV_IND;
>>> -     case LE_LEGACY_ADV_DIRECT_IND:
>>> -             return LE_ADV_DIRECT_IND;
>>> -     case LE_LEGACY_ADV_SCAN_IND:
>>> -             return LE_ADV_SCAN_IND;
>>> -     case LE_LEGACY_NONCONN_IND:
>>> -             return LE_ADV_NONCONN_IND;
>>> -     case LE_LEGACY_SCAN_RSP_ADV:
>>> -     case LE_LEGACY_SCAN_RSP_ADV_SCAN:
>>> -             return LE_ADV_SCAN_RSP;
>>> +static u8 convert_ext_evt_type(u16 evt_type)
>>> +{
>>> +     if (evt_type & LE_EXT_ADV_LEGACY_PDU) {
>>> +             switch (evt_type) {
>>> +             case LE_LEGACY_ADV_IND:
>>> +                     return LE_ADV_IND;
>>> +             case LE_LEGACY_ADV_DIRECT_IND:
>>> +                     return LE_ADV_DIRECT_IND;
>>> +             case LE_LEGACY_ADV_SCAN_IND:
>>> +                     return LE_ADV_SCAN_IND;
>>> +             case LE_LEGACY_NONCONN_IND:
>>> +                     return LE_ADV_NONCONN_IND;
>>> +             case LE_LEGACY_SCAN_RSP_ADV:
>>> +             case LE_LEGACY_SCAN_RSP_ADV_SCAN:
>>> +                     return LE_ADV_SCAN_RSP;
>>> +             }
>> 
>> I would do a return here since only the legacy part is special.
>> 
>>> +     } else {
>>> +             if (evt_type & LE_EXT_ADV_CONN_IND) {
>>> +                     if (evt_type & LE_EXT_ADV_DIRECT_IND)
>>> +                             return LE_ADV_DIRECT_IND;
>>> +
>>> +                     return LE_ADV_IND;
>>> +             }
>>> +
>>> +             if (evt_type & LE_EXT_ADV_SCAN_RSP)
>>> +                     return LE_ADV_SCAN_RSP;
>>> +
>>> +             if (evt_type & LE_EXT_ADV_SCAN_IND)
>>> +                     return LE_ADV_SCAN_IND;
>>> +
>>> +             if (evt_type == LE_EXT_ADV_NON_CONN_IND ||
>>> +                 evt_type & LE_EXT_ADV_DIRECT_IND)
>>> +                     return LE_ADV_NONCONN_IND;
>> 
>> Why do we have one == match here and the rest are bit checks.
>> 
>>>      }
>>> 
>>>      BT_ERR_RATELIMITED("Unknown advertising packet type: 0x%02x",
>>> @@ -5172,7 +5191,7 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>>>              u16 evt_type;
>>> 
>>>              evt_type = __le16_to_cpu(ev->evt_type);
>>> -             legacy_evt_type = convert_legacy_evt_type(evt_type);
>>> +             legacy_evt_type = convert_ext_evt_type(evt_type);
>> 
>> So ext_evt_type_to_legacy might be a better function name here.
>> 
>>>              if (legacy_evt_type != LE_ADV_INVALID) {
>> 
>> I might have asked this before, when are we reaching _INVALID here?
>> 
> 
> It will be hit in case of an unknown advertising pkt type.

I have no idea on how the controller can give us that until we explicitly enabled / asked for it, but if so, then please add a clear comment here.

Regards

Marcel

