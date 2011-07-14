Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110713201516.GB23921@joana>
References: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
	<1310418719-12296-9-git-send-email-andre.guedes@openbossa.org>
	<20110713201516.GB23921@joana>
Date: Thu, 14 Jul 2011 11:31:01 -0300
Message-ID: <CACJA=fUXQ_QgLCr-TURFOr-2aWva8_gCpPfYC1g=oX099V-stQ@mail.gmail.com>
Subject: Re: [PATCH 08/16] Bluetooth: Fix stop_discovery()
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Jul 13, 2011 at 5:15 PM, Gustavo Padovan <padovan@profusion.mobi> wrote:
>> @@ -963,6 +963,11 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
>>
>>       set_bit(HCI_INQUIRY, &hdev->flags);
>>
>> +     if (mgmt_has_pending_stop_discov(hdev->id)) {
>
> Isn't a new bit flag log HCI_INQUIRY_CANCEL better that this? First this has
> read a list, second it is a really ugly  function name.

A flag called HCI_CANCEL_DISCOV would be more appropriated since it
would be used to cancel the discovery procedure (inquiry/le scan).

My point is: I don't need a new flag to tell me the same information I already
have by checking for pending stop discovery command. IMO, traversing the
pending command list is not a issue today since it isn't that large.
If that list
becomes too large in future, then we'll have a bigger issue because lots of
mgmt commands do traversing the command pending list. In that case we
would need to come up with some optimization like pending list per hdev,
for instance.

Besides, I don't think mixing up mgmt layer and hci layer logic is a good
idea. The whole discovery procedure logic should go in mgmt layer, so no
discovery logic should be implemented in hci layer.

>> +             mgmt_cancel_discovery(hdev->id);
>
> Just call hci_send_cmd(HCI_OP_INQUIRY_CANCEL)

It would mix up mgmt and hci layer logic.

>
>> +             return;
>> +     }
>> +
>>       mgmt_discovering(hdev->id, 1);
>>  }
>>
>> @@ -1356,7 +1361,12 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
>>       hci_req_complete(hdev, HCI_OP_INQUIRY, status);
>>
>>       mgmt_discovering(hdev->id, 0);
>> +
>> +     hci_dev_lock(hdev);
>> +
>>       mgmt_start_discovery_complete(hdev->id);
>> +
>> +     hci_dev_unlock(hdev);
>>  }
>>
>>  static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index e43940e..bbb0daa 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -1670,6 +1670,21 @@ static int cancel_inquiry(struct hci_dev *hdev)
>>       return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
>>  }
>>
>> +int mgmt_cancel_discovery(u16 index)
>> +{
>> +     struct hci_dev *hdev;
>> +     int res = 0;
>> +
>> +     hdev = hci_dev_get(index);
>> +
>> +     if (test_bit(HCI_INQUIRY, &hdev->flags))
>> +             res = cancel_inquiry(hdev);
>> +
>> +     hci_dev_put(hdev);
>> +
>> +     return res;
>> +}
>> +
>>  static int stop_discovery(struct sock *sk, u16 index)
>>  {
>>       struct hci_dev *hdev;
>> @@ -1701,7 +1716,7 @@ static int stop_discovery(struct sock *sk, u16 index)
>>               goto failed;
>>       }
>
> You can check here with mgmt_pending_find() if the HCI_OP_INQUIRY_CANCEL was
> already issued or not. This simplifies code a bit.

Sorry, I didn't see what you mean here.

Regards,

Andre.
