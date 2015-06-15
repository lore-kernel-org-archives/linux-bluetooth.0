Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v2 5/5] BlueZ Broadcom UART Protocol
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <557E9C39.7020107@linux.intel.com>
Date: Mon, 15 Jun 2015 12:04:54 +0200
Cc: Ilya Faenson <ifaenson@broadcom.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Arend Van Spriel <arend@broadcom.com>
Message-Id: <7B7F857A-DD14-44B3-80C6-242D93B7115E@holtmann.org>
References: <1433966720-17482-1-git-send-email-ifaenson@broadcom.com> <1433966720-17482-6-git-send-email-ifaenson@broadcom.com> <10D46DDD-5B79-4D9C-92E8-0440A66CB45C@holtmann.org> <E0D3336E15B58B4294723AC879BA5E9426163D@IRVEXCHMB15.corp.ad.broadcom.com> <61600B60-2B7F-43E8-86AE-B6A31D54FE10@holtmann.org> <E0D3336E15B58B4294723AC879BA5E94261E6A@IRVEXCHMB15.corp.ad.broadcom.com> <557E9C39.7020107@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

>> >> Merge Broadcom protocol with the existing implementation, providing
>> >> for UART setup, firmware download and power management.
>> >>
>> >> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
>> >> ---
>> >> drivers/bluetooth/hci_bcm.c | 400 ++++++++++++++++++++++++++++++++++++++++++--
>> >> 1 file changed, 384 insertions(+), 16 deletions(-)
>> >>
>> >> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> >> index e4d66b6..5ff35b7 100644
>> >> --- a/drivers/bluetooth/hci_bcm.c
>> >> +++ b/drivers/bluetooth/hci_bcm.c
>> >> @@ -3,6 +3,7 @@
>> >> *  Bluetooth HCI UART driver for Broadcom devices
>> >> *
>> >> *  Copyright (C) 2015  Intel Corporation
>> >> + *  Copyright (C) 2015  Broadcom Corporation
>> >> *
>> >> *
>> >> *  This program is free software; you can redistribute it and/or modify
>> >> @@ -24,6 +25,7 @@
>> >> #include <linux/kernel.h>
>> >> #include <linux/errno.h>
>> >> #include <linux/skbuff.h>
>> >> +#include <linux/tty.h>
>> >> #include <linux/firmware.h>
>> >>
>> >> #include <net/bluetooth/bluetooth.h>
>> >> @@ -31,12 +33,170 @@
>> >>
>> >> #include "btbcm.h"
>> >> #include "hci_uart.h"
>> >> +#include "btbcm_uart.h"
>> >>
>> >> struct bcm_data {
>> >>     struct sk_buff *rx_skb;
>> >>     struct sk_buff_head txq;
>> >> +    struct hci_uart *hu;
>> >> +
>> >> +    bool is_suspended; /* suspend/resume flag */
>> >> +
>> >> +    struct timer_list timer; /* idle timer */
>> >
>> > I prefer not to use timers if we can use delayed work instead.
>> >
>> > IF: Could you clarify how you want me to use the delayed work for the frequently refreshed 5 second timer? It would essentially be an extra thread running most of the time with us having to synchronize it with the device stops etc. Clear invite for race conditions in my opinion.
>> 
>> refreshed means re-armed? I wonder how delayed work is different then? Maybe I need to understand a bit more than first.
>> 
>> IF: Every time a new packet comes from either direction, the idle timer needs to be re-armed to fire in 5 seconds regardless of the current state of this timer. Hope that clarifies the logic.
>> 
>> >
>> >> +
>> >> +    struct btbcm_uart_parameters pars; /* device parameters */
>> >
>> > btbcm_uart_params and params please. No pars and not point in spelling out parameters in a struct name.
>> >
>> > IF: Okay.
>> >
>> >> +    void *device_context; /* ACPI/DT device context */
>> >> };
>> >>
>> >> +/* Suspend/resume synchronization mutex */
>> >> +static DEFINE_MUTEX(plock);
>> >
>> > Please use a more descriptive name than plock. That is too generic for a global variable.
>> >
>> > IF: Okay.
>> >
>> >> +
>> >> +/* Forward reference */
>> >> +static struct hci_uart_proto bcm_proto;
>> >
>> > Why do we need this? I am generally not in favor of having forward reference until really really needed.
>> >
>> > IF: That is needed to set the oper-speed in this structure once the device parameters are available. Intel patch has hard-coded it to a single value for all Broadcom devices which is not acceptable.
>> 
>> So for Broadcom devices, I think in the static table, no oper-speed should be set. That means it has to come by other means. Either ACPI or DT. But as I mentioned in the other part, that table has to stay const.
>> 
>> IF: The oper_speed comes from DT in my current code already. The BlueZ line discipline currently acts on the oper_speed for all manufacturers. Do you want an exception for Broadcom there? If not, the oper-speed changes should apply to everybody.
> 
> <snip>
>> >> -static const struct hci_uart_proto bcm_proto = {
>> >> +/* This structure may not be const as speed may change at runtime */
>> >
>> > No. This struct is const. These are the value that a protocol driver sets.
>> >
>> > If values are dynamic and change based on DT, then left them zero here and provide a method for overwriting them internally in hci_uart. Please do not hack this in. There are simple UART drivers that we want to enable in a really simple way.
>> >
>> > IF: As I said above, I've inherited the need to change the speed(s) from the recent Intel patches. Will try fixing that.
>> 
>> I get where you are coming from. And for Broadcom the table will not contain an oper-speed. That will come from ACPI or DT. So you action should be to remove it here and introduce a variable in bcm_data that has it and that can be used instead. I have not figured out all the details, but that is the general idea. I leave the details up to you.
>> 
>> IF: As I said above, this is slightly more complicated as the oper_speed is used by the BlueZ line discipline for all manufacturers. And any manufacturer with the oper-speed changeable among the devices will be affected. Since the oper-speed used is largely defined by the UART rather than BT device capabilities, I'm afraid it should be configurable and not reside in a const structure for all.
> 
> FYI, the oper_speed is not available in ACPI table of T100.
> Depending on device, even the init_speed may not be available.
> 
> So, I agree with Ilya these values should be configurable.

that is fine, but not in the driver callback table. That is for simple devices that always have the same default and operational speed. If it is configured outside, then these two need to be left out.

Regards

Marcel

