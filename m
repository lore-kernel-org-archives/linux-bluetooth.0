Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH] Bluetooth: Fix RFCOMM bind fail for L2CAP sock
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383634944-4141-1-git-send-email-sw0312.kim@samsung.com>
Date: Tue, 5 Nov 2013 08:26:02 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Syam Sidhardhan <s.syam@samsung.com>
Message-Id: <CE0DCFC3-31E3-4693-9C7C-703CA43A0883@holtmann.org>
References: <1383634944-4141-1-git-send-email-sw0312.kim@samsung.com>
To: Seung-Woo Kim <sw0312.kim@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Seung-Woo,

> L2CAP socket bind checks its bdaddr type but RFCOMM kernel thread
> does not assign proper bdaddr type for L2CAP sock. This can cause
> that RFCOMM failure.
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> ---
> The issue is came from following commit, but it is only in bluetooth-next tree,
> so this patch is not needed for stable tree.
> 
> commit 80c1a2e76dbb36588facb265ab364b1302f7ef8c
> Author: Johan Hedberg <johan.hedberg@intel.com>
> Date:   Mon Oct 14 21:17:52 2013 +0300
> 
>    Bluetooth: Reject invalid bdaddr types for sockets
> 
> This patch is based on commit cca34b785a21d220176038c45071ffe842e99fd3 of
> bluetooth-next tree.
> ---
> net/bluetooth/rfcomm/core.c |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)

good catch. Patch has been applied to bluetooth-next tree.

You might also want to send a patch that adds the l2_bdaddr_type setting before the connect() call.

Regards

Marcel

