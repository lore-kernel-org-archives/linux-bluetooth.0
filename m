Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Aug 2011 14:59:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v3] Fix remove temporary link key for No Bonding
Message-ID: <20110823115950.GA18032@dell>
References: <1314020739-15376-1-git-send-email-dmitriy.paliy@nokia.com>
 <1314020739-15376-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314020739-15376-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Mon, Aug 22, 2011, Dmitriy Paliy wrote:
> This fixes regression caused by 33cdfcb0fabcfb5260953a13ae277b5abe9a322d.
> Temporary link key should be removed after device is disconnected if
> bonding information is not stored in file system.
> 
> Currently, the key is deleted only when paired device is removed, or
> adapter is powered off. In case of No Bonding authentication, device is
> not paired after disconnection, which results in link key left in memory.
> 
> On the other hand, device is not necessarily removed after disconnection
> that also leaves unneeded temporary link key in memory. Therefore,
> btd_adapter_remove_bonding is moved to device_set_paired(device, FALSE)
> covering both cases.
> ---
>  src/device.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
