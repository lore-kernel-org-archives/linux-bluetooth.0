Return-Path: <cyrus@holtmann.org>
Message-ID: <55C8BBD0.6010706@linux.intel.com>
Date: Mon, 10 Aug 2015 16:57:20 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Luka Karinja <lk@bazdara.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Bluetooth: hci_bcm: Add PM for BCM devices
References: <1438959640-15476-1-git-send-email-frederic.danis@linux.intel.com> <1438959640-15476-2-git-send-email-frederic.danis@linux.intel.com> <55C85A37.2030103@bazdara.com>
In-Reply-To: <55C85A37.2030103@bazdara.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luka,

On 10/08/2015 10:00, Luka Karinja wrote:
> Hey Frederic
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id bcm_acpi_match[] = {
>> +    { "BCM2E39", 0 },
>> +    { "BCM2E67", 0 },
>> +    { },
>> +};
> could you also add:
>
> +     { "BCM2E65", 0 },
>
> This is the ACPI name the Asus T100TAF uses

In addition to this, bcm_uart_subver_table, btbcm_initialize() and 
btbcm_check_bdaddr() may need to be patched to support new device.
All is located in btbcm.c file.

Regards

Fred
