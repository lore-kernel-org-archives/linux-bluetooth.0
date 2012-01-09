Return-Path: <cyrus@holtmann.org>
Message-ID: <1326138085.6454.154.camel@aeonflux>
Subject: Re: [PATCH 2/4] Bluetooth: Move mgmt related flags from hdev->flags
 to hdev->dev_flags
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 09 Jan 2012 11:41:25 -0800
In-Reply-To: <1326109565-32631-2-git-send-email-johan.hedberg@gmail.com>
References: <1326109565-32631-1-git-send-email-johan.hedberg@gmail.com>
	 <1326109565-32631-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There's no point in exposing these to user-space (which is what happens
> to everything in hdev->flags) so move them to dev_flags instead.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci.h |   16 +++++++-------
>  net/bluetooth/hci_core.c    |   30 ++++++++++++++--------------
>  net/bluetooth/hci_event.c   |   44 +++++++++++++++++++++---------------------
>  net/bluetooth/mgmt.c        |   30 ++++++++++++++--------------
>  net/bluetooth/smp.c         |    2 +-
>  5 files changed, 61 insertions(+), 61 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


