Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 1/4] Bluetooth: hci_bcm: Add PM for BCM devices
To: Frederic Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
References: <1438959640-15476-1-git-send-email-frederic.danis@linux.intel.com>
 <1438959640-15476-2-git-send-email-frederic.danis@linux.intel.com>
From: Luka Karinja <lk@bazdara.com>
Message-ID: <55C85A37.2030103@bazdara.com>
Date: Mon, 10 Aug 2015 10:00:55 +0200
MIME-Version: 1.0
In-Reply-To: <1438959640-15476-2-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Frederic
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id bcm_acpi_match[] = {
> +    { "BCM2E39", 0 },
> +    { "BCM2E67", 0 },
> +    { },
> +};
could you also add:

+     { "BCM2E65", 0 },

This is the ACPI name the Asus T100TAF uses
Thanks
