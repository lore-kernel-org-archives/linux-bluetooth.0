Return-Path: <elfring@users.sourceforge.net>
Subject: Re: [3/5] Bluetooth: btmrvl: One check less in
 btmrvl_sdio_card_to_host()
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
 <a988a80d-12c0-a414-ab81-ff4ab075855c@users.sourceforge.net>
 <609D1B28-2B75-4AB5-B707-FDB5D0500F1A@holtmann.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <09cd7314-d053-3a6d-a9e1-d666a00ddb55@users.sourceforge.net>
Date: Tue, 13 Mar 2018 08:46:33 +0100
MIME-Version: 1.0
In-Reply-To: <609D1B28-2B75-4AB5-B707-FDB5D0500F1A@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

>> @@ -797,12 +792,18 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
>> 		break;
>> 	}
>>
>> -exit:
>> -	if (ret) {
>> -		hdev->stat.err_rx++;
>> -		kfree_skb(skb);
>> -	}
>> +	return 0;
>> +
>> +free_skb:
>> +	kfree_skb(skb);
>> +e_io:
>> +	ret = -EIO;
>> +	goto increment_counter;
>>
>> +e_inval:
>> +	ret = -EINVAL;
>> +increment_counter:
>> +	hdev->stat.err_rx++;
>> 	return ret;
> 
> Nope!
> 
> This is not easier to read for me. This goto exit jumping and I hate that.

Can the software design direction become feasible to omit the repeated check
for the variable “ret” (and further initialisations)?

Regards,
Markus
