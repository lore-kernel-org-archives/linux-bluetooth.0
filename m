Return-Path: <cyrus@holtmann.org>
Message-ID: <55DF4B1A.60005@intel.com>
Date: Thu, 27 Aug 2015 19:38:34 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org, gaetan.prin@intel.com
Subject: Re: [PATCH 4/5] Bluetooth: hci_intel: Add intel_data_list
References: <1440689946-13576-1-git-send-email-loic.poulain@intel.com> <1440689946-13576-4-git-send-email-loic.poulain@intel.com> <4C16D0EB-E539-4934-B26E-38166403217A@holtmann.org>
In-Reply-To: <4C16D0EB-E539-4934-B26E-38166403217A@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> struct intel_data {
>> +	struct list_head list;
>
> this is the private data associated with the hci_uart. I am not turning this into a list.

>> +static struct intel_data *intel_data_get(struct intel_device *idev)
>> +{
>> +	struct list_head *p;
>> +
>> +	list_for_each(p, &intel_data_list) {
>> +		struct intel_data *intel = list_entry(p, struct intel_data,
>> +						      list);
>> +
>> +		/* tty device and pdev device should share the same parent
>> +		 * which is the UART port.
>> +		 */
>> +		if (intel->hu->tty->dev->parent == idev->pdev->dev.parent)
>> +			return intel;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>
> You really need to come up with something else. intel_data is not a list. It is private data for hci_uart.
>

Do you mean having an other simple list:
struct intel_hu {
	struct list_head list;
	struct hci_uart *hu;
}

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/
