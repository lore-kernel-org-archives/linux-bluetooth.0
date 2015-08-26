Return-Path: <cyrus@holtmann.org>
Message-ID: <55DD7CF6.60004@intel.com>
Date: Wed, 26 Aug 2015 10:46:46 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 2/2] Bluetooth: hci_intel: Add platform driver
References: <1440498097-19739-1-git-send-email-loic.poulain@intel.com> <1440498097-19739-2-git-send-email-loic.poulain@intel.com> <1F9EE4AD-6337-461E-9AA7-C809423D307F@holtmann.org>
In-Reply-To: <1F9EE4AD-6337-461E-9AA7-C809423D307F@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>>
>> @@ -100,6 +190,13 @@ static int intel_close(struct hci_uart *hu)
>>
>> 	BT_DBG("hu %p", hu);
>>
>> +	intel_set_power(hu, false);
>> +
>> +	spin_lock(&intel_device_list_lock);
>> +	if (intel_device_exists(intel->idev))
>> +		intel->idev->hu = NULL;
>
> Why are you checking here if it exists? Just set idev->hu = NULL unconditionally.

If I'm not wrong, idev could have been freed due to pdev removing.
So we don't want to deref idev unconditionally.
We always need to check intel->idev.

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/
