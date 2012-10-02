Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Oct 2012 15:41:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC v2] Convert storage to use per-remote device directories
Message-ID: <20121002124129.GA19094@x220>
References: <506AD942.5020902@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <506AD942.5020902@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Tue, Oct 02, 2012, Frederic Danis wrote:
> The adapter config file just need to be converted to ini-file format
> with only 1 group called [adapter], for example:
>   [Adapter]
>   Name=desktop-0
>   Class=0x780011
>   Pairable=true
>   OnMode=discoverable
>   Mode=discoverable

Looks ok, except I'd call the main section [General] to make it more
natural to extend the file with new sections in the future. This is also
consistent with what we have under /etc/bluetooth.

> Remote device config file will include a [device] group with general
> device infos (name, alias, profiles or primary services list, ...),
> for example:
>   [Device]

Same thing as with adapter.conf, i.e. I'd call this simply [General]

>   DeviceId=FFFF 0000 0000 0000

I'd move this into its own [DeviceID] section with separate Assigner,
Vendor, Product and Version fields.

> Keys file will include informations related to link key or long term
> link key, for example:
>   [LinkKey]
>   Key=9EF4BDFA68C5438A176DF42ACD59816C
>   Type=0
>   Length=4

I suppose s/Length/PINLength/ would be in order here.

Johan
