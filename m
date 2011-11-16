Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 6/6] Bluetooth: Support LE-Only discovery procedure
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <20111112095433.GA6578@fusion.localdomain>
Date: Wed, 16 Nov 2011 18:04:01 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <35A26EEA-987F-474A-9385-622EBFE0AD7C@openbossa.org>
References: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org> <1321051824-5216-7-git-send-email-andre.guedes@openbossa.org> <20111112095433.GA6578@fusion.localdomain>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Nov 12, 2011, at 6:54 AM, Johan Hedberg wrote:

> Hi Andre,
> 
> On Fri, Nov 11, 2011, Andre Guedes wrote:
>> @@ -1669,7 +1678,16 @@ static int start_discovery(struct sock *sk, u16 index)
>> 		goto failed;
>> 	}
>> 
>> -	err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
>> +	if (lmp_host_le_capable(hdev)) {
>> +		if (lmp_bredr_capable(hdev))
>> +			err = -ENOSYS;
>> +		else
>> +			err = hci_do_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
>> +					LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
>> +	} else {
>> +		err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
>> +	}
> 
> This should really be looking at type parameter that gets passed in the
> mgmt_start_discovery command. User space has been sending it already for
> some time but the kernel side wasn't yet updated to care about it. I
> just sent a patch to add the necessary mgmt.h struct and to pass the
> data to the start_discovery function.

The bluetooth-next tree didn't have those patches you are talking about
when I sent this series.

I'll consider the type parameter in v2. Thanks.

Andre

