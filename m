Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 13:02:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jefferson Delfes <jefferson.delfes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/3] shared: Different address for hciemu devices
Message-ID: <20130430100213.GA5745@x220.ger.corp.intel.com>
References: <1365693884-15423-1-git-send-email-jefferson.delfes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365693884-15423-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI Jefferson,

On Thu, Apr 11, 2013, Jefferson Delfes wrote:
> For testing multiple devices, it's nice to use a hciemu for each virtual
> device. The problem is that their addresses are always the same.
> 
> This patch series removes the static address assignment made in
> hciemu_new/create_vhci.
> Inside btdev_create, it already generated a specific address, so we can
> just reuse it.
> 
> Jefferson Delfes (3):
>   emulator: Add getter function for device address in btdev
>   shared: Remove static address assignment in hciemu
>   shared: Return real address of master dev in hciemu
> 
>  emulator/btdev.c    |  5 +++++
>  emulator/btdev.h    |  1 +
>  src/shared/hciemu.c | 21 ++++++++++-----------
>  3 files changed, 16 insertions(+), 11 deletions(-)

All three patches have been applied. Thanks.

Johan
