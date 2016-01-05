Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH v2] bluetooth: core: RfC - add basic LED triggers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <568B67A5.9010502@gmail.com>
Date: Mon, 4 Jan 2016 23:03:25 -0800
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Message-Id: <29FC8A44-BB30-4DAF-A9FE-4DB6A7273479@holtmann.org>
References: <5686A7E5.7010901@gmail.com> <117829AF-2B60-4455-BD8D-476912396D77@holtmann.org> <568AE316.4030707@gmail.com> <46CEB4CF-16CD-401C-8A88-DB19B4AA1DB4@holtmann.org> <568B67A5.9010502@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Heiner,

>>>>> In the bluetooth subsystem I miss the option to use LEDs to indicate
>>>>> the status. This patch is based on the LED triggers in mac80211 and
>>>>> adds two basic LED triggers (powered up, device connected) plus
>>>>> a config option to enable the BT LED triggers.
>>>>> 
>>>>> It works fine on my system however I don't know the bluetooth stack
>>>>> in too much detail and therefore appreciate any comment.
>>>>> 
>>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>>> ---
>>>>> v2:
>>>>> - completely rewrote the code to be as generic as possible and minimize
>>>>> the changes to struct hci_dev
>>>>> - make the details of the LED triggers opaque to struct hci_dev
>>>>> - avoid using ifdef CONFIG_BT_LEDS in hci_core.h
>>>>> - start with the radio trigger only
>>>>> - factor out the generic basic led trigger code to facilitate adding
>>>>> further basic LED triggers
>>>>> - fix indentation in Kconfig
>>>>> - rename led.[ch] to leds.[ch]
>>>>> ---
>>>>> include/net/bluetooth/hci_core.h |  3 ++
>>>>> net/bluetooth/Kconfig            |  9 ++++
>>>>> net/bluetooth/Makefile           |  1 +
>>>>> net/bluetooth/hci_core.c         |  8 ++++
>>>>> net/bluetooth/leds.c             | 99 ++++++++++++++++++++++++++++++++++++++++
>>>>> net/bluetooth/leds.h             | 17 +++++++
>>>>> 6 files changed, 137 insertions(+)
>>>>> create mode 100644 net/bluetooth/leds.c
>>>>> create mode 100644 net/bluetooth/leds.h
>>>>> 
>>>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>>>> index c95e032..4ffec8b 100644
>>>>> --- a/include/net/bluetooth/hci_core.h
>>>>> +++ b/include/net/bluetooth/hci_core.h
>>>>> @@ -25,6 +25,7 @@
>>>>> #ifndef __HCI_CORE_H
>>>>> #define __HCI_CORE_H
>>>>> 
>>>>> +#include <linux/leds.h>
>>>>> #include <net/bluetooth/hci.h>
>>>>> #include <net/bluetooth/hci_sock.h>
>>>>> 
>>>>> @@ -395,6 +396,8 @@ struct hci_dev {
>>>>> 	struct delayed_work	rpa_expired;
>>>>> 	bdaddr_t		rpa;
>>>>> 
>>>>> +	struct led_trigger *radio_led;
>>>>> +
>>>> 
>>>> I wonder if this one might not be better named power_led instead.
>>>> 
>>> OK
>>> 
>>>>> 	int (*open)(struct hci_dev *hdev);
>>>>> 	int (*close)(struct hci_dev *hdev);
>>>>> 	int (*flush)(struct hci_dev *hdev);
>>>>> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
>>>>> index 95d1a66..06c31b9 100644
>>>>> --- a/net/bluetooth/Kconfig
>>>>> +++ b/net/bluetooth/Kconfig
>>>>> @@ -69,6 +69,15 @@ config BT_6LOWPAN
>>>>> 	help
>>>>> 	  IPv6 compression over Bluetooth Low Energy.
>>>>> 
>>>>> +config BT_LEDS
>>>>> +	bool "Enable LED triggers"
>>>>> +	depends on BT
>>>>> +	depends on LEDS_CLASS
>>>>> +	select LEDS_TRIGGERS
>>>>> +	help
>>>>> +	  This option selects a few LED triggers for different
>>>>> +	  Bluetooth events.
>>>>> +
>>>>> config BT_SELFTEST
>>>>> 	bool "Bluetooth self testing support"
>>>>> 	depends on BT && DEBUG_KERNEL
>>>>> diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
>>>>> index 2b15ae8..b3ff12e 100644
>>>>> --- a/net/bluetooth/Makefile
>>>>> +++ b/net/bluetooth/Makefile
>>>>> @@ -17,6 +17,7 @@ bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
>>>>> 
>>>>> bluetooth-$(CONFIG_BT_BREDR) += sco.o
>>>>> bluetooth-$(CONFIG_BT_HS) += a2mp.o amp.o
>>>>> +bluetooth-$(CONFIG_BT_LEDS) += leds.o
>>>>> bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
>>>>> bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
>>>>> 
>>>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>>>> index 47bcef7..f472b1d 100644
>>>>> --- a/net/bluetooth/hci_core.c
>>>>> +++ b/net/bluetooth/hci_core.c
>>>>> @@ -40,6 +40,7 @@
>>>>> #include "hci_request.h"
>>>>> #include "hci_debugfs.h"
>>>>> #include "smp.h"
>>>>> +#include "leds.h"
>>>>> 
>>>>> static void hci_rx_work(struct work_struct *work);
>>>>> static void hci_cmd_work(struct work_struct *work);
>>>>> @@ -1395,6 +1396,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
>>>>> 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
>>>>> 		set_bit(HCI_UP, &hdev->flags);
>>>>> 		hci_sock_dev_event(hdev, HCI_DEV_UP);
>>>>> +		hci_led_radio(hdev, true);
>>>> 
>>>> Lets name this hci_leds_* etc.
>>>> 
>>>> And we might want to consider not using the word radio since we never really have used that word anywhere else in the subsystem.
>>>> 
>>> Then let's use the word power here too (e.g. hci_leds_powered).
>> 
>> I am not 100% sure that is the best name either, but it has at least better meaning than radio.
>> 
> Hmm, maybe hci_leds_ispowered ?

That is more like a query that should return true/false. Maybe hci_leds_update_powered.

>>> 
>>>>> 		if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
>>>>> 		    !hci_dev_test_flag(hdev, HCI_CONFIG) &&
>>>>> 		    !hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
>>>>> @@ -1532,6 +1534,8 @@ int hci_dev_do_close(struct hci_dev *hdev)
>>>>> 		return 0;
>>>>> 	}
>>>>> 
>>>>> +	hci_led_radio(hdev, false);
>>>>> +
>>>>> 	/* Flush RX and TX works */
>>>>> 	flush_work(&hdev->tx_work);
>>>>> 	flush_work(&hdev->rx_work);
>>>>> @@ -3067,6 +3071,8 @@ int hci_register_dev(struct hci_dev *hdev)
>>>>> 	if (error < 0)
>>>>> 		goto err_wqueue;
>>>>> 
>>>>> +	hci_led_init(hdev);
>>>>> +
>>>>> 	hdev->rfkill = rfkill_alloc(hdev->name, &hdev->dev,
>>>>> 				    RFKILL_TYPE_BLUETOOTH, &hci_rfkill_ops,
>>>>> 				    hdev);
>>>>> @@ -3128,6 +3134,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
>>>>> 
>>>>> 	id = hdev->id;
>>>>> 
>>>>> +	hci_led_exit(hdev);
>>>>> +
>>>>> 	write_lock(&hci_dev_list_lock);
>>>>> 	list_del(&hdev->list);
>>>>> 	write_unlock(&hci_dev_list_lock);
>>>>> diff --git a/net/bluetooth/leds.c b/net/bluetooth/leds.c
>>>>> new file mode 100644
>>>>> index 0000000..377f643
>>>>> --- /dev/null
>>>>> +++ b/net/bluetooth/leds.c
>>>>> @@ -0,0 +1,99 @@
>>>>> +/*
>>>>> + * Copyright 2015, Heiner Kallweit <hkallweit1@gmail.com>
>>>>> + *
>>>>> + * This program is free software; you can redistribute it and/or modify
>>>>> + * it under the terms of the GNU General Public License version 2 as
>>>>> + * published by the Free Software Foundation.
>>>>> + */
>>>>> +
>>>>> +#include <net/bluetooth/bluetooth.h>
>>>>> +#include <net/bluetooth/hci_core.h>
>>>>> +
>>>>> +#include "leds.h"
>>>>> +
>>>>> +struct hci_basic_led_trigger {
>>>>> +	struct led_trigger	led_trigger;
>>>>> +	atomic_t		cnt;
>>>>> +};
>>>>> +
>>>>> +#define to_hci_basic_led_trigger(arg) container_of(arg, \
>>>>> +					struct hci_basic_led_trigger, \
>>>>> +					led_trigger)
>>>>> +
>>>>> +static void hci_basic_led(struct led_trigger *trig, bool inc)
>>>>> +{
>>>>> +	struct hci_basic_led_trigger *htrig;
>>>>> +	int cnt;
>>>>> +
>>>>> +	if (!trig)
>>>>> +		return;
>>>>> +
>>>>> +	htrig = to_hci_basic_led_trigger(trig);
>>>>> +
>>>>> +	if (inc)
>>>>> +		cnt = atomic_inc_return(&htrig->cnt);
>>>>> +	else
>>>>> +		cnt = atomic_dec_return(&htrig->cnt);
>>>>> +
>>>>> +	WARN_ON(cnt < 0);
>>>>> +
>>>>> +	led_trigger_event(trig, cnt ? LED_FULL : LED_OFF);
>>>>> +}
>>>> 
>>>> Explain to me the reason for the counter? The Bluetooth subsystem is already guaranteeing the state of HCI_UP to be 100% synchronized. If have one case where it gets set and another where it gets unset. Meaning your counter will do 0 -> 1 and then 1 -> 0.
>>>> 
>>> Indeed the counter is not needed in this particular case.
>>> My intention was to make this basic led class more generic so that it can be re-used for triggers
>>> (to be added later) based on use cases like "at least one connection" where counting may be needed.
>> 
>> Actually it isn't needed there either. We have a hci_conn_hash that does the counting for you already. You pretty much just have to sum it up correctly and you know the correct state of your led.
>> 
> OK. We just might have one remaining issue: When the trigger gets activated, how to find out whether hci currently is powered or not?
> We can use the counter (as is) or we could store hdev in our trigger class and use hdev_is_powered(hdev) from within the activate callback.
> Would you prefer the latter approach?

Do not intermix some functions that are designed for the mgmt with low-level transport related handling. If you are adding the LED trigger where you currently do, then this is test_bit(HCI_UP, &hdev->flags).

Using hdev_is_powered would interact with the HCI_AUTO_OFF capability. And that is really not what you want. You better map it simple to the low-level transport that is HCI_UP flag. If you want to map it to the mgmt view of powered controllers, then that is a lot of more work. Especially since you then have to also deal with configured vs unconfigured controllers. And we also have raw mode and HCI User Channel which do not show in mgmt API.

Regards

Marcel

