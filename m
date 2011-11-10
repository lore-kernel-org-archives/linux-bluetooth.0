Return-Path: <cyrus@holtmann.org>
Message-ID: <4EBC521A.2060703@codeaurora.org>
Date: Thu, 10 Nov 2011 14:37:14 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Add address type to mgmt_pair_device
References: <1320962855-19036-1-git-send-email-johan.hedberg@gmail.com> <4EBC4D0A.7070704@codeaurora.org> <20111110223341.GA21131@fusion.localdomain>
In-Reply-To: <20111110223341.GA21131@fusion.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11/10/2011 2:33 PM, Johan Hedberg wrote:
> Hi Brian,
>
> On Thu, Nov 10, 2011, Brian Gix wrote:
>> On 11/10/2011 2:07 PM, johan.hedberg@gmail.com wrote:
>>>
>>> -	entry = hci_find_adv_entry(hdev,&cp->bdaddr);
>>> -	if (entry)
>>> -		conn = hci_connect(hdev, LE_LINK,&cp->bdaddr, sec_level,
>>> +	if (cp->addr.type == MGMT_ADDR_BREDR)
>>> +		conn = hci_connect(hdev, ACL_LINK,&cp->addr.bdaddr, sec_level,
>>>   								auth_type);
>>>   	else
>>> -		conn = hci_connect(hdev, ACL_LINK,&cp->bdaddr, sec_level,
>>> +		conn = hci_connect(hdev, LE_LINK,&cp->addr.bdaddr, sec_level,
>>>   								auth_type);
>>>
>>
>> Are we differentiating between Dual Mode and BR/EDR here?  If we
>> are, we may want to reverse the logic so that it connects with an
>> LE_LINK if the addr type == MGMT_ADDR_LE, and then connects to an
>> ACL_LINK otherwise (as the else).
>>
>> Unless this is being implimented as a bitmask, in which case the if
>> would be "if (cp->addr.type&  MGMT_ADDR_BREDR)", at which point I
>> have no objection.
>>
>> Because of course Dual mode devices must use the ACL_LINK between
>> each other.
>
> The idea here isn't to push connection type selection to the kernel but
> to expect user-space to explicitly say how it wants to connect. If
> user-space wants to connect over LE it'll provide either ADDR_LE_PUBLIC
> or ADDR_LE_PRIVATE. So it doesn't really matter what way around the
> if-statement is formulated (I chose this way around since it meant one
> comparison instead of two).

OK, I'm fine with that.


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
