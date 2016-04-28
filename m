Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: hci_intel problem
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20160428135028.GB13659@kuha.fi.intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
From: lpoulain <loic.poulain@intel.com>
Message-ID: <572234A8.4090308@intel.com>
Date: Thu, 28 Apr 2016 18:04:56 +0200
MIME-Version: 1.0
In-Reply-To: <20160428135028.GB13659@kuha.fi.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Heikki,

> Hi Loic,
>
> Commit 765ea3abd116 ("Bluetooth: hci_intel: Retrieve host-wake IRQ")
> seems to create a little regression:
>
> [    2.734749] hci_intel INT33E1:00: No corresponding irq for gpio
> [    2.736426] BUG: unable to handle kernel NULL pointer dereference at           (null)
> [    2.738631] IP: [<ffffffff8132bee1>] desc_to_gpio+0x1/0x20
>
> I think it's usually ill-advised to convert the gpio descriptors to
> numbers unless there is a real need for it. Maybe you can just fix the
> dev_info() back to way it was.
>

Thanks for the catch, I'm going to fix this and only display the desc 
address per your advice.

Root cause is the null pointer deref of the reset desc in:
desc_to_gpio(idev->reset)

However I already test this value earlier in the function with:

idev->reset = devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
if (IS_ERR(idev->reset)) {
         dev_err(&pdev->dev, "Unable to retrieve gpio\n");
         return PTR_ERR(idev->reset);
}

Problem is that devm_gpiod_get_optional can return either a ERR_PTR or 
NULL pointer.
I don't manage the NULL case, need to fix it as well.

Regards,
Loic
