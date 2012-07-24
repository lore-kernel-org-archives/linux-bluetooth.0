Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 11:53:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ 0/7] Generic GATT API changes
Message-ID: <20120724095310.GC9576@x220.ice.intel.com>
References: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jul 23, 2012, Anderson Lizardo wrote:
> This series contains the latest updates to the Generic GATT API planned for
> the next major BlueZ release. It was based on the discussions on the last BlueZ
> meeting, plus a few tweaks to the signature of some methods. For instance, the
> Register() method of the Service interface contains an optional "id" setting,
> which could allow to load the correct storage for registered GATT services when
> BlueZ daemon is restarted.
> 
> While reviewing these patches, please keep in mind that the plan is to allow to
> use the same API (or, more likely, a subset) when implementing external GATT
> services. This avoids creating another "asymmetric" API just for service
> registration. This approach has been already successfully adopted by other
> (audio related?) profiles in BlueZ.
> 
> Comments and suggestions are welcome.
> 
> Anderson Lizardo (6):
>   attrib-api: Remove local service hierarchy
>   attrib-api: Update introduction text
>   attrib-api: Remove GATT service hierarchy
>   attrib-api: Update Characteristic interface
>   attrib-api: Update Watcher interface methods
>   attrib-api: Add RegisterWatcher/UnregisterWatcher methods
> 
> Claudio Takahasi (1):
>   doc: Add Register/Unregister GATT based services

Patches 1-6 have been applied. The last two may need some more thinking
though.

Johan
