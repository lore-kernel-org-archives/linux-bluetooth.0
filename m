Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH v2] Bluetooth: Fix append max 11 bytes of name to scan rsp
 data
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAA4A+aBrKSpHkeXAT+84-coTYONFrqx-D=5AKL1fDL+ZeS1ZpA@mail.gmail.com>
Date: Tue, 18 Oct 2016 21:39:27 +0200
Cc: =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <2E9CAC66-0C05-4EA3-AD96-88C7902C2574@holtmann.org>
References: <1476802418-23134-1-git-send-email-michal.narajowski@codecoup.pl>
 <0852A289-D8DB-4707-97EE-D2E8FBBA2421@holtmann.org>
 <CAA4A+aBrKSpHkeXAT+84-coTYONFrqx-D=5AKL1fDL+ZeS1ZpA@mail.gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>>> Append maximum of 10 + 1 bytes of name to scan response data.
>>> Complete name is appended only if exists and is <= 10 characters.
>>> Else append short name if exists or shorten complete name if not.
>>> This makes sure name is consistent across multiple advertising
>>> instances.
>>> 
>>> Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
>>> ---
>>> net/bluetooth/hci_request.c | 47 +++++++++++++++++++++------------------------
>>> net/bluetooth/mgmt.c        |  4 ++--
>>> 2 files changed, 24 insertions(+), 27 deletions(-)
>>> 
>>> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
>>> index e228842..cfdd2c8 100644
>>> --- a/net/bluetooth/hci_request.c
>>> +++ b/net/bluetooth/hci_request.c
>>> @@ -971,39 +971,36 @@ void __hci_req_enable_advertising(struct hci_request *req)
>>> 
>>> static u8 append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
>>> {
>>> -     size_t complete_len;
>>>      size_t short_len;
>>> -     int max_len;
>>> -
>>> -     max_len = HCI_MAX_AD_LENGTH - ad_len - 2;
>>> -     complete_len = strlen(hdev->dev_name);
>>> -     short_len = strlen(hdev->short_name);
>>> -
>>> -     /* no space left for name */
>>> -     if (max_len < 1)
>>> -             return ad_len;
>>> +     size_t complete_len;
>>> 
>>> -     /* no name set */
>>> -     if (!complete_len)
>>> +     /* no space left for name (+ NULL + type + len) */
>>> +     if ((HCI_MAX_AD_LENGTH - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 3)
>>>              return ad_len;
>>> 
>>> -     /* complete name fits and is eq to max short name len or smaller */
>>> -     if (complete_len <= max_len &&
>>> -         complete_len <= HCI_MAX_SHORT_NAME_LENGTH) {
>>> +     /* use complete name if present and fits */
>>> +     complete_len = strlen(hdev->dev_name);
>>> +     if (complete_len && complete_len <= HCI_MAX_SHORT_NAME_LENGTH)
>>>              return eir_append_data(ptr, ad_len, EIR_NAME_COMPLETE,
>>> -                                    hdev->dev_name, complete_len);
>>> -     }
>>> +                                    hdev->dev_name, complete_len + 1);
>>> 
>>> -     /* short name set and fits */
>>> -     if (short_len && short_len <= max_len) {
>>> +     /* use short name if present */
>>> +     short_len = strlen(hdev->short_name);
>>> +     if (short_len)
>>>              return eir_append_data(ptr, ad_len, EIR_NAME_SHORT,
>>> -                                    hdev->short_name, short_len);
>>> -     }
>>> +                                    hdev->short_name, short_len + 1);
>>> 
>>> -     /* no short name set so shorten complete name */
>>> -     if (!short_len) {
>>> -             return eir_append_data(ptr, ad_len, EIR_NAME_SHORT,
>>> -                                    hdev->dev_name, max_len);
>>> +     /* use shortened full name if present, we already know that name
>>> +      * is longer then HCI_MAX_SHORT_NAME_LENGTH
>>> +      */
>>> +     if (complete_len) {
>>> +             u8 name[HCI_MAX_SHORT_NAME_LENGTH + 1];
>>> +
>>> +             memcpy(name, hdev->dev_name, HCI_MAX_SHORT_NAME_LENGTH);
>>> +             name[HCI_MAX_SHORT_NAME_LENGTH] = '\0';
>>> +
>>> +             return eir_append_data(ptr, ad_len, EIR_NAME_SHORT, name,
>>> +                                    sizeof(name));
>>>      }
>>> 
>>>      return ad_len;
>>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>>> index 7360380..cdcadca 100644
>>> --- a/net/bluetooth/mgmt.c
>>> +++ b/net/bluetooth/mgmt.c
>>> @@ -6030,9 +6030,9 @@ static u8 tlv_data_max_len(u32 adv_flags, bool is_adv_data)
>>>              if (adv_flags & MGMT_ADV_FLAG_TX_POWER)
>>>                      max_len -= 3;
>>>      } else {
>>> -             /* at least 1 byte of name should fit in */
>>> +             /* max 11 bytes of name should fit in */
>>>              if (adv_flags & MGMT_ADV_FLAG_LOCAL_NAME)
>>> -                     max_len -= 3;
>>> +                     max_len -= (1 + 1 + 11);
>> 
>> actually this one should also return correct values and not just max.
>> 
>> If either the full_name or short_name is shorter than 11 octets, then only that value should be returned instead of always 11 octets.
> 
> This would mean that if name is changed userspace will have to query
> this again (and track name changes from mgmt). If that is the case we
> should probably document this behavior.

that is what I would expect. And yes, documenting this would be a good idea.

Regards

Marcel

