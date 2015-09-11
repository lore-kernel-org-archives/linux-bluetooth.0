Return-Path: <cyrus@holtmann.org>
From: "Ge, Ethan" <ethan.ge@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "jeremy@goop.org" <jeremy@goop.org>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: BLE(ATT) mouse doesn't register wakeup source in Linux kernel
 during BLE mouse connecting
Date: Fri, 11 Sep 2015 10:12:31 +0000
Message-ID: <86D221DC0B85F94D9B05B97827669A34064CE519@PGSMSX106.gar.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

In file drivers/hid/hid-input.c, function hidinput_setup_battery() will return during connect a BLE mouse because of filed->usage->hid != HID_DC_BATTERYSTRENGTH. And BLE(ATT) HID doesn't register wakeup source in Linux kernel. 

It will cause BLE HID mouse can't wake DUT from S3. Issue can be reproduced by IBUFFALO BSMBB09DS / Dell WM615 mouse / Microsoft arc touch, these all are BLE mouse. 

static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type, struct hid_field *field)
{
    struct power_supply_desc *psy_desc = NULL;
    struct power_supply_config psy_cfg = { .drv_data = dev, };
    unsigned quirks;
    s32 min, max;

    if (field->usage->hid != HID_DC_BATTERYSTRENGTH)
        return false;    /* no match */
