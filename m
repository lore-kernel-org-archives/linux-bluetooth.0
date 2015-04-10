Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 2/7] Bluetooth: hci_uart: Add HCIUARTSETBAUDRATE ioctl
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5527EB14.9000608@hurleysoftware.com>
Date: Fri, 10 Apr 2015 11:20:06 -0700
Cc: Frederic Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <488A23CF-9578-42F5-A2E6-9D8450A15309@holtmann.org>
References: <1428673066-1349-1-git-send-email-frederic.danis@linux.intel.com> <1428673066-1349-2-git-send-email-frederic.danis@linux.intel.com> <5527EB14.9000608@hurleysoftware.com>
To: Peter Hurley <peter@hurleysoftware.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

>> This allows user space application to set final speed requested for UART
>> device. UART port is open at init speed by user space application.
>> 
>> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
>> ---
>> drivers/bluetooth/hci_ldisc.c | 6 ++++++
>> drivers/bluetooth/hci_uart.h  | 2 ++
>> 2 files changed, 8 insertions(+)
>> 
>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>> index 5c9a73f..190a7f8 100644
>> --- a/drivers/bluetooth/hci_ldisc.c
>> +++ b/drivers/bluetooth/hci_ldisc.c
>> @@ -609,6 +609,12 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
>> 	case HCIUARTGETFLAGS:
>> 		return hu->hdev_flags;
>> 
>> +	case HCIUARTSETBAUDRATE:
>> +		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
>> +			return -EBUSY;
>> +		hu->speed = arg;
>> +		break;
>> +
> 
> So now that the kernel can set line rate, why is an ioctl necessary
> to determine what the line rate should be?

actually I think we should skip this for now and only introduce it if it is really needed. For the chips we want to support initially we only need the default baudrate and the max baudrate. So the default baudrate is vendor specific and we would just hardcode that in the driver. The max baudrate is platform specific and most likely should come via ACPI or DT. Or some default value in case it is platform specific driver in the first place.

Just as background, this command is not for actually setting the baudrate at that point, it is informing the kernel about the max baudrate for operational use. It will be programmed way later. However as stated above, I think for now we should skip this and only introduce it if the kernel needs input from userspace on the max baudrate.

Fred, I think what we really want at this point is to add default and operational baudrate fields to hci_uart_proto.

Regards

Marcel

