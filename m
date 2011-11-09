Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] Bluetooth: Pass full hci_dev struct to mgmt
 callbacks
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 09 Nov 2011 16:34:22 +0900
In-Reply-To: <1320777616-15794-1-git-send-email-johan.hedberg@gmail.com>
References: <1320777616-15794-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320824067.15441.315.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The current global pending command list in mgmt.c is racy. Possibly the
> simplest way to fix it is to have per-hci dev lists instead of a global
> one (all commands that need a pending struct are hci_dev specific).
> This way the list can be protected using the already existing per-hci
> dev lock. To enable this refactoring the first thing that needs to be
> done is to ensure that the mgmt functions have access to the hci_dev
> struct (instead of just the dev id).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   61 ++++++-----
>  net/bluetooth/hci_core.c         |   16 ++--
>  net/bluetooth/hci_event.c        |   63 ++++++------
>  net/bluetooth/mgmt.c             |  206 +++++++++++++++++++------------------
>  4 files changed, 178 insertions(+), 168 deletions(-)

makes sense to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


