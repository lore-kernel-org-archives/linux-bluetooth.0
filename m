Return-Path: <ianwmorrison@gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_bcm: Add support for MINIX Z83-4
 based devices
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 hdegoede@redhat.com, frederic.danis.oss@gmail.com
References: <252d14ef-693e-fd5d-d720-0eae53e2cbf2@gmail.com>
 <1D920EEC-CDED-487A-94E4-F31EA5C6C551@holtmann.org>
From: Ian W MORRISON <ianwmorrison@gmail.com>
Message-ID: <e722d5ad-6ede-c454-b1d9-1a8aa82d4417@gmail.com>
Date: Sat, 7 Oct 2017 17:15:50 +1100
MIME-Version: 1.0
In-Reply-To: <1D920EEC-CDED-487A-94E4-F31EA5C6C551@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 10/7/17 5:30 AM, Marcel Holtmann wrote:
> Hi Ian,
> 
<snip>
> 
> can you actually add an extract of the ACPI table where the IRQ polarity is described wrongly. I like to have that in the commit message so that this becomes some sort of record.
> 
> Regards
> 
> Marcel
> 

Hi Marcel,

I've added an extract from the ACPI DSDT which shows 'GpioInt' requiring the trigger type IRQF_TRIGGER_FALLING and sent as v3 patch set.

Regards,
Ian
