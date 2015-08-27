Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 4/5] Bluetooth: hci_intel: Add intel_data_list
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55DF4B1A.60005@intel.com>
Date: Thu, 27 Aug 2015 10:48:25 -0700
Cc: linux-bluetooth@vger.kernel.org, gaetan.prin@intel.com
Message-Id: <19C3A7A8-47C9-4123-8843-DC21179B467F@holtmann.org>
References: <1440689946-13576-1-git-send-email-loic.poulain@intel.com> <1440689946-13576-4-git-send-email-loic.poulain@intel.com> <4C16D0EB-E539-4934-B26E-38166403217A@holtmann.org> <55DF4B1A.60005@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

>>> struct intel_data {
>>> +	struct list_head list;
>> 
>> this is the private data associated with the hci_uart. I am not turning this into a list.
> 
>>> +static struct intel_data *intel_data_get(struct intel_device *idev)
>>> +{
>>> +	struct list_head *p;
>>> +
>>> +	list_for_each(p, &intel_data_list) {
>>> +		struct intel_data *intel = list_entry(p, struct intel_data,
>>> +						      list);
>>> +
>>> +		/* tty device and pdev device should share the same parent
>>> +		 * which is the UART port.
>>> +		 */
>>> +		if (intel->hu->tty->dev->parent == idev->pdev->dev.parent)
>>> +			return intel;
>>> +	}
>>> +
>>> +	return NULL;
>>> +}
>>> +
>> 
>> You really need to come up with something else. intel_data is not a list. It is private data for hci_uart.
>> 
> 
> Do you mean having an other simple list:
> struct intel_hu {
> 	struct list_head list;
> 	struct hci_uart *hu;
> }

this doesn't make it any better. I rather not have this in a list at all. I get the feeling that we really should look into getting UART Slave concept upstream. So the power part can become its own driver.

Regards

Marcel

