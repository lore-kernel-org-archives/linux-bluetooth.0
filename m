Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
Message-Id: <7D2DA686-9741-4369-9E47-E4AD140D067E@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
In-Reply-To: <200808041823.28309.oliver@neukum.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v928.1)
Subject: Re: [rfc]btusb with SCO support
Date: Mon, 4 Aug 2008 18:33:36 +0200
References: <200807311452.24166.oliver@neukum.org> <200808041033.05446.oliver@neukum.org> <7B57E1E8-7077-4CCB-AF81-ACF5DCBCE918@holtmann.org> <200808041823.28309.oliver@neukum.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

>>>>> +module_param(override_ignore, bool, 0644);
>>>>> +MODULE_PARM_DESC(override_ignore, "Drive blacklisted devices");
>>>>
>>>> Why do we need this one? What is it good for?
>>>
>>> To override HCI_IGNORE. IF we provide overrides for blacklist  
>>> entries,
>>> it should be done systematically.
>>
>> no we should not do that. The HCI_IGNORE is for devices that pretend
>> to be Bluetooth H:2 compatible, but they are not. In these cases we  
>> do
>> have other drivers that do this right. See bcm203x and bpa10x  
>> drivers.
>
> Then why do you implement this option for hci_usb?
> And why can the other IGNORE options be overridden?

if I wanna use the generic Bluetooth descriptor for matching, I need a  
way to mark broken devices as to be ignored. Otherwise I would have a  
really long list of matching vendor and product ids.

The other ones are special cases where it in some situations make  
sense to either ignore the device or allow it. The ignore_csr is for  
the CSR ROM chips that need loading of persistent settings first. The  
Digianswer is for an old development hardware  that had some issues.  
And the sniffer is normally driven by userspace apps. However it might  
work with the hci_usb driver, but it will not give you a normal  
working Bluetooth device.

Regards

Marcel

