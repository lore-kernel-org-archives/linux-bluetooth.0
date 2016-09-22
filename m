Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH 1/3] Bluetooth: Fix local name in scan rsp
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2407078.m1aT8J8x6x@ix>
Date: Thu, 22 Sep 2016 21:56:32 +0200
Cc: =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>,
        linux-bluetooth@vger.kernel.org
Message-Id: <391818D9-515B-4622-B07C-1BEB13437C8A@holtmann.org>
References: <1474552899-3837-1-git-send-email-michal.narajowski@codecoup.pl>
 <9A1998C8-0404-4A27-B594-A55E2D80540D@holtmann.org> <2407078.m1aT8J8x6x@ix>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>>> Use complete name if it fits. If not and there is short name
>>> check if it fits. If not then use shortened name as prefix
>>> of complete name.
>>> 
>>> Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
>>> ---
>>> net/bluetooth/hci_request.c | 46
>>> +++++++++++++++++++++++++++++++++------------ 1 file changed, 34
>>> insertions(+), 12 deletions(-)
>>> 
>>> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
>>> index c813568..880758c 100644
>>> --- a/net/bluetooth/hci_request.c
>>> +++ b/net/bluetooth/hci_request.c
>>> @@ -973,25 +973,47 @@ void __hci_req_enable_advertising(struct hci_request
>>> *req)
>>> 
>>> static u8 append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
>>> {
>>> -	size_t name_len;
>>> +	size_t complete_len;
>>> +	size_t short_len;
>>> 
>>> 	int max_len;
>>> 	
>>> 	max_len = HCI_MAX_AD_LENGTH - ad_len - 2;
>>> 
>>> -	name_len = strlen(hdev->dev_name);
>>> -	if (name_len > 0 && max_len > 0) {
>>> +	complete_len = strlen(hdev->dev_name);
>>> +	short_len = strlen(hdev->short_name);
>>> 
>>> -		if (name_len > max_len) {
>>> -			name_len = max_len;
>>> -			ptr[1] = EIR_NAME_SHORT;
>>> -		} else
>>> -			ptr[1] = EIR_NAME_COMPLETE;
>>> +	/* no space left for name */
>>> +	if (max_len < 1)
>>> +		return ad_len;
>>> 
>>> -		ptr[0] = name_len + 1;
>>> +	/* no name set */
>>> +	if (!complete_len)
>>> +		return ad_len;
>>> 
>>> -		memcpy(ptr + 2, hdev->dev_name, name_len);
>>> +	/* complete name fits */
>>> +	if (complete_len <= max_len) {
>>> +		ptr[0] = complete_len + 1;
>>> +		ptr[1] = EIR_NAME_COMPLETE;
>>> +		memcpy(ptr + 2, hdev->dev_name, complete_len);
>>> 
>>> -		ad_len += (name_len + 2);
>>> -		ptr += (name_len + 2);
>>> +		return ad_len + complete_len + 2;
>>> +	}
>> 
>> so what we discussed is that at minimum 11 octets of name will be included
>> into the scan response. That is the same size of the Short_name (which
>> includes the nul-byte).
> 
> minimum? And do we need to put null byte there?

I think the term maximum would have been better. 1-11 octets of name should be included. For the nul-byte, we need to double check the spec., but I think it is required to be included. If not, then we can leave it out.

>> If the full name is 11 octets or smaller, then that is included. If the full
>> name is longer and a short name has been set, then the short name is used.
>> If the short name is not set, then the full name is truncated to 11 octets.
>> 
>> For the case where the full name is 11 octets or smaller, the complete tag
>> is used. For the case where the short name is used or the full name is
>> truncated, the partial tag is used.
> 
> So we never include full name if it is longer then 11 octets (with null)?
> BTW where this 11 octets value came from? I cannot find such requirement in 
> spec. Or this is just limited on mgmt interface level?

Until we have longer advertising packets, I think the 11 octets sound like a good compromise. Userspace can always decide to drive scan response by itself. Or do you have a better idea for a policy?

The 11 octets is a mgmt limit for the short name. We decided on that when inventing mgmt interface.

> I don't undertand why not to include complete name if it fits, even if longer 
> than 11 octets.

Feel free to define the policy then. It gets really complicated if userspace wants to include appearance, name and then its own data. If the name occupies the rest. Also when to decide when to use the short name vs long name. If we limit at the short name size, then the policy is simple.

>>> +
>>> +	/* shortened name set and fits */
>> 
>> Just a note here, it is not called shortened name. It is the short name. We
>> clearly separated the full name vs short name in the mgmt API.
> 
> It is called 'shortened' in both CoreSpec and CSS. 

And short name in mgmt.

Regards

Marcel

