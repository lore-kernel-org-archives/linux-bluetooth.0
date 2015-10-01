Return-Path: <cyrus@holtmann.org>
Message-ID: <560CF12A.8020709@linux.intel.com>
Date: Thu, 01 Oct 2015 11:39:06 +0300
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
 linux-acpi@vger.kernel.org, "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH 1/5] Bluetooth: hci_bcm: Add missing acpi_dev_free_resource_list()
References: <1443619605-19320-1-git-send-email-jarkko.nikula@linux.intel.com> <FBA45A9C-2E3D-4D13-BEDE-957647DC173F@holtmann.org> <B5ED0060-B534-493D-B6CD-16E44D255B2C@holtmann.org>
In-Reply-To: <B5ED0060-B534-493D-B6CD-16E44D255B2C@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 10/01/2015 11:05 AM, Marcel Holtmann wrote:
> Hi Jarkko,
>
>>> Caller of acpi_dev_get_resources() should free the constructed resource
>>> list by calling the acpi_dev_free_resource_list() in order to avoid memory
>>> leak.
>>>
>>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>>> ---
>>> Call to acpi_dev_get_resources() was introduced by the commit ae056908862b
>>> ("Bluetooth: hci_bcm: Retrieve UART speed from ACPI") so fix should go to
>>> v4.3-rc.
>>
>> if this should go into 4.3 then you need to send it against bluetooth tree actually and not bluetooth-next. And you might want to include patch 2/5 in there as well. Sending them as combined set with bluetooth-next patches is not really helping.
>>
>> In case this is not an urgent fix that has to make it into 4.3, then I am just applying all 5 to bluetooth-next tree. Your choice.
>
> I changed my mind here and applied all 5 patches to bluetooth-next tree.
>
Ah, sorry, brain fart from me to send these together.

Anyway, issue doesn't look fatal as leak happens only during probe time 
and may not actually even exists. At least on Asus T100TA the 
acpi_dev_get_resources() for the "BCM2E39" device returns 0, i.e. it 
doesn't build the list but calls the bcm_resource() a few times still.

Looks like acpi_dev_get_resources() builds the list for certain types of 
resources and probably not for these GPIO and serial bus that 
bcm_resource() is handling.

-- 
Jarkko
