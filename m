Return-Path: <cyrus@holtmann.org>
Message-ID: <4EBAFFE7.2030506@codeaurora.org>
Date: Wed, 09 Nov 2011 14:34:15 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Add SMP support to user_confirm_reply
References: <1320866027-14202-1-git-send-email-bgix@codeaurora.org>	 <1320866027-14202-2-git-send-email-bgix@codeaurora.org> <1320877587.15441.352.camel@aeonflux>
In-Reply-To: <1320877587.15441.352.camel@aeonflux>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 11/9/2011 2:26 PM, Marcel Holtmann wrote:

>> +	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,&cp->bdaddr);
>> +	if (!conn) {
>> +		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,&cp->bdaddr);
>> +		if (!conn) {
>> +			err = cmd_status(sk, index, mgmt_op, ENOTCONN);
>> +			goto done;
>> +		}
>> +
>> +		/* Forward Confirm response to SMP */
>> +
>> +		err = cmd_status(sk, index, mgmt_op, 0);
>> +		goto done;
>> +
>>   	}
>
> I am a bit lost why we are trying to find an ACL_LINK here first.

We want to route the confirmation to the Secure Simple Pair HCI command 
if this is being done on an ACL link, and to the SMP pairing algorythm 
if it is being done on an LE link.

While I suppose we could route all non-LE results to the related HCI 
command, it seemed cleaner to me to reject it with an ENOTCONN, rather 
than make an invalid HCI call, and depending on the baseband generating 
the error.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
