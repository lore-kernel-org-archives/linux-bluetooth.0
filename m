Return-Path: <cyrus@holtmann.org>
Message-ID: <551525E8.7070103@intel.com>
Date: Fri, 27 Mar 2015 10:42:00 +0100
From: loic <loic.poulain@intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Intel: Introduce btvnd_intel library
References: <1427387863-2629-1-git-send-email-loic.poulain@intel.com> <3354DD05-A6FC-4F73-9D77-485D570944B1@holtmann.org>
In-Reply-To: <3354DD05-A6FC-4F73-9D77-485D570944B1@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Marcel,

On 26/03/2015 17:56, Marcel Holtmann wrote:
> Hi Loic,
>
>> Most Intel Bluetooth controllers use a same set of vendor HCI commands
>> and procedures regardless of the transport layer (USB, UART, etc).
>> In order to prevent code duplication, this patch adds common library
>> for Intel bluetooth drivers.
>> This is essentially a move of btusb Intel code to btvnd_intel.
> actually in the beginning I would prefer to actually go with independent code for USB and UART for the Intel silicon. The reason I am saying that is because there are still things to be figured out before we can have generic code. So we might accept duplicate at first and once both transports are working, we will slowly start moving code out into a common module.
Seems reasonable.
>
> Also I think only BTUSB_INTEL_NEW support needs to be considered in the beginning. The older Intel silicon support should only be considered when the need arises.
>
> To give a little bit background, the functions that we need to consider are hdev->shutdown, hdev->setup and hdev->set_bdaddr. That would be simplest split into a separate module. However they are a bit tricky since for BTUSB_INTEL_NEW we already know that we have to handle asynchronous event reception from the firmware download. With regard, I would like to see the UART code first merged upstream and then we go and move common pieces into a more generic solution.
Async events (boot up, patch complete) are currently managed by the 
Bluetooth transport driver itself (hook).
Could we consider to introduce a hci_wait_vendor_event helper?

Regards,
Loic
