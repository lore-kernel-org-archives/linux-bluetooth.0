Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Oct 2012 11:26:01 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/5 v2] Bluetooth: Read adversiting channel TX power
 during init sequence
Message-ID: <20121024132601.GH13884@joana>
References: <1350669469-7719-1-git-send-email-johan.hedberg@gmail.com>
 <1350669469-7719-6-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350669469-7719-6-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2012-10-19 20:57:49 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> This patch adds the reading of the LE advertising channel TX power to
> the HCI init sequence of LE-capable controllers. This data will be used
> e.g. for inclusion in the advertising data packets when advertising is
> enabled.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h      |    6 ++++++
>  include/net/bluetooth/hci_core.h |    2 ++
>  net/bluetooth/hci_event.c        |   20 ++++++++++++++++++++
>  3 files changed, 28 insertions(+)

All patches but patch 4 were applied to bluetooth-next. Patch 4 doesn't apply
on current bluetooth-next. I also change functions on patch 1 to use _setup().
Thanks.

	Gustavo
