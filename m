Return-Path: <cyrus@holtmann.org>
Message-ID: <1329923728.2049.38.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: mgmt: Implement Set LE command
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 22 Feb 2012 16:15:28 +0100
In-Reply-To: <1329922392-25089-2-git-send-email-johan.hedberg@gmail.com>
References: <1329922392-25089-1-git-send-email-johan.hedberg@gmail.com>
	 <1329922392-25089-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch implements support for the Set LE mgmt command. Now, in
> addition to the enable_le module parameter user space needs to send an
> explicit Enable LE command to enable LE support.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci.h      |    1 +
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_event.c        |    7 ++-
>  net/bluetooth/mgmt.c             |  119 +++++++++++++++++++++++++++++++++++++-
>  4 files changed, 126 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


