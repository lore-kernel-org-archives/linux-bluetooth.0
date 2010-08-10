Return-Path: <cyrus@holtmann.org>
Message-ID: <4C61AD3F.4000302@codeaurora.org>
Date: Tue, 10 Aug 2010 14:49:19 -0500
From: David Scherba <dscherba@codeaurora.org>
MIME-Version: 1.0
To: johan.hedberg@gmail.com
CC: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org
Subject: Re: [PATCH 2/2] Use HCI device type to gate BR/EDR-specific HCI commands
References: <4C6173CA.8060308@codeaurora.org> <1281455145-1777-1-git-send-email-dscherba@codeaurora.org> <20100810191616.GA26091@jh-x301>
In-Reply-To: <20100810191616.GA26091@jh-x301>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 8/10/2010 2:16 PM, Johan Hedberg wrote:

>> +static inline int ignore_device(struct hci_dev_info *di)
>> +{
>> +	return hci_test_bit(HCI_RAW,&di->flags) || di->type>>  4 != HCI_BREDR;
>> +}
>
> Since this is hci_lib.h (something I didn't realize in the previous
> review) the function should follow the same namespace as all other
> functions in the header file, i.e. hci_*. However, does the function
> really need to be exported in this public library header file, i.e.
> isn't there some private header file that could be used instead?

It looks like src/hcid.h fits the bill, although the modified hcid.h 
will need to include the hci headers to have the appropriate defines... 
Modified patch coming up.

Thanks,
David

-- 
David Scherba
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
