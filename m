Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/3] Bluetooth: Enable LE Channel Selection Algorithm
 event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZLX2FNXL7pW9AXodwypo-QzDvf0eBJ5yGjg-GZYBkDdkg@mail.gmail.com>
Date: Tue, 2 May 2017 09:48:44 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <D7ABD7D0-0F64-4E2B-B8F6-1F3338EEC452@holtmann.org>
References: <20170502065419.7959-1-marcel@holtmann.org>
 <CABBYNZLX2FNXL7pW9AXodwypo-QzDvf0eBJ5yGjg-GZYBkDdkg@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>> If the Channel Selection Algorithm #2 feature is supported, then enable
>> the new LE Channel Selection Algorithm event.
>> 
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> include/net/bluetooth/hci.h | 1 +
>> net/bluetooth/hci_core.c    | 8 ++++++++
>> 2 files changed, 9 insertions(+)
>> 
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index 99aa5e5e3100..dd43cfdd443a 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -399,6 +399,7 @@ enum {
>> #define HCI_LE_PING                    0x10
>> #define HCI_LE_DATA_LEN_EXT            0x20
>> #define HCI_LE_EXT_SCAN_POLICY         0x80
>> +#define HCI_LE_CHAN_SEL_ALG2           0x40
>> 
>> /* Connection modes */
>> #define HCI_CM_ACTIVE  0x0000
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 4a0cac774107..e58b9034afff 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -635,6 +635,14 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
>>                                                 * Report
>>                                                 */
>> 
>> +               /* If the controller supports Channel Selection Algorithm #2
>> +                * feature, enable the corresponding event.
>> +                */
>> +               if (hdev->le_features[1] & HCI_LE_CHAN_SEL_ALG2)
>> +                       events[2] |= 0x08;      /* LE Channel Selection
>> +                                                * Algorithm
>> +                                                */
> 
> It might look better if you move the comments before the assignment
> and it may actually fit in a single line. Btw, shoudn't we have a
> define for 0x08?

this is in line with how we have done for all other events. So I have no plan to re-format the whole section at this point.

Regards

Marcel

