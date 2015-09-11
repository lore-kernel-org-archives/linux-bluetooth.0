Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <86D221DC0B85F94D9B05B97827669A34064CE519@PGSMSX106.gar.corp.intel.com>
References: <86D221DC0B85F94D9B05B97827669A34064CE519@PGSMSX106.gar.corp.intel.com>
Date: Fri, 11 Sep 2015 16:35:50 +0300
Message-ID: <CABBYNZJBEA2Pt71+yPHbx7N5hjidfeEyML=2b=Ca931oWrzvtg@mail.gmail.com>
Subject: Re: BLE(ATT) mouse doesn't register wakeup source in Linux kernel
 during BLE mouse connecting
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Ge, Ethan" <ethan.ge@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "jeremy@goop.org" <jeremy@goop.org>,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ethan,

On Fri, Sep 11, 2015 at 1:12 PM, Ge, Ethan <ethan.ge@intel.com> wrote:
> Hi,
>
> In file drivers/hid/hid-input.c, function hidinput_setup_battery() will return during connect a BLE mouse because of filed->usage->hid != HID_DC_BATTERYSTRENGTH. And BLE(ATT) HID doesn't register wakeup source in Linux kernel.
>
> It will cause BLE HID mouse can't wake DUT from S3. Issue can be reproduced by IBUFFALO BSMBB09DS / Dell WM615 mouse / Microsoft arc touch, these all are BLE mouse.
>
> static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type, struct hid_field *field)
> {
>     struct power_supply_desc *psy_desc = NULL;
>     struct power_supply_config psy_cfg = { .drv_data = dev, };
>     unsigned quirks;
>     s32 min, max;
>
>     if (field->usage->hid != HID_DC_BATTERYSTRENGTH)
>         return false;    /* no match */

But this is checked in case the device does not support battery
strength support, I thought any input device would register a wakeup
source regardless.


-- 
Luiz Augusto von Dentz
