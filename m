Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <86D221DC0B85F94D9B05B97827669A34064CEC19@PGSMSX106.gar.corp.intel.com>
References: <86D221DC0B85F94D9B05B97827669A34064CE519@PGSMSX106.gar.corp.intel.com>
	<CABBYNZJBEA2Pt71+yPHbx7N5hjidfeEyML=2b=Ca931oWrzvtg@mail.gmail.com>
	<86D221DC0B85F94D9B05B97827669A34064CEC19@PGSMSX106.gar.corp.intel.com>
Date: Tue, 15 Sep 2015 19:15:05 +0800
Message-ID: <CAAAJ3C++3S1mxwGPsQ7U+np0U02F7Rn8nhnr2rYcZEzPqRfXew@mail.gmail.com>
Subject: Re: BLE(ATT) mouse doesn't register wakeup source in Linux kernel
 during BLE mouse connecting
From: Ethan <ethancsge@gmail.com>
To: "Ge, Ethan" <ethan.ge@intel.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "jeremy@goop.org" <jeremy@goop.org>,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

2015-09-13 20:26 GMT-07:00 Ge, Ethan <ethan.ge@intel.com>:
> Hi Luiz
>
> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Friday, September 11, 2015 9:36 PM
> To: Ge, Ethan
> Cc: linux-bluetooth@vger.kernel.org; jeremy@goop.org; Marcel Holtmann
> Subject: Re: BLE(ATT) mouse doesn't register wakeup source in Linux kernel during BLE mouse connecting
>
> Hi Ethan,
>
> On Fri, Sep 11, 2015 at 1:12 PM, Ge, Ethan <ethan.ge@intel.com> wrote:
>> Hi,
>>
>> In file drivers/hid/hid-input.c, function hidinput_setup_battery() will return during connect a BLE mouse because of filed->usage->hid != HID_DC_BATTERYSTRENGTH. And BLE(ATT) HID doesn't register wakeup source in Linux kernel.
>>
>> It will cause BLE HID mouse can't wake DUT from S3. Issue can be reproduced by IBUFFALO BSMBB09DS / Dell WM615 mouse / Microsoft arc touch, these all are BLE mouse.
>>
>> static bool hidinput_setup_battery(struct hid_device *dev, unsigned
>> report_type, struct hid_field *field) {
>>     struct power_supply_desc *psy_desc = NULL;
>>     struct power_supply_config psy_cfg = { .drv_data = dev, };
>>     unsigned quirks;
>>     s32 min, max;
>>
>>     if (field->usage->hid != HID_DC_BATTERYSTRENGTH)
>>         return false;    /* no match */
>
>> But this is checked in case the device does not support battery strength support, I thought any input device would register a wakeup source regardless.
>> Luiz Augusto von Dentz
>
> I said that because I verified it by ftrace. I found if it return hidinput_setup_battery(), and input device can't register a wakeup source. Below are the code flow. hidinput_setup_battery->__power_supply_register-> device_init_wakeup.
> In other hand, the BR/EDR mouse can register a wakeup source because it won't return hidinput_setup_battery() and can go through next function. I am trying to check why BLE mouse usage->hid != HID_DC_BATTERYSTRENGTH and can not wakeup system in S3.
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
> ...
>     dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
> ..
> }
>
> static struct power_supply *__must_check
> __power_supply_register(struct device *parent,
>                    const struct power_supply_desc *desc,
>                    const struct power_supply_config *cfg,
>                    bool ws)
> {
>  ....
>
>     spin_lock_init(&psy->changed_lock);
>     rc = device_init_wakeup(dev, ws);
>     if (rc)
>         goto wakeup_init_failed;
> ....
> }
>
> int device_init_wakeup(struct device *dev, bool enable)
> {
>     int ret = 0;
>
>     if (!dev)
>         return -EINVAL;
>
>     if (enable) {
>         device_set_wakeup_capable(dev, true);
>         ret = device_wakeup_enable(dev);
> ...
> }
> Ethan
> --

I want to correct my description in previous mail, this issue doesn't
cause from hidinput_setup_battery.  And I found
/sys/bus/usb/devices/1-5/power/wakeup is enabled after BR/EDR HID
connected, but it's disabled after BLE HID connected. If I echo
enabled > /sys/bus/usb/devices/1-5/power/wakeup, and issue will
disappear. The wakeup value is configured from
wake_store->device_set_wakeup_enable(dev, 1) for BR/EDR HID case. I am
trying to figure out why BLE HID won't process it.

Ethan
