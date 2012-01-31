Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jan 2012 22:19:46 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <aguedespe@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, andre.guedes@openbossa.org
Subject: Re: [PATCH] Bluetooth: Use GFP_KERNEL in hci_add_adv_entry()
Message-ID: <20120131061946.GA7843@x220.globalsuite.net>
References: <1327977088-32223-1-git-send-email-aguedespe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327977088-32223-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Mon, Jan 30, 2012, Andre Guedes wrote:
> This function is not called in interrupt context anymore, so it
> should use GFP_KERNEL to allocate memory.
> 
> Signed-off-by: Andre Guedes <aguedespe@gmail.com>
> ---
>  net/bluetooth/hci_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

The patch has been applied to my bluetooth-next tree. Thanks.

Johan
