Return-Path: <cyrus@holtmann.org>
Message-ID: <1329909365.2049.31.camel@aeonflux>
Subject: Re: [PATCH 1/3] Bluetooth: mgmt: Make Set Link Security callable
 while powered off
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 22 Feb 2012 12:16:05 +0100
In-Reply-To: <1329909172-19958-1-git-send-email-johan.hedberg@gmail.com>
References: <1329909172-19958-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch makes it possible to change the Link Security setting while
> powered off and have it automatically enabled when powering on a device.
> To track the desired state once powered on a new HCI_LINK_SECURITY flag
> is added.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci.h |    1 +
>  net/bluetooth/hci_event.c   |    6 ++++++
>  net/bluetooth/mgmt.c        |   33 ++++++++++++++++++++++++++++-----
>  3 files changed, 35 insertions(+), 5 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


