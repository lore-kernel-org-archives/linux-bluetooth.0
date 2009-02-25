Return-Path: <cyrus@holtmann.org>
Message-ID: <49A5CF77.6020306@dtsp.co.nz>
Date: Thu, 26 Feb 2009 12:08:39 +1300
From: David Sainty <david.sainty@dtsp.co.nz>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Roel Kluin <roel.kluin@gmail.com>, linux-bluetooth@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Bluetooth: i reaches pkts_to_be_removed + 1
References: <49A5BEEF.9080603@gmail.com> <1235601640.27004.5.camel@localhost.localdomain>
In-Reply-To: <1235601640.27004.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann wrote:
> Hi Roel,
>
>   
>> i reaches pkts_to_be_removed + 1
>>
>> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
>> ---
>> diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
>> index 894b2cb..177f34b 100644
>> --- a/drivers/bluetooth/hci_bcsp.c
>> +++ b/drivers/bluetooth/hci_bcsp.c
>> @@ -385,7 +385,7 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)
>>  
>>  	spin_unlock_irqrestore(&bcsp->unack.lock, flags);
>>  
>> -	if (i != pkts_to_be_removed)
>> +	if (i <= pkts_to_be_removed)
>>  		BT_ERR("Removed only %u out of %u pkts", i, pkts_to_be_removed);
>>  }
>>     
>
> patch looks good, but can you please fill in the commit message with a
> little bit more details and background.
>   

Isn't there something wrong with this?  The patched code looks like it 
will output apparently nonsensical messages like "Removed only 10 out of 
10 pkts".
