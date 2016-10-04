Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: Bluetooth not working anymore due to too agressive PM in hci_bcm
 ? (was: [PATCH v5 5/5] Bluetooth: hci_bcm: Add suspend/resume runtime PM
 functions)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <da9a4059-4164-e455-a451-83c97e57ad71@intel.com>
Date: Tue, 4 Oct 2016 10:38:46 +0200
Cc: =?utf-8?Q?J=C3=A9r=C3=B4me_de_Bretagne?=
        <jerome.debretagne@gmail.com>,
        Frederic Danis <frederic.danis@linux.intel.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <2647C028-4C38-4CC8-9B60-38EF619A06F3@holtmann.org>
References: <1475533357.2947.3.camel@gmail.com>
 <da9a4059-4164-e455-a451-83c97e57ad71@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

>> since building a kernel with its parent commit [4] works perfectly fine:
>>   commit: 7649faff1cfe4f76dabf78cd53d659d39f65b3c1
>>   Bluetooth: Remove useless rx_lock spinlock
>> 
>> The code change adding the runtime PM functions introduces an autosleep
>> delay but it's unclear from the commit description how the BT chipset is
>> supposed to get out of sleep afterwards.
> 
> Using out-of-band gpio/irq which are retrieved from the ACPI device.
> wakeup can be initiated by host or controller depending which one wants
> to transfer hci data.

I am actually curious if HCI remote wakeup might not work. So the HID mouse (I assume Classic here) will initiate a HCI Create Connection which will result in a HCI Connection Request. So that wakeup event needs to be allowed. I am curious if we might not set that correctly.

I would need to see the btmon trace from the controller initialization (start btmon before calling btattach). I am no longer sure that this has been tested with UART based controllers. On USB the remote wakeup works.

If the events for connection creation and remote wakeup set correctly, then it is some GPIO or Broadcom vendor specific thing.

Regards

Marcel

