Return-Path: <cyrus@holtmann.org>
Message-ID: <55C8C843.8040606@linux.intel.com>
Date: Mon, 10 Aug 2015 17:50:27 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Bluetooth: hci_bcm: Add ACPI and PM support
References: <1438959640-15476-1-git-send-email-frederic.danis@linux.intel.com> <A785406E-6D37-404C-B535-2CAD31496F0E@holtmann.org>
In-Reply-To: <A785406E-6D37-404C-B535-2CAD31496F0E@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

On 07/08/2015 18:45, Marcel Holtmann wrote:
> Hi Fred,
>
>> These patches move PM support from rfkill-gpio to hci_uart module.
>> On, off, suspend and resume functions are supported.
>> They also parse the ACPI entry to find initial UART baud rate.
>>
>> v1->v2:
>> - Add BCM2E67 device in acpi_device_id table
>> - Add suspend/resume functions
>
> looks pretty good. My only concern is the race between bcm_data and bcm_device. Is that a valid concern from my side or can that never happen? Meaning do we need to protect against removal / unbinding of the platform device while the line discipline is active.

I do not found a way to protect against device unbinding, so I will 
check if bcm_device is still in bsm_device_list before using it.

Regards

Fred
