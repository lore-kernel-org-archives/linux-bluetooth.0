Return-Path: <hdegoede@redhat.com>
Subject: Re: [RFC 0/1] Bluetooth: hci_bcm: Do not tie GPIO pin order to a
 specific ACPI HID
To: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20180314135454.8387-1-hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <b277d1cd-26a9-89b7-59f3-a6665b35f02b@redhat.com>
Date: Wed, 14 Mar 2018 15:12:25 +0100
MIME-Version: 1.0
In-Reply-To: <20180314135454.8387-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 14-03-18 14:54, Hans de Goede wrote:
> Hi All,
> 
> While working on a patch to add the BCM2E84 ACPI HID to the hci_bcm code,
> to fix BT the Lenovo Yoga2: https://bugzilla.redhat.com/show_bug.cgi?id=1554835
> 
> I realized that I was basing wether to use the acpi_bcm_int_first_gpios or
> the acpi_bcm_int_last_gpios mapping on the order of resources in the ACPI
> device's resource table, which is something which we might as well do in
> the code directly.
> 
> I've not done much testing with this change yet, because I hit a snag.
> While working on this the reporter of the Yoga2 problem got back to me that
> things work, but that his bluetooth keyboard cannot wakeup the HCI from
> runtime-suspend. I've yet to debug this but I think this might be caused
> by the device-wakeup and shutdown GPIOs being swapped. Which would mean
> we have a 3th possible order...
> 
> Assuming we have the 3th possible order, it might be best to forget about
> this patch and just keep defining hardcoded orders for each ACPI HID
> until we hit a case where we actually need 2 different orders for a single
> HID and then maybe dust of this patch.

Thinking more about this, I believe it is more likely that the problem is
the IRQ polarity being wrong...

> But I wrote this patch now so I wanted to share it and see what others
> think because I personally still like the idea of figuring things out
> automatically.

Which means (once confirmed) that we could move forward with this patch,
so some initial review / remarks would be appreciated.

Regards,

Hans
