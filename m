Return-Path: <cyrus@holtmann.org>
Message-ID: <5540F386.3010707@linux.intel.com>
Date: Wed, 29 Apr 2015 17:06:46 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
	Peter Hurley <peter@hurleysoftware.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/7] Bluetooth: hci_uart: Add HCIUARTSETBAUDRATE ioctl
References: <1428673066-1349-1-git-send-email-frederic.danis@linux.intel.com> <1428673066-1349-2-git-send-email-frederic.danis@linux.intel.com> <5527EB14.9000608@hurleysoftware.com> <488A23CF-9578-42F5-A2E6-9D8450A15309@holtmann.org>
In-Reply-To: <488A23CF-9578-42F5-A2E6-9D8450A15309@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

On 10/04/2015 20:20, Marcel Holtmann wrote:
> Hi Peter,
>
>>> This allows user space application to set final speed requested for UART
>>> device. UART port is open at init speed by user space application.
>>>
>>> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
>>> ---
>>> drivers/bluetooth/hci_ldisc.c | 6 ++++++
>>> drivers/bluetooth/hci_uart.h  | 2 ++
>>> 2 files changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>>> index 5c9a73f..190a7f8 100644
>>> --- a/drivers/bluetooth/hci_ldisc.c
>>> +++ b/drivers/bluetooth/hci_ldisc.c
>>> @@ -609,6 +609,12 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
>>> 	case HCIUARTGETFLAGS:
>>> 		return hu->hdev_flags;
>>>
>>> +	case HCIUARTSETBAUDRATE:
>>> +		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
>>> +			return -EBUSY;
>>> +		hu->speed = arg;
>>> +		break;
>>> +
>>
>> So now that the kernel can set line rate, why is an ioctl necessary
>> to determine what the line rate should be?
>
> actually I think we should skip this for now and only introduce it if it is really needed. For the chips we want to support initially we only need the default baudrate and the max baudrate. So the default baudrate is vendor specific and we would just hardcode that in the driver. The max baudrate is platform specific and most likely should come via ACPI or DT. Or some default value in case it is platform specific driver in the first place.
>
> Just as background, this command is not for actually setting the baudrate at that point, it is informing the kernel about the max baudrate for operational use. It will be programmed way later. However as stated above, I think for now we should skip this and only introduce it if the kernel needs input from userspace on the max baudrate.
>
> Fred, I think what we really want at this point is to add default and operational baudrate fields to hci_uart_proto.

OK, I will add default and operational speed to hci_uart_proto.
I tried to find the operational speed in T100's ACPI table but only find 
default speed. (first time I work on ACPI table so I may have missed it).

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

